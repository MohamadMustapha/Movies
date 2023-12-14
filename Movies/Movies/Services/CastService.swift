//
//  CastService.swift
//  Movies
//
//  Created by mohamad mostapha on 14/12/2023.
//

import Foundation

class CastService {
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func getCast(of movie: Movie) async throws -> [Cast] {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)/credits?api_key=\(apiKey)")!

        let (data, _) = try await URLSession.shared.data(from: url)

        let decoded = try jsonDecoder.decode(CastResponse.self, from: data)

        return decoded.cast
    }
    
}
