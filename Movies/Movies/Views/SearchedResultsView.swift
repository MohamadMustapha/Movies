//
//  SearchedResultsView.swift
//  Movies
//
//  Created by Mohamad Mustapha on 19/01/2024.
//

import SwiftUI

struct SearchedResultsView: View {
    @Binding var searchResult: [Movie]
    
    var body: some View {
        LazyVStack() {
            ForEach($searchResult) { item in
                HStack {
                    AsyncImage(url: item.backdropURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 120)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 80, height: 120)
                    }
                    .clipped()
                    .cornerRadius(10)
                    
                    VStack(alignment:.leading) {
                        Text(item.title)
                            .foregroundColor(.white)
                            .font(.headline)
                        
                        HStack {
                            Image(systemName: "hand.thumbsup.fill")
                            Text(String(format: "%.1f", item.vote_average))
                            Spacer()
                        }
                        .foregroundColor(.yellow)
                        .fontWeight(.heavy)
                    }
                    Spacer()
                }
                .padding()
                .background(Color(red:61/255,green:61/255,blue:88/255))
                .cornerRadius(20)
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    SearchedResultsView(searchResult: )
}
