//
//  Product.swift
//  SongBook
//
//  Created by Ali Can Kayaaslan on 27.03.2023.
//

import Foundation

struct Product : Codable {
    let results : [ArtistResults]
}

struct ArtistResults : Codable {
    let trackName : String
    let artistName : String
    let artworkUrl60 : String
    let country : String
}
