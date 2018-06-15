//
//  SideVC.swift
//  ProjectApp
//
//  Created by Ankit on 6/1/18.
//  Copyright © 2018 Ankit. All rights reserved.
//

import UIKit

class SideVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblMenu: UITableView!
    var  tblMenuList : [(String,UIImage?)]?
    override func viewDidLoad() {
        super.viewDidLoad()
        tblMenuList = [
            ("HOME",UIImage.init(named:"home-icon")),
            ("LOGOUT" , UIImage.init(named:"logout-icon"))]
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tblMenuList!.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let navigationcontroller = self.revealViewController().frontViewController  as! UINavigationController
        switch indexPath.row {
        case 0:
        navigationcontroller.popToRootViewController(animated: true)
        Common.homeVC?.userDataViewModel.reloadUserList()
        break
        case 1:
        Common.homeVC!.logOutUser()
        break
        default:
        break
        }
         self.revealViewController().revealToggle(nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
         let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
         let imgIcon  = cell.viewWithTag(1) as! UIImageView
        let lblText = cell.viewWithTag(2) as! UILabel
        let singleTuple = tblMenuList![indexPath.row]
        imgIcon.image = singleTuple.1
        lblText.text = singleTuple.0
        
         return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
        
    }
}
