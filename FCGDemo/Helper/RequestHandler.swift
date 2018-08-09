//
//  RequestHandler.swift
//  FCGDemo
//
//  Created by Deepesh Gairola on 09/08/18.
//  Copyright © 2018 Deepesh Gairola. All rights reserved.
//

import Foundation
import ObjectMapper

protocol RequestHandlerDelegate {
    func responseFromServer(response: [Profile])
}

class RequestHandler: NSObject {
    
    var delegate : RequestHandlerDelegate?
    
    
    func getAllProfilesData() {
        
        let resource = "https://fierce-harbor-90458.herokuapp.com/profiles"
    
        let url = NSURL(string: resource)
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if let data = data {
                
                let json = String(data: data, encoding: .utf8)
                
                let objProfiles = Mapper<Profile>().mapArray(JSONString: json!)

                DispatchQueue.main.async {
                    self.delegate?.responseFromServer(response: objProfiles!)
                }
            }
        }
        task.resume()
    }
    
    func getProfileData(profileId: String) {
        
        let resource = "https://fierce-harbor-90458.herokuapp.com/profiles/\(profileId)"
        
        let url = NSURL(string: resource)
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if let data = data {
                
                let json = String(data: data, encoding: .utf8)
                
                let objProfile = Mapper<Profile>().map(JSONString: json!)
                
                DispatchQueue.main.async {
                    self.delegate?.responseFromServer(response: [objProfile!])
                }
            }
        }
        task.resume()
    }
}
