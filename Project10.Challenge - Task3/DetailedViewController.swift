//
//  DetailedViewController.swift
//  Project10.Challenge - Task3
//
//  Created by Igor Polousov on 17.08.2021.
//

import UIKit

class DetailedViewController: UIViewController {

    @IBOutlet var detailedImage: UIImageView!
    
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(selectedImage?.replacingOccurrences(of: ".jpg", with: "") ?? "Oops, no image found")"
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharePicture))

        if let imageToLoad = selectedImage {
            detailedImage.image = UIImage(named: imageToLoad)
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap =  false
    }
    
    @objc func sharePicture() {
        
        guard let image = detailedImage.image?.jpegData(compressionQuality: 0.7) else {
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image,"\(selectedImage?.replacingOccurrences(of: ".jpg", with: "") ?? "Oops, no image foiund")"], applicationActivities: [])
        
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
        
    }

}
