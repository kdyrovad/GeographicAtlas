//
//  DetailPresenter.swift
//  GeographicAtlas
//
//  Created by Дильяра Кдырова on 15.05.2023.
//

import Foundation
import UIKit

protocol DetailViewProtocol: AnyObject {
    func updateView()
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}

protocol DetailPresenterProtocol {
    var countryName: String { get }
    var capitalName: String { get }
    var currency: String { get }
    var capitalInfo: String { get }
    var timezones: String { get }
    var currencies: String { get }
    
    func loadView()
}

final class DetailPresenter: DetailPresenterProtocol {
    
    private let model: CountryModelProtocol
    private let service: CountryServiceProtocol
    
    private var countriesDetail: [CountryDetailModelProtocol] = []
    
    weak var view: DetailViewProtocol?
    
    var countryName: String {
        return model.countryName
    }
    
    var capitalName: String {
        return model.capitalName
    }
    
    var currency: String {
        model.currencies
    }
    
    var capitalInfo: String {
        countriesDetail.first?.capitalInfo ?? ""
    }
    
    var timezones: String {
        model.timezones
    }
    
    var currencies: String {
        model.currenciesAll
    }
    
    init(service: CountryServiceProtocol, model: CountryModelProtocol) {
        self.service = service
        self.model = model
    }
    
    func loadView() {
        view?.updateView(withLoader: true)
        
        service.getStockDetail(id: model.cca2) { [weak self] result in
            self?.view?.updateView(withLoader: false)
            switch result {
            case .success(let countries):
                self?.countriesDetail = countries.map { CountryDetailModel(country: $0) }
                self?.view?.updateView()
            case .failure(let error):
                self?.view?.updateView(withError: error.localizedDescription)
            }
        }
    }
}



