//
//  SearchResultModel.swift
//  WeatherApp
//
//  Created by Guglielmo Chimera on 13/06/22.
//

import Foundation

struct SearchResultModel: Codable {
    let country : String?
    let lat : Float?
    let localNames : LocalName?
    let lon : Float?
    let name : String?
    let state : String?
    
    
    enum CodingKeys: String, CodingKey {
        case country = "country"
        case lat = "lat"
        case localNames
        case lon = "lon"
        case name = "name"
        case state = "state"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        lat = try values.decodeIfPresent(Float.self, forKey: .lat)
        localNames = try LocalName(from: decoder)
        lon = try values.decodeIfPresent(Float.self, forKey: .lon)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        state = try values.decodeIfPresent(String.self, forKey: .state)
    }
    
    
}

struct LocalName : Codable {

    let ar : String?
    let en : String?
    let fr : String?
    let ko : String?
    let ru : String?
    let uk : String?


    enum CodingKeys: String, CodingKey {
        case ar = "ar"
        case en = "en"
        case fr = "fr"
        case ko = "ko"
        case ru = "ru"
        case uk = "uk"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ar = try values.decodeIfPresent(String.self, forKey: .ar)
        en = try values.decodeIfPresent(String.self, forKey: .en)
        fr = try values.decodeIfPresent(String.self, forKey: .fr)
        ko = try values.decodeIfPresent(String.self, forKey: .ko)
        ru = try values.decodeIfPresent(String.self, forKey: .ru)
        uk = try values.decodeIfPresent(String.self, forKey: .uk)
    }


}
