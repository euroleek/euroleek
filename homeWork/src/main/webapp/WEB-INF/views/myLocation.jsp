<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

    <meta charset="utf-8">
    <title>geolocation으로 마커 표시하기</title>
    <script src = "<c:url value = '/resources/js/jquery-3.4.1.js'/>"></script>
    
    
    
</head>
<body>

<p style="margin-top:-12px">
    <b>위치가 부정확할시 지도에서 위치를 클릭해주시고 버튼을 눌러주세요</b>
    <input type = "button" value = "수정" id = "loCheck"> 
</p>
<div id="map" style="width:30%;height:600px;float:left;" 	></div>
<div id = "found" style ="width:40%;height:600px;float:left; margin: 1px; padding: 10px;">
	<table style = "width:90%; height : 80%;" border="1">
	
		
		<tr>
			<th style = "height : 30px;">사업자명</th>
			<td style = "height : 30px;">
				<p id = "id1"></p>
			</td>
			<td rowspan="3"><input type = "button" value = "길찾기" style="height: 30px;text-align: left;" id = "check"></td>
		</tr>
		
		<tr>
			<th>전화번호</th>
			<td>
				<p id = "ph1"></p>
			</td>
		</tr>	
		
		<tr>
			<th>주소</th>
			<td>
				<p id = "lo1"></p>
			</td>
		</tr>	
		
		<tr>
			<th>사업자명</th>
			<td>
				<p id = "id2"></p>
			</td>
			<td rowspan="3"><input type = "button" value = "길찾기" style="height: 30px;text-align: left;" id = "check1"></td>
		</tr>
		
		<tr>
			<th>전화번호</th>
			<td>
				<p id = "ph2"></p>
			</td>
		</tr>	
		
		<tr>
			<th>주소</th>
			<td>
				<p id = "lo2"></p>
			</td>
		</tr>		
		
		<tr>
			<th>사업자명</th>
			<td>
				<p id = "id3"></p>
			</td>
			<td rowspan="3"><input type = "button" value = "길찾기" style="height: 30px;text-align: left;" id = "check2"></td>
		</tr>
		
		<tr>
			<th>전화번호</th>
			<td>
				<p id = "ph3"></p>
			</td>
		</tr>	
		
		<tr>
			<th>주소</th>
			<td>
				<p id = "lo3"></p>
			</td>
		</tr>	
		
		
	</table>

</div>




<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bcb304f051b2968e7a9473de010e09a0&libraries=services"></script>


<script>

var coords = new kakao.maps.Coords(400207.5, -11710);
coords.toLatLng().toString(); 

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 6 // 지도의 확대 레벨 
    }; 

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();





// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
if (navigator.geolocation) {
    
    // GeoLocation을 이용해서 접속 위치를 얻어옵니다	
    navigator.geolocation.getCurrentPosition(function(position) {
        
        var lat = position.coords.latitude, // 위도
            lon = position.coords.longitude; // 경도
           
        var my = ""; 
            var coord = new kakao.maps.LatLng(lat, lon);
            var callback = function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                   my = result[0].address.address_name;
                }
            };
            var markers = [];
			var count = 0;
			
            geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
			
            $.ajax({
    			url : "myL",
    			type : "get",
    			data : {
    				xValue:lat
    				,yValue:lon
    			},
    			success : function(data){
     							
					$('#id1').html(data[0]);
					$('#ph1').html(data[1]);
					$('#lo1').html(data[2]);
					
					$('#id2').html(data[3]);
					$('#ph2').html(data[4]);
					$('#lo2').html(data[5]);

					$('#id3').html(data[6]);
					$('#ph3').html(data[7]);
					$('#lo3').html(data[8]);

					
					
					var positions = [
					    {
					        title: data[0], 
					        latlng: new kakao.maps.LatLng(data[9], data[10])
					    },
					    {
					        title: data[3], 
					        latlng: new kakao.maps.LatLng(data[11], data[12])
					    },
					    {
					        title: data[6], 
					        latlng: new kakao.maps.LatLng(data[13], data[14])
					    },
					];

					// 마커 이미지의 이미지 주소입니다
					var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
					    
					for (var i = 0; i < positions.length; i ++) {
					    
					    // 마커 이미지의 이미지 크기 입니다
					    var imageSize = new kakao.maps.Size(24, 35); 
					    
					    // 마커 이미지를 생성합니다    
					    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
					    
					    // 마커를 생성합니다
					    var marker1 = new kakao.maps.Marker({
					        map: map, // 마커를 표시할 지도
					        position: positions[i].latlng, // 마커를 표시할 위치
					        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
					        image : markerImage // 마커 이미지 
					    });
					    markers.push(marker1);
					}
					
					     				
     				$('#check').on("click", function(){
     					var start = my;
     					var end = data[2];
     					var w = window.open("about:blank","_blank","width=1000, height=700, top=0,left=0,scrollbars=no");
     					$.ajax({
     						url : "check",
     						type : "post",
     						data : {
     							start : start
     							,end : end
     						},
     						success : function(data){
     							
     							w.location.href = "http://map.daum.net/?sName="+ data[0] +"&eName=" + data[1]
     							
     						},
     						error : function(){
     						
     						}
     					});
     				});

     				$('#check1').on("click", function(){
     					var start = my;
     					var end = data[5];
     					var w = window.open("about:blank","_blank","width=1000, height=700, top=0,left=0,scrollbars=no");
     					$.ajax({
     						url : "check",
     						type : "post",
     						data : {
     							start : start
     							,end : end
     						},
     						success : function(data){
     							
     							w.location.href = "http://map.daum.net/?sName="+ data[0] +"&eName=" + data[1]
     							
     						},
     						error : function(){
     						
     						}
     					});
     				});

     				$('#check2').on("click", function(){
     					var start = my;
     					var end = data[8];
     					var w = window.open("about:blank","_blank","width=1000, height=700, top=0,left=0,scrollbars=no");
     					$.ajax({
     						url : "check",
     						type : "post",
     						data : {
     							start : start
     							,end : end
     						},
     						success : function(data){
     							
     							w.location.href = "http://map.daum.net/?sName="+ data[0] +"&eName=" + data[1]
     							
     						},
     						error : function(){
     						
     						}
     					});
    				});

     				
			
     				
     				
    			},
    			error : function(){
    			
    			}
    		});
           

		  var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
            message = '<div style="padding:5px;">여기에 계신가요?!</div>'; // 인포윈도우에 표시될 내용입니다

            // 마커를 생성합니다
    	   	var marker = new kakao.maps.Marker({  
    	    map: map, 
    	   	position : locPosition
    	   
    	  });     
        
    	   	var iwContent = message, // 인포윈도우에 표시할 내용
            iwRemoveable = true;

        // 인포윈도우를 생성합니다
        var infowindow = new kakao.maps.InfoWindow({
            content : iwContent,
            removable : iwRemoveable
        });
        
        // 인포윈도우를 마커위에 표시합니다 
        infowindow.open(map, marker);
        
        // 지도 중심좌표를 접속위치로 변경합니다
        map.setCenter(locPosition);      
        

      //지도를 클릭한 위치에 표출할 마커입니다
        var marker2 = new kakao.maps.Marker({ 
            // 지도 중심좌표에 마커를 생성합니다 
            position: map.getCenter() 
        }); 
        // 지도에 마커를 표시합니다
        marker2.setMap(map);

        var x = "";
        var y = "";

        //클릭이벤트
        kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
           	marker.setMap(null);
            
            // 클릭한 위도, 경도 정보를 가져옵니다 
            var latlng = mouseEvent.latLng; 
            
            // 마커 위치를 클릭한 위치로 옮깁니다
            marker2.setPosition(latlng);
            
            x = latlng.getLat();
            y = latlng.getLng();
        });

        
        

	        
	            $(function(){
	            	$('#loCheck').on("click", function(){
	            		       	
		            	count++;
	            		for(var i = 0 ; i<3*count; i++)
	   		            {
			            		markers[i].setMap(null);
	       		        }

	            		var my1 = ""; 
	                    var coord1 = new kakao.maps.LatLng(x, y);
	                    var callback = function(result, status) {
	                        if (status === kakao.maps.services.Status.OK) {
	                           my1 = result[0].address.address_name;
	                        }
	                    };
	                    geocoder.coord2Address(coord1.getLng(), coord1.getLat(), callback);
	            								     							
	            		$.ajax({
	            			url : "myL",
	            			type : "get",
	            			data : {
	            				xValue:x
	            				,yValue:y
	            			},
	            			success : function(data){
	            					
	            				$('#id1').html(data[0]);
	            				$('#ph1').html(data[1]);
	            				$('#lo1').html(data[2]);
	            				
	            				$('#id2').html(data[3]);
	            				$('#ph2').html(data[4]);
	            				$('#lo2').html(data[5]);

	            				$('#id3').html(data[6]);
	            				$('#ph3').html(data[7]);
	            				$('#lo3').html(data[8]);

	            				var positions = [
	            				    {
	            				        title: data[0], 
	            				        latlng: new kakao.maps.LatLng(data[9], data[10])
	            				    },
	            				    {
	            				        title: data[3], 
	            				        latlng: new kakao.maps.LatLng(data[11], data[12])
	            				    },
	            				    {
	            				        title: data[6], 
	            				        latlng: new kakao.maps.LatLng(data[13], data[14])
	            				    },
	            				];
								
	            				// 마커 이미지의 이미지 주소입니다
	            				var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
	            				  
	            				for (var i = 0; i < positions.length; i ++) {
	            				    
	            				    // 마커 이미지의 이미지 크기 입니다
	            				    var imageSize = new kakao.maps.Size(24, 35); 
	            				    
	            				    // 마커 이미지를 생성합니다    
	            				    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
	            				    
	            				    // 마커를 생성합니다
	            				    var marker1 = new kakao.maps.Marker({
	            				        map: map, // 마커를 표시할 지도
	            				        position: positions[i].latlng, // 마커를 표시할 위치
	            				        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
	            				        image : markerImage // 마커 이미지 
	            				       
	            				    });
	            				    markers.push(marker1);
	            				}
	            				
												
			     				
	             				$('#check').off().on("click", function(){
	             					var start = my1;
	             					var end = data[2];
	             					var w = window.open("about:blank","_blank","width=1000, height=700, top=0,left=0,scrollbars=no");
	             					$.ajax({
	             						url : "check",
	             						type : "post",
	             						data : {
	             							start : start
	             							,end : end
	             						},
	             						success : function(data){
	             							
	             							w.location.href = "http://map.daum.net/?sName="+ data[0] +"&eName=" + data[1]
	             							
	             						},
	             						error : function(){
	             						
	             						}
	             					});
	             				});

	             				$('#check1').off().on("click", function(){
	             					var start = my1;
	             					var end = data[5];
	             					var w = window.open("about:blank","_blank","width=1000, height=700, top=0,left=0,scrollbars=no");
	             					$.ajax({
	             						url : "check",
	             						type : "post",
	             						data : {
	             							start : start
	             							,end : end
	             						},
	             						success : function(data){
	             							
	             							w.location.href = "http://map.daum.net/?sName="+ data[0] +"&eName=" + data[1]
	             							
	             						},
	             						error : function(){
	             						
	             						}
	             					});
	             				});

	             				$('#check2').off().on("click", function(){
	             					var start = my1;
	             					var end = data[8];
	             					var w = window.open("about:blank","_blank","width=1000, height=700, top=0,left=0,scrollbars=no");
	             					$.ajax({
	             						url : "check",
	             						type : "post",
	             						data : {
	             							start : start
	             							,end : end
	             						},
	             						success : function(data){
	             							
	             							w.location.href = "http://map.daum.net/?sName="+ data[0] +"&eName=" + data[1]
	             							
	             						},
	             						error : function(){
	             						
	             						}
	             					});
	            				});
	        	            			
	            				     		            				     				
	             				
	            		
	             				
	            			},
	            			error : function(){
	            			
	            			}
	            		});
	            		
	            	});
	            });
	            
	            
	        
      
            
      });
    
} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
    
    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
        message = 'geolocation을 사용할수 없어요..'
    
        
  
   
   
}





	





</script>


</body>
</html>