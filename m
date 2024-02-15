Return-Path: <bpf+bounces-22056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9BA85594B
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 04:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C13DB26E75
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 03:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1A514282;
	Thu, 15 Feb 2024 03:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gZ7I4WHg"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A11BA2E;
	Thu, 15 Feb 2024 03:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966500; cv=none; b=pPBGtcvh/k9PiYjfoYF3On/GAXsg5gajzLExh7m39f2UPaKZl6tCncqfRulkPT6QQaUTOHXFU1hiQaUVA49njUKqvISwWg7MGlgdAvfQG4HFtZNrh0E2AZ7dqhpT8BbVE3TKwlEVxTUcDRInuGfHA3vLQECsFOkcQxCeGMi1QwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966500; c=relaxed/simple;
	bh=vvpIPgH1K2PujTnqInvxE+a2W/xss8TF8nrQRvP6KiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YhfxIY2y2iepAuVg5LU3z9dinbQyIvibPGuuutDhrxGhwPpYlVZlftwS61VeS9nTgd7Z05UbzxUdAoaN/uhHHm8yEK+QZdREVARS0XdrDSlyvzzkScrcpI73oWG35bSeHsXtsHxtpmXBkE0ylvM3Ny554SOJiX7mmFDTVnRy/Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gZ7I4WHg; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707966500; x=1739502500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vvpIPgH1K2PujTnqInvxE+a2W/xss8TF8nrQRvP6KiQ=;
  b=gZ7I4WHgYWomjcwBvI1Pjb0NLZQYZEmzbWXGCQZKyEj2P4MKAkgb/Pfi
   BlEVr/JgsVAfuWbocwM9DaBkvP4urpvi/dBJqeKy4TN1P+ZTHThCYjULj
   fHyQxZgwRT2pgeNDu2x/cIFUujAgeBAMCCnktlCIWvccOzeKCK/48GGIF
   /VEmgEshCibmvuz7Aoy8/Dz6/t7WixABW3KFyKdvDfC/0SwWs6fpQcv7/
   KcnVIHuytBZ7hLxztv4btdhYanLxvRdIEIVZZ7CdrjOFwklUqQK3++K3R
   i1Vh322HTQ7qM9Mc451O/q34JDzu9F9NPY6fZzgytyrgvslirvI3mKpcb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19461373"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="19461373"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 19:08:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="3385820"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by fmviesa009.fm.intel.com with ESMTP; 14 Feb 2024 19:08:11 -0800
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
Subject: [PATCH net-next v5 6/9] net: stmmac: configure SerDes on mac_finish
Date: Thu, 15 Feb 2024 11:04:56 +0800
Message-Id: <20240215030500.3067426-7-yong.liang.choong@linux.intel.com>
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

SerDes will configure according to the provided interface mode after
finish a major reconfiguration of the interface mode.

Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +++++++++++++
 include/linux/stmmac.h                            |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index dbd16fc38888..69a33e9f1a5c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1120,12 +1120,25 @@ static unsigned int stmmac_get_pcs_neg_mode(struct phylink_config *config,
 	return neg_mode;
 }
 
+static int stmmac_mac_finish(struct phylink_config *config, unsigned int mode,
+			     phy_interface_t interface)
+{
+	struct net_device *ndev = to_net_dev(config->dev);
+	struct stmmac_priv *priv = netdev_priv(ndev);
+
+	if (priv->plat->config_serdes)
+		priv->plat->config_serdes(ndev, priv->plat->bsp_priv, interface);
+
+	return 0;
+}
+
 static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
 	.mac_select_pcs = stmmac_mac_select_pcs,
 	.mac_config = stmmac_mac_config,
 	.mac_link_down = stmmac_mac_link_down,
 	.mac_link_up = stmmac_mac_link_up,
 	.mac_get_pcs_neg_mode = stmmac_get_pcs_neg_mode,
+	.mac_finish = stmmac_mac_finish,
 };
 
 /**
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index ffd66722eeda..fd3d7d25f871 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -279,6 +279,9 @@ struct plat_stmmacenet_data {
 	void (*speed_mode_2500)(struct net_device *ndev, void *priv);
 	unsigned int (*get_pcs_neg_mode)(phy_interface_t interface,
 					 struct pci_dev *pdev);
+	int (*config_serdes)(struct net_device *ndev,
+			     void *priv,
+			     phy_interface_t interface);
 	void (*ptp_clk_freq_config)(struct stmmac_priv *priv);
 	int (*init)(struct platform_device *pdev, void *priv);
 	void (*exit)(struct platform_device *pdev, void *priv);
-- 
2.34.1


