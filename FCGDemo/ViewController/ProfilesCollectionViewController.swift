//
//  ProfilesCollectionViewController.swift
//  FCGDemo
//
//  Created by Deepesh Gairola on 09/08/18.
//  Copyright © 2018 Deepesh Gairola. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

extension UIImageView {
    
     func imageFromServerURL(urlString: String, defaultImage : String?) {
        
        if let defaultImg = defaultImage {
            self.image = UIImage(named: defaultImg)
        }
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
}

class ProfilesCollectionViewController: UICollectionViewController, RequestHandlerDelegate, NVActivityIndicatorViewable {

    let requestHandler = RequestHandler()
    var profiles : [Profile]?
    var selectedProfileId : String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        requestHandler.delegate = self
//        Activity indicator view settings
        NVActivityIndicatorView.DEFAULT_TEXT_COLOR = .black
        NVActivityIndicatorView.DEFAULT_BLOCKER_MESSAGE = "Please wait we are searching !"
        NVActivityIndicatorView.DEFAULT_BLOCKER_MESSAGE_FONT = UIFont.boldSystemFont(ofSize: 18)
        NVActivityIndicatorView.DEFAULT_BLOCKER_SIZE = CGSize(width: 50, height: 50)
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = .white
        NVActivityIndicatorView.DEFAULT_TYPE = .lineScale
        NVActivityIndicatorView.DEFAULT_COLOR = .lightGray
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
//        Launch activity indicator
        startAnimating()
        requestHandler.getAllProfilesData()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
//     MARK: - Navigation

//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Pass the selected object to the new view controller.
        let destinationVC = segue.destination as! ProfileViewController
        destinationVC.profileID = selectedProfileId
        
        
    }
 

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // #warning Incomplete implementation, return the number of items
        
        if (profiles?.count) != nil {
            return 10
        }else {
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath) as! ProfileCollectionViewCell
        
        // Configure the cell
        cell.profileImage.imageFromServerURL(urlString: profiles![indexPath.row].profile_img_url!, defaultImage: "demo.jpg")
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        selectedProfileId = String(describing: profiles![indexPath.row].profileId!)
        self.performSegue(withIdentifier: "segueProfile", sender: self)
    }

    // MARK: ReqeuestHandlerDelegate
    
    func responseFromServer(response: [Profile]) {
        
        stopAnimating()
        
        profiles = response
        collectionView?.reloadData()
    }

}
