//
//  UserDefaults.swift
//  CarTrack
//
//  Created by Prashant Singh on 13/5/21.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultsKeys: String {
        case isLoggedIn
    }
    
    func setIsLoggedIn(value: Bool) {
        if value == true {
            set(true, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        } else {
            set(false, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        }
        synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
}
