#Collider demo
#2022 Levi D. Smith

class Sphere
	attr_accessor :x
	attr_accessor :y
	attr_accessor :z
	attr_accessor :r
	
	def initialize(in_x, in_y, in_z, in_r)
		@x = in_x
		@y = in_y
		@z = in_z
		@r = in_r
	end
	
	def to_s()
		return "x: #{@x} y: #{@y} z: #{@z} r: #{@r}"
	end
	
end

class Cube
	attr_accessor :x
	attr_accessor :y
	attr_accessor :z
	attr_accessor :w
	attr_accessor :h
	attr_accessor :d
	
	def initialize(in_x, in_y, in_z, in_w, in_h, in_d)
		@x = in_x
		@y = in_y
		@z = in_z
		@w = in_w
		@h = in_h
		@d = in_d
	end
	
	def to_s()
		return "x: #{@x} y: #{@y} z: #{@z} w: #{@w} h: #{@h} d: #{@d}"
	end
end

def sphereCollisionCheck(c1, c2)
	d = ( (c1.x - c2.x) ** 2 +
	      (c1.y - c2.y) ** 2 +
		  (c1.z - c2.z) ** 2
		) ** 0.5
	sum_r = c1.r + c2.r
	puts "Distance: #{'%.2f' % d}"
	puts "Sum of radius: #{sum_r}"
	
	print "Sphere collision: "
	if (d < sum_r)
		puts "YES"
		
	else
		puts "NO"
	
	end

end

def cubeCollisionCheck(r1, r2)

	val1 = r1.x - (r1.w / 2.0)
	val2 = r2.x + (r2.w / 2.0)
	isRight = val1 > val2
	puts "Right: #{val1} > #{val2} : #{isRight}"

	val1 = r1.x + (r1.w / 2.0)
	val2 = r2.x - (r2.w / 2.0)
	isLeft = val1 < val2
	puts "Left: #{val1} < #{val2} : #{isLeft}"

	val1 = r1.y - (r1.h / 2.0)
	val2 = r2.y + (r2.h / 2.0)
	isAbove = val1 > val2
	puts "Above: #{val1} > #{val2} : #{isAbove}"

	val1 = r1.y + (r1.h / 2.0)
	val2 = r2.y - (r2.h / 2.0)
	isBelow = val1 < val2
	puts "Below: #{val1} < #{val2} : #{isBelow}"

	val1 = r1.z - (r1.d / 2.0)
	val2 = r2.z + (r2.d / 2.0)
	isInFront = val1 > val2
	puts "In Front: #{val1} > #{val2} : #{isInFront}"

	val1 = r1.z + (r1.d / 2.0)
	val2 = r2.z - (r2.d / 2.0)
	isBehind = val1 < val2
	puts "Behind: #{val1} < #{val2} : #{isBehind}"

	print "Cube collision: "
	if ( not(isRight) && not(isLeft) && 
	     not(isAbove) && not(isBelow) &&
		 not(isInFront) && not(isBehind))
		puts "YES"
		
	else
		puts "NO"
	
	end


end


def parseInput(in_str)
#	puts "Command line: #{in_str.gsub(/\s/,'')}"

	m = in_str.gsub(/\s/,'').match /(c\(.+\)),(c\(.+\))/
	if not (m.nil?)
		c1 = parseSphere(m[1])
		c2 = parseSphere(m[2])

		puts "c1: #{c1}"
		puts "c2: #{c2}"

		sphereCollisionCheck(c1, c2)

	end

	m = in_str.gsub(/\s/,'').match /(r\(.+\)),(r\(.+\))/
	if not (m.nil?)
		r1 = parseCube(m[1])
		r2 = parseCube(m[2])

		puts "r1: #{r1}"
		puts "r2: #{r2}"

		cubeCollisionCheck(r1, r2)

	end

	
end

def parseSphere(in_str)
	puts "parseSphere: #{in_str}"
	c = nil

	m = in_str.gsub(/\s/,'').match /c\((-?\d+),(-?\d+),(-?\d+),(-?\d+)\)/

	if not (m.nil?)
		c = Sphere.new(m[1].to_i, m[2].to_i, m[3].to_i, m[4].to_i)
	end
	

	m = in_str.gsub(/\s/,'').match /c\(rand\)/

	if not (m.nil?)
		c = Sphere.new(rand(-10..10),
					rand(-10..10),
					rand(-10..10),
					rand(1..10))
	end
	
	if (c.nil?)
		puts "Syntax error"
	end

	
	
	return c
end

def parseCube(in_str) 
	puts "parseCube: #{in_str}"
	r = nil

	m = in_str.gsub(/\s/,'').match /r\((-?\d+),(-?\d+),(-?\d+),(\d+),(\d+),(\d+)\)/

	if not (m.nil?)
		r = Cube.new(m[1].to_i, m[2].to_i, m[3].to_i, m[4].to_i, m[5].to_i, m[6].to_i)
	end

	m = in_str.gsub(/\s/,'').match /r\(rand\)/

	if not (m.nil?)
		r = Cube.new(rand(-10..10),
					rand(-10..10),
					rand(-10..10),
					rand(1..10),
					rand(1..10),
					rand(1..10))
	end

	if (r.nil?)
		puts "Syntax error"
	end

	
	return r

end


def displayUsage() 
	puts 'Usage: '
	puts '  ruby collision3d.rb "c(x,y,z,r),c(x,y,z,r)"'
	puts '  ruby collision3d.rb "c(rand),c(x,y,z,r)'
	puts '  ruby collision3d.rb "c(rand),c(rand)'
	puts '  ruby collision3d.rb "r(x,y,z,w,h,d),r(x,y,z,w,h,d)"'
	puts '  ruby collision3d.rb "r(rand),r(x,y,z,w,h,d)'
	puts '  ruby collision3d.rb "r(rand),r(rand)'

end


def main() 
	puts "Collision 3D demo"
	puts "2022 Levi D. Smith"
	
	if (ARGV.length == 1)
		if (ARGV[0].downcase == "rand")
			generateRandom()
		else
			parseInput(ARGV[0])
		end
	else
		displayUsage()
	end


end

main()