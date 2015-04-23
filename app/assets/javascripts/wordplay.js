 $(document).ready(function () {
   $("html, body").animate({
    scrollTop: $("#results").offset().top
   }, 700);
  });

  $(document).ready(function () {
  	$(".reset-btn").click(function() { 
  	$("html:not(:animated),body:not(:animated)").animate({
    scrollTop: $("body").offset().top
   }, 500 );
  	});
  });
  
$(document).ready(function() {
$('.reset-btn').click(function (e) {
    e.preventDefault();                   // prevent default anchor behavior
    var goTo = this.getAttribute("href"); // store anchor href

	$(".results").fadeOut("slow");

    setTimeout(function(){
         window.location = goTo;
    },310);       
});
});


// click reset button
// reset #textblock_content
