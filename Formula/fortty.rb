class Fortty < Formula
  desc "GPU-accelerated terminal emulator written in Fortran"
  homepage "https://github.com/FortranGoingOnForty/fortty"
  url "https://github.com/FortranGoingOnForty/fortty/archive/refs/tags/v0.1.7.tar.gz"
  sha256 "9be7b27cb4df3a70a98bc6e4a75ed7e2c8afc96b28d75e4d3fd0ff43452cdc95"
  license "MIT"
  head "https://github.com/FortranGoingOnForty/fortty.git", branch: "trunk"

  depends_on "cmake" => :build
  depends_on "gcc" # for gfortran
  depends_on "freetype"
  depends_on "glfw"
  depends_on "fontconfig"

  def install
    system "cmake", "-B", "build", "-DCMAKE_BUILD_TYPE=Release", *std_cmake_args
    system "cmake", "--build", "build"
    bin.install "build/fortty"
  end

  test do
    assert_predicate bin/"fortty", :executable?
  end
end
