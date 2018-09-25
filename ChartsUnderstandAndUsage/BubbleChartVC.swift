//
//  BubbleChartVC.swift
//  ChartsUnderstandAndUsage
//
//  Created by 张海峰 on 2018/9/17.
//  Copyright © 2018年 张海峰. All rights reserved.
//
//Charts框架地址
//https://github.com/danielgindi/Charts.git
//该demo地址
//https://github.com/FighterLightning/ChartsUnderstandAndUsage.git
/*气泡图*/
import UIKit
import Charts
class BubbleChartVC: UIViewController {
    var bubbleChartView: BubbleChartView  = BubbleChartView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ZHFColor.white
        //1.添加气泡图和刷新按钮
        addBubbleChartAndRefreshBtn()
        
        //2. 基本样式
        setBubbleChartViewBaseStyle()
        
        //3.添加（刷新数据）
        updataData()
    }
}
extension BubbleChartVC{
    //添加气泡图和刷新按钮
    func addBubbleChartAndRefreshBtn(){
        bubbleChartView.backgroundColor = ZHFColor.white
        bubbleChartView.frame.size = CGSize.init(width: 300, height: 300)
        bubbleChartView.center = self.view.center
        bubbleChartView.delegate = self
        self.view.addSubview(bubbleChartView)
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
    func setBubbleChartViewBaseStyle(){
        //气泡图描述
        bubbleChartView.chartDescription?.text = "气泡图描述"
        bubbleChartView.chartDescription?.position = CGPoint.init(x: bubbleChartView.frame.width - 30, y:bubbleChartView.frame.height - 20)//位置（及在bubbleChartView的中心点）
        bubbleChartView.chartDescription?.font = UIFont.systemFont(ofSize: 12)//大小
        bubbleChartView.chartDescription?.textColor = UIColor.red
        
        //图例
        let l = bubbleChartView.legend
        l.wordWrapEnabled = false //显示图例
        l.horizontalAlignment = .left //居左
        l.verticalAlignment = .bottom //放在底部
        l.orientation = .horizontal //水平排布
        l.drawInside = false // 图例在外
        l.formSize = 10 //（图例大小）默认是8
        l.form = Legend.Form.circle//图例头部样式
        //矩形：.square（默认值） 圆形：.circle   横线：.line  无：.none 空：.empty（与 .none 一样都不显示头部，但不同的是 empty 头部仍然会占一个位置)
        //Y轴右侧线
        let rightAxis = bubbleChartView.rightAxis
        rightAxis.axisMinimum = 0
        //Y轴左侧线
        let leftAxis = bubbleChartView.leftAxis
        leftAxis.axisMinimum = 0
        //X轴
        let xAxis = bubbleChartView.xAxis
        xAxis.labelPosition = .bothSided //分布在两边外部
        xAxis.axisMinimum = 0 //最小刻度值
        xAxis.granularity = 1 //最小间隔
    }
    @objc func updataData(){
        //第一组气泡图的10条随机数据
        let dataEntries1 = (0..<10).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(50))
            let size = CGFloat(arc4random_uniform(10))
            //只要size超过6的气泡都会带有一个小图标
            if size > 6 {
                return BubbleChartDataEntry(x: Double(i), y: val, size: size,
                                            icon: UIImage(named: "smile"))//这个图片可根据需求定
            } else {
                return BubbleChartDataEntry(x: Double(i), y: val, size: size)
            }
        }
        let chartDataSet1 = BubbleChartDataSet(values: dataEntries1, label: "气泡1")
        chartDataSet1.highlightCircleWidth = 6 //气泡选中时的边框宽
        chartDataSet1.iconsOffset = CGPoint(x: 10, y: -10) //修改气泡上的图片位置（默认居中）
        chartDataSet1.drawValuesEnabled = true
        chartDataSet1.valueFont = UIFont.systemFont(ofSize: 7)
        chartDataSet1.valueTextColor = ZHFColor.red
        //第二组气泡图的10条随机数据
        let dataEntries2 = (0..<10).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(50) + 50)
            let size = CGFloat(arc4random_uniform(10))
            //只要size超过6的气泡都会带有一个小图标
            if size > 6 {
                return BubbleChartDataEntry(x: Double(i), y: val, size: size,
                                            icon: UIImage(named: "smile"))//这个图片可根据需求定
            } else {
                return BubbleChartDataEntry(x: Double(i), y: val, size: size)
            }
        }
        let chartDataSet2 = BubbleChartDataSet(values: dataEntries2, label: "气泡2")
        chartDataSet2.setColor(.orange) //第二组气泡使用橙色
        
        //目前气泡图包括2组数据
        let chartData = BubbleChartData(dataSets: [chartDataSet1, chartDataSet2])
        
        //设置气泡图数据
        bubbleChartView.data = chartData
    }
}
extension BubbleChartVC: ChartViewDelegate{
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
