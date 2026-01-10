class Firp < Formula
  desc "A Modern Fortran Interpreter with REPL, debugger, and JIT compilation"
  homepage "https://github.com/FortranGoingOnForty/firp"
  url "https://github.com/FortranGoingOnForty/firp/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "29bdc248a2105f340c921fc0190cb06acb4be839205715f116664a3aec5b84b4"
  license "MIT"
  head "https://github.com/FortranGoingOnForty/firp.git", branch: "trunk"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    # Install documentation
    doc.install "README.md" if File.exist?("README.md")
    doc.install "LICENSE" if File.exist?("LICENSE")

    # Install example programs
    if File.directory?("examples")
      (pkgshare/"examples").install Dir["examples/*.f90"]
    end
  end

  def caveats
    <<~EOS
      FIRP - A Modern Fortran Interpreter

      Interactive REPL:
        firp              # Start interactive mode

      Run a file:
        firp program.f90  # Execute a Fortran program

      Features:
        - Interactive REPL with auto-indentation
        - Built-in debugger (--debug flag)
        - Profiler support (--profile flag)
        - JIT compilation (--jit flag)

      Example programs installed to:
        #{pkgshare}/examples/
    EOS
  end

  test do
    # Test version output
    assert_match "FIRP", shell_output("#{bin}/firp --version 2>&1", 1)

    # Test simple expression evaluation
    (testpath/"test.f90").write <<~EOS
      program test
        print *, 42
      end program test
    EOS
    assert_match "42", shell_output("#{bin}/firp #{testpath}/test.f90")
  end
end
