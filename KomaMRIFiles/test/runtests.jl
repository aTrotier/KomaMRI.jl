using TestItems, TestItemRunner

@run_package_tests filter=ti->!(:skipci in ti.tags)&&(:files in ti.tags) #verbose=true

@testitem "Files" tags=[:files] begin
    using Suppressor

    # Test Pulseq
    @testset "Pulseq" begin
        path = @__DIR__
        seq = @suppress read_seq(path*"/test_files/epi.seq") #Pulseq v1.4.0, RF arbitrary
        @test seq.DEF["FileName"] == "epi.seq"
        @test seq.DEF["PulseqVersion"] ≈ 1004000
        @test seq.DEF["signature"] == "67ebeffe6afdf0c393834101c14f3990"

        seq = @suppress read_seq(path*"/test_files/spiral.seq") #Pulseq v1.4.0, RF arbitrary
        @test seq.DEF["FileName"] == "spiral.seq"
        @test seq.DEF["PulseqVersion"] ≈ 1004000
        @test seq.DEF["signature"] == "efc5eb7dbaa82aba627a31ff689c8649"

        seq = @suppress read_seq(path*"/test_files/epi_JEMRIS.seq") #Pulseq v1.2.1
        @test seq.DEF["FileName"] == "epi_JEMRIS.seq"
        @test seq.DEF["PulseqVersion"] ≈ 1002001
        @test seq.DEF["signature"] == "f291a24409c3e8de01ddb93e124d9ff2"

        seq = @suppress read_seq(path*"/test_files/radial_JEMRIS.seq") #Pulseq v1.2.1
        @test seq.DEF["FileName"] == "radial_JEMRIS.seq"
        @test seq.DEF["PulseqVersion"] ≈ 1002001
        @test seq.DEF["signature"] == "e827cfff4436b65a6341a4fa0f6deb07"

        # Test Pulseq compression-decompression
        shape = ones(100)
        num_samples, compressed_data = KomaMRIFiles.compress_shape(shape)
        shape2 = KomaMRIFiles.decompress_shape(num_samples, compressed_data)
        @test shape == shape2
    end
    # Test JEMRIS
    @testset "JEMRIS" begin
        path = @__DIR__
        obj = read_phantom_jemris(path*"/test_files/column1d.h5")
        @test obj.name == "column1d.h5"
    end
    # Test JEMRIS
    @testset "MRiLab" begin
        path = @__DIR__
        filename = path * "/test_files/brain_mrilab.mat"
        FRange_filename = path * "/test_files/FRange.mat" #Slab within slice thickness
        obj = read_phantom_MRiLab(filename; FRange_filename)
        @test obj.name == "brain_mrilab.mat"
    end
end
