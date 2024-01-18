//
//  TrendingMovieCard.swift
//  Movies
//
//  Created by Mohamad Mustapha on 18/01/2024.
//
import Foundation
import SwiftUI

struct TrendingMovieCard: View {

    let trendingItem: Movie

    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: trendingItem.backdropURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 240)
            } placeholder: {
                ProgressView()
            }

            VStack {
                HStack {
                    Text(trendingItem.title)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
                HStack {
                    Image(systemName: "hand.thumbsup.fill")
                    Text(String(format: "%.1f", trendingItem.voteAverage))
                    Spacer()
                }
                .foregroundColor(.yellow)
                .fontWeight(.heavy)
            }
            .padding()
            .background(Color.trendingCardbackground)
        }
        .cornerRadius(10)
    }
}
#Preview {
    TrendingMovieCard(trendingItem: Movie.mock)
}
