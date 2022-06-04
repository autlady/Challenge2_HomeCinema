//
//  ActorsCollectionViewCell.swift
//  Challenge2_HomeCinema
//
//  Created by Даниил Кирьянчук on 31.05.2022.
//

import UIKit

class ActorsCollectionViewCell: UICollectionViewCell {
    
    var networkManager = NetworkManager()
    
    lazy var photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 2.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = self.frame.width/2.0
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "some name"
        label.textColor = .white

        return label
    }()

    private lazy var roleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.text = "some role"
        label.textColor = .gray

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        contentView.addSubview(photoView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(roleLabel)



        NSLayoutConstraint.activate([
            roleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            roleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            roleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            roleLabel.heightAnchor.constraint(equalToConstant: 20),

            nameLabel.bottomAnchor.constraint(equalTo: roleLabel.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor)
        ])
    }

    func setupCell(indexCell: Int, idMovie: Int) {

        self.networkManager.fetchFilmActors(idMovie: idMovie) { (result) in
            switch result {

            case .success(let FilmActorsData):

                self.nameLabel.text = FilmActorsData.cast[indexCell].name
                self.roleLabel.text = FilmActorsData.cast[indexCell].character

                self.networkManager.getImageFilm(urlImage: FilmActorsData.cast[indexCell].profile_photo) { (result) in
                    switch result {
                    case .success(let data):
                        self.photoView.image = UIImage (data: data)
                    case .failure(let error):
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
        
        
//    func setupCell(indexCell: Int, nameActor: String, characterActor: String, profile_photo: String) {
//
//        self.nameLabel.text = nameActor
//        self.roleLabel.text = characterActor
//
//        self.networkManager.getImageFilm(urlImage: profile_photo) { (result) in
//            switch result {
//            case .success(let data):
//                self.photoView.image = UIImage (data: data)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
}


