//
//  ViewController.swift
//  kazakh_filters
//
//  Created by Din Daniyarbekov on 2016-07-08.
//  Copyright © 2016 Din. All rights reserved.
//

import UIKit
import VK_ios_sdk


class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    
    @IBAction func vkLogin(sender: AnyObject) {
   VKSdk.authorize([VK_PER_EMAIL])
}
    let LoginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton ()
        button.readPermissions = ["email"]
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vkInstance = VKSdk.initializeWithAppId("5542787")
        vkInstance.registerDelegate(self)
        
        view.addSubview(LoginButton)
        LoginButton.center = view.center
        LoginButton.delegate = self
        
        if let token = FBSDKAccessToken.currentAccessToken() {
            fetchProfile ()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //VKSdk.authorize([VK_PER_EMAIL])
    }

    func fetchProfile() {
        print ("fetch profile")
        
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler { (connection, result, error) -> Void in
            
            if error != nil {
                print (error)
                return
            }
            
            if let email = result["email"] as? String {
                print (email)
            }
            
            if let picture = result["picture"] as? NSDictionary, data = picture["data"] as? NSDictionary, url = data ["url"] as? String {
                
                print(url)
            }
}
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print ("Completed Login")
        fetchProfile()
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension ViewController: VKSdkUIDelegate {
    func vkSdkShouldPresentViewController(controller: UIViewController!) {
        print("vkSdkShouldPresentViewController")
    }
    
    func vkSdkNeedCaptchaEnter(captchaError: VKError!) {
        print("vkSdkNeedCaptchaEnter")
    }
}

extension ViewController: VKSdkDelegate {
    func vkSdkAccessAuthorizationFinishedWithResult(result: VKAuthorizationResult!) {
        print("vkSdkAccessAuthorizationFinishedWithResult")
    }
    
    func vkSdkUserAuthorizationFailed() {
        print("vkSdkUserAuthorizationFailed")
    }
}
