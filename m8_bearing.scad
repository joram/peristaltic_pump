module m8_bearing(){
  difference(){
    cylinder(r = 22/2, h =7, center=true, $fn = fn);
    cylinder(r = 8/2, h =7+0.1, center=true, $fn = fn);
  }
}