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
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var courseArray = [Course]()
    
    func addCourse(title: String, desc: String) {
        print(title, desc)
        let course = Course(context: managedObjectContext)
        course.title = title
        course.desc = desc
        
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("saved")
            } catch {
                print(error)
            }
        }
        
        dismiss(animated: true, completion: nil)
        fetchAllItemsandReload()
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

    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.delegate = self
        myTableView.dataSource = self
        fetchAllItemsandReload()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        let destination = segue.destination as! AddViewController
        destination.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

