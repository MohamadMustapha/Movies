import Foundation

@MainActor
class MovieViewModel: ObservableObject {
    
    @Published var searchResults: [Movie] = []

    private let trendingService = TrendingMoviesService()
    private let inCinemaService = CinemaService()
    
    enum State {
        case loading
        case loaded(movies: [Movie])
        case error(Error)
    }
    
    @Published var state: State = .loading
    @Published var cinemaState: State = .loading
    
    func loadMovies(service: MovieServiceProtocol, completion: @escaping (State) -> Void) async {
        do {
            
            let movies = try await service.getMovies()
            completion(.loaded(movies: movies))
        } catch {
            completion(.error(error))
        }
    }

    func loadTrendingMovies() async {
        await loadMovies(service: trendingService) { newState in
            self.state = newState
        }
    }

    func loadInCinemaMovies() async {
        await loadMovies(service: inCinemaService) { newState in
            self.cinemaState = newState
        }
    }
    
    func search(key: String) async -> [Movie] {
        searchResults =  try! await trendingService.search(term: key)
        return searchResults
    }

}
