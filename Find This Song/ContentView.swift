//
//  ContentView.swift
//  Find This Song
//
//  Created by Bartosz Klimek on 10/08/2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var searchText = ""
    var searchPhraseWithoutSpaces: String {
        searchText.replacingOccurrences(of: " ", with: "%20")
    }
    
    var body: some View {
        NavigationView {
            
            
            
            VStack {
                HStack {
                    TextField("Search", text: $searchText)
                        .onTapGesture {
                            searchText = ""
                        }
                    NavigationLink{
                        ResultsView(searchText: searchPhraseWithoutSpaces)
                    }label:{
                        Image(systemName: "arrow.forward.circle.fill")
                            .foregroundColor(colorScheme == .light ? .black : .white)
                            .font(.system(size: 30))
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .fill(.regularMaterial)
                )
                
                
                .padding()
                Spacer()
            }
            .navigationTitle("Search song or artist")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
