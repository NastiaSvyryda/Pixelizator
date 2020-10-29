<%--
  Created by IntelliJ IDEA.
  User: asvyryda
  Date: 10/8/20
  Time: 4:51 пп
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="description" content="Pixelizator">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title id="name" >Pixelizator</title>
    <script type="text/javascript" src="https://platform-api.sharethis.com/js/sharethis.js#property=5f9ad1924fa617001994479a&product=image-share-buttons" async="async"></script>
<%--    FACEBOOK--%>
<%--    <meta property="og:url"           content="http://localhost:8080/pixelizator/Pixelizator" />--%>
<%--    <meta property="og:type"          content="image/jpeg" />--%>
<%--    <meta property="og:title"         content="Your Website Title" />--%>
<%--    <meta property="og:description"   content="Your description" />--%>
<%--    <meta property="og:image"         content="${path}" />--%>
</head>
<link rel="stylesheet" href="mystyle.css">
<script>

</script>
<body>
<h1>Pixelizator</h1>
<form method="post" enctype="multipart/form-data" action="Pixelizator">
    <input name="image" id="file" type="file" accept="image/*">
    <br>
    <label for="fileUrl">download by url</label>
    <input name="text" id="fileUrl" type='text' />
    <br>
    <label for="pixSize">select size of pixel</label>
    <input name="size" id="pixSize" type='number' min="0" value="10"/>
    <br>
    <button type="submit">Pixelate</button>
    <br>
    <img id="Img" src="${path}" class="no-image" alt="your image" onclick="getUrl" >
    <br>
</form>
<p>
    total size: <span id="fileSize">0 MiB</span>
</p>
<p>
<a class="button" href="${path}" download="pixel.jpg">Download</a>
</p>

<%--TELEGRAM--%>
<%--<script async id="link" src="https://telegram.org/js/telegram-widget.js?12" data-telegram-share-url="" data-size="large">--%>
<%--    &lt;%&ndash;function getUrl() {&ndash;%&gt;--%>
<%--    &lt;%&ndash;    var link = document.getElementById("link");&ndash;%&gt;--%>
<%--    &lt;%&ndash;     = URL.createObjectURL("${path}");&ndash;%&gt;--%>
<%--    &lt;%&ndash;}&ndash;%&gt;--%>
<%--</script>--%>

<%--FACEBOOK--%>
<%--<div id="fb-root"></div>--%>
<%--<script>(function(d, s, id) {--%>
<%--    var js, fjs = d.getElementsByTagName(s)[0];--%>
<%--    if (d.getElementById(id)) return;--%>
<%--    js = d.createElement(s); js.id = id;--%>
<%--    js.src = "https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.0";--%>
<%--    fjs.parentNode.insertBefore(js, fjs);--%>
<%--}(document, 'script', 'facebook-jssdk'));</script>--%>

<%--<!-- Your share button code -->--%>
<%--<div class="fb-share-button"--%>
<%--     data-href="${path}"--%>
<%--     data-layout="button_count">--%>
<%--</div>--%>


<script>
    window.addEventListener('load', function() {
        document.getElementById("file").addEventListener('change', function() {
            if (this.files && this.files[0]) {
                var image = document.getElementById("Img");  // $('img')[0]
                image.src = URL.createObjectURL(this.files[0]); // set src to blob url

                var img= this.files[0].size;
                var imgsize=img/1024;
                document.getElementById("fileSize").innerHTML = imgsize.toFixed(3) + " MiB";
                image.onload = imageIsLoaded;
            }
        });
        document.getElementById("fileUrl").addEventListener('change', function() {
                var image = document.getElementById("Img");  // $('img')[0]
                var downloadingImage = new Image();
                downloadingImage.onload = function(){
                    image.src = this.src;
                };
                downloadingImage.src = document.getElementById("fileUrl").value;

            // var img = downloadingImage.files[0].size;
            // var imgsize=img/1024;
            //         // var nBytes = 0,
            //         //     oFiles = downloadingImage.src,
            //         //     nFiles = oFiles.length;
            //         // for (var nFileId = 0; nFileId < nFiles; nFileId++) {
            //         //     nBytes += oFiles[nFileId].size;
            //         // }
            // document.getElementById("fileSize").innerHTML = imgsize.toFixed(3) + " MiB";
        });
    });

    function imageIsLoaded() {
        alert(this.src);  // blob url
        // update width and height ...
    }
</script>
</body>
</html>
