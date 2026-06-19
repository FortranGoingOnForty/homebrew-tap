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
    url "https://github.com/FortranGoingOnForty/fgof-temp/archive/refs/tags/v0.1.0.tar.gz"
    sha256 "d46446c1dfaac7aa19bb400404e6d127d94e3c04236bb2bcc6f69e1526e8f23a"
  end

  resource "fgof-pty" do
    url "https://github.com/FortranGoingOnForty/fgof-pty/archive/refs/tags/v0.1.0.tar.gz"
    sha256 "3f64569c3bffd18a21541643ac94953d27f1575a71faba1783b54881833cc28e"
  end

  resource "fgof-screen" do
    url "https://github.com/FortranGoingOnForty/fgof-screen/archive/refs/tags/v0.1.0.tar.gz"
    sha256 "b8deda84fa20276d46c178333ce09d0b66dab8f9a95dfdd041ed70787753772f"
  end

  resource "fgof-termios" do
    url "https://github.com/FortranGoingOnForty/fgof-termios/archive/refs/tags/v0.1.0.tar.gz"
    sha256 "e0d320966362ef8401730de7ca015f9d4a17435d925a546168c36eb928b6263a"
  end

  resource "fgof-keys" do
    url "https://github.com/FortranGoingOnForty/fgof-keys/archive/refs/tags/v0.1.0.tar.gz"
    sha256 "880c6c0e7ba960a843c34f7b6970ff50e336d6d59b9784c618867a4200f0ed9e"
  end

  resource "fgof-lineedit" do
    url "https://github.com/FortranGoingOnForty/fgof-lineedit/archive/refs/tags/v0.1.0.tar.gz"
    sha256 "45762edbe32ae58ba272b1b182b8a15e4eb691917ec383fc22759fded2bf3100"
  end

  resource "fgof-fs" do
    url "https://github.com/FortranGoingOnForty/fgof-fs/archive/refs/tags/v0.1.0.tar.gz"
    sha256 "80e2ab563c2a4915fbcd5632942195a88b4cfa0814f6db2bcb25b0acadedb668"
  end

  resource "fgof-process" do
    url "https://github.com/FortranGoingOnForty/fgof-process/archive/refs/tags/v0.1.1.tar.gz"
    sha256 "f0f1ae8075fa109350cf227aeeb5df90d7eef5ec6100827b74aae5dc0557c296"
  end

  resource "fgof-watch" do
    url "https://github.com/FortranGoingOnForty/fgof-watch/archive/refs/tags/v0.1.0.tar.gz"
    sha256 "2d1ec7cd7bfe5ff3f73f957fa1a87c4e2832053f97526ff821e4df6adc7720b2"
  end

  resource "fgof-state" do
    url "https://github.com/FortranGoingOnForty/fgof-state/archive/refs/tags/v0.1.0.tar.gz"
    sha256 "eb3cf32ceb1682c208f67196e5b44088d1d72f8358f0f6a50eeb41b3cb3aa81e"
  end

  resource "fgof-cache" do
    url "https://github.com/FortranGoingOnForty/fgof-cache/archive/refs/tags/v0.1.0.tar.gz"
    sha256 "41d92c1c89a04bc785f2a6397f583c7491976d76e56677634afefdf649c5458e"
  end

  resource "fgof-expect" do
    url "https://github.com/FortranGoingOnForty/fgof-expect/archive/refs/tags/v0.1.0.tar.gz"
    sha256 "059e5ac22c612cf76735c3c9d09c813f600a43b2abfd042d3bfe571197028cad"
  end

  resource "fgof-toml" do
    url "https://github.com/FortranGoingOnForty/fgof-toml/archive/refs/tags/v0.1.0.tar.gz"
    sha256 "ddb744627c74cf72dc6fb0b543590882aadf51bd57a566400f91e04329b4c944"
  end

  def install
    fgof_root = buildpath/"_fgof"
    fgof_root.mkpath

    resources.each do |r|
      r.stage do
        (fgof_root/r.name).install Pathname.pwd.children
      end
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
