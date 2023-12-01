Return-Path: <bpf+bounces-16348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD76800366
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 06:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3186B1C20FE4
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 05:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E00BE5C;
	Fri,  1 Dec 2023 05:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l2dbkrha"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40749173F;
	Thu, 30 Nov 2023 21:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701410010; x=1732946010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=745PEhhMTv2nUH952q0oJw2I4MN8WiAR7IlL3H79p04=;
  b=l2dbkrhae1Sj5w7uILJrP7oFAAMSs4IjNRLWTpvodldR4mKh4oWSN79F
   ySzEI+b+sNtN4RYrLUnAS35y0N+uCMDDFL+t/qk4XFFq/wRiqWVjcx+Z+
   K0xaGCRPrF9o5fegy51WUL278fZlyGuvEo1gog9ul60rbQRCFVqHMRcAk
   xgJs/ZCOEV0Bzb4HOI374yF7gOUpYLJWli0bLIsmKNC9El+rLDI8kgh7g
   QPLRudJmeYrphXOG/bL3A4VFyS+xyC6HqEzP+iYcOeh7C19xHbbCCd3N9
   fgaoMfsfi+PG0rP6UYY2YRujsmnz2uzFMO9OigzODGc2DGTZ6KlauRxwF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="373624030"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="373624030"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 21:53:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="763004560"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="763004560"
Received: from ppgyli0104.png.intel.com ([10.126.160.64])
  by orsmga007.jf.intel.com with ESMTP; 30 Nov 2023 21:53:22 -0800
From: Rohan G Thomas <rohan.g.thomas@intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Rohan G Thomas <rohan.g.thomas@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v2 2/3] net: stmmac: Refactor EST implementation
Date: Fri,  1 Dec 2023 13:52:51 +0800
Message-Id: <20231201055252.1302-3-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20231201055252.1302-1-rohan.g.thomas@intel.com>
References: <20231201055252.1302-1-rohan.g.thomas@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor EST implementation by moving common code for DWMAC4 and
DWXGMAC IPs into a separate EST module. EST implementation for DWMAC4
and DWXGMAC differs only for CSR base address, PTOV field offset
width, and PTOV clock multiplier value.

Thanks, Serge Semin and Jakub Kicinski for the suggestions on
refactoring EST implementation into a separate EST module.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |   4 -
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c  | 137 ---------------
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |  51 ------
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  43 -----
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 143 ---------------
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  21 +++
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  22 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   1 +
 .../net/ethernet/stmicro/stmmac/stmmac_est.c  | 165 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_est.h  |  64 +++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  |   4 +-
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |   4 +-
 15 files changed, 272 insertions(+), 392 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_est.h

diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index 80e598bd4255..26cad4344701 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -6,7 +6,7 @@ stmmac-objs:= stmmac_main.o stmmac_ethtool.o stmmac_mdio.o ring_mode.o	\
 	      mmc_core.o stmmac_hwtstamp.o stmmac_ptp.o dwmac4_descs.o	\
 	      dwmac4_dma.o dwmac4_lib.o dwmac4_core.o dwmac5.o hwif.o \
 	      stmmac_tc.o dwxgmac2_core.o dwxgmac2_dma.o dwxgmac2_descs.o \
