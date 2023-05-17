//
//  CountryModel.swift
//  GeographicAtlas
//
//  Created by Дильяра Кдырова on 14.05.2023.
//

import Foundation
import UIKit

protocol CountryModelProtocol {
    var countryName: String { get }
    var capitalName: String { get }
    var flagURL: String { get }
    var regionName: String { get }
    var cca2: String { get }
    var capitalInfo: String { get }
    var population: String { get }
    var area: String { get }
    var continets: [String] { get }
    var currencies: String { get }
    var timezones: String { get }
    var currenciesAll: String { get }
    
    var isExpanded: Bool { get set }
}

final class CountryModel: CountryModelProtocol {
    private let country: Country
    
    init(country: Country) {
        self.country = country
    }
    
    var countryName: String {
        country.name.common
    }
    
    var capitalName: String {
        (country.capital?[0]) ?? ""
    }
    
    var flagURL: String {
        return country.flags.png
    }
    
    var regionName: String {
        return country.region
    }
    
    var regionsNumber: Int {
        return country.continents.count
    }
    
    var continets: [String] {
        return country.continents
    }
    
    var isExpanded: Bool = false
    
    var population: String {
        if country.population > 1000000 {
            return "\(country.population/1000000) mln"
        } else {
            return "\(country.population)"
        }
    }
    
    var area: String {
        return String(format: "%.0f", country.area) + " km²"
    }
    
    var currencies: String {
        if ((country.currencies?.keys.count) ?? 0) > 1 {
            var str = ""
            for (_, value) in country.currencies! {
                if let name = value["name"] {
                    str += "\(name), "
                }
            }
            return str
        } else {
            return "\(country.currencies?.first?.value["name"] ?? "") (\(country.currencies?.first?.value["symbol"] ?? "")) (\(country.currencies?.first?.key ?? ""))"
        }
    }
    
    var currenciesAll: String {
        var str = ""
        guard let countryCurrencies = country.currencies else { return "" }
        for (key, value) in countryCurrencies {
            if let name = value["name"], let symbol = value["symbol"] {
                str += "\(name) (\(symbol)) (\(key))\n"
            }
        }
        return str
    }
    
    var capitalInfo: String {
        return "\(country.capitalInfo.first?.value[0] ?? 0)".replacingOccurrences(of: ".", with: "°")+"' \(country.capitalInfo.first?.value[1] ?? 0)".replacingOccurrences(of: ".", with: "°")+"'"
    }
    
    var cca2: String {
        return country.cca2
    }
    
    var timezones: String {
        return country.timezones.joined(separator: "\n")
    }
}
