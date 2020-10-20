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
    <title>Pizelizator</title>
</head>
<body>
<h1>Simple Java Web App Demo</h1>
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

<%--<form method="post" enctype="multipart/form-data">--%>
<%--    Name: <input type="text" name="submit"/> <br/>--%>
<%--    <button type="submit">send</button>--%>
<%--<input id="file" type='file' name="photo" onchange=updateSize() />--%>
<%--<br><img id="myImg" src="#" alt="your image" height=600 width=800>--%>
<%--</form>--%>

<form method="post" enctype="multipart/form-data" action="Pixelizator">
    <input name="image" id="file" type="file" accept="image/*" onchange=updateSize()>
    <br>
    <button type="submit">send</button>
</form>

<p>
    total size: <span id="fileSize">0</span>
</p>

<div class="row"><span id="output"></span></div>

<script>
    function showImage(evt) {
        var file = evt.target.files; // FileList object
        var f = file[0]
        // Only process image files.
        if (!f.type.match('image.*')) {
            alert("Только изображения....");
        }
        var reader = new FileReader();
        // Closure to capture the file information.
        reader.onload = (function(theFile) {
            return function(e) {
                // Render thumbnail.
                var span = document.createElement('span');
                span.innerHTML = ['<img class="img-thumbnail" src="', e.target.result,
                    '" title="', escape(theFile.name), '"/>'].join('');
                document.getElementById('output').innerHTML = "";
                document.getElementById('output').insertBefore(span, null);
            };
        })(f);
        // Read in the image file as a data URL.
        reader.readAsDataURL(f);
    }
    function reset(evt) {
        var file = evt.target.files; // FileList object
        var f = file[0];
        f = "";
    }
    document.getElementById('file').addEventListener('change', showImage, false);
    // document.getElementById('file').addEventListener('load', reset, false);
</script>
</body>
</html>
