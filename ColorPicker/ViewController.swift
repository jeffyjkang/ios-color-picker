//
//  ViewController.swift
//  ColorPicker
//
//  Created by Jeff Kang on 11/21/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func changeColor(_ sender: ColorPicker) {
        view.backgroundColor = sender.color
        
    }
    

}

