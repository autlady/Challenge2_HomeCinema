//
//  TableViewCell.swift
//  Challenge2_HomeCinema
//
//  Created by  Юлия Григорьева on 30.05.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    private lazy var filmCollection: UICollectionView = { //создаю collectionview
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell") // регистрирую ячейку в collectionview
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .black
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {

        contentView.addSubview(filmCollection)
        
        let inset: CGFloat = 12

        NSLayoutConstraint.activate([

            filmCollection.topAnchor.constraint(equalTo: contentView.topAnchor),
            filmCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            filmCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            filmCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),

        ])
    }
}

extension TableViewCell: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat { return 8 }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        // настраиваю размер ячеек
        let width = (collectionView.bounds.width - sideInset * 2) / 2.5
        return CGSize(width: width, height: width * 1.5)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        // настраиваю отступы между ячейками
        sideInset
    }
}

extension TableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        // количество ячеек
        12
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // создаю ячейку

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.setupCell()
        return cell
    }
}

