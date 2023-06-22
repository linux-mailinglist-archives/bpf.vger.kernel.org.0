Return-Path: <bpf+bounces-3100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE405739637
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 06:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3EDA2817EF
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 04:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886351FDF;
	Thu, 22 Jun 2023 04:19:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4852B1C02;
	Thu, 22 Jun 2023 04:19:44 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BA719C;
	Wed, 21 Jun 2023 21:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687407582; x=1718943582;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rKgnFurbdIRdoh4CHd4XKUen+Eh+ergId4ed9rxs1x8=;
  b=gj96WUnnBYTye/kmRrfT2ZVvXrLM1DUUXYOZQyYq6oV++xu0RFbgIXVM
   Z1l79ss+1h0KOQziz4jbh3O/VgPQjnp6JNLQOHCGre0jt+aYx71SrwlKR
   lgCaNfAmcchuHagP/0Zk53Z99bwN/wUD0YOaSIsd7bwF1HPR+8xnaEqyW
   j4wI8fWuAtxgLTdFg8j7em+3Q2C6x9/2X4qlbhZTurtxHBgTjwDD5tryC
   K1PcmEQ8BUOzGr0qFkk96Ss3AYgRyvb1tLLMmZlN0C9dzLvGnaiNHijiR
   FsCCJJJKkUTVEzUm4VmjiDgm8F8PuNj+zp7xmez5GzQKxDopNczzNOGIC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="363811732"
X-IronPort-AV: E=Sophos;i="6.00,262,1681196400"; 
   d="scan'208";a="363811732"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 21:19:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="744453724"
X-IronPort-AV: E=Sophos;i="6.00,262,1681196400"; 
   d="scan'208";a="744453724"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by orsmga008.jf.intel.com with ESMTP; 21 Jun 2023 21:19:27 -0700
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
To: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	bpf@vger.kernel.org, Voon Wei Feng <weifeng.voon@intel.com>,
	Tan@web.codeaurora.org, Tee Min <tee.min.tan@linux.intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	Lai Peter Jun Ann <jun.ann.lai@intel.com>
Subject: [PATCH net-next 0/6] TSN auto negotiation between 1G and 2.5G
Date: Thu, 22 Jun 2023 12:18:59 +0800
Message-Id: <20230622041905.629430-1-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
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

Choong Yong Liang (1):
  net: stmmac: Add 1G/2.5G auto-negotiation support for ADL-N

David E. Box (1):
  platform/x86: intel_pmc_core: Add IPC mailbox accessor function and
    add SoC register access

Michael Sit Wei Hong (1):
  stmmac: intel: Separate driver_data of ADL-N from TGL

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
 drivers/net/phy/phylink.c                     |   3 +
 drivers/platform/x86/intel/pmc/adl.c          |   2 +-
 drivers/platform/x86/intel/pmc/cnp.c          |   2 +-
 drivers/platform/x86/intel/pmc/core.c         |  63 +++++-
 drivers/platform/x86/intel/pmc/icl.c          |   2 +-
 drivers/platform/x86/intel/pmc/mtl.c          |   2 +-
 drivers/platform/x86/intel/pmc/spt.c          |   2 +-
 drivers/platform/x86/intel/pmc/tgl.c          |   2 +-
 .../core.h => include/linux/intel_pmc_core.h  |  27 ++-
 include/linux/pcs/pcs-xpcs.h                  |   1 +
 include/linux/phy.h                           |   2 +
 include/linux/stmmac.h                        |   1 +
 19 files changed, 449 insertions(+), 24 deletions(-)
 rename drivers/platform/x86/intel/pmc/core.h => include/linux/intel_pmc_core.h (95%)

-- 
2.25.1


