//
//  DataModel.swift
//  Find This Song
//
//  Created by Bartosz Klimek on 10/08/2022.
//

import SwiftUI

struct DataModel: Codable {
    let response: Response
}

struct Response: Codable {
    let hits: [Hit]
}

struct Hit: Codable {
    let type: String
    let result: Result
}

struct Result: Codable {
    let artistNames: String
    let fullTitle: String
    let id: Int
    let songArtImageUrl: String
    let primaryArtist: Artist
    let featuredArtists: [Artist]
    let url: String
}

struct Artist: Codable {
    let imageUrl: String
    let name: String
    let url: String
}


