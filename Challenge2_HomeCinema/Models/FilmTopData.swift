//
//  FilmTopData.swift
//  Challenge2_HomeCinema
//
//  Created by Roman Smiyan on 04.06.2022.
//

import Foundation

struct FilmTopData: Codable {
    var page: Int
    var results: [Films]
}

struct Films: Codable {
    var id: Int
    var title: String
    var release_date: String
    var poster: String {
        guard let poster_path = poster_path else { return "" }
        return "https://image.tmdb.org/t/p/w400" + poster_path
    }
    var poster_path: String?
}
