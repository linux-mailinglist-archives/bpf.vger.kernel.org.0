Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19C65B7D31
	for <lists+bpf@lfdr.de>; Wed, 14 Sep 2022 00:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiIMWsB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Sep 2022 18:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIMWr7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Sep 2022 18:47:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BB552DCA;
        Tue, 13 Sep 2022 15:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663109278; x=1694645278;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7vuGPrjvpnP8JElr2b5KXy1+oZKLBwocK710pEgM2W4=;
  b=acMlU++0f/JvE4f+o/Mc4qinBfmGaQoC8B4JidDyHcAod/UeDgyaExVD
   P6AGeIdDIhSYrt9gkUf44fA4U2uzGfo1Nsl5OqWUlYgVxiS24bY1y9wzZ
   bRgWgBrzXXFYNybz6uvYuAKm/FzD6rBFed2Ro9Sm371vcARvCR6xpxEOt
   6keeBQwTe6XRNAi+S2OcX9dM0HmkIKOMM+00OoZQZxz/4EUBWmTxwS0Ic
   Ee+ia5KKOP9x5Doi9Ll0m2Ijlp83IfvwReRcW/5nlNPglEi83i8FQuUkv
   g91+cRWaUhPXlZ1LGQIiT4rbxJAtV4beXyIhgUcZyMyIcUKuzLhjyqlGF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="278008848"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="278008848"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 15:47:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="678778744"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 13 Sep 2022 15:47:55 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYEh8-00045Z-2P;
        Tue, 13 Sep 2022 22:47:54 +0000
Date:   Wed, 14 Sep 2022 06:47:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-wireless@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-hwmon@vger.kernel.org, dri-devel@lists.freedesktop.org,
        damon@lists.linux.dev, bpf@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 0caac1da994900d12a9be6106edb8e98696712a3
Message-ID: <6321087b.WsDIw5m+1a7xRREp%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 0caac1da994900d12a9be6106edb8e98696712a3  Add linux-next specific files for 20220913

Error/Warning reports:

