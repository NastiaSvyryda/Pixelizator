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
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script type="text/javascript" src="script.js"></script>
    <link rel="stylesheet" href="mystyle.css">
<%--    <script type="text/javascript" src="https://platform-api.sharethis.com/js/sharethis.js#property=5f9ad1924fa617001994479a&product=image-share-buttons" async="async"></script>--%>
</head>
<body>
    <h1>Pixelizator</h1>
    <form action="Pixelizator"
        method="post"
        enctype="multipart/form-data" class="center">
<%--        <div class="center">--%>
<%--            <p class="element">--%>
            <label for="file">Download by file</label>
            <input class="element" name="file" id="file" type="file" accept="image/*">
<%--            </p>--%>
<%--            <p class="element">--%>
            <label for="fileUrl">Download by url</label>
            <input class="element" name="fileUrl" id="fileUrl" type='text' />
<%--            </p>--%>
<%--        </div>--%>
        <br>
<%--        <div class="center">--%>
            <label for="pixSize">Select size of pixel</label>
            <input name="pixSize" id="pixSize" type='number' min="0" value="10"/>
<%--        </div>--%>
        <br>
        <div id="divImage" style ="display:none">
            <img id="Img" src="" style="max-width: 80%" alt="your image">
            <br>
            <p>
                Total size: <span id="fileSize">0 MiB</span>
            </p>
            <button id="submitButton" type="submit" value="Upload" style="font-size: 20px;
        border-radius: 6px;
        border: none;
        background-color: black;
        color: aliceblue;
        cursor: pointer;" >Pixelate</button>
            <br>
        </div>
    </form>
    <div id="downloadButtons" style ="display:none">
        <div class="center">
            <img id="NewImg" src="" style="max-width: 80%" alt="your image">
            <br>
            <br>
            Download as:
            <a id="downloadJpg" class="button" href="" download="pixel.jpg">jpg</a>
            <a id="downloadPng" class="button" href="" download="pixel.png">png</a>
            <a id="downloadWebp" class="button" href="" download="pixel.webp">webp</a>
            <a id="downloadBmp" class="button" href="" download="pixel.bmp">bmp</a>
            <br>
            <br>
        </div>
    </div>
</body>
</html>
