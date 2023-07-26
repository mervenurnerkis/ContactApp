//
//  InfoViewController.swift
//  ContactApp
//
//  Created by Merve Nur Nerkis on 23.07.2023.
//

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var relationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var selectedImageName: String?
    var relationLabelName: String?
    var relationTypes: String?
    var selectedContacts: [ContactModel] = [ContactModel]()
    
    @IBOutlet weak var infoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoCollectionView.delegate = self
        infoCollectionView.dataSource = self
        
        let design:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let viewWidth = self.infoCollectionView.frame.size.width
        design.sectionInset = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 10)
        design.itemSize = CGSize(width: (viewWidth-60)/2, height: (viewWidth-60)/2)
        design.scrollDirection = .horizontal
        infoCollectionView.collectionViewLayout = design
        
        if let name = relationLabelName {
            nameLabel.text = name
        }
        
        if let relation = relationTypes {
            relationLabel.text = relation
        }
        selectedImage.image = UIImage(named: selectedImageName!)
        
    }
}

extension InfoViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        selectedContacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoViewControllerCell", for: indexPath) as! InfoViewControllerCell
        cell.contactLabel.text = selectedContacts[indexPath.row].title
        cell.contactImage.image = UIImage(named: String(describing: selectedContacts[indexPath.row].personImage))
        return cell
    }
    
    
}
