//
//  BarChartHorizontalVC.swift
//  ChartsUnderstandAndUsage
//
//  Created by 张海峰 on 2018/10/18.
//  Copyright © 2018年 张海峰. All rights reserved.
//
//Charts框架地址
//https://github.com/danielgindi/Charts.git
//该demo地址
//https://github.com/FighterLightning/ChartsUnderstandAndUsage.git
/*柱状图(波浪)*/
import UIKit
import Charts
class BarChartWaveVC: BaseVC {
    var barChartView: BarChartView = BarChartView()
    lazy var xVals: NSMutableArray = NSMutableArray.init()
    var data: BarChartData = BarChartData()
    let axisMaximum :Double = 100
    override func viewDidLoad() {
        super.viewDidLoad()
        //添加柱状图
        addBarChartView()
        //设置基本样式
        setBarChartViewBaseStyle()
        //设置X轴，Y轴样式
        setBarChartViewXY()
        //添加（刷新数据）
        updataData()
    }
    //添加柱状图
    func addBarChartView(){
        barChartView.backgroundColor = ZHFColor.white
        barChartView.frame.size = CGSize.init(width: ScreenWidth - 20, height: 300)
        barChartView.center = self.view.center
        barChartView.delegate = self
        self.view.addSubview(barChartView)
        //刷新按钮响应
        refreshrBtn.addTarget(self, action: #selector(updataData), for: UIControlEvents.touchUpInside)
    }
    func setBarChartViewBaseStyle(){
        //基本样式
        barChartView.noDataText = "暂无数据"//没有数据时的显示
        barChartView.drawValueAboveBarEnabled = true//数值显示是否在条柱上面
        barChartView.drawBarShadowEnabled = false//是否绘制阴影背景
        
        //交互设置 (把煮食逐个取消试试)
        //        barChartView.scaleXEnabled = false//取消X轴缩放
        barChartView.scaleYEnabled = false//取消Y轴缩放
        barChartView.doubleTapToZoomEnabled = false//取消双击是否缩放
        //        barChartView.pinchZoomEnabled = false//取消XY轴是否同时缩放
        barChartView.dragEnabled = true //启用拖拽图表
        barChartView.dragDecelerationEnabled = true //拖拽后是否有惯性效果
        barChartView.dragDecelerationFrictionCoef = 0.9 //拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
    }
    func setBarChartViewXY(){
        //1.X轴样式设置（对应界面显示的--->0月到7月）
        let xAxis: XAxis = barChartView.xAxis
        xAxis.axisLineWidth = 1 //设置X轴线宽
        xAxis.labelPosition = XAxis.LabelPosition.bottom //X轴（5种位置显示，根据需求进行设置）
        xAxis.drawGridLinesEnabled = false//不绘制网格
        xAxis.labelWidth = 4 //设置label间隔，若设置为1，则如果能全部显示，则每个柱形下面都会显示label
        xAxis.labelFont = UIFont.systemFont(ofSize: 10)//x轴数值字体大小
        xAxis.labelTextColor = ZHFColor.brown//数值字体颜色
        
        //2.Y轴左样式设置（对应界面显示的--->-2.5 到 2.5）
        let leftAxis = barChartView.leftAxis
        leftAxis.labelCount = 8
        leftAxis.axisMinimum = -1.5
        leftAxis.axisMaximum = 1.5
        leftAxis.granularityEnabled = true
        leftAxis.granularity = 0.2 //左Y 轴线间隙
        
        //3.Y轴右样式设置（如若设置可参考左样式）
        let rightAxis = barChartView.rightAxis
        rightAxis.labelCount = 8
        rightAxis.axisMinimum = -1.5
        rightAxis.axisMaximum = 1.5
        rightAxis.granularity = 0.2  //右Y 轴线间隙
        
        //4.描述文字设置
        barChartView.chartDescription?.text = "柱形图"//右下角的description文字样式 不设置的话会有默认数据
        barChartView.chartDescription?.position = CGPoint.init(x: 80, y: 5)//位置（及在barChartView的中心点）
        barChartView.chartDescription?.font = UIFont.systemFont(ofSize: 12)//大小
        barChartView.chartDescription?.textColor = ZHFColor.orange
        
        //5.设置类型试图的对齐方式，右上角 (默认左下角)
        let legend = barChartView.legend
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .horizontal
        legend.textColor = ZHFColor.orange
        legend.font = UIFont.systemFont(ofSize: 11.0)
    }
    @objc func updataData(){
         let count: NSInteger = NSInteger(arc4random_uniform(UInt32(150)) + 100)
        let entries = (0 ..< count).map {
            BarChartDataEntry(x: Double($0), y: sin(.pi * Double($0%128) / 64))
        }
        
        let set = BarChartDataSet(values: entries, label: "信息")
        set.setColor(UIColor(red: 240/255, green: 120/255, blue: 123/255, alpha: 1))
        
        let data = BarChartData(dataSet: set)
        data.setValueFont(.systemFont(ofSize: 10, weight: .light))
        data.setDrawValues(false)
        data.barWidth = 0.8
        barChartView.data = data
        barChartView.animate(xAxisDuration: 2, yAxisDuration: 2)//展示方式xAxisDuration 和 yAxisDuration两种
    }
}
//MARK:-   <ChartViewDelegate代理方法实现>
extension BarChartWaveVC :ChartViewDelegate {
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

