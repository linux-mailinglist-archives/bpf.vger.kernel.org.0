Return-Path: <bpf+bounces-7399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F148377674E
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 20:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6DB281327
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 18:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DF01DA2C;
	Wed,  9 Aug 2023 18:29:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65FF1DA33;
	Wed,  9 Aug 2023 18:29:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2451BFA;
	Wed,  9 Aug 2023 11:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691605785; x=1723141785;
  h=date:from:to:cc:subject:message-id;
  bh=JO28v4AThAH9S4Jz1TvazVqFHkRKaGQWvh2JuhCpHm4=;
  b=b1RoipgsXlr8EZ9owtB8RXOXpgjmyUg4u7knS3KflInD4V+PZ2q8whH3
   vGpwas4kykVvnDJqvsqN4wCTGXdpf5RTa9ke4MtxAR2P19bF41+LMhUkJ
   pYaQJOVR5H62c2Ep9kUsAzLDwMBMTeq+5Yb7P1yjcCJWabKUtB0k6Nebz
   gXgPYzc2opTT9jbJ1TozwWpSoqslltuEpyoIDORCGtH1cPMFVlgG8q8/c
   45vVu96w2Jay0DsIUfT8nG/MRS1D3JQOE5OinFHiWb9Yt1FBk7uVkvF49
   C+wTZzsH3oxJd3EYUCTm7NpCQBWm0pD6aFLjBWWWJBCr4TdgGXZ8CkceT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="370099551"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="370099551"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 11:29:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="846078968"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="846078968"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 09 Aug 2023 11:29:41 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qTnwD-0006Jy-0G;
	Wed, 09 Aug 2023 18:29:41 +0000
Date: Thu, 10 Aug 2023 02:29:19 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, bpf@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-alpha@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-input@vger.kernel.org,
 netdev@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 21ef7b1e17d039053edaeaf41142423810572741
Message-ID: <202308100207.to2feahW-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 21ef7b1e17d039053edaeaf41142423810572741  Add linux-next specific files for 20230809

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202307251531.p8ZLFTMZ-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308081459.US5rLYAY-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308091728.NEJhgUPP-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308091820.0dPY7D6f-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308092009.dDIMqss4-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308100149.2rvEPRIG-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308100247.oHTlRKLx-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

