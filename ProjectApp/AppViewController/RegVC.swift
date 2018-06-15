//
//  RegVC.swift
//  ProjectApp
//
//  Created by Ankit on 5/31/18.
//  Copyright © 2018 Ankit. All rights reserved.
//

import UIKit

class RegVC: UIViewController {
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
   
      @IBOutlet weak var txtPass: UITextField!
      @IBOutlet weak var txtCPass: UITextField!
   
    var userViewModel: UserViewModel = UserViewModel()
    
        override func viewDidLoad() {
        super.viewDidLoad()
        btnNext.layer.cornerRadius = btnNext.frame.height / 2
        btnNext.clipsToBounds = true
        btnNext.tintColor = UIColor.white
        self.title = "REGISTRATION"
            
            userViewModel.regSuccess.bind { (value) in
                self.hideLoading()
                Common.instance.showalert( message: value, calling: self)
                self.txtEmail.text = ""
                self.txtPass.text =  ""
                self.txtCPass.text = ""
                
            }
            
            userViewModel.regFailure.bind {(value) in
                self.hideLoading()
                Common.instance.showalert( message: value, calling: self)
            }
    
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnLoginPress(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        self.view.endEditing(true)
        if(!Common.instance.isValidEmail(txtEmail.text!)){
            Common.instance.showalert(message: "Please enter valid email.", calling: self)
            return
        }
        else if(!Common.instance.isValidPassword(txtPass.text!)){
            Common.instance.showalert(message: "Please enter password.", calling: self)
            return
        }else if(txtPass.text != txtCPass.text){
             Common.instance.showalert(message: "confirm password and password should be same.", calling: self)
            return
        }
        
        
        let params = [
            "email" : txtEmail.text! ,
            "password" : txtPass.text!,
           
        ]
        self.showLoading()
        userViewModel.doRegister(params)
    
    }
    
    func showLoading(){
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
        
    }
    
    func hideLoading(){
         MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    
}

