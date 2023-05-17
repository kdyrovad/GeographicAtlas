//
//  ViewController.swift
//  GeographicAtlas
//
//  Created by Дильяра Кдырова on 11.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private var presenter: CountryPresenterProtocol
    
    //MARK: - Init
    
    init(presenter: CountryPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .white
        navigationItem.title = "World countries"
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        presenter.loadView()
    }
    
    //MARK: - Views
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private lazy var populationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hexString: "#888888")
        label.text = "Population:"
        return label
    }()
    
    //MARK: - Methods
    
    private func setUpViews() {
        view.addSubview(tableView)
        setContraints()
    }
    
    func toggleCellExpansion(at indexPath: IndexPath) {
        
        presenter.model(for: indexPath).isExpanded.toggle()
        print("ToggleCellExpansion: ", presenter.model(for: indexPath).isExpanded)
        
        if let cell = tableView.cellForRow(at: indexPath) as? CountryTableViewCell {
            cell.buttonArrow.isSelected = presenter.model(for: indexPath).isExpanded
            if cell.buttonArrow.isSelected {
                cell.buttonArrow.setImage(UIImage(named: "clicked.png"), for: .selected)
            } else {
                cell.buttonArrow.setImage(UIImage(named: "down_arrow.png"), for: .normal)
            }
            cell.setNeedsLayout()
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
        print("toggleCellExpansion END")
    }
    
    func learnMoreTapped(at indexPath: IndexPath) {
        let vc = Main.shared.detailsScreen(for: presenter.model(for: indexPath))
        vc.configure(for: presenter.model(for: indexPath))
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Constraints

extension ViewController {
    
    private func setContraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


//MARK: - CountryViewProtocol

extension ViewController: CountryViewProtocol {
    func updateView() {
        tableView.reloadData()
    }
    
    func updateView(withLoader isLoading: Bool) {
        if isLoading {
            let loadingIndicator = UIActivityIndicatorView(style: .large)
            loadingIndicator.startAnimating()
            loadingIndicator.center = view.center
            view.addSubview(loadingIndicator)
        } else {
            view.subviews.filter { $0 is UIActivityIndicatorView }.forEach { $0.removeFromSuperview() }
        }
    }
    
    func updateView(withError message: String) {
    }
}


//MARK: - UITableViewDelegate, UITableViewDataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CountryTableViewCell else {
                return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        cell.configure(with: presenter.model(for: indexPath))
        cell.buttonTapAction = { [weak self] in
            self?.toggleCellExpansion(at: indexPath)
        }
        cell.learnMoreButtonAction = { [weak self] in
            self?.learnMoreTapped(at: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if presenter.model(for: indexPath).isExpanded {
            return 216
        } else {
            return 84
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.groupedElements.keys.sorted().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let continent = presenter.groupedElements.keys.sorted()[section]
        return presenter.groupedElements[continent]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.groupedElements.keys.sorted()[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.toggleCellExpansion(at: indexPath)
    }
}

//MARK: - Extension UIColor

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

