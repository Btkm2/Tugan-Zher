//
//  CountryClass.swift
//  Tugan Zher
//
//  Created by Beket Muratbek on 08.06.2023.
//

import Foundation

struct Country: Codable, Hashable, Identifiable {
    var id: Int
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}
