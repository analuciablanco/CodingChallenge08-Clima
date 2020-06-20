//
//  WeatherData.swift
//  Clima
//
//  Created by Ana Lucia Blanco on 18/06/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

/*
    We created this file with a main struct named WeatherData to
    DECODE the JSON text we get when we call the right API url.
 
    This file can be seen as the converted swift version of the JSON file
    so the first struct named WeatherData is the main JSON body/request,
    inside of the sctruct we declare variables as the objects inside our JSON.
 
    Then, the following structs such as Main and Weather are the name
    of the objects which contain another variables we declare to
    take the value inside of them.
 
    Example: if we want to get the temperature we have to acces to the temp
    variable, so the path to it starts from the WeatherData struct, then call the
    main variable and finally call the temp. (WeatherData.main.temp)
 
    And in case our JSON object is an array, we declare it as such.
    So to call the id it would be like: (WeatherData.weather[0].id)
*/

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}
