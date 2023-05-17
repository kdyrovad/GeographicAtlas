//
//  StocksRouter.swift
//  GeographicAtlas
//
//  Created by Дильяра Кдырова on 15.05.2023.
//

import Foundation

enum CountryRouter: Router {
    case countries
    case detailCountry(id: String)
    
    var baseUrl: String {
        "https://restcountries.com/v3.1"
    }
    
    var path: String {
        switch self {
        case .countries:
            return "/all"
        case .detailCountry(let id):
            return "/alpha\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .countries, .detailCountry:
            return .get
        }
    }
}

