//
//  ViewController.swift
//  ChartsUnderstandAndUsage
//
//  Created by 张海峰 on 2018/9/12.
//  Copyright © 2018年 张海峰. All rights reserved.
//
//Charts框架地址
//https://github.com/danielgindi/Charts.git
//该demo地址
//https://github.com/FighterLightning/ChartsUnderstandAndUsage.git
import UIKit
//设备物理尺寸
let ScreenHeight = UIScreen.main.bounds.size.height
let ScreenWidth = UIScreen.main.bounds.size.width
private struct ItemMessage{
    let title: String
    let subtitle: String
    let imageName: String
    let `class` : AnyClass
}
class ViewController: UIViewController {
    var tableView:UITableView!
    private var ItemMessages =
        [ItemMessage.init(title: "柱状图", subtitle: "Bar Chart(A simple demonstration of the bar chart.)", imageName: "barChartImage", class: BarChartVC.self),
         ItemMessage.init(title: "饼状图", subtitle: "Pie Chart(A simple demonstration of the pie chart.)", imageName: "pieChartImage", class: PieChartVC.self),
         ItemMessage.init(title: "饼状图（半圆形）", subtitle: "Half Pie Chart (A simple demonstration of the pie chart.)", imageName: "pieChartHalfImage", class: PieChartHalfVC.self),
         ItemMessage.init(title: "雷达图", subtitle: "Radar Chart(Demonstrates the use of a spider-web like (net) chart.)", imageName: "radarChartImage", class: RadarChartVC.self),
         ItemMessage.init(title: "折线图", subtitle: "Line Chart(A simple demonstration of the linechart.)", imageName: "lineChartImage", class: LineChartVC.self),
         ItemMessage.init(title: "折线填充图", subtitle: "Line Filled Chart(This demonstrates how to fill an area between two LineDataSets.)", imageName: "lineFilledChartImage", class: LineFilledChartVC.self),
         ItemMessage.init(title: "散点图", subtitle: "Scatter Chart(A simple demonstration of the scatter chart.)", imageName: "scatterChartImage", class: ScatterChartVC.self),
         ItemMessage.init(title: "K 线图（烛形图）", subtitle: "CandleStick Chart(Demonstrates usage of the CandleStickChart.)", imageName: "candleStickChartImage", class: CandleStickChartVC.self),
         ItemMessage.init(title: "气泡图", subtitle: "Bubble Chart(A simple demonstration of the bubble chart.)", imageName: "bubbleChartImage", class: BubbleChartVC.self),
         ItemMessage.init(title: "组合图(混合图)", subtitle: "Combined Chart(Demonstrates how to create a combined chart (bar and line in this case).", imageName: "combinedChartImage", class: CombinedChartVC.self),]
    lazy var dataMarr:NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Charts框架理解与使用"
        self.addTableView()
    }
    func addTableView(){
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 44, width: ScreenWidth, height: ScreenHeight - 44), style: UITableViewStyle.plain)
        self.view.addSubview(tableView)
        tableView.backgroundColor = ZHFColor.zhff9_backGroundColor
        tableView.separatorColor = ZHFColor.zhf_strColor(hex: "cccccc")
        tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 25, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
    }
}
extension ViewController :UITableViewDataSource,UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ItemMessages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemMessage = self.ItemMessages[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style:UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        }
        cell?.textLabel?.text = itemMessage.title
        cell?.textLabel?.textColor = ZHFColor.red
        cell?.detailTextLabel?.text = itemMessage.subtitle
        cell?.detailTextLabel?.textColor = ZHFColor.zhf66_contentTextColor
        cell?.detailTextLabel?.numberOfLines = 0
        cell?.imageView?.image = UIImage.init(named: itemMessage.imageName)
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemMessage = self.ItemMessages[indexPath.row]
        let vcClass = itemMessage.class as! UIViewController.Type
        let vc = vcClass.init()
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

