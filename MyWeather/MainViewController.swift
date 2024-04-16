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
    private let textFieldInfoLabel = UILabel()
    private let textField = UITextField()
    private let findButton = UIButton(configuration: .filled())
    private let temporaryLabel = UILabel()
    
    private let weatherManager = WeatherManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        setup()
        addTapGestureToHideKeyboard()
        textField.delegate = self
        registerForKeyboardNotifications()
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
    
    private func setup() {
        view.backgroundColor = .systemGray6
        title = tabBarItem.title
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "slider.horizontal.2.square"),
            style: .plain,
            target: self,
            action: #selector(didSettingsButtonTapped))
        
        
        
        [cardView, textField, textFieldInfoLabel, findButton, temporaryLabel].forEach {
            view.addSubview($0)
        }
        [cityLabel, tempLabel, windSpeedLabel, windSideLabel, typeOfWeatherLabel].forEach {
            cardView.addSubview($0)
            $0.font = UIFont.systemFont(ofSize: 16)
        }
        
        cardView.backgroundColor = .systemBackground
        cardView.layer.cornerRadius = 8
        
        cityLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        cityLabel.numberOfLines = 0
        cityLabel.lineBreakMode = .byWordWrapping
       
        textFieldInfoLabel.text = "Найти погоду"
        textFieldInfoLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        textField.placeholder = "Введите название города"
        textField.backgroundColor = .systemBackground
        textField.leftViewMode = .always
        textField.leftView = UIView(frame:CGRect(x:0, y:0, width: 10, height: 0))
        textField.layer.cornerRadius = 8
        
        findButton.setTitle("Найти", for: .normal)
        findButton.addTarget(self, action: #selector(didFindButtonTapped), for: .touchUpInside)
        
        temporaryLabel.text = "Скоро здесь появится прогноз погоды на 10 дней в качестве UICollectionView со скроллом в этой области"
        temporaryLabel.numberOfLines = 0
        temporaryLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        temporaryLabel.textAlignment = .center
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
            .height(180)
        cityLabel.pin
            .top(12)
            .left(20)
            .maxWidth(view.frame.width - 80)
            .minHeight(60)
            .sizeToFit(.width)
        windSideLabel.pin
            .bottom(12)
            .left(20)
            .sizeToFit()
        windSpeedLabel.pin
            .above(of: windSideLabel)
            .marginBottom(4)
            .left(20)
            .sizeToFit()
        tempLabel.pin
            .above(of: windSpeedLabel)
            .marginBottom(4)
            .left(20)
            .sizeToFit()
        typeOfWeatherLabel.pin
            .above(of: tempLabel)
            .marginBottom(4)
            .left(20)
            .sizeToFit()
        temporaryLabel.pin
            .below(of: cardView)
            .marginTop(20)
            .width(of: cardView)
            .sizeToFit(.width)
            .hCenter()
        findButton.pin
            .bottom(view.pin.safeArea.bottom + 20)
            .width(of: cardView)
            .height(36)
            .horizontally(20)
        textField.pin
            .above(of: findButton)
            .width(of: cardView)
            .height(36)
            .horizontally(20)
            .marginBottom(12)
        textFieldInfoLabel.pin
            .above(of: textField)
            .sizeToFit()
            .marginBottom(8)
            .hCenter()


    }
    
    @objc
    private func didSettingsButtonTapped() {
        
    }
    
    @objc
    private func didFindButtonTapped() {
        guard let text = self.textField.text else { return }
        WeatherManager.shared.setNameCity(newName: text)
        loadData()
        self.view.endEditing(true)
    }
}

extension MainViewController: UITextFieldDelegate {
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = self.textField.text else { return false }
        WeatherManager.shared.setNameCity(newName: text)
        loadData()
        self.view.endEditing(true)
        return false
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbShow), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(kbHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func kbShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - (tabBarController?.tabBar.frame.height ?? 0)
            }
        }
    }
    @objc
    func kbHide() {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}


