//
//  ScatterChartVC.swift
//  ChartsUnderstandAndUsage
//
//  Created by 张海峰 on 2018/9/17.
//  Copyright © 2018年 张海峰. All rights reserved.
//
//Charts框架地址
//https://github.com/danielgindi/Charts.git
//该demo地址
//https://github.com/FighterLightning/ChartsUnderstandAndUsage.git
/*散点图*/
import UIKit
import Charts
class ScatterChartVC: UIViewController {
    var scatterChartView: ScatterChartView  = ScatterChartView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ZHFColor.white
        //1.添加折线和刷新按钮
        addScatterChartAndRefreshBtn()
        
        //2. 基本样式
        setScatterChartViewBaseStyle()
        
        //3.添加（刷新数据）
        updataData()
    }
}
extension ScatterChartVC{
    //添加散点图和刷新按钮
    func addScatterChartAndRefreshBtn(){
        scatterChartView.backgroundColor = ZHFColor.white
        scatterChartView.frame.size = CGSize.init(width: 300, height: 300)
        scatterChartView.center = self.view.center
        scatterChartView.delegate = self
        self.view.addSubview(scatterChartView)
        //添加刷新按钮
        let btn: UIButton = UIButton.init(type: UIButtonType.custom)
        btn.frame = CGRect.init(x: 30, y: 84, width: 40, height: 25)
        btn.setTitle("刷新", for: UIControlState.normal)
        btn.backgroundColor = ZHFColor.red
        btn.setTitleColor(ZHFColor.zhf33_titleTextColor, for: UIControlState.normal)
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.addTarget(self, action: #selector(updataData), for: UIControlEvents.touchUpInside)
        self.view.addSubview(btn)
    }
    func setScatterChartViewBaseStyle(){
        //散点图描述
        scatterChartView.chartDescription?.text = "散点图描述"
        scatterChartView.chartDescription?.position = CGPoint.init(x: scatterChartView.frame.width - 30, y:scatterChartView.frame.height - 20)//位置（及在scatterChartView的中心点）
        scatterChartView.chartDescription?.font = UIFont.systemFont(ofSize: 12)//大小
        scatterChartView.chartDescription?.textColor = UIColor.red
        
        //图例
        let l = scatterChartView.legend
        l.wordWrapEnabled = false //显示图例
        l.horizontalAlignment = .left //居左
        l.verticalAlignment = .bottom //放在底部
        l.orientation = .horizontal //水平排布
        l.drawInside = false // 图例在外
        l.formSize = 10 //（图例大小）默认是8
        l.form = Legend.Form.circle//图例头部样式
        //矩形：.square（默认值） 圆形：.circle   横线：.line  无：.none 空：.empty（与 .none 一样都不显示头部，但不同的是 empty 头部仍然会占一个位置)
        //Y轴右侧线
        let rightAxis = scatterChartView.rightAxis
        rightAxis.axisMinimum = 0
        //Y轴左侧线
        let leftAxis = scatterChartView.leftAxis
        leftAxis.axisMinimum = 0
        //X轴
        let xAxis = scatterChartView.xAxis
        xAxis.labelPosition = .bothSided //分布在两边外部
        xAxis.axisMinimum = 0 //最小刻度值
        xAxis.granularity = 1 //最小间隔
    }
    @objc func updataData(){
        //第一组散点图的10条随机数据
        let dataEntries1 = (0..<10).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(20) )
            return ChartDataEntry(x: Double(i), y: val)
        }
        let chartDataSet1 = ScatterChartDataSet(values: dataEntries1, label: "图例1")
        chartDataSet1.setScatterShape(.circle) //使用圆形散点(三角形：.triangle 十字：.cross 叉：.x 上箭头：.chevronUp  下箭头：.chevronDown)
        chartDataSet1.setColor(.yellow)
        chartDataSet1.scatterShapeSize = 10 //散点大小
        chartDataSet1.scatterShapeHoleRadius = 2.5 //内点大小
        chartDataSet1.scatterShapeHoleColor = .red //内点颜色
       
        //第二组散点图的10条随机数据
        let dataEntries2 = (0..<10).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(20) + 20)
            return ChartDataEntry(x: Double(i), y: val)
        }
        let chartDataSet2 = ScatterChartDataSet(values: dataEntries2, label: "图例2")
        chartDataSet2.setColor(.red)
        chartDataSet2.scatterShapeSize = 10 //散点大小
        chartDataSet2.scatterShapeHoleRadius = 2.5 //内点大小
        chartDataSet2.scatterShapeHoleColor = .yellow //内点颜色
        //第三组散点图的10条随机数据
        let dataEntries3 = (0..<10).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(20) + 40)
            return ChartDataEntry(x: Double(i), y: val)
        }
        let chartDataSet3 = ScatterChartDataSet(values: dataEntries3, label: "图例3")
        chartDataSet3.setScatterShape(.x)//使用圆形散点(三角形：.triangle 十字：.cross 叉：.x 上箭头：.chevronUp  下箭头：.chevronDown)
        chartDataSet3.setColor(.green)
        //目前散点图包括2组数据
        let chartData = ScatterChartData(dataSets: [chartDataSet1, chartDataSet2,chartDataSet3])
        
        //设置散点图数据
        scatterChartView.data = chartData
    }
}
extension ScatterChartVC: ChartViewDelegate{
    //1.点击选中
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        ZHFLog(message: "点击选中")
    }
    //2.没有选中
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        ZHFLog(message: "没有选中")
    }
    //3.捏合放大或缩小
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        ZHFLog(message: "捏合放大或缩小")
    }
    //4.拖拽图表
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        ZHFLog(message: "拖拽图表")
    }
}
