//
//  TheSimpsonsQuoteAPIEndpoint.swift
//  TheSimpsonsQuoteGenerator
//
//  Created by aleksandre on 27.01.22.
//

import Foundation

enum TheSimpsonsQuoteAPIEndpoint: Endpoint {
    
    case singleQuote
    case multipleQuotes(numberOfQuotes: String)
    
    var scheme: String {
        switch self {
        default: return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        default: return "thesimpsonsquoteapi.glitch.me"
        }
    }
    
    var path: String {
        switch self {
        default: return "/quotes"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .multipleQuotes(let numOfQuotes):
            return [URLQueryItem(name: "count", value: numOfQuotes)]
        default : return [URLQueryItem(name: "", value: "")]
        }
    }
    
    var method: String {
        switch self {
        default: return "GET"
        }
    }
    
    
    
}
