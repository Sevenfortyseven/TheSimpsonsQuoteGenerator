//
//  EndpointProtocol.swift
//  TheSimpsonsQuoteGenerator
//
//  Created by aleksandre on 27.01.22.
//

import Foundation

protocol Endpoint {
    
    var scheme: String { get }
    
    var baseURL: String { get }
    
    var path: String { get }
    
    var parameters: [URLQueryItem] { get }
    
    var method: String { get }
}
