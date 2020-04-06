//
//  MediaType.swift
//  ITuneContentFetch
//
//  Created by Bharatraj Rai on 4/3/20.
//  Copyright © 2020 Bharatraj Rai. All rights reserved.
//

import Foundation

/**
 MediaType lists the various media which would help in filter the catalog response data and dispay the section header.

*/

enum MediaType: String {
    case Book = "book"
    case Album = "album"
    case Coached_audio = "coached-audio"
    case Feature_movie = "feature-movie"
    case Interactive_booklet = "interactive-booklet"
    case Music_video = "music-video"
    case Pdf_podcast = "pdf podcast"
    case Podcast_episode = "podcast-episode"
    case Software_package = "software-package"
    case Song = "song"
    case Tv_episode = "tv-episode"
    case ArtistFor = "artistFor"
}
