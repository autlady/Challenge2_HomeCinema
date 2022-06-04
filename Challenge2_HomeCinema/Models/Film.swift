//
//  Film.swift
//  Challenge2_HomeCinema
//
//  Created by  Юлия Григорьева on 30.05.2022.
//
import UIKit
import Foundation

// Создаем расширение UIImageView для отображения картинки по ссылке URL

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

// Делаем две структуры для передачи данных с API запроса

struct Results: Decodable {
    var page: Int
    var results: [Films]
}

struct Films: Decodable {
    var id: Int
    var title: String
    var release_date: String
    var poster_path: String
}

// Масив для хранения данных о фильмах

var films = [Films]()

// Переменная для хранения пути к картинке по дефолту

var defaultImageUrl = "https://image.tmdb.org/t/p/w500"

// Создание юрл-запроса, получения и декодирование данных с сайта

func loadFilmsInfo() {

    let stringUrl = "https://api.themoviedb.org/3/discover/movie?api_key=913cb0dacf3fb9f137f999920947bf24&language=ru-RU&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
    
    guard let url = URL(string: stringUrl) else { return }
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard error == nil else {
            print(error?.localizedDescription ?? "noDesc" )
            return
        }
        guard let data = data else { return }
        guard let filmInfo = try? JSONDecoder().decode(Results.self, from: data) else {
            print("Error: Can not find url")
            return
        }
        
        films = filmInfo.results
    }
    task.resume()
}



