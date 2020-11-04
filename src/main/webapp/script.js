$(document).ready(function() {
    $('form').submit(function(event) {
        event.preventDefault();
        var data = new FormData(this);
        if ($('#file').val().length !== 0) {
            console.log("file");
            data.append("type", "file");
        }
        if ($('#fileUrl').val().length !== 0) {
            console.log("fileUrl");
            data.append("type", "url");
        }
        // Calling AJAX
        $.ajax({
            url : $(this).attr('action'),
            type : $(this).attr('method'),
            data : data,
            contentType : false,
            cache : false,
            processData : false,
            success : function(response) {
                // обработка ответа от сервера
                console.log(response);
                document.getElementById("NewImg").src = response;
                console.log(document.getElementById("NewImg").src);
                document.getElementById("downloadButtons").style.display = "initial";
                document.getElementById("downloadJpg").href = response;
                document.getElementById("downloadPng").href = response;
                document.getElementById("downloadWebp").href = response;
                document.getElementById("downloadBmp").href = response;
            }
        });
        return false;
    });

    document.getElementById("file").addEventListener('change', function() {
        if (this.files && this.files[0]) {
            var image = document.getElementById("Img");  // $('img')[0]
            image.src = URL.createObjectURL(this.files[0]); // set src to blob url
            var img= this.files[0].size;
            var imgsize = img/1000000;
            document.getElementById("fileSize").innerHTML = imgsize.toFixed(3) + " MiB";
            image.onload = imageIsLoaded;
            document.getElementById("fileUrl").value = null;
            document.getElementById("divImage").style.display = "initial";
            document.getElementById("downloadButtons").style.display = "none";
        }
    });

    document.getElementById("fileUrl").addEventListener('change', function() {
        var image = document.getElementById("Img");  // $('img')[0]
        var downloadingImage = new Image();
        downloadingImage.onload = function() {
            image.src = this.src;
        };
        if (document.getElementById("fileUrl").value != null) {
            downloadingImage.src = document.getElementById("fileUrl").value;
            document.getElementById("file").value = null;
            document.getElementById("divImage").style.display = "initial";
            document.getElementById("downloadButtons").style.display = "none";
        }

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