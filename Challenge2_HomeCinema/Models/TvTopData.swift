//
//  TvTopData.swift
//  Challenge2_HomeCinema
//
//  Created by Roman Smiyan on 05.06.2022.
//

import Foundation

struct TvTopData: Codable {
    var page: Int
    var results: [TopTV]
}

struct TopTV: Codable {
    var id: Int
    var name: String
    var overview: String
    var first_air_date: String
    var poster: String {
        guard let poster_path = poster_path else { return "" }
        return "https://image.tmdb.org/t/p/w400" + poster_path
    }
    var poster_path: String?
}
