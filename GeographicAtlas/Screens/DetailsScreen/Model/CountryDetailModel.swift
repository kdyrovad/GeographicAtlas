//
//  CountryDetailModel.swift
//  GeographicAtlas
//
//  Created by Дильяра Кдырова on 17.05.2023.
//

import Foundation

protocol CountryDetailModelProtocol {
    var countryName: String { get }
    var flagURL: String { get }
    var regionName: String { get }
    var capitalName: String { get }
    var capitalInfo: String { get }
    var population: String { get }
    var area: String { get }
    var currencies: String { get }
    var cca2: String { get }
    var timezone: String { get }
    
}

final class CountryDetailModel: CountryDetailModelProtocol {
    private let country: CountryDetail
    
    init(country: CountryDetail) {
        self.country = country
    }
    
    var countryName: String {
        country.name.common
    }
    
    var flagURL: String {
        country.flags.png
    }
    
    var regionName: String {
        country.region
    }
    
    var capitalName: String {
        (country.capital?[0]) ?? ""
    }
    
    var capitalInfo: String {
        return "\(country.capitalInfo?.first?.value.first ?? 0)"
    }
    
    var population: String {
        if country.population > 1000000 {
            return "\(country.population/1000000) mln"
        } else {
            return "\(country.population)"
        }
    }
    
    var area: String {
        return "\(country.area) mln km²"
    }
    
    var currencies: String {
        return "\(country.currencies?.first?.value["name"] ?? "") (\(country.currencies?.first?.value["symbol"] ?? "")) (\(country.currencies?.first?.key ?? ""))"
    }
    
    var cca2: String {
        return country.cca2
    }
    
    var timezone: String {
        country.timezones[0] ?? ""
    }
    
    
}
