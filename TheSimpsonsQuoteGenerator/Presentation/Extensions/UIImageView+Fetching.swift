//
//  UIImage+Fetching.swift
//  TheSimpsonsQuoteGenerator
//
//  Created by aleksandre on 01.02.22.
//

import UIKit

extension UIImageView {
    @discardableResult
    func loadImageFromURL(urlString: String, placeholder: UIImage? = nil) -> URLSessionDataTask? {
        self.image = nil
        
        if let cachedImage = CacheStorage.getImageCache(urlString) {
            self.image = UIImage(data: cachedImage)
            return nil
        }
        guard let url = URL(string: urlString) else { return nil }
        if let placeholder = placeholder {
            self.image = placeholder
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data , _, _ in
            DispatchQueue.main.async {
                if let data = data, let downloadedImage = UIImage(data: data) {
                    CacheStorage.setImageCache(url.absoluteString, data)
                    self.image = downloadedImage
                }
            }
        }
        dataTask.resume()
        return dataTask
    }
}
