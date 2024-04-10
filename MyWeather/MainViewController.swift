//
//  ViewController.swift
//  MyWeather
//
//  Created by Александр Денисов on 10.04.2024.
//

import UIKit
import PinLayout

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    private func setup() {
        view.backgroundColor = .systemGray6
        title = tabBarItem.title
        

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
}

