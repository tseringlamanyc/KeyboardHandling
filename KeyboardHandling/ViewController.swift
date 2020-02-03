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
        pulsateLogo()
        userName.delegate = self
        passWord.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyBoardNotifications()
    }
    
    private var isKeyboardThere = false
    
    private var originalState: NSLayoutConstraint!
    
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
        resetUI()
    }
    
    private func moveKeyboardUp(height: CGFloat) {
       if isKeyboardThere {return}
        originalState = pursuitCenterYConstraint
       isKeyboardThere = true
       pursuitCenterYConstraint.constant -= height
        
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func resetUI() {
        isKeyboardThere = false
        pursuitCenterYConstraint.constant -= originalState.constant
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func pulsateLogo() {
        UIView.animate(withDuration: 0.8, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            self.pursuitLogo.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: nil)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

