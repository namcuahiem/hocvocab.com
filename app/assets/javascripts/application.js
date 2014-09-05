// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .

// function showText(id){
//  id = id[0,1];
//  currenturl = $(location).attr('pathname');
//  url = currenturl+"/meanings/"+id;
//     $.get(url,function(data,status){
//      $('#meaning').html(data.translation)
//    },'json');
// }


function getSelected() {
  if(window.getSelection) { return window.getSelection(); }
  else if(document.getSelection) { return document.getSelection(); }
  else {
    var selection = document.selection && document.selection.createRange();
    if(selection.text) { return selection.text; }
    return false;
  }
  return false;
}

function selectOnMouseDown(){
    $('.post-content span').removeClass('select'); 
} 

function selectWordsOnMouseUp(){
    var ranges = getSelected();
    var startNode = ranges.anchorNode;
    var endNode = ranges.focusNode;

    var startId = parseInt(startNode.parentElement.id.substring(1));
    var endId = parseInt(endNode.parentElement.id.substring(1));
    var words = "";

    if(startId>endId){
        var temp = startId;
        startId = endId;
        endId = temp;
    }

    if(startId!=endId){
      if($('#w'+startId.toString()).text()==" ")
        startId++;
      if($('#w'+endId.toString()).text()==" ")
        endId--;
    }

    for(i=startId;i<=endId;i++){
         $('#w'+i.toString()).addClass("select");
         words += $('#w'+i.toString()).text();
    }
    
    if((words!=" ") && (words!="")){
      words = words.trim();
      $('#selectword').text(words);
      //insert startId and endId and words to form input
      $('#translation_start').attr("value",startId);
      $('#translation_end').attr("value",endId);
      $('#translation_words').attr("value",words);
      showTranslation(startId,endId);
    }
}

//ajax call to get meaning and show on web
function showTranslation(start,end){
  currenturl = $(location).attr('pathname');
  url = currenturl+"/translation?start="+start+"&end="+end;
    $.get(url,function(data,status){
      if(data.exact.length>0){
        $('#getmeaning').html("");
        data.exact.map(function(item){
          $('#getmeaning').append('<li class="list-group-item">'+item.meaning+"<i> by </i>"+item.author+'</li>');
        });
      }
      else{
        if(data.related.length>0){
          $('#getmeaning').html('<li class="list-group-item alert-danger">No translation until now.</li><li class="list-group-item active">Related words: '+(data.related)[0].words+'</li>');
          data.related.map(function(item){
            $('#getmeaning').append('<li class="list-group-item">'+item.meaning+"<i> by "+item.author+'</i></li>');
          });
        }
        else{
          $('#getmeaning').html('<li class="list-group-item alert-danger">No translation until now.</li>');
        }
      }
    },'json');
}


$(document).ready(function () {
    $('.post-content').on("mouseup", selectWordsOnMouseUp);
    $('.post-content').on("mousedown", selectOnMouseDown);
});