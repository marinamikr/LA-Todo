//
//  MainViewController.swift
//  Todo
//
//  Created by 原田摩利奈 on 9/5/22.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    let realm = try! Realm()

    @IBOutlet weak var todoTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let todo: Todo? = read()
        todoTextField.text = todo?.todo
        contentTextView.text = todo?.content
        // Do any additional setup after loading the view.
    }
    
    
    func read() -> Todo? {
        return realm.objects(Todo.self).first
    }
    
    @IBAction func saveButton(){
        let todoText: String = todoTextField.text!
        let content: String = contentTextView.text!
        
        let todo: Todo? = read()
        
        if todo != nil {
            try! realm.write {
                todo!.todo = todoText
                todo!.content = content
            }
            
            } else {
                let newTodo = Todo()
                newTodo.todo = todoText
                newTodo.content = content
                try! self.realm.write {
                    self.realm.add(newTodo)
                }
            }
        
        let alert: UIAlertController = UIAlertController(title: "成功", message: "保存しました", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}
