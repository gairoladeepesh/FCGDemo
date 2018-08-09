//
//  Profile.swift
//  FCGDemo
//
//  Created by Deepesh Gairola on 09/08/18.
//  Copyright © 2018 Deepesh Gairola. All rights reserved.
//

import Foundation
import ObjectMapper

class Profile: Mappable {
    
    var profileId: Int?
    var profile_img_url :String?
    var first_name : String?
    var last_name : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        profileId <- map["id"]
        profile_img_url <- map["profile_picture"]
        first_name <- map["first_name"]
        last_name  <- map["last_name"]
    }
    
    
}
