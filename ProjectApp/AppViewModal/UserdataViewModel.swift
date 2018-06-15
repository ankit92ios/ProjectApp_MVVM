//
//  UserdataViewModel.swift
//  ProjectApp
//
//  Created by Ankit Agarwal on 6/15/18.
//  Copyright © 2018 Ankit. All rights reserved.
//

class UserDataViewModel{
    
    var userList: DynamicType<[Userdata]> = DynamicType(nil)
    var error:DynamicType<String> = DynamicType(nil)
    var total_pages: DynamicType<Int> = DynamicType(nil)
    var currentPage : DynamicType<Int> = DynamicType(nil)
    var isAlreadyLoading : Bool  = false
    
    
    func reloadUserList(forPage page : Int = 1)
    {
        if page == 1 {
            userList.value?.removeAll()
        }
        isAlreadyLoading = true
        NetworkManager.instance.userListing(page: page, completion:{ (userList,total_pages,currentPage, error) in
            if(error == nil){
                self.isAlreadyLoading = false
                let newUserlist: [Userdata] = userList!.filter {
                    if self.userList.value == nil {
                        return true
                    }
                    return  self.userList.value?.contains($0) == false
                }
                
                self.total_pages.value = total_pages
                self.currentPage.value = currentPage
                if(currentPage == 1){
                    self.userList.value = newUserlist
                }else{
                    self.userList.value?.append(contentsOf:newUserlist)
                }
                
            }else{
               self.error.value = error
            }
        })
        
    }
    
    func userlogout(viewcontroller : UIViewController){
        if(Common.instance.UserLogout())
        {
            let startNV = viewcontroller.storyboard?.instantiateViewController(withIdentifier: "start")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = startNV!
            
        }else{
            
        }
    }
}
