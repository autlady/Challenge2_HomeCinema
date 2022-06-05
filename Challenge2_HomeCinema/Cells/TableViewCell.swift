//
//  TableViewCell.swift
//  Challenge2_HomeCinema
//
//  Created by  Юлия Григорьева on 30.05.2022.
//

import UIKit

//Протокол для возможности вызвать сигвей по клику на ячейку
protocol DidClickCellDelegate {
    func didClickCell(_ cell: TableViewCell, id: Int, sectionType: String)
}

class TableViewCell: UITableViewCell {
    
    var delegate: DidClickCellDelegate?
    
    var networkManager = NetworkManager()
    
    //Массивы для временного хранения спарсеных данных
    var filmTopDataArray = [Films]()
    var tvTopDataArray = [TopTV]()
    
    var countMovie = 0
    
    private lazy var filmCollection: UICollectionView = { //создаю collectionview
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        //print("IndexSection - \(indexSection)")
        //Кейсы для выбора секции, куда подгружать данные
        switch indexSection {
        case 0:
            networkManager.fetchMovie(urlString: UrlMovie.urlFilmTop) { (result: Result<FilmTopData, Error>) in
                switch result {
                case .success(let FilmTopData):
                    self.filmTopDataArray = FilmTopData.results
                    self.countMovie = self.filmTopDataArray.count
                    collectionView.delegate = self
                    collectionView.dataSource = self
                case .failure(let error):
                    print(error)
                }
            }
        case 1:
            networkManager.fetchMovie(urlString: UrlMovie.urlTvTop) { (result: Result<TvTopData, Error>) in
                switch result {
                case .success(let TvTopData):
                    self.tvTopDataArray = TvTopData.results
                    self.countMovie = self.tvTopDataArray.count
                    collectionView.delegate = self
                    collectionView.dataSource = self
                case .failure(let error):
                    print(error)
                }
            }
        case 2:
            networkManager.fetchMovie(urlString: UrlMovie.urlFilmTop) { (result: Result<FilmTopData, Error>) in
                switch result {
                case .success(let FilmTopData):
                    self.filmTopDataArray = FilmTopData.results
                    self.countMovie = self.filmTopDataArray.count
                    collectionView.delegate = self
                    collectionView.dataSource = self
                case .failure(let error):
                    print(error)
                }
            }
        default:
            break
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
        self.countMovie
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // создаю ячейку
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        if self.filmTopDataArray.isEmpty == false {
            cell.setupCell(indexCell: indexPath.row, titleFilm: filmTopDataArray[indexPath.row].title, releaseDate: filmTopDataArray[indexPath.row].release_date, posterFilm: filmTopDataArray[indexPath.row].poster)
        } else if self.tvTopDataArray.isEmpty == false {
            cell.setupCell(indexCell: indexPath.row, titleFilm: tvTopDataArray[indexPath.row].name, releaseDate: tvTopDataArray[indexPath.row].first_air_date, posterFilm: tvTopDataArray[indexPath.row].poster)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(self.filmTopDataArray)
        print(self.tvTopDataArray)
        
        if self.filmTopDataArray.isEmpty == false {
            delegate?.didClickCell(self, id: filmTopDataArray[indexPath.row].id, sectionType: "TOPFILM")
        } else if self.tvTopDataArray.isEmpty == false {
            delegate?.didClickCell(self, id: tvTopDataArray[indexPath.row].id, sectionType: "TOPTV")
        }
        
    }
    
}

