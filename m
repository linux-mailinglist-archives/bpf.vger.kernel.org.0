Return-Path: <bpf+bounces-20585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFDE84063F
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 14:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933F31F25AF5
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 13:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4917C64AB3;
	Mon, 29 Jan 2024 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AcPE/c2T"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C446664AE;
	Mon, 29 Jan 2024 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533587; cv=none; b=BI4p7028vRmPway3YgBbon18n4COfwUey6Pfo/O+WQj+7wFI2LAl5abpLwlXe4y5iL6sGtLG3EtLKYXhRKVHTxNDe4vxSBOPZ2qO4Ohc6c/WW+J1fkydrmx2hgUTJpRNIFk5GetNs7SDmzDKIqxOWhrq61DC8cw6q80wLV4iQlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533587; c=relaxed/simple;
	bh=YX+8SYjl2KN0yI2CjlWGvAYamUQY2YUGDNZGqVMB2u8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kpnijbh1LPuRAi6DClyBksWVKrlG8KuSmn7unR6JmX9SZT5udGzfhlf73AKOU6LAmQojdb49gv04IFzWXLby4QmGYoc2fx50wn3OQon74waS2xC6tv0ywnXgJS+8lYsAdiYZzIxebO6aFRWAc0yuMB2dM28DneqCkId/KN8qPH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AcPE/c2T; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706533587; x=1738069587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YX+8SYjl2KN0yI2CjlWGvAYamUQY2YUGDNZGqVMB2u8=;
  b=AcPE/c2TphnboSNkXyibmUJLk4pX1eLfwXtFO9rABkLWP6+l+HaDarl9
   JdT8KdbEMyfOXvnuBm+zo32wmrB96BPP0ruPOT0Rz6L1t3SQZXRgvs3Qu
   EZCZyZY69aOSL8+ezkXN5CP2aT3OAcmqNHV8XZkBGO7jMvlBJcZlKiddu
   Cd/3r6rjXNAFSuIod7GCmlpKqJ/FWvm2kQu63eH331Mwpoa3lI/nMEnsa
   u1pGJdqJAIdyBkID1OqnOK77uv0cN0he6Uz2HF45oR36IpEHzxAulvdZB
   IZiNeZEIuzilMrQZvod6lYPsaIXEmIfoHL915Q6CU/0JmQQs99Dwmigu6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="21473643"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="21473643"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 05:06:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="907106871"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="907106871"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jan 2024 05:06:17 -0800
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
Subject: [PATCH net-next v4 09/11] net: stmmac: configure SerDes on mac_finish
Date: Mon, 29 Jan 2024 21:02:51 +0800
Message-Id: <20240129130253.1400707-10-yong.liang.choong@linux.intel.com>
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

SerDes will configure according to the provided interface mode after
finish a major reconfiguration of the interface mode.

Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +++++++++++++
 include/linux/stmmac.h                            |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 50429c985441..ced26c01e88e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1129,12 +1129,25 @@ static unsigned int stmmac_get_pcs_neg_mode(struct phylink_config *config,
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
index 778bdfc3f010..c14b4c204190 100644
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


