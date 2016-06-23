//
//  ViewController.swift
//  BasketBall
//
//  Created by 杨志权 on 16/6/23.
//  Copyright © 2016年 杨泽奇. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var db:SQLiteDB!
    
    @IBOutlet var txtTeam1: UITextField!
    @IBOutlet var txtTeam2: UITextField!
    
    var timer:NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //获取数据库实例
        db = SQLiteDB.sharedInstance()
        //如果表还不存在则创建表（其中uid为自增主键）
        db.execute("create table if not exists Match(uid integer primary key,Team1 varchar(20),Team2 varchar(20),mobile varchar(20))")
        //如果有数据则加载
        initUser()
    }
    
    //点击保存
    @IBAction func saveClicked(sender: AnyObject) {
        saveUser()
    }
    //显示保存结果
    @IBAction func Show(sender: AnyObject) {
        ShowNews()
    }
    
    //从SQLite加载数据
    func initUser() {
        let data = db.query("select * from Match")
        if data.count > 0 {
            //获取最后一行数据显示
            let user = data[data.count - 1]
            txtTeam1.text = user["Team1"] as? String
            txtTeam2.text = user["Team2"] as? String
        }
    }
    
    //保存数据到SQLite
    func saveUser() {
        let team1 = self.txtTeam1.text!
        let team2 = self.txtTeam2.text!
        //插入数据库，这里用到了esc字符编码函数，其实是调用bridge.m实现的
        let sql = "insert into Match(Team1,Team2) values('\(team1)','\(team2)')"
        print("sql: \(sql)")
        //通过封装的方法执行sql
        let result = db.execute(sql)
        print(result)
    
    }
    
    //显示保存结果
    func ShowNews() {
        let data = db.query("select * from Match")
        if data.count > 0 {
            //获取最后一行数据显示
            let user = data[data.count - 1]
            txtTeam1.text = user["Team1"] as? String
            txtTeam2.text = user["Team2"] as? String
        }
        
    }
    
    func textFieldShouldReturn(txtTeam1: UITextField!) -> Bool
    {
        txtTeam1.resignFirstResponder()
        return true;
    }
    
    //当暂停或者犯规后，使用24回表功能
    
    
    //计时
    // 启用计时器，控制每秒执行一次tickDown方法
    /*timer = NSTimer.scheduledTimerWithTimeInterval(1,target:self,selector:Selector("tickDown"),userInfo:nil,repeats:true)
}

//计时器每秒触发事件

func tickDown()
{
    print("tick...")
}
//停止计时
timer.invalidate()
if remainingSeconds <= 0 {
let alert = UIAlertView()
alert.title = "计时完成！"
alert.message = ""
alert.addButtonWithTitle("OK")
alert.show()*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

