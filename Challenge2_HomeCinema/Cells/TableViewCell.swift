//
//  TableViewCell.swift
//  Challenge2_HomeCinema
//
//  Created by  Юлия Григорьева on 30.05.2022.
//

import UIKit

protocol DidClickCellDelegate {
    func didClickCell(_ cell: TableViewCell, id: Int)
}

class TableViewCell: UITableViewCell {
    
    var delegate: DidClickCellDelegate?
    
    var networkManager = NetworkManager()

    var countTopFilms = 0
    
    var filmTopDataArray = [Films]()

    private lazy var filmCollection: UICollectionView = { //создаю collectionview
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        networkManager.fetchFilmTop { (result) in
            switch result {

            case .success(let FilmTopData):

                self.countTopFilms = FilmTopData.results.count
                self.filmTopDataArray = FilmTopData.results

                collectionView.delegate = self
                collectionView.dataSource = self
                
                
            case .failure(let error):
                print(error)
            }
        }
        
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
        countTopFilms
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // создаю ячейку

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.setupCell(indexCell: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didClickCell(self, id: self.filmTopDataArray[indexPath.row].id)
    }
    
    
}

