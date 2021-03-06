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
    var courseName:String?
    var myDesc:String?
    var indexPath:IndexPath?
    var delegate: AddViewControllerDelegate?
    
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var courseNameTextField: UITextField!
    @IBOutlet var courseDescTextField: UITextField!
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        if let myIP = indexPath {
            
            delegate?.editCourse(title: courseNameTextField.text!, desc: courseDescTextField.text!, indexPath: myIP)
        }
        else if courseNameTextField.text != "" && courseDescTextField.text != "" {
            
            delegate?.addCourse(title: courseNameTextField.text!, desc: courseDescTextField.text!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerLabel.text = header
        if let course = courseName {
            
            courseNameTextField.text = course
        }
        if let desc = myDesc {
            
            courseDescTextField.text = desc
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
