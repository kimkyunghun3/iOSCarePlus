//
//  NewGameResponse.swift
//  iOSCarePlus
//
//  Created by Kyunghun Kim on 2020/12/16.
//

import Foundation

struct NewGameContent: Decodable {
    let formalName: String
    let heroBannerURL: String
    let screenshots: [NewGameScreenshot]
    
    enum CodingKeys: String, CodingKey {
        case formalName = "formal_name"
        case heroBannerURL = "hero_banner_url"
        case screenshots
    }
}

struct NewGameScreenshot: Decodable {
    let images: [NewGameScreenshotURL]
}

struct NewGameScreenshotURL: Decodable {
    let url: String
}

struct NewGameResponse: Decodable {
    var contents: [NewGameContent]
    let length: Int
    let offset: Int
    let total: Int
//    let screenshot: [NewGameScreenshot]
//    let url: String
}
