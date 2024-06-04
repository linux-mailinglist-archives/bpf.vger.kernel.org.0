Return-Path: <bpf+bounces-31354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFF58FB93C
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 18:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED621C22568
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 16:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ABE14883B;
	Tue,  4 Jun 2024 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LYCZXx9/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBA6127B7A;
	Tue,  4 Jun 2024 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519288; cv=none; b=rk5vCRuje27IH/8xa/FumSCxUckZmIFkkArktij9NMngjwuv90jx+LBSQNDWcdtD1Eiw1T0yvwiRcWYEYiZWcQHRkNx25jcm5yuUqC5556psjab/HjLB4FWIMFLzZWc3E5J5ElIiSww5DBoxV5g+naZhmE+LAbsx0/TFDTvn7qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519288; c=relaxed/simple;
	bh=l99PcNxm8obHng7+n5hWYuP+Gxq+vqCy0R2Wqi9Gv4E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IuEAq/UZJXDyDoms4D1AvJWi29Xfjha92GJKJgb3Lfs7Z4kyPYxHFld9r2bFhqeovLM8/5GvVbcmPO5Mm5D8QyK1KAWbFqyt9wdgb4SGM4dqJ5ZkyyhHlJ7WW1btodl9hiTR/0tQRw+SQ3QZ8WEud7QZ/StfkPgNpEmWQEQNDQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LYCZXx9/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717519286; x=1749055286;
  h=date:from:to:cc:subject:message-id;
  bh=l99PcNxm8obHng7+n5hWYuP+Gxq+vqCy0R2Wqi9Gv4E=;
  b=LYCZXx9/5GX1g4tTh/5+3KNTDjZ6VRD6RD5Rp2PfKmWv/hlwp+2Wnrnc
   m/MaOR2fCXTIB6dneTQM3RRdYnlQY8WdL0YtTBt7R5geBaVPA5kRTiMPo
   +bZNGqMeGkewaMOlPyBB3ojiYdZef1ubmsOrSrzITkLcZrA5e0286JrUK
   IUBTbFR9K110qeCFxjDh0WUlUQm3/+ipe5P68ahMCCgdDNnViLTc05WBn
   HcI+/n8sjQpj/2ZbICdq8mexn6XJd4nR2vP7wgLbqDOSQFxci65RkNIAD
   K2NuaStMtjyrNDPv+ddBB9YLv9Mbj9yd6Gt1sQoLQ0SVW45Rl19d4lzzT
   A==;
X-CSE-ConnectionGUID: 5jzBbTqTSWO+NwWuX0wLWA==
X-CSE-MsgGUID: 8Vesmxa9SRy+AoFCPQnn9w==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="31617980"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="31617980"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 09:41:24 -0700
X-CSE-ConnectionGUID: 6g5Cbd1/Thu3xeby3WCB3A==
X-CSE-MsgGUID: 5tKQ5h9yTDmUv9XaVX7aww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="37378848"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 04 Jun 2024 09:41:20 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEXDp-0000DL-2w;
	Tue, 04 Jun 2024 16:41:18 +0000
Date: Wed, 05 Jun 2024 00:40:19 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, bpf@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
 linux-input@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 d97496ca23a2d4ee80b7302849404859d9058bcd
