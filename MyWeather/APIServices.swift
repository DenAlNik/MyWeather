//
//  APIServices.swift
//  MyWeather
//
//  Created by Александр Денисов on 11.04.2024.
//
//e721d68acfa85590809be07883665271

import Foundation

struct currentStateOfWeather: Codable {
    
    struct CurrentConditions: Codable {
        //let datetimeEpoch: Int
        let temp: Float
        let windspeed: Float
        let winddir: Int
        let conditions: String
    }
    
    let resolvedAddress: String
    let currentConditions: CurrentConditions
}

var nameCity: String = "London"

class WeatherManager {
    
    static let shared = WeatherManager()
    
    let urlString = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/" + nameCity + "?unitGroup=metric&elements=name%2Ctemp%2Cwindspeed%2Cwinddir%2Cconditions&include=current&key=VGLFY6BKKEJ4G8FFTYL3MLH9P&contentType=json"
    
    func fetchWeather(completion: @escaping (currentStateOfWeather) -> Void) {
        
        guard let url = URL(string: urlString) else {return}
        var request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
      
            guard let data = data else { return }
            
            if let error = error {
                print("ERROR1: \(String(describing: error.localizedDescription))")
                return
            }
            
            if let weatherData = try? JSONDecoder().decode(currentStateOfWeather.self, from: data) {
                completion(weatherData)
            } else {
                print("Error some")
            }
            
//            do {
//                let dataCurrent = try JSONDecoder().decode(currentStateOfWeather.self, from: data)
//                DispatchQueue.main.async {
//                    
//                }
//            } catch {
//                print("ERROR2: \(error.localizedDescription)")
//            }
        }
            task.resume()
    }
    
}
