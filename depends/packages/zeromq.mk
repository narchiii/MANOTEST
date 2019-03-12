package=zeromq
$(package)_version=4.3.1
$(package)_download_path=https://github.com/zeromq/libzmq/archive/
$(package)_file_name=v$($(package)_version).tar.gz
$(package)_sha256_hash=e1dec061725b55d791e0c6952b8c220846c8cd901c09d1283a6e902898205b9d
$(package)_patches=0001-fix-build-with-older-mingw64.patch

define $(package)_set_vars
  $(package)_config_opts=--without-docs --disable-shared --without-libsodium --disable-curve --disable-curve-keygen --disable-perf
  $(package)_config_opts_linux=--with-pic
  $(package)_cxxflags=-std=c++11
endef

define $(package)_preprocess_cmds
   patch -p1 < $($(package)_patch_dir)/0001-fix-build-with-older-mingw64.patch && \
  ./autogen.sh
endef

define $(package)_config_cmds
  $($(package)_autoconf)
endef

define $(package)_build_cmds
  $(MAKE) src/libzmq.la
endef

define $(package)_stage_cmds
  $(MAKE) DESTDIR=$($(package)_staging_dir) install-libLTLIBRARIES install-includeHEADERS install-pkgconfigDATA
endef

define $(package)_postprocess_cmds
  sed -i.old "s/ -lstdc++//" lib/pkgconfig/libzmq.pc && \
  rm -rf bin share
endef