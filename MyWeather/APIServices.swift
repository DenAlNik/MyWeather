//
//  APIServices.swift
//  MyWeather
//
//  Created by Александр Денисов on 11.04.2024.
//
//e721d68acfa85590809be07883665271

import Foundation

struct StateOfWeather {
    let city: String
    let temp: String
    let typeOfWeather: String
    let windSpeed: String
    let windSide: String
  }


func fetchWeather(completionHandler: @escaping([StateOfWeather]) -> Void) {
    var weather: [StateOfWeather] = []
    
    completionHandler(weather)
}
