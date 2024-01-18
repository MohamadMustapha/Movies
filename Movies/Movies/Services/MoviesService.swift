import Foundation

protocol MovieServiceProtocol {
    func getMovies() async throws -> [Movie]
}

public let jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()

class TrendingMoviesService: MovieServiceProtocol {
    
    func getMovies() async throws -> [Movie] {
        let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let movies = try jsonDecoder.decode(MovieResponse.self, from: data)
        
        return movies.results
    }
    
    func search(term: String) async throws -> [Movie] {
        let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=en-US&page=1&include_adult=false&query=\(term)".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)!

        let (data, _) = try await URLSession.shared.data(from: url)
        
        let movie = try jsonDecoder.decode(MovieResponse.self, from: data)

        return movie.results
    }
}

class CinemaService: MovieServiceProtocol {
    
    func getMovies() async throws -> [Movie] {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let movies = try jsonDecoder.decode(MovieResponse.self, from: data)
        
        return movies.results
    }
}

