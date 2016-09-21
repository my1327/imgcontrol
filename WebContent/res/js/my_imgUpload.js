var imgObj = new ShopImg();
	var options = {
			target : '#output1',
			beforeSubmit : beforeSubmit,
			success : function(data, states, result) {
				submitted(data, false);
				loadShoppingCount();
			},
			error : function(data) {
				submitted(data, true);
			},
			type : "POST",
			url : "image/upload.ds",
			dataType : "json"
		};
		function beforeSubmit(formData, jqForm, options) {
			formData[0].value = options.file;
			return true;
		}

		function submitted(data, hasError) {
			var progressNum = ((fileIndex + 1) / fileList.length) * 100;
			progress(progressNum, fileIndex + 1, fileList.length);
			++fileIndex;
			if (fileIndex < fileList.length) {
				console.log("Current index: " + fileIndex);
				//进度条百分比
				submit(fileIndex);
			} else {
				uploadCompleted();
				$("#bg").hide();
				$(".barline").hide();
			}
		}
		//进度条
		function progress(progress, currentNum, allNum) {
			$("#line").css("width", progress + "%");
			$("#all").html(allNum);
			$("#already").html(currentNum);
			$("#no").html(allNum - currentNum);
		}

		function uploadCompleted() {
			fileIndex = 0;
			//alert("Completed!");
			loadShoppingCount();
		}

		function submit(index) {
			options.file = fileList[index];
			$("#imgForm").ajaxSubmit(options);
		}

		var inputElement = document.getElementById("fileId");
		inputElement.addEventListener("change", handleFiles, false);

		function handleFiles() {
			fileList = this.files;
			fileIndex = 0;
			//添加进度条
			$("#bg").show();
			$(".barline").show();
			submit(fileIndex);
		}
		
		//遮罩层的显示隐藏
		function Boxs(evl){
			document.getElementById('showBox').style.display=evl;
			document.getElementById('bg').style.display=evl;
			document.getElementById('imgContain').innerHTML="";
		}
		
		
		
		//原图显示function
		function showImgs(index){
			var showImg = imgObj.Imgs()[index];
			var img=document.createElement('img');
				img.setAttribute("src", showImg.url);	
				img.setAttribute("alt", index);	
				Boxs('block');				
				document.getElementById('imgContain').appendChild(img);				
		}
		//点击原图显示
		function imgBox(index){
			showImgs(index);
		}
		
		//向后按钮
		function toNext(){	
			
			nexePage(true);
		}
		
		//向前按钮
		function toPrev(){	
			nexePage(false);
		}
		
		//前后按钮调用函数
		function nexePage(tag){
			var index=document.getElementById('imgContain').getElementsByTagName('img')[0].alt;
			index=parseInt(index);	
			//alert(index);
			if(index==0&&!tag){
				alert('第一张了');
			}
			else if(index==imgObj.Imgs().length-1&&tag){
				alert('最后一张了');
			}
			else{
				if(tag)
					++index;
				else 
					--index;
				showImgs(index);
			}
		}
		//knockout绑定
		function ShopImg() {
			var self = this;
			self.Imgs = ko.observableArray([]);
			self.imgChose = ko.observableArray([]);
			//self.detailsEnabled= ko.observable(false);
			self.deleteclick = function(data, event) {
				//alert(1);
				var dataid = {
						id : data.id//"fea9744b046546a09f5b1780907a60c2"
					};
					$.post("image/remove.ds", dataid,
					function(result) {
						if (result.code == 0)
							//getImages();
						loadShoppingCount();
						else {
							alert(result.content);
						}
					})
			}
			//点击查看原图事件
			self.showImg=function(data,event){
				//alert(index);
				var context = ko.contextFor(event.target); 
				var index = context.$index();              
				//alert("当前索引是：" + index); 
				imgBox(index);
			}
			//点击选中按钮
			self.choseImg = function(data,event){				
				if( $.inArray(data,self.imgChose())==-1){
					self.imgChose.push(data);
					$('#'+data.id).css('display','block');
				}else{
					self.imgChose.remove(data);
					$('#'+data.id).css('display','none');
				}
			}
			
			self.sureClick = function(){
				var string = '';
				for(i=0;i<self.imgChose().length;i++){
					string+=self.imgChose()[i].id+'     '+self.imgChose()[i].url;
				}
				alert(string);
			}
		}
		
	ko.applyBindings(imgObj,document.getElementById('contain'));
	
	//显示原图按钮显示
	function showBtn(div){
		$(div).parent().find('.showImg').css('display','block');
	}
	//显示原图按钮隐藏
	function hideBtn(div){
		$(div).parent().find('.showImg').css('display','none');
	}
	
	loadShoppingCount();
	
	function loadShoppingCount() {
		$.get("image/count.ds", null, function(result) {
			var number = $.parseJSON(result);
			//alert(number);
			setTotalCount(number);
		});
	}
	
	function loadSourceItems(start) {
		var data = {
			page: currentPage-1,
			size: pageSize
		}
		
		$.get("image/get.ds",data, function(result) {
			//alert(result);
			imgObj.Imgs(result);
		})
	}