//
//  DetailViewController.swift
//  Milestone1
//
//  Created by Muhsin Can Yılmaz on 24.08.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var selectedFlag : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = 30
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        
        if let image = selectedFlag{
            imageView.image = UIImage(named: image)
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
            
        }
        
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) , selectedFlag != nil else{
            print("error")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image,selectedFlag!], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
            
    }
    

}
