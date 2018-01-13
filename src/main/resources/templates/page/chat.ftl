<html lang="zh-cn" >
<head>
    <meta charset="utf-8" />
    <meta HTTP-EQUIV="pragma" CONTENT="no-cache">
    <meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
    <meta HTTP-EQUIV="expires" CONTENT="0">
    <meta name="apple-touch-fullscreen" content="yes" />
    <meta name="format-detection" content="telephone=no" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0 user-scalable=no" media="screen" />
    <title>跟楠尼玛瞎聊中</title>
    <script type="text/javascript" src="/demo/js/jquery.js"></script>
    <link rel="stylesheet" href="/demo/layui/css/layui.css" media="all">
    <script type="text/javascript" src="/demo/layui/layui.js"></script>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
    <style type="text/css">
        body{background:url(images/yuyin_bg.png) no-repeat;background-size:100%;}
        @media all and (min-width: 640px) {
            body,html,.wenwen-footer,.speak_window{width:640px!important;margin:0 auto}
            .speak_window,.wenwen-footer{left:50%!important;margin-left:-320px}
        }
        input,button{outline:none;}
        .wenwen-footer{width:100%;position:fixed;bottom:-5px;left:0;background:#fff;padding:3%;border-top:solid 1px #ddd;box-sizing:border-box;}
        .wenwen_btn,.wenwen_help{width:15%;text-align:center;}
        .wenwen_btn img,.wenwen_help img{height:40px;}
        .wenwen_text{height:40px;border-radius:5px;border:solid 1px #636162;box-sizing:border-box;width:66%;text-align:center;overflow:hidden;margin-left:2%;}
        .circle-button{padding:0 5px;}
        .wenwen_text .circle-button{font-size:14px;color:#666;line-height:38px;}
        .write_box{background:#fff;width:100%;height:40px;line-height:40px;display:none;}
        .write_box input{height:40px;padding:0 5px;line-height:40px;width:100%;box-sizing:border-box;border:0;}
        .wenwen_help button{width:95%;background:#42929d;color:#fff;border-radius:5px;border:0;height:40px;display:none;}
        #wenwen{height:100%;}
        .speak_window{overflow-y:scroll;height:100%;width:100%;position:fixed;top:0;left:0;}
        .speak_box{margin-bottom:70px;padding:10px;}
        .question,.answer{margin-bottom:1rem;}
        .question{text-align:right;}
        .question>div{display:inline-block;}
        .left{float:left;}
        .right{float:right;}
        .clear{clear:both;}
        .heard_img{height:60px;width:60px;border-radius:5px;overflow:hidden;background:#ddd;}
        .heard_img img{width:100%;height:100%}
        .question_text,.answer_text{box-sizing:border-box;position:relative;display:table-cell;min-height:60px;}
        .question_text{padding-right:20px;}
        .answer_text{padding-left:20px;}
        .question_text p,.answer_text p{border-radius:10px;padding:.5rem;margin:0;font-size:14px;line-height:28px;box-sizing:border-box;vertical-align:middle;display:table-cell;height:60px;word-wrap:break-word;}
        .answer_text p{background:#fff;}
        .question_text p{background:#42929d;color:#fff;text-align:left;}
        .question_text i,.answer_text i{width:0;height:0;border-top:5px solid transparent;border-bottom:5px solid transparent;position:absolute;top:25px;}
        .answer_text i{border-right:10px solid #fff;left:10px;}
        .question_text i{border-left:10px solid #42929d;right:10px;}
        .answer_text p a{color:#42929d;display:inline-block;}
        audio{display:none;}
        .saying{position:fixed;bottom:30%;left:50%;width:120px;margin-left:-60px;display:none;}
        .saying img{width:100%;}
        .write_list{position:absolute;left:0;width:100%;background:#fff;border-top:solid 1px #ddd;padding:5px;line-height:30px;}
    </style>
</head>
<body>
<div id="voiceLocated"></div>
<script>
    $.post("/demo/getVoice",{text:'我就是可爱的楠尼玛，有啥想和我说的'} ,function (data) {
        document.getElementById("voiceLocated").innerHTML = '<audio src="'+data+'" autoplay></audio>';
    });
    function alerthelp(){
        layer.msg('我是楠尼玛，我并不是一个集才华和美貌于一身的男子，如果你想要和我探讨或者要源码，请联系我,QQ：519286925,或者查看我的Github：https://github.com/x519286925', {icon: 6,time: 5000});
    }
</script>
<input hidden id="recordId">
<div class="speak_window">
    <div class="speak_box">
        <div class="answer">
            <div class="heard_img left"><img src="images/dglvyou.jpg"></div>
            <div class="answer_text">
                <p>我就是可爱的楠尼玛，有啥想和我说的</p>
                <i></i>
            </div>
        </div>
    </div>
</div>
<div class="saying">
    <img src="images/saying.gif"/>
</div>
<div class="wenwen-footer">
    <div class="wenwen_btn left" onClick="to_write()"><img src="images/jp_btn.png"></div>
    <div class="wenwen_text left">
        <div class="write_box">
            <input type="text" class="left" onKeyUp="keyup()" placeholder="请输入内容" />
        </div>
        <div class="circle-button" id="wenwen">
            按住 说话
        </div>
    </div>
    <div class="wenwen_help right">
        <a onclick="alerthelp()">
            <img src="images/help_btn.png">
        </a>
        <button onClick="up_say()" class="right">发送</button>
    </div>
    <div style="opacity:0;" class="clear"></div>
</div>
<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
    layui.use('upload', function() {

        wx.config({
            debug: 0, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
            appId: '${wxJsVO.appId}', // 必填，公众号的唯一标识
            timestamp: ${wxJsVO.timestamp}, // 必填，生成签名的时间戳
            nonceStr: '${wxJsVO.nonceStr}', // 必填，生成签名的随机串
            signature: '${wxJsVO.signature}',// 必填，签名，见附录1
            jsApiList: ['startRecord','stopRecord','playVoice','stopVoice','uploadVoice','translateVoice'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
        });
        wx.error(function(res){
            layer.open({
                offset: '40px',
                area: ['100%','400px'],
                title: '使用录音功能需关注测试号',
                type: 1,
                content: '<img src="/demo/images/test.png" width="100%" height="290px"><br><h3 style="text-align: center">(关注后需刷新页面)</h3>' //这里content是一个普通的String
            });
            // config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
        });
        wx.checkJsApi({
            jsApiList: ['startRecord','stopRecord','playVoice','stopVoice','uploadVoice','translateVoice'], // 需要检测的JS接口列表，所有JS接口列表见附录2,
            success: function(res) {
                console.log("接口是否可以调用："+res);
                // 以键值对的形式返回，可用的api值true，不可用为false
                // 如：{"checkResult":{"chooseImage":true},"errMsg":"checkJsApi:ok"}
            }
        });

    });
        function to_write() {
            $('.wenwen_btn img').attr('src', 'images/yy_btn.png');
            $('.wenwen_btn').attr('onclick', 'to_say()');
            $('.write_box,.wenwen_help button').show();
            $('.circle-button,.wenwen_help a').hide();
            $('.write_box input').focus();
            for_bottom();
        }

        function to_say() {
            $('.write_list').remove();
            $('.wenwen_btn img').attr('src', 'images/jp_btn.png');
            $('.wenwen_btn').attr('onclick', 'to_write()');
            $('.write_box,.wenwen_help button').hide();
            $('.circle-button,.wenwen_help a').show();
        }

        function up_say() {
            $('.write_list').remove();
            var text = $('.write_box input').val(),
                    str = '<div class="question">';
            str += '<div class="heard_img right"><img src="images/dglvyou2.jpg"/></div>';
            str += '<div class="question_text clear"><p>' + text + '</p><i></i>';
            str += '</div></div>';
            if (text == '') {
                layer.msg('请输入内容', {icon: 5});
                $('.write_box input').focus();
            } else {
                $('.speak_box').append(str);
                document.title = '对方正在输入中.......';
                $('.write_box input').val('');
                $.post("/demo/uploadText",{text:text} ,function (data) {
                    var json = eval('(' + data + ')');
                    if(json.ret=="0"){
//                        $('.write_box input').focus();
                        autoWidth();
                        for_bottom();
                        setTimeout(function () {
                            var ans = '<div class="answer"><div class="heard_img left"><img src="images/dglvyou.jpg"/></div>';
                            ans += '<div class="answer_text"><p>' + json.data.answer + '</p><i></i>';
                            ans += '</div></div>';
                            $('.speak_box').append(ans);
                            for_bottom();
                            document.title = '跟楠尼玛瞎聊中';
                        }, 1000);
                        $.post("/demo/getVoice",{text:json.data.answer} ,function (data) {
                                   document.getElementById("voiceLocated").innerHTML = '<audio src="'+data+'" autoplay></audio>';
                        });
                    }
                    else{
                        $('.write_box input').val('');
//                        $('.write_box input').focus();
                        autoWidth();
                        for_bottom();
                        setTimeout(function () {
                            var ans = '<div class="answer"><div class="heard_img left"><img src="images/dglvyou.jpg"/></div>';
                            ans += '<div class="answer_text"><p>' + '我无言以对，我听不懂，我闭嘴' + '</p><i></i>';
                            ans += '</div></div>';
                            $('.speak_box').append(ans);
                            for_bottom();
                            document.title = '跟楠尼玛瞎聊中';
                        }, 0);
                    }
               });

            }
        }

        function keyup() {
            var footer_height = $('.wenwen-footer').outerHeight(),
                    text = $('.write_box input').val(),
                    str = '<div class="write_list">' + text + '</div>';
            if (text == '' || text == undefined) {
                $('.write_list').remove();
            } else {
                $('.wenwen-footer').append(str);
                $('.write_list').css('bottom', footer_height);
            }
        }

        var wen = document.getElementById('wenwen');

        function _touch_start(event) {
            event.preventDefault();
            $('.wenwen_text').css('background', '#c1c1c1');
            $('.wenwen_text span').css('color', '#fff');
            $('.saying').show();
            wx.startRecord();
        }

        function _touch_end(event) {
            event.preventDefault();
            $('.wenwen_text').css('background', '#fff');
            $('.wenwen_text .circle-button').css('color', '#666');
            $('.saying').hide();

            wx.stopRecord({
                success: function (res) {
                    var localId = res.localId;
                    wx.translateVoice({
                        localId: localId.toString(), // 需要识别的音频的本地Id，由录音相关接口获得
                        isShowProgressTips: 1, // 默认为1，显示进度提示
                        success: function (res) {
//                            alert(res.translateResult); // 语音识别的结果
                                var str = '<div class="question">';
                                str += '<div class="heard_img right"><img src="images/dglvyou2.jpg"/></div>';
                                str += '<div class="question_text clear"><p>' + res.translateResult + '</p><i></i>';
                                str += '</div></div>';
                                $('.speak_box').append(str);
                                for_bottom();
                                //以上是语音识别

                            document.title = '对方正在输入中.......';
                            $.post("/demo/uploadText",{text:res.translateResult} ,function (data) {
                                var json = eval('(' + data + ')');
                                if (json.ret == "0") {
                                    autoWidth();
                                    for_bottom();
                                    setTimeout(function () {
                                        var ans = '<div class="answer"><div class="heard_img left"><img src="images/dglvyou.jpg"/></div>';
                                        ans += '<div class="answer_text"><p>' + json.data.answer + '</p><i></i>';
                                        ans += '</div></div>';
                                        $('.speak_box').append(ans);
                                        for_bottom();
                                        document.title = '跟楠尼玛瞎聊中';
                                    }, 1000);
                                    $.post("/demo/getVoice",{text:json.data.answer} ,function (data) {
                                        document.getElementById("voiceLocated").innerHTML = '<audio src="'+data+'" autoplay></audio>';
                                    });
                                }
                            });


                        }
                    });
                }
            });
//            setTimeout(function () {
//                var ans = '<div class="answer"><div class="heard_img left"><img src="images/dglvyou.jpg"/></div>';
//                ans += '<div class="answer_text"><p>我不知道你在说什么?</p><i></i>';
//                ans += '</div></div>';
//                $('.speak_box').append(ans);
//                for_bottom();
//            }, 1000);
        }

        wen.addEventListener("touchstart", _touch_start, false);
        wen.addEventListener("touchend", _touch_end, false);

        function for_bottom() {
            var speak_height = $('.speak_box').height();
            $('.speak_box,.speak_window').animate({scrollTop: speak_height}, 500);
        }

        function autoWidth() {
            $('.question_text').css('max-width', $('.question').width() - 60);
        }

        autoWidth();
</script>

</body>
</html>
