Return-Path: <bpf+bounces-22049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FF7855922
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 04:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A30FFB28C49
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 03:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304044A15;
	Thu, 15 Feb 2024 03:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="heb5Zclc"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266841870;
	Thu, 15 Feb 2024 03:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966450; cv=none; b=nrbplWpLAeS3oB0zZYsGE07Qk4l9BdeKazPjeaGqadsn3zilxZgN3ci35wtoxJnJLKfzcYpPAcjFzvIOZEbZCm+DErN26x9FnaaX9zyizNdPCAD4wxyh/0IZRDuLRiyxPUSQxbt996Qu3elL7Y4cFgIiF2Tv6QkZ8zOJojfAO3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966450; c=relaxed/simple;
	bh=qwwasO+1xBKjEezC6aXWqJJmEG8jQepQBuZ9KNK5I8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RKehzgzwOshpO00cl4Ct58VMa6Tt20Ge51ZfXi1gahESQaQyYp74+GCIskN/W3ck7f6LwI7LQCygDW/0oOyuRQsB+iJbll/mnNL7+azK9YvulOgs02SLeqaus+IxMogySsDEGY+Hy34mn98ymw0b4WeH2kj347obGCKkT/E54bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=heb5Zclc; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707966450; x=1739502450;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qwwasO+1xBKjEezC6aXWqJJmEG8jQepQBuZ9KNK5I8Y=;
  b=heb5ZclcVvK5Havye35ORgU/HuR1tlGUYPHV9B7NPewpumBoEIBGWKRf
   Yus6w3PNaTnWaXlrUOod08VjgnDaoA93ig4cGaoOv5Z/c7JcY2JNguwC7
   kjRB2DXhlngi/7H9F8eu1ABKkFVgiQE9jkH1zkr83s5do2GnpXS0C+7lw
   kF0/XzfKM/Z0nU+P8pUGJNWbSGYdCuBZAJj2dGPNcYRuYUzh/pwa/BL4O
   A5NCjC+c1JAdfDmqxJim1nAaE9MEB3Tx0NK2n9dacQjCeCSoFY8QpQDqu
   n5jDDJxusdaLTBfrqjR/3ot+5Gx9reUO5VsP3Dfj2jL3krr20cUypzvtM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19461201"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="19461201"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 19:07:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="3385643"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by fmviesa009.fm.intel.com with ESMTP; 14 Feb 2024 19:07:21 -0800
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
Subject: [PATCH net-next v5 0/9] Enable SGMII and 2500BASEX interface mode switching for Intel platforms
Date: Thu, 15 Feb 2024 11:04:50 +0800
Message-Id: <20240215030500.3067426-1-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: root <root@YongLiang-Ubuntu20-iLBPG12.png.intel.com>

During the interface mode change, the 'phylink_major_config' function
will be triggered in phylink. The modification of the following functions
will be triggered to support the switching between SGMII and 2500BASEX
interfaces mode for the Intel platform.

- mac_get_pcs_neg_mode: A new function that selects the PCS negotiation
  mode according to the interface mode.
- xpcs_do_config: Re-initiate clause 37 auto-negotiation for SGMII interface
  mode to perform auto-negotiation.
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
 
 v4 -> v5:
 - remove 'allow_switch_interface' related patches.
 - remove 'mac_select_pcs' related patches.
 - add a soft reset according to XPCS datasheet for re-initiate Clause 37
 auto-negotiation when switching to SGMII interface mode.

Choong Yong Liang (7):
  net: phylink: provide mac_get_pcs_neg_mode() function
  net: phylink: add phylink_pcs_neg_mode() declaration into phylink.h
  net: stmmac: select PCS negotiation mode according to the interface
    mode
  net: pcs: xpcs: re-initiate clause 37 Auto-negotiation
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
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   2 +
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 233 ++++++++++++++++--
 .../net/ethernet/stmicro/stmmac/dwmac-intel.h |  81 ++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  30 +++
 drivers/net/pcs/pcs-xpcs.c                    |  62 ++++-
 drivers/net/phy/phylink.c                     |  21 +-
 include/linux/phylink.h                       |   8 +
 .../linux/platform_data/x86/intel_pmc_ipc.h   |  34 +++
 include/linux/stmmac.h                        |   5 +
 13 files changed, 538 insertions(+), 25 deletions(-)
 create mode 100644 arch/x86/platform/intel/pmc_ipc.c
 create mode 100644 include/linux/platform_data/x86/intel_pmc_ipc.h

-- 
2.34.1


