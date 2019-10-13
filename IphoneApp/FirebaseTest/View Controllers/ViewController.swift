//
//  ViewController.swift
//  FirebaseTest
//
//  Created by Ashish on 11/09/19.
//  Copyright © 2019 AAS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signupTextField: UIButton!
    @IBOutlet weak var loginTextField: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
    }
    
    func setUpElements() {
        Utilities.styleFilledButton(signupTextField)
        Utilities.styleHollowButton(loginTextField)
    }

    
}

