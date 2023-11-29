module KomaMRIIO

using KomaMRICore
import KomaMRICore: simulation_output
using Scanf, FileIO, HDF5, MAT, JLD2    # IO related

using Reexport
using MRIFiles
@reexport using MRIFiles: ISMRMRDFile
@reexport using FileIO: save

include("io/Pulseq.jl")
include("io/JEMRIS.jl")
include("io/MRiLab.jl")
include("io/ISMRMRD.jl")

export read_seq                                 # Pulseq
export signal_to_raw_data                       # ISMRMRD
export read_phantom_jemris, read_phantom_MRiLab # Phantom

# Package version: KomaMRIIO.__VERSION__
using Pkg
__VERSION__ = VersionNumber(Pkg.TOML.parsefile(joinpath(@__DIR__, "..", "Project.toml"))["version"])

end # module KomaMRIIO
