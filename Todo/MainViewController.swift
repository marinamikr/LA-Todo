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
    @IBOutlet var dateTextField: UITextField!
    
    //    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    var todoArray = [String]()
    var detailArray = [String]()
    var dateArray = [String]()
    
    var datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let todo: Todo? = read()
        todoTextField.text = todo?.todo
        contentTextView.text = todo?.content
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = toolbar
    }
    
    
    func read() -> Todo? {
        return realm.objects(Todo.self).first
    }
    
    @objc func done() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年 M月d日"
        dateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func saveButton(){
        let todoText: String = todoTextField.text!
        let content: String = contentTextView.text!
        let date: String = dateTextField.text!
        
        let todo = Todo()
               todo.todo = todoText
               todo.content = content
               todo.date = date
               
               try! realm.write {
                   realm.add(todo)
               }
        
        self.navigationController?.popToRootViewController(animated: true)

               

        
        let alert: UIAlertController = UIAlertController(title: "成功", message: "保存しました", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
