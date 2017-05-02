$(document).ready(function() {
    $("#newbrands").change(function(){
        var val = $(this).val();
        if (val == "GMC") {
            console.log(val);
            $("#newmodels").html("<select class='selectpicker form-control' name='Model'><option selected='selected'>Model</option><option value='Yukon'>Yukon</option><option value='Canyon'>Canyon</option></select>");
        }
        else if (val == "Jeep") {
            console.log(val);
            $("#newmodels").html("<select class='selectpicker form-control' name='Model'><option selected='selected'>Model</option><option value='Cherokee'>Cherokee</option><option value='Compass'>Compass</option></select>");

        } else if (val == "Ford") {
            console.log(val);
            $("#newmodels").html("<select class='selectpicker form-control' name='Model'><option selected='selected'>Model</option><option value='F-150'>F-150</option><option value='Fusion'>Fusion</option></select>");
        } else if (val == "Toyota") {
            console.log(val);
            $("#newmodels").html("<select class='selectpicker form-control' name='Model'><option selected='selected'>Model</option><option value='Prius'>Prius</option> <option value='Camry'>Camry</option> <option value='Corolla'>Corolla</option> <option value='Hignlander'>Hignlander</option></select>");
        }
        $('.selectpicker').selectpicker();
    });
});