Return-Path: <bpf+bounces-20586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F756840644
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 14:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE33288E6D
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 13:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC76266B2F;
	Mon, 29 Jan 2024 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DdgLfPGw"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D16B629E1;
	Mon, 29 Jan 2024 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533596; cv=none; b=T7r72SPHHWo7gOj9vYMV4t8z1L9WoeNvcdVWWsGnlmmFeqkVjEHQNrjgIF5eN4lJuQiyQ27qS+U/AJ9iSE2n6FK0pBB1BunamlDDqPioMYJ5GFiVAkA6IAffWe4YqUtu5JekuB9tf+WzmfNxqaoOeA/Ta5KTJLZ/LIC3fjZ2lR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533596; c=relaxed/simple;
	bh=jVZuVXGKKl/w9vqXKLg9hV4CJBuyMpcx4WwCQPI+U90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YgLP+2YV1Wkq82vZBiAajmw91BamTo5c2HJy1NTaZ5EWB6HWwVePieqtOQ6Jntz1JrNVVzQoTa8DKQL0dsDi3NmSfC7OvulKKLnB7fARJeECkQ3clE3qw7VFoo/cyUDg43fmpsbiyE5OELUfS3bwjWDZPMwz3GyRd0kA4bKkceE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DdgLfPGw; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706533595; x=1738069595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jVZuVXGKKl/w9vqXKLg9hV4CJBuyMpcx4WwCQPI+U90=;
  b=DdgLfPGwkD4gUsk8iY6sV2deaE39217jMMg2reh2bCgNX6vqvjHA1rlI
   p1y6qG0eHLxmsNByUoJMp1v8FycSLpvXFsVE4JyzCxRQe9uBrfi88t+dd
   u/Pe6XJ1Rpt/2vS1ZZnYDZoWCiJpOyu4FjSaHAySnAiyvKmeZkJBo/Wdi
   rFvsY0aeD4Isanq5ATdnO3l4S35VWZUuPd7pvo5x8Hz+B6Stp+FTf8cqB
   TN36AVsRCUebuRiPuWtmhm9cmXTsWltS/fUdfSvrE0bDfzewbWRGeKDUI
   Kztktzv7W6sdG4WWRP+fbaFTj3Op5p1YtSRFFl59Ihvx7wumplSB0MWw3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="21473693"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="21473693"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 05:06:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="907106888"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="907106888"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jan 2024 05:06:26 -0800
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
Subject: [PATCH net-next v4 10/11] stmmac: intel: interface switching support for EHL platform
Date: Mon, 29 Jan 2024 21:02:52 +0800
Message-Id: <20240129130253.1400707-11-yong.liang.choong@linux.intel.com>
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

From: Choong Yong Liang <yong.liang.choong@intel.com>

'intel_get_pcs_neg_mode' and 'intel_config_serdes' was provided to
handle interface mode change for EHL platform.

Modphy register lane was provided to configure serdes on interface
mode changing.

Signed-off-by: Choong Yong Liang <yong.liang.choong@intel.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 27 ++++++++++++++++---
 .../net/ethernet/stmicro/stmmac/dwmac-intel.h |  4 +++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index ddd96b18ce87..fd9d56b7c511 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -760,6 +760,8 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 static int ehl_common_data(struct pci_dev *pdev,
 			   struct plat_stmmacenet_data *plat)
 {
+	struct intel_priv_data *intel_priv = plat->bsp_priv;
+
 	plat->rx_queues_to_use = 8;
 	plat->tx_queues_to_use = 8;
 	plat->flags |= STMMAC_FLAG_USE_PHY_WOL;
@@ -775,19 +777,26 @@ static int ehl_common_data(struct pci_dev *pdev,
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
-
+	plat->get_pcs_neg_mode = intel_get_pcs_neg_mode;
+	plat->config_serdes = intel_config_serdes;
 	plat->clk_ptp_rate = 204800000;
+	intel_priv->pid_modphy = PID_MODPHY3;
 
 	return ehl_common_data(pdev, plat);
 }
@@ -841,10 +850,16 @@ static struct stmmac_pci_info ehl_pse0_rgmii1g_info = {
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
+	plat->get_pcs_neg_mode = intel_get_pcs_neg_mode;
+	plat->config_serdes = intel_config_serdes;
+	intel_priv->pid_modphy = PID_MODPHY1;
+
 	return ehl_pse0_common_data(pdev, plat);
 }
 
@@ -882,10 +897,16 @@ static struct stmmac_pci_info ehl_pse1_rgmii1g_info = {
 static int ehl_pse1_sgmii1g_data(struct pci_dev *pdev,
 				 struct plat_stmmacenet_data *plat)
 {
+	struct intel_priv_data *intel_priv = plat->bsp_priv;
+
 	plat->phy_interface = PHY_INTERFACE_MODE_SGMII;
 	plat->speed_mode_2500 = intel_speed_mode_2500;
 	plat->serdes_powerup = intel_serdes_powerup;
 	plat->serdes_powerdown = intel_serdes_powerdown;
+	plat->get_pcs_neg_mode = intel_get_pcs_neg_mode;
+	plat->config_serdes = intel_config_serdes;
+	intel_priv->pid_modphy = PID_MODPHY1;
+
 	return ehl_pse1_common_data(pdev, plat);
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h
index 79c35ba969ea..093eed977ab0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h
@@ -123,6 +123,10 @@ static const struct pmc_serdes_regs pid_modphy1_2p5g_regs[] = {
 	{ PID_MODPHY1_N_MODPHY_PCR_CMN_ANA_DWORD30,	N_MODPHY_PCR_CMN_ANA_DWORD30_2P5G },
 	{}
 };
+
+static const int ehl_tsn_lane_registers[] = {7, 8, 9, 10, 11};
+#else
+static const int ehl_tsn_lane_registers[] = {};
 #endif /* CONFIG_INTEL_PMC_IPC */
 
 #endif /* __DWMAC_INTEL_H__ */
-- 
2.34.1


