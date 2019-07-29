<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>实时统计图表</title>
    <script src="<%=path%>/js/jquery-1.11.3.js"></script>
    <script src="<%=path%>/js/echarts.js"></script>
    <script src="<%=path%>/js/option/show.js"></script>
  </head>
  <body>
  <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
  <table width="100%" border="1">
  	<tr>
  		<td width="50%"><div id="oneBarEchart" style="width: 100%;height: 300px;"></div></td>
  		<td width="50%"><div id="mapChart" style="width: 100%;height:300px;"></div></td>
  	</tr>
  	  	<tr>
  		<td width="50%"><div id="twoBarEchart" style="width: 100%;height: 300px;"></div></td>
  		<td width="50%">
  		<table id="wtTable" width="100%">
  			<thead><tr><th style="text-align:center;width: 70%">问题描述</th><th style="text-align:center">数量</th></tr></thead>
			<tbody></tbody>
  		</table>
  		</td>
  	</tr>
  	<tr>
  		<td width="50%"><div id="lineEchart" style="width: 100%;height: 300px;"></div></td>
  		<td width="50%"><div id="pieEchart" style="width: 100%;height:300px;"></div></td>
  	</tr>
  </table>
    
  </body>
  <script type="text/javascript">
  	var path = "<%=path%>";
  	var num = 20;
    $(document).ready(function(){
    	/*****************单柱形***************/
    	var myData = [12, 22, 20, 34, 39, 30, 20,12,34,26];
    	var myChart = echarts.init(document.getElementById('oneBarEchart'));
    	barChartOption = {
    			animation:true,
    			animationEasing:'linear',
    		    tooltip : {
    		        trigger: 'axis',
    		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
    		            type : 'line'        // 默认为直线，可选为：'line' | 'shadow'
    		        }
    		    },
    		    toolbox: {
        	        feature: {
        	            saveAsImage: {}
        	        }
        	    },
    		    grid: {
    		        left: '3%',
    		        right: '4%',
    		        bottom: '3%',
    		        containLabel: true
    		    },
    		    xAxis : [
    		        {
    		            type : 'category',
    		            data : ['福田区', '宝安区', '南山区', '光明区', '龙华区', '龙岗区', '罗湖区', '坪山区', '盐田区', '大鹏区'],
    		            axisTick: {
    		                alignWithLabel: true
    		            }
    		        }
    		    ],
    		    yAxis : [
    		        {
    		            type : 'value'
    		        }
    		    ],
    		    series : [
    		        {
    		            name:'直接访问',
    		            type:'bar',
    		            barWidth: '60%',
    		            itemStyle: {
    		                normal: {
    		                  color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
									{offset: 0, color: 'rgba(255,255,255,0)'},
									{offset: 0.5, color: '#188df0'},
									{offset: 1, color: '#188df0'}
    		                  ])
    		                }
    		              },
    		            label: {
    		                normal: {
    		                    show: true,
    		                    rotate: 90,
    		                    align: 'left',
    		                    verticalAlign: 'middle',
    		                    position: 'insideBottom',
    		                    distance: 15
    		                }
    		            },
    		            data: myData
    		        }
    		    ]
    		};
    	myChart.setOption(barChartOption);
