//
//  ViewController.swift
//  ToDo
//
//  Created by Soo Jang on 2022/12/15.
//

import UIKit

class ViewController: UIViewController {
    
    let plusImage = UIImage(systemName: "plus")
    
    let tableView = UITableView()
    
    let toDoManager = CoreDataManager.shared
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        tableView.delaysContentTouches = false
        setTableView()
    }
    
    func setNav() {
        view.backgroundColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.title = "Memo"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(onClickPlusButton))
    }
    
    func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 130
        tableView.separatorStyle = .none
        tableView.register(MemoTableViewCell.self, forCellReuseIdentifier: "MemoCell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 100)
        ])

    }
    
    
    @objc func onClickPlusButton() {
        print("plus button clicked")
        let editingVC = EditingViewController()
        navigationController?.pushViewController(editingVC, animated: true)
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoManager.getToDoListFromCoreData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath) as! MemoTableViewCell
        let toDoData = toDoManager.getToDoListFromCoreData()
        cell.toDoData = toDoData[indexPath.row]

        cell.closureForUpdateButton = { [weak self] (senderCell) in
            print("go to edit")
            let editVC = EditingViewController()
            editVC.toDoData = toDoData[indexPath.row]
            self?.navigationController?.pushViewController(editVC, animated: true)
        }
        
        return cell
    }
    
    
}
