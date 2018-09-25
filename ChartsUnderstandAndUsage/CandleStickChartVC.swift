//
//  CandleStickChartVC.swift
//  ChartsUnderstandAndUsage
//
//  Created by 张海峰 on 2018/9/17.
//  Copyright © 2018年 张海峰. All rights reserved.
//
//Charts框架地址
//https://github.com/danielgindi/Charts.git
//该demo地址
//https://github.com/FighterLightning/ChartsUnderstandAndUsage.git
/*K 线图（烛形图）*/
import UIKit
import Charts
class CandleStickChartVC: UIViewController {
    var candleStickChartView: CandleStickChartView  = CandleStickChartView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ZHFColor.white
        //1.添加K 线图（烛形图）和刷新按钮
        addCandleStickChartAndRefreshBtn()
        
        //2. 基本样式
        setCandleStickChartViewBaseStyle()
        
        //3.添加（刷新数据）
        updataData()
    }
}
extension CandleStickChartVC{
    //添加K 线图（烛形图）和刷新按钮
    func addCandleStickChartAndRefreshBtn(){
        candleStickChartView.backgroundColor = ZHFColor.white
        candleStickChartView.frame.size = CGSize.init(width: 300, height: 300)
        candleStickChartView.center = self.view.center
        candleStickChartView.delegate = self
        self.view.addSubview(candleStickChartView)
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
    func setCandleStickChartViewBaseStyle(){
        //K 线图（烛形图）描述
        candleStickChartView.chartDescription?.text = "K 线图（烛形图）描述"
        candleStickChartView.chartDescription?.position = CGPoint.init(x: candleStickChartView.frame.width - 30, y:candleStickChartView.frame.height - 20)//位置（及在bubbleChartView的中心点）
        candleStickChartView.chartDescription?.font = UIFont.systemFont(ofSize: 12)//大小
        candleStickChartView.chartDescription?.textColor = UIColor.red
        
        //图例
        let l = candleStickChartView.legend
        l.wordWrapEnabled = false //显示图例
        l.horizontalAlignment = .left //居左
        l.verticalAlignment = .bottom //放在底部
        l.orientation = .horizontal //水平排布
        l.drawInside = false // 图例在外
        l.formSize = 10 //（图例大小）默认是8
        l.form = Legend.Form.circle//图例头部样式
        //矩形：.square（默认值） 圆形：.circle   横线：.line  无：.none 空：.empty（与 .none 一样都不显示头部，但不同的是 empty 头部仍然会占一个位置)
        //Y轴右侧线
        let rightAxis = candleStickChartView.rightAxis
        rightAxis.axisMinimum = 0
        //Y轴左侧线
        let leftAxis = candleStickChartView.leftAxis
        leftAxis.axisMinimum = 0
        //X轴
        let xAxis = candleStickChartView.xAxis
        xAxis.labelPosition = .bothSided //分布在两边外部
        xAxis.axisMinimum = 0 //最小刻度值
        xAxis.granularity = 1 //最小间隔
    }
    @objc func updataData(){
        //第一组烛形图的10条随机数据
        let dataEntries1 = (0..<10).map { (i) -> CandleChartDataEntry in
            let val = Double(arc4random_uniform(40) + 10)
            let high = Double(arc4random_uniform(9) + 8)
            let low = Double(arc4random_uniform(9) + 8)
            let open = Double(arc4random_uniform(6) + 1)
            let close = Double(arc4random_uniform(6) + 1)
            let even = arc4random_uniform(2) % 2 == 0 //true表示开盘价高于收盘价
            //当天涨幅超过9的显示一个星星图标
            if(!even && (open + close) > 9 ){
                return CandleChartDataEntry(x: Double(i),
                                            shadowH: val + high,
                                            shadowL: val - low,
                                            open: even ? val + open : val - open,
                                            close: even ? val - close : val + close,
                                            icon: UIImage(named: "smile")!)
            }
            else{
            return CandleChartDataEntry(x: Double(i),
                                        shadowH: val + high,
                                        shadowL: val - low,
                                        open: even ? val + open : val - open,
                                        close: even ? val - close : val + close)
            }
        }
        let chartDataSet1 = CandleChartDataSet(values: dataEntries1, label: "图例1")
        chartDataSet1.shadowWidth = 2 //柱线（烛心线）颜色
        chartDataSet1.decreasingFilled = false //开盘高于收盘则使用空心矩形
        chartDataSet1.increasingFilled = true //开盘低于收盘则使用实心矩形
        chartDataSet1.setColor(.orange) //整体设置颜色
//        chartDataSet1.shadowColor = .darkGray //柱线（烛心线）颜色
//        chartDataSet1.decreasingColor = ZHFColor.green //实心颜色
//        chartDataSet1.increasingColor = ZHFColor.red //空心颜色
       // chartDataSet1.shadowColorSameAsCandle = true//竖线的颜色与方框颜色一样
        //chartDataSet1.showCandleBar = false //不显示方块
        //目前烛形图包括1组数据
        let chartData = CandleChartData(dataSets: [chartDataSet1])
        
        //设置烛形图数据
        candleStickChartView.data = chartData
    }
}
extension CandleStickChartVC: ChartViewDelegate{
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
