//
//  SecondViewController.swift
//  Challenge2_HomeCinema
//
//  Created by Даниил Кирьянчук on 31.05.2022.
//

import UIKit

class SecondViewController: UIViewController {
    
    var networkManager = NetworkManager()    
    
    var idMovie = 0
    
    var sectionType = ""
    
    var originalFilmUrl = "https://www.themoviedb.org/movie/"

    var originalShowUrl = "https://www.themoviedb.org/tv/"
    
    var filmActorsDataArray = [Cast]()
    
    @IBOutlet weak var filmImageView: UIImageView!
    
    @IBOutlet weak var actorCollectionView: UICollectionView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var movieOverview: UITextView!

    @IBAction func closeButtonTapped(_ sender: UIButton) {
    }
    
    // Переход на сайт фильма при нажатии на кнопку "Watch now"
    @IBAction func watchButtonTapped(_ sender: UIButton) {
        
        if sectionType == "TOPTV" {
            UIApplication.shared.open(URL(string: originalShowUrl + "\(idMovie)")! as URL, options: [:], completionHandler: nil)
        } else if sectionType == "TOPFILM" {
            UIApplication.shared.open(URL(string: originalFilmUrl + "\(idMovie)")! as URL, options: [:], completionHandler: nil)
        }
        //UIApplication.shared.open(NSURL(string: "https://www.themoviedb.org/movie/18-the-fifth-element")! as URL)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        actorCollectionView.register(ActorsCollectionViewCell.self, forCellWithReuseIdentifier: "ActorsCollectionViewCell") //регистрирую ячейку
        actorCollectionView.backgroundColor = .black
        movieOverview.backgroundColor = .black
        
        //networkManager.delegate = self
        
        //Загрузка описания фильма и фото
        //print("SectionType - \(sectionType)")
        if sectionType == "TOPTV" {
            networkManager.fetchFilmInfo(idMovie: idMovie) { (result) in
                switch result {
                case .success(let TvTopData):
                    self.movieTitle.text = TvTopData.title
                    self.movieOverview.text = TvTopData.overview
                    self.networkManager.getImageFilm(urlImage: TvTopData.poster) { (result) in
                        switch result {
                        case .success(let data):
                            self.filmImageView.image = UIImage (data: data)
                        case .failure(let error):
                            print(error)
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
        } else if sectionType == "TOPFILM" {
            networkManager.fetchFilmInfo(idMovie: idMovie) { (result) in
                switch result {
                case .success(let FilmData):
                    self.movieTitle.text = FilmData.title
                    self.movieOverview.text = FilmData.overview
                    self.networkManager.getImageFilm(urlImage: FilmData.poster) { (result) in
                        switch result {
                        case .success(let data):
                            self.filmImageView.image = UIImage (data: data)
                        case .failure(let error):
                            print(error)
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        //Загрузка данных актеров к фильму и сохранение во временный массив для дальнейшего использования
        if sectionType == "TOPTV" {
            networkManager.fetchFilmActors(idMovie: idMovie, roleActors: "TV") { (result) in
                switch result {
                case .success(let FilmActorsData):
                    self.filmActorsDataArray = FilmActorsData.cast
                    self.actorCollectionView.dataSource = self
                    self.actorCollectionView.delegate = self
                case .failure(let error):
                    print(error)
                }
            }
        } else if sectionType == "TOPFILM" {
            networkManager.fetchFilmActors(idMovie: idMovie, roleActors: "FILM") { (result) in
                switch result {
                case .success(let FilmActorsData):
                    self.filmActorsDataArray = FilmActorsData.cast
                    self.actorCollectionView.dataSource = self
                    self.actorCollectionView.delegate = self
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
}


    // MARK: - extensions


extension SecondViewController: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat { return 8 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // настраиваю размер ячеек
        let width = (collectionView.bounds.width - sideInset * 4) / 5
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        // настраиваю отступы между ячейками
        sideInset
    }
}

extension SecondViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // количество ячеек
        self.filmActorsDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // создаю ячейку        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorsCollectionViewCell", for: indexPath) as! ActorsCollectionViewCell
        cell.setupCell(indexCell: indexPath.row, nameActor: self.filmActorsDataArray[indexPath.row].name, characterActor: self.filmActorsDataArray[indexPath.row].character, profilePhoto: self.filmActorsDataArray[indexPath.row].profile_photo)
        return cell
    }
}


////MARK: - FilmInfoManagerDelegate
//
//extension SecondViewController: FilmInfoManagerDelegate {
//
//    func  didUpdateFilmInfo(_ networkManager: NetworkManager, filmInfo: FilmData) {
//
//        DispatchQueue.main.async {
//            self.movieTitle.text = filmInfo.title
//            self.movieOverview.text = filmInfo.overview
//        }
//    }
//
//    func didFailWithError(error: Error) {
//        print(error)
//    }
//}



