//
//  SignUpViewController.swift
//  FirebaseTest
//
//  Created by Joseph on 11/09/19.
//  Copyright © 2019 AAS. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstnameText: UITextField!
    @IBOutlet weak var lastnameText: UITextField!
    @IBOutlet weak var emailtext: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    func setUpElements(){
        errorLabel.alpha=0
        Utilities.styleFilledButton(signupButton)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func ValidateFields() -> String? {
        //check for filled in fields
        if firstnameText.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""{
            return "Please Fill in Fields"
        }
        if lastnameText.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""{
            return "Please Fill in Fields"
        }
        if emailtext.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""{
            return "Please Fill in Fields"
        }
        if passwordText.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""{
            return "Please Fill in Fields"
        }
        //check password
        let cleanedPassword=passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword)==false{
            return "Your password isn't secure,it  should have 8 characters, a special charcter and a number!"
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
    @IBAction func signupTapped(_ sender: Any) {
        //Validate
        let error=ValidateFields()
        if error != nil{
            showError(error!)
        }
        else{
        //Create
            // Create cleaned versions of the data
            let firstName = firstnameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastnameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailtext.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil{
                    self.showError("Error! Cannot create user")
                }
                else{
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid ]) { (error) in
                        
                        if error != nil {
                            // Show error message
                            self.showError("Error saving user data")
                        }
                    }
                    
                    // Transition to the home screen
                    self.transitionToHome()
                    
                }
            }
        //Transition
        }
    }
}
