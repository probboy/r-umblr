
    function getUrlVars() {
        var vars = {};
        var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function (m, key, value) {
          vars[key] = value;
        });
        return vars;
      }
  
      var a = getUrlVars().prodName;
      var b = getUrlVars().prodID;
  
  
      String.prototype.replaceAll = function (search, replacement) {
        var target = this;
        return target.split(search).join(replacement);
      };
      a = a.replaceAll("%20", " ");
  
      $(function () {
        $("<span>" + a + "</span>").appendTo("#productName")
      })
  
  
      $.getJSON("product-data.json", {}, function (data, textStatus, jqXHR) {
        $.each(data.products, function (index, object) {
          //console.log(index,object)
          if (object["prod_id"] == b) {
            $("#productStock").append(object["in_stock"]);
            $("#productPrice").append(object["retail_price"]);
            $("#productDesc").append(object["description"]);
            $("#productimage").attr("src",object["photo_src"])
          }
        })
      });
  
  