Return-Path: <bpf+bounces-6968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B4476FC54
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 10:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D1928253C
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 08:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67A59468;
	Fri,  4 Aug 2023 08:46:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99E0944C;
	Fri,  4 Aug 2023 08:46:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0543B49C9;
	Fri,  4 Aug 2023 01:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691138817; x=1722674817;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MAcJ299wo3k+KdBjVHFQ6R9T4MfMmRMDb+y4waGUqbo=;
  b=LefVT/ui/fcTxEHGAtBfJc9JfvF+3TLqfKlpkwiz/M3DTEV824QPerPR
   JI655C2TELcazqceBAyul369MdGg83zjXy6Z6DZN/Q+kEllZTlplkp1fu
   iqGA7E5NTTnuG5RtzLEu3USOgD/METFjG8dk6ZPye8wX6o+o+Y5HXtnNY
   wVRDw8Qgmhbn+IRcsrb0ikV8/yBu5j51b5yjvKbRAE7oUhKgPycQH67mb
   MhMgxFaTHrkN1e1oZjtwW8vh1t4i0pSGg72PBHhQq2jNPBp/thydDN6XR
   eLSjIBAbH+T2Lc9xjax82VQyI86m0oAqaeIdc6zc9JSBctn7I2KhEtZ4d
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="456478220"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="456478220"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 01:46:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="765017754"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="765017754"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by orsmga001.jf.intel.com with ESMTP; 04 Aug 2023 01:46:36 -0700
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
To: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Wong Vee Khee <veekhee@apple.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Revanth Kumar Uppala <ruppala@nvidia.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Andrey Konovalov <andrey.konovalov@linaro.org>,
	Jochen Henneberg <jh@henneberg-systemdesign.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	bpf@vger.kernel.org,
	Voon Wei Feng <weifeng.voon@intel.com>,
	Tan Tee Min <tee.min.tan@linux.intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	Lai Peter Jun Ann <jun.ann.lai@intel.com>
Subject: [PATCH net-next v2 0/5] TSN auto negotiation between 1G and 2.5G
Date: Fri,  4 Aug 2023 16:45:22 +0800
Message-Id: <20230804084527.2082302-1-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Intel platforms’ integrated Gigabit Ethernet controllers support
2.5Gbps mode statically using BIOS programming. In the current
implementation, the BIOS menu provides an option to select between
10/100/1000Mbps and 2.5Gbps modes. Based on the selection, the BIOS
programs the Phase Lock Loop (PLL) registers. The BIOS also read the
TSN lane registers from Flexible I/O Adapter (FIA) block and provided
10/100/1000Mbps/2.5Gbps information to the stmmac driver. But
auto-negotiation between 10/100/1000Mbps and 2.5Gbps is not allowed.
The new proposal is to support auto-negotiation between 10/100/1000Mbps
and 2.5Gbps . Auto-negotiation between 10, 100, 1000Mbps will use
in-band auto negotiation. Auto-negotiation between 10/100/1000Mbps and
2.5Gbps will work as the following proposed flow, the stmmac driver reads
the PHY link status registers then identifies the negotiated speed.
Based on the speed stmmac driver will identify TSN lane registers from
FIA then send IPC command to the Power Management controller (PMC)
through PMC driver/API. PMC will act as a proxy to programs the
PLL registers.

changelog:
v1 -> v2: 
 - Created intel_pmc_core.h in include/linux/platform_data/x86/ and
 export the desired functionality.
 - Add cur_link_an_mode to the kernel doc
 - Update cfg_link_an_mode value during phy driver changed
 - Combine 2 commits i.e. "stmmac: intel: Separate driver_data of ADL-N
 from TGL" and "net: stmmac: Add 1G/2.5G auto-negotiation
 support for ADL-N" into 1 commit.


v1 -> v2: 
 - Add static to pmc_lpm_modes declaration
 - Add cur_link_an_mode to the kernel doc
 - Combine 2 commits i.e. "stmmac: intel: Separate driver_data of ADL-N
 from TGL" and "net: stmmac: Add 1G/2.5G auto-negotiation
 support for ADL-N" into 1 commit.
---
Choong Yong Liang (1):
  stmmac: intel: Add 1G/2.5G auto-negotiation support for ADL-N

David E. Box (1):
  platform/x86: intel_pmc_core: Add IPC mailbox accessor function and
    add SoC register access

Tan, Tee Min (3):
  net: pcs: xpcs: combine C37 SGMII AN and 2500BASEX for Intel mGbE
    controller
  net: phy: update in-band AN mode when changing interface by PHY driver
  net: stmmac: enable Intel mGbE 1G/2.5G auto-negotiation support

 MAINTAINERS                                   |   1 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 183 +++++++++++++++++-
 .../net/ethernet/stmicro/stmmac/dwmac-intel.h |  81 ++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  20 ++
 drivers/net/pcs/pcs-xpcs.c                    |  72 +++++--
 drivers/net/phy/marvell10g.c                  |   6 +
 drivers/net/phy/phylink.c                     |   4 +
 drivers/platform/x86/intel/pmc/core.c         |  60 ++++++
 include/linux/pcs/pcs-xpcs.h                  |   1 +
 include/linux/phy.h                           |   3 +
 .../linux/platform_data/x86/intel_pmc_core.h  |  41 ++++
 include/linux/stmmac.h                        |   1 +
 13 files changed, 458 insertions(+), 16 deletions(-)
 create mode 100644 include/linux/platform_data/x86/intel_pmc_core.h

-- 
2.25.1


