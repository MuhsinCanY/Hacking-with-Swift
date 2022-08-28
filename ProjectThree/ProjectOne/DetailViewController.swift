//
//  DetailViewController.swift
//  ProjectOne
//
//  Created by Muhsin Can Yılmaz on 17.08.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedImage : String?
    var totalPictures : Int?
    var selectedPictureNumber : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //title = selectedImage
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        
        if let detailTotalCount = totalPictures {
            if let detailSelectedImageNumber = selectedPictureNumber{
                title = "Picture \(detailSelectedImageNumber) of \(detailTotalCount)"
            }
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        navigationItem.largeTitleDisplayMode = .never
        
        // Do any additional setup after loading the view.
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) , selectedImage != nil else{
            print("error")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image,selectedImage!], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
            
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
