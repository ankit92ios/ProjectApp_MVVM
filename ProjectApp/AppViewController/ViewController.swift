//
//  ViewController.swift
//  ProjectApp
//
//  Created by Ankit on 5/31/18.
//  Copyright © 2018 Ankit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    
    
    var userViewModel: UserViewModel = UserViewModel()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        btnLogin.layer.cornerRadius = btnLogin.frame.height / 2
        btnLogin.clipsToBounds = true
        btnLogin.tintColor = UIColor.white
      
        userViewModel.regSuccess.bind {_ in
             self.hideLoading()
            self.txtEmail.text = ""
            self.txtPass.text =  ""
            self.userViewModel.doUserLogin(self)
        }
        userViewModel.regFailure.bind {(value) in
            self.hideLoading()
            Common.instance.showalert( message: value, calling: self)
        }
        
        if(Common.instance.isUserLogin()){
           self.userViewModel.doUserLogin(self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
   
   
    @IBAction func btnLoginPressed(_ sender: Any) {

        
        if(Common.instance.isNotEmpty(txtEmail.text!) && Common.instance.isNotEmpty(txtPass.text!)){
            
            let params = [
                "email" : txtEmail.text! ,
                "password" : txtPass.text!
            ]
            self.showLoading()
            userViewModel.doLogin(params)
        }else{

            Common.instance.showalert( message: "Please enter email and password to login", calling: self)
        }
       
    }
    
    @IBAction func btnDriverPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "RegSegue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back-btn")
        
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back-btn")
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style:.plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = .white
        
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


