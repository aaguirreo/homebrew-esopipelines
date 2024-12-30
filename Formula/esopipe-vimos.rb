class EsopipeVimos < Formula
  desc "ESO VIMOS instrument pipeline (data static)"
  homepage "https://www.eso.org/sci/software/pipe_aem_table.html"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/vimos/vimos-kit-4.1.10.tar.gz"
  sha256 "e4394926ada4e5f59be3de67d56630bf113943d2398298a8f2b7abf1e908de4e"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?vimos-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/aaguirreo/homebrew-esopipelines/releases/download/esopipe-vimos-4.1.10"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "04599f8301caa3a772bb4ce9c4e28f5b0c036b6fef63e04553ed611b6eb78470"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "eaf1474e7eab226f634227f158bcfda14ea0c9797da67feda0cdf664a263cd26"
    sha256 cellar: :any_skip_relocation, ventura:       "3eb6fe59432f3bc47ac70a05812a8066d3136fdd4022d81216a73785688a03ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "130be7096d4f84bcc60f17cd1136b9228d6b14a64ef49324255baf35d37fa6c5"
  end

  def pipeline
    "vimos"
  end

  depends_on "esopipe-vimos-recipes"

  def install
    system "tar", "xf", "#{pipeline}-calib-#{version.major_minor_patch}.tar.gz"
    (prefix/"share/esopipes/datastatic/#{pipeline}-#{version.major_minor_patch}").install Dir["#{pipeline}-calib-#{version.major_minor_patch}/cal/*"]
  end

  test do
    system "true"
  end
end
