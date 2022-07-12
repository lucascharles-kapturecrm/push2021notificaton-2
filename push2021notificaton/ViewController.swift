//
//  ViewController.swift
//  push2021notificaton
//
//  Created by Kapture on 27/12/21.
//

import UIKit
import FirebaseCore

class ViewController: UIViewController {
    @IBOutlet weak var texttoken: UITextView!
    @IBOutlet weak var texttoken2nd: UITextView!
    var mrnKey = String()
    var target =  String()
    @IBOutlet weak var texttoken3rd: UITextView!
    var age = String()
    @IBOutlet weak var texttoken4th: UITextView!
    var user = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        var fcmNo = String()
        
        if fcmNo != nil
        {
     fcmNo = AppPreferences.share.get(forkey: .fcmToken) ?? "0"
        }
        else
        {
            fcmNo = "0"
        }
        mrnKey = AppPreferences.share.get(forkey: .mrnValue) ?? "1st sender id token"
        target = AppPreferences.share.get(forkey: .target) ?? "2nd sender id token"
        age = AppPreferences.share.get(forkey: .age) ?? "3rdnd sender id token"
        user = AppPreferences.share.get(forkey: .user) ?? "4th sender id token"
//        print("FCMpRINT",fcmNo)
      texttoken.text = mrnKey
        texttoken2nd.text = target
      //  texttoken3rd.text = age
        //texttoken4th .text = user
        
      
    }
    override func viewWillAppear(_ animated: Bool) {
  
    }
    override func viewDidAppear(_ animated: Bool) {
//        var clientset = UserDefaults.standard.string(forKey: "Clienttoken")
//        print("clientset",clientset)
//        texttoken.text = clientset
    }

}

