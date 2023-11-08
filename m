Return-Path: <bpf+bounces-14467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DEC7E50A3
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 07:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC25C1C20DBE
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 06:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6038D28A;
	Wed,  8 Nov 2023 06:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZFnNqSm"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF76FCA70;
	Wed,  8 Nov 2023 06:56:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EE61716;
	Tue,  7 Nov 2023 22:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699426600; x=1730962600;
  h=date:from:to:cc:subject:message-id;
  bh=5x7wG3znK7SjI7OnpFSrFwFkgD88zrIhgrJZMAB8n2Q=;
  b=dZFnNqSmSb3y2mee2SuLL3NyC1zIxPNjo8byzHWA1Lzmq3cu72Hyc8+I
   zDYWXhcckPMBKSnqKd9pOYzIBYEXR/wYyi/R38P+y6SJDU+6ZhpcV6qAU
   NyHcuxmcQ+zLoaY7eSDnTm4Sv13/lNgI4oActOvbSzg8+KL95gqEiCE4W
   B5JBClaFKvx+nywy/a3r3vgvjLdwUvvA+xbh1M9i62cx4S2kDOLrnQZkR
   i2anbcVTVAyylokKNQrxDGRLnvzIwYK2R3Ha3ASEe6wJodYJ/g3VVJnBy
   PUnKT9m9Kd1wtjt7NLqJsPiYaUGzG9+5nmc74jlWNV4jomlS6NZJMmT5K
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="8355634"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="8355634"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 22:56:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="1010174117"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="1010174117"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 07 Nov 2023 22:56:31 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r0cUH-0007ky-2H;
	Wed, 08 Nov 2023 06:56:29 +0000
Date: Wed, 08 Nov 2023 14:55:31 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 apparmor@lists.ubuntu.com, bpf@vger.kernel.org, gfs2@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, linux-block@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 loongarch@lists.linux.dev, netdev@vger.kernel.org,
 sparclinux@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 5cd631a52568a18b12fd2563418985c8cb63e4b0
Message-ID: <202311081422.L6DDIbrW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 5cd631a52568a18b12fd2563418985c8cb63e4b0  Add linux-next specific files for 20231107

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202311011659.fOMoFPWP-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

fs/bcachefs/disk_groups.c:583:6: warning: no previous prototype for 'bch2_target_to_text_sb' [-Wmissing-prototypes]

Unverified Error/Warning (likely false positive, please contact us if interested):

