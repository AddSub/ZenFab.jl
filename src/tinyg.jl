module TinyG

using JSON,
      SerialPorts

const versions = Dict("master" => "440.18",
                      "edge" => "442.04")

abstract AbstractTinyGDevice

immutable TinyGDevice{T} <: AbstractTinyGDevice
    port::T
end


function init(s::TinyGDevice)

end

@doc """
Download the latest release versions of TinyG firmware. This will get all
available branches, currently "master" and "edge".
"""
function download_firmware()
    for k in keys(versions)
        download_firmware(k)
    end
end

@doc """
Download the latest release versions for either 'master' or 'edge'.
"""
function download_firmware(v::String)
    m = Pkg.dir("TinyG","deps","firmware",v)
    if !isdir(m)
        mkpath(m)
    end
    hex = "tinyg-$v-$(versions[v]).hex"
    url = "http://synthetos.github.io/binaries/$hex"
    download(url, joinpath(m,hex))
end

end # module
