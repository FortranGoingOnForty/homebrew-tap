class Ferp < Formula
  desc "A GNU grep clone written in Fortran"
  homepage "https://github.com/FortranGoingOnForty/ferp"
  url "https://github.com/FortranGoingOnForty/ferp/archive/refs/tags/v0.10.1.tar.gz"
  sha256 "69dd4dbb31c234aab9f33f2731099d62eddba3a15343c03e7ecc2ee748e27d6f"
  head "https://github.com/FortranGoingOnForty/ferp.git", branch: "trunk"

  # No llvm: the C sources build fine with the clang from the Command Line
  # Tools, which Homebrew already requires. ferp's macOS CI builds with only
  # gcc and pcre2 installed.
  depends_on "gcc" => :build
  depends_on "pcre2"

  def install
    # The -j1 workaround is no longer needed: the race it avoided (the release
    # target ran clean as an unordered prerequisite, so rm -rf build could land
    # mid-build) is fixed in 0.10.1, and ferp's CI now builds with -j.
    system "make", "release", "FC=gfortran"
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
