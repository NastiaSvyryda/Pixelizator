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

</head>
<link rel="stylesheet" href="mystyle.css">
<script>
    function updateImage() {
        if ("${path}".length !== 0) {
            document.getElementById("divImage").style.display = "initial";
            document.getElementById("downloadButtons").style.display = "initial";
        }
    }
</script>
<body>
<h1>Pixelizator</h1>
<form method="post" enctype="multipart/form-data" action="Pixelizator">
    <label for="file">Download by file</label>
    <input name="image" id="file" type="file" accept="image/*">
    <br>
    <label for="fileUrl">Download by url</label>
    <input name="text" id="fileUrl" type='text' />
    <br>
    <label for="pixSize">Select size of pixel</label>
    <input name="size" id="pixSize" type='number' min="0" value="10"/>
    <br>
    <div id="divImage" style ="display:none">
        <button type="submit">Pixelate</button>
        <br>
        <img id="Img" src="${path}" class="no-image" alt="your image" onchange="updateImage()">
        <br>
        <p>
            Total size: <span id="fileSize">0 MiB</span>
        </p>
    </div>
</form>
<div id="downloadButtons" style ="display:none">
    Download as:
    <a class="button" href="${path}" download="pixel.jpg">jpg</a>
    <a class="button" href="${path}" download="pixel.png">png</a>
    <a class="button" href="${path}" download="pixel.webp">webp</a>
    <a class="button" href="${path}" download="pixel.bmp">bmp</a>
</div>

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
                document.getElementById("divImage").style.display = "initial";
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
