class Ferp < Formula
  desc "A GNU grep clone written in Fortran"
  homepage "https://github.com/FortranGoingOnForty/ferp"
  url "https://github.com/FortranGoingOnForty/ferp/archive/refs/tags/v0.10.0.tar.gz"
  sha256 "039821e46c045f328150cc5f4ad1f79f97a50aaf8007273a7f2030eb033c0653"
  head "https://github.com/FortranGoingOnForty/ferp.git", branch: "trunk"

  # No llvm: the C sources build fine with the clang from the Command Line
  # Tools, which Homebrew already requires. ferp's macOS CI builds with only
  # gcc and pcre2 installed.
  depends_on "gcc" => :build
  depends_on "pcre2"

  def install
    # Use -j1 to avoid race condition: release target runs clean, then parallel jobs
    # start before build directory is recreated
    system "make", "-j1", "release", "FC=gfortran"
    bin.install "ferp"

    # Install documentation
    doc.install "README.md" if File.exist?("README.md")
  end

  test do
    assert_match "hello", pipe_output("#{bin}/ferp hello", "hello world")
    assert_match version.to_s, shell_output("#{bin}/ferp --version")

    # Exercises the directory walk, which reads struct stat and struct dirent
    # and so is the part most likely to break on macOS.
    (testpath/"sub").mkpath
    (testpath/"top.txt").write("needle\n")
    (testpath/"sub/nested.txt").write("needle\n")
    assert_equal 2, shell_output("#{bin}/ferp -r needle #{testpath}").lines.count
  end
end