https://lore.kernel.org/linux-mm/202209042337.FQi69rLV-lkp@intel.com
https://lore.kernel.org/linux-mm/202209060229.dVuyxjBv-lkp@intel.com
https://lore.kernel.org/linux-mm/202209080718.y5QmlNKH-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/gpu/drm/amd/amdgpu/imu_v11_0_3.c:139:6: warning: no previous prototype for 'imu_v11_0_3_program_rlc_ram' [-Wmissing-prototypes]
drivers/gpu/drm/drm_atomic_helper.c:802: warning: expecting prototype for drm_atomic_helper_check_wb_connector_state(). Prototype was for drm_atomic_helper_check_wb_encoder_state() instead
drivers/hwmon/emc2305.c:194 emc2305_set_cur_state() warn: impossible condition '(val > 255) => (0-255 > 255)'
drivers/scsi/qla2xxx/qla_os.c:2854:23: warning: assignment to 'struct trace_array *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
drivers/scsi/qla2xxx/qla_os.c:2854:25: error: implicit declaration of function 'trace_array_get_by_name'; did you mean 'trace_array_set_clr_event'? [-Werror=implicit-function-declaration]
drivers/scsi/qla2xxx/qla_os.c:2869:9: error: implicit declaration of function 'trace_array_put' [-Werror=implicit-function-declaration]
kernel/bpf/memalloc.c:499 bpf_mem_alloc_destroy() error: potentially dereferencing uninitialized 'c'.
mm/damon/vaddr.c:158 __damon_va_three_regions() error: uninitialized symbol 'start'.
net/mac80211/iface.c:251 ieee80211_can_powered_addr_change() warn: inconsistent returns '&local->mtx'.
sound/soc/codecs/tas2562.c:442:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-imu_v11_0_3.c:warning:no-previous-prototype-for-imu_v11_0_3_program_rlc_ram
|   |-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|   |-- drivers-scsi-qla2xxx-qla_os.c:error:implicit-declaration-of-function-trace_array_get_by_name
|   |-- drivers-scsi-qla2xxx-qla_os.c:error:implicit-declaration-of-function-trace_array_put
|   |-- drivers-scsi-qla2xxx-qla_os.c:warning:assignment-to-struct-trace_array-from-int-makes-pointer-from-integer-without-a-cast
|   `-- sound-soc-codecs-tas2562.c:warning:variable-ret-set-but-not-used
|-- alpha-buildonly-randconfig-r003-20220911
|   |-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|   `-- sound-soc-codecs-tas2562.c:warning:variable-ret-set-but-not-used
|-- arc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-imu_v11_0_3.c:warning:no-previous-prototype-for-imu_v11_0_3_program_rlc_ram
|   |-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|   `-- sound-soc-codecs-tas2562.c:warning:variable-ret-set-but-not-used
|-- arc-buildonly-randconfig-r002-20220912
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- arc-randconfig-r012-20220913
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- arc-randconfig-r021-20220911
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- arc-randconfig-r043-20220911
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- arc-randconfig-r043-20220912
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- arc-randconfig-s052-20220911
|   |-- kernel-bpf-hashtab.c:sparse:sparse:cast-removes-address-space-__percpu-of-expression
|   |-- kernel-bpf-hashtab.c:sparse:sparse:incorrect-type-in-assignment-(different-address-spaces)-expected-void-noderef-__percpu-assigned-pptr-got-void
|   |-- kernel-bpf-hashtab.c:sparse:sparse:incorrect-type-in-assignment-(different-address-spaces)-expected-void-ptr_to_pptr-got-void-noderef-__percpu-assigned-pptr
|   |-- kernel-bpf-memalloc.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-noderef-__percpu-__pdata-got-void
|   |-- kernel-bpf-memalloc.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-noderef-__percpu-__pdata-got-void-pptr
|   |-- kernel-bpf-memalloc.c:sparse:sparse:incorrect-type-in-initializer-(different-address-spaces)-expected-void-pptr-got-void-noderef-__percpu
|   `-- kernel-exit.c:sparse:sparse:incorrect-type-in-initializer-(different-address-spaces)-expected-struct-sighand_struct-sighand-got-struct-sighand_struct-noderef-__rcu-sighand
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-imu_v11_0_3.c:warning:no-previous-prototype-for-imu_v11_0_3_program_rlc_ram
|   |-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|   `-- sound-soc-codecs-tas2562.c:warning:variable-ret-set-but-not-used
|-- arm-defconfig
|   `-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|-- arm-randconfig-r001-20220911
|   |-- drivers-gpu-drm-amd-amdgpu-imu_v11_0_3.c:warning:no-previous-prototype-for-imu_v11_0_3_program_rlc_ram
|   |-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|   `-- sound-soc-codecs-tas2562.c:warning:variable-ret-set-but-not-used
|-- arm-randconfig-r006-20220911
|   |-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|   `-- sound-soc-codecs-tas2562.c:warning:variable-ret-set-but-not-used
|-- arm64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-imu_v11_0_3.c:warning:no-previous-prototype-for-imu_v11_0_3_program_rlc_ram
|   |-- drivers-gpu-drm-drm_atomic_helper.c:warning:expecting-prototype-for-drm_atomic_helper_check_wb_connector_state().-Prototype-was-for-drm_atomic_helper_check_wb_encoder_state()-instead
|   `-- sound-soc-codecs-tas2562.c:warning:variable-ret-set-but-not-used
|-- csky-buildonly-randconfig-r001-20220911
clang_recent_errors
|-- i386-randconfig-a012-20220912
|   `-- sound-soc-intel-skylake-skl.c:warning:unused-variable-skl
|-- i386-randconfig-a015-20220912
|   `-- drivers-extcon-extcon-usbc-tusb320.c:warning:expecting-prototype-for-drivers-extcon-extcon-tusb320c().-Prototype-was-for-TUSB320_REG8()-instead
|-- powerpc-buildonly-randconfig-r006-20220912
|   `-- drivers-extcon-extcon-usbc-tusb320.c:warning:expecting-prototype-for-drivers-extcon-extcon-tusb320c().-Prototype-was-for-TUSB320_REG8()-instead
|-- powerpc-randconfig-r004-20220911
|   `-- drivers-gpu-drm-amd-amdgpu-imu_v11_0_3.c:warning:no-previous-prototype-for-function-imu_v11_0_3_program_rlc_ram
`-- riscv-randconfig-r042-20220912
    `-- drivers-extcon-extcon-usbc-tusb320.c:warning:expecting-prototype-for-drivers-extcon-extcon-tusb320c().-Prototype-was-for-TUSB320_REG8()-instead

elapsed time: 725m

configs tested: 63
configs skipped: 2

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                 randconfig-a001-20220912
i386                 randconfig-a002-20220912
x86_64                              defconfig
i386                 randconfig-a004-20220912
x86_64                           rhel-8.3-kvm
i386                 randconfig-a003-20220912
x86_64                          rhel-8.3-func
i386                 randconfig-a006-20220912
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
i386                 randconfig-a005-20220912
x86_64                    rhel-8.3-kselftests
m68k                             allmodconfig
x86_64                           rhel-8.3-syz
arc                              allyesconfig
x86_64                           allyesconfig
alpha                            allyesconfig
i386                                defconfig
m68k                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
arm                                 defconfig
mips                             allyesconfig
x86_64               randconfig-a001-20220912
x86_64               randconfig-a006-20220912
sh                               allmodconfig
x86_64               randconfig-a004-20220912
riscv                randconfig-r042-20220911
x86_64               randconfig-a002-20220912
i386                             allyesconfig
arc                  randconfig-r043-20220912
x86_64               randconfig-a005-20220912
arm64                            allyesconfig
x86_64               randconfig-a003-20220912
arm                              allyesconfig
arc                  randconfig-r043-20220911
s390                 randconfig-r044-20220911
ia64                             allmodconfig
csky                              allnoconfig
arc                               allnoconfig
alpha                             allnoconfig
riscv                             allnoconfig

clang tested configs:
i386                 randconfig-a014-20220912
i386                 randconfig-a013-20220912
x86_64               randconfig-a014-20220912
i386                 randconfig-a011-20220912
x86_64               randconfig-a011-20220912
i386                 randconfig-a015-20220912
x86_64               randconfig-a012-20220912
i386                 randconfig-a012-20220912
x86_64               randconfig-a016-20220912
i386                 randconfig-a016-20220912
x86_64               randconfig-a013-20220912
riscv                randconfig-r042-20220912
x86_64               randconfig-a015-20220912
hexagon              randconfig-r041-20220912
hexagon              randconfig-r045-20220911
hexagon              randconfig-r041-20220911
hexagon              randconfig-r045-20220912
s390                 randconfig-r044-20220912
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
