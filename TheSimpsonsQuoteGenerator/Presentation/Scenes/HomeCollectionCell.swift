//
//  HomeCollectionViewCell.swift
//  TheSimpsonsQuoteGenerator
//
//  Created by aleksandre on 31.01.22.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    private(set) static var reuseID = String(describing: HomeCollectionViewCell.self)
    
    // MARK: - Instances
   
    public var HomeCollectionCellVM: HomeCollectionCellVM? {
        didSet {
            updateCell()
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .primaryColor
        self.clipsToBounds = true
        addSubviews()
        initializeStackView()
        initializeConstraints()
        print("init")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainStackView.layoutIfNeeded()
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        self.contentView.addSubview(mainStackView)

    }
    
    private func initializeStackView() {
        mainStackView.addArrangedSubview(characterDescriptionLabel)
        mainStackView.addArrangedSubview(characterImageView)
        
    }
    
    private func updateCell() {
        guard let HomeCollectionCellVM = HomeCollectionCellVM else {
            return
        }
        self.characterDescriptionLabel.text = HomeCollectionCellVM.description
        self.characterImageView.loadImageFromURL(urlString: HomeCollectionCellVM.imageURL)
    }
    
    // MARK: - UI Configuration
    
    
    // MARK: - UI Elements
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let characterDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .quaternaryColor
        label.font = .preferredFont(forTextStyle: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()

    
    // MARK: - Constraints
    
    private func initializeConstraints() {

        var constraints = [NSLayoutConstraint]()
        /// StackView
        constraints.append(mainStackView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor))
        constraints.append(mainStackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor))
        constraints.append(mainStackView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.7))
        constraints.append(mainStackView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.8))
       
        NSLayoutConstraint.activate(constraints)
    }
}


