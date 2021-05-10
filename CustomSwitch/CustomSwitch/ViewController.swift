//
//  ViewController.swift
//  CustomSwitch
//
//  Created by Alex on 5/10/21.
//  Copyright © 2021 AlexCo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var switchControl: CustomRectSwitch?
    private let bgOnState = UIColor(red: 0, green: 0.2, blue: 0, alpha: 1.0)
    private let bgOffState = UIColor(red: 0, green: 0, blue: 0.2, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func switchControlDidChange(_ sender: CustomRectSwitch) {
        if sender === switchControl {
            view.backgroundColor = sender.isOn ? bgOnState : bgOffState
        }
    }

}

