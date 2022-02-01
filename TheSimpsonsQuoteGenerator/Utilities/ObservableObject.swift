//
//  ObservableObject.swift
//  TheSimpsonsQuoteGenerator
//
//  Created by aleksandre on 29.01.22.
//

import Foundation

final class ObservableObject<T> {
    
    var value: T {
        didSet {
            guard let listener = listener else {
                print("value is \(value)")
                return
            }
            listener(value)
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    var listener: ((T) -> Void)? = nil
    
    func bind(_ listener:  @escaping (T) -> Void) {
        listener(value)
        self.listener = listener
        
    }
}
