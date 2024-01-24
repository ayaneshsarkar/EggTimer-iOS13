//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let softTime: Int = 5
    let mediumTime: Int = 7
    let hardTime: Int = 12
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        if (sender.currentTitle == "Soft") {
            print("\(softTime)")
        } else if (sender.currentTitle == "Medium") {
            print("\(mediumTime)")
        } else if (sender.currentTitle == "Hard") {
            print("\(hardTime)")
        }
    }
    
}
