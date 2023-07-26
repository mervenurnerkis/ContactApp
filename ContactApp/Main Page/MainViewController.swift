//
//  MainViewController.swift
//  ContactApp
//
//  Created by Merve Nur Nerkis on 22.07.2023.
//

import UIKit

struct ContactModel {
    var title: String
    var relationType: RelationType
    var personGender: Gender
    var personImage: GenderImage
}

enum RelationType: CaseIterable {
    case family
    case friends
    case work
    case sportgroup
    
    var relationType: String {
        switch self {
        case .family:
            return "Family"
        case .friends:
            return "Friends"
        case .work:
            return "Work"
        case .sportgroup:
            return "Sportgroup"
        }
    }
}

enum Gender{
    case woman
    case man
}

enum GenderImage: CaseIterable {
    case woman
    case man
    
    var genderImage: String {
        switch self {
        case .woman:
            return "woman"
        case .man:
            return "man"
        }
    }
}

class Contacts {
    static let contacts: [ContactModel] = [
        ContactModel(title: "Merve", relationType: .family, personGender: .woman, personImage: .woman),
        ContactModel(title: "Batu", relationType: .family, personGender: .man, personImage: .man),
        ContactModel(title: "Miray", relationType: .family, personGender: .woman, personImage: .woman),
        ContactModel(title: "Ersin", relationType: .family, personGender: .man, personImage: .man),
        ContactModel(title: "Melek", relationType: .family, personGender: .woman, personImage: .woman),
        ContactModel(title: "Elif", relationType: .friends, personGender: .woman, personImage: .woman),
        ContactModel(title: "Birgül", relationType: .friends, personGender: .woman, personImage: .woman),
        ContactModel(title: "Ece", relationType: .friends, personGender: .woman, personImage: .woman),
        ContactModel(title: "Yaren", relationType: .friends, personGender: .woman, personImage: .woman),
        ContactModel(title: "Funda", relationType: .friends, personGender: .woman, personImage: .woman),
        ContactModel(title: "Ali", relationType: .work, personGender: .man, personImage: .man),
        ContactModel(title: "Mehmet", relationType: .work, personGender: .man, personImage: .man),
        ContactModel(title: "Begüm", relationType: .work, personGender: .woman, personImage: .woman),
        ContactModel(title: "Umut", relationType: .work, personGender: .man, personImage: .man),
        ContactModel(title: "Ada", relationType: .work, personGender: .woman, personImage: .woman),
        ContactModel(title: "Cenk", relationType: .sportgroup, personGender: .man, personImage: .man),
        ContactModel(title: "Yıldız", relationType: .sportgroup, personGender: .woman, personImage: .woman),
        ContactModel(title: "Beyza", relationType: .sportgroup, personGender: .woman, personImage: .woman),
        ContactModel(title: "Betül", relationType: .sportgroup, personGender: .woman, personImage: .woman),
        ContactModel(title: "Nur", relationType: .sportgroup, personGender: .woman, personImage: .woman),
        
    ]
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var contactTableView: UITableView!
    
    
    private var selectedRelationType: RelationType? {
        didSet {
            contactTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactTableView.delegate = self
        contactTableView.dataSource = self
        
    }
    
    @IBAction func filterButton(_ sender: UIBarButtonItem) {
        
        let storyboard = UIStoryboard(name: "PickerViewController", bundle: nil)
        
        if let vc = storyboard.instantiateViewController(identifier: "PickerViewController") as? PickerViewController {
            vc.delegate = self
            let navController = UINavigationController(rootViewController: vc)
            navController.modalPresentationStyle = .overCurrentContext
            self.present(navController, animated: true)
        }
    }
    
}

extension MainViewController: PickerViewControllerDelegate {
    func didSelectRelationType(_ type: RelationType) {
        selectedRelationType = type
        contactTableView.reloadData()
        print("didSelectRelationType called with type: \(type.relationType)")
    }
}

extension MainViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return setSections().count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return setSections()[section].relationType
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterContacts(section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell") as! ContactTableViewCell
        
        cell.cellImageView?.image = UIImage(named: filterContacts(indexPath.section)[indexPath.row].personImage.genderImage)
        cell.cellTitleLabel?.text = filterContacts(indexPath.section)[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let filterbyContacts = filterContacts(indexPath.section).filter({$0.title != filterContacts(indexPath.section)[indexPath.row].title})
        
        let storyboard = UIStoryboard(name: "InfoViewController", bundle: nil)
        let infoVC = storyboard.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        infoVC.relationLabelName = filterContacts(indexPath.section)[indexPath.row].title
        infoVC.selectedImageName = String(describing: filterContacts(indexPath.section)[indexPath.row].personImage)
        infoVC.selectedContacts = filterbyContacts
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Contacts", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(infoVC, animated: true)
    }
    
    private func setSections() -> [RelationType] {
        if selectedRelationType == nil {
            return RelationType.allCases
        } else {
            return [selectedRelationType!]
        }
    }
    
    func filterContacts(_ sectionIndex: Int) -> [ContactModel] {
        if selectedRelationType == nil {
            return Contacts.contacts.filter({ $0.relationType == RelationType.allCases[sectionIndex] })
        } else {
            return Contacts.contacts.filter({ $0.relationType == selectedRelationType })
        }
        
    }
}
