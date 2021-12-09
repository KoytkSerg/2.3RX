//
//  EViewController.swift
//  HW2.3
//
//  Created by Sergii Kotyk on 14/9/21.

// e) Две кнопки и лейбл. Когда на каждую кнопку нажали хотя бы один раз, в лейбл выводится: «Ракета запущена».

import UIKit
import Bond

class EViewController: UIViewController {

    @IBOutlet weak var launchLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var button1Pressed = Observable(false)
        var button2Pressed = Observable(false)
        button1.reactive.tap
            .observeNext{ button1Pressed.value = true }
        button2.reactive.tap
            .observeNext{ button2Pressed.value = true}
        
        button1Pressed.combineLatest(with: button2Pressed)
            .map({ $0 == true && $1 == true ? "Запускаю ракету" : ""})
            .bind(to: launchLabel.reactive.text)
        

       
    }
    

   
}
