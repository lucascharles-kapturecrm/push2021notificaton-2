//
//  File.swift
//  DoodhWala
//
//  Created by Kapil Dhawan on 2/11/17.
//  Copyright © 2017 Kapil Dhawan. All rights reserved.
//

import Foundation

class AppPreferences{
    
    enum keys : String{
        case isLogin = "isLogin"
        case authToken = "authToken"
        case authSecret = "authSecret"
        case username = "username"
        case password = "password"
        case userID = "userID"
        case userGender = "userGender"
        case userHeigth = "userHeigth"
        case userRace = "userRace"
        case userCategory = "userCategory"
        case userFirstName = "userFirstName"
        case newspo2value = "newspo2value"
        
        case userLastName = "userLastName"
        case userEmail = "userEmail"
        case userMobile = "userMobile"
        case user = "user"
        case userdoctorID = "doctorID"
        case companyN = "companyname"
        case fcmToken = "fcmNo"
        case age = "age"
        case target = "target"
       
        case mrnValue = "mrnKey"
        case profileUpdated = "profileUpdated"
        case calories = "calories"
        case bodyWeight = "bodyWeight"
        case waterInTaken = "water"
        case bp = "bp"
        case sleepMins = "sleepMins"
        case sleepHours = "sleepHours"
        case heartRate = "heartRate"
        case spo2 = "spo2"
        case pulse = "pulse"
        case steps = "steps"
        case smartBandSync = "smartBandSync"
        case fitbitAuthToken = "fitbitAuthToken"
        case bodyAnalyzerLastDataSync = "bodyAnalyzerLastDataSync"
    }
    
    static let share = AppPreferences()
    
    let userDef = UserDefaults.standard
    
    func commit(data:Any,forkey:keys){
        let archiveData = NSKeyedArchiver.archivedData(withRootObject: data)
        UserDefaults.standard.set(archiveData, forKey:  forkey.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func get<T>(forkey:keys)->T?{
        let archiveData = UserDefaults.standard.object(forKey: ( forkey.rawValue))
        if archiveData != nil{
            print("PrintArchive",archiveData!)
    let unarchiveData = NSKeyedUnarchiver.unarchiveObject(with: archiveData as! Data) as AnyObject
         //   let unarchiveData  = (NSKeyedUnarchiver.unarchiveObject(with: archiveData as! Data) as AnyObject)
            
            print(unarchiveData)
            
            
            return unarchiveData as? T
        }
        return nil
    }
    
    func clear(){
        for key in UserDefaults.standard.dictionaryRepresentation().keys{
            UserDefaults.standard.removeObject(forKey: key.description)
        }
    }
    
    func remove(_ key: keys)
    {
        UserDefaults.standard.removeObject(forKey: ( key.rawValue))
        UserDefaults.standard.synchronize()
    }
    
    func isKeyExist(_ key: keys) -> Bool
    {
        if(UserDefaults.standard.object(forKey: ( key.rawValue)) == nil)
        {
            return false
        }
        
        return true
    }
    
    
}
public extension UserDefaults {
    
    /// Set Codable object into UserDefaults
    ///
    /// - Parameters:
    ///   - object: Codable Object
    ///   - forKey: Key string
    /// - Throws: UserDefaults Error
    public func set<T: Codable>(object: T, forKey: String) throws {
        
        let jsonData = try JSONEncoder().encode(object)
        
        set(jsonData, forKey: forKey)
    }
    
    /// Get Codable object into UserDefaults
    ///
    /// - Parameters:
    ///   - object: Codable Object
    ///   - forKey: Key string
    /// - Throws: UserDefaults Error
    public func get<T: Codable>(objectType: T.Type, forKey: String) throws -> T? {
        
        guard let result = value(forKey: forKey) as? Data else {
            return nil
        }
        
        return try JSONDecoder().decode(objectType, from: result)
    }
}
