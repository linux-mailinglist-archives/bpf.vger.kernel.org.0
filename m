Return-Path: <bpf+bounces-22057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A9B855959
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 04:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD731F2AD98
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 03:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA3A1B81A;
	Thu, 15 Feb 2024 03:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UYuhYYKR"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C68182DD;
	Thu, 15 Feb 2024 03:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966509; cv=none; b=DmucObqI0K7YyJK+FtGyeeVlWswSbwKUB1v3dQj1dy6rNS5gdy/tLz1p2nTzQl+telj0JsmFxU/QB846uTBd2bbYhmN8rON4oKYReKF+SLPJqMPoEN8mRYHKVI/Ru6nBfmM8dHsDXZo3uGhwHVXuYgMKkJ07Up1jWimb2Xru4dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966509; c=relaxed/simple;
	bh=fumAyhQKjC1W9BaMP5HdTDN5H3s/uIB2V97WkllaS/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dnxHJVPoqnB9Ek24SDdiO7pCLEUyFgNUffpoG1AyLvdS/A2hrTCi05krH0oWLtEXINdGmEZqOQzEbYO4VEKgZtn5a1StbHIkrfJ1ya8MXQn+vLoKMU9hyRk3Z26gOz+VHivQIajWCLJ/1h+BYPaBeOZFN3j/+g185kBr2kndzrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UYuhYYKR; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707966508; x=1739502508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fumAyhQKjC1W9BaMP5HdTDN5H3s/uIB2V97WkllaS/4=;
  b=UYuhYYKR9StN7zO0KXoPz+e6/DM5O1VS9d/MDi9COPIiYdJ/i6701N02
   JJ++DKk+IAyAKBKSr4HbLrmmFVsz4uuLWKf4o8+ZTeVO2AG9qd5mFr6o4
   xMwwjx0CI1PTIdrJnSXVk6JBBLpwAT6AMBtopo6dzGYfedP1ofL7noThv
   KzFgV68Zq6gGg9k1xpf8RPCqCBgLSCgEEaaCV8ZS6nnsfRaIFPMlJqhB0
   se8SrJmVx8d4hY0bPOWx01wvzXsCeRc+h4D/2IjgiXQdXhWUNrwGMwziJ
   vULdISOIPHb5R8bpLF6kLVgBIT8Yrj8E7w54JvbxSPvaXaOfpzdTxYx0G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19461394"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="19461394"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 19:08:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="3385830"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by fmviesa009.fm.intel.com with ESMTP; 14 Feb 2024 19:08:19 -0800
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
Subject: [PATCH net-next v5 7/9] stmmac: intel: configure SerDes according to the interface mode
Date: Thu, 15 Feb 2024 11:04:57 +0800
Message-Id: <20240215030500.3067426-8-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215030500.3067426-1-yong.liang.choong@linux.intel.com>
References: <20240215030500.3067426-1-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Tan, Tee Min" <tee.min.tan@linux.intel.com>

Intel platform will configure the SerDes through PMC api based on the
provided interface mode.

This patch adds several new functions below:-
- intel_tsn_interface_is_available(): This new function reads FIA lane
  ownership registers and common lane registers through IPC commands
  to know which lane the mGbE port is assigned to.
- intel_config_serdes(): To configure the SerDes based on the assigned
  lane and latest interface mode, it sends IPC command to the PMC through
  PMC driver/API. The PMC acts as a proxy for R/W on behalf of the driver.
- intel_set_reg_access(): Set the register access to the available TSN
  interface.

Signed-off-by: Tan, Tee Min <tee.min.tan@linux.intel.com>
Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   2 +
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 115 +++++++++++++++++-
 .../net/ethernet/stmicro/stmmac/dwmac-intel.h |  75 ++++++++++++
 3 files changed, 191 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 4ec61f1ee71a..25405c305a21 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -273,6 +273,8 @@ config DWMAC_INTEL
 	default X86
 	depends on X86 && STMMAC_ETH && PCI
 	depends on COMMON_CLK
+	depends on ACPI
+	select INTEL_PMC_IPC
 	help
 	  This selects the Intel platform specific bus support for the
 	  stmmac driver. This driver is used for Intel Quark/EHL/TGL.
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 6f12e80b8a05..74cc0aa96faf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -5,6 +5,7 @@
 #include <linux/clk-provider.h>
 #include <linux/pci.h>
 #include <linux/dmi.h>
+#include <linux/platform_data/x86/intel_pmc_ipc.h>
 #include "dwmac-intel.h"
 #include "dwmac4.h"
 #include "stmmac.h"
