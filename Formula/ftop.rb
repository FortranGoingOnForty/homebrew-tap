class Ftop < Formula
  desc "TUI system monitor in Fortran 2018 with truecolor, braille graphs, and GPU monitoring"
  homepage "https://github.com/FortranGoingOnForty/ftop"
  url "https://github.com/FortranGoingOnForty/ftop/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "79fb4f266a2a9c669c706094457a3b7b9f6d7e2a581a50eb523e41ab3a0aa42c"
  license "MIT"
  head "https://github.com/FortranGoingOnForty/ftop.git", branch: "trunk"

  depends_on "cmake" => :build
  depends_on "gcc" # for gfortran

  resource "fgof-temp" do
    url "https://github.com/FortranGoingOnForty/fgof-temp/archive/refs/tags/v0.2.0.tar.gz"
    sha256 "8c80a194dee6d798aeedcf6f3ab4e591fcb4a986256e43363ef2d81ebd4d39d7"
  end

  resource "fgof-pty" do
    url "https://github.com/FortranGoingOnForty/fgof-pty/archive/refs/tags/v0.2.0.tar.gz"
    sha256 "a060dec59d03886deaf3551fcd06c0b196dfb0871a5781d3aeb866d419603f33"
  end

  resource "fgof-screen" do
    url "https://github.com/FortranGoingOnForty/fgof-screen/archive/refs/tags/v0.2.0.tar.gz"
    sha256 "c77d2722d69b9b175b914b6a8f2fcfc21fba3346f6f782ceb4bec2c8d7c4b0bd"
  end

  resource "fgof-termios" do
    url "https://github.com/FortranGoingOnForty/fgof-termios/archive/refs/tags/v0.2.0.tar.gz"
    sha256 "c55eaa2779bcf1120256cd53965ad909c1608cb2c7ae2e21284a613f8771dc1d"
  end

  resource "fgof-keys" do
    url "https://github.com/FortranGoingOnForty/fgof-keys/archive/refs/tags/v0.2.0.tar.gz"
    sha256 "3abe53ccb797e14f5a96efb25ac73903a61fa9a890d0f9f883ba94ff4e348a31"
  end

  resource "fgof-lineedit" do
    url "https://github.com/FortranGoingOnForty/fgof-lineedit/archive/refs/tags/v0.2.0.tar.gz"
    sha256 "e43093213d5180f07b1918a6d87e388c938169f2cba178db7eaf09be4dd96857"
  end

  resource "fgof-fs" do
    url "https://github.com/FortranGoingOnForty/fgof-fs/archive/refs/tags/v0.2.0.tar.gz"
    sha256 "9755b7a3f4ed0ab1875cc02614d560383d6bd1112dcbbe31c2d2e760f511e693"
  end

  resource "fgof-process" do
    url "https://github.com/FortranGoingOnForty/fgof-process/archive/refs/tags/v0.2.0.tar.gz"
    sha256 "41d60051f33e4ade1d97d1acfeba579e50a7bb16626af97caaea5e053e97812f"
  end

  resource "fgof-watch" do
    url "https://github.com/FortranGoingOnForty/fgof-watch/archive/refs/tags/v0.2.0.tar.gz"
    sha256 "dd19cf7cddfe3a9ab17a81222ff750f3f52cb93f0e6a71f44b4d8b4095e774c4"
  end

  resource "fgof-state" do
    url "https://github.com/FortranGoingOnForty/fgof-state/archive/refs/tags/v0.2.0.tar.gz"
    sha256 "fbfaf3b0f5d324ecb319612a8b09a366d50ab4aa4fd6d1b5d4b3a179f996ad2b"
  end

  resource "fgof-cache" do
    url "https://github.com/FortranGoingOnForty/fgof-cache/archive/refs/tags/v0.2.0.tar.gz"
    sha256 "20e637850f35f5b885e299b424fbbd7ebb248bffb9300f0b367433ac00a9252f"
  end

  resource "fgof-expect" do
    url "https://github.com/FortranGoingOnForty/fgof-expect/archive/refs/tags/v0.2.0.tar.gz"
    sha256 "6becdb60881a2099c91c5cc184f8d3ef6205916bcb92c4328e18be161930cd5b"
  end

  resource "fgof-toml" do
    url "https://github.com/FortranGoingOnForty/fgof-toml/archive/refs/tags/v0.1.0.tar.gz"
    sha256 "ddb744627c74cf72dc6fb0b543590882aadf51bd57a566400f91e04329b4c944"
  end

  def install
    fgof_root = buildpath/"_fgof"
    fgof_root.mkpath

    resources.each do |r|
      r.stage(fgof_root/r.name)
    end

    system "cmake", "-S", ".", "-B", "build",
           "-DCMAKE_BUILD_TYPE=Release",
           "-DFTOP_FGOF_ROOT=#{fgof_root}",
           "-DBUILD_TESTING=OFF",
           *std_cmake_args
    system "cmake", "--build", "build"

    bin.install "build/bin/ftop"
    doc.install "README.md"
  end

  test do
    assert_match "ftop", shell_output("#{bin}/ftop --version 2>&1")
  end
end
