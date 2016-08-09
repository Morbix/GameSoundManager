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

        GameSound.shared.addSound(identifier, path: "bubble", type: "wav", loops: -1)
    }

    // MARK: Actions
    
    @IBAction func hitMeTouched(sender: AnyObject) {
        GameSound.shared.playSound(identifier)
    }
    
    @IBAction func stopTouched(sender: AnyObject) {
        GameSound.shared.stopSound(identifier)
    }
    
}

