//
//  AuthViewController.swift
//  vkFeed
//
//  Created by  Евгений on 26/05/2019.
//  Copyright © 2019 LosAnatoly Inc. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    private var authService: AuthService!

    override func viewDidLoad() {
        super.viewDidLoad()
        //authService = AuthService()
        // Do any additional setup after loading the view.
        authService = AppDelegate.shared().authService
    }
    


    @IBAction func signInTouch() {
        authService.wakeUpSession()
    }
    
}