../lib/gcc/loongarch64-linux/12.3.0/plugin/include/config/loongarch/loongarch-opts.h:31:10: fatal error: loongarch-def.h: No such file or directory
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_replay.c:37: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
drivers/video/backlight/lp855x_bl.c:252:11: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
drivers/video/backlight/lp855x_bl.c:252:7: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
include/linux/list.h:53:13: error: '__preserve_most__' calling convention is not supported for this target [-Werror,-Wignored-attributes]
include/linux/list.h:53:13: warning: '__preserve_most__' calling convention is not supported for this target [-Wignored-attributes]
lib/list_debug.c:20:1: warning: '__preserve_most__' calling convention is not supported for this target [-Wignored-attributes]
warning: unsafe memchr() usage lacked '__read_overflow' warning in lib/test_fortify/read_overflow-memchr.c
warning: unsafe memchr_inv() usage lacked '__read_overflow' warning in lib/test_fortify/read_overflow-memchr_inv.c
warning: unsafe memcmp() usage lacked '__read_overflow' warning in lib/test_fortify/read_overflow-memcmp.c
warning: unsafe memcmp() usage lacked '__read_overflow2' warning in lib/test_fortify/read_overflow2-memcmp.c
warning: unsafe memcpy() usage lacked '__read_overflow2' warning in lib/test_fortify/read_overflow2-memcpy.c
warning: unsafe memcpy() usage lacked '__read_overflow2_field' warning in lib/test_fortify/read_overflow2_field-memcpy.c
warning: unsafe memcpy() usage lacked '__write_overflow' warning in lib/test_fortify/write_overflow-memcpy.c
warning: unsafe memcpy() usage lacked '__write_overflow_field' warning in lib/test_fortify/write_overflow_field-memcpy.c
warning: unsafe memmove() usage lacked '__read_overflow2' warning in lib/test_fortify/read_overflow2-memmove.c
warning: unsafe memmove() usage lacked '__read_overflow2_field' warning in lib/test_fortify/read_overflow2_field-memmove.c
warning: unsafe memmove() usage lacked '__write_overflow' warning in lib/test_fortify/write_overflow-memmove.c
warning: unsafe memmove() usage lacked '__write_overflow_field' warning in lib/test_fortify/write_overflow_field-memmove.c
warning: unsafe memscan() usage lacked '__read_overflow' warning in lib/test_fortify/read_overflow-memscan.c
warning: unsafe memset() usage lacked '__write_overflow' warning in lib/test_fortify/write_overflow-memset.c
warning: unsafe memset() usage lacked '__write_overflow_field' warning in lib/test_fortify/write_overflow_field-memset.c
warning: unsafe strcpy() usage lacked '__write_overflow' warning in lib/test_fortify/write_overflow-strcpy-lit.c
warning: unsafe strcpy() usage lacked '__write_overflow' warning in lib/test_fortify/write_overflow-strcpy.c
warning: unsafe strlcpy() usage lacked '__write_overflow' warning in lib/test_fortify/write_overflow-strlcpy-src.c
warning: unsafe strlcpy() usage lacked '__write_overflow' warning in lib/test_fortify/write_overflow-strlcpy.c
warning: unsafe strncpy() usage lacked '__write_overflow' warning in lib/test_fortify/write_overflow-strncpy-src.c
warning: unsafe strncpy() usage lacked '__write_overflow' warning in lib/test_fortify/write_overflow-strncpy.c
warning: unsafe strscpy() usage lacked '__write_overflow' warning in lib/test_fortify/write_overflow-strscpy.c

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/block/ublk_drv.c:445 ublk_setup_iod_zoned() warn: signedness bug returning '(-95)'
drivers/gpu/drm/tests/drm_exec_test.c:166 test_prepare_array() error: uninitialized symbol 'ret'.
drivers/input/touchscreen/iqs7211.c:1761 iqs7211_parse_cycles() error: buffer overflow 'cycle_alloc[0]' 2 <= 41
drivers/regulator/max77857-regulator.c:430:28: sparse: sparse: symbol 'max77857_id' was not declared. Should it be static?
drivers/soundwire/qcom.c:905:22-23: WARNING opportunity for min()
drivers/video/fbdev/core/fb_chrdev.c:239 do_fscreeninfo_to_user() warn: ignoring unreachable code.
kernel/workqueue.c:324:40: sparse: sparse: duplicate [noderef]
kernel/workqueue.c:324:40: sparse: sparse: multiple address spaces given: __percpu & __rcu
mm/khugepaged.c:2138 collapse_file() warn: variable dereferenced before check 'cc' (see line 1787)
net/xdp/xsk.c:696 xsk_build_skb() error: 'skb' dereferencing possible ERR_PTR()
sh4-linux-gcc: internal compiler error: Segmentation fault signal terminated program cc1
{standard input}: Warning: end of file not at end of a line; newline inserted
{standard input}:927: Error: pcrel too far

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_replay.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|-- alpha-randconfig-r082-20230808
|   |-- kernel-workqueue.c:sparse:sparse:duplicate-noderef
|   `-- kernel-workqueue.c:sparse:sparse:multiple-address-spaces-given:__percpu-__rcu
|-- alpha-randconfig-r093-20230809
|   `-- arch-alpha-include-asm-xchg.h:sparse:sparse:cast-truncates-bits-from-constant-value-(eb9f-becomes-9f)
|-- arc-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_replay.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|-- arm-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_replay.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|-- arm-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_replay.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|-- arm64-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_replay.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|-- i386-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_replay.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|-- i386-buildonly-randconfig-r006-20230809
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_replay.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|-- i386-randconfig-r082-20230809
|   `-- drivers-regulator-max77857-regulator.c:sparse:sparse:symbol-max77857_id-was-not-declared.-Should-it-be-static
|-- loongarch-allmodconfig
|   `-- lib-gcc-loongarch64-linux-..-plugin-include-config-loongarch-loongarch-opts.h:fatal-error:loongarch-def.h:No-such-file-or-directory
|-- microblaze-randconfig-r035-20230808
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_replay.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|-- mips-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_replay.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|-- mips-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_replay.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|-- mips-randconfig-m031-20230809
|   |-- drivers-gpu-drm-tests-drm_exec_test.c-test_prepare_array()-error:uninitialized-symbol-ret-.
|   |-- drivers-input-touchscreen-iqs7211.c-iqs7211_parse_cycles()-error:buffer-overflow-cycle_alloc
|   `-- net-xdp-xsk.c-xsk_build_skb()-error:skb-dereferencing-possible-ERR_PTR()
|-- parisc-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_replay.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|-- powerpc-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_replay.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|-- riscv-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_replay.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|-- riscv-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_replay.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|-- s390-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_replay.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|-- s390-randconfig-m041-20230809
|   |-- drivers-block-ublk_drv.c-ublk_setup_iod_zoned()-warn:signedness-bug-returning
|   |-- drivers-video-fbdev-core-fb_chrdev.c-do_fscreeninfo_to_user()-warn:ignoring-unreachable-code.
|   `-- mm-khugepaged.c-collapse_file()-warn:variable-dereferenced-before-check-cc-(see-line-)
|-- s390-randconfig-r044-20230808
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_replay.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|-- sh-allmodconfig
|   |-- sh4-linux-gcc:internal-compiler-error:Segmentation-fault-signal-terminated-program-cc1
|   |-- standard-input:Error:pcrel-too-far
|   `-- standard-input:Warning:end-of-file-not-at-end-of-a-line-newline-inserted
|-- sparc-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_replay.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|-- um-randconfig-r051-20230809
|   `-- drivers-soundwire-qcom.c:WARNING-opportunity-for-min()
`-- x86_64-allyesconfig
    `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_replay.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
