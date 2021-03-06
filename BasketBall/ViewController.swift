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
    
    
    
    var TwityFour:NSTimer!
    var Sixty:NSTimer!
    var TweleveMinute:NSTimer!
    var DateTime:NSTimer!
    
    var twityfour:Int = 24
    var tweleveminute:Int = 720
    var sixty_:Int = 60
    
    var operation:String = ""
    
    
    var grade1:Int=0;
    var grade2:Int=0;
    var cancel1:Int=0;
    var cancel2:Int=0;
    
    var rule_1:Int=0;
    var rule_2:Int=0;
    var pause_1:Int=0;
    var pause_2:Int=0;
    @IBOutlet weak var twity_four: UILabel!
    @IBOutlet weak var Sixty_jishi: UILabel!
    
    @IBOutlet weak var match_news: UILabel!
    
    
    @IBOutlet weak var Score1: UITextField!
    @IBOutlet weak var Score2: UITextField!
    
    @IBOutlet weak var Pause1: UITextField!
    @IBOutlet weak var Pause2: UITextField!
    
    
    @IBOutlet weak var Rule1: UITextField!
    @IBOutlet weak var Rule2: UITextField!
    
    @IBOutlet weak var Sevenhum: UILabel!
    
    
    @IBOutlet weak var time: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //获取数据库实例
        db = SQLiteDB.sharedInstance()
        //如果表还不存在则创建表（其中uid为自增主键）
        db.execute("create table if not exists Match2(uid integer primary key,Team1 varchar(20),Team2 varchar(20))")
        //如果有数据则加载
        initUser()
    }
    
    
    @IBAction func StartMatch(sender: AnyObject) {
        Score1.text = "000"
        Score2.text = "000"
        
        tf()
        Match_Time()
        CurrentTime()
        
    }
    
    
    @IBAction func Match_Over(sender: AnyObject) {
        //
        var str:String="获得了胜利！"
        
        if Int(Score1.text!)>Int(Score2.text!)
        {
            match_news.text = txtTeam1.text!+str
        }
        else
        {
            match_news.text = txtTeam2.text!+str
        }
        saveUser()
    }
    //显示保存结果
    @IBAction func Show(sender: AnyObject) {
        ShowNews()
    }
    
    //从SQLite加载数据
    func initUser() {
        let data = db.query("select * from Match2")
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
        let sql = "insert into Match2(Team1,Team2) values('\(team1)','\(team2)')"
        print("sql: \(sql)")
        //通过封装的方法执行sql
        let result = db.execute(sql)
        print(result)
    
    }
    
    
    
    //显示保存结果
    func ShowNews() {
        let data = db.query("select * from Match2")
        if data.count > 0 {
            //获取最后一行数据显示
            let user = data[data.count - 1]
            txtTeam1.text = user["Team1"] as? String
            txtTeam2.text = user["Team2"] as? String
        }
        
    }
    //实现鼠标点击textfield控件，textfield中的提示信息消失
    func textFieldShouldReturn(txtTeam1: UITextField!) -> Bool
    {
        txtTeam1.resignFirstResponder()
        return true;
    }
    
    //当暂停或者犯规后，使用24回表功能
    
    
    
    func tf() {
        //24秒计时
        // 启用计时器，控制每秒执行一次tickDown方法
        TwityFour = NSTimer.scheduledTimerWithTimeInterval(1,target:self,selector:Selector("tickDown"),userInfo:nil,repeats:true)
        
    }
    

    @IBAction func twity_four_Stop(sender: AnyObject) {
        TwityFour.invalidate()
        
    }
    //计时器每秒触发事件
    
    func tickDown()
    {
        twityfour--
        let sec = twityfour%60
        twity_four.text = String(sec)
        if twityfour==1 {
            twityfour = 24
        }
        //看电脑上有无代码
        
    }
    
    
    func Wait() {
        //60秒计时
        // 启用计时器，控制每秒执行一次tick方法
        TwityFour = NSTimer.scheduledTimerWithTimeInterval(1,target:self,selector:Selector("tick"),userInfo:nil,repeats:true)
    }
    
    func tick() {
        sixty_--
        let sec = sixty_%60
        let min = sixty_/60
        Sixty_jishi.text = String(min) + ":" + String(sec)
        
    }
    
    func Match_Time() {
        //720秒计时
        // 启用计时器，控制每秒执行一次tick方法
        TweleveMinute = NSTimer.scheduledTimerWithTimeInterval(1,target:self,selector:Selector("tickd"),userInfo:nil,repeats:true)
    }
    
    func tickd() {
        
        tweleveminute--
        let sec = tweleveminute%60
        let min = tweleveminute/60
        Sevenhum.text = String(min) + ":" + String(sec)
        
    }
    
    @IBAction func HuiBiao(sender: UIButton) {
        twityfour = 24
    }
    
    
    func CurrentTime() {
        //获取系统的当前时间
        var date = NSDate()
        var timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "yyy-MM-dd 'at' HH:mm:ss.SSS"
        var strNowTime = timeFormatter.stringFromDate(date) as String
        time.text = strNowTime
    }
    

    //停止计时
    //TwityFour.invalidate()
    /*
    if remainingSeconds <= 0 {
    let alert = UIAlertView()
    alert.title = "计时完成,进入下一节比赛！"
    alert.message = ""
    alert.addButtonWithTitle("OK")
    alert.show()*/
    
    
    
    
    @IBAction func Continue(sender: AnyObject) {
        //24秒计时
        tf()
        //等待时间计时
        Wait()
    }
    
    
    @IBAction func Pause1(sender: AnyObject) {
        //暂停之后，24秒暂停看是谁的球权；比赛时间暂停；当前时间继续；等待时间计时开始；当前队伍暂停计数加1
        twity_four.text = "24"
        TweleveMinute.invalidate()
        
    }
    
    @IBAction func Pause2(sender: AnyObject) {
        //暂停之后，24秒暂停看是谁的球权；比赛时间暂停；当前时间继续；等待时间计时开始；当前队伍暂停计数加1
        twity_four.text = "24"
        TweleveMinute.invalidate()
        
    }
    
    @IBAction func Rule1(sender: AnyObject) {
        //犯规之后，24秒暂停看是谁的球权；比赛时间暂停；当前时间继续；等待时间计时开始；当前队伍犯规计数加1
        
    }
    
    @IBAction func Rule2(sender: AnyObject) {
        //犯规之后，24秒暂停看是谁的球权；比赛时间暂停；当前时间继续；等待时间计时开始；当前队伍犯规计数加1
        
    }
    
    //加分操作
    @IBAction func ADD1(sender: UIButton) {
        grade1+=1;
        Score1.text=String(grade1);
        cancel1=1;
    }
    
    @IBAction func ADD2(sender: UIButton) {
        grade1+=2;
        Score1.text=String(grade1);
        cancel1=2;
    }
    
    
    @IBAction func ADD3(sender: UIButton) {
        grade1+=3;
        Score1.text=String(grade1);
        cancel1=3;
    }
    
    
    @IBAction func BDD1(sender: UIButton) {
        grade2+=1;
        Score2.text=String(grade2);
        cancel2=1;
    }
    
    @IBAction func BDD2(sender: UIButton) {
        grade2+=2;
        Score2.text=String(grade2);
        cancel2=2;
    }
    
    
    @IBAction func BDD3(sender: UIButton) {
        grade2+=3;
        Score2.text=String(grade2);
        cancel2=3;
    }
    
    @IBAction func RuleAdd(sender: UIButton) {
        rule_1 += 1;
        Rule1.text = String(rule_1)
        //判断暂停次数限制
    }
    
    
    @IBAction func RuleBdd(sender: UIButton) {
        rule_2 += 1;
        Rule2.text = String(rule_2)
        //判断暂停次数限制
    }
    
    
    
    @IBAction func PauseAdd(sender: UIButton) {
        pause_1 += 1;
        Pause1.text = String(pause_1)
        //判断犯规次数限制
    }
    
    
    @IBAction func PauseBdd(sender: UIButton) {
        pause_2 += 1;
        Pause2.text = String(pause_2)
        //判断犯规次数限制
        
    }
    
    @IBAction func CancelA(sender: UIButton) {
        Score1.text = String(Int(Score1.text!)! - cancel1);
        grade1-=cancel1;
    }
    
    @IBAction func CancelB(sender: UIButton) {
        Score2.text = String(Int(Score2.text!)! - cancel2);
        grade2-=cancel2;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

