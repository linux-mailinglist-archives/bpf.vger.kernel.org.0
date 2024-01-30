Return-Path: <bpf+bounces-20691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B24D841E69
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 09:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11E01F272B8
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 08:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5D05810D;
	Tue, 30 Jan 2024 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AhAJ79Ld"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F4A57867;
	Tue, 30 Jan 2024 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604756; cv=none; b=bD/EmtqHiEItGbw122ss8AwbTTiDjs23YE3dqXbMcFDvZRRDdCoUMqVpPU4e3KEriNRZrab0w8N7BVxdGVLOsVQ8oHNogGaVx5Rvn2GDU4NLfcjFMomaJmqa+EwwoCdMMxoi5IdOs87K+9UU7hk8fryAJHjKu1K7m8XwR8MSSSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604756; c=relaxed/simple;
	bh=2h2lKDVDe0Qt6DafrcvNa34Fl+qhtWodrVVJ81QUTO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Be16AEyTrFS4cPh9mATSqZ3oiGoK4oD9aUfaWeqrvAJ9SiRCfdXrAat0a3ESzvFIeIPNoYojwwnqDjRweMN7wndH3jWOGOgf81zBBzaachc03BvYHxjD12ahl84t+VJYfrjCLIFo2nSXnBFGIV0ThAlilf8RTBIAiYaz+Fn5gME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AhAJ79Ld; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706604754; x=1738140754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2h2lKDVDe0Qt6DafrcvNa34Fl+qhtWodrVVJ81QUTO0=;
  b=AhAJ79LdFf6ZfRnWl5RZxjS/sEAauHD6ktHX10zQ4DhS3Ruvy++ZbdzE
   h7yc8E4dr5V9owfHInxwLvNVt7stIUN0GXxyzI5ZCMTak9dSYckrt7frG
   QwBUrz0i9DPwM4WOuCyWRMPhMgclPkJTy+MkZaeCqWj+f4NPJ9kHdJleh
   /8Ib1QKVRT3idN1R7o9fCJR6oZz1mST3svFIdrWejT6R0BPg7TMsMaJGd
   TkHgLj20RQIxsZa8X/YM4Sikn91n9fQOHHLCWE0aQapPSnGHSsrGYfXgd
   Cl05RGkX1ZQgG4GXcmGmUInlaHNTSN6IBybZ+bBjK9fc8cwjAsipj98ik
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="10602345"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="10602345"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 00:52:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="788126949"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="788126949"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 30 Jan 2024 00:52:17 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUjou-00009I-0m;
	Tue, 30 Jan 2024 08:50:34 +0000
Date: Tue, 30 Jan 2024 16:48:06 +0800
From: kernel test robot <lkp@intel.com>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, Andrew Halaney <ahalaney@redhat.com>,
	Simon Horman <simon.horman@corigine.com>,
	Serge Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 08/11] stmmac: intel: configure SerDes
 according to the interface mode
Message-ID: <202401301610.XVvNEdG4-lkp@intel.com>
References: <20240129130253.1400707-9-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129130253.1400707-9-yong.liang.choong@linux.intel.com>

