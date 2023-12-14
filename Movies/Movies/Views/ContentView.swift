//
//  ContentView.swift
//  Movies
//
//  Created by mohamad mostapha on 14/12/2023.
//

import SwiftUI

struct MoviesView: View {
    
    @StateObject var viewModel = MovieViewModel()
    @State var isPresent = false
    
    var body: some View {
        Group{
            switch viewModel.state {
                
            case .loading:
                ProgressView()
                
            case let .loaded(movies):
                list(of: movies)
                
            case let .error(error):
               MoviesErrorView(error: error)
            }
        }
        .navigationTitle("Upcoming Movies")
        .task {
            await viewModel.loadMovies()
        }
    }
    
    @ViewBuilder
    func MoviesErrorView(error: Error) -> some View {
        EmptyView()
                    .alert(isPresented: $isPresent) {
                        Alert(
                            title: Text("Seems like you got an error here"),
                            message: Text(error.localizedDescription),
                            primaryButton: .default(
                                Text("Try again?"),
                                action: {
                                    Task {
                                        await viewModel.loadMovies()
                                    }
                                    isPresent = false
                                }
                            ),
                            secondaryButton: .cancel()
                        )
                    }
    }
    
    @ViewBuilder
    func list(of movies: [Movie]) -> some View {
        if movies.isEmpty{
            Text("no upcoming movies")
        }
        else{
            List(movies){ movie in
                NavigationLink(destination: MovieDetailsView(movie: movie), label: {
                    HStack{
                        AsyncImage(url: movie.posterURL){ image in
                            image
                                .resizable()                            .aspectRatio(contentMode: .fit)
                                .cornerRadius(10)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        VStack(alignment: .leading){
                            
                            Text(movie.title)
                                .font(.title2)
                            Text(movie.overview)
                                .font(.callout)
                                .lineLimit(4)
                        }
                    }
                })
                
            }
        }
    }

}

#Preview {
    NavigationView{
        MoviesView()
    }
}
