//
//  NetworkEngine.swift
//  TheSimpsonsQuoteGenerator
//
//  Created by aleksandre on 27.01.22.
//

import UIKit


class NetworkEngine<T: Codable> {
    
    typealias NetworkFetchingCompletion = ((Result<T, Error>) -> Void)
    
    static func request(endpoint: Endpoint, completion: @escaping NetworkFetchingCompletion) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.baseURL
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.parameters
        
        guard let url = urlComponents.url else {
            print("Invalid url: \(String(describing: urlComponents.url))")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription ?? "Unknown Error")
                return
            }
            guard response != nil, let data = data else { return }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                
                let decoder = JSONDecoder()
                if let responseObject = try? decoder.decode(T.self, from: data) {
                    completion(.success(responseObject))
                } else {
                    let error = NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "Failed to Decode response"])
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
        
    }
        
        
    
    
}
