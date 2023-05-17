//
//  CountryPresenter.swift
//  GeographicAtlas
//
//  Created by Дильяра Кдырова on 14.05.2023.
//

import Foundation

protocol CountryViewProtocol: AnyObject {
    func updateView()
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
} 

protocol CountryPresenterProtocol {
    var view: CountryViewProtocol? { get set }
    var itemsCount: Int { get }
    
    var regionsCount: Int { get }
    
    var groupedElements: [String: [CountryModel]] { get }
    
    func loadView()
    func model(for indexPath: IndexPath) -> CountryModel
}

final class CountryPresenter: CountryPresenterProtocol {
    
    var groupedElementss: [String: [CountryModel]] = [:]
    
    private let service: CountryServiceProtocol
    private var countries: [CountryModel] = []
    
    var uniqueContinents = Set<String>()
    
    init(service: CountryServiceProtocol) {
        self.service = service
    }
    
    weak var view: CountryViewProtocol?
    
    var itemsCount: Int {
        countries.count
    }
    
    var regionsCount: Int {
        uniqueContinents.count
    }
    
    var groupedElements: [String: [CountryModel]] {
        return groupedElementss
    }
    
    func model(for indexPath: IndexPath) -> CountryModel {
        let continent = groupedElements.keys.sorted()[indexPath.section]
        let countriesForContinent = groupedElements[continent]
        let countryModel = (countriesForContinent?[indexPath.row])!
        return countryModel
    }
    
    func loadView() {
        view?.updateView(withLoader: true)
        
        service.getStocks { [weak self] result in
            self?.view?.updateView(withLoader: false)
            
            switch result {
            case .success(let countries):
               
                for country in countries {
                    self?.uniqueContinents.insert(country.continents.first!)
                }
                
                self?.groupedElementss = Dictionary(grouping: countries.map { CountryModel(country: $0) }, by: { $0.continets.first ?? "" })
                
                self?.countries = countries.map { CountryModel(country: $0) }
                self?.view?.updateView()
            case .failure(let error):
                self?.view?.updateView(withError: error.localizedDescription)
            }
        }
    }
    
}