-	      stmmac_xdp.o \
+	      stmmac_xdp.o stmmac_est.o \
 	      $(stmmac-y)
 
 stmmac-$(CONFIG_STMMAC_SELFTESTS) += stmmac_selftests.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 6b935922054d..721c1f8e892f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -563,6 +563,7 @@ struct mac_device_info {
 	const struct stmmac_hwtimestamp *ptp;
 	const struct stmmac_tc_ops *tc;
 	const struct stmmac_mmc_ops *mmc;
+	const struct stmmac_est_ops *est;
 	struct dw_xpcs *xpcs;
 	struct phylink_pcs *lynx_pcs; /* Lynx external PCS */
 	struct mii_regs mii;	/* MII register Addresses */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 5f35faf90963..6b6d0de09619 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -1247,8 +1247,6 @@ const struct stmmac_ops dwmac410_ops = {
 	.set_arp_offload = dwmac4_set_arp_offload,
 	.config_l3_filter = dwmac4_config_l3_filter,
 	.config_l4_filter = dwmac4_config_l4_filter,
-	.est_configure = dwmac5_est_configure,
-	.est_irq_status = dwmac5_est_irq_status,
 	.fpe_configure = dwmac5_fpe_configure,
 	.fpe_send_mpacket = dwmac5_fpe_send_mpacket,
 	.fpe_irq_status = dwmac5_fpe_irq_status,
@@ -1302,8 +1300,6 @@ const struct stmmac_ops dwmac510_ops = {
 	.set_arp_offload = dwmac4_set_arp_offload,
 	.config_l3_filter = dwmac4_config_l3_filter,
 	.config_l4_filter = dwmac4_config_l4_filter,
-	.est_configure = dwmac5_est_configure,
-	.est_irq_status = dwmac5_est_irq_status,
 	.fpe_configure = dwmac5_fpe_configure,
 	.fpe_send_mpacket = dwmac5_fpe_send_mpacket,
 	.fpe_irq_status = dwmac5_fpe_irq_status,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
index e95d35f1e5a0..ea92650f5c97 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -573,143 +573,6 @@ int dwmac5_flex_pps_config(void __iomem *ioaddr, int index,
 	return 0;
 }
 
-static int dwmac5_est_write(void __iomem *ioaddr, u32 reg, u32 val, bool gcl)
-{
-	u32 ctrl;
-
-	writel(val, ioaddr + MTL_EST_GCL_DATA);
-
-	ctrl = (reg << ADDR_SHIFT);
-	ctrl |= gcl ? 0 : GCRR;
-
-	writel(ctrl, ioaddr + MTL_EST_GCL_CONTROL);
-
-	ctrl |= SRWO;
-	writel(ctrl, ioaddr + MTL_EST_GCL_CONTROL);
-
-	return readl_poll_timeout(ioaddr + MTL_EST_GCL_CONTROL,
-				  ctrl, !(ctrl & SRWO), 100, 5000);
-}
-
-int dwmac5_est_configure(void __iomem *ioaddr, struct stmmac_est *cfg,
-			 unsigned int ptp_rate)
-{
-	int i, ret = 0x0;
-	u32 ctrl;
-
-	ret |= dwmac5_est_write(ioaddr, BTR_LOW, cfg->btr[0], false);
-	ret |= dwmac5_est_write(ioaddr, BTR_HIGH, cfg->btr[1], false);
-	ret |= dwmac5_est_write(ioaddr, TER, cfg->ter, false);
-	ret |= dwmac5_est_write(ioaddr, LLR, cfg->gcl_size, false);
-	ret |= dwmac5_est_write(ioaddr, CTR_LOW, cfg->ctr[0], false);
-	ret |= dwmac5_est_write(ioaddr, CTR_HIGH, cfg->ctr[1], false);
-	if (ret)
-		return ret;
-
-	for (i = 0; i < cfg->gcl_size; i++) {
-		ret = dwmac5_est_write(ioaddr, i, cfg->gcl[i], true);
-		if (ret)
-			return ret;
-	}
-
-	ctrl = readl(ioaddr + MTL_EST_CONTROL);
-	ctrl &= ~PTOV;
-	ctrl |= ((1000000000 / ptp_rate) * 6) << PTOV_SHIFT;
-	if (cfg->enable)
-		ctrl |= EEST | SSWL;
-	else
-		ctrl &= ~EEST;
-
-	writel(ctrl, ioaddr + MTL_EST_CONTROL);
-
-	/* Configure EST interrupt */
-	if (cfg->enable)
-		ctrl = (IECGCE | IEHS | IEHF | IEBE | IECC);
-	else
-		ctrl = 0;
-
-	writel(ctrl, ioaddr + MTL_EST_INT_EN);
-
-	return 0;
-}
-
-void dwmac5_est_irq_status(void __iomem *ioaddr, struct net_device *dev,
-			  struct stmmac_extra_stats *x, u32 txqcnt)
-{
-	u32 status, value, feqn, hbfq, hbfs, btrl;
-	u32 txqcnt_mask = (1 << txqcnt) - 1;
-
-	status = readl(ioaddr + MTL_EST_STATUS);
-
-	value = (CGCE | HLBS | HLBF | BTRE | SWLC);
-
-	/* Return if there is no error */
-	if (!(status & value))
-		return;
-
-	if (status & CGCE) {
-		/* Clear Interrupt */
-		writel(CGCE, ioaddr + MTL_EST_STATUS);
-
-		x->mtl_est_cgce++;
-	}
-
-	if (status & HLBS) {
-		value = readl(ioaddr + MTL_EST_SCH_ERR);
-		value &= txqcnt_mask;
-
-		x->mtl_est_hlbs++;
-
-		/* Clear Interrupt */
-		writel(value, ioaddr + MTL_EST_SCH_ERR);
-
-		/* Collecting info to shows all the queues that has HLBS
-		 * issue. The only way to clear this is to clear the
-		 * statistic
-		 */
-		if (net_ratelimit())
-			netdev_err(dev, "EST: HLB(sched) Queue 0x%x\n", value);
-	}
-
-	if (status & HLBF) {
-		value = readl(ioaddr + MTL_EST_FRM_SZ_ERR);
-		feqn = value & txqcnt_mask;
-
-		value = readl(ioaddr + MTL_EST_FRM_SZ_CAP);
-		hbfq = (value & SZ_CAP_HBFQ_MASK(txqcnt)) >> SZ_CAP_HBFQ_SHIFT;
-		hbfs = value & SZ_CAP_HBFS_MASK;
-
-		x->mtl_est_hlbf++;
-
-		/* Clear Interrupt */
-		writel(feqn, ioaddr + MTL_EST_FRM_SZ_ERR);
-
-		if (net_ratelimit())
-			netdev_err(dev, "EST: HLB(size) Queue %u Size %u\n",
-				   hbfq, hbfs);
-	}
-
-	if (status & BTRE) {
-		if ((status & BTRL) == BTRL_MAX)
-			x->mtl_est_btrlm++;
-		else
-			x->mtl_est_btre++;
-
-		btrl = (status & BTRL) >> BTRL_SHIFT;
-
-		if (net_ratelimit())
-			netdev_info(dev, "EST: BTR Error Loop Count %u\n",
-				    btrl);
-
-		writel(BTRE, ioaddr + MTL_EST_STATUS);
-	}
-
-	if (status & SWLC) {
-		writel(SWLC, ioaddr + MTL_EST_STATUS);
-		netdev_info(dev, "EST: SWOL has been switched\n");
-	}
-}
-
 void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
 			  bool enable)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
index 53c138d0ff48..8b0f2c90faef 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
@@ -39,53 +39,6 @@
 #define MAC_PPSx_INTERVAL(x)		(0x00000b88 + ((x) * 0x10))
 #define MAC_PPSx_WIDTH(x)		(0x00000b8c + ((x) * 0x10))
 
-#define MTL_EST_CONTROL			0x00000c50
-#define PTOV				GENMASK(31, 24)
-#define PTOV_SHIFT			24
-#define SSWL				BIT(1)
-#define EEST				BIT(0)
-
-#define MTL_EST_STATUS			0x00000c58
-#define BTRL				GENMASK(11, 8)
-#define BTRL_SHIFT			8
-#define BTRL_MAX			(0xF << BTRL_SHIFT)
-#define SWOL				BIT(7)
-#define SWOL_SHIFT			7
-#define CGCE				BIT(4)
-#define HLBS				BIT(3)
-#define HLBF				BIT(2)
-#define BTRE				BIT(1)
-#define SWLC				BIT(0)
-
-#define MTL_EST_SCH_ERR			0x00000c60
-#define MTL_EST_FRM_SZ_ERR		0x00000c64
-#define MTL_EST_FRM_SZ_CAP		0x00000c68
-#define SZ_CAP_HBFS_MASK		GENMASK(14, 0)
-#define SZ_CAP_HBFQ_SHIFT		16
-#define SZ_CAP_HBFQ_MASK(_val)		({ typeof(_val) (val) = (_val);	\
-					((val) > 4 ? GENMASK(18, 16) :	\
-					 (val) > 2 ? GENMASK(17, 16) :	\
-					 BIT(16)); })
-
-#define MTL_EST_INT_EN			0x00000c70
-#define IECGCE				CGCE
-#define IEHS				HLBS
-#define IEHF				HLBF
-#define IEBE				BTRE
-#define IECC				SWLC
-
-#define MTL_EST_GCL_CONTROL		0x00000c80
-#define BTR_LOW				0x0
-#define BTR_HIGH			0x1
-#define CTR_LOW				0x2
-#define CTR_HIGH			0x3
-#define TER				0x4
-#define LLR				0x5
-#define ADDR_SHIFT			8
-#define GCRR				BIT(2)
-#define SRWO				BIT(0)
-#define MTL_EST_GCL_DATA		0x00000c84
-
 #define MTL_RXP_CONTROL_STATUS		0x00000ca0
 #define RXPI				BIT(31)
 #define NPE				GENMASK(23, 16)
