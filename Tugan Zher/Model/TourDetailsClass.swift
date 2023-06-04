//
//  TourDetailsClass.swift
//  Tugan Zher
//
//  Created by Beket Muratbek on 04.06.2023.
//

import Foundation
import ObjectiveC

struct TourDetails: Codable {
    var id: Int
    var name: String
    var description: String
//    var program: Bool
//    var type: String
    var places: String
//    var cost_per_person: Double
//    var departure_datetime: String
//    var arrival_datetime: String
//    var maximum_tourists_count: Int
//    var provider: Int
//    var departure_city: Int
//    var available_languages: [Int]
    
    enum CodingKeys: String, CodingKey {
            case id, name, description, places
    }
}


//JSON
//{
//    "id": 2,
//    "name": "Kolsay Lake",
//    "description": "Trip to Kolsay lake",
//    "program": null,
//    "type": "GROUP",
//    "places": "Kolsay",
//    "cost_per_person": 10000.0,
//    "departure_datetime": "2023-06-05T23:26:00+06:00",
//    "arrival_datetime": "2023-06-06T23:26:00+06:00",
//    "maximum_tourists_count": 4,
//    "provider": 1,
//    "departure_city": 1,
//    "available_languages": [
//        1,
//        2
//    ]
//}
