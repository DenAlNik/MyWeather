//
//  ViewController.swift
//  MyWeather
//
//  Created by Александр Денисов on 10.04.2024.
//

import UIKit
import PinLayout

class MainViewController: UIViewController {
    private let cityLabel = UILabel()
    private let tempLabel = UILabel()
    private let windSpeedLabel = UILabel()
    private let windSideLabel = UILabel()
    private let typeOfWeatherLabel = UILabel()
    private let cardView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        setup()
    }
    
    
    private func setup() {
        view.backgroundColor = .systemGray6
        title = tabBarItem.title
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
            $0.font = UIFont.systemFont(ofSize: 15)
        }
        
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 8
        
        cityLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        cityLabel.numberOfLines = 0
        cityLabel.lineBreakMode = .byWordWrapping
       
    }
    
    private func loadData() {
        WeatherManager.shared.fetchWeather { [weak self] weatherData in
            DispatchQueue.main.async {
                guard let self else { return }
                self.cityLabel.text = weatherData.resolvedAddress
                self.tempLabel.text = "Температура: \(weatherData.currentConditions.temp) C˚"
                self.windSpeedLabel.text = "Скорость ветра: \(weatherData.currentConditions.windspeed) м/с"
                self.windSideLabel.text = "Направление ветра: \(weatherData.currentConditions.winddir)"
                self.typeOfWeatherLabel.text = "Состояние погоды: " + weatherData.currentConditions.conditions
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cardView.pin
            .top(view.pin.safeArea.top + 12)
            .horizontally(view.pin.safeArea + 20)
            .width(view.frame.width - 40)
            //.sizeToFit(.heightFlexible)
            //.sizeToFit()
            //.height(400)
            
        cityLabel.pin
            .top(12)
            .left(20)
            .maxWidth(view.frame.width - 80)
            .sizeToFit(.width)
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
        cardView.pin
            .height(cityLabel.frame.height + 120)
    }
    
    @objc
    private func didSettingsButtonTapped() {
        
    }
}

