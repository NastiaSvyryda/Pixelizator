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
    <%--    через 5 секунд переходит на страницу    --%>
    <%--        <meta http-equiv="refresh" content="5; URL=http://www.google.com">--%>
    <title>Pixelizator</title>
</head>
<body>
<h1>Pixelizator</h1>
<script>
    function updateSize() {
        var nBytes = 0,
            oFiles = document.getElementById("file").files,
            nFiles = oFiles.length;
        for (var nFileId = 0; nFileId < nFiles; nFileId++) {
            nBytes += oFiles[nFileId].size;
        }
        document.getElementById("fileSize").innerHTML = (nBytes / 1000000).toFixed(3) + "MiB";
    }
</script>

    <input name="image" id="file" type='file' accept="image/*" enctype="multipart/form-data"/>
    <br>
    <input name="text" id="fileUrl" type='text' />
    <br>
    <img id="Img" src="#" alt="your image" onchange=updateSize()>
    <br>
    <button type="submit">Pixelate</button>
</form>

<p>
    total size: <span id="fileSize">0</span>
</p>


<script>
    window.addEventListener('load', function() {
        document.getElementById("file").addEventListener('change', function() {
            if (this.files && this.files[0]) {
                var img = document.getElementById("Img");  // $('img')[0]
                img.src = URL.createObjectURL(this.files[0]); // set src to blob url
                img.onload = imageIsLoaded;
            }
        });
        document.getElementById("fileUrl").addEventListener('change', function() {
                var image = document.getElementById("Img");  // $('img')[0]
                var downloadingImage = new Image();
                downloadingImage.onload = function(){
                    image.src = this.src;
                };
                downloadingImage.src = document.getElementById("fileUrl").value;
        });
    });

    function imageIsLoaded() {
        alert(this.src);  // blob url
        // update width and height ...
    }
</script>
</body>
</html>
