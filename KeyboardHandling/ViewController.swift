//
//  ViewController.swift
//  KeyboardHandling
//
//  Created by Tsering Lama on 2/3/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pursuitLogo: UIImageView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var pursuitCenterYConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyBoardNotifications()
    }
    
    private func registerForKeyBoardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterForKeyBoardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?["UIKeyboardFrameBeginUserInfoKey"] as? CGRect else {
            return
        }
        print(keyboardFrame)
        moveKeyboardUp(height: keyboardFrame.size.height)
    }
    
    @objc
    private func keyboardWillHide(notification: NSNotification) {
        print("willHide")
        print(notification.userInfo)
    }
    
    private func moveKeyboardUp(height: CGFloat) {
       pursuitCenterYConstraint.constant -= height
    }


}

