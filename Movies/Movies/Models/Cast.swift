//
//  Cast.swift
//  Movies
//
//  Created by mohamad mostapha on 14/12/2023.
//

import Foundation

struct CastResponse: Decodable{
    let cast: [Cast]
}

struct Cast: Decodable, Identifiable{
    let id: Int
    let name: String
    let character: String
    let profilePath: String
    var profileURL: URL? {
        URL(string: "https://image.tmdb.org/t/p/w400/\(profilePath)")
    }
}
