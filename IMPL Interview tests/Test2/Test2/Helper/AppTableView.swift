//
//  AppTableView.swift
//  Test2
//
//  Created by Be More on 5/16/20.
//  Copyright © 2020 Yami No Mid. All rights reserved.
//

import UIKit

protocol AppScrollViewDelegate: class {
    func refreshDatas(_ view: UIView)
}

class AppTableView: UITableView {

    weak var scrollDelegate: AppScrollViewDelegate?
    var refresher = UIRefreshControl()

    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupRefreshControl()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupRefreshControl()
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()

        setupRefreshControl()

    }

    func setupRefreshControl() {

        if #available(iOS 10.0, *) {
            self.refreshControl = refresher
        } else {
            self.addSubview(refresher)
        }

        refresher.addTarget(self, action: #selector(refreshed(_:)), for: .valueChanged)
    }

    @objc func refreshed(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.refreshData()
        })
        refresher.endRefreshing()
    }

    func refreshData() {
        scrollDelegate?.refreshDatas(self)
    }

}