//     	window.setInterval(function(){
//     		var url = path+"/Index3Servlet";
//     		barChart(url,myChart,barChartOption); 
//     		}, 3000);
    	/*****************地图*****************/
    	$.get('<%=path%>/js/option/440300-ju.json', function (jsdata) {
			echarts.registerMap('shenzhen', jsdata);
				var mapChart = echarts.init(document.getElementById('mapChart'));
				var mapOption = {
					tooltip : {
						trigger: 'item',
						formatter:'{b}<br/>{c} (户)'
					},
					toolbox: {
						show : false,
						orient : 'vertical',
						x: 'right',
						y: 'center',
						feature : {
							mark : {show: true},
							dataView : {show: true, readOnly: false},
							restore : {show: true},
							saveAsImage : {}
						}
					},
					roamController: {
				        show: false,
				        x: 'right',
				        mapTypeControl: {
				            'shenzhen': true
				        }
				    },
				    dataRange: {
				    	show:false,
				        x: 'left',
				        y: 'bottom',
				        splitList: [{start: 70},{start: 41, end: 69},{start: 0, end: 40}],
				        color: ['#eb740c','#ebf564', '#9bf296', '#24e81a','#50f50f']
				    },
					series:  [
						{
							name: '分布图',
							type: 'map',
							mapType: 'shenzhen', // 自定义扩展图表类型
							itemStyle:{
								normal:{label:{show:true}},
								emphasis:{label:{show:true}}
							},
							data:[{name:"福田局",value:111},{name:"宝安局",value:99},{name:"南山局",value:38},{name:"光明局",value:92},{name:"龙华局",value:61},{name:"龙岗局",value:11},{name:"罗湖局",value:128},{name:"坪山局",value:124},{name:"盐田局",value:86},{name:"大鹏局",value:136}],
							itemStyle: {
		                        normal: {
		                            label: {
		                                show: !0
		                            },
		                            formatter: function formatter(a) {
		                                return a.value;
		                            },
		                            borderColor: "#389BB7",//每个区域的边框色
		                            areaColor:'#0FB8F0'//区域背景色
		                        },
		                    },
							// 文本位置修正
							textFixed : {
								'Yau Tsim Mong' : [-10, 0]
							},
							label: {
								normal: { //静态的时候展示样式
									show: true, //是否显示地图省份得名称
									textStyle: {
										color: "#000",
										fontSize: 13,
										fontFamily: "Microsoft Yahei"
									}
								},
								emphasis: { //动态展示的样式
									color:'#00eaff',
								},
							},
							// 文本直接经纬度定位
							geoCoord : {
								'Islands' : [113.95, 22.26]
							}
						}
					]
				};
				mapChart.setOption(mapOption);
				window.setInterval(function(){
		    		var url = path+"/MapServlet";
		    		mapChartOption(url,mapChart,myChart); 
		    		}, 7000);
			});
    	/*****************双柱形***************/
    	var twoBarEchart = echarts.init(document.getElementById('twoBarEchart'));
        var twoBarOption = {
        		color: ['#22bfb9', '#95dd5a'],
        	    tooltip : {
        	        trigger: 'axis',
        	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
        	            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
        	        }
        	    },
        	    legend: {
        	        data: ['直接访问', '邮件营销'],
        	        textStyle: {
	                        fontSize: '12',
	                        color: '#123123'
	                      }
        	    },
        	    grid: {
        	        left: '3%',
        	        right: '4%',
        	        bottom: '3%',
        	        containLabel: true
        	    },
        	    xAxis:  {
        	        type: 'category',
        	        data: ['周一','周二','周三','周四','周五','周六','周日']
        	       
        	    },
        	    yAxis: {
        	         type: 'value'
        	    },
        	    series: [
        	        {
        	            name: '直接访问',
        	            type: 'bar',
        	            stack: '总量',
        	            label: {
        	            	fontSize:20,
        	                normal: {
        	                    show: true,
        	                    position: 'insideTop'
        	                }
        	            },
        	            data: [320, 302, 301, 334, 390, 330, 320]
        	        },
        	        {
        	            name: '邮件营销',
        	            type: 'bar',
        	            stack: '总量',
        	            label: {
        	                normal: {
        	                    show: true,
        	                    position: 'insideTop'
        	                }
        	            },
        	            data: [120, 132, 101, 134, 90, 230, 210]
        	        }
        	    ]
        	};
        twoBarEchart.setOption(twoBarOption);
        window.setInterval(function(){
    		var url = path+"/TwoBarServlet";
    		twoBarEchartOption(url,twoBarEchart,twoBarOption); 
    		}, 4000);
        /**************************列表显示更新************************************/
        window.setInterval(function(){
    		var url = path+"/ShowListServlet";
    		listShow(url,"wtTable"); 
    		}, 3000);
        /*****************线状图***************/
        var lineEchart = echarts.init(document.getElementById('lineEchart'));
        lineOption = {
        	    title: {
        	        text: '折线图堆叠'
        	    },
        	    tooltip: {
        	        trigger: 'axis'
        	    },
        	    legend: {
        	        data:['邮件营销','联盟广告','视频广告','直接访问','搜索引擎']
        	    },
        	    grid: {
        	        left: '3%',
        	        right: '4%',
        	        bottom: '3%',
        	        containLabel: true
        	    },
        	    toolbox: {
        	        feature: {
        	            saveAsImage: {}
        	        }
        	    },
        	    xAxis: {
        	        type: 'category',
        	        boundaryGap: false,
        	        data: ['周一','周二','周三','周四','周五','周六','周日']
        	    },
        	    yAxis: {
        	        type: 'value'
        	    },
        	    series: [
        	        {
        	            name:'邮件营销',
        	            type:'line',
        	            stack: '总量',
        	            data:[120, 132, 101, 134, 90, 230, 210]
        	        },
        	        {
        	            name:'联盟广告',
        	            type:'line',
        	            stack: '总量',
        	            data:[220, 182, 191, 234, 290, 330, 310]
        	        },
        	        {
        	            name:'视频广告',
        	            type:'line',
        	            stack: '总量',
        	            data:[150, 232, 201, 154, 190, 330, 410]
        	        },
        	        {
        	            name:'直接访问',
        	            type:'line',
        	            stack: '总量',
        	            data:[320, 332, 301, 334, 390, 330, 320]
        	        },
        	        {
        	            name:'搜索引擎',
        	            type:'line',
        	            stack: '总量',
        	            data:[820, 932, 901, 934, 1290, 1330, 1320]
        	        }
        	    ]
        	};
        lineEchart.setOption(lineOption);
        window.setInterval(function(){
    		var url = path+"/LineServlet?pp="+num;
    		lineEchartOption(url,lineEchart,lineOption); 
    		}, 6000);
        /**********************饼状图更新**************************/
        var pieEchart = echarts.init(document.getElementById('pieEchart'));
        pieOption = {
        	    tooltip: {
        	        trigger: 'item',
        	        formatter: "{a} <br/>{b}: {c} ({d}%)"
        	    },
        	    legend: {
        	        orient: 'vertical',
        	        x: 'left',
        	        data:['直接访问','邮件营销','联盟广告','视频广告','搜索引擎']
        	    },
        	    toolbox: {
        	        feature: {
        	            saveAsImage: {}
        	        }
        	    },
        	    series: [
        	        {
        	            name:'访问来源',
        	            type:'pie',
        	            radius: ['50%', '70%'],
        	            avoidLabelOverlap: false,
        	            label: {
        	                normal: {
        	                    show: false,
        	                    position: 'center'
        	                },
        	                emphasis: {
        	                    show: true,
        	                    textStyle: {
        	                        fontSize: '30',
        	                        fontWeight: 'bold'
        	                    }
        	                }
        	            },
        	            labelLine: {
        	                normal: {
        	                    show: false
        	                }
        	            },
        	            data:[
        	                {value:335, name:'直接访问'},
        	                {value:310, name:'邮件营销'},
        	                {value:234, name:'联盟广告'},
        	                {value:135, name:'视频广告'},
        	                {value:1548, name:'搜索引擎'}
        	            ]
        	        }
        	    ]
        	};
        pieEchart.setOption(pieOption);
        window.setInterval(function(){
    		var url = path+"/PieServlet?pp="+num;
    		pieEchartOption(url,pieEchart,pieOption); 
    		}, 4000);
    });
	</script>
</html>
