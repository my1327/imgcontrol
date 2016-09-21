var currentPage = 1;
var pageSum = 0; // 总页数
var pageSize = 10; // 每页条数
var totalCount = 0; // 总条数

function setTotalCount(total) {
	totalCount = total;
	pageSum = Math.ceil(totalCount / pageSize);
	currentPage = 1;
	pageButton();
	loadPageItems(getStart());
}

function loadPageItems(start) {
	loadSourceItems(start);
}

function enable(dom) {
	dom.style.pointerEvents = "auto";
}

function disable(dom) {
	dom.style.pointerEvents = "none";
}

function pageButton() {
	var elNum = document.getElementById("pageNum");
	var elFirst = document.getElementById("pageFirst");
	var elForward = document.getElementById("pageForward");
	var elJump = document.getElementById("pageJump");
	var elNext = document.getElementById("pageNext");
	var elEnd = document.getElementById("pageEnd");
	elNum.value = currentPage;

	if (pageSum <= 1) {
		disable(elFirst);
		disable(elForward);
		disable(elJump);
		disable(elNext);
		disable(elEnd);
		return;
	}

	if (currentPage == 1) {
		disable(elFirst);
		disable(elForward);
		enable(elJump);
		enable(elNext);
		enable(elEnd);
	} else if (currentPage >= pageSum) {
		enable(elFirst);
		enable(elForward);
		enable(elJump);
		disable(elNext);
		disable(elEnd);
	} else {
		enable(elFirst);
		enable(elForward);
		enable(elJump);
		enable(elNext);
		enable(elEnd);
	}
}
function getStart() {
	//return (currentPage * pageSize) - pageSize;
	return currentPage-1;
}
function firstPage() {
	currentPage = 1;
	pageButton();
	loadPageItems(getStart());
}

function forwardPage() {
	currentPage--;
	pageButton();
	loadPageItems(getStart());
}

function jumpPage() {
	var page = document.getElementById("pageNum").value;
	if (page > pageSum) {
		alert("总页数：" + pageSum + " 页");
		return;
	} else if (page < 1) {
		page = 1;
		document.getElementById("pageNum").value = 1;
	}
	currentPage = page;
	pageButton();
	loadPageItems(getStart());
}

function nextPage() {
	currentPage++;
	pageButton();
	loadPageItems(getStart());
}

function endPage() {
	currentPage = pageSum;
	pageButton();
	loadPageItems(getStart());
}