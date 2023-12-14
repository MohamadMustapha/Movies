//
//  MovieViewModel.swift
//  Movies
//
//  Created by mohamad mostapha on 14/12/2023.
//

import Foundation

@MainActor
class MovieViewModel: ObservableObject{
    
    private let service = MoviesService()
    
    enum State {
        case loading
        case loaded(movies: [Movie])
        case error(Error)
    }
    
    @Published var state: State = .loading

    func loadMovies() async {
        do{
            state = .loading
            let movies = try await service.getMovies()
            state = .loaded(movies: movies)
        }
        catch{
            state = .error(error)
        }
    }
    
}
