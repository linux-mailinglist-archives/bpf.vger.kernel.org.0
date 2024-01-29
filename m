Return-Path: <bpf+bounces-20584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99991840638
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 14:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0621C23CBC
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 13:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A1165BAB;
	Mon, 29 Jan 2024 13:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JmmQfSo/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B866313F;
	Mon, 29 Jan 2024 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533579; cv=none; b=fa8SjKXNhN/VS7fb7FqJVEzPAnw69xCfseFHtHbSetupp4OqqQQQoI5+Snh891aZiIIkBXSDq8rUApHQOlvFsqW0oJKULrwFd1re/rg5evHhkXHt7wrGbXpN4UfnCmkh4V7BlC4zAdzzxtxiOwFxoCxEx+3UT4mrLaVsDM9hAIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533579; c=relaxed/simple;
	bh=4V+EHs1p9HyKhWN7K3Svxl9CZMQvX/gkngKTp0RS5nY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IOFrBPLRvnQTjFSY5VV9RMngBuPQQTcMzgk4u142nOWOPOY6rFcIsUYzUMmW06Dc0CjpxodlQFYNvenGGciUV881fXdCn7UUrFDg+4mk3EjA/pdv7P6Gwanr8ElvnfSqCFUWOXNw8ZcRSCdOEHaMtgOBBQTAYcqT6ex4UGDi+7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JmmQfSo/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706533578; x=1738069578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4V+EHs1p9HyKhWN7K3Svxl9CZMQvX/gkngKTp0RS5nY=;
  b=JmmQfSo/DBSad/Ww11COuJA2pQlNf/Lt1b/eAM2itG1RVYQl7RXWWXE7
   uBsICmu30Qo6HqdO2ERclhnyU1+XeLY0/qxCo6xFhPU5fPPZvYovj8s/H
   qHbFX1anuX5Pq+jUeuwJZmmadUeJ4GBX/kq+h8sTC68HQz3kP0hEOb839
   2HJIRWtqME1C6NHG/8dVQq90B0mDx/qFzZjs4qWuf2Mm9g8W0wVrAP9Yo
   uExrTkuQ5Po6UEZSDRdW2AhXJoD9znGLn09RULDIZs5ET2Y2XpHkEHs6V
   7bjgniO2qplKCx0zZzXg0FFtGN5LwPatLbIJB+DdHZ5R86JCbS+iB02zY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="21473603"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="21473603"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 05:06:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="907106860"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="907106860"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jan 2024 05:06:09 -0800
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
Subject: [PATCH net-next v4 08/11] stmmac: intel: configure SerDes according to the interface mode
Date: Mon, 29 Jan 2024 21:02:50 +0800
Message-Id: <20240129130253.1400707-9-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129130253.1400707-1-yong.liang.choong@linux.intel.com>
References: <20240129130253.1400707-1-yong.liang.choong@linux.intel.com>
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
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 113 +++++++++++++++++-
 .../net/ethernet/stmicro/stmmac/dwmac-intel.h |  75 ++++++++++++
 3 files changed, 188 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 85dcda51df05..be423fb2b46c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -273,6 +273,7 @@ config DWMAC_INTEL
 	default X86
 	depends on X86 && STMMAC_ETH && PCI
 	depends on COMMON_CLK
+	select INTEL_PMC_IPC
 	help
 	  This selects the Intel platform specific bus support for the
 	  stmmac driver. This driver is used for Intel Quark/EHL/TGL.
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 5110af776c8f..ddd96b18ce87 100644
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
@@ -622,6 +723,16 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 		plat->mdio_bus_data->xpcs_an_inband = true;
 	}
 
+	/* When the platform is able to switch between PHY_INTERFACE_MODE_SGMII
+	 * and PHY_INTERFACE_MODE_2500BASEX interfaces, we clear xpcs_an_inband
+	 * for PHY_INTERFACE_MODE_2500BASEX interface
+	 */
+	if (plat->phy_interface == PHY_INTERFACE_MODE_SGMII &&
+	    plat->max_speed == 2500) {
+		plat->mdio_bus_data->xpcs_an_inband = false;
+		plat->mdio_bus_data->allow_switch_interface = true;
+	}
+
 	/* For fixed-link setup, we clear xpcs_an_inband */
 	if (is_fixed_link(pdev))
 		plat->mdio_bus_data->xpcs_an_inband = false;
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


