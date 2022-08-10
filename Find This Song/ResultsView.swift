//
//  ResultsView.swift
//  Find This Song
//
//  Created by Bartosz Klimek on 10/08/2022.
//

import SwiftUI

struct ResultsView: View {
    var searchText: String
    @State private var hits: [Hit] = []
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(hits, id: \.result.id) { hit in
                
                NavigationLink {
                    DetailView(hit: hit)
                } label: {
                    HStack(alignment: .top) {
                        AsyncImage(url: URL(string: hit.result.songArtImageUrl)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70)
                            
                        } placeholder: {
                            ZStack {
                                Rectangle()
                                    .fill(.regularMaterial)
                                    .frame(width: 70, height: 70)
                                ProgressView()
                            }
                        }
                        VStack(alignment: .leading) {
                            Text(hit.result.fullTitle)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(colorScheme == .light ? .black : .white)
                            Text(hit.result.artistNames)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                }
                
                Divider()
                    .background(.gray)
            }
        }
        .padding(.horizontal)
        .task {
            print("https://api.genius.com/search?q=\(searchText)&access_token=g3_p-U6Eke_wc74uxbMZAkI8MoHFE1jBwcKJ_UT5-_VKpNJsn2AbAqRpAKiGiuwB")
            await getSearchedData()
        }
        .navigationTitle("Results")
        .navigationBarTitleDisplayMode(.inline)
    }
    func getSearchedData() async {
        guard let url = URL(string: "https://api.genius.com/search?q=\(searchText)&access_token=g3_p-U6Eke_wc74uxbMZAkI8MoHFE1jBwcKJ_UT5-_VKpNJsn2AbAqRpAKiGiuwB") else {
            print("Invalid url")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            if let decodedData = try? decoder.decode(DataModel.self, from: data) {
                hits = decodedData.response.hits
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(searchText: "")
    }
}
