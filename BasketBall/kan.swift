//
//  kan.swift
//  BasketBall
//
//  Created by 杨志权 on 16/6/28.
//  Copyright © 2016年 杨泽奇. All rights reserved.
//

import UIKit

class kan: UIViewController {
    
    @IBOutlet weak var txtTeam1: UITextField!
    @IBOutlet weak var txtTeam2: UITextField!
    var db:SQLiteDB!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //获取数据库实例
        db = SQLiteDB.sharedInstance()
        let data = db.query("select * from Match2")
        if data.count > 0 {
            //获取最后一行数据显示
            let user = data[data.count - 1]
            txtTeam1.text = user["Team1"] as? String
            txtTeam2.text = user["Team2"] as? String
        }

        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
