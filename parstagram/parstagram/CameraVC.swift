//
//  CameraVC.swift
//  parstagram
//
//  Created by Jennifer Lopez on 10/23/20.
//  Copyright © 2020 Jennifer Lopez. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class CameraVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var cap: UITextField!
    @IBOutlet weak var postButt: UIButton!
    
    @IBAction func tappedImg(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
        
    }
    
    @IBAction func post(_ sender: Any) {
        let post = PFObject(className: "Posts")
        post["caption"] = cap.text
        post["author"] = PFUser.current()
        
        let imageData = img.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        post["img"] = file
        
        post.saveInBackground { (success, err) in
            if (success) {
                print ("posted")
                self.dismiss(animated: true, completion: nil)
            }
            else {
                print("error - \(err?.localizedDescription)")
            }
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let pic = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaled = pic.af.imageScaled(to: size)
        
        img.image = scaled
        dismiss(animated: true, completion: nil)
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postButt.layer.cornerRadius = 15
    }
    
}