Hi Choong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Choong-Yong-Liang/net-phylink-publish-ethtool-link-modes-that-supported-and-advertised/20240129-211219
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240129130253.1400707-9-yong.liang.choong%40linux.intel.com
patch subject: [PATCH net-next v4 08/11] stmmac: intel: configure SerDes according to the interface mode
config: x86_64-kismet-CONFIG_INTEL_PMC_IPC-CONFIG_DWMAC_INTEL-0-0 (https://download.01.org/0day-ci/archive/20240130/202401301610.XVvNEdG4-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20240130/202401301610.XVvNEdG4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401301610.XVvNEdG4-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for INTEL_PMC_IPC when selected by DWMAC_INTEL
   .config:21:warning: symbol value 'n' invalid for AIC79XX_DEBUG_MASK
   .config:51:warning: symbol value 'n' invalid for BLK_DEV_LOOP_MIN_COUNT
   .config:114:warning: symbol value 'n' invalid for SQUASHFS_FRAGMENT_CACHE_SIZE
   .config:205:warning: symbol value 'n' invalid for FB_OMAP2_NUM_FBS
   .config:209:warning: symbol value 'n' invalid for CMA_SIZE_MBYTES
   .config:254:warning: symbol value 'n' invalid for SATA_MOBILE_LPM_POLICY
   .config:337:warning: symbol value 'n' invalid for CFAG12864B_RATE
   .config:351:warning: symbol value 'n' invalid for PSTORE_BLK_MAX_REASON
   .config:355:warning: symbol value 'n' invalid for AIC79XX_CMDS_PER_DEVICE
   .config:437:warning: symbol value 'n' invalid for PANEL_LCD_PIN_SDA
   .config:459:warning: symbol value 'n' invalid for KFENCE_SAMPLE_INTERVAL
   .config:574:warning: symbol value 'n' invalid for AIC7XXX_DEBUG_MASK
   .config:646:warning: symbol value 'n' invalid for CRYPTO_DEV_QCE_SW_MAX_LEN
   .config:653:warning: symbol value 'n' invalid for DRM_XE_JOB_TIMEOUT_MIN
   .config:690:warning: symbol value 'n' invalid for FAT_DEFAULT_CODEPAGE
   .config:752:warning: symbol value 'n' invalid for PANEL_LCD_CHARSET
   .config:838:warning: symbol value 'n' invalid for SND_AC97_POWER_SAVE_DEFAULT
   .config:868:warning: symbol value 'n' invalid for MAGIC_SYSRQ_DEFAULT_ENABLE
   .config:885:warning: symbol value 'n' invalid for DRM_I915_MAX_REQUEST_BUSYWAIT
   .config:919:warning: symbol value 'n' invalid for SND_AT73C213_TARGET_BITRATE
   .config:957:warning: symbol value 'n' invalid for DRM_XE_PREEMPT_TIMEOUT_MIN
   .config:969:warning: symbol value 'n' invalid for VMCP_CMA_SIZE
   .config:1154:warning: symbol value 'n' invalid for NODES_SHIFT
   .config:1224:warning: symbol value 'n' invalid for RCU_CPU_STALL_TIMEOUT
   .config:1253:warning: symbol value 'n' invalid for MTDRAM_ERASE_SIZE
   .config:1327:warning: symbol value 'n' invalid for SERIAL_UARTLITE_NR_UARTS
   .config:1492:warning: symbol value 'n' invalid for INPUT_MOUSEDEV_SCREEN_Y
   .config:1506:warning: symbol value 'n' invalid for LEGACY_PTY_COUNT
   .config:1667:warning: symbol value 'n' invalid for AIC7XXX_RESET_DELAY_MS
   .config:1833:warning: symbol value 'n' invalid for USB_GADGET_STORAGE_NUM_BUFFERS
   .config:1883:warning: symbol value 'n' invalid for IBM_EMAC_POLL_WEIGHT
   .config:1951:warning: symbol value 'n' invalid for PANEL_PROFILE
   .config:1967:warning: symbol value 'n' invalid for DRM_I915_STOP_TIMEOUT
   .config:2289:warning: symbol value 'n' invalid for SND_HDA_PREALLOC_SIZE
   .config:2301:warning: symbol value 'n' invalid for PANEL_LCD_PIN_E
   .config:2336:warning: symbol value 'n' invalid for SND_SOC_SOF_DEBUG_IPC_FLOOD_TEST_NUM
   .config:2339:warning: symbol value 'n' invalid for RCU_FANOUT_LEAF
   .config:2443:warning: symbol value 'n' invalid for DRM_XE_TIMESLICE_MAX
   .config:2500:warning: symbol value 'n' invalid for PANEL_LCD_BWIDTH
   .config:2763:warning: symbol value 'n' invalid for PANEL_PARPORT
   .config:2773:warning: symbol value 'n' invalid for PSTORE_BLK_CONSOLE_SIZE
   .config:2860:warning: symbol value 'n' invalid for NOUVEAU_DEBUG_DEFAULT
   .config:2938:warning: symbol value 'n' invalid for BOOKE_WDT_DEFAULT_TIMEOUT
   .config:3061:warning: symbol value 'n' invalid for KCSAN_REPORT_ONCE_IN_MS
   .config:3171:warning: symbol value 'n' invalid for KCSAN_UDELAY_INTERRUPT
   .config:3194:warning: symbol value 'n' invalid for PANEL_LCD_PIN_BL
   .config:3216:warning: symbol value 'n' invalid for DEBUG_OBJECTS_ENABLE_DEFAULT
   .config:3223:warning: symbol value 'n' invalid for INITRAMFS_ROOT_GID
   .config:3345:warning: symbol value 'n' invalid for ATM_FORE200E_TX_RETRY
   .config:3389:warning: symbol value 'n' invalid for FB_OMAP2_DSS_MIN_FCK_PER_PCK
   .config:3450:warning: symbol value 'n' invalid for AIC79XX_RESET_DELAY_MS
   .config:3538:warning: symbol value 'n' invalid for KCSAN_UDELAY_TASK
   .config:3574:warning: symbol value 'n' invalid for STACK_MAX_DEFAULT_SIZE_MB
   .config:3759:warning: symbol value 'n' invalid for MMC_BLOCK_MINORS
   .config:3806:warning: symbol value 'n' invalid for SCSI_NCR53C8XX_SYNC
   .config:3894:warning: symbol value 'n' invalid for SERIAL_MCF_BAUDRATE
   .config:3936:warning: symbol value 'n' invalid for UCLAMP_BUCKETS_COUNT
   .config:3963:warning: symbol value 'n' invalid for X86_AMD_PSTATE_DEFAULT_MODE
   .config:3985:warning: symbol value 'n' invalid for DE2104X_DSL
   .config:3993:warning: symbol value 'n' invalid for BLK_DEV_RAM_COUNT
   .config:4233:warning: symbol value 'n' invalid for IP_VS_SH_TAB_BITS
   .config:4347:warning: symbol value 'n' invalid for SERIAL_ALTERA_UART_BAUDRATE
   .config:4385:warning: symbol value 'n' invalid for USBIP_VHCI_HC_PORTS
   .config:4492:warning: symbol value 'n' invalid for CMA_AREAS
   .config:4493:warning: symbol value 'n' invalid for DUMMY_CONSOLE_ROWS
   .config:4551:warning: symbol value 'n' invalid for INPUT_MOUSEDEV_SCREEN_X
   .config:4670:warning: symbol value 'n' invalid for RIONET_RX_SIZE
   .config:4736:warning: symbol value 'n' invalid for RADIO_TYPHOON_PORT
   .config:4854:warning: symbol value 'n' invalid for SERIAL_TXX9_NR_UARTS
   .config:4899:warning: symbol value 'n' invalid for MTRR_SANITIZER_SPARE_REG_NR_DEFAULT
   .config:5001:warning: symbol value 'n' invalid for IBM_EMAC_TXB
   .config:5148:warning: symbol value 'n' invalid for FTRACE_RECORD_RECURSION_SIZE
   .config:5510:warning: symbol value 'n' invalid for DRM_I915_FENCE_TIMEOUT
   .config:5532:warning: symbol value 'n' invalid for TTY_PRINTK_LEVEL
   .config:5585:warning: symbol value 'n' invalid for CRYPTO_DEV_FSL_CAAM_INTC_TIME_THLD
   .config:5701:warning: symbol value 'n' invalid for MIPS_EJTAG_FDC_KGDB_CHAN
   .config:5772:warning: symbol value 'n' invalid for PPC_EARLY_DEBUG_EHV_BC_HANDLE
   .config:5796:warning: symbol value 'n' invalid for KDB_DEFAULT_ENABLE
   .config:5816:warning: symbol value 'n' invalid for SERIAL_ALTERA_UART_MAXPORTS
   .config:5933:warning: symbol value 'n' invalid for IP_VS_MH_TAB_INDEX
   .config:6101:warning: symbol value 'n' invalid for PANEL_LCD_HWIDTH
   .config:6131:warning: symbol value 'n' invalid for LOCKDEP_CHAINS_BITS
   .config:6230:warning: symbol value 'n' invalid for DRM_I915_HEARTBEAT_INTERVAL
   .config:6236:warning: symbol value 'n' invalid for KCSAN_SKIP_WATCH
   .config:6244:warning: symbol value 'n' invalid for EFI_MAX_FAKE_MEM
   .config:6260:warning: symbol value 'n' invalid for PSTORE_BLK_KMSG_SIZE
   .config:6358:warning: symbol value 'n' invalid for PANEL_LCD_PIN_RW
   .config:6481:warning: symbol value 'n' invalid for SERIAL_8250_RUNTIME_UARTS
   .config:6517:warning: symbol value 'n' invalid for KVM_MAX_NR_VCPUS
   .config:6584:warning: symbol value 'n' invalid for ARCH_MMAP_RND_COMPAT_BITS
   .config:6633:warning: symbol value 'n' invalid for SERIAL_SH_SCI_NR_UARTS
   .config:6766:warning: symbol value 'n' invalid for RADIO_TRUST_PORT
   .config:6852:warning: symbol value 'n' invalid for SND_MAX_CARDS
   .config:7006:warning: symbol value 'n' invalid for RCU_BOOST_DELAY
   .config:7177:warning: symbol value 'n' invalid for DVB_MAX_ADAPTERS
   .config:7180:warning: symbol value 'n' invalid for SCSI_NCR53C8XX_MAX_TAGS
   .config:7187:warning: symbol value 'n' invalid for CMA_SIZE_PERCENTAGE
   .config:7213:warning: symbol value 'n' invalid for SCSI_SYM53C8XX_DMA_ADDRESSING_MODE
   .config:7257:warning: symbol value 'n' invalid for ZSMALLOC_CHAIN_SIZE
   .config:7354:warning: symbol value 'n' invalid for DRM_XE_TIMESLICE_MIN

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

