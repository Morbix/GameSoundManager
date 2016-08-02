//
//  ViewController.swift
//  GameSoundManager
//
//  Created by Henrique Morbin on 08/01/2016.
//  Copyright (c) 2016 Henrique Morbin. All rights reserved.
//

import UIKit
import GameSoundManager

class ViewController: UIViewController {

    let identifier = "bubble_sound"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GameSound.shared.addSound(identifier, path: "bubble", type: "wav")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func hitMeTouched(sender: AnyObject) {
        GameSound.shared.playSound(identifier)
    }
}

