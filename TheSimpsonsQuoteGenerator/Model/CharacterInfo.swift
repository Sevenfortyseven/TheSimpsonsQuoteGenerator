//
//  Character.swift
//  TheSimpsonsQuoteGenerator
//
//  Created by aleksandre on 27.01.22.
//

import Foundation

struct CharacterInfo: Codable {
    
    let quote: String
    let characterName: String
    let imageURL: String
    let characterDirection: String
    
    enum CodingKeys: String, CodingKey {
        case quote, characterDirection
        case characterName = "character"
        case imageURL = "image"
    }
}
