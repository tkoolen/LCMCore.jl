module lcmtesttypes

export lcm_test_type_1, lcm_test_type_2, lcm_test_type_3
export hard_coded_example

using LCMCore, StaticArrays

mutable struct lcm_test_type_1 <: LCMType
    a::Int16
    blength::Int32
    b::Vector{Int64}
    c::SVector{3, Int32}
end

@lcmtypesetup(lcm_test_type_1,
    (b, 1) => blength
)

function Base.:(==)(x::lcm_test_type_1, y::lcm_test_type_1)
    x.a == y.a || return false
    x.blength == y.blength || return false
    x.b == y.b || return false
    x.c == y.c || return false
    true
end

function Base.rand(::Type{lcm_test_type_1})
    blength = rand(Int32(0) : Int32(10))
    lcm_test_type_1(rand(Int16), blength, rand(Int64, blength), rand(SVector{3, Int32}))
end

function hard_coded_example(::Type{lcm_test_type_1})
    ret = lcm_test_type_1()
    ret.a = 1
    ret.blength = 4
    ret.b = [4, 5, -6, 7]
    ret.c = [10, -1, 5]
    ret
end

mutable struct lcm_test_type_2 <: LCMType
    dlength::Int32
    f_inner_length::Int32
    a::Bool
    b::UInt8
    c::lcm_test_type_1
    d::Vector{lcm_test_type_1}
    e::SVector{3, lcm_test_type_1}
    f::SVector{3, Vector{Int64}}
end

@lcmtypesetup(lcm_test_type_2,
    (d, 1) => dlength,
    (f, 2) => f_inner_length
)

function Base.:(==)(x::lcm_test_type_2, y::lcm_test_type_2)
    x.dlength == y.dlength || return false
    x.f_inner_length == y.f_inner_length || return false
    x.a == y.a || return false
    x.b == y.b || return false
    x.c == y.c || return false
    x.d == y.d || return false
    x.e == y.e || return false
    x.f == y.f || return false
    true
end

function Base.rand(::Type{lcm_test_type_2})
    dlength = rand(Int32(0) : Int32(10))
    f_inner_length = rand(Int32(0) : Int32(10))
    a = rand(Bool)
    b = rand(UInt8)
    c = rand(lcm_test_type_1)
    d = [rand(lcm_test_type_1) for i = 1 : dlength]
    e = SVector{3}([rand(lcm_test_type_1) for i = 1 : 3])
    f = SVector{3}([rand(Int64, f_inner_length) for i = 1 : 3])
    lcm_test_type_2(dlength, f_inner_length, a, b, c, d, e, f)
end

function hard_coded_example(::Type{lcm_test_type_2})
    ret = lcm_test_type_2()
    ret.dlength = 2
    ret.f_inner_length = 2
    ret.a = false
    ret.b = 6
    ret.c = hard_coded_example(lcm_test_type_1)
    ret.d = [hard_coded_example(lcm_test_type_1), hard_coded_example(lcm_test_type_1)]
    ret.d[1].a = 2
    ret.e = [hard_coded_example(lcm_test_type_1), hard_coded_example(lcm_test_type_1), hard_coded_example(lcm_test_type_1)]
    ret.e[3].c = [5, 3, 8]
    ret.f = [[1, 2], [3, 4], [5, 7]]
    ret
end

mutable struct lcm_test_type_3 <: LCMType
    a::String
    blength::Int32
    b::Vector{String}
    c::SVector{2, String}
    d::Float64
end

@lcmtypesetup(lcm_test_type_3,
    (b, 1) => blength
)

function Base.:(==)(x::lcm_test_type_3, y::lcm_test_type_3)
    x.a == y.a || return false
    x.blength == y.blength || return false
    x.b == y.b || return false
    x.c == y.c || return false
    x.d == y.d || return false
    true
end

function Base.rand(::Type{lcm_test_type_3})
    a = randstring()
    blength = rand(Int32(0) : Int32(10))
    b = [randstring() for i = 1 : blength]
    c = SVector{2}([randstring() for i = 1 : 2])
    d = rand()
    lcm_test_type_3(a, blength, b, c, d)
end

function hard_coded_example(::Type{lcm_test_type_3})
    ret = lcm_test_type_3()
    ret.a = "abcd"
    ret.blength = 3
    ret.b = ["x*4f", "4^G32", "4"]
    ret.c = ["xyz", "wxy"]
    ret.d = 2.5
    ret
end

end # module