//
//  FlickrImage.swift
//  Zeo
//
//  Created by Umar Farooq on 10/04/25.
//



struct Images: Decodable {
    let items: [Image]
}

struct Image: Decodable {
    let title: String
    let media: MediaURL
}

struct MediaURL: Decodable {
    let url: String
    
    // Map the "m" key in JSON to our "url" property
    private enum CodingKeys: String, CodingKey {
        case url = "m"
    }
}

