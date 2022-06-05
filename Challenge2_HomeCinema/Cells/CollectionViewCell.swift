//
//  CollectionViewCell.swift
//  Challenge2_HomeCinema
//
//  Created by  Юлия Григорьева on 30.05.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var networkManager = NetworkManager()

    lazy var photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.sizeToFit()
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "some name"
        label.textColor = .white
                
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "some date"
        label.textColor = .gray
                
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        layout()
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        contentView.addSubview(photoView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            nameLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor)
        ])
    }

    
    func setupCell(indexCell: Int, titleFilm: String, releaseDate: String, posterFilm: String) {
        
        self.nameLabel.text = titleFilm
        self.dateLabel.text = releaseDate
        
        //Загрузка image фильма или сериала в CollectionView
        if posterFilm != "" {
            self.networkManager.getImageFilm(urlImage: posterFilm) { (result) in
                switch result {
                case .success(let data):
                    self.photoView.image = UIImage (data: data)
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            photoView.image = UIImage (named: "film")
        }
    }
}

    
    


