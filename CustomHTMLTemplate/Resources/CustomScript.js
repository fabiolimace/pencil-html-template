
var current = 0;

var CLASS_PAGE = "Page";

function find(id) {
	return document.getElementById(id);
}

function findAll() {
	return document.getElementsByClassName(CLASS_PAGE);
}

function show(id) {
	find(id).style.display = "block";
}

function hideAll() {
	var pages = findAll(CLASS_PAGE);
	for (var i = 0; i < pages.length; i++) {
		pages[i].style.display = "none";
	}
}

function go(id) {
	hideAll();
	show(id);
}

function goIndex(i) {

	var pages = findAll();
	
	if (i < 0) {
		current = 0;
	} else if (i > pages.length - 1) {
		current = pages.length - 1;
	} else {
		current = i;
	}

	go(pages[current].id);
}

function first() {
	goIndex(0);
}

function next() {
	goIndex(++current);
}

function previous() {
	goIndex(--current);
}