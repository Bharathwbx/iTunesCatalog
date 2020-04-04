//
//  ItunesResultModel.swift
//  ITuneContentFetch
//
//  Created by Bharatraj Rai on 4/3/20.
//  Copyright © 2020 Bharatraj Rai. All rights reserved.
//

import Foundation


struct ItunesResult: Codable {
    let resultCount: Int?
    var results: [ItunesMediaModel]?
}

struct ItunesMediaModel: Codable, Hashable {
    static func == (lhs: ItunesMediaModel, rhs: ItunesMediaModel) -> Bool {
        return lhs.trackId == rhs.trackId && lhs.primaryGenreName == rhs.primaryGenreName && lhs.trackName == rhs.trackName
    }
    
    let kind: String?
    let trackId: Int?
    let trackName: String?
    let artworkUrl100: String?
    let primaryGenreName: String?
    let trackViewUrl: String?
    let artistId: Int?
    var isFavorite: Bool?
}
