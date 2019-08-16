//
//  Movie.swift
//  MovieDatabase
//
//  Created by Apps on 8/16/19.
//  Copyright © 2019 Apps. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let title: String
    let rating: Double
    let summary: String
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case rating = "vote_average"
        case summary = "overview"
        case imageURL = "backdrop_path"
    }
}

struct MovieTopLevelDictionary: Codable {
    let results: [Movie]
}
