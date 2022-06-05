//
//  NetworkManager.swift
//  Challenge2_HomeCinema
//
//  Created by Roman Smiyan on 03.06.2022.
//

import Foundation


struct NetworkManager {
    
    //Загрузка изображений
    func getImageFilm(urlImage: String, completion: @escaping (Result<Data, Error>) -> Void) {
        //print("urlImage - \(urlImage)")
        guard let imageURL = URL(string: urlImage) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: imageURL) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
            
        }
        task.resume()
    }
    
    //Универсальный парсер для популярных фильмов и сериалов
    func fetchMovie<T: Codable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do {
                    let resultMovieTop = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(resultMovieTop))
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
    
    //Парсинг данных о фильме
    func fetchFilmInfo(idMovie:Int, completion: @escaping (Result<FilmData, Error>) -> Void) {
        let urlString = "https://api.themoviedb.org/3/movie/\(idMovie)?api_key=d015925a3cd3c8a114f5dced8b22d262&language=ru-RU"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do {
                    let resultFilmInfo = try JSONDecoder().decode(FilmData.self, from: data)
                    completion(.success(resultFilmInfo))
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
    
    //Парсинг актеров к фильмам и сериалам
    func fetchFilmActors(idMovie:Int, roleActors: String, completion: @escaping (Result<FilmActorsData, Error>) -> Void) {
        var urlString = ""
        if roleActors == "TV" {
            urlString = "https://api.themoviedb.org/3/tv/\(idMovie)/credits?api_key=d015925a3cd3c8a114f5dced8b22d262&language=ru-RU"
        } else if roleActors == "FILM" {
            urlString = "https://api.themoviedb.org/3/movie/\(idMovie)/credits?api_key=d015925a3cd3c8a114f5dced8b22d262&language=ru-RU"
        }
        print(urlString)
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do {
                    let resultFilmInfo = try JSONDecoder().decode(FilmActorsData.self, from: data)
                    completion(.success(resultFilmInfo))
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
    
    
}


//protocol FilmInfoManagerDelegate {
//    func didUpdateFilmInfo(_ networkManager: NetworkManager, filmInfo: FilmData)
//    func didFailWithError(error: Error)
//}
//
//struct NetworkManager {
//
//    var delegate: FilmInfoManagerDelegate?
//
//    func fetchFilmInfo(idMovie: Int) {
//        let urlString = "https://api.themoviedb.org/3/movie/\(idMovie)?api_key=d015925a3cd3c8a114f5dced8b22d262&language=ru-RU"
//        performRequest(with: urlString)
//    }
//
//
//    func performRequest(with urlString: String){
//        if let url = URL(string: urlString) {
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { (data, response, error) in
//                if error != nil {
//                    self.delegate?.didFailWithError(error: error!)
//                    return
//                }
//                if let data = data {
//                    if let filmInfo = self.parseJSON(data) {
//                        self.delegate?.didUpdateFilmInfo(self, filmInfo: filmInfo)
//                    }
//                }
//            }
//            task.resume()
//        }
//    }
//
//    func parseJSON(_ filmData: Data) -> FilmData? {
//        let decoder = JSONDecoder()
//        do {
//            let decoderData = try decoder.decode(FilmData.self, from: filmData)
//            print(decoderData.id)
//            print(decoderData.title)
//            print(decoderData.overview)
//            print(decoderData.poster_path)
//            return decoderData
//        } catch {
//            delegate?.didFailWithError(error: error)
//            return nil
//        }
//    }
//}

