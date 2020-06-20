//
//  WeatherModel.swift
//  Clima
//
//  Created by Ana Lucia Blanco on 18/06/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

/*
    We created this file with a struct named WeatherModel so we can filter our
    data coming from the OpenWeather API.
 */
struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    var conditionName: String {
        switch conditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
}
