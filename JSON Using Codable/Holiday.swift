//
//  Holiday.swift
//  JSON Using Codable
//
//  Created by Alan Silva on 24/09/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import Foundation

struct HolidayResponse: Decodable {
    var response: Holidays
}

struct Holidays: Decodable {
    var holidays:[HolidayDetail]
}

struct HolidayDetail:Decodable {
    var name: String
    var date: DateInfo
}

struct DateInfo:Decodable {
    var iso: String
}
