class Candy < Formula
  desc "A easy-to-deploy and peer-to-peer virtual private network"
  homepage "https://github.com/lanthora/candy"
  url "https://github.com/lanthora/candy/archive/v3.2.tar.gz"
  sha256 "a2454ca17bb42f697203e944a77eac348b5b339f4f3d33923858c0bc4a59c51d"
  license "MIT"
  head "https://github.com/lanthora/candy.git"

  depends_on "cmake" => :build
  depends_on "argp-standalone" => :build
  depends_on "uriparser" => :build
  depends_on "pkg-config" => :build
  depends_on "libconfig"
  depends_on "openssl"
  depends_on "spdlog"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    etc.install "candy.conf"
  end

  service do
    run [opt_bin/"candy", "-c", etc/"candy.conf"]
    keep_alive true
    require_root true
    error_log_path var/"log/candy.log"
    log_path var/"log/candy.log"
  end

end
