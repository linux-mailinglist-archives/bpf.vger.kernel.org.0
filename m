Return-Path: <bpf+bounces-12355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1517CB6F6
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 01:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7602CB2107E
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 23:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6C438FB2;
	Mon, 16 Oct 2023 23:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hyjkJUD3"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA65927EE0;
	Mon, 16 Oct 2023 23:21:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB619B;
	Mon, 16 Oct 2023 16:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697498516; x=1729034516;
  h=date:from:to:cc:subject:message-id;
  bh=OtQxmjoALgHa+s4AdJcPcEmcaL6nwt6LfGkkUOQIHZU=;
  b=hyjkJUD3rV10o62EJMZLVD2tjqEHvbdenyF+54dCrMUR86xedf75AAQ9
   TQdWIhSKzR+A0+mwNTdSV21TGQ9jn5f1gaLje1jW/mKSF+4bhrLNm12Ol
   NpktznhWJ6HiHuwQ708l9g0VdsPOE9iH4V4AI98p31Q2vgUkDphm0EZHe
   lJUy45UM4JY387jYHRFSdTkoyz0Ei2iZsyellVmOhr+OeabJF8LLJkCvO
   zEsSLtKs13OVbhZoOCKVpAVpQW7trgScgbI8frbotfpBXr4rNIdgq5Nen
   z8T6fPUt9uIPFhbZ4+0uAjTI3ydIUkbpUzGK++eL4b9XxAVbXCceeoo67
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="452139630"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="452139630"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 16:21:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="705779117"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="705779117"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Oct 2023 16:21:54 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qsWuF-0008kY-1v;
	Mon, 16 Oct 2023 23:21:51 +0000
Date: Tue, 17 Oct 2023 07:21:20 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, bpf@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 4d0515b235dec789578d135a5db586b25c5870cb
Message-ID: <202310170705.YN3XVbWR-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 4d0515b235dec789578d135a5db586b25c5870cb  Add linux-next specific files for 20231016

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202309212121.cul1pTRa-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202309212339.hxhBu2F1-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310051547.40nm4Sif-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310160401.RIcVn63P-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310161945.VDy8ESWa-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310170132.IrOpHglA-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310170340.tkkfdZYn-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310170627.2Kvf6ZHY-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

(.text+0x11c): undefined reference to `devm_hwrng_register'
drivers/crypto/qcom-rng.c:213:(.text+0x16c): undefined reference to `devm_hwrng_register'
drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c:274: warning: Function parameter or member 'gart_placement' not described in 'amdgpu_gmc_gart_location'
drivers/net/ethernet/apm/xgene/xgene_enet_main.c:2004:34: warning: unused variable 'xgene_enet_of_match' [-Wunused-const-variable]
idpf_txrx.c:(.text+0x2dbc): undefined reference to `tcp_gro_complete'
include/linux/bitmap.h:527:25: error: 'EBUSY' undeclared (first use in this function)
include/linux/bitmap.h:554:17: error: 'ENOMEM' undeclared (first use in this function)
kernel/bpf/helpers.c:1909:19: warning: no previous declaration for 'bpf_percpu_obj_new_impl' [-Wmissing-declarations]
kernel/bpf/helpers.c:1945:18: warning: no previous declaration for 'bpf_percpu_obj_drop_impl' [-Wmissing-declarations]
kernel/bpf/helpers.c:2480:18: warning: no previous declaration for 'bpf_throw' [-Wmissing-declarations]
qcom-rng.c:(.text+0x224): undefined reference to `devm_hwrng_register'

Unverified Error/Warning (likely false positive, please contact us if interested):

Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml:

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- arc-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- arc-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- arm-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- arm-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- arm-buildonly-randconfig-r006-20220608
|   `-- drivers-crypto-qcom-rng.c:(.text):undefined-reference-to-devm_hwrng_register
|-- arm-randconfig-s032-20220424
|   |-- include-linux-bitmap.h:error:EBUSY-undeclared-(first-use-in-this-function)
|   `-- include-linux-bitmap.h:error:ENOMEM-undeclared-(first-use-in-this-function)
|-- arm64-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- arm64-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- arm64-randconfig-001-20231016
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|   `-- idpf_txrx.c:(.text):undefined-reference-to-tcp_gro_complete
|-- arm64-randconfig-002-20231016
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- arm64-randconfig-r015-20220507
|   `-- qcom-rng.c:(.text):undefined-reference-to-devm_hwrng_register
|-- csky-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- csky-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- i386-randconfig-005-20231016
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- i386-randconfig-006-20231016
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|   |-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_percpu_obj_drop_impl
|   |-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_percpu_obj_new_impl
|   `-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_throw
|-- loongarch-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- loongarch-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- loongarch-defconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- loongarch-randconfig-001-20231016
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- loongarch-randconfig-001-20231017
|   `-- Documentation-devicetree-bindings-mfd-qcom-pm8xxx.yaml:
|-- loongarch-randconfig-002-20231016
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- microblaze-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- microblaze-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- mips-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- mips-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- openrisc-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- openrisc-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- parisc-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- parisc-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- parisc-randconfig-001-20231016
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- parisc-randconfig-r001-20221214
|   `-- (.text):undefined-reference-to-devm_hwrng_register
|-- powerpc-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- powerpc-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- powerpc-randconfig-001-20231016
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- powerpc64-randconfig-002-20231016
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- powerpc64-randconfig-003-20231016
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- riscv-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- riscv-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- riscv-randconfig-002-20231016
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- s390-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- s390-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- s390-randconfig-002-20231016
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- sparc-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- sparc-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- sparc64-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- sparc64-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
`-- x86_64-allyesconfig
    `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
clang_recent_errors
`-- hexagon-randconfig-r005-20221019
    `-- drivers-net-ethernet-apm-xgene-xgene_enet_main.c:warning:unused-variable-xgene_enet_of_match

elapsed time: 1065m

configs tested: 105
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231016   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231016   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231016   gcc  
i386                  randconfig-002-20231016   gcc  
i386                  randconfig-003-20231016   gcc  
i386                  randconfig-004-20231016   gcc  
i386                  randconfig-005-20231016   gcc  
i386                  randconfig-006-20231016   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231016   gcc  
loongarch             randconfig-001-20231017   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231016   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231016   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231016   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231016   gcc  
x86_64                randconfig-002-20231016   gcc  
x86_64                randconfig-003-20231016   gcc  
x86_64                randconfig-004-20231016   gcc  
x86_64                randconfig-005-20231016   gcc  
x86_64                randconfig-006-20231016   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

