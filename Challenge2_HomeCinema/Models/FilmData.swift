//
//  FilmData.swift
//  Challenge2_HomeCinema
//
//  Created by Roman Smiyan on 03.06.2022.
//

import Foundation

struct FilmData: Codable {
    var id: Int
    var overview: String
    var title: String
    var poster : String {
        return "https://image.tmdb.org/t/p/w400" + poster_path
    }
    var poster_path: String
}
