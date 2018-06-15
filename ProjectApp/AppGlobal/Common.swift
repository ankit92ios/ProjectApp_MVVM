
import Foundation
import Alamofire
import CoreData
open class Common {

    static let instance: Common = Common()
    static var loginUser: User?
    static var homeVC : HomeVC?
    static var bal : String?
    
    public init(){}
    
    //MARK: -
    /*******************************
     * Function related with Validation
     *******************************/
   
    open func isValidEmail(_ testStr:String) -> Bool
    {
      
        let emailRegEx =  "[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}" + "\\@" + "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" + "(" + "\\." + "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" + ")+"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
       
    }

    open func isNotEmpty(_ testStr:String) -> Bool
    {
        let testStr2 =  testStr.trimmingCharacters(in: .whitespacesAndNewlines)
        if ( testStr2.count <= 0) {
            return false
        }
        return true
    }
    
    open func isValidPassword(_ testStr : String) -> Bool
    {
        if testStr.count >= 6
        {
            return true
        }
        else{
            return false
        }
    }
    
   
     func showalert(title : String = "Project APP" , message : String ,calling : UIViewController) -> Void{
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        calling.present(alert, animated: true, completion: nil)
    }
    
    func isUserLogin()-> Bool{
        if(Common.loginUser != nil){
            return true
        }else{
            Common.loginUser = User.init()
            return Common.loginUser!.bindUserInfo()
            
        }
       
    }
    
    func UserLogout() -> Bool
    {
        if(Common.loginUser?.logout())!{
            Common.loginUser = nil
            Common.homeVC = nil
            return true
        }
        return false
    }
    
    
    // Documents directory
    func documentsDirectory() -> String {
        let documentsFolderPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
//        debugPrint(documentsFolderPath)
        return documentsFolderPath
    }
}

extension String {
    func stringByAppendingPathComponent(_ path: String) -> String {
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
    
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UIColor {
    struct FlatColor {
        struct Blue {
            static let LightSkyBlue = UIColor(hexString: "#97E4FB")
            static let sideMenu = UIColor(hexString: "#005F75")
             static let green = UIColor(hexString: "#009D00")
        }
        struct customBlack {
            static let lightBlack = UIColor(hexString: "#3C4145")
            static let dimBlack = UIColor(hexString: "#F1F1F1")
        }
    }
}
