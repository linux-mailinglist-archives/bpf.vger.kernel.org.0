Return-Path: <bpf+bounces-10539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FA17A98EF
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 20:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCFB51F21223
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 18:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C8F42BF1;
	Thu, 21 Sep 2023 17:22:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E6E3F4B1;
	Thu, 21 Sep 2023 17:22:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B23551F54;
	Thu, 21 Sep 2023 10:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695316619; x=1726852619;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6hzWF6t3usS5DT5I810V3jYMFYBjf/9WntyNrqaTQuo=;
  b=bJ2vQwqqvZUSlPQef5CO7qJl7hpl60lcNGbtiepil+vDOyE23iqnsvjZ
   H7zkCcVHvqSwcypLhDNlwLZ54wSS1+8xJfjNzdE1vXSYvsfSRkxVh34eM
   O2Cngk1Rgx4fPh3dw1G6aisXoiElqyZGzi2EVbLpbduE02b+LXisOuUQk
   IMYrjpOJLF0ns1TO3cDk0t4xUPYqLcwEMwZH25mCgNbn/ldbS9XjVXnFc
   OWSUyOhYUuGfxhfY5nsDskRSA/VnF9VW4SWmOeylepvNlHL0GowqnPRM7
   GmS0AO9h/cctYPyXDZ5THol3YJtVszkXIap6NGeW+S5yPfh+m7IZohWaE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="444608109"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="444608109"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 05:20:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="862441612"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="862441612"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by fmsmga002.fm.intel.com with ESMTP; 21 Sep 2023 05:20:13 -0700
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
Cc: David E Box <david.e.box@intel.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Simon Horman <simon.horman@corigine.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	netdev@vger.kernel.org,
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
Subject: [PATCH net-next v3 0/5] TSN auto negotiation between 1G and 2.5G
Date: Thu, 21 Sep 2023 20:19:41 +0800
Message-Id: <20230921121946.3025771-1-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
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

---

Choong Yong Liang (2):
  net: phy: update in-band AN mode when changing interface by PHY driver
  stmmac: intel: Add 1G/2.5G auto-negotiation support for ADL-N

David E. Box (1):
  arch: x86: Add IPC mailbox accessor function and add SoC register
    access

Tan, Tee Min (2):
  net: pcs: xpcs: combine C37 SGMII AN and 2500BASEX for Intel mGbE
    controller
  net: stmmac: enable Intel mGbE 1G/2.5G auto-negotiation support

 MAINTAINERS                                   |   2 +
 arch/x86/Kconfig                              |   9 +
 arch/x86/platform/intel/Makefile              |   1 +
 arch/x86/platform/intel/pmc_ipc.c             |  75 +++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 183 +++++++++++++++++-
 .../net/ethernet/stmicro/stmmac/dwmac-intel.h |  81 ++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  20 ++
 drivers/net/pcs/pcs-xpcs.c                    |  72 +++++--
 drivers/net/phy/phylink.c                     |  30 ++-
 include/linux/pcs/pcs-xpcs.h                  |   1 +
 .../linux/platform_data/x86/intel_pmc_ipc.h   |  34 ++++
 include/linux/stmmac.h                        |   1 +
 13 files changed, 493 insertions(+), 17 deletions(-)
 create mode 100644 arch/x86/platform/intel/pmc_ipc.c
 create mode 100644 include/linux/platform_data/x86/intel_pmc_ipc.h

-- 
2.25.1


