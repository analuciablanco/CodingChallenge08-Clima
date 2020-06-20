//
//  WeatherManager.swift
//  Clima
//
//  Created by Ana Lucia Blanco on 17/06/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

/*
    Everytime we declare a protocol it should be where the main scruct is.
    We use protocols so they can be called (just like with the classes) but the
    functions we declare inside a protocol are mandatory.
    
    For example: our protocol named WeatherManagerDelegate has two functions
    called didUpdateWeather and didFailWithError, both recieve parameters
    but as a rule, functions in protocols does not have body so when we
    use them elsewhere we have the liberty to use them with their called parameters
    for the reason we may need them.
 */
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

/*
    We have our main struct named WeatherManager, which it could be seen as
    the main data manager (Model) of our app and send the results back to the Controller.
 */
struct WeatherManager {
    // Here we are declaring our API url as a String.
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=baffff0be4677def5deb44988cba97ac&units=metric"
    // Here we are calling the delegate to be used.
    var delegate: WeatherManagerDelegate?
    
    // Here we are taking the cityName value the user type which is sent from the Controller
    func fetchWeather(cityName: String) {
        // We take our initial weatherURL and concatenate it with our new value
        let urlString = "\(weatherURL)&q=\(cityName)"
        // Then we send it to our funtion to make the request
        performRequest(with: urlString)
    }
    
    func fetchWeather(lat latitude: Double, lon longitude: Double) {
        // We take our initial weatherURL and concatenate it with our new values
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        // Then we send it to our funtion to make the request
        performRequest(with: urlString)
    }
    
    // In this funtion we take the urlString sent before
    func performRequest(with urlString: String) {
        //1. Convert String to URL
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a task -- Using a closure
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                // If there is no error it skips this
                if error != nil {
                    // BUT if there is an actual error, it will send it to the delegate function
                    self.delegate?.didFailWithError(error: error!)
                    // We use return to make sure the function stops if there was actual an error
                    // so it won't continue to the next part
                    return
                }
                
                // In case there wasn't any errors and skiped the part before, it declares a safeData constant
                // This is just to validate there is data on it
                if let safeData = data {
                    // Then here we send the safeData to the function parseJSON
                    if let weather = self.parseJSON(safeData) {
                        //
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            })
            
            //4. Start the task
            task.resume()
        }
    }
    
    // Function called once we have our safeData
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        // It will need to be decoded so we can use the date on it
        // We declare a JSONDecoder constant to work it
        let decoder = JSONDecoder()
        // It is a MUST to use "do try catch" when we decode to safely know if something failed
        do {
            // The constant decodeData will have the decoded information form weatherData
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            // Then here we declare our constants taken from the decodedData
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            // And here we send our decoded data to the model to be used next
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            return weather
        
        } catch {
            // In case it didn't work, it will send the error to the delegate to be printed out
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
    
}
