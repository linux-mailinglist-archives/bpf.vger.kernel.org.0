Return-Path: <bpf+bounces-10537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 401E47A98E9
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 947DAB20F77
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 17:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE98B16439;
	Thu, 21 Sep 2023 17:22:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BEC1DDC2;
	Thu, 21 Sep 2023 17:22:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E14154903;
	Thu, 21 Sep 2023 10:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695316629; x=1726852629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UKg+X6Op5cASxXwGUeFtTyF/wDyM/yKi1ZuAir9nXgg=;
  b=P51JNEHwKo6mppy3GG5ZE2goYqd8JI/hbgjJYpTidMJZ+OK03CreTy2Z
   VP1le3IG+Ho7SOl9tl22dLu5Nt+ehnqBXeeQ1WIcTg+jE2ZJeFeGGIz6j
   fQhgbh0v0ASvUp6TwfFAlAUcldlZ1Qk/n9Z0tVMbUauciz866Ffrw0aZc
   yhcKeikvhGDRU/H0T93/Y47kbm32yY9JsA8BX9Ts5rdS5uFiMKjnRz9ql
   Zf0fM0GDJFxNWfiQnuA91CSlT3b4dQjwIA7PJyCADHBQNBfpLdf9a21v2
   FyUUs+URmxHEZWe/25+cO/fmi4rr2TOAQrOjg99EKX+TQvmiF695Hr6Fa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="444608334"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="444608334"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 05:21:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="862442052"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="862442052"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by fmsmga002.fm.intel.com with ESMTP; 21 Sep 2023 05:21:00 -0700
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
Subject: [PATCH net-next v3 4/5] net: stmmac: enable Intel mGbE 1G/2.5G auto-negotiation support
Date: Thu, 21 Sep 2023 20:19:45 +0800
Message-Id: <20230921121946.3025771-5-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230921121946.3025771-1-yong.liang.choong@linux.intel.com>
References: <20230921121946.3025771-1-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: "Tan, Tee Min" <tee.min.tan@linux.intel.com>

Initially, Intel mGbE was only able to configure the overclocking of 2.5
times clock rate to enable 2.5Gbps in the BIOS during boot time. Kernel
driver had no access to modify the clock rate for 1G/2.5G mode at runtime.

Now, this patch enables the runtime 1G/2.5G auto-negotiation support to
gets rid of the dependency on BIOS to change the 1G/2.5G clock rate.

This patch adds several new functions below:-
- intel_tsn_interface_is_available(): This new function reads FIA lane
  ownership registers and common lane registers through IPC commands
  to know which lane the mGbE port is assigned to.
- stmmac_mac_prepare(): To obtain the latest PHY interface from phylink
  during initialization and call intel_config_serdes() to proceed with
  SERDES configuration.
- intel_config_serdes(): To configure the SERDES based on the assigned
  lane and latest PHY interface, it sends IPC command to the PMC through
  PMC driver/API. The PMC acts as a proxy for R/W on behalf of the driver.
- intel_set_reg_access(): Set the register access to the available TSN
  interface.

Signed-off-by: Tan, Tee Min <tee.min.tan@linux.intel.com>
Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 134 +++++++++++++++++-
 .../net/ethernet/stmicro/stmmac/dwmac-intel.h |  79 +++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  20 +++
 include/linux/stmmac.h                        |   1 +
 5 files changed, 231 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index a2b9e289aa36..4340efd9bd50 100644
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
index a3a249c63598..a211f42914a2 100644
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
@@ -414,6 +418,106 @@ static void intel_mgbe_pse_crossts_adj(struct intel_priv_data *intel_priv,
 	}
 }
 
