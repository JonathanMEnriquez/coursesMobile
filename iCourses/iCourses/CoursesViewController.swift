//
//  ViewController.swift
//  iCourses
//
//  Created by user on 1/23/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import CoreData

class CoursesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddViewControllerDelegate {
    
    @IBOutlet var myTableView: UITableView!
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){}
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var courseArray = [Course]()
    
    func addCourse(title: String, desc: String) {
        print(title, desc)
        let course = Course(context: managedObjectContext)
        course.title = title
        course.desc = desc
        
        saveContext()
        
        dismiss(animated: true, completion: nil)
        fetchAllItemsandReload()
    }
    
    func editCourse(title: String, desc: String, indexPath: IndexPath){
        
        let course = courseArray[indexPath.row]
        course.title = title
        course.desc = desc
        
        saveContext()
        fetchAllItemsandReload()
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseArray.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let toDelete = courseArray[indexPath.row]
        
        managedObjectContext.delete(toDelete)
        
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                print("failed to delete", error)
        }
        }
        
        fetchAllItemsandReload()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "AddEditSegue", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! CustomCell
        cell.titleLabel.text = courseArray[indexPath.row].title
        cell.descLabel.text = courseArray[indexPath.row].desc
        tableView.rowHeight = 65
        return cell
    }
    
    func fetchAllItemsandReload() {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Course")
        do {
            let result = try managedObjectContext.fetch(request)
            courseArray = result as! [Course]
        } catch {
            print("oh no", error)
        }
        
        myTableView.reloadData()
    }
    
    func saveContext() {
        
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("saved")
            } catch {
                print(error)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.delegate = self
        myTableView.dataSource = self
        fetchAllItemsandReload()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        let destination = segue.destination as! AddViewController
        destination.delegate = self
        if let s = sender as? UIBarButtonItem {
            
            destination.header = "Add a New Course"
            destination.courseName = nil
            destination.myDesc = nil
            destination.indexPath = nil
        }
        else {
            destination.header = "Edit Your Course"
            let indexPath = sender as! NSIndexPath
            let myCourse = courseArray[indexPath.row]
            destination.courseName = myCourse.title
            destination.myDesc = myCourse.desc
            destination.indexPath = indexPath as IndexPath
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

