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
</head>
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
    <img id="Img" src="#" alt="your image" >
    <br>
    <button type="submit">Pixelate</button>
</form>
<p>
    total size: <span id="fileSize">0 MiB</span>
</p>
<p>
    pixelated image: <div id="path">${path}</div>
<br>
<img id="ImgPix" src="${path}" alt="your image" >
<br>
</p>

<%--<div class="canvas__container">--%>
<%--    <canvas id="cnvs" class="canvas__canvas"></canvas>--%>
<%--    <img src="${path}" id="mirror" class="canvas__mirror" />--%>
<%--</div>--%>

<%--<a href="#" class="button" id="btn-download" download="my-file-name.png">Download</a>--%>


<%--<img src="Pixelizator?word=value">the rest</img>--%>


<script>
    // var cnvs = document.getElementById('cnvs'),
    //     ctx = cnvs.getContext('2d'),
    //     mirror = document.getElementById('mirror');
    //
    //
    // cnvs.width = mirror.width = window.innerWidth;
    // cnvs.height = mirror.height = window.innerHeight;
    // mirror.addEventListener('contextmenu', function (e) {
    //     var dataURL = canvas.toDataURL('image/png');
    //     mirror.src = dataURL;
    // });
    // var button = document.getElementById('btn-download');
    // button.addEventListener('click', function (e) {
    //     var dataURL = canvas.toDataURL('image/png');
    //     button.href = dataURL;
    // });


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
