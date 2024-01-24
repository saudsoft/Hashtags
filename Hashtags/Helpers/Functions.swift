//
//  functions.swift
//  Image for Instagram
//
//  Created by Saud Almutlaq on 15/05/2020.
//  Copyright © 2020 Saud Soft. All rights reserved.
//

import Foundation
import UIKit

// Constants
// Test Ads
let GADTestBannerID  = "ca-app-pub-3940256099942544/2934735716"
let GADTestInterstitialID   = "ca-app-pub-3940256099942544/4411468910"
let GADTestInterstitialVideoid  =  "ca-app-pub-3940256099942544/5135589807"
let GADTestRewardedVideoID  =  "ca-app-pub-3940256099942544/1712485313"
let GADTestNativeAdvancedID  =  "ca-app-pub-3940256099942544/3986624511"
let GADTestNativeAdvancedVideoID  =  "ca-app-pub-3940256099942544/2521693316"

// Live Ads
let GADLiveBannerID  = "ca-app-pub-1257362510472337/1337889096"
let GADLiveInterstitialID   = "ca-app-pub-1257362510472337/6231602057"
let GADLiveInterstitialVideoid  =  ""
let GADLiveRewardedVideoID  =  ""
let GADLiveNativeAdvancedID  =  ""
let GADLiveNativeAdvancedVideoID  =  ""

let productID = "hashtags_ads_remove"

var hashtagsArray = [""]

func getHashData() {
    guard let userHashtag = UserDefaults.standard.value(forKey: "hashtags") else {
//        print("using default hashtags")
        hashtagsArray = defaultHashtags.components(separatedBy: " ")
        //            print(hashtagsArray.joined(separator: " "))
        UserDefaults.standard.set(hashtagsArray.joined(separator: " "), forKey: "hashtags")
        return
    }
    
    hashtagsArray = (userHashtag as! String).components(separatedBy: " ")
//    print(hashtagsArray)
    //        print(hashtagsArray.joined(separator: " "))
//    print("using saved hashtags")
}

func showAlert(withTitle title:String, andMessage message:String, inView sender:UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

    alert.addAction(UIAlertAction(title: "موافق", style: .default, handler: nil))
//    alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

    sender.present(alert, animated: true)
}
