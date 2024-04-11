//
//  ViewController.swift
//  MyWeather
//
//  Created by Александр Денисов on 10.04.2024.
//

import UIKit
import PinLayout

class MainViewController: UIViewController {
    private let currentCityWeather: StateOfWeather = StateOfWeather(city: "Moscow", temp: "+15", typeOfWeather: "sun", windSpeed: "10", windSide: "south")
    private let cityLabel = UILabel()
    private let tempLabel = UILabel()
    private let windSpeedLabel = UILabel()
    private let windSideLabel = UILabel()
    private let typeOfWeatherLabel = UILabel()
    private let cardView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    private func setup() {
        view.backgroundColor = .systemGray6
        title = tabBarItem.title
        //navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "slider.horizontal.2.square"),
            style: .plain,
            target: self,
            action: #selector(didSettingsButtonTapped))
        
        
        
        [cardView].forEach {
            view.addSubview($0)
        }
        [cityLabel, tempLabel, windSpeedLabel, windSideLabel, typeOfWeatherLabel].forEach {
            cardView.addSubview($0)
        }
        cardView.backgroundColor = .white
        cardView.frame = CGRect(x: 0, y: 0, width: Int(self.view.safeAreaLayoutGuide.layoutFrame.width), height: 168)
        cardView.layer.cornerRadius = 8
        setCurrent()
        cityLabel.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        
       
    }
    
    private func setCurrent() {
        self.cityLabel.text = currentCityWeather.city
        self.tempLabel.text = "Температура: " + currentCityWeather.temp + " C˚"
        self.windSpeedLabel.text = "Скорость ветра: " + currentCityWeather.windSpeed + " м/с"
        self.windSideLabel.text = "Направление ветра: " + currentCityWeather.windSide
        self.typeOfWeatherLabel.text = "Состояние погоды: " + currentCityWeather.typeOfWeather
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cardView.pin
            .top(view.pin.safeArea.top + 12)
            .horizontally(view.pin.safeArea + 20)
        cityLabel.pin
            .top(12)
            .left(20)
            .sizeToFit()
        typeOfWeatherLabel.pin
            .below(of: cityLabel)
            .marginTop(8)
            .left(20)
            .sizeToFit()
        tempLabel.pin
            .below(of: typeOfWeatherLabel)
            .marginTop(4)
            .left(20)
            .sizeToFit()
        windSpeedLabel.pin
            .below(of: tempLabel)
            .marginTop(4)
            .left(20)
            .sizeToFit()
        windSideLabel.pin
            .below(of: windSpeedLabel)
            .marginTop(4)
            .left(20)
            .sizeToFit()
    }
    
    @objc
    private func didSettingsButtonTapped() {
        
    }
}

