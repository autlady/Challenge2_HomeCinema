//
//  CollectionViewCell.swift
//  Challenge2_HomeCinema
//
//  Created by  Юлия Григорьева on 30.05.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    lazy var photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.sizeToFit()
        return imageView
    }()
    
    private lazy var nameLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "some name"
        label.textColor = .white
                
        return label
    }()
    
    private lazy var dateLable: UILabel = {
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
        contentView.addSubview(nameLable)
        contentView.addSubview(dateLable)


        
        NSLayoutConstraint.activate([
            dateLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dateLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dateLable.heightAnchor.constraint(equalToConstant: 20),
            
            nameLable.bottomAnchor.constraint(equalTo: dateLable.topAnchor),
            nameLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dateLable.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoView.bottomAnchor.constraint(equalTo: nameLable.topAnchor)
        ])
    }

    func setupCell() {
        photoView.image = UIImage(named: "film")
        
    }
}

