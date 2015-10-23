fn = 100;

module pump_arm_bottom(thickness, innner_d, outer_d, arm_radius, arm_mount_radius){
  difference(){
    pump_arm(thickness, innner_d, outer_d, arm_radius, arm_mount_radius);
    union(){
      translate(v=[0,0,3.6+thickness]) cube(size = [arm_mount_radius*4, arm_radius*4, thickness*2], center=true);
      translate(v=[0, arm_radius,2]) cylinder(r = 11.5, h = 7.1, center=true, $fn = fn);
      translate(v=[0,-arm_radius,2]) cylinder(r = 11.5, h = 7.1, center=true, $fn = fn);
    }
  }
}

module pump_arm_top(thickness, innner_d, outer_d, arm_radius, arm_mount_radius){
  difference(){
    pump_arm(thickness, innner_d, outer_d, arm_radius, arm_mount_radius);
    translate(v=[0,0,3.6-thickness*2]) cube(size = [arm_mount_radius*4, arm_radius*4, thickness*4], center=true);
  }
}


module pump_arm(thickness, innner_d, outer_d, arm_radius, arm_mount_radius){
  radius = arm_mount_radius;
  
  difference(){
    union(){
      
      // upper arm
      translate(v=[0, arm_radius,3.6+thickness/2]) cylinder(r = radius, h = thickness, center=true, $fn = fn);
      translate(v=[0,-arm_radius,3.6+thickness/2]) cylinder(r = radius, h = thickness, center=true, $fn = fn);
      translate(v=[0,0,3.6+thickness/2]) cube(size = [radius*2, arm_radius*2, thickness], center=true);

      // lower arm
      translate(v=[0,arm_radius,-(3.6+thickness/2)]) cylinder(r = radius, h = thickness, center=true, $fn = fn);
      translate(v=[0,-arm_radius,-(3.6+thickness/2)]) cylinder(r = radius, h = thickness, center=true, $fn = fn);
      translate(v=[0,0,-(3.6+thickness/2)]) cube(size = [radius*2, arm_radius*2, thickness], center=true);
     
     // body
     translate(v=[0,0,0]) cube(size = [radius*2, arm_radius*2, 7.2+thickness*2], center=true);
     translate(v=[5,0,0]) cube(size = [10, 20, 7.2+thickness*2], center=true);

    }
    union(){

      // bolt holes
      translate(v=[0, arm_radius,0]) cylinder(r = 4.1, h = 20, center=true, $fn = fn);
      translate(v=[0,-arm_radius,0]) cylinder(r = 4.1, h = 20, center=true, $fn = fn);

      // bearing holes
      translate(v=[0, arm_radius,0]) cylinder(r = 11.5, h = 7.1, center=true, $fn = fn);
      translate(v=[0,-arm_radius,0]) cylinder(r = 11.5, h = 7.1, center=true, $fn = fn);

      // 5mm stepper axle hole
      translate(v=[0,0,0]) cylinder(r = 5/2, h = thickness*4+11, center=true, $fn = fn);
      translate(v=[6,0, 5])  cube(size = [3, 7.1, 10], center=true);  // m4 nut slot
      rotate([0,90,0]) translate(v=[3, 0, 10])  cylinder(r = 2, h = 20, center=true, $fn = fn);
    }
  }


}

tubing_r = 30; 
pump_arm(5, 7, 9 , tubing_r);

//translate(v=[0,tubing_r-9,0]) m8_bearing();
//translate(v=[0,-tubing_r+9,0]) m8_bearing();
//color([0.1,1,0.1]) translate(v=[0,0,0]) cube(size = [100,100,0.01], center=true);
