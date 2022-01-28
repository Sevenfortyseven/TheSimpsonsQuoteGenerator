//
//  ViewController.swift
//  TheSimpsonsQuoteGenerator
//
//  Created by aleksandre on 27.01.22.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemRed
        NetworkEngine.request(endpoint: TheSimpsonsQuoteAPIEndpoint.singleQuote) { (result: Result<CharacterInfoResponse,Error>) in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }


}

