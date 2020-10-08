//
//  VenueModel.swift
//  Discover
//
//  Created by Natalija Krsnik on 29/09/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import Foundation

struct Venues: Decodable {
    var success: Bool
    var data: Data
    var _links: [String?]
    var _meta: [String?]
}

struct Data: Codable {
    var pickOfTheWeek: String?
    var venueCategories: [VenueCategories]
    var customPicks: [CustomPicks]
    var trending: [Trending]
}

struct VenueCategories: Codable {
    var id: Int
    var image: String
    var feeling_lucky: Int?
    var feelingLuckyData:[FeelingLuckyData]
    var smokingArea: SmokingArea
    var categoryAny: String
    var popularTags: [PopularTags]
    var gradient_color_start: String?
    var gradient_color_end: String?
    var name: String
    var feeling_lucky_title: String?
}

struct CustomPicks: Codable {
    var id: Int
    var order: Int
    var tags: [Tags]
    var type: String
    var items: [Trending]
    var title: String
}

struct Trending: Codable {
    var id: Int
    var subtitle: String
    var picture_url: String?
    var venue_categories:[TrendingVenuesCategory]?
    var primary_tag_group: String?
    var allTags: TagsNum
    var address: String
    var opened: Bool
    var web: String
    var telephone: String
    var share_link: String?
    var city: String
    var lat: Double
    var lon: Double
    var trending: Int
    var promoted: Int
    var bat: Int
    var has_qr_code: Int?
    var active: Int
    var smoking_area: Int?
    var working_hours: [WorkingHours]?
    var gallery: [Gallery]
    var type: String
    var name: String
    var description: String
}

struct FeelingLuckyData: Codable {
    var id: Int
    var tagGroup: TagGroup
    var order: Int
    var category_id: Int?
    var title: String
    var any_title: String?

}

struct SmokingArea: Codable {
    var title: String
    var answers: Answers
}

struct PopularTags: Codable {
    var tag: Tags
    var tags: Int
}

struct TagGroup: Codable {
    var id: Int
    var tags: [Tags]
    var name: String
}

struct Tags: Codable {
    var id: Int
    var color: String
    var tag_group_id: Int?
    var name: String
}

struct Answers: Codable {
    var zero: String?
    var one: String?
    var minusOne: String?
    enum CodingKeys: String, CodingKey {
        case zero  = "no"
        case one = "yes"
        case minusOne = "any"
    }
}

struct TrendingVenuesCategory: Codable {
    var id: Int
    var image: String
    var feelingLuckyData: [String?]
    var name: String
    var feeling_lucky_title: String?

}

struct WorkingHours: Codable {
    var id: Int
    var venue_id: Int?
    var day: Int
    var start: String
    var end: String
}

struct Gallery: Codable {
    var id: Int
    var venue_id: Int?
    var picture: String
    var created_at: Int?
    var updated_at: Int?
}

struct TagsNum: Codable {
    var primaryTags: [Tags]
    var secondaryTags: [Tags]
}
