Return-Path: <bpf+bounces-20577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B79840613
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 14:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0AA1C232A8
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 13:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B8F634E7;
	Mon, 29 Jan 2024 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hLHzItpV"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703A96280A;
	Mon, 29 Jan 2024 13:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533526; cv=none; b=TEn+6e3ppKYhSuWORN0ebf4161CP0/Q2q3SOT/+qcRNvGmfkLyxWYcRZf3492B/LM9l5hkWILGy2kLGl1LmdCE6XMSX6R+TDTADYZSoeR66Zg8EEV6/jzDkJM8Cc1/T/r/47GA9frK12DtLB/XtV9x+4j6hdE//++CKVA2DP/+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533526; c=relaxed/simple;
	bh=6NUJxzq+XVvVj6pNMncMX5L9x6cZh5iXbnFwIH3E42c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QguaieeaeoFXFTCcajY2txKXvsD7QTKgKIBvNWRwM8OgfYXkOC60M616y8WrifKHvtKQaV6AO7sm/1KuxB+aQ2XDdBXbdUl2xkW/bpKmYOuV6xL26XiMj3X4dJ7XRrpLQHBv4wyVMYzlr7wcPpev2P1kM28+cW+3lH5K72Zxlaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hLHzItpV; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706533526; x=1738069526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6NUJxzq+XVvVj6pNMncMX5L9x6cZh5iXbnFwIH3E42c=;
  b=hLHzItpVaeDBrdZ+DaFZZyKzvVUR4rZ4EmkzGyr1e8hf9pQyCi2fFAkM
   vul8k9YZCzGb5piEm7FbiJWee2Z9sHBfJKlOVuOadKbdXnx6Hama52UJg
   7oLDH43fNk5h3GUTSrkrXbSv4j7UwtT0WiimUOQmyFN9HvqyBLIZOgxxy
   4gswoiSZ+nvTZ24YnCBtCIFMSP9VB6nfofY4Vw01O5vLUY/xValLxfjqW
   XN/vpilkKLXFNflR6ZO7T0mPyiyuUtWwbMJ8piqwrGN7S+XYemnT3WCIT
   YIyKGX+ioGSkSauuJ+cC76G0RqvPxON8kdWPNQuk1Q++sPUyWTNaMMquB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="21473347"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="21473347"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 05:05:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="907106724"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="907106724"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jan 2024 05:05:17 -0800
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
Subject: [PATCH net-next v4 02/11] net: stmmac: provide allow_switch_interface flag
Date: Mon, 29 Jan 2024 21:02:44 +0800
Message-Id: <20240129130253.1400707-3-yong.liang.choong@linux.intel.com>
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

Provide the allow_switch_interface flag to indicate the platform supports
interface mode switching.

Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 ++++-
 include/linux/stmmac.h                            | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a0e46369ae15..d1ec075ae10a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1222,9 +1222,12 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 	priv->phylink_config.mac_managed_pm = true;
 
 	mdio_bus_data = priv->plat->mdio_bus_data;
-	if (mdio_bus_data)
+	if (mdio_bus_data) {
 		priv->phylink_config.ovr_an_inband =
 			mdio_bus_data->xpcs_an_inband;
+		priv->phylink_config.allow_switch_interface =
+			mdio_bus_data->allow_switch_interface;
+	}
 
 	/* Set the platform/firmware specified interface mode. Note, phylink
 	 * deals with the PHY interface mode, not the MAC interface mode.
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index dee5ad6e48c5..b99d11f4ff26 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -87,6 +87,7 @@ struct stmmac_mdio_bus_data {
 	int *irqs;
 	int probed_phy_irq;
 	bool needs_reset;
+	bool allow_switch_interface;
 };
 
 struct stmmac_dma_cfg {
-- 
2.34.1