+#if IS_ENABLED(CONFIG_INTEL_PMC_IPC)
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
+static int intel_config_serdes(struct net_device *ndev, void *intel_data)
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
+		if (priv->plat->phy_interface == PHY_INTERFACE_MODE_2500BASEX) {
+			ret = intel_set_reg_access(pid_modphy1_2p5g_regs,
+						   ARRAY_SIZE(pid_modphy1_2p5g_regs));
+		} else {
+			ret = intel_set_reg_access(pid_modphy1_1g_regs,
+						   ARRAY_SIZE(pid_modphy1_1g_regs));
+		}
+	} else {
+		if (priv->plat->phy_interface == PHY_INTERFACE_MODE_2500BASEX) {
+			ret = intel_set_reg_access(pid_modphy3_2p5g_regs,
+						   ARRAY_SIZE(pid_modphy3_2p5g_regs));
+		} else {
+			ret = intel_set_reg_access(pid_modphy3_1g_regs,
+						   ARRAY_SIZE(pid_modphy3_1g_regs));
+		}
+	}
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
+#else
+static int intel_config_serdes(struct net_device *ndev, void *intel_data)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_INTEL_PMC_IPC */
+
 static void common_default_data(struct plat_stmmacenet_data *plat)
 {
 	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
@@ -624,6 +728,8 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 static int ehl_common_data(struct pci_dev *pdev,
 			   struct plat_stmmacenet_data *plat)
 {
+	struct intel_priv_data *intel_priv = plat->bsp_priv;
+
 	plat->rx_queues_to_use = 8;
 	plat->tx_queues_to_use = 8;
 	plat->flags |= STMMAC_FLAG_USE_PHY_WOL;
@@ -639,20 +745,28 @@ static int ehl_common_data(struct pci_dev *pdev,
 	plat->safety_feat_cfg->prtyen = 0;
 	plat->safety_feat_cfg->tmouten = 0;
 
+	intel_priv->tsn_lane_registers = ehl_tsn_lane_registers;
+	intel_priv->max_tsn_lane_registers = ARRAY_SIZE(ehl_tsn_lane_registers);
+
 	return intel_mgbe_common_data(pdev, plat);
 }
 
 static int ehl_sgmii_data(struct pci_dev *pdev,
 			  struct plat_stmmacenet_data *plat)
 {
+	struct intel_priv_data *intel_priv = plat->bsp_priv;
+
 	plat->bus_id = 1;
 	plat->phy_interface = PHY_INTERFACE_MODE_SGMII;
-	plat->speed_mode_2500 = intel_speed_mode_2500;
+	plat->max_speed = SPEED_2500;
 	plat->serdes_powerup = intel_serdes_powerup;
 	plat->serdes_powerdown = intel_serdes_powerdown;
+	plat->config_serdes = intel_config_serdes;
 
 	plat->clk_ptp_rate = 204800000;
 
+	intel_priv->pid_modphy = PID_MODPHY3;
+
 	return ehl_common_data(pdev, plat);
 }
 
@@ -705,10 +819,16 @@ static struct stmmac_pci_info ehl_pse0_rgmii1g_info = {
 static int ehl_pse0_sgmii1g_data(struct pci_dev *pdev,
 				 struct plat_stmmacenet_data *plat)
 {
+	struct intel_priv_data *intel_priv = plat->bsp_priv;
+
 	plat->phy_interface = PHY_INTERFACE_MODE_SGMII;
-	plat->speed_mode_2500 = intel_speed_mode_2500;
+	plat->max_speed = SPEED_2500;
 	plat->serdes_powerup = intel_serdes_powerup;
 	plat->serdes_powerdown = intel_serdes_powerdown;
+	plat->config_serdes = intel_config_serdes;
+
+	intel_priv->pid_modphy = PID_MODPHY1;
+
 	return ehl_pse0_common_data(pdev, plat);
 }
 
@@ -746,10 +866,16 @@ static struct stmmac_pci_info ehl_pse1_rgmii1g_info = {
 static int ehl_pse1_sgmii1g_data(struct pci_dev *pdev,
 				 struct plat_stmmacenet_data *plat)
 {
+	struct intel_priv_data *intel_priv = plat->bsp_priv;
+
 	plat->phy_interface = PHY_INTERFACE_MODE_SGMII;
-	plat->speed_mode_2500 = intel_speed_mode_2500;
+	plat->max_speed = SPEED_2500;
 	plat->serdes_powerup = intel_serdes_powerup;
 	plat->serdes_powerdown = intel_serdes_powerdown;
+	plat->config_serdes = intel_config_serdes;
+
+	intel_priv->pid_modphy = PID_MODPHY1;
+
 	return ehl_pse1_common_data(pdev, plat);
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h
index 0a37987478c1..093eed977ab0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h
@@ -50,4 +50,83 @@
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
+
+static const int ehl_tsn_lane_registers[] = {7, 8, 9, 10, 11};
+#else
+static const int ehl_tsn_lane_registers[] = {};
+#endif /* CONFIG_INTEL_PMC_IPC */
+
 #endif /* __DWMAC_INTEL_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9201ed778ebc..75765cf52cd1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1103,11 +1103,31 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 		stmmac_hwtstamp_correct_latency(priv, priv);
 }
 
+#if IS_ENABLED(CONFIG_INTEL_PMC_IPC)
+static int stmmac_mac_prepare(struct phylink_config *config, unsigned int mode,
+			      phy_interface_t interface)
+{
+	struct net_device *ndev = to_net_dev(config->dev);
+	struct stmmac_priv *priv = netdev_priv(ndev);
+	int ret = 0;
+
+	priv->plat->phy_interface = interface;
+
+	if (priv->plat->config_serdes)
+		ret = priv->plat->config_serdes(ndev, priv->plat->bsp_priv);
+
+	return ret;
+}
+#endif
+
 static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
 	.mac_select_pcs = stmmac_mac_select_pcs,
 	.mac_config = stmmac_mac_config,
 	.mac_link_down = stmmac_mac_link_down,
 	.mac_link_up = stmmac_mac_link_up,
+#if IS_ENABLED(CONFIG_INTEL_PMC_IPC)
+	.mac_prepare = stmmac_mac_prepare,
+#endif
 };
 
 /**
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index c0079a7574ae..aa7d4d96391c 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -275,6 +275,7 @@ struct plat_stmmacenet_data {
 	int (*serdes_powerup)(struct net_device *ndev, void *priv);
 	void (*serdes_powerdown)(struct net_device *ndev, void *priv);
 	void (*speed_mode_2500)(struct net_device *ndev, void *priv);
+	int (*config_serdes)(struct net_device *ndev, void *priv);
 	void (*ptp_clk_freq_config)(struct stmmac_priv *priv);
 	int (*init)(struct platform_device *pdev, void *priv);
 	void (*exit)(struct platform_device *pdev, void *priv);
-- 
2.25.1


