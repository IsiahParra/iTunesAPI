//
//  Track.swift
//  iTunesSearch
//
//  Created by Karl Pfister on 6/4/22.
//

import Foundation

struct TopLevelDictionaryTracks: Decodable {
    let results: [Track]
}

struct Track: Decodable {
    private enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case albumID = "collectionId"
        case kind
        case albumTitle = "collectionName"
        case trackTimeMillis
    }
    let title: String?
    let albumID: Int
    let kind: String?
    let albumTitle: String
    let trackTimeMillis: Int?
}
