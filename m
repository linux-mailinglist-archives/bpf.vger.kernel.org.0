Return-Path: <bpf+bounces-22059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB43855968
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 04:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7568CB29DEA
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 03:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0DAD53F;
	Thu, 15 Feb 2024 03:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vsl1yFIr"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525B3611B;
	Thu, 15 Feb 2024 03:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966533; cv=none; b=b7d+ZQ+ZdxstqR72As7cd8cqUKT1IExZenJmv974hft1OvRpUCYdTbU/FdEb1cctDLjbxl3Wi51HzKBN0/khsTugPfxQD+uijZ+UF4WTmRfnR/qvV1ACOTMCQNganY3bQb4cBYfKMB1lIEEfIfUWtkqp0wS74p+qxWxPBNZkSe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966533; c=relaxed/simple;
	bh=qvmE9ozt+922Am67EghiGlMAntqBBBPRw+LPiyCAFes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hx1NARbaEEZZ+y9qvvzGn9gv440KdljKsMddgcabRwIAdmyRzvcTvmzqBbh0co3YM0zKMo+EJFS1IO/RXXrzrYpeV4URJZXdNw7zF27Cl6/aD7K8IF6O3vsxSR0tMdfTCYQ3ixORaQBm/H89slJckjTr+wQPP7cJIBw5Ub/Duh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vsl1yFIr; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707966532; x=1739502532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qvmE9ozt+922Am67EghiGlMAntqBBBPRw+LPiyCAFes=;
  b=Vsl1yFIrzGyB74w6qHdmSe/75lA/Y91AMd/wze4YnSKqCyO1X5CssomT
   +sDLZbk4EDil7qThVTwxstsX5KGjIFtOv/+MuX9vwiBi8+kAXe/pzDThB
   GcPblx2k1nstDqF8xuDmRwTRDoWRXjelIdUhwI+gIuRUB72n3LZdfsfwO
   vDZiifomVst5GFCaWpz8PZfVdb4eW8txWamopT9xQYjSgopR8Fz1bHSJ5
   /nqXn7AoFcz1jcvvCVPXAXsZ2FglZ3Eva92kbU7rgGIh9v9TpNL5dImf/
   jNmKyb6GXJGQ6H/GkiYS48akk5ddilcDoejfwjkkdDpOZDtP8z1L0JPYQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19461453"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="19461453"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 19:08:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="3385871"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by fmviesa009.fm.intel.com with ESMTP; 14 Feb 2024 19:08:35 -0800
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
Subject: [PATCH net-next v5 9/9] stmmac: intel: interface switching support for ADL-N platform
Date: Thu, 15 Feb 2024 11:04:59 +0800
Message-Id: <20240215030500.3067426-10-yong.liang.choong@linux.intel.com>
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

'intel_get_pcs_neg_mode' and 'intel_config_serdes' was provided to
handle interface mode change for ADL-S platform.

Modphy register lane was provided to configure serdes on interface
mode changing.

Signed-off-by: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 49 ++++++++++++++++++-
 .../net/ethernet/stmicro/stmmac/dwmac-intel.h |  2 +
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index c79d8e3c3b24..f0f3d35bdb69 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -992,6 +992,53 @@ static int adls_sgmii_phy1_data(struct pci_dev *pdev,
 static struct stmmac_pci_info adls_sgmii1g_phy1_info = {
 	.setup = adls_sgmii_phy1_data,
 };
+
+static int adln_common_data(struct pci_dev *pdev,
+			    struct plat_stmmacenet_data *plat)
+{
+	struct intel_priv_data *intel_priv = plat->bsp_priv;
+
+	plat->rx_queues_to_use = 6;
+	plat->tx_queues_to_use = 4;
+	plat->clk_ptp_rate = 204800000;
+
+	plat->safety_feat_cfg->tsoee = 1;
+	plat->safety_feat_cfg->mrxpee = 0;
+	plat->safety_feat_cfg->mestee = 1;
+	plat->safety_feat_cfg->mrxee = 1;
+	plat->safety_feat_cfg->mtxee = 1;
+	plat->safety_feat_cfg->epsi = 0;
+	plat->safety_feat_cfg->edpp = 0;
+	plat->safety_feat_cfg->prtyen = 0;
+	plat->safety_feat_cfg->tmouten = 0;
+
+	intel_priv->tsn_lane_registers = adln_tsn_lane_registers;
+	intel_priv->max_tsn_lane_registers = ARRAY_SIZE(adln_tsn_lane_registers);
+
+	return intel_mgbe_common_data(pdev, plat);
+}
+
+static int adln_sgmii_phy0_data(struct pci_dev *pdev,
+				struct plat_stmmacenet_data *plat)
+{
+	struct intel_priv_data *intel_priv = plat->bsp_priv;
+
+	plat->bus_id = 1;
+	plat->phy_interface = PHY_INTERFACE_MODE_SGMII;
+	plat->max_speed = SPEED_2500;
+	plat->serdes_powerup = intel_serdes_powerup;
+	plat->serdes_powerdown = intel_serdes_powerdown;
+	plat->get_pcs_neg_mode = intel_get_pcs_neg_mode;
+	plat->config_serdes = intel_config_serdes;
+	intel_priv->pid_modphy = PID_MODPHY1;
+
+	return adln_common_data(pdev, plat);
+}
+
+static struct stmmac_pci_info adln_sgmii1g_phy0_info = {
+	.setup = adln_sgmii_phy0_data,
+};
+
 static const struct stmmac_pci_func_data galileo_stmmac_func_data[] = {
 	{
 		.func = 6,
@@ -1374,7 +1421,7 @@ static const struct pci_device_id intel_eth_pci_id_table[] = {
 	{ PCI_DEVICE_DATA(INTEL, TGLH_SGMII1G_1, &tgl_sgmii1g_phy1_info) },
 	{ PCI_DEVICE_DATA(INTEL, ADLS_SGMII1G_0, &adls_sgmii1g_phy0_info) },
 	{ PCI_DEVICE_DATA(INTEL, ADLS_SGMII1G_1, &adls_sgmii1g_phy1_info) },
-	{ PCI_DEVICE_DATA(INTEL, ADLN_SGMII1G, &tgl_sgmii1g_phy0_info) },
+	{ PCI_DEVICE_DATA(INTEL, ADLN_SGMII1G, &adln_sgmii1g_phy0_info) },
 	{ PCI_DEVICE_DATA(INTEL, RPLP_SGMII1G, &tgl_sgmii1g_phy0_info) },
 	{}
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h
index 093eed977ab0..2c6b50958988 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h
@@ -124,8 +124,10 @@ static const struct pmc_serdes_regs pid_modphy1_2p5g_regs[] = {
 	{}
 };
 
+static const int adln_tsn_lane_registers[] = {6};
 static const int ehl_tsn_lane_registers[] = {7, 8, 9, 10, 11};
 #else
+static const int adln_tsn_lane_registers[] = {};
 static const int ehl_tsn_lane_registers[] = {};
 #endif /* CONFIG_INTEL_PMC_IPC */
 
-- 
2.34.1


