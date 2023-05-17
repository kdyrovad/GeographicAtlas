//
//  NetworkError.swift
//  GeographicAtlas
//
//  Created by Дильяра Кдырова on 15.05.2023.
//

import Foundation

enum NetworkError: String, Error {
    case missingURL
    case missingRequest
    case taskError
    case responseError
    case dataError
    case decodeError
}
