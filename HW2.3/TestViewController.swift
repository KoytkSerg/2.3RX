//
//  TestViewController.swift
//  HW2.3
//
//  Created by Sergii Kotyk on 22/9/21.
//

import UIKit
import Bond

class TestViewController: UIViewController {
    
    @IBOutlet weak var someButton: UIButton!
    @IBOutlet weak var someTextField: UITextField!
    @IBOutlet weak var someLabel: UILabel!
    
    var someValue1 = 0
    var someValue2 = Observable(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        someButton.reactive.tap
            .observeNext{
                self.someFunc()  //1
                self.someValue1 = self.someValue2.value //2
                self.someLabel.text = "\(self.someValue1)" //3
            }
        
        someTextField.reactive.text
            .observeNext{ text in
                self.someFunc() //4
                self.someValue1 = self.someValue2.value //5
                self.someLabel.text = text // 6 ну и любое действие которое будет ссылаться на функцию, переменную значение или свойство из TestViewController
            }
        
        someValue2.observeNext{ value in
            self.someValue1 = value // 7
        }
    }
    func someFunc(){
        print("Test")
    }
}
