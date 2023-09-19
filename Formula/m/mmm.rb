class Mmm < Formula
  desc "Advanced mechanical simulation library based on MFront and MFEM"
  homepage "https://thelfer.github.io/mfem-mgis/web/"
  url "https://github.com/thelfer/mfem-mgis"
  version "1.0.0"
  sha256 "4dec5f10d42ec8413f2c8286b9c06fc0a370cc31f3044e1c08622c11aaa611b6"
  license "LGPL-3.0-only"
  head "https://github.com/thelfer/mfem-mgis.git", branch: "mw_homebrew_package_manager"

  depends_on "cmake" => :build
  depends_on "mfem"
  depends_on "mgis"
  depends_on "tfel"

  fails_with :clang # no OpenMP support

  def install
    args = [
      "-Denable-website=OFF",
      "-Denable-portable-build=ON",
      # "-DMFrontGenericInterface_DIR=/usr/local/opt/mgis/share/mgis/cmake",
      # "-DMFEM_DIR=/usr/local/opt/mfem/lib/cmake/mfem",
      # "-DMFEM_INSTALL_DIR=/usr/local/opt/mfem",
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
