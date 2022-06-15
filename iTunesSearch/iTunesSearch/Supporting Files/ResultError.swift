//
//  ResultError.swift
//  iTunesSearch
//
//  Created by Karl Pfister on 6/4/22.
//

import Foundation

enum ResultError: LocalizedError {
    case invalidURL(String)
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL(let urlString):
            return "Unable to reach the server. Please try again. The URL used is: \(urlString)"
        case .thrownError(let error):
            return "Error: \(error.localizedDescription) -> \(error)"
        case .noData:
            return "The server responded with no data. Please try again"
        case .unableToDecode:
            return "The server responded with bad data. Please try again"
        }
    }
}
