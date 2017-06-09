$fn=50;

module brushCrossSection(radius, count) 
{
union() {
    circle(r=radius, center=true);
    
    for(i=[0:360./count:360]) {
        rotate([0,0,i])
        polygon(points=[ [radius/4.,0], [0,radius+10], [-radius/4.,0] ]);
    }
}
}

linear_extrude(height=100, twist=90)
brushCrossSection(radius=20, count=6);

module spherical_extrude(radius, angle, twist) 
{
    angle_steps = [ for( i =[0:angle/$fn:angle] ) i];
    twist_steps = [ for( i =[0:twist/$fn:twist] ) i];
    for(i = [1:$fn-1]) {
    hull() {        
        rotate([angle_steps[i-1],0,twist_steps[i-1]])
        translate([0,radius,0])
        linear_extrude(height=1)
        children();
        
        rotate([angle_steps[i],0,twist_steps[i]])
        translate([0,radius,0])
        linear_extrude(height=1)
        children();
        
    }
    }
}

module brushBulbEnd(radius, count)
{
union() {
    sphere(r=radius, center=true);
    
    for(i=[0:360./count:360]) {
        rotate([0,0,i])
        spherical_extrude(0, -60, 30)
        polygon(points=[ [radius/4.,0], [0,radius+10], [-radius/4.,0] ]);
    }
}
}

brushBulbEnd(radius=20, count=6);