arch/riscv/kernel/smpboot.c: asm/cpufeature.h is included more than once.

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-firmware-broadcom-bcm47xx_sprom.c:warning:snprintf-output-may-be-truncated-before-the-last-format-character
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- alpha-defconfig
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- arc-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- arc-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- arm-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- arm-allnoconfig
|   `-- arch-arm-kernel-process.c:warning:variable-buf-set-but-not-used
|-- arm-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-firmware-broadcom-bcm47xx_sprom.c:warning:snprintf-output-may-be-truncated-before-the-last-format-character
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- arm-defconfig
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-firmware-broadcom-bcm47xx_sprom.c:warning:snprintf-output-may-be-truncated-before-the-last-format-character
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   `-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|-- arm-randconfig-004-20231107
|   |-- arch-arm-kernel-process.c:warning:variable-buf-set-but-not-used
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- csky-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- csky-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-firmware-broadcom-bcm47xx_sprom.c:warning:snprintf-output-may-be-truncated-before-the-last-format-character
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- i386-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- i386-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- i386-debian-10.3
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- i386-defconfig
|   `-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|-- loongarch-allmodconfig
|   |-- arch-loongarch-kernel-asm-offsets.c:warning:no-previous-prototype-for-output_kvm_defines
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- loongarch-allnoconfig
|   `-- arch-loongarch-kernel-asm-offsets.c:warning:no-previous-prototype-for-output_kvm_defines
|-- loongarch-allyesconfig
|   |-- arch-loongarch-kernel-asm-offsets.c:warning:no-previous-prototype-for-output_kvm_defines
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-firmware-broadcom-bcm47xx_sprom.c:warning:snprintf-output-may-be-truncated-before-the-last-format-character
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- loongarch-defconfig
|   |-- arch-loongarch-kernel-asm-offsets.c:warning:no-previous-prototype-for-output_kvm_defines
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- m68k-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- m68k-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- m68k-defconfig
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- microblaze-alldefconfig
|   |-- arch-microblaze-kernel-traps.c:warning:no-previous-prototype-for-trap_init
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-fp-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-loglvl-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-pc-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-task-not-described-in-unwind_trap
|   `-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-trace-not-described-in-unwind_trap
|-- microblaze-allmodconfig
|   |-- arch-microblaze-kernel-traps.c:warning:no-previous-prototype-for-trap_init
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-fp-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-loglvl-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-pc-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-task-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-trace-not-described-in-unwind_trap
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- microblaze-allnoconfig
|   |-- arch-microblaze-kernel-traps.c:warning:no-previous-prototype-for-trap_init
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-fp-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-loglvl-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-pc-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-task-not-described-in-unwind_trap
|   `-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-trace-not-described-in-unwind_trap
|-- microblaze-allyesconfig
|   |-- arch-microblaze-kernel-traps.c:warning:no-previous-prototype-for-trap_init
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-fp-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-loglvl-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-pc-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-task-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-trace-not-described-in-unwind_trap
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-firmware-broadcom-bcm47xx_sprom.c:warning:snprintf-output-may-be-truncated-before-the-last-format-character
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- microblaze-defconfig
|   |-- arch-microblaze-kernel-traps.c:warning:no-previous-prototype-for-trap_init
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-fp-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-loglvl-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-pc-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-task-not-described-in-unwind_trap
|   `-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-trace-not-described-in-unwind_trap
|-- mips-allmodconfig
|   |-- arch-mips-kernel-ftrace.c:warning:no-previous-prototype-for-prepare_ftrace_return
|   |-- arch-mips-kernel-machine_kexec.c:warning:no-previous-prototype-for-machine_shutdown
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- mips-allyesconfig
|   |-- arch-mips-kernel-ftrace.c:warning:no-previous-prototype-for-prepare_ftrace_return
|   |-- arch-mips-kernel-machine_kexec.c:warning:no-previous-prototype-for-machine_shutdown
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- nios2-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- nios2-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- nios2-randconfig-002-20231107
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   `-- drivers-net-ppp-pppoe.c:warning:variable-pde-set-but-not-used
|-- openrisc-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- openrisc-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-firmware-broadcom-bcm47xx_sprom.c:warning:snprintf-output-may-be-truncated-before-the-last-format-character
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- parisc-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- parisc-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-firmware-broadcom-bcm47xx_sprom.c:warning:snprintf-output-may-be-truncated-before-the-last-format-character
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- parisc-randconfig-001-20231107
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   `-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|-- powerpc-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- powerpc-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-firmware-broadcom-bcm47xx_sprom.c:warning:snprintf-output-may-be-truncated-before-the-last-format-character
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- riscv-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- riscv-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-firmware-broadcom-bcm47xx_sprom.c:warning:snprintf-output-may-be-truncated-before-the-last-format-character
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- riscv-defconfig
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- riscv-rv32_defconfig
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- s390-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- s390-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-firmware-broadcom-bcm47xx_sprom.c:warning:snprintf-output-may-be-truncated-before-the-last-format-character
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- s390-defconfig
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- sh-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- sh-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- sparc-alldefconfig
|   |-- kernel-dma.c:warning:no-previous-prototype-for-free_dma
|   `-- kernel-dma.c:warning:no-previous-prototype-for-request_dma
|-- sparc-allmodconfig
|   |-- arch-sparc-kernel-module.c:error:variable-strtab-set-but-not-used
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- sparc-allnoconfig
|   |-- kernel-dma.c:warning:no-previous-prototype-for-free_dma
|   `-- kernel-dma.c:warning:no-previous-prototype-for-request_dma
|-- sparc-allyesconfig
|   |-- arch-sparc-kernel-module.c:error:variable-strtab-set-but-not-used
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-firmware-broadcom-bcm47xx_sprom.c:warning:snprintf-output-may-be-truncated-before-the-last-format-character
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- sparc-defconfig
|   |-- arch-sparc-kernel-module.c:error:variable-strtab-set-but-not-used
|   |-- kernel-dma.c:warning:no-previous-prototype-for-free_dma
|   `-- kernel-dma.c:warning:no-previous-prototype-for-request_dma
|-- sparc64-allmodconfig
|   |-- arch-sparc-kernel-module.c:error:variable-strtab-set-but-not-used
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- sparc64-allyesconfig
|   |-- arch-sparc-kernel-module.c:error:variable-strtab-set-but-not-used
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-firmware-broadcom-bcm47xx_sprom.c:warning:snprintf-output-may-be-truncated-before-the-last-format-character
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- sparc64-defconfig
|   |-- arch-sparc-kernel-module.c:error:variable-strtab-set-but-not-used
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-allnoconfig
|   |-- arch-riscv-include-asm-insn-def.h:asm-gpr-num.h-is-included-more-than-once.
|   |-- arch-riscv-kernel-smpboot.c:asm-cpufeature.h-is-included-more-than-once.
|   |-- drivers-pinctrl-qcom-pinctrl-lpass-lpi.c:linux-seq_file.h-is-included-more-than-once.
|   |-- include-linux-gpio-consumer.h:linux-err.h-is-included-more-than-once.
|   |-- include-linux-gpio-driver.h:asm-bug.h-is-included-more-than-once.
|   |-- include-linux-gpio-driver.h:linux-err.h-is-included-more-than-once.
|   `-- kernel-bpf-bpf_struct_ops.c:bpf_struct_ops_types.h-is-included-more-than-once.
|-- x86_64-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-firmware-broadcom-bcm47xx_sprom.c:warning:snprintf-output-may-be-truncated-before-the-last-format-character
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- x86_64-defconfig
|   `-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|-- x86_64-randconfig-004-20231107
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
`-- x86_64-rhel-8.3
    |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
    |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
    |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
    |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
    |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
    |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
    |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
    |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
    |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
    |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
    `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
clang_recent_errors
`-- x86_64-rhel-8.3-rust
    |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
    |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
    |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
    |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
    |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
    |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
    |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
    |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
    |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
    `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt

elapsed time: 1647m

configs tested: 101
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-004-20231107   gcc  
arm                           sunxi_defconfig   gcc  
arm                        vexpress_defconfig   clang
arm64                             allnoconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       alldefconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      maltaaprp_defconfig   clang
mips                          rb532_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-002-20231107   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231107   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                      tqm8xx_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
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
x86_64                randconfig-004-20231107   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

