//
//  NetworkManager.swift
//  NetworkLayer

import Foundation
import Alamofire



class NetworkManager {
     static let instance : NetworkManager = NetworkManager()
   
     static let environment : NetworkEnvironment = .production
   
    
          func login(params : [String: String] , completion: @escaping (_ token: String?,_ error: String?)->())
          {
            
            _ = Alamofire.request(APIRouters.login(params["email"]!,params["password"]!)).responseJSON(completionHandler: { response  in
               
//                #if DEBUG
//                print("Request: \(String(describing: response.request))")   // original url request
//                print("Response: \(String(describing: response.response))") // http url response
//                print("Result: \(response.result)")
//                #endif
                if response.result.isSuccess
                    {
                        if response.result.value != nil {
                           // print("JSON: \(json)")
                             let responseObject = response.result.value! as AnyObject
                             let error = responseObject.value(forKey: "error") as? String
                            
                            if(error != nil)
                            {
                                 completion(nil, error!)
                            }
                            else
                            {
                                let token = responseObject.value(forKey: "token") as? String
                                completion(token, nil)
                            }

                        }else
                        {
                            completion(nil, response.error!.localizedDescription)
                            print("API : JSON FAILED")
    
                        }
                    }
                    else
                    {
                        completion(nil, response.error!.localizedDescription)
                        print("API : FAILED")
                    }
                })
            
        }

    
    func register(params : [String: String] , completion: @escaping (_ success: String?, _ error: String?)->())
    {
        _ = Alamofire.request(APIRouters.register(params["email"]!,params["password"]!)).responseJSON(completionHandler: { response  in
//             #if DEBUG
//            print("Request: \(String(describing: response.request))")   // original url request
//            print("Response: \(String(describing: response.response))") // http url response
//            print("Result: \(response.result)")
//             #endif
            if response.result.isSuccess
            {
                if response.result.value != nil {
                    // print("JSON: \(json)")
                    let responseObject = response.result.value! as AnyObject
                    let error = responseObject.value(forKey: "error") as? String
                    if(error != nil)
                    {
                        completion(nil, error!)
                    }
                    else
                    {
                        let token = responseObject.value(forKey: "token") as? String
                        
                        completion(token, nil)
                    }
                    
                }else
                {
                    completion(nil,response.error!.localizedDescription)
                    print("API : JSON FAILED")
                    
                }
            }
            else
            {
                completion( nil,response.error!.localizedDescription)
                print("API : FAILED")
            }
        })
        
    }
    
   func userListing(page : Int ,completion: @escaping (_ userList: [Userdata]?,_ totalPages : Int? ,_ currentPage : Int?,_ error: String?)->())
    {
        _ = Alamofire.request(APIRouters.listusers(page)).responseJSON(completionHandler: { response  in
            
//            #if DEBUG
//            print("Request: \(String(describing: response.request))")   // original url request
//            print("Response: \(String(describing: response.response))") // http url response
//            print("Result: \(response.result)")
//            #endif
            if response.result.isSuccess
            {
                if response.result.value != nil {
                    // print("JSON: \(json)")
                    let responseObject = response.result.value! as AnyObject
                    let data = responseObject.value(forKey: "data") as? [Any]
                    if(data == nil)
                    {
                        let error_msg = "No Data Found"
                        completion(nil, nil, nil, error_msg )
                    }
                    else
                    {
                        var userList = [Userdata]()
                        if let representation = (response.result.value as AnyObject).value(forKeyPath: "data") as? [NSDictionary]
                        {
                            for subCategory in representation
                            {
                                
                                userList.append( Userdata(json: subCategory))
                            }
                        }
                         let total_pages = responseObject.value(forKey: "total_pages") as? Int
                         let page = responseObject.value(forKey: "page") as? Int
                        
                        
                        completion(userList, total_pages , page , nil)
                    }
                    
                }else
                {
                    completion(nil,  nil, nil,response.error!.localizedDescription)
                    print("API : JSON FAILED")
                    
                }
            }
            else
            {
                completion(nil, nil,nil,response.error!.localizedDescription)
                print("API : FAILED")
            }
        })
    }

}

