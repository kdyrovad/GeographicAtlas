//
//  CountryResponse.swift
//  GeographicAtlas
//
//  Created by Дильяра Кдырова on 15.05.2023.
//

import Foundation
import UIKit

struct Country: Decodable {
    let area: Double
    let capital: [String]?
    let region: String
    let name: Name
    let continents: [String]
    let population: Int
    let currencies: [String : [String : String]]?
//    let timezones: [String]
    let flags: Flag
    let capitalInfo: [String : [Double]]
    let cca2: String
    let timezones: [String]
}

struct Name: Decodable {
    let common: String
}

struct Currency: Decodable {
    let name: String
    let symbol: String
}

struct Flag: Decodable {
    let png: String
    let svg: String
}

struct CapitalInfo: Decodable {
    let latlng: [Double]
}
