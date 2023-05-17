//
//  CountryService.swift
//  GeographicAtlas
//
//  Created by Дильяра Кдырова on 15.05.2023.
//

import Foundation

protocol CountryServiceProtocol {
    func getStocks(completion: @escaping (Result<[Country], NetworkError>) -> Void)
    func getStockDetail(id: String, completion: @escaping (Result<[CountryDetail], NetworkError>) -> Void)
}

final class CountryService: CountryServiceProtocol {
    func getStocks(completion: @escaping (Result<[Country], NetworkError>) -> Void) {
        client.execute(with: CountryRouter.countries, completion: completion)
    }
    
    func getStockDetail(id: String, completion: @escaping (Result<[CountryDetail], NetworkError>) -> Void) {
        client.execute(with: CountryRouter.detailCountry(id: id), completion: completion)
    }
    
    private let client: NetworkService
    
    private var stocks: [Country] = []
    
    init(client: NetworkService) {
        self.client = client
    }
}

