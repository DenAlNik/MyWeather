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

final class WeatherManager {
    private var nameCity: String = "Москва"
    static let shared = WeatherManager()
    func fetchWeather(completion: @escaping (currentStateOfWeather) -> Void) {
        let urlString = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/" + nameCity + "?unitGroup=metric&elements=name%2Ctemp%2Cwindspeed%2Cwinddir%2Cconditions&include=current&key=VGLFY6BKKEJ4G8FFTYL3MLH9P&contentType=json"
        guard let url = URL(string: urlString) else {return}
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            if let error = error {
                print("ERROR1: \(String(describing: error.localizedDescription))")
                return
            }
            if let weatherData = try? JSONDecoder().decode(currentStateOfWeather.self, from: data) {
                completion(weatherData)
            } else {
                print("NOT FIND")
            }
        }
            task.resume()
    }
    func setNameCity(newName: String) {
        self.nameCity = newName
    }
    func getNameCity() -> String {
        return self.nameCity
    }
}
