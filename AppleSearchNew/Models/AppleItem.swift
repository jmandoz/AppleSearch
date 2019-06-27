//
//  AppleItem.swift
//  AppleSearchNew
//
//  Created by Jason Mandozzi on 6/27/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

import Foundation

struct TopLevelJson: Codable {
    let results: [AppleItem]
}

struct AppleItem: Codable {
    let album: String
    let artist: String
    let track: String
    let imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case track = "trackName"
        case artist = "artistName"
        case album = "collectionName"
        case imageURL = "artworkUrl30"
    }
}
