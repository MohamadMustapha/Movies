//
//  MoviesService.swift
//  Movies
//
//  Created by mohamad mostapha on 14/12/2023.
//

import Foundation

class MoviesService {
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func getMovies() async throws -> [Movie]{
        let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let movies = try jsonDecoder.decode(MovieResponse.self, from: data)
        
        return movies.results
    }
}
