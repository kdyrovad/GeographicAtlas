//
//  DetailViewController.swift
//  GeographicAtlas
//
//  Created by Дильяра Кдырова on 15.05.2023.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    private let presenter: DetailPresenterProtocol
    
    //MARK: - Init
    
    init(presenter: DetailPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.loadView()
        
        setUpView()
    }
    
    //MARK: - Views
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.delegate = self
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "My Title"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        return titleLabel
    }()
    
    private lazy var flagImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "kz.png")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        return image
    }()
    
    private lazy var dotLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 35)
        label.font = UIFont.boldSystemFont(ofSize: 35.0)
        label.text = " • "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dotLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 35)
        label.font = UIFont.boldSystemFont(ofSize: 35.0)
        label.text = " • "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dotLabel3: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 35)
        label.font = UIFont.boldSystemFont(ofSize: 35.0)
        label.text = " • "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dotLabel4: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 35)
        label.font = UIFont.boldSystemFont(ofSize: 35.0)
        label.text = " • "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dotLabel5: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 35)
        label.font = UIFont.boldSystemFont(ofSize: 35.0)
        label.text = " • "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dotLabel6: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 35)
        label.font = UIFont.boldSystemFont(ofSize: 35.0)
        label.text = " • "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dotLabel7: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 35)
        label.font = UIFont.boldSystemFont(ofSize: 35.0)
        label.text = " • "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var regionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 15)
        label.textColor = UIColor(hexString: "#888888")
        label.text = "Region:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var regionNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 20)
        label.textColor = UIColor(hexString: "#000000")
        label.text = "Asia"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var capitalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 15)
        label.textColor = UIColor(hexString: "#888888")
        label.text = "Capital:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var capitalNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 20)
        label.textColor = UIColor(hexString: "#000000")
        label.text = "Astana"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var coordinatesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 15)
        label.textColor = UIColor(hexString: "#888888")
        label.text = "Capital coordinates:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var coordinatesNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 20)
        label.textColor = UIColor(hexString: "#000000")
        label.text = "51°08′, 71°26′"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var populationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 15)
        label.textColor = UIColor(hexString: "#888888")
        label.text = "Population:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var populationNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 20)
        label.textColor = UIColor(hexString: "#000000")
        label.text = "19 mln"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var areaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 15)
        label.textColor = UIColor(hexString: "#888888")
        label.text = "Area:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var areaNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 20)
        label.textColor = UIColor(hexString: "#000000")
        label.text = "2 724 900 km²"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 15)
        label.textColor = UIColor(hexString: "#888888")
        label.text = "Currency:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var currencyNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 20)
        label.textColor = UIColor(hexString: "#000000")
        label.text = "Tenge (₸) (KZT)"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timezoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 15)
        label.textColor = UIColor(hexString: "#888888")
        label.text = "Timezones:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timezoneNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 30)
        label.textColor = UIColor(hexString: "#000000")
        label.text = "GMT+6"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Methods
    
    private func setUpView() {
        view.backgroundColor = .white
        navigationItem.titleView = titleLabel
        
        scrollView.contentSize = view.bounds.size
        
        view.addSubview(scrollView)
        
        flagImage.clipsToBounds = true
        [flagImage, regionLabel, regionNameLabel, dotLabel1, dotLabel2, dotLabel3, dotLabel4, dotLabel5, dotLabel6, dotLabel7, capitalLabel, capitalNameLabel, coordinatesLabel, coordinatesNameLabel, populationLabel, populationNameLabel, areaLabel, areaNameLabel, currencyLabel, currencyNameLabel, timezoneLabel, timezoneNameLabel].forEach { scrollView.addSubview($0) }
        
        setConstraints()
    }
    
    func configure(for model: CountryModelProtocol) {
        titleLabel.text = presenter.countryName
        guard let url = URL(string: model.flagURL) else { return }
        flagImage.downloaded(from: url)
        regionNameLabel.text = model.regionName
        capitalNameLabel.text = model.capitalName
        populationNameLabel.text = model.population
        areaNameLabel.text = model.area
        currencyNameLabel.text = presenter.currencies
        coordinatesNameLabel.text = model.capitalInfo
        timezoneNameLabel.text = model.timezones
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let layout = view.safeAreaLayoutGuide
        scrollView.centerXAnchor.constraint(equalTo: layout.centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: layout.centerYAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: layout.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: layout.heightAnchor).isActive = true
    }
    
    //MARK: - Constraints
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            flagImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            flagImage.widthAnchor.constraint(equalToConstant: 370),
            flagImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            regionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 48),
            regionLabel.topAnchor.constraint(equalTo: flagImage.bottomAnchor, constant: 21),

            regionNameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 48),
            regionNameLabel.topAnchor.constraint(equalTo: regionLabel.bottomAnchor, constant: 4),
            
            dotLabel1.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            dotLabel1.topAnchor.constraint(equalTo: regionLabel.topAnchor),
            dotLabel1.heightAnchor.constraint(equalToConstant: 20),
            
            capitalLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 48),
            capitalLabel.topAnchor.constraint(equalTo: regionNameLabel.bottomAnchor, constant: 24),
            
            capitalNameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 48),
            capitalNameLabel.topAnchor.constraint(equalTo: capitalLabel.bottomAnchor, constant: 4),
            
            dotLabel2.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            dotLabel2.topAnchor.constraint(equalTo: capitalLabel.topAnchor),
            dotLabel2.heightAnchor.constraint(equalToConstant: 20),
            
            coordinatesLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 48),
            coordinatesLabel.topAnchor.constraint(equalTo: capitalNameLabel.bottomAnchor, constant: 24),
            
            coordinatesNameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 48),
            coordinatesNameLabel.topAnchor.constraint(equalTo: coordinatesLabel.bottomAnchor, constant: 4),
            
            dotLabel3.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            dotLabel3.topAnchor.constraint(equalTo: coordinatesLabel.topAnchor),
            dotLabel3.heightAnchor.constraint(equalToConstant: 20),
            
            populationLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 48),
            populationLabel.topAnchor.constraint(equalTo: coordinatesNameLabel.bottomAnchor, constant: 24),
            
            populationNameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 48),
            populationNameLabel.topAnchor.constraint(equalTo: populationLabel.bottomAnchor, constant: 4),
            
            dotLabel4.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            dotLabel4.topAnchor.constraint(equalTo: populationLabel.topAnchor),
            dotLabel4.heightAnchor.constraint(equalToConstant: 20),
            
            areaLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 48),
            areaLabel.topAnchor.constraint(equalTo: populationNameLabel.bottomAnchor, constant: 24),
            
            areaNameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 48),
            areaNameLabel.topAnchor.constraint(equalTo: areaLabel.bottomAnchor, constant: 4),
            
            dotLabel5.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            dotLabel5.topAnchor.constraint(equalTo: areaLabel.topAnchor),
            dotLabel5.heightAnchor.constraint(equalToConstant: 20),
            
            currencyLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 48),
            currencyLabel.topAnchor.constraint(equalTo: areaNameLabel.bottomAnchor, constant: 24),
            
            currencyNameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 48),
            currencyNameLabel.topAnchor.constraint(equalTo: currencyLabel.bottomAnchor, constant: 4),
            
            dotLabel6.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            dotLabel6.topAnchor.constraint(equalTo: currencyLabel.topAnchor),
            dotLabel6.heightAnchor.constraint(equalToConstant: 20),
            
            timezoneLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 48),
            timezoneLabel.topAnchor.constraint(equalTo: currencyNameLabel.bottomAnchor, constant: 24),
            
            timezoneNameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 48),
            timezoneNameLabel.topAnchor.constraint(equalTo: timezoneLabel.bottomAnchor, constant: 4),
            
            dotLabel7.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            dotLabel7.topAnchor.constraint(equalTo: timezoneLabel.topAnchor),
            dotLabel7.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
