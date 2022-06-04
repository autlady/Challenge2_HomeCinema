//
//  SecondViewController.swift
//  Challenge2_HomeCinema
//
//  Created by Даниил Кирьянчук on 31.05.2022.
//

import UIKit

class SecondViewController: UIViewController {
    
    var networkManager = NetworkManager()
    
    var urlPoster = ""
    
    var countActors = 0
    
    var idMovie = 0
    
    //var filmActorsDataArray = [Cast]()
    
    @IBOutlet weak var filmImageView: UIImageView!
    
    @IBOutlet weak var actorCollectionView: UICollectionView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var movieOverview: UITextView!

    @IBAction func closeButtonTapped(_ sender: UIButton) {
    }

    @IBAction func watchButtonTapped(_ sender: UIButton) {
        UIApplication.shared.open(NSURL(string: "https://www.themoviedb.org/movie/18-the-fifth-element")! as URL)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
//        actorCollectionView.dataSource = self
//        actorCollectionView.delegate = self
        actorCollectionView.register(ActorsCollectionViewCell.self, forCellWithReuseIdentifier: "ActorsCollectionViewCell") //регистрирую ячейку
        actorCollectionView.backgroundColor = .black
        movieOverview.backgroundColor = .black
        
        //networkManager.delegate = self
        
        networkManager.fetchFilmInfo(idMovie: idMovie) { (result) in
            switch result {
            case .success(let FilmData):
                self.movieTitle.text = FilmData.title
                self.movieOverview.text = FilmData.overview
                self.urlPoster = FilmData.poster
                
                self.networkManager.getImageFilm(urlImage: self.urlPoster) { (result) in
                    switch result {
                    case .success(let data):
                        //print("urlPoster getImageFilm - \(self.urlPoster)")
                        self.filmImageView.image = UIImage (data: data)
                    case .failure(let error):
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        
        networkManager.fetchFilmActors(idMovie: idMovie) { (result) in
            switch result {

            case .success(let FilmActorsData):
                print(FilmActorsData.id)
                print(FilmActorsData.cast[0].name)
                print(FilmActorsData.cast[0].profile_photo)
                //print(FilmActorsData)
                print(FilmActorsData.cast.count)
                self.countActors = FilmActorsData.cast.count
                
                self.actorCollectionView.dataSource = self
                self.actorCollectionView.delegate = self
                
            case .failure(let error):
                print(error)
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
        countActors
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // создаю ячейку        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorsCollectionViewCell", for: indexPath) as! ActorsCollectionViewCell
        cell.setupCell(indexCell: indexPath.row, idMovie: self.idMovie)
        //cell.setupCell(indexCell: indexPath.row, nameActor: self.filmActorsDataArray[indexPath.row], characterActor: self.filmActorsDataArray[indexPath.row], profile_photo: self.filmActorsDataArray[indexPath.row])
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
