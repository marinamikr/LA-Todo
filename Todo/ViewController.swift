//
//  ViewController.swift
//  Todo
//
//  Created by 原田摩利奈 on 9/5/22.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet var table: UITableView!
    
    var data = [Todo]()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        
        table.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        data = realm.objects(Todo.self).map({ $0 })
        
        let result = realm.objects(Todo.self).value(forKey: "name")
        print(result)

    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TableViewCell
        cell.textLabel?.text = data[indexPath.row].todo
        return cell
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//          tableView.deselectRow(at: indexPath, animated: true)
//          let item = data[indexPath.row]
//          guard let vc = storyboard?.instantiateViewController(identifier: "view") as? ViewViewController else { return }
//          vc.item = item
//          vc.deletionHandler = { [weak self] in self?.refresh() }
//          vc.navigationItem.largeTitleDisplayMode = .never
//          vc.title = item.item
//          navigationController?.pushViewController(vc, animated: true)
//      }
//
//      @IBAction func didTapAddButton(_ sender: Any) {
//          guard let vc = storyboard?.instantiateViewController(identifier: "enter") as? EntryViewController else { return }
//          vc.completionHandler = { [weak self] in self?.refresh()
//          }
//          vc.title = "New Item"
//          vc.navigationItem.largeTitleDisplayMode = .never
//          navigationController?.pushViewController(vc, animated: true)
//      }
//
//      func refresh() {
//          data = realm.objects(ToDoListItem.self).map({ $0 })
//          table.reloadData()
//      }
  }

    