@@ -14,6 +15,9 @@ struct intel_priv_data {
 	int mdio_adhoc_addr;	/* mdio address for serdes & etc */
 	unsigned long crossts_adj;
 	bool is_pse;
+	const int *tsn_lane_registers;
+	int max_tsn_lane_registers;
+	int pid_modphy;
 };
 
 /* This struct is used to associate PCI Function of MAC controller on a board,
@@ -93,7 +97,7 @@ static int intel_serdes_powerup(struct net_device *ndev, void *priv_data)
 	data &= ~SERDES_RATE_MASK;
 	data &= ~SERDES_PCLK_MASK;
 
-	if (priv->plat->max_speed == 2500)
+	if (priv->plat->phy_interface == PHY_INTERFACE_MODE_2500BASEX)
 		data |= SERDES_RATE_PCIE_GEN2 << SERDES_RATE_PCIE_SHIFT |
 			SERDES_PCLK_37p5MHZ << SERDES_PCLK_SHIFT;
 	else
@@ -447,6 +451,103 @@ static unsigned int intel_get_pcs_neg_mode(phy_interface_t interface,
 	return neg_mode;
 }
 
+static bool intel_tsn_interface_is_available(struct net_device *ndev,
+					     struct intel_priv_data *intel_priv)
+{
+	struct stmmac_priv *priv = netdev_priv(ndev);
+	struct pmc_ipc_cmd tmp = {0};
+	u32 rbuf[4] = {0};
+	int ret, i, j;
+
+	if (priv->plat->serdes_powerup) {
+		tmp.cmd = IPC_SOC_REGISTER_ACCESS;
+		tmp.sub_cmd = IPC_SOC_SUB_CMD_READ;
+
+		for (i = 0; i < 5; i++) {
+			tmp.wbuf[0] = R_PCH_FIA_15_PCR_LOS1_REG_BASE + i;
+
+			ret = intel_pmc_ipc(&tmp, rbuf);
+			if (ret < 0) {
+				netdev_info(priv->dev,
+					    "Failed to read from PMC.\n");
+				return false;
+			}
+
+			for (j = 0; j <= intel_priv->max_tsn_lane_registers; j++)
+				if ((rbuf[0] >>
+				    (4 * (intel_priv->tsn_lane_registers[j] % 8)) &
+				     B_PCH_FIA_PCR_L0O) == 0xB)
+					return true;
+		}
+	}
+	return false;
+}
+
+static int intel_set_reg_access(const struct pmc_serdes_regs *regs, int max_regs)
+{
+	int ret = 0, i;
+
+	for (i = 0; i < max_regs; i++) {
+		struct pmc_ipc_cmd tmp = {0};
+		u32 buf[4] = {0};
+
+		tmp.cmd = IPC_SOC_REGISTER_ACCESS;
+		tmp.sub_cmd = IPC_SOC_SUB_CMD_WRITE;
+		tmp.wbuf[0] = (u32)regs[i].index;
+		tmp.wbuf[1] = regs[i].val;
+
+		ret = intel_pmc_ipc(&tmp, buf);
+		if (ret < 0)
+			return ret;
+	}
+
+	return ret;
+}
+
+static int intel_config_serdes(struct net_device *ndev,
+			       void *intel_data,
+			       phy_interface_t interface)
+{
+	struct intel_priv_data *intel_priv = intel_data;
+	struct stmmac_priv *priv = netdev_priv(ndev);
+	int ret = 0;
+
+	if (!intel_tsn_interface_is_available(ndev, intel_priv)) {
+		netdev_info(priv->dev,
+			    "No TSN interface available to set the registers.\n");
+		goto pmc_read_error;
+	}
+
+	if (intel_priv->pid_modphy == PID_MODPHY1) {
+		if (interface == PHY_INTERFACE_MODE_2500BASEX) {
+			ret = intel_set_reg_access(pid_modphy1_2p5g_regs,
+						   ARRAY_SIZE(pid_modphy1_2p5g_regs));
+		} else {
+			ret = intel_set_reg_access(pid_modphy1_1g_regs,
+						   ARRAY_SIZE(pid_modphy1_1g_regs));
+		}
+	} else {
+		if (interface == PHY_INTERFACE_MODE_2500BASEX) {
+			ret = intel_set_reg_access(pid_modphy3_2p5g_regs,
+						   ARRAY_SIZE(pid_modphy3_2p5g_regs));
+		} else {
+			ret = intel_set_reg_access(pid_modphy3_1g_regs,
+						   ARRAY_SIZE(pid_modphy3_1g_regs));
+		}
+	}
+
+	priv->plat->phy_interface = interface;
+
+	if (ret < 0)
+		goto pmc_read_error;
+
+pmc_read_error:
+	intel_serdes_powerdown(ndev, intel_priv);
+	intel_serdes_powerup(ndev, intel_priv);
+
+	return ret;
+}
+
 static void common_default_data(struct plat_stmmacenet_data *plat)
 {
 	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
@@ -622,6 +723,15 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 		plat->mdio_bus_data->xpcs_an_inband = true;
 	}
 
+	/* When the platform is able to switch between PHY_INTERFACE_MODE_SGMII
+	 * and PHY_INTERFACE_MODE_2500BASEX interfaces, we clear xpcs_an_inband
+	 * for PHY_INTERFACE_MODE_2500BASEX interface
+	 */
+	if (plat->phy_interface == PHY_INTERFACE_MODE_SGMII &&
+	    plat->max_speed == 2500) {
+		plat->mdio_bus_data->xpcs_an_inband = false;
+	}
+
 	/* For fixed-link setup, we clear xpcs_an_inband */
 	if (is_fixed_link(pdev))
 		plat->mdio_bus_data->xpcs_an_inband = false;
