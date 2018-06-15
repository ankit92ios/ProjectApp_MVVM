//
//  AppEndPoint.swift


import Foundation
import Alamofire

internal enum APIRouters : URLRequestConvertible
{
    static var baseURLString : String{
        switch NetworkManager.environment {
        case .production: return "https://reqres.in/api/"
        case .testing: return "https://reqres.in/api/"
        }
    }
    
    case login(String,String)
    case register(String,String)
    case listusers(Int)
    
    var httpMethod: Alamofire.HTTPMethod {
        switch self {
        case .login(_):
            return .post
        case .register(_):
            return .post
        case .listusers(_):
            return .get
            
        }
    }

    var path: String {
        switch self {
        case .login(_):
            return "\(APIRouters.baseURLString)login"
        case .register(_):
            return "\(APIRouters.baseURLString)register"
        case .listusers(_):
            return "\(APIRouters.baseURLString)users"
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
    
        let URL = Foundation.URL(string: path)!
        
        var mutableURLRequest = URLRequest(url:URL)
        mutableURLRequest.httpMethod = httpMethod.rawValue
        mutableURLRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        switch self {
            
            
        case .login(let email,let password):
            
            do {
                
                var params : [String : String] = [String : String]()
                params["email"] = email as String
                params["password"] = password as String
                let encoding =  URLEncoding(destination: URLEncoding.default.destination)
                return try encoding.encode(mutableURLRequest, with:params)
                
            } catch {
                
                return mutableURLRequest
            }
            
         case .register(let email,let password):
            do {
                var params : [String : String] = [String : String]()
                params["email"] = email as String
                params["password"] = password as String
                let encoding =  URLEncoding(destination: URLEncoding.default.destination)
                return try encoding.encode(mutableURLRequest, with:params)
                
            } catch {
                
                return mutableURLRequest
            }
        case .listusers(let page):
            do {
                var params:[String:AnyObject] = [String : AnyObject]()
                params["page"] = page as AnyObject
                let encoding =  URLEncoding(destination: URLEncoding.Destination.queryString)
                return try encoding.encode(mutableURLRequest, with:params)
                
            } catch {
                
                return mutableURLRequest
            }
            
        }
    }
}

enum NetworkEnvironment {
    case testing
    case production
}




