class EsopipeIsaac < Formula
  desc "ESO ISAAC instrument pipeline (static data)"
  homepage "https://www.eso.org/sci/software/pipe_aem_table.html"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/isaac/isaac-kit-6.2.5-1.tar.gz"
  sha256 "bed2508b8a06cf943b93ca6f2078a55c8e8acec33c92dfc5aa297d5e8f1483a5"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://github.com/aaguirreo/homebrew-esopipelines/releases/download/esopipe-isaac-6.2.5-1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "032af9d135dc86a08fc9800a5aac66e68cc223803f86d78a50671925255606f8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b0c0e06dad6341f7df31e6cf84f1b420bf36e878492e3300c9adb7520df38e4c"
    sha256 cellar: :any_skip_relocation, ventura:       "55112db47b5cd0ffd5f058ed861ebc31b9d5bb4e55821754ef6521b26b25aa61"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "eb89898e0f669600455a1804e9f33b04a1df85f30e74e96c8249c8f1983e68fb"
  end

  def pipeline
    "isaac"
  end

  livecheck do
    url :homepage
    regex(/href=.*?isaac-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  depends_on "esopipe-isaac-recipes"

  def install
    system "tar", "xf", "#{pipeline}-calib-#{version.major_minor_patch}.tar.gz"
    (prefix/"share/esopipes/datastatic/#{pipeline}-#{version.major_minor_patch}").install Dir["#{pipeline}-calib-#{version.major_minor_patch}/cal/*"]
  end

  test do
    system "true"
  end
end
