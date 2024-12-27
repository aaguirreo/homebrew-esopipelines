class EsopipeNaco < Formula
  desc "ESO NACO instrument pipeline (static data)"
  homepage "https://www.eso.org/sci/software/pipe_aem_table.html"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/naco/naco-kit-4.4.13-1.tar.gz"
  sha256 "999ed3bbd574f0821e0c00d8d51e41aff14c9ebf4cea586c642b8da5e048e383"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?naco-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/aaguirreo/homebrew-esopipelines/releases/download/esopipe-naco-4.4.13-1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5f4fb4ee7d55ee2d51858f2955890286eaffc566722b7c2cbb0a358e22b036e1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3f2a6442c267611a2fb6e081ec2d995c49f003f7b77a0efb17416aea966f742c"
    sha256 cellar: :any_skip_relocation, ventura:       "5370b9095f849cea06bbc8d9a7724eb4b87c649dff71b5b4babc3a55de74e7db"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c514e58e9e158d1fa64ec3d3527bd6620703b6d0c713fe9ef93686e11edc05cb"
  end

  def pipeline
    "naco"
  end

  depends_on "esopipe-naco-recipes"

  def install
    system "tar", "xf", "#{pipeline}-calib-#{version.major_minor_patch}.tar.gz"
    (prefix/"share/esopipes/datastatic/#{pipeline}-#{version.major_minor_patch}").install Dir["#{pipeline}-calib-#{version.major_minor_patch}/cal/*"]
  end

  test do
    system "true"
  end
end
