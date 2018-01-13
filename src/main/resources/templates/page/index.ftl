<!DOCTYPE html>
<html>
<head>
    <title>楠尼玛人工瞎聊</title>
    <meta name="viewport" content="initial-scale=1, user-scalable=0, minimal-ui">
    <meta name="keywords" content="keyword1,keyword2,keyword3"></meta>
    <meta name="description" content="this is my page"></meta>
    <meta name="content-type" content="text/html; charset=UTF-8"></meta>
    <script type="text/javascript" src="/demo/js/jquery.js"></script>
    <link rel="stylesheet" href="/demo/layui/css/layui.css" media="all">
    <script type="text/javascript" src="/demo/layui/layui.js"></script>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
</head>
<style>
    .loading{
        width:250px;
        height:56px;
        margin: 0 auto;
        line-height:56px;
        color:#fff;
        padding-left:60px;
        font-size:15px;
        background: #000 url(layui/images/loader.gif) no-repeat 10px 50%;
        opacity: 0.7;
        z-index:9999;
        -moz-border-radius:20px;
        -webkit-border-radius:20px;
        border-radius:20px;
        filter:progid:DXImageTransform.Microsoft.Alpha(opacity=70);
    }
    .tag_confidence{
        color: #FD482C;
    }
    .tag_name{
        color: #FD482C;
    }
</style>
<script>
    var callbackNumber = {
        '4096':	'参数非法',
        '12289':'应用不存在',
        '12801':'素材不存在',
        '12802':'素材ID与应用ID不匹配',
        '16385':'缺少app_id参数',
        '16386':'缺少time_stamp参数',
        '16387':'缺少nonce_str参数',
        '16388':'请求签名无效',
        '16389':'缺失API权限',
        '16390':'time_stamp参数无效',
        '16391':'同义词识别结果为空	系统识别结果为空',
        '16392':'专有名词识别结果为空	系统识别结果为空',
        '16393':'意图识别结果为空	系统识别结果为空',
        '16394':'闲聊返回结果为空	系统处理结果为空',
        '16396':'图片格式非法	请检查图片格式是否符合API要求',
        '16397':'图片体积过大	请检查图片大小是否超过API限制',
        '16402':'图片没有人脸	请检查图片是否包含人脸',
        '16403':'相似度错误	请联系客服反馈问题',
        '16404':'人脸检测失败',
        '16405':'图片解码失败',
        '16406':'特征处理失败',
        '16407':'提取轮廓错误',
        '16408':'提取性别错误',
        '16409':'提取表情错误',
        '16410':'提取年龄错误',
        '16411':'提取姿态错误',
        '16412':'提取眼镜错误',
        '16413':'提取魅力值错误',
        '16414':'语音合成失败',
        '16415':'图片为空',
        '16416':'个体已存在',
        '16417':'个体不存在',
        '16418':'人脸不存在',
        '16419':'分组不存在',
        '16420':'分组列表不存在',
        '16421':'人脸个数超过限制',
        '16422':'个体个数超过限制',
        '16423':'组个数超过限制',
        '16424':'对个体添加了几乎相同的人脸',
        '16425':'无效的图片格式',
        '16426':'图片模糊度检测失败',
        '16427':'美食图片检测失败',
        '16428':'提取图像指纹失败',
        '16429':'图像特征比对失败',
        '16430':'OCR照片为空',
        '16431':'OCR识别失败',
        '16432':'输入图片不是身份证',
        '16433':'名片无足够文本',
        '16434':'名片文本行倾斜角度太大',
        '16435':'名片模糊',
        '16436':'名片姓名识别失败',
        '16437':'名片电话识别失败',
        '16438':'图像为非名片图像',
        '16439':'检测或者识别失败',
        '16440':'未检测到身份证',
        '16441':'请使用第二代身份证件进行扫描',
        '16442':'不是身份证正面照片',
        '16443':'不是身份证反面照片',
        '16444':'证件图片模糊',
        '16445':'请避开灯光直射在证件表面',
        '16446':'行驾驶证OCR识别失败',
        '16447':'通用OCR识别失败',
        '16448':'银行卡OCR预处理错误',
        '16449':'银行卡OCR识别失败',
        '16450':'营业执照OCR预处理失败',
        '16451':'营业执照OCR识别失败',
        '16452':'意图识别超时',
        '16453':'闲聊处理超时',
        '16454':'语音识别解码失败',
        '16455':'语音过长或空',
        '16456':'翻译引擎失败',
        '16457':'不支持的翻译类型'
    }
    function startRecord(){
        wx.startRecord();
    }
    function stopRecord(){
        wx.stopRecord({
            success: function (res) {
                var localId = res.localId;
                wx.playVoice({
                    localId: localId.toString() // 需要播放的音频的本地ID，由stopRecord接口获得
                });
                document.getElementById("recordId").value=localId.toString();
            }
        });
    }
    function playVoice(){
        wx.playVoice({
            localId: document.getElementById("recordId").value // 需要播放的音频的本地ID，由stopRecord接口获得
        });
    }
    function uploadVoice(){
        wx.uploadVoice({
            localId: document.getElementById("recordId").value, // 需要上传的音频的本地ID，由stopRecord接口获得
            isShowProgressTips: 1, // 默认为1，显示进度提示
            success: function (res) {
                var serverId = res.serverId; // 返回音频的服务器端ID
//                $.post("/demo/uploadVoice",{media_id:serverId} ,function (data) {
//                        alert(data);
//                });
            }
        });
    }
    function translateVoice() {
        wx.translateVoice({
            localId: document.getElementById("recordId").value, // 需要识别的音频的本地Id，由录音相关接口获得
            isShowProgressTips: 1, // 默认为1，显示进度提示
            success: function (res) {
                alert(res.translateResult); // 语音识别的结果
            }
        });
    }
</script>
<body>
<br><br><br>
<h2 style="text-align: center"><i class="layui-icon">&#xe681;</i> 楠尼玛人工瞎聊 <i class="layui-icon">&#xe65d;</i></h2>
<br><br>
<div style="text-align: center">
    <input hidden id="recordId">
    <button class="layui-btn layui-btn-fluid" style="width:95%;" onclick = "startRecord()">长按录音(限30秒)</button>
    <br><br>
    <button class="layui-btn layui-btn-fluid" style="width:95%;" onclick = "stopRecord()">停止录音</button>
    <br><br>
    <button class="layui-btn layui-btn-fluid" style="width:95%;" onclick = "playVoice()">播放录音</button>
    <br><br>
    <button class="layui-btn layui-btn-fluid" style="width:95%;" onclick = "uploadVoice()">上传录音</button>
    <br><br>
    <button class="layui-btn layui-btn-fluid" style="width:95%;" onclick = "translateVoice()">录音识别</button>
    </div>
<script>
    layui.use('upload', function(){
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
                offset: '90px',
                area: ['100%','340px'],
                title: '您没有关注测试号无法使用',
                type: 1,
                content: '<img src="/demo/images/test.png" width="100%" height="300px">' //这里content是一个普通的String
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
</script>
</body>
</html>