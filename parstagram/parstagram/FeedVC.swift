//
//  FeedVC.swift
//  parstagram
//
//  Created by Jennifer Lopez on 10/23/20.
//  Copyright © 2020 Jennifer Lopez. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var posts = [PFObject]()
    
    @IBOutlet weak var tbv: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbv.delegate = self
        tbv.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        query.limit = 20
        query.findObjectsInBackground { (posts, err) in
            if (posts != nil) {
                self.posts = posts!
                self.tbv.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbv.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! postCell
        let post = posts[indexPath.row]
        
        cell.caption.text = (post["caption"] as! String)
            
        let name = (post["author"] as! PFUser).username
        cell.userName.text = name!
        
        let file = post["img"] as! PFFileObject
        let url = URL(string: file.url!)!
        
        cell.postImg.af.setImage(withURL: url)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
}
