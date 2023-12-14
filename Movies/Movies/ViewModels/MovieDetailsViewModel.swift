import Foundation

@MainActor
class MovieDetailsViewModel: ObservableObject {
    private let castService = CastService()
    
    enum State {
        case loading
        case loaded(cast: [Cast])
        case error(Error)
    }
    
    @Published var state: State = .loading
    
    func loadCast(for movie: Movie) async {
        do {
            state = .loading
            let cast = try await castService.getCast(of: movie)
            state = .loaded(cast: cast)
        } catch {
            state = .error(error)
        }
    }
}
