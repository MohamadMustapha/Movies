//
//  ContentView.swift
//  Movies
//
//  Created by mohamad mostapha on 14/12/2023.
//

import SwiftUI

struct MoviesView: View {
    
    @StateObject var trendingViewModel = MovieViewModel()
    @State var searchText = ""
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                if searchText.isEmpty {
                    SearchedResultsView(searchResult: $trendingViewModel.searchResults)
                }
                else{
                    Group {
                        switch trendingViewModel.state {
                        case .loading:
                            ProgressView()
                            
                        case let .loaded(movies):
                            trendingCarousel(of: movies)
                            
                        case .error:
                            Text("An error occurred")
                                .foregroundColor(.red)
                                .padding()
                        }
                        
                        switch trendingViewModel.cinemaState {
                        case .loading:
                            ProgressView()
                            
                        case let .loaded(movies):
                            cinemaCarousel(of: movies)
                            
                        case .error:
                            Text("An error occurred")
                                .foregroundColor(.red)
                                .padding()
                        }
                    }
                }
            }
            .background(Color.appBackground)
        }
        .searchable(text: $searchText)
        .onChange(of: searchText) { newValue in
            if newValue.count > 2 {
                Task {
                    await trendingViewModel.search(key: newValue)
                }
            }
        }

        .task {
            await trendingViewModel.loadTrendingMovies()
            await trendingViewModel.loadInCinemaMovies()
        }
    }
    
    @ViewBuilder
    func trendingCarousel(of movies: [Movie]) -> some View {
        if movies.isEmpty {
            Text("No trending movies")
        } else {
            HStack {
                Text("Trending")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                Spacer()
            }
            .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(movies) { movie in
                        VStack {
                            TrendingMovieCard(trendingItem: movie)
                        }
                    }
                }
                .padding()
            }
        }
    }

    @ViewBuilder
    func cinemaCarousel(of movies: [Movie]) -> some View {
        if movies.isEmpty {
            Text("No cinema movies")
        } else {
            HStack {
                Text("In Cinema")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                Spacer()
            }
            .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(movies) { movie in
                        VStack {
                            TrendingMovieCard(trendingItem: movie)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

extension Color {
    
    static let trendingCardbackground = Color(red:61/255,green:61/255,blue:88/255)
    
    static let appBackground = Color(red:39/255,green:40/255,blue:59/255)
}

#Preview {
    NavigationView{
        MoviesView()
    }
}
