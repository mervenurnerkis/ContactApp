//
//  PickerViewController.swift
//  ContactApp
//
//  Created by Merve Nur Nerkis on 23.07.2023.
//

import UIKit

protocol PickerViewControllerDelegate {
    func didSelectRelationType(_ type: RelationType)
}


class PickerViewController: UIViewController {
    
    @IBOutlet weak var filterPickerView: UIPickerView!
    
    private var selectedContactsType: RelationType?
    
    var delegate: PickerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterPickerView.delegate = self
        filterPickerView.dataSource = self
    }
    
    @IBAction func doneButtonAct(_ sender: UIButton) {
        guard let delegate = delegate else {
            print("Delegate is not set!")
            return
        }
        
        delegate.didSelectRelationType(selectedContactsType ?? .family)
        dismiss(animated: true)
        
    }
}

extension PickerViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return RelationType.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return RelationType.allCases[row].relationType
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedContactsType = RelationType.allCases[row]
    }
}
