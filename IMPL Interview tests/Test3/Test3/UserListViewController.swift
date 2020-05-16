//
//  UserListViewController.swift
//  Test3
//
//  Created by Be More on 5/16/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserListViewController: UIViewController {
    
    var userListModel = [UserModel]()
    
    lazy var userTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        getData()
    }
    
    private func setUpViews() {
        self.navigationController?.navigationBar.isHidden = true
        // set up table view
        self.view.addSubview(self.userTableView)
        self.userTableView.fillSuperView()
        UserTableViewCell.registerCellByClass(self.userTableView)
    }
    
    private func getData() {
        Api.shared.getUserData { [weak self] (success, path, data) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                if success, let dataRsp = data {
                    self.userListModel = dataRsp
                    self.userTableView.reloadData()
                }
            }
        }
    }
}


// MARK: - UITableViewDelegate
extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UserDetailViewController()
        vc.data = self.userListModel[indexPath.row]
        vc.index = indexPath.row
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension UserListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.userListModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = UserTableViewCell.loadCell(tableView, indexPath: indexPath) as? UserTableViewCell else {
            return BaseTBCell()
        }
        cell.setData(data: self.userListModel[indexPath.row])
        return cell
    }
}

// MARK: - SaveData
extension UserListViewController: SaveData {
    func saveData(indexPath: Int, data: UserModel) {
        self.userListModel[indexPath] = data
        self.userTableView.reloadData()
    }
}
