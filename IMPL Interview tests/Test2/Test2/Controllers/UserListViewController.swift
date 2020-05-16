//
//  UserListViewController.swift
//  Test2
//
//  Created by Be More on 5/15/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import UIKit

enum LoadApiType {
    case normal
    case refresh
    case loadMore
}


class UserListViewController: UIViewController {
    
    var fetchingMore = false
    
    var hasMoreData = true
    
    var listUserData: [UserListModel] = [UserListModel]()
    
    var currentPage: Int = 1
    
    let viewLoadFail: LoadingFailView = {
        let view = LoadingFailView()
        return view
    }()
    
    let viewLoading: LoadingView = {
        let view = LoadingView()
        return view
    }()
    
    lazy var userTableView: AppTableView = {
        let tableView = AppTableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.scrollDelegate = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        getData()
    }
    
    private func setUpViews() {
        self.view.backgroundColor = UIColor(hexString: "#E5E5E5")
        // table view constraints
        self.view.addSubview(self.userTableView)
        self.userTableView.fillSuperView()
        self.userTableView.rowHeight = UITableView.automaticDimension
        self.userTableView.estimatedRowHeight = 80
        UserTableViewCell.registerCellByClass(self.userTableView)
        LoadingTableViewCell.registerCellByClass(self.userTableView)
        
        self.view.addSubview(self.viewLoading)
        self.viewLoading.fillSuperView()
        
        self.view.addSubview(self.viewLoadFail)
        self.viewLoadFail.fillSuperView()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
        if bottomEdge >= scrollView.contentSize.height {
            if scrollView.contentOffset.y >= 0 {
                if !self.fetchingMore {
                    self.handleFetchingMore()
                }
            }
        }
    }
    
    private func handleFetchingMore() {
        self.fetchingMore = true
        self.userTableView.reloadSections(IndexSet(integer: 1), with: .none)
        self.getData(loadType: .loadMore)
    }
    
    private func getData(loadType: LoadApiType = .normal) {
        self.viewLoadFail.hide()
        if loadType == .loadMore {
            self.currentPage += 1
        } else if loadType == .normal {
            self.viewLoading.show()
            self.currentPage = 1
        } else {
            self.currentPage = 1
        }
        
        Api.shared.getUserListData(pageNumber: self.currentPage, pageSize: 10) { [weak self] (success, listData) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.viewLoading.hide()
                if success {
                    guard let listUserData = listData else {
                        return
                    }
                    self.handleGetDataSuccess(loadType: loadType, lisData: listUserData)
                } else {
                    self.handleGetDataFail()
                }
            }
        }
    }
    
    private func handleGetDataSuccess(loadType: LoadApiType, lisData: [UserListModel]) {
        if loadType != .loadMore {
            self.hasMoreData = true
            self.listUserData.removeAll()
        } else {
            if lisData.isEmpty {
                self.hasMoreData = false
            }
        }
        
        self.listUserData.append(contentsOf: lisData)
        self.fetchingMore = false
        if hasMoreData {
            self.userTableView.reloadData()
        }
    }
    
    private func handleGetDataFail() {
        self.viewLoading.hide()
        self.viewLoadFail.show()
        self.viewLoadFail.setErrorMessage(errorMessage: "Có Lỗi")
        self.viewLoadFail.buttonAction = {
            self.getData()
            self.viewLoadFail.hide()
        }
    }
}

// MARK: - UITableViewDelegate
extension UserListViewController: UITableViewDelegate {
}

// MARK: - UITableViewDataSource
extension UserListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
             return self.listUserData.count
        } else if section == 1 && self.fetchingMore {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        if section == 0 {
            guard let cell = UserTableViewCell.loadCell(tableView, indexPath: indexPath) as? UserTableViewCell else {
                return BaseTBCell()
            }
            cell.setData(data: self.listUserData[indexPath.row])
            return cell
        } else {
            guard let cell = LoadingTableViewCell.loadCell(tableView, indexPath: indexPath) as? LoadingTableViewCell else {
                return BaseTBCell()
            }
            cell.spinner.startAnimating()
            cell.setUpCell(hasMoreData: self.hasMoreData)
            return cell
        }
    }
}

extension UserListViewController: AppScrollViewDelegate {
    func refreshDatas(_ view: UIView) {
        self.getData(loadType: .refresh)
    }
}
