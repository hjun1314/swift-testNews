//
//  NWHomeListViewController.swift
//  testNews
//
//  Created by hjun on 2020/8/6.
//  Copyright © 2020 GD. All rights reserved.
//

import UIKit
import JXSegmentedView
import MJRefresh
class NWHomeListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   //tableView
    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NWSingalTitleCell.self, forCellReuseIdentifier: NSStringFromClass(NWSingalTitleCell.self))
        return tableView
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
               tableView.snp.makeConstraints { (make) in
                   make.edges.equalTo(view)
               }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : NWSingalTitleCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(NWSingalTitleCell.self),for: indexPath) as! NWSingalTitleCell
        cell.titleLab?.text = "asddasd"

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
  

}

extension NWHomeListViewController : JXSegmentedListContainerViewListDelegate {
      func listView() -> UIView {
          return view
      }
  }
