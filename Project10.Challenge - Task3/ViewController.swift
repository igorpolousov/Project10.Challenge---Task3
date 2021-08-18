//
//  ViewController.swift
//  Project10.Challenge - Task3
//  Day 44
//  Created by Igor Polousov on 12.08.2021.
//

import UIKit

class ViewController: UICollectionViewController {

    var pictures = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareApp))
        
        getFiles()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StormCell", for: indexPath) as? StormCellController else {
            fatalError("Unable dequeue StormCell")
        }
        let picture = pictures[indexPath.item]
        
        cell.imageView.image = UIImage(named: picture)
        cell.name.text = picture.replacingOccurrences(of: ".jpg", with: "")
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(white: 0.4, alpha: 0.3).cgColor
        cell.layer.cornerRadius = 6
        cell.layer.backgroundColor = UIColor(white: 0.6, alpha: 0.2).cgColor
        
        cell.imageView.layer.borderWidth = 1
        cell.imageView.layer.borderColor = UIColor(white: 0.4, alpha: 0.3).cgColor
        cell.imageView.layer.cornerRadius = 6
       
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailedViewController {
            vc.selectedImage = pictures[indexPath.item]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    @objc func shareApp() {
        let appName = "Storm Viewer"
        let vc = UIActivityViewController(activityItems: [appName], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    func getFiles() {
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
                pictures.sort()
            }
        }
    }
    
}

