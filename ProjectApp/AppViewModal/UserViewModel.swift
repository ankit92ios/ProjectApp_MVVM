//
//  UserViewModel.swift
//  ProjectApp
//
//  Created by Ankit on 6/15/18.
//  Copyright © 2018 Ankit. All rights reserved.
//



class UserViewModel{
    
    
    var regSuccess: DynamicType<String> = DynamicType(nil)
    var regFailure: DynamicType<String> = DynamicType(nil)
    
    func doLogin(_ params :  [String: String] )
    {
        Common.loginUser = User()
        Common.loginUser?.email = params["email"]
        Common.loginUser?.password = params["password"]
        NetworkManager.instance.login(params: params) { (token, error) in
            if(error == nil){
                Common.loginUser?.token = token
                Common.loginUser?.addToPlist(Common.loginUser!)
                self.regSuccess.value = ""
                
            }else{
                self.regFailure.value = error
            }
            
        }
    }
    func doRegister(_ params :  [String: String] )
    {
        NetworkManager.instance.register(params: params) { (show_user_msg, error) in
            if(error == nil){
                
                self.regFailure.value = "Successfully Registered !! "
            }else{
                
                self.regFailure.value = error
            }
        }
    }

    func doUserLogin(_ viewcontroller : UIViewController){
        let LoginNVC = viewcontroller.storyboard?.instantiateViewController(withIdentifier: "LoginNVC")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = LoginNVC!
    }
}
