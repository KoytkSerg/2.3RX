//
//  BViewController.swift
//  HW2.3
//
//  Created by Sergii Kotyk on 14/9/21.
//
// b) Текстовое поле для ввода поисковой строки. Реализуйте симуляцию «отложенного» серверного запроса при вводе текста: если не было внесено никаких изменений в текстовое поле в течение 0,5 секунд, то в консоль должно выводиться: «Отправка запроса для <введенный текст в текстовое поле>».
import UIKit
import Bond

class BViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.reactive.text
            .ignoreNils()
            .filter({ $0.count != 0})
            .debounce(for: 0.5)
            .observeNext {[unowned self] e in
                print("Отправка запроса для \(self.searchTextField.text!)")
            }

        
    }
    

}
