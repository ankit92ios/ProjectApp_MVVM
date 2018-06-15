//
//  HomeVC.swift
//  ProjectApp
//
//  Created by Ankit on 6/1/18.
//  Copyright © 2018 Ankit. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var tblList: UITableView!

    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet var AlertLogOut: UIView!
   
    
    var popup : KLCPopup!
    var UID : String = ""
    
   
    var refresh : CarbonSwipeRefresh = CarbonSwipeRefresh()
   
    var userDataViewModel: UserDataViewModel = UserDataViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AlertLogOut.layer.cornerRadius = 5
        AlertLogOut.layer.masksToBounds = true
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        self.revealViewController().bounceBackOnOverdraw = false
        self.revealViewController().frontViewShadowOpacity = 0.2
       
        btnOk.layer.cornerRadius = btnOk.frame.height / 2
        btnOk.clipsToBounds = true
        btnOk.tintColor = UIColor.white
        
        btnCancel.layer.cornerRadius = btnCancel.frame.height / 2
        btnCancel.clipsToBounds = true
        btnCancel.tintColor = UIColor.white
        
        let color1 : UIColor = UIColor.FlatColor.Blue.LightSkyBlue
        let color2 : UIColor = UIColor.FlatColor.Blue.green
        let color3 : UIColor = UIColor.FlatColor.customBlack.lightBlack
        refresh = CarbonSwipeRefresh.init(scrollView: tblList!)
        refresh.colors = [color1,color2,color3]
        
        refresh.addTarget(self, action: #selector(self.loadData), for:UIControlEvents.valueChanged)
        
        self.title = "Home"
        
        if(Common.homeVC == nil){
            Common.homeVC = self
        }
        userDataViewModel.error.bind { (error) in
            Common.instance.showalert( message: error, calling: self)
        }
        userDataViewModel.userList.bind { [unowned self]value in
             self.refresh.endRefreshing()
             self.hideLoading()
             self.tblList.reloadData()
        }
        self.loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.view.addSubview(refresh)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func loadData() {
        userDataViewModel.reloadUserList(forPage: 1)
    }
    
    @IBAction func menubtnPress(_ sender: Any) {
        self.revealViewController().revealToggle(sender)
    }
   
    
    func logOutUser(){
        lblTitle.text = "Are you want ot exit ?"
        popup =  KLCPopup.init(contentView: AlertLogOut, showType: .slideInFromBottom, dismissType: .slideOutToBottom, maskType: .dimmed, dismissOnBackgroundTouch: true, dismissOnContentTouch: false)
        popup.tag = 1
         popup.show()

    }
    
   
    @IBAction func btnOKPressed(_ sender: Any) {
        popup?.dismiss(true)
        self.userDataViewModel.userlogout(viewcontroller: self)
    }
    
    @IBAction func btnCancelPressed(_ sender: Any) {
        
        popup?.dismiss(true)
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

extension HomeVC :  UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let users = self.userDataViewModel.userList.value {
            return users.count
        }
        return 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ProjectAppCell", for: indexPath) as? ProjectAppCell
        if(cell == nil)
        {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "ProjectAppCell") as? ProjectAppCell
        }
        
        if let users = self.userDataViewModel.userList.value {
            let user = users[indexPath.row]
            cell?.lblFirst.text = user.first_name
            cell?.lblSecond.text = user.last_name
            cell?.imgProf?.image = UIImage.init(named: "profile")
            cell?.lblSno?.text = "\(user.uid!)"
            if let avatar = user.avatar {
               
                    
                    do {
                        let components = URLComponents(string: avatar)
                        let URL = try components?.asURL()
                        DispatchQueue.global().async(execute: {
                            do {
                                let imageData = try Data(contentsOf:URL!)
                                DispatchQueue.main.async {
                                    cell?.imgProf?.image = UIImage.init(data: imageData)
                                }
                            }
                            catch {
                                DispatchQueue.main.async {
                                    cell?.imgProf?.image = UIImage.init(named: "profile")
                                }
                                
                            }
                            
                        })
                        
                    }
                    catch {
                        DispatchQueue.main.async {
                            cell?.imgProf?.image = UIImage.init(named: "profile")
                        }
                    }
                
            }
            else {
                DispatchQueue.main.async {
                    cell?.imgProf?.image = UIImage.init(named: "profile")
                }
            }
            
            
        }
        else {
            cell?.lblFirst.text = "Unavailable"
            cell?.lblSecond.text = "Unavailable"
            
        }
    
        return cell!
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 141
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        if(!self.userDataViewModel.isAlreadyLoading){
            if self.userDataViewModel.currentPage.value! <= self.userDataViewModel.total_pages.value! {
                self.userDataViewModel.currentPage.value!  = self.userDataViewModel.currentPage.value! + 1
                self.userDataViewModel.reloadUserList(forPage: self.userDataViewModel.currentPage.value!)
            }
        }
        
    }

}

