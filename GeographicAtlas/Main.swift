//
//  Main.swift
//  GeographicAtlas
//
//  Created by Дильяра Кдырова on 15.05.2023.
//

import Foundation
import UIKit

final class Main {
    private init() {}
    
    private lazy var network: NetworkService = {
        Network()
    }()
    
    static let shared: Main = .init()
    
    func networkService() -> NetworkService {
        network
    }
    
    func countryService() -> CountryServiceProtocol {
        CountryService(client: network)
    }
    
    func countriesScreen() -> UIViewController {
        let presenter = CountryPresenter(service: countryService())
        let view = ViewController(presenter: presenter)
        presenter.view = view
        
        return view
    }
    
    func detailsScreen(for model: CountryModelProtocol) -> DetailViewController {
        let presenter = DetailPresenter(service: countryService(), model: model)
        let detailVC = DetailViewController(presenter: presenter)
        return detailVC
    }
    
    func navController() -> UINavigationController {
        return UINavigationController(rootViewController: countriesScreen())
    }
}
