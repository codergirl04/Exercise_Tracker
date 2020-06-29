//
//  SignUpViewController.swift
//  ExerciseTracker
//
//  Created by Maya Itty on 6/28/20.
//  Copyright © 2020 Maya Itty. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessage.alpha = 0
        // Do any additional setup after loading the view.
    }
    
    func isPasswordValid(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    @IBOutlet var firstNameEntry: UITextField!
    @IBOutlet var lastNameEntry: UITextField!
    @IBOutlet var emailEntry: UITextField!
    @IBOutlet var passwordEntry: UITextField!
    @IBOutlet var errorMessage: UILabel!
    
    @IBAction func signUp(_ sender: UIButton) {
        let error = validateFields()
        if error != nil {
            errorMessage.text = error!
            errorMessage.alpha = 1
        }
        else {
            let firstName = firstNameEntry.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameEntry.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailEntry.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordEntry.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    self.errorMessage.text = "Error creating user"
                    self.errorMessage.alpha = 1
                }
                else {
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstname": firstName, "lastname": lastName, "uid":result!.user.uid]) { (error) in
                        if err != nil {
                            self.errorMessage.text = "Error saving user data. You can still login with your email and password."
                            self.errorMessage.alpha = 1
                        }
                    }
                    
                    self.transitionToHome()
                }
                
            }
            
        }
    }
    
    func validateFields() -> String? {
        if firstNameEntry.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameEntry.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailEntry.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordEntry.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        let cleanedPassword = passwordEntry.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isPasswordValid(cleanedPassword) == false {
            return "Please make sure your password is at least 8 characters and contains a special character and a number."
        }
        return nil
    }
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: "HomeVC") as? ExerciseListScreenTableViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
}
