//
//  LoginViewController.swift
//  ExerciseTracker
//
//  Created by Maya Itty on 6/28/20.
//  Copyright © 2020 Maya Itty. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessage.alpha = 0
        // Do any additional setup after loading the view.
    }

    
    @IBOutlet var emailEntry: UITextField!
    @IBOutlet var passwordEntry: UITextField!
    @IBOutlet var errorMessage: UILabel!
    
    @IBAction func login(_ sender: UIButton) {
        
        let email = emailEntry.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordEntry.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().signIn(withEmail: email, password: password) {
            (result, error) in
            if error != nil {
                self.errorMessage.text = error!.localizedDescription
                self.errorMessage.alpha = 1
            }
            else {
                let homeViewController = self.storyboard?.instantiateViewController(identifier: "HomeVC") as? ExerciseListScreenTableViewController
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
    }
    
    @IBAction func signInWithGoogle(_ sender: UIButton) {
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
