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
import Moya
import SwiftyJSON
import HandyJSON
import Kingfisher
class NWHomeListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var channelId : String?
    
    let header = MJRefreshNormalHeader()
    let footer = MJRefreshAutoNormalFooter()
    var pageIndex : Int = 1
    
    var datas = [NWHomePageListDataModel]()

    //tableView
    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NWSingalTitleCell.self, forCellReuseIdentifier: NSStringFromClass(NWSingalTitleCell.self))
        tableView.register(NWImageViewCell.self, forCellReuseIdentifier: NSStringFromClass(NWImageViewCell.self))
        return tableView
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        //顶部刷新
        header.setRefreshingTarget(self, refreshingAction: #selector(headRefresh))
        header.setTitle("松开即可刷新状态哦...", for: .pulling)
        header.setTitle("刷新中...", for: .refreshing)
        tableView.mj_header = header
        //底部刷新
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        tableView.mj_footer = footer
        tableView.mj_header?.beginRefreshing()
    }
    @objc func headRefresh() {
        pageIndex = 1
        let provider = MoyaProvider<HttpRequest>()
        provider.request(.getHomePageNewsListAPI(siteId: wnj_siteId, channelId: channelId!, regionCode: 0, userId: "", pageIndex: pageIndex, pageSize: 20)) { (result) in
            switch result {
            case let .success(response):
                self.tableView.mj_header?.endRefreshing()
                let jsonString = String(data: response.data, encoding: .utf8)
                
                let dict = getDictionaryFromJSONString(jsonString: jsonString!)
                print(dict)
                
                let model = JSONDeserializer<NWHomePageListModel>.deserializeFrom(json: jsonString)
                self.datas.removeAll()
                self.datas = model?.Data?.list ?? []
                self.tableView.reloadData()
                
            case let .failure(error):
                self.tableView.mj_header?.endRefreshing()
                print(error)
                
            }
            
        }
        
    }
    @objc func footerRefresh() {
        pageIndex += 1
        let provider = MoyaProvider<HttpRequest>()
        provider.request(.getHomePageNewsListAPI(siteId: wnj_siteId, channelId: channelId!, regionCode: 0, userId: "", pageIndex: pageIndex, pageSize: 20)) { (result) in
            switch result {
            case let .success(response):
                self.tableView.mj_footer?.endRefreshing()
                let jsonString = String(data: response.data, encoding: .utf8)
                //json字符串转字典可以清晰看到返回结果层级
                let dict = getDictionaryFromJSONString(jsonString: jsonString!)
                print(dict)
                
                //第二步.HandyJSON转成Model
                let model = JSONDeserializer<NWHomePageListModel>.deserializeFrom(json: jsonString)
                
                if (model?.Data?.list?.count)! > 0 {
                    self.datas .append(contentsOf: (model?.Data?.list)!)
                }else {
                    self.tableView.mj_footer?.endRefreshingWithNoMoreData()
                }
                self.tableView.reloadData()
                
            case  let .failure(error):
                self.tableView.mj_footer?.endRefreshing()
                print(error)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model : NWHomePageListDataModel = datas[indexPath.row]
        if model.newsType == "news" {
                if model.newsCoverList!.count > 0 {
            let cell : NWImageViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(NWImageViewCell.self),for: indexPath) as! NWImageViewCell
            cell.titleLab?.text = model.newsTitle
            cell.imaV?.kf.setImage(with: URL(string: (model.newsCoverList?[0])!))
            cell.authorLab?.text = model.userName
            cell.commentLab?.text = "\(String(model.commentCount!,radix: 10)) 评论"
            cell.timeLab?.text = model.newsPublishTime

            return cell
        }else {
            let cell : NWSingalTitleCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(NWSingalTitleCell.self),for: indexPath) as! NWSingalTitleCell
            cell.titleLab?.text = model.newsTitle
                      cell.authorLab?.text = model.userName
                      cell.commentLab?.text = "\(String(model.commentCount!,radix: 10)) 评论"
                      cell.timeLab?.text = model.newsPublishTime
            return cell
        }
        }
        let cell : NWSingalTitleCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(NWSingalTitleCell.self),for: indexPath) as! NWSingalTitleCell
        cell.titleLab?.text = model.newsTitle
                  cell.authorLab?.text = model.userName
                  cell.commentLab?.text = "\(String(model.commentCount!,radix: 10)) 评论"
                  cell.timeLab?.text = model.newsPublishTime
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 44
    //    }
    //
    
}

extension NWHomeListViewController : JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
