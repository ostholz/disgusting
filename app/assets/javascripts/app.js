(function(){

  $('a.sound').on('click', function(e){
    e.preventDefault();
    $(this).play();
  });

})();