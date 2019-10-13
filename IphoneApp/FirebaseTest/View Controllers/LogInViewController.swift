//
//  LogInViewController.swift
//  FirebaseTest
//
//  Created by Ashish on 11/09/19.
//  Copyright © 2019 AAS. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
        // Do any additional setup after loading the view.
    }
    func setUpElements() {
        errorLabel.alpha=0
        Utilities.styleFilledButton(loginButton)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func ValidateUser() -> String? {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""{
        return "Please Fill in Fields"
        }
        if passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""{
        return "Please Fill in Fields"
        }
    return nil
    }
    func showError(_ message:String){
        errorLabel.text=message
        errorLabel.alpha=1
    }
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    @IBAction func loginTapped(_ sender: Any) {
        //Validate
        let error=ValidateUser()
        if error != nil{
            showError(error!)
        }
        else{
            //Create
            // Create cleaned versions of the data
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
                if err != nil{
                    self.showError("Error! Cannot sign in")
                }
                else{
                    self.transitionToHome()
                    
                }
            }
            //Transition
        }
    }

}
