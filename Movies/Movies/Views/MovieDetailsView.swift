//
//  MovieDetailsView.swift
//  Movies
//
//  Created by mohamad mostapha on 14/12/2023.
//

import SwiftUI

struct MovieDetailsView: View {
    
    let movie: Movie
    @StateObject var viewModel = MovieDetailsViewModel()
    
    var body: some View {
        Group{
            switch viewModel.state {
                
            case .loading:
                ProgressView()
                
            case let .loaded(cast):
                list(of: cast)
                
            case let .error(error):
                VStack {
                    Text(error.localizedDescription)
                    
                    Button("Retry?") {
                        Task {
                            await viewModel.loadCast(for: movie)
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(movie.title)
        .toolbar {
            ShareLink(item: movie.posterURL!)
        }
        .task {
            await viewModel.loadCast(for: movie)
        }
    }
    @ViewBuilder
    func list(of cast: [Cast]) -> some View{
        List {
            Section {
                HStack(alignment: .top) {
                    AsyncImage(url: movie.posterURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 200)
                    
                    Text(movie.overview)
                        .lineLimit(4)
                    
                }
            }
            Section {
                    ForEach(cast) { actor in
                        HStack{
                            AsyncImage(url: actor.profileURL) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(10)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(height: 100)
                            VStack(alignment: .leading) {
                                Text(actor.character)
                                    .font(.title3)
                                Text(actor.name)
                                    .font(.caption)
                                    .italic()
                            }
                        }
                    }
                }
            }
        }
    }

#Preview {
    NavigationView{
        MovieDetailsView(movie: Movie.mock)
    }
}