Message-ID: <202406050014.Wmet4Lvf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: d97496ca23a2d4ee80b7302849404859d9058bcd  Add linux-next specific files for 20240604

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202406041641.wE3cCT4C-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/input/touchscreen/wacom_w8001.c:637:29: warning: ' Pen' directive output may be truncated writing 4 bytes into a region of size between 1 and 64 [-Wformat-truncation=]
drivers/input/touchscreen/wacom_w8001.c:653:29: warning: ' Finger' directive output may be truncated writing 7 bytes into a region of size between 1 and 64 [-Wformat-truncation=]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-063-20240604
|   `-- drivers-hwmon-cros_ec_hwmon.c:sparse:sparse:cast-to-restricted-__le16
|-- loongarch-defconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hubbub-dcn401-dcn401_hubbub.o:warning:objtool:unexpected-relocation-symbol-type-in-.rela.discard.reachable
|   `-- drivers-thermal-thermal_trip.o:warning:objtool:unexpected-relocation-symbol-type-in-.rela.discard.reachable
|-- microblaze-randconfig-r006-20230312
|   |-- drivers-input-touchscreen-wacom_w8001.c:warning:Finger-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-input-touchscreen-wacom_w8001.c:warning:Pen-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|-- nios2-randconfig-r111-20240604
|   |-- drivers-gpu-drm-arm-display-komeda-komeda_dev.c:error:implicit-declaration-of-function-seq_puts
|   |-- drivers-gpu-drm-arm-display-komeda-komeda_dev.c:error:invalid-use-of-undefined-type-struct-seq_file
|   `-- drivers-gpu-drm-arm-display-komeda-komeda_dev.c:error:type-defaults-to-int-in-declaration-of-DEFINE_SHOW_ATTRIBUTE
`-- um-allyesconfig
    `-- kernel-bpf-verifier.c:error:pcpu_hot-undeclared-(first-use-in-this-function)
clang_recent_errors
|-- arm64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-irq-dce110-irq_service_dce110.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_cursor.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_ddi.c:error:arithmetic-between-different-enumeration-types-(-enum-hpd_pin-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_ddi.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-phy-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-tc_port-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display_irq.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display_irq.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_dpll_mgr.c:error:arithmetic-between-different-enumeration-types-(-enum-tc_port-and-enum-intel_dpll_id-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_hotplug.c:error:arithmetic-between-different-enumeration-types-(-enum-hpd_pin-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_pipe_crc.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_tc.c:error:arithmetic-between-different-enumeration-types-(-enum-intel_display_power_domain-and-enum-tc_port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_vdsc.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-skl_universal_plane.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-skl_watermark.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   `-- drivers-gpu-drm-renesas-rcar-du-rcar_cmm.c:error:unused-function-rcar_cmm_read-Werror-Wunused-function
|-- arm64-randconfig-001-20240604
|   |-- drivers-gpu-drm-drm_mm.c:error:function-drm_mm_node_scanned_block-is-not-needed-and-will-not-be-emitted-Werror-Wunneeded-internal-declaration
|   `-- drivers-gpu-drm-renesas-rcar-du-rcar_cmm.c:error:unused-function-rcar_cmm_read-Werror-Wunused-function
|-- powerpc-randconfig-r112-20240604
|   |-- drivers-mtd-nand-raw-mxc_nand.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-buf-got-void-noderef-__iomem
|   `-- drivers-mtd-nand-raw-mxc_nand.c:sparse:sparse:incorrect-type-in-initializer-(different-address-spaces)-expected-unsigned-short-noderef-usertype-__iomem-t-got-void-buf
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-irq-dce110-irq_service_dce110.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_cursor.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_ddi.c:error:arithmetic-between-different-enumeration-types-(-enum-hpd_pin-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_ddi.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-phy-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-tc_port-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display_irq.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display_irq.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_dpll_mgr.c:error:arithmetic-between-different-enumeration-types-(-enum-tc_port-and-enum-intel_dpll_id-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_hotplug.c:error:arithmetic-between-different-enumeration-types-(-enum-hpd_pin-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_pipe_crc.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_tc.c:error:arithmetic-between-different-enumeration-types-(-enum-intel_display_power_domain-and-enum-tc_port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_vdsc.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-skl_universal_plane.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   `-- drivers-gpu-drm-i915-display-skl_watermark.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|-- riscv-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-irq-dce110-irq_service_dce110.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|-- s390-allmodconfig
|   |-- drivers-gpu-drm-i915-display-intel_cursor.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_ddi.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-phy-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display_irq.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display_irq.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_dpll_mgr.c:error:arithmetic-between-different-enumeration-types-(-enum-tc_port-and-enum-intel_dpll_id-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_hotplug.c:error:arithmetic-between-different-enumeration-types-(-enum-hpd_pin-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_pipe_crc.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_tc.c:error:arithmetic-between-different-enumeration-types-(-enum-intel_display_power_domain-and-enum-tc_port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_vdsc.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-skl_universal_plane.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   `-- drivers-gpu-drm-i915-display-skl_watermark.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|-- x86_64-randconfig-011-20240604
|   `-- drivers-gpu-drm-drm_mm.c:error:function-drm_mm_node_scanned_block-is-not-needed-and-will-not-be-emitted-Werror-Wunneeded-internal-declaration
|-- x86_64-randconfig-122-20240604
|   `-- drivers-hwmon-cros_ec_hwmon.c:sparse:sparse:cast-to-restricted-__le16
`-- x86_64-randconfig-161-20240604
    `-- drivers-gpu-drm-drm_mm.c:error:function-drm_mm_node_scanned_block-is-not-needed-and-will-not-be-emitted-Werror-Wunneeded-internal-declaration

elapsed time: 734m

configs tested: 179
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240604   gcc  
arc                   randconfig-002-20240604   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          ep93xx_defconfig   clang
arm                            hisi_defconfig   gcc  
arm                   randconfig-001-20240604   clang
arm                   randconfig-002-20240604   gcc  
arm                   randconfig-003-20240604   clang
arm                   randconfig-004-20240604   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240604   clang
arm64                 randconfig-002-20240604   gcc  
arm64                 randconfig-003-20240604   gcc  
arm64                 randconfig-004-20240604   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240604   gcc  
csky                  randconfig-002-20240604   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240604   clang
hexagon               randconfig-002-20240604   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240604   gcc  
i386         buildonly-randconfig-002-20240604   clang
i386         buildonly-randconfig-003-20240604   clang
i386         buildonly-randconfig-004-20240604   gcc  
i386         buildonly-randconfig-005-20240604   clang
i386         buildonly-randconfig-006-20240604   clang
i386                                defconfig   clang
i386                  randconfig-001-20240604   clang
i386                  randconfig-002-20240604   clang
i386                  randconfig-003-20240604   clang
i386                  randconfig-004-20240604   clang
i386                  randconfig-005-20240604   gcc  
i386                  randconfig-006-20240604   gcc  
i386                  randconfig-011-20240604   clang
i386                  randconfig-012-20240604   gcc  
i386                  randconfig-013-20240604   gcc  
i386                  randconfig-014-20240604   clang
i386                  randconfig-015-20240604   clang
i386                  randconfig-016-20240604   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240604   gcc  
loongarch             randconfig-002-20240604   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                            q40_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240604   gcc  
nios2                 randconfig-002-20240604   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240604   gcc  
parisc                randconfig-002-20240604   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                        cell_defconfig   gcc  
powerpc                      chrp32_defconfig   clang
powerpc                       eiger_defconfig   clang
powerpc                   microwatt_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc               randconfig-001-20240604   gcc  
powerpc               randconfig-002-20240604   gcc  
powerpc               randconfig-003-20240604   gcc  
powerpc                     tqm8560_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
powerpc64             randconfig-001-20240604   gcc  
powerpc64             randconfig-002-20240604   gcc  
powerpc64             randconfig-003-20240604   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240604   clang
riscv                 randconfig-002-20240604   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240604   clang
s390                  randconfig-002-20240604   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20240604   gcc  
sh                    randconfig-002-20240604   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240604   gcc  
sparc64               randconfig-002-20240604   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240604   clang
um                    randconfig-002-20240604   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240604   clang
x86_64       buildonly-randconfig-002-20240604   clang
x86_64       buildonly-randconfig-003-20240604   gcc  
x86_64       buildonly-randconfig-004-20240604   clang
x86_64       buildonly-randconfig-005-20240604   gcc  
x86_64       buildonly-randconfig-006-20240604   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240604   clang
x86_64                randconfig-002-20240604   gcc  
x86_64                randconfig-003-20240604   gcc  
x86_64                randconfig-004-20240604   gcc  
x86_64                randconfig-005-20240604   gcc  
x86_64                randconfig-006-20240604   gcc  
x86_64                randconfig-011-20240604   clang
x86_64                randconfig-012-20240604   clang
x86_64                randconfig-013-20240604   clang
x86_64                randconfig-014-20240604   clang
x86_64                randconfig-015-20240604   clang
x86_64                randconfig-016-20240604   clang
x86_64                randconfig-071-20240604   clang
x86_64                randconfig-072-20240604   gcc  
x86_64                randconfig-073-20240604   gcc  
x86_64                randconfig-074-20240604   clang
x86_64                randconfig-075-20240604   clang
x86_64                randconfig-076-20240604   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240604   gcc  
xtensa                randconfig-002-20240604   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

