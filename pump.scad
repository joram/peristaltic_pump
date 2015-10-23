

use <nema17.scad>;
use<m8_bearing.scad>;
use<arm.scad>;
use<body.scad>;
fn = 30;

inner_d = 7;
outer_d = 9;
arm_radius = 34;
tubing_r = 45; 
arm_thickness = 5;
nut_thickness = 5;
top_padding = arm_thickness + nut_thickness;
arm_mount_radius = 7;


pump_arm_top(arm_thickness, inner_d, outer_d, arm_radius, arm_mount_radius, top_padding);
pump_arm_bottom(arm_thickness, inner_d, outer_d, arm_radius, arm_mount_radius, top_padding);

// bottom
//difference(){
//  pump_body(2, inner_d, outer_d, tubing_r, arm_radius, arm_mount_radius, top_padding);
//  translate([0, 0, 100]) cube(size = [200, 200, 200], center=true);
//}

// top
// rotate([0,180,0]) translate([0,150,0])  difference(){
//   pump_body(2, inner_d, outer_d, tubing_r, arm_radius, arm_mount_radius, top_padding);
//   translate([0, 0, -100]) cube(size = [200, 200, 200], center=true);
// }