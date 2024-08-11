class MfemMgis < Formula
  desc "Advanced mechanical simulation library based on MFront and MFEM"
  homepage "https://thelfer.github.io/mfem-mgis/"
  url "https://github.com/thelfer/mfem-mgis/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "34ee7ee0751672ce195ef9e53d7d75205a19ff71da791faf76afbf67265ee1f6"
  license "LGPL-3.0-only"
  head "https://github.com/thelfer/mfem-mgis.git", using: :git, branch: "master"

  depends_on "cmake" => :build
  depends_on "mfem" => "4.7"
  depends_on "mgis" => "2.2"
  depends_on "tfel" => "4.2"
  fails_with :clang

  def install
    args = [
      "-Denable-website=OFF",
      "-Denable-portable-build=ON",
    ]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    pkgshare.install "tests"
  end

  test do
    cp_r pkgshare/"tests", testpath
    system "make", "-C", testpath/"tests", "all"
    system testpath/"tests/UniaxialTensileTest"
  end
end
