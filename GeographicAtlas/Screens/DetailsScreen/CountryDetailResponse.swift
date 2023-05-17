//
//  CountryDetailResponse.swift
//  GeographicAtlas
//
//  Created by Дильяра Кдырова on 17.05.2023.
//

import Foundation

struct CountryDetail: Decodable {
    let area: Double
    let capital: [String]?
    let region: String
    let name: Name
    let population: Int
    let currencies: [String : [String : String]]?
    let flags: Flag
    let capitalInfo: [String : [Double]]?
    let cca2: String
    let timezones: [Int: String]
}
