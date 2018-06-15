//
//  Modal.swift
//  ProjectApp
//
//  Created by Ankit on 6/2/18.
//  Copyright © 2018 Ankit. All rights reserved.
//

import UIKit



final class User: NSObject{
    

    var email: String?
    var token: String?
    var password : String?
    override init ()
    {
        super.init()
    }
    
    init(userData: NSDictionary) {
        super.init()
        self.setData(userData)
    }

    
    init(json response : Any) {
        super.init()
        //        print(response)
        if let userData = (response as AnyObject) as? NSDictionary
        {
           self.setData(userData)
        } else {
            
        }
        
    }
    
    func setData(_ userData: NSDictionary)
    {
        self.token = userData["token"] as? String
        self.email = userData["email"] as? String
        self.password = userData["password"] as? String
        
    }
    
    func addToPlist(_ user: User)
    {
        KeychainWrapper.standard.set(self.email!, forKey: "email")
        KeychainWrapper.standard.set(self.password!, forKey: "password")
        KeychainWrapper.standard.set(self.token!, forKey: "token")
        let userDict : [String : Any] = [
            "isUsrLogin" : "true",
        ]

        _ = Common.instance.documentsDirectory()
        UserDefaults.standard.setSecretObject(userDict,forKey: "LoginInfo")
        print(UserDefaults.standard.synchronize())
    }
    
    
    
    func bindUserInfo() -> Bool{
        let userDict : [String : Any]? =  UserDefaults.standard.secretObject(forKey: "LoginInfo") as? [String : Any]
        if(userDict != nil){
            self.setData(userDict! as NSDictionary)
            self.email = KeychainWrapper.standard.string(forKey: "email")
            self.password =  KeychainWrapper.standard.string(forKey: "password")
            self.token = KeychainWrapper.standard.string(forKey: "isUsrLogin")
            return true
        }
        return false
    }
    
    func logout() -> Bool{
        let removeSuccessful: Bool =  KeychainWrapper.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "LoginInfo")
        return removeSuccessful
    }
    
   
}

final class Userdata : NSObject{
  
    var uid: Int?
    var first_name : String?
    var last_name: String?
    var avatar: String?
  
    init(json response : Any) {
        super.init()
        if let userData = (response as AnyObject) as? NSDictionary
        {
            self.setData(userData)
        } else {
        }
    }
    
    init(userData: NSDictionary) {
        super.init()
        self.setData(userData)
    }
    
    func setData(_ userData: NSDictionary)
    {
        self.uid = userData["id"] as? Int
        self.first_name = userData["first_name"] as? String
        self.last_name    = userData["last_name"] as? String
        self.avatar = userData["avatar"] as? String
    }
    
    override func isEqual(_ data: Any?)->Bool {
        let data2 : Userdata = data as! Userdata
        return self.uid! == data2.uid!
    }
}



extension Userdata {
    override public var hashValue: Int { return uid!.hashValue}
}

func == (lhs: Userdata, rhs: Userdata)->Bool {
    return lhs.isEqual(rhs)
}



