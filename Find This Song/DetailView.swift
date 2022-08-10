//
//  DetailView.swift
//  Find This Song
//
//  Created by Bartosz Klimek on 10/08/2022.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.colorScheme) var colorScheme
    var hit: Hit
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack (alignment: .leading) {
                Group {
                    AsyncImage(url: URL(string: hit.result.songArtImageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ZStack {
                            Rectangle()
                                .fill(.regularMaterial)
                                .frame(width: 320, height: 340)
                            ProgressView()
                        }
                    }
                    
                    Text(hit.result.fullTitle)
                        .multilineTextAlignment(.leading)
                        .font(.headline)
                    
                    Divider()
                        .background(.gray)
                    ScrollView (.horizontal) {
                        HStack {
                            NavigationLink {
                                WebView(url: URL(string: hit.result.primaryArtist.url)!)
                            } label: {
                                ArtistWidget(primaryArtist: hit.result.primaryArtist)
                            }
                        }
                    }
                    Divider()
                        .background(.gray)
                    
                    
                    if !hit.result.featuredArtists.isEmpty {
                        Text("Featured artists")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(hit.result.featuredArtists, id: \.url) { artist in
                                    NavigationLink{
                                        WebView(url: URL(string: artist.url)!)
                                    } label: {
                                        ArtistWidget(primaryArtist: artist)
                                    }
                                }
                            }
                        }
                        Divider()
                            .background(.gray)
                    }
                }
                
                Group {
                    NavigationLink{
                        WebView(url: URL(string: hit.result.url)!)
                    }label:{
                        
                        HStack {
                            Spacer()
                            Text("View Lyrics")
                                .foregroundColor(colorScheme == .light ? .white : .black)
                                .padding(.vertical)
                            Spacer()
                        }
                        .background(
                            Rectangle()
                                .fill(colorScheme == .light ? .black : .white)
                        )
                        .padding(.top, 5)
                        .padding(.bottom)
                        
                        
                    }
                }
                
                
            }
            .padding(.horizontal)
        }
    }
}

struct ArtistWidget: View {
    var primaryArtist: Artist
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: primaryArtist.imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70)
                    .clipShape(Circle())
                
            } placeholder: {
                ZStack {
                    Rectangle()
                        .fill(.regularMaterial)
                        .frame(width: 70, height: 70)
                    ProgressView()
                }
            }
            Spacer()
            Text(primaryArtist.name)
                .font(.headline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.trailing)
        }
    }
}
