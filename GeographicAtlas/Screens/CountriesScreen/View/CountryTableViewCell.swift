//
//  CountryTableViewCell.swift
//  GeographicAtlas
//
//  Created by Дильяра Кдырова on 11.05.2023.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    var buttonTapAction: (() -> Void)?
    var learnMoreButtonAction: (() -> Void)?
    
    var isExp: Bool = false
    
    var indexPath: IndexPath!
    
    //MARK: - NotExpanded views
    
    private lazy var totalView: UIView = {
        let total = UIView()
        total.layer.cornerRadius = 12
        total.backgroundColor = UIColor(hexString: "#F7F8F9")
        total.isUserInteractionEnabled = true
        total.translatesAutoresizingMaskIntoConstraints = false
        return total
    }()
    
    private lazy var iconView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.image = UIImage(named: "kz.png")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()
    
    
    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    private lazy var capitalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hexString: "#888888")
        label.text = "Astana"
        return label
    }()
    
    var buttonArrow: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "down_arrow.png"), for: .normal)
        button.setImage(UIImage(named: "clicked.png"), for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonArrowTapped), for: .touchUpInside)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    //MARK: - Expanded views
    
    private lazy var populationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hexString: "#888888")
        label.text = "Population:"
        return label
    }()
    
    private lazy var populationValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hexString: "#000000")
        label.text = "19 mln"
        return label
    }()
    
    private lazy var areaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hexString: "#888888")
        label.text = "Area:"
        return label
    }()
    
    private lazy var areaValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hexString: "#000000")
        label.text = "2.725 mln km2"
        return label
    }()
    
    private lazy var currenciesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hexString: "#888888")
        label.text = "Currencies:"
        return label
    }() 
    
    private lazy var currenciesValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Text", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hexString: "#000000")
        label.text = "Tenge"
        return label
    }()
    
    var learnMoreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Learn More", for: .normal)
        button.setTitleColor(UIColor(hexString: "#007AFF"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SF Pro Text", size: 17)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        button.addTarget(self, action: #selector(learnMoreButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        
        setContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Methods
    
    @objc func buttonArrowTapped() {
        
        isSelected = !isSelected
        buttonArrow.isSelected = isSelected
        
        buttonTapAction?()
    }
    
    @objc func learnMoreButtonTapped() {
        learnMoreButtonAction?()
    }
    
    private func setViews() {
        contentView.addSubview(totalView)
        
        [iconView, countryLabel, capitalLabel, buttonArrow, populationLabel, populationValueLabel, areaLabel, areaValueLabel, currenciesLabel, currenciesValueLabel, learnMoreButton].forEach { totalView.addSubview($0) }
    }
    
    func configure(with model: CountryModelProtocol) {
        countryLabel.text = model.countryName
        capitalLabel.text = model.capitalName
        guard let url = URL(string: model.flagURL) else {
            return
        }
        
        iconView.downloaded(from: url)
        populationValueLabel.text = model.population
        areaValueLabel.text = model.area
        currenciesValueLabel.text = model.currencies
        isExp = model.isExpanded
        buttonArrow.isSelected = model.isExpanded
        
        if model.isExpanded {
            addNewElement()
        } else {
            removeElements()
        }
    }
    
    func addNewElement() {
        [populationLabel, populationValueLabel, areaLabel, areaValueLabel, currenciesLabel, currenciesValueLabel, learnMoreButton].forEach{ totalView.addSubview($0) }
        setExpandedConstraints()
    }
    
    func removeElements() {
        [populationLabel, populationValueLabel, areaLabel, areaValueLabel, currenciesLabel, currenciesValueLabel, learnMoreButton].forEach{ $0.removeFromSuperview() }
    }
    
    //MARK: - Constraints
    
    private func setContraints() {
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: totalView.topAnchor, constant: 12),
            iconView.leadingAnchor.constraint(equalTo: totalView.leadingAnchor, constant: 12),
            iconView.widthAnchor.constraint(equalToConstant: 82),
            iconView.heightAnchor.constraint(equalToConstant: 48),
            
            countryLabel.topAnchor.constraint(equalTo: totalView.topAnchor, constant: 16),
            countryLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            
            capitalLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 4),
            capitalLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            
            buttonArrow.topAnchor.constraint(equalTo: totalView.topAnchor, constant: 32),
            buttonArrow.trailingAnchor.constraint(equalTo: totalView.trailingAnchor, constant: -18),
            buttonArrow.leadingAnchor.constraint(equalTo: countryLabel.trailingAnchor, constant: 17),
            buttonArrow.widthAnchor.constraint(equalToConstant: 14),
            
            totalView.topAnchor.constraint(equalTo: contentView.topAnchor),
            totalView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            totalView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            totalView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    private func setExpandedConstraints() {
        NSLayoutConstraint.activate([
            populationLabel.leadingAnchor.constraint(equalTo: totalView.leadingAnchor, constant: 12),
            populationLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 12),
            
            populationValueLabel.leadingAnchor.constraint(equalTo: populationLabel.trailingAnchor, constant: 4),
            populationValueLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 12),

            areaLabel.leadingAnchor.constraint(equalTo: totalView.leadingAnchor, constant: 12),
            areaLabel.topAnchor.constraint(equalTo: populationLabel.bottomAnchor, constant: 8),
            
            areaValueLabel.leadingAnchor.constraint(equalTo: areaLabel.trailingAnchor, constant: 4),
            areaValueLabel.topAnchor.constraint(equalTo: populationValueLabel.bottomAnchor, constant: 8),

            currenciesLabel.leadingAnchor.constraint(equalTo: totalView.leadingAnchor, constant: 12),
            currenciesLabel.topAnchor.constraint(equalTo: areaLabel.bottomAnchor, constant: 8),
            
            currenciesValueLabel.leadingAnchor.constraint(equalTo: currenciesLabel.trailingAnchor, constant: 4),
            currenciesValueLabel.topAnchor.constraint(equalTo: areaValueLabel.bottomAnchor, constant: 8),
            
            learnMoreButton.leadingAnchor.constraint(equalTo: totalView.leadingAnchor, constant: 126),
//            learnMoreButton.topAnchor.constraint(equalTo: currenciesValueLabel.bottomAnchor, constant: 26)
            learnMoreButton.bottomAnchor.constraint(equalTo: totalView.bottomAnchor, constant: -15)
        ])
    }
}

//MARK: - Extension for image

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