@@ -676,6 +786,7 @@ static int ehl_sgmii_data(struct pci_dev *pdev,
 	plat->serdes_powerup = intel_serdes_powerup;
 	plat->serdes_powerdown = intel_serdes_powerdown;
 	plat->get_pcs_neg_mode = intel_get_pcs_neg_mode;
+	plat->config_serdes = intel_config_serdes;
 	plat->clk_ptp_rate = 204800000;
 
 	return ehl_common_data(pdev, plat);
@@ -735,6 +846,7 @@ static int ehl_pse0_sgmii1g_data(struct pci_dev *pdev,
 	plat->serdes_powerup = intel_serdes_powerup;
 	plat->serdes_powerdown = intel_serdes_powerdown;
 	plat->get_pcs_neg_mode = intel_get_pcs_neg_mode;
+	plat->config_serdes = intel_config_serdes;
 	return ehl_pse0_common_data(pdev, plat);
 }
 
@@ -777,6 +889,7 @@ static int ehl_pse1_sgmii1g_data(struct pci_dev *pdev,
 	plat->serdes_powerup = intel_serdes_powerup;
 	plat->serdes_powerdown = intel_serdes_powerdown;
 	plat->get_pcs_neg_mode = intel_get_pcs_neg_mode;
+	plat->config_serdes = intel_config_serdes;
 	return ehl_pse1_common_data(pdev, plat);
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h
index 0a37987478c1..79c35ba969ea 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h
@@ -50,4 +50,79 @@
 #define PCH_PTP_CLK_FREQ_19_2MHZ	(GMAC_GPO0)
 #define PCH_PTP_CLK_FREQ_200MHZ		(0)
 
+#define	PID_MODPHY1 0xAA
+#define	PID_MODPHY3 0xA8
+
+#if IS_ENABLED(CONFIG_INTEL_PMC_IPC)
+struct pmc_serdes_regs {
+	u8 index;
+	u32 val;
+};
+
+/* Modphy Register index */
+#define R_PCH_FIA_15_PCR_LOS1_REG_BASE			8
+#define R_PCH_FIA_15_PCR_LOS2_REG_BASE			9
+#define R_PCH_FIA_15_PCR_LOS3_REG_BASE			10
+#define R_PCH_FIA_15_PCR_LOS4_REG_BASE			11
+#define R_PCH_FIA_15_PCR_LOS5_REG_BASE			12
+#define B_PCH_FIA_PCR_L0O				GENMASK(3, 0)
+#define PID_MODPHY1_B_MODPHY_PCR_LCPLL_DWORD0		13
+#define PID_MODPHY1_N_MODPHY_PCR_LCPLL_DWORD2		14
+#define PID_MODPHY1_N_MODPHY_PCR_LCPLL_DWORD7		15
+#define PID_MODPHY1_N_MODPHY_PCR_LPPLL_DWORD10		16
+#define PID_MODPHY1_N_MODPHY_PCR_CMN_ANA_DWORD30	17
+#define PID_MODPHY3_B_MODPHY_PCR_LCPLL_DWORD0		18
+#define PID_MODPHY3_N_MODPHY_PCR_LCPLL_DWORD2		19
+#define PID_MODPHY3_N_MODPHY_PCR_LCPLL_DWORD7		20
+#define PID_MODPHY3_N_MODPHY_PCR_LPPLL_DWORD10		21
+#define PID_MODPHY3_N_MODPHY_PCR_CMN_ANA_DWORD30	22
+
+#define B_MODPHY_PCR_LCPLL_DWORD0_1G		0x46AAAA41
+#define N_MODPHY_PCR_LCPLL_DWORD2_1G		0x00000139
+#define N_MODPHY_PCR_LCPLL_DWORD7_1G		0x002A0003
+#define N_MODPHY_PCR_LPPLL_DWORD10_1G		0x00170008
+#define N_MODPHY_PCR_CMN_ANA_DWORD30_1G		0x0000D4AC
+#define B_MODPHY_PCR_LCPLL_DWORD0_2P5G		0x58555551
+#define N_MODPHY_PCR_LCPLL_DWORD2_2P5G		0x0000012D
+#define N_MODPHY_PCR_LCPLL_DWORD7_2P5G		0x001F0003
+#define N_MODPHY_PCR_LPPLL_DWORD10_2P5G		0x00170008
+#define N_MODPHY_PCR_CMN_ANA_DWORD30_2P5G	0x8200ACAC
+
+static const struct pmc_serdes_regs pid_modphy3_1g_regs[] = {
+	{ PID_MODPHY3_B_MODPHY_PCR_LCPLL_DWORD0,	B_MODPHY_PCR_LCPLL_DWORD0_1G },
+	{ PID_MODPHY3_N_MODPHY_PCR_LCPLL_DWORD2,	N_MODPHY_PCR_LCPLL_DWORD2_1G },
+	{ PID_MODPHY3_N_MODPHY_PCR_LCPLL_DWORD7,	N_MODPHY_PCR_LCPLL_DWORD7_1G },
+	{ PID_MODPHY3_N_MODPHY_PCR_LPPLL_DWORD10,	N_MODPHY_PCR_LPPLL_DWORD10_1G },
+	{ PID_MODPHY3_N_MODPHY_PCR_CMN_ANA_DWORD30,	N_MODPHY_PCR_CMN_ANA_DWORD30_1G },
+	{}
+};
+
+static const struct pmc_serdes_regs pid_modphy3_2p5g_regs[] = {
+	{ PID_MODPHY3_B_MODPHY_PCR_LCPLL_DWORD0,	B_MODPHY_PCR_LCPLL_DWORD0_2P5G },
+	{ PID_MODPHY3_N_MODPHY_PCR_LCPLL_DWORD2,	N_MODPHY_PCR_LCPLL_DWORD2_2P5G },
+	{ PID_MODPHY3_N_MODPHY_PCR_LCPLL_DWORD7,	N_MODPHY_PCR_LCPLL_DWORD7_2P5G },
+	{ PID_MODPHY3_N_MODPHY_PCR_LPPLL_DWORD10,	N_MODPHY_PCR_LPPLL_DWORD10_2P5G },
+	{ PID_MODPHY3_N_MODPHY_PCR_CMN_ANA_DWORD30,	N_MODPHY_PCR_CMN_ANA_DWORD30_2P5G },
+	{}
+};
+
+static const struct pmc_serdes_regs pid_modphy1_1g_regs[] = {
+	{ PID_MODPHY1_B_MODPHY_PCR_LCPLL_DWORD0,	B_MODPHY_PCR_LCPLL_DWORD0_1G },
+	{ PID_MODPHY1_N_MODPHY_PCR_LCPLL_DWORD2,	N_MODPHY_PCR_LCPLL_DWORD2_1G },
+	{ PID_MODPHY1_N_MODPHY_PCR_LCPLL_DWORD7,	N_MODPHY_PCR_LCPLL_DWORD7_1G },
+	{ PID_MODPHY1_N_MODPHY_PCR_LPPLL_DWORD10,	N_MODPHY_PCR_LPPLL_DWORD10_1G },
+	{ PID_MODPHY1_N_MODPHY_PCR_CMN_ANA_DWORD30,	N_MODPHY_PCR_CMN_ANA_DWORD30_1G },
+	{}
+};
+
+static const struct pmc_serdes_regs pid_modphy1_2p5g_regs[] = {
+	{ PID_MODPHY1_B_MODPHY_PCR_LCPLL_DWORD0,	B_MODPHY_PCR_LCPLL_DWORD0_2P5G },
+	{ PID_MODPHY1_N_MODPHY_PCR_LCPLL_DWORD2,	N_MODPHY_PCR_LCPLL_DWORD2_2P5G },
+	{ PID_MODPHY1_N_MODPHY_PCR_LCPLL_DWORD7,	N_MODPHY_PCR_LCPLL_DWORD7_2P5G },
+	{ PID_MODPHY1_N_MODPHY_PCR_LPPLL_DWORD10,	N_MODPHY_PCR_LPPLL_DWORD10_2P5G },
+	{ PID_MODPHY1_N_MODPHY_PCR_CMN_ANA_DWORD30,	N_MODPHY_PCR_CMN_ANA_DWORD30_2P5G },
+	{}
+};
+#endif /* CONFIG_INTEL_PMC_IPC */
+
 #endif /* __DWMAC_INTEL_H__ */
-- 
2.34.1