clang_recent_errors
|-- arm-randconfig-r005-20230809
|   |-- include-linux-list.h:error:__preserve_most__-calling-convention-is-not-supported-for-this-target-Werror-Wignored-attributes
|   |-- include-linux-list.h:warning:__preserve_most__-calling-convention-is-not-supported-for-this-target
|   |-- lib-list_debug.c:warning:__preserve_most__-calling-convention-is-not-supported-for-this-target
|   |-- warning:unsafe-memchr()-usage-lacked-__read_overflow-warning-in-lib-test_fortify-read_overflow-memchr.c
|   |-- warning:unsafe-memchr_inv()-usage-lacked-__read_overflow-warning-in-lib-test_fortify-read_overflow-memchr_inv.c
|   |-- warning:unsafe-memcmp()-usage-lacked-__read_overflow-warning-in-lib-test_fortify-read_overflow-memcmp.c
|   |-- warning:unsafe-memcmp()-usage-lacked-__read_overflow2-warning-in-lib-test_fortify-read_overflow2-memcmp.c
|   |-- warning:unsafe-memcpy()-usage-lacked-__read_overflow2-warning-in-lib-test_fortify-read_overflow2-memcpy.c
|   |-- warning:unsafe-memcpy()-usage-lacked-__read_overflow2_field-warning-in-lib-test_fortify-read_overflow2_field-memcpy.c
|   |-- warning:unsafe-memcpy()-usage-lacked-__write_overflow-warning-in-lib-test_fortify-write_overflow-memcpy.c
|   |-- warning:unsafe-memcpy()-usage-lacked-__write_overflow_field-warning-in-lib-test_fortify-write_overflow_field-memcpy.c
|   |-- warning:unsafe-memmove()-usage-lacked-__read_overflow2-warning-in-lib-test_fortify-read_overflow2-memmove.c
|   |-- warning:unsafe-memmove()-usage-lacked-__read_overflow2_field-warning-in-lib-test_fortify-read_overflow2_field-memmove.c
|   |-- warning:unsafe-memmove()-usage-lacked-__write_overflow-warning-in-lib-test_fortify-write_overflow-memmove.c
|   |-- warning:unsafe-memmove()-usage-lacked-__write_overflow_field-warning-in-lib-test_fortify-write_overflow_field-memmove.c
|   |-- warning:unsafe-memscan()-usage-lacked-__read_overflow-warning-in-lib-test_fortify-read_overflow-memscan.c
|   |-- warning:unsafe-memset()-usage-lacked-__write_overflow-warning-in-lib-test_fortify-write_overflow-memset.c
|   |-- warning:unsafe-memset()-usage-lacked-__write_overflow_field-warning-in-lib-test_fortify-write_overflow_field-memset.c
|   |-- warning:unsafe-strcpy()-usage-lacked-__write_overflow-warning-in-lib-test_fortify-write_overflow-strcpy-lit.c
|   |-- warning:unsafe-strcpy()-usage-lacked-__write_overflow-warning-in-lib-test_fortify-write_overflow-strcpy.c
|   |-- warning:unsafe-strlcpy()-usage-lacked-__write_overflow-warning-in-lib-test_fortify-write_overflow-strlcpy-src.c
|   |-- warning:unsafe-strlcpy()-usage-lacked-__write_overflow-warning-in-lib-test_fortify-write_overflow-strlcpy.c
|   |-- warning:unsafe-strncpy()-usage-lacked-__write_overflow-warning-in-lib-test_fortify-write_overflow-strncpy-src.c
|   |-- warning:unsafe-strncpy()-usage-lacked-__write_overflow-warning-in-lib-test_fortify-write_overflow-strncpy.c
|   `-- warning:unsafe-strscpy()-usage-lacked-__write_overflow-warning-in-lib-test_fortify-write_overflow-strscpy.c
|-- hexagon-randconfig-r015-20230809
|   `-- drivers-video-backlight-lp855x_bl.c:warning:variable-ret-is-used-uninitialized-whenever-if-condition-is-false
|-- hexagon-randconfig-r041-20230808
|   |-- include-linux-list.h:warning:__preserve_most__-calling-convention-is-not-supported-for-this-target
|   `-- lib-list_debug.c:warning:__preserve_most__-calling-convention-is-not-supported-for-this-target
|-- i386-randconfig-i011-20230809
|   `-- drivers-video-backlight-lp855x_bl.c:warning:variable-ret-is-used-uninitialized-whenever-if-condition-is-false
|-- i386-randconfig-i015-20230809
|   `-- drivers-video-backlight-lp855x_bl.c:warning:variable-ret-is-used-uninitialized-whenever-if-condition-is-false
`-- x86_64-buildonly-randconfig-r002-20230808
    `-- drivers-video-backlight-lp855x_bl.c:warning:variable-ret-is-used-uninitialized-whenever-if-condition-is-false

elapsed time: 722m

configs tested: 115
configs skipped: 5

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r033-20230808   gcc  
arc                  randconfig-r043-20230808   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r005-20230809   clang
arm                  randconfig-r046-20230808   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230809   gcc  
arm64                randconfig-r006-20230809   gcc  
arm64                randconfig-r031-20230808   clang
csky                                defconfig   gcc  
hexagon              randconfig-r004-20230809   clang
hexagon              randconfig-r041-20230808   clang
hexagon              randconfig-r045-20230808   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230808   clang
i386         buildonly-randconfig-r004-20230809   gcc  
i386         buildonly-randconfig-r005-20230809   gcc  
i386         buildonly-randconfig-r006-20230808   clang
i386         buildonly-randconfig-r006-20230809   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230808   clang
i386                 randconfig-i001-20230809   gcc  
i386                 randconfig-i002-20230808   clang
i386                 randconfig-i002-20230809   gcc  
i386                 randconfig-i003-20230808   clang
i386                 randconfig-i003-20230809   gcc  
i386                 randconfig-i004-20230808   clang
i386                 randconfig-i004-20230809   gcc  
i386                 randconfig-i005-20230809   gcc  
i386                 randconfig-i006-20230809   gcc  
i386                 randconfig-i011-20230809   clang
i386                 randconfig-i012-20230809   clang
i386                 randconfig-i013-20230809   clang
i386                 randconfig-i014-20230809   clang
i386                 randconfig-i015-20230809   clang
i386                 randconfig-i016-20230809   clang
i386                 randconfig-r023-20230808   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230809   gcc  
m68k                 randconfig-r011-20230808   gcc  
microblaze           randconfig-r035-20230808   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r034-20230808   gcc  
openrisc             randconfig-r013-20230808   gcc  
openrisc             randconfig-r016-20230808   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r003-20230809   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r014-20230808   gcc  
riscv                randconfig-r042-20230808   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230808   gcc  
sh                               allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r015-20230808   gcc  
sparc                randconfig-r025-20230808   gcc  
sparc64              randconfig-r026-20230808   gcc  
sparc64              randconfig-r032-20230808   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r036-20230808   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230808   clang
x86_64       buildonly-randconfig-r001-20230809   gcc  
x86_64       buildonly-randconfig-r002-20230808   clang
x86_64       buildonly-randconfig-r002-20230809   gcc  
x86_64       buildonly-randconfig-r003-20230808   clang
x86_64       buildonly-randconfig-r003-20230809   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r021-20230808   gcc  
x86_64               randconfig-x001-20230808   gcc  
x86_64               randconfig-x002-20230808   gcc  
x86_64               randconfig-x003-20230808   gcc  
x86_64               randconfig-x004-20230808   gcc  
x86_64               randconfig-x005-20230808   gcc  
x86_64               randconfig-x006-20230808   gcc  
x86_64               randconfig-x011-20230809   gcc  
x86_64               randconfig-x012-20230809   gcc  
x86_64               randconfig-x013-20230809   gcc  
x86_64               randconfig-x014-20230809   gcc  
x86_64               randconfig-x015-20230809   gcc  
x86_64               randconfig-x016-20230809   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

