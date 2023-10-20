# Copyright 2017-2023 NXP
#
# SPDX-License-Identifier: BSD-3-Clause



optee_client:
	@[ $(DESTARCH) != arm64 -o $(DISTROVARIANT) = tiny -o $(DISTROVARIANT) = base ] && exit || \
	 $(call fbprint_b,"optee_client") && \
	 $(call repo-mngr,fetch,optee_client,apps/security) && \
	 if [ ! -d $(RFSDIR)/usr/lib ]; then \
	     bld rfs -r $(DISTROTYPE):$(DISTROVARIANT) -a $(DESTARCH) -f $(CFGLISTYML); \
	 fi && \
	 export CC="$(CROSS_COMPILE)gcc --sysroot=$(RFSDIR)" && \
	 export LDFLAGS="-L$(RFSDIR)/usr/lib -L$(RFSDIR)/usr/lib/aarch64-linux-gnu" && \
	 export PKG_CONFIG=pkg-config && \
	 \
	 cd $(SECDIR)/optee_client && \
	 $(MAKE) ARCH=arm64 CFLAGS="-I$(RFSDIR)/usr/include/uuid" && \
	 $(call fbprint_d,"optee_client")
