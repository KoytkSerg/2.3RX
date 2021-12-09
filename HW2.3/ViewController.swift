//
//  ViewController.swift
//  HW2.3
//
//  Created by Sergii Kotyk on 14/9/21.
//

import UIKit
import Bond

//a) Два текстовых поля. Логин и пароль, под ними лейбл и ниже кнопка «Отправить». В лейбл выводится «некорректная почта», если введённая почта некорректна. Если почта корректна, но пароль меньше шести символов, выводится: «Слишком короткий пароль». В противном случае ничего не выводится. Кнопка «Отправить» активна, если введена корректная почта и пароль не менее шести символов.

class ViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var validLogin = Observable(false)
        var validPassword = Observable(false)
        
        sendButton.isEnabled = false
        
        func MailCheckFunc(_ value: String) -> Bool{
            // для удобного разсширения условий валидности почты
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: value)
        }
        
        func passwordCheckFunc(_ value: String) -> Bool{
            // для удобного разсширения условий валидности пароля
            value.count > 5
        }
        
        loginTextField.reactive.text
            .ignoreNils()
            .observeNext{ [unowned self] text in
                if text.count == 0 {self.infoLabel.text = "Введите логин(почту)"}
                if  MailCheckFunc(text) == true {
                    validLogin.value = true
                    if validPassword.value == false {self.infoLabel.text = "Введите пароль не меньше 6 символов"}
                    else { self.infoLabel.text = ""}
                }
                else{
                    validLogin.value = false
                    if text.count == 0 {self.infoLabel.text = "Введите логин(почту)"}
                    else {self.infoLabel.text = "Некорректная почта"}
                   }
            }

        passwordTextField.reactive.text
            .ignoreNils()
            .observeNext{ [unowned self] text in
                if passwordCheckFunc(text) == true {
                    validPassword.value = true
                    if validLogin.value == true{
                       self.infoLabel.text = ""
                       }
                }
                else {
                    validPassword.value = false
                    if validLogin.value == true{
                       self.infoLabel.text = "Введите пароль не меньше 6 символов"
                       }
                   }
            }

        validLogin.combineLatest(with: validPassword)
            .map({ $0 == true && $1 == true ? true : false})
            .observeNext { [unowned self] value in
                self.sendButton.isEnabled = value
                print(validPassword.value , validLogin.value)
            }
    }
}