@@ -149,10 +102,6 @@ int dwmac5_rxp_config(void __iomem *ioaddr, struct stmmac_tc_entry *entries,
 int dwmac5_flex_pps_config(void __iomem *ioaddr, int index,
 			   struct stmmac_pps_cfg *cfg, bool enable,
 			   u32 sub_second_inc, u32 systime_flags);
-int dwmac5_est_configure(void __iomem *ioaddr, struct stmmac_est *cfg,
-			 unsigned int ptp_rate);
-void dwmac5_est_irq_status(void __iomem *ioaddr, struct net_device *dev,
-			   struct stmmac_extra_stats *x, u32 txqcnt);
 void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
 			  bool enable);
 void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 489f66094c49..207ff1799f2c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -284,49 +284,6 @@
 #define XGMAC_TC_PRTY_MAP1		0x00001044
 #define XGMAC_PSTC(x)			GENMASK((x) * 8 + 7, (x) * 8)
 #define XGMAC_PSTC_SHIFT(x)		((x) * 8)
-#define XGMAC_MTL_EST_CONTROL		0x00001050
-#define XGMAC_PTOV			GENMASK(31, 23)
-#define XGMAC_PTOV_SHIFT		23
-#define XGMAC_SSWL			BIT(1)
-#define XGMAC_EEST			BIT(0)
-#define XGMAC_MTL_EST_STATUS		0x00001058
-#define XGMAC_BTRL			GENMASK(15, 8)
-#define XGMAC_BTRL_SHIFT		8
-#define XGMAC_BTRL_MAX			GENMASK(15, 8)
-#define XGMAC_CGCE			BIT(4)
-#define XGMAC_HLBS			BIT(3)
-#define XGMAC_HLBF			BIT(2)
-#define XGMAC_BTRE			BIT(1)
-#define XGMAC_SWLC			BIT(0)
-#define XGMAC_MTL_EST_SCH_ERR		0x00001060
-#define XGMAC_MTL_EST_FRM_SZ_ERR	0x00001064
-#define XGMAC_MTL_EST_FRM_SZ_CAP	0x00001068
-#define XGMAC_SZ_CAP_HBFS_MASK		GENMASK(14, 0)
-#define XGMAC_SZ_CAP_HBFQ_SHIFT		16
-#define XGMAC_SZ_CAP_HBFQ_MASK(val)	\
-	({					\
-		typeof(val) _val = (val);	\
-		(_val > 4 ? GENMASK(18, 16) :	\
-		 _val > 2 ? GENMASK(17, 16) :	\
-		 BIT(16));			\
-	})
-#define XGMAC_MTL_EST_INT_EN		0x00001070
-#define XGMAC_IECGCE			BIT(4)
-#define XGMAC_IEHS			BIT(3)
-#define XGMAC_IEHF			BIT(2)
-#define XGMAC_IEBE			BIT(1)
-#define XGMAC_IECC			BIT(0)
-#define XGMAC_MTL_EST_GCL_CONTROL	0x00001080
-#define XGMAC_BTR_LOW			0x0
-#define XGMAC_BTR_HIGH			0x1
-#define XGMAC_CTR_LOW			0x2
-#define XGMAC_CTR_HIGH			0x3
-#define XGMAC_TER			0x4
-#define XGMAC_LLR			0x5
-#define XGMAC_ADDR_SHIFT		8
-#define XGMAC_GCRR			BIT(2)
-#define XGMAC_SRWO			BIT(0)
-#define XGMAC_MTL_EST_GCL_DATA		0x00001084
 #define XGMAC_MTL_RXP_CONTROL_STATUS	0x000010a0
 #define XGMAC_RXPI			BIT(31)
 #define XGMAC_NPE			GENMASK(23, 16)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index c770683300e2..f33f73de5cfe 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1433,145 +1433,6 @@ static void dwxgmac2_set_arp_offload(struct mac_device_info *hw, bool en,
 	writel(value, ioaddr + XGMAC_RX_CONFIG);
 }
 
