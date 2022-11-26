// adapted from https://github.com/Golobro/rgbcolorslider

// select RGB inputs
let hue = qs('#hue'),
chrma = qs('#chroma'),
luminance = qs('#luminance');

// select num inputs
let hueNumVal = qs('#hueNum'),
chromaNumVal = qs('#chromaNum'),
luminanceNumVal = qs('#luminanceNum');

// select Color Display
let colorDisplayHCL = qs('.hcl-slider-wrap');

// select labels
let hueLbl = qs('label[for=hue]'),
chromaLbl = qs('label[for=chroma]'),
luminanceLbl = qs('label[for=luminance]');

// init display Colors
displayColorsHCL();
// init Color Vals
colorNumbrValsHCL();
// init ColorSliderVals
initSliderColorsHCL();
// init Change Range Val
changeRangeNumValHCL();
// init Colors controls
colorSlidersHCL();

// display colors
function displayColorsHCL(){
  colorDisplayHCL.style.backgroundColor = chroma.hcl(parseInt(hue.value), parseInt(chrma.value), parseInt(luminance.value)).css();
}

// initial color val when DOM is loaded
function colorNumbrValsHCL(){
    hueNumVal.value = hue.value;
    chromaNumVal.value = chrma.value;
    luminanceNumVal.value = luminance.value;
}

// initial colors when DOM is loaded
function initSliderColorsHCL(){
    // label bg colors
    hueLbl.style.background = chroma(parseInt(hue.value),180,0,'hcl').css();
    chromaLbl.style.background = chroma(0,parseInt(chrma.value),0,'hcl').css();
    luminanceLbl.style.background = chroma(0,0,parseInt(luminance.value),'hcl').css();

    // slider bg colors
    sliderFillHCL(hue);
    sliderFillHCL(chrma);
    sliderFillHCL(luminance);
}

// Slider Fill offset
function sliderFillHCL(clr){
    let val = (clr.value - clr.min) / (clr.max - clr.min);
    let percent = val * 100;

    // clr input
    if(clr === hue){
        let cval = chroma.hcl(parseInt(clr.value), 180, 0).css();
        clr.style.background = `linear-gradient(to right, ${cval} ${percent}%, #cccccc 0%)`;
    } else if (clr === chrma) {
        let cval = chroma.hcl(0, parseInt(clr.value), 0).css();
        clr.style.background = `linear-gradient(to right, ${cval} ${percent}%, #cccccc 0%)`;
    } else if (clr === luminance) {
        let cval = chroma.hcl(0, 0, parseInt(clr.value)).css();
        clr.style.background = `linear-gradient(to right, ${cval} ${percent}%, #cccccc 0%)`;
    }
}

// change range values by number input
function changeRangeNumValHCL(){

    // Validate number range
    hueNumVal.addEventListener('change', ()=>{
        // make sure numbers are entehue between 0 to 360
        if(hueNumVal.value > 360){
            alert('cannot enter numbers greater than 360');
            hueNumVal.value = hue.value;
        } else if(hueNumVal.value < 0) {
            alert('cannot enter numbers less than 0');
            hueNumVal.value = hue.value;
        } else if (hueNumVal.value == '') {
            alert('cannot leave field empty');
            hueNumVal.value = hue.value;
            initSliderColorsHCL();
            displayColorsHCL();
        } else {
            hue.value = hueNumVal.value;
            initSliderColorsHCL();
            displayColorsHCL();
        }
    });

    // Validate number range
    chromaNumVal.addEventListener('change', ()=>{
        // make sure numbers are entered between 0 to 180
        if(chromaNumVal.value > 180){
            alert('cannot enter numbers greater than 180');
            chromaNumVal.value = chrma.value;
        } else if(chromaNumVal.value < 0) {
            alert('cannot enter numbers less than 0');
            chromaNumVal.value = chrma.value;
        } else if(chromaNumVal.value == '') {
            alert('cannot leave field empty');
            chromaNumVal.value = chrma.value;
            initSliderColorsHCL();
            displayColorsHCL();
        } else {
            chrma.value = chromaNumVal.value;
            initSliderColorsHCL();
            displayColorsHCL();
        }
    });

    // Validate number range
    luminanceNumVal.addEventListener('change', ()=>{
        // make sure numbers are entered between 0 to 100
        if (luminanceNumVal.value > 100) {
            alert('cannot enter numbers greater than 100');
            luminanceNumVal.value = luminance.value;
        } else if (luminanceNumVal.value < 0) {
            alert('cannot enter numbers less than 0');
            luminanceNumVal.value = luminance.value;
        } else if(luminanceNumVal.value == '') {
            alert('cannot leave field empty');
            luminanceNumVal.value = luminance.value;
            initSliderColorsHCL();
            displayColorsHCL();
        } else {
            luminance.value = luminanceNumVal.value;
            initSliderColorsHCL();
            displayColorsHCL();
        }
    });
}

// Color Sliders controls
function colorSlidersHCL(){
    hue.addEventListener('input', () => {
        displayColorsHCL();
        initSliderColorsHCL();
        changeRangeNumValHCL();
        colorNumbrValsHCL();
    });

    chrma.addEventListener('input', () => {
        displayColorsHCL();
        initSliderColorsHCL();
        changeRangeNumValHCL();
        colorNumbrValsHCL();
    });

    luminance.addEventListener('input', () => {
        displayColorsHCL();
        initSliderColorsHCL();
        changeRangeNumValHCL();
        colorNumbrValsHCL();
    });
}
