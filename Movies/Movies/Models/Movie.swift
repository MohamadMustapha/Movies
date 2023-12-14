//
//  Movie.swift
//  Movies
//
//  Created by mohamad mostapha on 14/12/2023.
//

import Foundation

struct MovieResponse: Decodable{
    let results: [Movie]
}
struct Movie: Decodable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    var posterURL: URL? {
        URL(string: "https://image.tmdb.org/t/p/w400/\(posterPath)")
    }
}
extension Movie {
    static var mock: Movie {
        Movie(
            id: 507086,
            title: "Jurassic World Dominion",
            overview: "Four years after Isla Nublar was destroyed, dinosaurs now live—and hunt—alongside humans all over the world. This fragile balance will reshape the future and determine, once and for all, whether human beings are to remain the apex predators on a planet they now share with history’s most fearsome creatures.",
            posterPath: "/w4c0GTpmEQ1CZQNHndTv2PPgf2p.jpg"
        )
    }
}
