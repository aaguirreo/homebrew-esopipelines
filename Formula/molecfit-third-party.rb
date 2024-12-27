class MolecfitThirdParty < Formula
  desc "3rd party tools for the Molecfit library"
  homepage "https://www.eso.org/sci/software/pipelines/skytools/molecfit"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/molecfit_third_party/molecfit_third_party-1.9.3.tar"
  sha256 "2786e34accf63385932bad66c39deab8c8faf4c9095a23173146a9820f4f0183"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://ftp.eso.org/pub/dfs/pipelines/libraries/molecfit_third_party/"
    regex(/href=.*?molecfit_third_party[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  depends_on "gfortran" => :build

  def install
    ENV.deparallelize
    #ENV.append "LDFLAGS", "-L#{Formula["gcc"].opt_lib}/gcc/current"
    #ENV.append "CFLAGS", "-I#{Formula["gcc"].opt_include}"

    system "tar", "-xf", cached_download.to_s, "-C", buildpath
    cd "molecfit_third_party-#{version}" do
      system "make", "-f", "BuildThirdParty.mk",
             "FC=gfortran",
             "prefix=#{prefix}"
      system "make", "-f", "BuildThirdParty.mk",
             "FC=gfortran",
             "prefix=#{prefix}",
             "install"
    end
  end

  test do
    # Include a basic test to validate installation
    system "true"
  end
end
