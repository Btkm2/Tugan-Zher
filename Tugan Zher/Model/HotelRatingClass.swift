//
//  HotelRatingClass.swift
//  Tugan Zher
//
//  Created by Beket Muratbek on 04.06.2023.
//

import Foundation


struct HotelRating: Codable {
    var id :Int
    var points: Double
    var hotel: Int
    var client: Int
}
