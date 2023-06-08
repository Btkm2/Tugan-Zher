//
//  HotelClass.swift
//  Tugan Zher
//
//  Created by Beket Muratbek on 08.06.2023.
//

import Foundation

struct Hotel: Codable {
    var id: Int
    var name: String
    var description: String
//    var city: Int
//    var provider: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
    }
}
