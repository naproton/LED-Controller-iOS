//
//  ViewController.swift
//  LED Controller
//
//  Created by Nick Protonentis on 3/24/20.
//  Copyright © 2020 Nick Protonentis. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    //connect buttons to view controller
    @IBOutlet weak var wifiBtn: UIButton!
    @IBOutlet weak var bLEBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //round edges of buttons and add black border
        wifiBtn.layer.borderColor = UIColor.black.cgColor
        wifiBtn.layer.borderWidth = 2
        wifiBtn.layer.cornerRadius = 100
        
        bLEBtn.layer.borderColor = UIColor.black.cgColor
        bLEBtn.layer.borderWidth = 2
        bLEBtn.layer.cornerRadius = 100
        
        
    }


}

