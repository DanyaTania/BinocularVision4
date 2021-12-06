<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>You are welcome!</title>
    <style>
        .user-info{
            padding: 8px;
            border: 1px #ccc solid;
        }
    </style>
</head>
<body>
<div id="app"> </div>

<script crossorigin src="https://unpkg.com/react@17/umd/react.production.min.js"></script>
<script crossorigin src="https://unpkg.com/react-dom@17/umd/react-dom.production.min.js"></script>
<script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>

<script type="text/babel">
    const user = {
        id : 5,
        age: 33,
        firstName: 'Tom',
        lastName: 'Smit',
        getFullName: function(){
            return `${this.firstName} ${this.lastName}`;
        }
    };
    const userClassName = "user-info";
    const styleObj = {
        color:'red',
        fontFamily:'Verdana'
    };
    ReactDOM.render(
        <div className={userClassName}  style={styleObj}>
            <p>Полное имя: {user.getFullName()}</p>
            <p>Возраст: {user.age}</p>
        </div>,
        document.getElementById("app")
    )
</script>
</body>
</html>


<!-- <html>
<head>
    <title>Index</title>
<META    language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>
</head>
<body>
<br/>
<br/>
<br/>
<nav class="navbar navbar-default navbar-fixed-bottom" style="background: #20B2AA">
    <div class="container-fluid">
        <form class="navbar-form navbar-right" action="/user">
             <input type="hidden" name="find" value="18">
         <form class="navbar-form navbar-right" action="/index">

            <br/>

            <button type="submit" class="btn btn-default"></button>
         </form>
         </form>
    </div>
</nav>
<br/>
<br/>
<br/>
Введите буквы кириллицы:
<input type="text" id="input_cyrillic" placeholder="cyrillic_letter" on>
<script src="../js/jquery-3.2.0.min.js"></script>
<script src="../js/bootstrap.min.js"></script>


</body>
</html>-->