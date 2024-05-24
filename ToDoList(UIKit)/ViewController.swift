//
//  ViewController.swift
//  ToDoList(UIKit)
//
//  Created by 김형준 on 5/24/24.
//

import UIKit


class ViewController: UITableViewController, AddViewControllerDelegate, CheckboxCellDelegate {
     let userDefaultsKey = "key"
    
    func checkboxCellDidToggle(_ cell: CheckboxCellTableViewCell, isChecked: Bool) {

        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        let task = tasklist[indexPath.row].task
    
        if isChecked {
            tasklist.removeAll(where: { $0.task == task })
            tasklist.append(TaskList(task: task, check: true))
            
        } else {
            tasklist.removeAll(where: { $0.task == task })
            tasklist.insert(TaskList(task: task, check: false), at: 0)
        }
        saveTasks()
        tableView.reloadData()
    }
    
    
//    private var tasklist = ["밥먹기", "똥싸기"]
    
    func addTask(_ task: String) {
        tasklist.insert(TaskList(task: task), at: 0)
        tableView.reloadData()
        saveTasks()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return tasklist.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CheckboxCellTableViewCell(style: .default, reuseIdentifier: "CheckboxCell")
        /*tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)*/
        cell.configure(tasklist[indexPath.row].task, isChecked: tasklist[indexPath.row].check)
        cell.checkboxDelegate = self
        if tasklist[indexPath.row].check {
            cell.backgroundColor = .gray }
        return cell
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasklist.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveTasks()
        }
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadTasks()
        tableView.delegate = self
        self.title = "To do List"
        // 네비게이션 바 스타일 설정
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.barTintColor = .white
        // 왼쪽 바버튼 아이템 추가
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addList))
        rightButton.tintColor = .white
        navigationItem.rightBarButtonItem = rightButton
        
        let leftButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(delete2))
        leftButton.tintColor = .white
        navigationItem.leftBarButtonItem = leftButton
        
        tableView.dataSource = self
        tableView.register(CheckboxCellTableViewCell.self, forCellReuseIdentifier: CheckboxCellTableViewCell.identifier)
    }

    @objc func addList() {
        
        let addViewController = addViewController()
        addViewController.delegate = self
        self.navigationController?.present(addViewController, animated: true)
        

    }
    @objc func delete2() {
        
    }
    
    func saveTasks() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tasklist) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    func loadTasks() {
        if let dataIs = UserDefaults.standard.data(forKey: userDefaultsKey) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([TaskList].self, from: dataIs) {
                tasklist = decoded
            }
        }
    }
}
