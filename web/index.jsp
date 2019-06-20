<%-- 
    Document   : index
    Created on : Jun 14, 2019, 10:22:21 AM
    Author     : Elian L. Fernandez / Gaby
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.Authentication"%>
<%@page import="hibernate.entityclasses.Syscompany"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Highlander Enterprise System</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/index.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript"></script>
        <script src='https://code.jquery.com/jquery-3.4.1.min.js'></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    </head>
    <body>
        
        
        <span class="heading-section">            
              <span class="line line1"></span>
              <span class="header-Letters">Highlander</span> 
              <span class="subheader">Enterprise System</span>
        </span>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/animejs/2.0.2/anime.min.js"></script>
        
        <%-- 
        <div class="heading-section">   
            <span class="line line1"></span>
            <span class="header-Letters">Highlander</span>
            <span class="subheader">Enterprise System </span>
       </div>
        --%>     
        
        
<div class="login-page">      
   <div class="form">       
       <form class="register-form" id="register-form" name="registerform" action="/action_page.php" method="post">                 
        <i class="fa fa-user-circle icon"></i>
        <input type="text" id="fn" name="firstname" placeholder="First name" onkeyup="FormSignUpLetterOnlyValidation(this)" required/>
        <i class="fa fa-user-circle icon"></i>
        <input type="text" id="ln" name="lastname" placeholder="Last name" onkeyup="FormSignUpLetterOnlyValidation(this)" required/>
        <i class="fa fa-user icon"></i>
        <input type="text" id="un" name="username" placeholder="Username" onkeyup="this.value = this.value.toLowerCase()" required/>
        <i class="fa fa-key icon"></i>
        <input type="password" id="passw" name="password" placeholder="Password" required/>
        <i class="fa fa-envelope icon"></i>
        <input type="email" id="em" name="email" placeholder="Email" required/>
        <i class="fa fa-qrcode icon"></i>
        <input type="text" id="ac" name="accesscode" placeholder="Access Code" onkeyup="FormSignUpNumbersOnlyValidation(this)" required/>
        <label class="terms-and-cond"><a href="#termsandcond">I have read and agree to the Terms and Conditions</a>
            <input type="checkbox" id="chkb" name="termsAndCond" value="TermsAndCond" required/>
         <span class="checkmark"></span>
        </label>
        <button id="submitSignUp" value="signup">SIGN UP</button>
        <br/>
        <p class="message">Already Registered?  <a href="#signin"><strong>SIGN IN</strong></a></p> 
        <br/>       
        <div class="errorsignup-panel">
        <label id="errorSignupPanel">
           <strong>Warning: </strong> 
           It is mandatory to be in agreement with the Terms and Conditions of Service and Use.           
        </label>
        </div>
       </form>        
       
       <form class="login-form" name="loginform" action="/action_page.php" method="post">
        <i class="fa fa-user icon"></i>
        <input type="text" name="username" placeholder="Username" onkeyup="this.value = this.value.toLowerCase()" required/>
        <i class="fa fa-key icon"></i>
        <input type="password" name="password" placeholder="Password" required/>
        <i class="fa fa-building icon"></i>
        
        <%-- Populate the company selection --%>
        <select class="combobox">
            <%
                Authentication a = new Authentication();
                for (Syscompany co : a.getCompaniesInfo()){
                   out.println("<option>");
                   out.println(co.getCompanyName());
                   out.println("</option>");
                }
            %>         
        </select>  
        <%-- Populate the company selection --%>
        
        <button id="submitSignIn" name="action" value="signin">SIGN IN</button>
        <p class="message">Not Registered?  <a href="#signup"><strong>SIGN UP</strong></a></p>
        
        <p class="message"><a href="#forgotusername">Forgot Username?</a></p>
        <p class="message"><a href="#forgotpassword">Forgot Password?</a></p>
                             
       </form>       
   </div>    
</div>
    
    <script>
        function FormSignUpLetterOnlyValidation(input){
            //allow only letters
            var regex = /[^a-z]/gi;
            input.value = input.value.replace(regex, "");
        }
        
        function FormSignUpNumbersOnlyValidation(input){
            //allow only numbers
            var regex = /[^0-9]/g;
            input.value = input.value.replace(regex, "");
        }
                      
        //Switch forms
         $('.message a').click(function(){
         $('form').animate({height: "toggle", opacity: "toggle"}, "slow");
         $('.form input').css({"background-color": "#f2f2f2"});
         });
         
         //Check if checkbox of "Terms and Condition" is checked.
        $(function() {             
            $('#submitSignUp').click(function() {
                if ($('#chkb').is(':checked')) {
                    $('.errorsignup-panel').hide();                    
                }
                else {
                    $('.errorsignup-panel').show();
                    $("form#registerform").focus();
                    return false;
                }                
             });
         });  
           
         
       // Wrap every letter in a span
       $('.heading-section .header-Letters').each(function(){
         $(this).html($(this).text().replace(/([^\x00-\x80]|\w)/g, "<span class='header-Letter'>$&</span>"));
       });

       anime.timeline({loop: false})
         .add({
           targets: '.heading-section .line',
           scaleY: [0,1],
           opacity: [0.5,1],
           easing: "easeOutExpo",
           duration: 700
         })
         .add({
           targets: '.heading-section .line',
           translateX: [0,$(".heading-section .header-Letters").width()],
           easing: "easeOutExpo",
           duration: 700,
           delay: 100
         }).add({
           targets: '.heading-section .header-Letter',
           opacity: [0,1],
           easing: "easeOutExpo",
           duration: 600,
           offset: '-=775',
           delay: function(el, i) {
             return 34 * (i+1);
           }
         }).add({
           targets: '.heading-section .line',
           opacity: 0,
           duration: 1000,
           easing: "easeOutExpo",
           delay: 1000
         });
    </script>     
    </body>
</html>

