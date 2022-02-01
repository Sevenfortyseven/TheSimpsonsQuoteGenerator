//
//  HomeVM.swift
//  TheSimpsonsQuoteGenerator
//
//  Created by aleksandre on 29.01.22.
//

import Foundation

final class HomeViewModel {
    
    var cellVMs = [HomeCollectionCellVM]() {
        didSet {
            reloadCollectionView?()
        }
    }
    var userData: ObservableObject<CharacterModel?> = ObservableObject(value: nil)
    var characterData = [CharacterModel]()
    var reloadCollectionView: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var resetFetching: (() -> ())?
    var observer: NSObjectProtocol?
    
    
    var isLoading: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.updateLoadingStatus?()
            }
            
        }
    }
    
    public var numberOfCells: Int {
        return cellVMs.count
    }
    
    init() {
        fetchData()
        startObserving()
    }
    
    deinit {
        guard let observer = observer else {
            return
        }
        NotificationCenter.default.removeObserver(observer)
    }
    
    func fetchData() {
        print("fetching again")
        self.isLoading = true
        NetworkEngine.request(endpoint: TheSimpsonsQuoteAPIEndpoint.multipleQuotes(numberOfQuotes: "10")) { [weak self] (result: Result<CharacterInfoResponse, Error>) in
            self?.isLoading = false
            switch result {
            case .success(let response):
                let fetchedData =  response.map {
                    return CharacterModel(name: $0.characterName, quote: $0.quote, imageURL: $0.imageURL)
                }
                self?.processFetchedData(CharacterModels: fetchedData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func createCellVM(characterData: CharacterModel) -> HomeCollectionCellVM {
        var descriptionContainer = [String]()
        descriptionContainer.append(characterData.quote)
        descriptionContainer.append(characterData.name)
        let characterDescription = descriptionContainer.joined(separator: " - ")
        let characterImageURL = characterData.imageURL
        return HomeCollectionCellVM(description: characterDescription, imageURL: characterImageURL)
    }
    
    public func getCellVM(at indexPath: IndexPath) -> HomeCollectionCellVM {
        return cellVMs[indexPath.row]
    }
    
    private func processFetchedData(CharacterModels: [CharacterModel]) {
        self.characterData = CharacterModels
        var cellVMs = [HomeCollectionCellVM]()
        for characterModel in CharacterModels {
            cellVMs.append(createCellVM(characterData: characterModel))
        }
        self.cellVMs = cellVMs
    }
    
    public func refetchData() {
        self.fetchData()
    }
    
    private func startObserving() {
        NotificationCenter.default.addObserver(forName: .refetchButtonPressed, object: nil, queue: .main) { [weak self] _ in
            self?.refetchData()
        }
    }

}
