//
//  CharacterModel.swift
//  TheSimpsonsQuoteGenerator
//
//  Created by aleksandre on 31.01.22.
//

import Foundation

struct CharacterModel {
    let name: String
    let quote: String
    let imageURL: String
    let isFavorite: Bool
    
    init(name: String, quote: String, imageURL: String, isFavorite: Bool = false) {
        self.name = name
        self.quote = quote
        self.imageURL = imageURL
        self.isFavorite = isFavorite
    }
}
