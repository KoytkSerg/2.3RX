//
//  CViewController.swift
//  HW2.3
//
//  Created by Sergii Kotyk on 14/9/21.
//
// c) UITableView с выводом 20 разных имён людей и две кнопки. Одна кнопка добавляет новое случайное имя в начало списка, вторая — удаляет последнее имя. Список реактивно связан с UITableView.

//  f) Для задачи «c» добавьте поисковую строку. При вводе текста в поисковой строке, если текст не изменялся в течение двух секунд, выполните фильтрацию имён по введённой поисковой строке (с помощью оператора throttle). Такой подход применяется в реальных приложениях при поиске, который отправляет поисковый запрос на сервер, — чтобы не перегружать сервер и поисковая строка отправлялась на сервер, только когда пользователь закончит ввод (или сделает паузу во вводе).
import UIKit
import Bond


class CViewController: UIViewController {
    @IBOutlet weak var nameTableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var nameSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var names = MutableObservableArray(["Sergii", "Nick","Max","John","Mat","Bob","Mike","Jack","Dave","Alex"])
        
        var originNames = MutableObservableArray(["Sergii", "Nick","Max","John","Mat","Bob","Mike","Jack","Dave","Alex"])
        
        let nameBaseConst = ["Sergii", "Nick","Max","John","Mat","Bob","Mike","Jack","Dave","Alex"]
        
        var searchText = Observable("")
        
        names.observeNext{ _ in
            if names.isEmpty{
                self.deleteButton.isEnabled = false}
            else {
                self.deleteButton.isEnabled = true}
        }
        
        addButton.reactive.tap
            .observeNext {
                let someName = nameBaseConst.randomElement()
                names.insert(someName!, at: 0)
                originNames.insert(someName!, at: 0)
            }
        
        deleteButton.reactive.tap
            .observeNext {
                names.removeLast()
                originNames.removeLast()
            }
        
        names.bind(to: nameTableView) { (data, indexPath, nameTableView) -> UITableViewCell in
            let cell = nameTableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
            cell.textLabel?.text = data[indexPath.row]
            return cell
        }
        
        // F
        nameSearchBar.reactive.text
            .ignoreNils()
            .filter({$0.count != 0})
            .debounce(for: 2.0)

            .map({
                var text = $0
                var searchResultNames: [String] = []
                originNames.array.map({ $0.lowercased().contains(text.lowercased()) ? searchResultNames.append($0) : nil })
                print(searchResultNames)
                print(originNames.array)
                return searchResultNames
                
            })
            .bind(to: names)
        
        nameSearchBar.reactive.text
            .ignoreNils()
            .map({ $0.count == 0 ? originNames.array : names.array })
            .bind(to: names)
        
    }
   
}

