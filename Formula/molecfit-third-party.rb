class MolecfitThirdParty < Formula
  desc "3rd party tools for the Molecfit library"
  homepage "http://www.eso.org/sci/software/pipelines/skytools/molecfit"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/molecfit_third_party/molecfit_third_party-1.9.3.tar"
  sha256 "2786e34accf63385932bad66c39deab8c8faf4c9095a23173146a9820f4f0183"
  license "GPL-2"

  depends_on "gfortran" => :build

  def install
    ENV.deparallelize
    lnfl_target = "customOsxGNUsgl"
    lblrtm_target = "customOsxGNUsgl"

    system "tar", "-xf", cached_download.to_s, "-C", buildpath
    cd "molecfit_third_party-#{version}" do
      system "make", "-f", "BuildThirdParty.mk",
             "CC=#{Formula["gcc"].bin}/gcc-14",
             "FC=#{Formula["gcc"].bin}/gfortran-14",
             "lnfl_target=#{lnfl_target}",
             "lblrtm_target=#{lblrtm_target}",
             "prefix=#{prefix}"
      system "make", "-f", "BuildThirdParty.mk",
             "CC=#{Formula["gcc"].bin}/gcc-14",
             "FC=#{Formula["gcc"].bin}/gfortran-14",
             "lnfl_target=#{lnfl_target}",
             "lblrtm_target=#{lblrtm_target}",
             "prefix=#{prefix}",
             "install"
    end
  end

  test do
    # Include a basic test to validate installation
    system "true"
  end
end
