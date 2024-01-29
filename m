Return-Path: <bpf+bounces-20574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB68840601
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 14:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C80BEB2230E
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 13:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85956627F9;
	Mon, 29 Jan 2024 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XSNhTc4K"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0800612C1;
	Mon, 29 Jan 2024 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533510; cv=none; b=drIPFCHI/XrJrf0MIV7zjKesOrseFdC6+DAaaTIXievYEN6OqPwpKBRpaEDdW8OaUGcQR8pZYzG1VezC/yIJ9gsGrEKShht2b0hnLKlxiQ/3g501Osq18TUOXqeL4l50Yxql7kQ3qP2eEISwfW+uD0yFuZTWVgx5ztCJORrGsT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533510; c=relaxed/simple;
	bh=xyoHfqTNIOjnNDp1+5s08f5WV/yjrMhPn3StDt1Ourk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MqAFemFATLkY9FaeNqpzDk/ORh9PlNFhj7gR29iVxtRDvaH8VJ+7vLyBYBhUy0V0PtMsvFg1wFDT8yilsO6t/fRwfzo3Djro4XC9NwguyR7ByVvoEG+lcHiT+sSD6MZ0yzTnKsskQwY+Rlc3RC/BciWPPEE0/JEWM15239c1R8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XSNhTc4K; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706533508; x=1738069508;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xyoHfqTNIOjnNDp1+5s08f5WV/yjrMhPn3StDt1Ourk=;
  b=XSNhTc4KraK/Z1LJ2Cv3S2WiOqaZRp5IpPFGF8i4PZljXra0i3lCQI3I
   4ENCSHhTFbT2Tc3lReFmAR+2gOSGa9xiFKVO5MHVoMTL2VF8xSFSQ1tTG
   A7qM1E2PnNtcoQBy9eT5GwMhCAT7yiWkrDkvnDiIrhulsKyH5TDYg+Jhn
   njMOjndu6Txn9cf82XFntXIgNjJ937g0cp4ielavuvKJuYJN6m990Kuf/
   gV7pbwWcf10iusQUcCWusv9ewKVvgYVX9bnk8Rm58BW3wjuKncmU5kARw
   yQb+aLIfQi6LHAZEkXM1cEjmOqU5QOpx1ACSz+sztrVIXEyXRS+yDph/m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="21473130"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="21473130"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 05:05:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="907106700"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="907106700"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jan 2024 05:04:59 -0800
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
To: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
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
Cc: Andrew Halaney <ahalaney@redhat.com>,
	Simon Horman <simon.horman@corigine.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	bpf@vger.kernel.org,
	Voon Wei Feng <weifeng.voon@intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	Lai Peter Jun Ann <jun.ann.lai@intel.com>,
	Abdul Rahim Faizal <faizal.abdul.rahim@intel.com>
Subject: [PATCH net-next v4 00/11] Enable SGMII and 2500BASEX interface mode switching for Intel platforms
Date: Mon, 29 Jan 2024 21:02:42 +0800
Message-Id: <20240129130253.1400707-1-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Choong Yong Liang <yong.liang.choong@intel.com>

At the start of link initialization, the 'allow_switch_interface' flag is
set to true. Based on 'allow_switch_interface' flag, the interface mode is
configured to PHY_INTERFACE_MODE_NA within the 'phylink_validate_phy'
function. This setting allows all ethtool link modes that are supported and
advertised will be published. Then interface mode switching occurs based on
the selection of different link modes.

During the interface mode change, the 'phylink_major_config' function
will be triggered in phylink. The modification of the following functions
will be triggered to support the switching between SGMII and 2500BASEX
interfaces for the Intel platform.

- mac_get_pcs_neg_mode: A new function that selects the PCS negotiation
  mode according to the interface mode.
- mac_select_pcs: Destroys and creates a new PCS according to the
  interface mode.
- mac_finish: Configures the SerDes according to the interface mode.

With the above changes, the code will work as follows during the
interface mode change. The PCS and PCS negotiation mode will be selected
for PCS configuration according to the interface mode. Then, the MAC
driver will perform SerDes configuration on the 'mac_finish' based on the
interface mode. During the SerDes configuration, the selected interface
mode will identify TSN lane registers from FIA and then send IPC commands
to the Power Management Controller (PMC) through the PMC driver/API.
PMC will act as a proxy to program the PLL registers.

Change log:
v1 -> v2: 
 - Add static to pmc_lpm_modes declaration
 - Add cur_link_an_mode to the kernel doc
 - Combine 2 commits i.e. "stmmac: intel: Separate driver_data of ADL-N
 from TGL" and "net: stmmac: Add 1G/2.5G auto-negotiation
 support for ADL-N" into 1 commit.

v2 -> v3:
 - Create `pmc_ipc.c` file for `intel_pmc_ipc()` function and 
 allocate the file in `arch/x86/platform/intel/` directory.
 - Update phylink's AN mode during phy interface change and 
 not exposing phylink's AN mode into phylib.
 
 v3 -> v4:
 - Introduce `allow_switch_interface` flag to have all ethtool 
 link modes that are supported and advertised will be published.
 - Introduce `mac_get_pcs_neg_mode` function that selects the PCS 
 negotiation mode according to the interface mode.
 - Remove pcs-xpcs.c changes and handle pcs during `mac_select_pcs`
 function
 - Configure SerDes base on the interface on `mac_finish` function.

Choong Yong Liang (9):
  net: phylink: publish ethtool link modes that supported and advertised
  net: stmmac: provide allow_switch_interface flag
  net: phylink: provide mac_get_pcs_neg_mode() function
  net: phylink: add phylink_pcs_neg_mode() declaration into phylink.h
  net: stmmac: select PCS negotiation mode according to the interface
    mode
  net: stmmac: resetup XPCS according to the new interface mode
  net: stmmac: configure SerDes on mac_finish
  stmmac: intel: interface switching support for EHL platform
  stmmac: intel: interface switching support for ADL-N platform

David E. Box (1):
  arch: x86: Add IPC mailbox accessor function and add SoC register
    access

Tan, Tee Min (1):
  stmmac: intel: configure SerDes according to the interface mode

 MAINTAINERS                                   |   2 +
 arch/x86/Kconfig                              |   9 +
 arch/x86/platform/intel/Makefile              |   1 +
 arch/x86/platform/intel/pmc_ipc.c             |  75 ++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 233 ++++++++++++++++--
 .../net/ethernet/stmicro/stmmac/dwmac-intel.h |  81 ++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  48 +++-
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c |   7 +-
 drivers/net/phy/phylink.c                     |  30 ++-
 include/linux/phylink.h                       |   9 +
 .../linux/platform_data/x86/intel_pmc_ipc.h   |  34 +++
 include/linux/stmmac.h                        |   6 +
 14 files changed, 506 insertions(+), 32 deletions(-)
 create mode 100644 arch/x86/platform/intel/pmc_ipc.c
 create mode 100644 include/linux/platform_data/x86/intel_pmc_ipc.h

-- 
2.34.1


