//
//  NWHomeListViewController.swift
//  testNews
//
//  Created by hjun on 2020/8/6.
//  Copyright © 2020 GD. All rights reserved.
//

import UIKit
import JXSegmentedView

class NWHomeListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

  

}

extension NWHomeListViewController : JXSegmentedListContainerViewListDelegate {
      func listView() -> UIView {
          return view
      }
  }
