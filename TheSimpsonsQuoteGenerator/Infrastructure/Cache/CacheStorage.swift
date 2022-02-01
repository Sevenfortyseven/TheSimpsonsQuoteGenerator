//
//  CacheStorage.swift
//  TheSimpsonsQuoteGenerator
//
//  Created by aleksandre on 01.02.22.
//

import Foundation

class CacheStorage {
    
    private static var cache = [String : Data]()
    
    public static func setImageCache(_ url: String, _ data: Data?) {
        cache[url] = data
    }
    public static func getImageCache(_ url: String) -> Data? {
        return cache[url]
    }
}
