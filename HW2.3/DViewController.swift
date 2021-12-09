//
//  DViewController.swift
//  HW2.3
//
//  Created by Sergii Kotyk on 14/9/21.
//d) Лейбл и кнопку. В лейбле выводится значение counter (по умолчанию 0), при нажатии counter увеличивается на 1.

import UIKit
import Bond

class DViewController: UIViewController {

    @IBOutlet weak var counterButton: UIButton!
    @IBOutlet weak var counterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var counter = Observable (0)
        counterButton.reactive.tap
            .observeNext { counter.value += 1}
        
        counter
            .map { "\($0)"}
            .bind(to: counterLabel.reactive.text)

    }
    

}
