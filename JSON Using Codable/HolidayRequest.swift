//
//  HolidayRequest.swift
//  JSON Using Codable
//
//  Created by Alan Silva on 24/09/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import Foundation

enum HolidayError: Error{
    case noDataAvailable
    case canNotProccessData
}


struct HolidayRequest {
    let resourceURL:URL
    let API_KEY = "d261dd1b50674b1be43d727ddd8c98428155ba33"
    
    init(countryCode:String){
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
        let resourceString = "https://calendarific.com/api/v2/holidays?api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
        
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
        
    }
    
    func getHolidays (completion: @escaping(Result<[HolidayDetail], HolidayError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let holidaysResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                let holidayDetails = holidaysResponse.response.holidays
                completion(.success(holidayDetails))
            }catch{
                completion(.failure(.canNotProccessData))
            }
            
        }
        
        dataTask.resume()
        
    }
    
    
}
