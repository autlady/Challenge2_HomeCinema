//
//  FilmActorsData.swift
//  Challenge2_HomeCinema
//
//  Created by Roman Smiyan on 03.06.2022.
//

import Foundation

struct FilmActorsData: Codable {
    var id: Int
    var cast: [Cast]
}

struct Cast: Codable {
    var id: Int
    var name: String
    var original_name: String
    var profile_path: String?
    var profile_photo: String {
        guard let profile_path = profile_path else { return "" }
        return "https://image.tmdb.org/t/p/w200" + profile_path
    }
    //var profile_path: String?
    var character: String
}
