
magnet_h=10;
magnet_d=10;

screw=3; // M3 screw

clr_magnet_d=0.5; // diameter clearance
clr_screw_hole=0.5; // hole bit bigger
clr_screw_step=1; // screw spacing clearance

tube_wall=1; // wall thickness
tube_len=80; // tube length


//screw_step=magnet_h+screw+clr_screw_step;

screw_step=2*screw;

cylinder_faces=32;

holder_thick=10;

module magnet_tube()
{
  inner_d=magnet_d+clr_magnet_d;
  outer_d=inner_d+tube_wall;
  steps=floor(tube_len/screw_step/2)*2;
  difference()
  {
    cylinder(d=outer_d,h=tube_len,$fn=cylinder_faces,center=true);
    // tube = inside empty
    cylinder(d=inner_d,h=tube_len+0.01,$fn=cylinder_faces,center=true);
    // adjustment holes
    for(i=[-2*steps:2*steps])
      translate([0,0,i*screw_step])
        rotate([90,0,0])
          cylinder(d=screw+clr_screw_hole,h=outer_d*2,center=true);
        
  }
}

module side_holder()
{
  cube_len=54;
  cube_h=15;
  steps=floor(cube_len/screw_step/2)*2;
  difference()
  {
    cube([cube_len,cube_h,cube_h],center=true);
    // adjustment holes
    for(i=[-2*steps:2*steps])
    translate([i*screw_step,0,0])
        rotate([0,0,0])
          cylinder(d=screw+clr_screw_hole,h=cube_h*2,center=true);
    // hole for threaded rod
    rotate([90,0,0])
      cylinder(d=screw+clr_screw_hole,h=cube_h*2,center=true);
  }
}


translate([0,0,15])
rotate([90,0,0])
magnet_tube();

side_holder();