//
//  AddViewController.swift
//  iCourses
//
//  Created by user on 1/23/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    var header = "Add a New Course"
    var delegate: AddViewControllerDelegate?
    
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var courseNameTextField: UITextField!
    @IBOutlet var courseDescTextField: UITextField!
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        if courseNameTextField.text != "" && courseDescTextField.text != "" {
            
            delegate?.addCourse(title: courseNameTextField.text!, desc: courseDescTextField.text!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerLabel.text = header
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
