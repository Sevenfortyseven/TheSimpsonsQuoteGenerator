//
//  HomeVC.swift
//  TheSimpsonsQuoteGenerator
//
//  Created by aleksandre on 29.01.22.
//


import UIKit

final class HomeViewController: UIViewController {
    
    //MARK: - Instances
    
    private let homeViewModel = HomeViewModel()
    
    
    //MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .primaryColor
        addSubviews()
        initializeConstraints()
        registerCollectionView()
        initVM()
    }
    
    
    private func addSubviews() {
        self.view.addSubview(homeCollectionView)
        self.view.addSubview(activityIndicator)
        self.view.addSubview(refreshQuotes)
    }

    private func initVM() {
        homeViewModel.reloadCollectionView = { [weak self] () in
            DispatchQueue.main.async {
                self?.homeCollectionView.reloadData()
            }
        }
        homeViewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.homeViewModel.isLoading ?? false
                if isLoading {
                    self?.refreshQuotes.isHidden = true
                    self?.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2) {
                        self?.homeCollectionView.alpha = 0.0
                    }
                } else {
                    self?.refreshQuotes.isHidden = false
                    self?.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2) {
                        self?.homeCollectionView.alpha = 1.0
                    }
                }
            }
        }
    }
    
    
    // MARK: - UI Elements
    
    
    private let homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.clipsToBounds = true
        collectionView.bounces = false
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private let refreshQuotes: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(refreshQuotesOnTouch), for: .touchUpInside)
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.tintColor = .quaternaryColor
        return button
    }()
    
    
    
    // MARK: - Button Actions

    @objc private func refreshQuotesOnTouch() {
        NotificationCenter.default.post(name: .refetchButtonPressed, object: nil)
    }
    
    
}




//MARK: CollectionView Datasource + Delegate

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Register CollectionView
    private func registerCollectionView() {
        homeCollectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.reuseID)
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(homeViewModel.numberOfCells)
        return homeViewModel.numberOfCells
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.reuseID, for: indexPath) as? HomeCollectionViewCell else {
            fatalError("Cell doesn't exist")
        }
        let cellVM = homeViewModel.getCellVM(at: indexPath)
        cell.HomeCollectionCellVM = cellVM
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}


//MARK: - Constraints

extension HomeViewController {
    
    private func initializeConstraints() {
        let spinnerSize = CGFloat(50)
        let topPadding = CGFloat(50)
        let rightPadding = CGFloat(-50)
        
        var constraints = [NSLayoutConstraint]()
        
        /// CollectionView
        constraints.append(homeCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor))
        constraints.append(homeCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor))
        constraints.append(homeCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor))
        constraints.append(homeCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor))
        
        /// Activity indicator
        constraints.append(activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor))
        constraints.append(activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor))
        constraints.append(activityIndicator.widthAnchor.constraint(equalToConstant: spinnerSize))
        constraints.append(activityIndicator.heightAnchor.constraint(equalToConstant: spinnerSize))
        
        /// Quotes refresh button
        constraints.append(refreshQuotes.topAnchor.constraint(equalTo: self.view.topAnchor, constant: topPadding))
        constraints.append(refreshQuotes.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: rightPadding))
    
        
        NSLayoutConstraint.activate(constraints)
    }
}

