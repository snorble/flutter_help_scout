import Flutter
import UIKit
import Beacon



public class SwiftFlutterHelpScoutPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "privilee/flutter_help_scout", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterHelpScoutPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let arguments = call.arguments as? NSDictionary
    
    if(call.method.elementsEqual("initialize")){

        // initialize beacon
        initializeBeacon(arguments: arguments!)

        result("Beacon successfully initialized")
    }
    else if(call.method.elementsEqual("openBeacon")){
     
        let beaconId = arguments!["beaconId"] as? String
        
        // open beacon
        openBeacon(beaconId: beaconId!)
      
        result("Beacon open successfully!")
    } else if(call.method.elementsEqual("identifyBeacon")){
        // initialize beacon providing arguments to identify the user
        initializeBeacon(arguments: arguments!)

        result("Beacon identifyBeacon successfully!")
    }

    else if(call.method.elementsEqual("logoutBeacon")){
     
        // logout beacon
        logoutBeacon()
      
        result("Beacon logged out successfully!")
    }

    else if(call.method.elementsEqual("clearBeacon")){
     
        // reset beacon
        resetBeacon()
      
        result("Beacon reset successfully!")
    }

    else if(call.method.elementsEqual("openContact")){
     
        let beaconId = arguments!["beaconId"] as? String
        
        // open beacon
//        openBeacon(beaconId: beaconId!)
        
        // open contact
        openContact(beaconId: beaconId!)
      
        result("Beacon openContact successfully!")
    }

    else if(call.method.elementsEqual("setSessionAttributes")){

            let beaconId = arguments!["beaconId"] as? String
            let attributes = arguments!["attributes"] as? [String: String]

            setSessionAttributes(beaconId: beaconId!, attributes: attributes!)

            result("Session Attributes successfully added!")
        }
      
      else if(call.method.elementsEqual("openArticle")){
       
          let beaconId = arguments!["beaconId"] as? String
          let articleId = arguments!["articleId"] as? String
          
          // open article
          openArticle(beaconId: beaconId!, articleId: articleId!)
        
          result("Beacon openArticle successfully!")
      }
    
  }
    
    
  public func initializeBeacon(arguments: NSDictionary){
        
    let email = arguments["email"] as? String
    let name = arguments["name"] as? String
    let avatar = arguments["avatar"] as? URL
        
    let user = HSBeaconUser()
    user.email = email
    user.name = name
    user.avatar = avatar;

    let attributes = arguments["attributes"] as? Dictionary<String, String>
    if attributes != nil {
          for (key, value) in attributes!{
              user.addAttribute(withKey: key, value: value)
          }
    }

    HSBeacon.identify(user)
 }

    // open the beacon
  public func openBeacon(beaconId: String){
    let settings = HSBeaconSettings(beaconId: beaconId)
    settings.messagingEnabled = true
    settings.chatEnabled = true
    HSBeacon.open(settings)
  }

  // logout beacon
  public func logoutBeacon(){
    HSBeacon.logout()
  }

  // reset beacon
  public func resetBeacon(){
    HSBeacon.reset()
  }

  public func openContact(beaconId: String){
      let settings = HSBeaconSettings(beaconId: beaconId)
      HSBeacon.navigate("/ask/message/", beaconSettings: settings)
  }

  public func setSessionAttributes(beaconId: String, attributes: [String: String]) {
      //Save Session Attributes in UserDefaults
      let defaults = UserDefaults.standard
      defaults.set(attributes, forKey: "HelpScoutSessionAttributes")
  }
    
    public func openArticle(beaconId: String, articleId: String){
        let settings = HSBeaconSettings(beaconId: beaconId)
        HSBeacon.openArticle(articleId, beaconSettings: settings)
    }
}

extension SwiftFlutterHelpScoutPlugin: HSBeaconDelegate {
    public func sessionAttributes() -> [String: String] {
        let defaults = UserDefaults.standard
        
        //Retrieve Session Attributes in UserDefaults
        let sessionAttributesDict = defaults.object(forKey: "HelpScoutSessionAttributes") as? [String: String] ?? [String: String]()

        return sessionAttributesDict
    }
}
