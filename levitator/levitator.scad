
magnet_h=10;
magnet_d=10;

screw=3; // M3 screw
screw_plastic=2.2; // plastic hole dia
screw_plastic_inside=screw_plastic*0.8; // tight
screw_plastic_loose=screw_plastic*1.2;
screw_plastic_head=screw_plastic*2;
screw_plastic_head_transition=1; // cone for easier printing
screw_plastic_under=2; // not counting transition

clr_magnet_d=0.5; // diameter clearance
clr_screw_hole=0.5; // hole bit bigger
clr_screw_step=1; // screw spacing clearance

tube_wall=1.5; // wall thickness
tube_len=150; // tube length


screw_step=magnet_h+screw+clr_screw_step;

// screw_step=2*screw;

cylinder_faces=32;

holder_depth=15;
holder_width=50;
holder_height=20;
magnet_step=5;
magnet_height=10;
holder_clearance=0.5;

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
          rotate([0,0,90])
          cylinder(d=screw+clr_screw_hole,h=outer_d*2,$fn=6,center=true);
        
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
          cylinder(d=screw_plastic_inside+clr_screw_hole,h=cube_h*2,center=true);
    // hole for threaded rod
    rotate([90,0,0])
      rotate([0,0,90])
      cylinder(d=screw+clr_screw_hole,h=cube_h*2,$fn=6,center=true);
  }
}

module magnet_holder(upper=0,lower=1)
{
  difference()
  {
    cube([holder_width,holder_depth,holder_height],center=true);
    // cut slit between
    translate([0,0,-holder_height/2+magnet_height])
      cube([
            holder_width+0.01,
            holder_depth+0.01,
            holder_clearance],
      center=true);
    // no upper side
    if(upper<0.5)
      translate([0,0,-holder_height/2+magnet_height+holder_height/2])
      cube([
            holder_width+0.01,
            holder_depth+0.01,
            holder_height],
      center=true);
    // no lower side
    if(lower<0.5)
      translate([0,0,-holder_height/2+magnet_height-holder_height/2])
      cube([
            holder_width+0.01,
            holder_depth+0.01,
            holder_height],
      center=true);
    // magnet placeholders
    steps=floor(holder_width/magnet_step/2)*2-4;
    // adjustment holes
    for(i=[-steps/2:steps/2])
        if(i < -0.5 || i > 0.5)
    translate([i*magnet_step,0,-holder_height/2+magnet_height])
        rotate([90,0,0])
          cylinder(d=magnet_d,h=magnet_h,center=true);
    // rod hole
    // hole for threaded rod
    translate([0,0,-holder_height/2+magnet_height/2])
    rotate([90,0,0])
      rotate([0,0,90])
      cylinder(d=screw+clr_screw_hole,h=holder_depth+0.01,$fn=6,center=true);
    // screw plastic thread hole thru all
    translate([holder_width/2-magnet_step/2,0,0])
        cylinder(d=screw_plastic_inside,h=holder_height+0.1,center=true);
    // screw head
    translate([holder_width/2-magnet_step/2,0,-holder_height/1+magnet_height-screw_plastic_under])
        cylinder(d=screw_plastic_head,h=holder_height+0.1,$fn=16,center=true);
    // screw pass thru hole
    translate([holder_width/2-magnet_step/2,0,-holder_height/2+magnet_height-screw_plastic_under/2])
        cylinder(d=screw_plastic_loose,h=screw_plastic_under+0.1,$fn=16,center=true);
    // conical transition

  }
}

if(0)
translate([0,0,15])
rotate([90,0,0])
magnet_tube();

//magnet_tube();
//side_holder();
magnet_holder();
