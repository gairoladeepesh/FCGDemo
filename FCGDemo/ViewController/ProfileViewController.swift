//
//  ProfileViewController.swift
//  FCGDemo
//
//  Created by Deepesh Gairola on 09/08/18.
//  Copyright © 2018 Deepesh Gairola. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, RequestHandlerDelegate {
    
    
    
    let requestHandler = RequestHandler()
    
    var completeName : String?
    var profileImg : String?
    
    var profileID : String?
    
    
    @IBOutlet weak var mainProfileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestHandler.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        requestHandler.getProfileData(profileId: profileID!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func responseFromServer(response: [Profile]) {
        self.title = "\(response[0].first_name!) \(response[0].last_name!)"
        mainProfileImage.imageFromServerURL(urlString: response[0].profile_img_url!, defaultImage: "demo.jpg")
    }
    
    
    @IBAction func actionAddToFav(_ sender: Any) {
        
    }
    
    

}
