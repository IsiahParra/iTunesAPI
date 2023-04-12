//
//  Album.swift
//  iTunesSearch
//
//  Created by Karl Pfister on 6/4/22.
//

import Foundation

struct TopLevelDictionaryAlbums: Decodable {
    let results: [Album]
}

struct Album: Decodable {
    private enum CodingKeys: String, CodingKey {
        case title = "collectionName"
        case trackCount
        case albumImagePath = "artworkUrl100"
        case albumID = "collectionId"
    }
    let title: String
    let trackCount: Int
    let albumImagePath: String?
    let albumID: Int
}
