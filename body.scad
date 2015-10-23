fn = 30;

module pump_body(wall_padding, innner_d, outer_d, tubing_r, arm_radius, arm_mount_radius, top_padding){
  width = tubing_r*2 + wall_padding*2 + outer_d;
  height = outer_d + top_padding*2;
  holeR = 4;
  hole_wall_offset = 10;
  hole_w = width/2-hole_wall_offset;

  difference(){
   union(){
    difference(){
     cube(size = [width, width, height], center=true);
     union(){
      torus(tubing_r, outer_d/2);
      cylinder(r = tubing_r, h = outer_d, center=true, $fn = fn);
      rotate([0,0, 30]) translate(v=[ tubing_r, 25, 0]) rotate([90,0,0]) cylinder(r=outer_d/2, h=50, center=true, $fn = fn);
      rotate([0,0,-30]) translate(v=[-tubing_r, 25, 0]) rotate([90,0,0]) cylinder(r=outer_d/2, h=50, center=true, $fn = fn); 
      cylinder(r=arm_radius + arm_mount_radius + 0.5, h=height*4, center=true, $fn = fn);  // center
     }
    }
    translate([0,0,-height/2-wall_padding/2 + 0.1]) cube(size = [width, width, wall_padding], center=true);
    difference(){
     translate([0,0, height/2+wall_padding/2 - 0.1]) cube(size = [width, width, wall_padding], center=true);
     nema_bolts(100);
    }
   }
   union(){
    translate(v=[hole_w,hole_w,0]) cylinder(r = holeR, h = height*3, center=true);
    translate(v=[-hole_w,hole_w,0]) cylinder(r = holeR, h = height*3, center=true);
    translate(v=[-hole_w,-hole_w,0]) cylinder(r = holeR, h = height*3, center=true);
    translate(v=[hole_w,-hole_w,0]) cylinder(r = holeR, h = height*3, center=true);
   }
  }
}

module nema_bolts(h){
  holeL = 47.14/2; //distance between hole centres
  holeR = 5.21/2;
  translate(v=[holeL,holeL,0]) cylinder(r = holeR, h = h, center=true);
  translate(v=[-holeL,holeL,0]) cylinder(r = holeR, h = h, center=true);
  translate(v=[-holeL,-holeL,0]) cylinder(r = holeR, h = h, center=true);
  translate(v=[holeL,-holeL,0]) cylinder(r = holeR, h = h, center=true);
}

module sdfasfd(){
    union(){
	translate(v=[0,0,outer_d/2+wall_padding]) torus(tubing_r, torus_r);
       translate(v=[0,0,outer_d/2+wall_padding]) cylinder(r = tubing_r, h = outer_d, center=true, $fn = fn);  // center hollow
       translate(v=[tubing_r, 25, outer_d/2+wall_padding])   rotate([90,0,0]) cylinder(r = outer_d/2, h =50, center=true, $fn = fn);  // exit liquid tube
	translate(v=[-tubing_r, 25, outer_d/2+wall_padding])   rotate([90,0,0]) cylinder(r = outer_d/2, h =50, center=true, $fn = fn);  // exit liquid tube
      	translate(v=[0,0,-5.5]) cylinder(r=shaftR*1.1, h=50, center=true, $fn = fn);  // center axle
      	translate(v=[0,0,-2.5]) cylinder(r=11, h=10, center=true, $fn = fn);  // center
      	translate(v=[holeL,holeL,0-bodyL/2]) cylinder(r = holeR, h = bodyL+10, center=true, $fn = fn);  // bolts
      	translate(v=[-holeL,holeL,0-bodyL/2]) cylinder(r = holeR, h = bodyL+10, center=true, $fn = fn);  // bolts
      	translate(v=[-holeL,-holeL,0-bodyL/2]) cylinder(r = holeR, h = bodyL+10, center=true, $fn = fn);  // bolts
      	translate(v=[holeL,-holeL,0-bodyL/2]) cylinder(r = holeR, h = bodyL+10, center=true, $fn = fn);  // bolts
    };
}


module torus(radius, pipe_radius, vertical_offset){
  rotate_extrude(convexity = 10, $fn = fn) translate([radius, 0, 0]) circle(r = pipe_radius); 
}

tubing_r = 30; 
pump_body(5, 7, 9, tubing_r);
