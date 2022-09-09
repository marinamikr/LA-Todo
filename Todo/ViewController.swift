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
        
        
        let result = realm.objects(Todo.self)

        table.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        data = realm.objects(Todo.self).map({ $0 })
        
        print("\(result)これ")

    }
    
//    @IBAction func editButton() {
//
//    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let userData = realm.objects(Todo.self)
                return userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TableViewCell
        
               let userData = realm.objects(Todo.self)
        cell.todoLabel?.text = "\(userData[indexPath.row].todo)"
        cell.contentLabel?.text = "\(userData[indexPath.row].content)"
        cell.dateLabel?.text = "\(userData[indexPath.row].date)"
        
        print("\(userData[indexPath.row].todo)これ")
        
               return cell
    }
    
    
      func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
          switch editingStyle {
          case .delete:
              data.remove(at: indexPath.row)
              let target = realm.objects(Todo.self)[indexPath.row]
              do{
                try realm.write{
                  realm.delete(target)
                    print("消えたよ")
                    print("\(realm.objects(Todo.self))これ")
                }
              }catch {
                print("Error \(error)")
              }
              
              table.beginUpdates()
              table.deleteRows(at: [indexPath], with: .automatic)
              table.endUpdates()
          case .insert, .none:
              // NOP
              break
          }
          
//          func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//                  let action = UIContextualAction(style: .destructive,
//                                                  title: "消すで！") { (action, view, completionHandler) in
//                      self.showAlert(deleteIndexPath: indexPath)
//                      completionHandler(true)
//                  }
//                  action.backgroundColor = .orange
//                  let configuration = UISwipeActionsConfiguration(actions: [action])
//                  return configuration
//              }
//
//              func showAlert(deleteIndexPath indexPath: IndexPath) {
//                  let dialog = UIAlertController(title: "セル消すで！",
//                                                 message: "ほんまに消してええんか？",
//                                                 preferredStyle: .alert)
//                  dialog.addAction(UIAlertAction(title: "消す", style: .default, handler: { (_) in
//                      self.array.remove(at: indexPath.row)
//                      self.tableView.deleteRows(at: [indexPath], with: .automatic)
//                  }))
//                  dialog.addAction(UIAlertAction(title: "嫌や", style: .cancel, handler: nil))
//                  self.present(dialog, animated: true, completion: nil)
//              }
    
      }
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//          let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
//              //削除処理を記述
//              let results = realm.objects(Todo.self).filter()
//
//              try! realm.write {
//                  realm.delete(results)
//              }
//
//
//              completionHandler(true)
//          }
//
//          return UISwipeActionsConfiguration(actions: [deleteAction])
//      }
//
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

    