-static int dwxgmac3_est_write(void __iomem *ioaddr, u32 reg, u32 val, bool gcl)
-{
-	u32 ctrl;
-
-	writel(val, ioaddr + XGMAC_MTL_EST_GCL_DATA);
-
-	ctrl = (reg << XGMAC_ADDR_SHIFT);
-	ctrl |= gcl ? 0 : XGMAC_GCRR;
-
-	writel(ctrl, ioaddr + XGMAC_MTL_EST_GCL_CONTROL);
-
-	ctrl |= XGMAC_SRWO;
-	writel(ctrl, ioaddr + XGMAC_MTL_EST_GCL_CONTROL);
-
-	return readl_poll_timeout_atomic(ioaddr + XGMAC_MTL_EST_GCL_CONTROL,
-					 ctrl, !(ctrl & XGMAC_SRWO), 100, 5000);
-}
-
-static int dwxgmac3_est_configure(void __iomem *ioaddr, struct stmmac_est *cfg,
-				  unsigned int ptp_rate)
-{
-	int i, ret = 0x0;
-	u32 ctrl;
-
-	ret |= dwxgmac3_est_write(ioaddr, XGMAC_BTR_LOW, cfg->btr[0], false);
-	ret |= dwxgmac3_est_write(ioaddr, XGMAC_BTR_HIGH, cfg->btr[1], false);
-	ret |= dwxgmac3_est_write(ioaddr, XGMAC_TER, cfg->ter, false);
-	ret |= dwxgmac3_est_write(ioaddr, XGMAC_LLR, cfg->gcl_size, false);
-	ret |= dwxgmac3_est_write(ioaddr, XGMAC_CTR_LOW, cfg->ctr[0], false);
-	ret |= dwxgmac3_est_write(ioaddr, XGMAC_CTR_HIGH, cfg->ctr[1], false);
-	if (ret)
-		return ret;
-
-	for (i = 0; i < cfg->gcl_size; i++) {
-		ret = dwxgmac3_est_write(ioaddr, i, cfg->gcl[i], true);
-		if (ret)
-			return ret;
-	}
-
-	ctrl = readl(ioaddr + XGMAC_MTL_EST_CONTROL);
-	ctrl &= ~XGMAC_PTOV;
-	ctrl |= ((1000000000 / ptp_rate) * 9) << XGMAC_PTOV_SHIFT;
-	if (cfg->enable)
-		ctrl |= XGMAC_EEST | XGMAC_SSWL;
-	else
-		ctrl &= ~XGMAC_EEST;
-
-	writel(ctrl, ioaddr + XGMAC_MTL_EST_CONTROL);
-
-	/* Configure EST interrupt */
-	if (cfg->enable)
-		ctrl = XGMAC_IECGCE | XGMAC_IEHS | XGMAC_IEHF | XGMAC_IEBE |
-		       XGMAC_IECC;
-	else
-		ctrl = 0;
-
-	writel(ctrl, ioaddr + XGMAC_MTL_EST_INT_EN);
-	return 0;
-}
-
-static void dwxgmac3_est_irq_status(void __iomem *ioaddr,
-				    struct net_device *dev,
-				    struct stmmac_extra_stats *x, u32 txqcnt)
-{
-	u32 status, value, feqn, hbfq, hbfs, btrl;
-	u32 txqcnt_mask = BIT(txqcnt) - 1;
-
-	status = readl(ioaddr + XGMAC_MTL_EST_STATUS);
-
-	value = XGMAC_CGCE | XGMAC_HLBS | XGMAC_HLBF | XGMAC_BTRE | XGMAC_SWLC;
-
-	/* Return if there is no error */
-	if (!(status & value))
-		return;
-
-	if (status & XGMAC_CGCE) {
-		/* Clear Interrupt */
-		writel(XGMAC_CGCE, ioaddr + XGMAC_MTL_EST_STATUS);
-
-		x->mtl_est_cgce++;
-	}
-
-	if (status & XGMAC_HLBS) {
-		value = readl(ioaddr + XGMAC_MTL_EST_SCH_ERR);
-		value &= txqcnt_mask;
-
-		x->mtl_est_hlbs++;
-
-		/* Clear Interrupt */
-		writel(value, ioaddr + XGMAC_MTL_EST_SCH_ERR);
-
-		/* Collecting info to shows all the queues that has HLBS
-		 * issue. The only way to clear this is to clear the
-		 * statistic.
-		 */
-		if (net_ratelimit())
-			netdev_err(dev, "EST: HLB(sched) Queue 0x%x\n", value);
-	}
-
-	if (status & XGMAC_HLBF) {
-		value = readl(ioaddr + XGMAC_MTL_EST_FRM_SZ_ERR);
-		feqn = value & txqcnt_mask;
-
-		value = readl(ioaddr + XGMAC_MTL_EST_FRM_SZ_CAP);
-		hbfq = (value & XGMAC_SZ_CAP_HBFQ_MASK(txqcnt)) >>
-			XGMAC_SZ_CAP_HBFQ_SHIFT;
-		hbfs = value & XGMAC_SZ_CAP_HBFS_MASK;
-
-		x->mtl_est_hlbf++;
-
-		/* Clear Interrupt */
-		writel(feqn, ioaddr + XGMAC_MTL_EST_FRM_SZ_ERR);
-
-		if (net_ratelimit())
-			netdev_err(dev, "EST: HLB(size) Queue %u Size %u\n",
-				   hbfq, hbfs);
-	}
-
-	if (status & XGMAC_BTRE) {
-		if ((status & XGMAC_BTRL) == XGMAC_BTRL_MAX)
-			x->mtl_est_btrlm++;
-		else
-			x->mtl_est_btre++;
-
-		btrl = (status & XGMAC_BTRL) >> XGMAC_BTRL_SHIFT;
-
-		if (net_ratelimit())
-			netdev_info(dev, "EST: BTR Error Loop Count %u\n",
-				    btrl);
-
-		writel(XGMAC_BTRE, ioaddr + XGMAC_MTL_EST_STATUS);
-	}
-
-	if (status & XGMAC_SWLC) {
-		writel(XGMAC_SWLC, ioaddr + XGMAC_MTL_EST_STATUS);
-		netdev_info(dev, "EST: SWOL has been switched\n");
-	}
-}
-
 static void dwxgmac3_fpe_configure(void __iomem *ioaddr, u32 num_txq,
 				   u32 num_rxq, bool enable)
 {
@@ -1640,8 +1501,6 @@ const struct stmmac_ops dwxgmac210_ops = {
 	.config_l3_filter = dwxgmac2_config_l3_filter,
 	.config_l4_filter = dwxgmac2_config_l4_filter,
 	.set_arp_offload = dwxgmac2_set_arp_offload,
-	.est_configure = dwxgmac3_est_configure,
-	.est_irq_status = dwxgmac3_est_irq_status,
 	.fpe_configure = dwxgmac3_fpe_configure,
 };
 
@@ -1703,8 +1562,6 @@ const struct stmmac_ops dwxlgmac2_ops = {
 	.config_l3_filter = dwxgmac2_config_l3_filter,
 	.config_l4_filter = dwxgmac2_config_l4_filter,
 	.set_arp_offload = dwxgmac2_set_arp_offload,
-	.est_configure = dwxgmac3_est_configure,
-	.est_irq_status = dwxgmac3_est_irq_status,
 	.fpe_configure = dwxgmac3_fpe_configure,
 };
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index b8ba8f2d8041..1bd34b2a47e8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -7,6 +7,7 @@
 #include "common.h"
 #include "stmmac.h"
 #include "stmmac_ptp.h"
+#include "stmmac_est.h"
 
 static u32 stmmac_get_id(struct stmmac_priv *priv, u32 id_reg)
 {
@@ -114,6 +115,7 @@ static const struct stmmac_hwif_entry {
 	const void *mode;
 	const void *tc;
 	const void *mmc;
+	const void *est;
 	int (*setup)(struct stmmac_priv *priv);
 	int (*quirks)(struct stmmac_priv *priv);
 } stmmac_hw[] = {
@@ -162,6 +164,7 @@ static const struct stmmac_hwif_entry {
 		.regs = {
 			.ptp_off = PTP_GMAC4_OFFSET,
 			.mmc_off = MMC_GMAC4_OFFSET,
+			.est_off = EST_GMAC4_OFFSET,
 		},
 		.desc = &dwmac4_desc_ops,
 		.dma = &dwmac4_dma_ops,
@@ -170,6 +173,7 @@ static const struct stmmac_hwif_entry {
 		.mode = NULL,
 		.tc = &dwmac510_tc_ops,
 		.mmc = &dwmac_mmc_ops,
+		.est = &dwmac510_est_ops,
 		.setup = dwmac4_setup,
 		.quirks = stmmac_dwmac4_quirks,
 	}, {
@@ -180,6 +184,7 @@ static const struct stmmac_hwif_entry {
 		.regs = {
 			.ptp_off = PTP_GMAC4_OFFSET,
 			.mmc_off = MMC_GMAC4_OFFSET,
+			.est_off = EST_GMAC4_OFFSET,
 		},
 		.desc = &dwmac4_desc_ops,
 		.dma = &dwmac4_dma_ops,
@@ -188,6 +193,7 @@ static const struct stmmac_hwif_entry {
 		.mode = &dwmac4_ring_mode_ops,
 		.tc = &dwmac510_tc_ops,
 		.mmc = &dwmac_mmc_ops,
+		.est = &dwmac510_est_ops,
 		.setup = dwmac4_setup,
 		.quirks = NULL,
 	}, {
@@ -198,6 +204,7 @@ static const struct stmmac_hwif_entry {
 		.regs = {
 			.ptp_off = PTP_GMAC4_OFFSET,
 			.mmc_off = MMC_GMAC4_OFFSET,
+			.est_off = EST_GMAC4_OFFSET,
 		},
 		.desc = &dwmac4_desc_ops,
 		.dma = &dwmac410_dma_ops,
@@ -206,6 +213,7 @@ static const struct stmmac_hwif_entry {
 		.mode = &dwmac4_ring_mode_ops,
 		.tc = &dwmac510_tc_ops,
 		.mmc = &dwmac_mmc_ops,
+		.est = &dwmac510_est_ops,
 		.setup = dwmac4_setup,
 		.quirks = NULL,
 	}, {
@@ -216,6 +224,7 @@ static const struct stmmac_hwif_entry {
 		.regs = {
 			.ptp_off = PTP_GMAC4_OFFSET,
 			.mmc_off = MMC_GMAC4_OFFSET,
+			.est_off = EST_XGMAC_OFFSET,
 		},
 		.desc = &dwmac4_desc_ops,
 		.dma = &dwmac410_dma_ops,
@@ -224,6 +233,7 @@ static const struct stmmac_hwif_entry {
 		.mode = &dwmac4_ring_mode_ops,
 		.tc = &dwmac510_tc_ops,
 		.mmc = &dwmac_mmc_ops,
+		.est = &dwmac510_est_ops,
 		.setup = dwmac4_setup,
 		.quirks = NULL,
 	}, {
@@ -235,6 +245,7 @@ static const struct stmmac_hwif_entry {
 		.regs = {
 			.ptp_off = PTP_XGMAC_OFFSET,
 			.mmc_off = MMC_XGMAC_OFFSET,
+			.est_off = EST_XGMAC_OFFSET,
 		},
 		.desc = &dwxgmac210_desc_ops,
 		.dma = &dwxgmac210_dma_ops,
@@ -243,6 +254,7 @@ static const struct stmmac_hwif_entry {
 		.mode = NULL,
 		.tc = &dwmac510_tc_ops,
 		.mmc = &dwxgmac_mmc_ops,
+		.est = &dwmac510_est_ops,
 		.setup = dwxgmac2_setup,
 		.quirks = NULL,
 	}, {
@@ -254,6 +266,7 @@ static const struct stmmac_hwif_entry {
 		.regs = {
 			.ptp_off = PTP_XGMAC_OFFSET,
 			.mmc_off = MMC_XGMAC_OFFSET,
+			.est_off = EST_XGMAC_OFFSET,
 		},
 		.desc = &dwxgmac210_desc_ops,
 		.dma = &dwxgmac210_dma_ops,
@@ -262,6 +275,7 @@ static const struct stmmac_hwif_entry {
 		.mode = NULL,
 		.tc = &dwmac510_tc_ops,
 		.mmc = &dwxgmac_mmc_ops,
+		.est = &dwmac510_est_ops,
 		.setup = dwxlgmac2_setup,
 		.quirks = stmmac_dwxlgmac_quirks,
 	},
@@ -296,6 +310,10 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 		(needs_gmac4 ? PTP_GMAC4_OFFSET : PTP_GMAC3_X_OFFSET);
 	priv->mmcaddr = priv->ioaddr +
 		(needs_gmac4 ? MMC_GMAC4_OFFSET : MMC_GMAC3_X_OFFSET);
+	if (needs_gmac4)
+		priv->estaddr = priv->ioaddr + EST_GMAC4_OFFSET;
+	else if (needs_xgmac)
+		priv->estaddr = priv->ioaddr + EST_XGMAC_OFFSET;
 
 	/* Check for HW specific setup first */
 	if (priv->plat->setup) {
@@ -332,10 +350,13 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 		mac->mode = mac->mode ? : entry->mode;
 		mac->tc = mac->tc ? : entry->tc;
 		mac->mmc = mac->mmc ? : entry->mmc;
+		mac->est = mac->est ? : entry->est;
 
 		priv->hw = mac;
 		priv->ptpaddr = priv->ioaddr + entry->regs.ptp_off;
 		priv->mmcaddr = priv->ioaddr + entry->regs.mmc_off;
+		if (entry->est)
+			priv->estaddr = priv->ioaddr + entry->regs.est_off;
 
 		/* Entry found */
 		if (needs_setup) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 1d424c9bf037..72412d733856 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -419,10 +419,6 @@ struct stmmac_ops {
 				bool en, bool udp, bool sa, bool inv,
 				u32 match);
 	void (*set_arp_offload)(struct mac_device_info *hw, bool en, u32 addr);
-	int (*est_configure)(void __iomem *ioaddr, struct stmmac_est *cfg,
-			     unsigned int ptp_rate);
-	void (*est_irq_status)(void __iomem *ioaddr, struct net_device *dev,
-			       struct stmmac_extra_stats *x, u32 txqcnt);
 	void (*fpe_configure)(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
 			      bool enable);
 	void (*fpe_send_mpacket)(void __iomem *ioaddr,
@@ -528,10 +524,6 @@ struct stmmac_ops {
 	stmmac_do_callback(__priv, mac, config_l4_filter, __args)
 #define stmmac_set_arp_offload(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, set_arp_offload, __args)
-#define stmmac_est_configure(__priv, __args...) \
-	stmmac_do_callback(__priv, mac, est_configure, __args)
-#define stmmac_est_irq_status(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mac, est_irq_status, __args)
 #define stmmac_fpe_configure(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, fpe_configure, __args)
 #define stmmac_fpe_send_mpacket(__priv, __args...) \
@@ -657,9 +649,22 @@ struct stmmac_mmc_ops {
 #define stmmac_mmc_read(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mmc, read, __args)
 
+struct stmmac_est_ops {
+	int (*configure)(struct stmmac_priv *priv, struct stmmac_est *cfg,
+			 unsigned int ptp_rate);
+	void (*irq_status)(struct stmmac_priv *priv, struct net_device *dev,
+			   struct stmmac_extra_stats *x, u32 txqcnt);
+};
+
+#define stmmac_est_configure(__priv, __args...) \
+	stmmac_do_callback(__priv, est, configure, __args)
+#define stmmac_est_irq_status(__priv, __args...) \
+	stmmac_do_void_callback(__priv, est, irq_status, __args)
+
 struct stmmac_regs_off {
 	u32 ptp_off;
 	u32 mmc_off;
+	u32 est_off;
 };
 
 extern const struct stmmac_ops dwmac100_ops;
@@ -678,6 +683,7 @@ extern const struct stmmac_dma_ops dwxgmac210_dma_ops;
 extern const struct stmmac_desc_ops dwxgmac210_desc_ops;
 extern const struct stmmac_mmc_ops dwmac_mmc_ops;
 extern const struct stmmac_mmc_ops dwxgmac_mmc_ops;
+extern const struct stmmac_est_ops dwmac510_est_ops;
 
 #define GMAC_VERSION		0x00000020	/* GMAC CORE Version */
 #define GMAC4_VERSION		0x00000110	/* GMAC4+ CORE Version */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 686c94c2e8a7..9f89acf31050 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -295,6 +295,7 @@ struct stmmac_priv {
 
 	void __iomem *mmcaddr;
 	void __iomem *ptpaddr;
+	void __iomem *estaddr;
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
 	int sfty_ce_irq;
 	int sfty_ue_irq;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
new file mode 100644
index 000000000000..4da6ccc17c20
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023, Intel Corporation
+ * stmmac EST(802.3 Qbv) handling
+ */
+#include <linux/iopoll.h>
+#include <linux/types.h>
+#include "stmmac.h"
+#include "stmmac_est.h"
+
+static int est_write(void __iomem *est_addr, u32 reg, u32 val, bool gcl)
+{
+	u32 ctrl;
+
+	writel(val, est_addr + EST_GCL_DATA);
+
+	ctrl = (reg << EST_ADDR_SHIFT);
+	ctrl |= gcl ? 0 : EST_GCRR;
+	writel(ctrl, est_addr + EST_GCL_CONTROL);
+
+	ctrl |= EST_SRWO;
+	writel(ctrl, est_addr + EST_GCL_CONTROL);
+
+	return readl_poll_timeout(est_addr + EST_GCL_CONTROL, ctrl,
+				  !(ctrl & EST_SRWO), 100, 5000);
+}
+
+static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
+			 unsigned int ptp_rate)
+{
+	void __iomem *est_addr = priv->estaddr;
+	int i, ret = 0;
+	u32 ctrl;
+
+	ret |= est_write(est_addr, EST_BTR_LOW, cfg->btr[0], false);
+	ret |= est_write(est_addr, EST_BTR_HIGH, cfg->btr[1], false);
+	ret |= est_write(est_addr, EST_TER, cfg->ter, false);
+	ret |= est_write(est_addr, EST_LLR, cfg->gcl_size, false);
+	ret |= est_write(est_addr, EST_CTR_LOW, cfg->ctr[0], false);
+	ret |= est_write(est_addr, EST_CTR_HIGH, cfg->ctr[1], false);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < cfg->gcl_size; i++) {
+		ret = est_write(est_addr, i, cfg->gcl[i], true);
+		if (ret)
+			return ret;
+	}
+
+	ctrl = readl(est_addr + EST_CONTROL);
+	if (priv->plat->has_xgmac) {
+		ctrl &= ~EST_XGMAC_PTOV;
+		ctrl |= ((NSEC_PER_SEC / ptp_rate) * EST_XGMAC_PTOV_MUL) <<
+			 EST_XGMAC_PTOV_SHIFT;
+	} else {
+		ctrl &= ~EST_GMAC5_PTOV;
+		ctrl |= ((NSEC_PER_SEC / ptp_rate) * EST_GMAC5_PTOV_MUL) <<
+			 EST_GMAC5_PTOV_SHIFT;
+	}
+	if (cfg->enable)
+		ctrl |= EST_EEST | EST_SSWL;
+	else
+		ctrl &= ~EST_EEST;
+
+	writel(ctrl, est_addr + EST_CONTROL);
+
+	/* Configure EST interrupt */
+	if (cfg->enable)
+		ctrl = EST_IECGCE | EST_IEHS | EST_IEHF | EST_IEBE | EST_IECC;
+	else
+		ctrl = 0;
+
+	writel(ctrl, est_addr + EST_INT_EN);
+
+	return 0;
+}
+
+static void est_irq_status(struct stmmac_priv *priv, struct net_device *dev,
+			   struct stmmac_extra_stats *x, u32 txqcnt)
+{
+	u32 status, value, feqn, hbfq, hbfs, btrl, btrl_max;
+	void __iomem *est_addr = priv->estaddr;
+	u32 txqcnt_mask = BIT(txqcnt) - 1;
+
+	status = readl(est_addr + EST_STATUS);
+
+	value = EST_CGCE | EST_HLBS | EST_HLBF | EST_BTRE | EST_SWLC;
+
+	/* Return if there is no error */
+	if (!(status & value))
+		return;
+
+	if (status & EST_CGCE) {
+		/* Clear Interrupt */
+		writel(EST_CGCE, est_addr + EST_STATUS);
+
+		x->mtl_est_cgce++;
+	}
+
+	if (status & EST_HLBS) {
+		value = readl(est_addr + EST_SCH_ERR);
+		value &= txqcnt_mask;
+
+		x->mtl_est_hlbs++;
+
+		/* Clear Interrupt */
+		writel(value, est_addr + EST_SCH_ERR);
+
+		/* Collecting info to shows all the queues that has HLBS
+		 * issue. The only way to clear this is to clear the
+		 * statistic
+		 */
+		if (net_ratelimit())
+			netdev_err(dev, "EST: HLB(sched) Queue 0x%x\n", value);
+	}
+
+	if (status & EST_HLBF) {
+		value = readl(est_addr + EST_FRM_SZ_ERR);
+		feqn = value & txqcnt_mask;
+
+		value = readl(est_addr + EST_FRM_SZ_CAP);
+		hbfq = (value & EST_SZ_CAP_HBFQ_MASK(txqcnt)) >>
+			EST_SZ_CAP_HBFQ_SHIFT;
+		hbfs = value & EST_SZ_CAP_HBFS_MASK;
+
+		x->mtl_est_hlbf++;
+
+		/* Clear Interrupt */
+		writel(feqn, est_addr + EST_FRM_SZ_ERR);
+
+		if (net_ratelimit())
+			netdev_err(dev, "EST: HLB(size) Queue %u Size %u\n",
+				   hbfq, hbfs);
+	}
+
+	if (status & EST_BTRE) {
+		if (priv->plat->has_xgmac) {
+			btrl = FIELD_GET(EST_XGMAC_BTRL, status);
+			btrl_max = FIELD_MAX(EST_XGMAC_BTRL);
+		} else {
+			btrl = FIELD_GET(EST_GMAC5_BTRL, status);
+			btrl_max = FIELD_MAX(EST_GMAC5_BTRL);
+		}
+		if (btrl == btrl_max)
+			x->mtl_est_btrlm++;
+		else
+			x->mtl_est_btre++;
+
+		if (net_ratelimit())
+			netdev_info(dev, "EST: BTR Error Loop Count %u\n",
+				    btrl);
+
+		writel(EST_BTRE, est_addr + EST_STATUS);
+	}
+
+	if (status & EST_SWLC) {
+		writel(EST_SWLC, est_addr + EST_STATUS);
+		netdev_info(dev, "EST: SWOL has been switched\n");
+	}
+}
+
+const struct stmmac_est_ops dwmac510_est_ops = {
+	.configure = est_configure,
+	.irq_status = est_irq_status,
+};
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
new file mode 100644
index 000000000000..7a858c566e7e
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023, Intel Corporation
+ * stmmac EST(802.3 Qbv) handling
+ */
+
+#define EST_GMAC4_OFFSET		0x00000c50
+#define EST_XGMAC_OFFSET		0x00001050
+
+#define EST_CONTROL			0x00000000
+#define EST_GMAC5_PTOV			GENMASK(31, 24)
+#define EST_GMAC5_PTOV_SHIFT		24
+#define EST_GMAC5_PTOV_MUL		6
+#define EST_XGMAC_PTOV			GENMASK(31, 23)
+#define EST_XGMAC_PTOV_SHIFT		23
+#define EST_XGMAC_PTOV_MUL		9
+#define EST_SSWL			BIT(1)
+#define EST_EEST			BIT(0)
+
+#define EST_STATUS			0x00000008
+#define EST_GMAC5_BTRL			GENMASK(11, 8)
+#define EST_XGMAC_BTRL			GENMASK(15, 8)
+#define EST_SWOL			BIT(7)
+#define EST_SWOL_SHIFT			7
+#define EST_CGCE			BIT(4)
+#define EST_HLBS			BIT(3)
+#define EST_HLBF			BIT(2)
+#define EST_BTRE			BIT(1)
+#define EST_SWLC			BIT(0)
+
+#define EST_SCH_ERR			0x00000010
+
+#define EST_FRM_SZ_ERR			0x00000014
+
+#define EST_FRM_SZ_CAP			0x00000018
+#define EST_SZ_CAP_HBFS_MASK		GENMASK(14, 0)
+#define EST_SZ_CAP_HBFQ_SHIFT		16
+#define EST_SZ_CAP_HBFQ_MASK(val)		\
+	({					\
+		typeof(val) _val = (val);	\
+		(_val > 4 ? GENMASK(18, 16) :	\
+		 _val > 2 ? GENMASK(17, 16) :	\
+		 BIT(16));			\
+	})
+
+#define EST_INT_EN			0x00000020
+#define EST_IECGCE			EST_CGCE
+#define EST_IEHS			EST_HLBS
+#define EST_IEHF			EST_HLBF
+#define EST_IEBE			EST_BTRE
+#define EST_IECC			EST_SWLC
+
+#define EST_GCL_CONTROL			0x00000030
+#define EST_BTR_LOW			0x0
+#define EST_BTR_HIGH			0x1
+#define EST_CTR_LOW			0x2
+#define EST_CTR_HIGH			0x3
+#define EST_TER				0x4
+#define EST_LLR				0x5
+#define EST_ADDR_SHIFT			8
+#define EST_GCRR			BIT(2)
+#define EST_SRWO			BIT(0)
+
+#define EST_GCL_DATA			0x00000034
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index c2ac88aaffed..5b7d45f2e2a9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5960,7 +5960,7 @@ static void stmmac_common_interrupt(struct stmmac_priv *priv)
 		pm_wakeup_event(priv->device, 0);
 
 	if (priv->dma_cap.estsel)
-		stmmac_est_irq_status(priv, priv->ioaddr, priv->dev,
+		stmmac_est_irq_status(priv, priv, priv->dev,
 				      &priv->xstats, tx_cnt);
 
 	if (priv->dma_cap.fpesel) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index bffa5c017032..e04830a3a1fb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -72,7 +72,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		est_rst = true;
 		mutex_lock(&priv->plat->est->lock);
 		priv->plat->est->enable = false;
-		stmmac_est_configure(priv, priv->ioaddr, priv->plat->est,
+		stmmac_est_configure(priv, priv, priv->plat->est,
 				     priv->plat->clk_ptp_rate);
 		mutex_unlock(&priv->plat->est->lock);
 	}
@@ -102,7 +102,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		priv->plat->est->btr[0] = (u32)time.tv_nsec;
 		priv->plat->est->btr[1] = (u32)time.tv_sec;
 		priv->plat->est->enable = true;
-		ret = stmmac_est_configure(priv, priv->ioaddr, priv->plat->est,
+		ret = stmmac_est_configure(priv, priv, priv->plat->est,
 					   priv->plat->clk_ptp_rate);
 		mutex_unlock(&priv->plat->est->lock);
 		if (ret)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index ac41ef4cbd2f..d4ee4684bc70 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1051,7 +1051,7 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 	 */
 	priv->plat->fpe_cfg->enable = fpe;
 
-	ret = stmmac_est_configure(priv, priv->ioaddr, priv->plat->est,
+	ret = stmmac_est_configure(priv, priv, priv->plat->est,
 				   priv->plat->clk_ptp_rate);
 	mutex_unlock(&priv->plat->est->lock);
 	if (ret) {
@@ -1072,7 +1072,7 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 	if (priv->plat->est) {
 		mutex_lock(&priv->plat->est->lock);
 		priv->plat->est->enable = false;
-		stmmac_est_configure(priv, priv->ioaddr, priv->plat->est,
+		stmmac_est_configure(priv, priv, priv->plat->est,
 				     priv->plat->clk_ptp_rate);
 		mutex_unlock(&priv->plat->est->lock);
 	}
-- 
2.26.2


