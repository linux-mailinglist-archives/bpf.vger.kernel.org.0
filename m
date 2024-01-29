Return-Path: <bpf+bounces-20578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9FB84061A
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 14:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFFE61C223CA
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 13:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108456350A;
	Mon, 29 Jan 2024 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cmNgZKxE"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2203164CC0;
	Mon, 29 Jan 2024 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533535; cv=none; b=ivfU/YSWlZ/3rULWQuzO4NRV4XRmpFfqWYadKNUwtWuMIMesHFRFdGHnPfYFAFsampDDG08mYGJZJWYpQr2832QCtpujmHa6SeAwHWUjOd3MdAi8JcjhIHE3PPlHYnKQWi3j8shtc6WSZHt9s5Q7psMiYSE4pmWMGQmhzEJqblg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533535; c=relaxed/simple;
	bh=4DcfKjEUE4Q7uAyGpqdaKfRx/METmTskcQvMbEFG2So=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FAw+4n0QgjHZaoKwhU/e7HDH2cYhOl2c7300Kk69rBZmjJEoHtSoQJWmjPmTArwq3GvqFUWgLP+cIku4CIH6aTveN/0IpybbmJnt8nt9qVU7kP3Te1YUJJ0GD4oqz8YmdfkWE3UzUaiwTQAZ+9RZMshYe41ziS9fpqPptho/LOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cmNgZKxE; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706533535; x=1738069535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4DcfKjEUE4Q7uAyGpqdaKfRx/METmTskcQvMbEFG2So=;
  b=cmNgZKxErDCd4hL6OvkHcAFnMbFgKmE+wSHQG4WPKrlQS5wbzxNhGhGH
   9Wi8XEsxLh9q5J2sFn5XUmGcTjD7b6OMtg3VsqvoyfbKUC3x81kqDkjRk
   s8sZh5hlnuywQ6B1mZKs7MVesjOcvBIpiYijs4AugPoW+UsiDKTO+n2yG
   mZu3R+oeAJ2dfXvzXkfNRXpFZFqwfnkuQlGHyX/35+qGKCqzRLomeA+sw
   79JSvPo/x1xs2NYXCbgfWaLjEcj32xpt/p5XlYt02+VSD5amoCUlj9g0V
   /uVkWVqqSu29e5Axl5lH5H2QXpKpExpb853Ak3CIHevO4jVEldi7enQiy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="21473394"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="21473394"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 05:05:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="907106751"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="907106751"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jan 2024 05:05:25 -0800
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
Subject: [PATCH net-next v4 03/11] net: phylink: provide mac_get_pcs_neg_mode() function
Date: Mon, 29 Jan 2024 21:02:45 +0800
Message-Id: <20240129130253.1400707-4-yong.liang.choong@linux.intel.com>
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

Phylink invokes the 'mac_get_pcs_neg_mode' function during interface mode
switching and initial startup.

This function is optional; if 'phylink_pcs_neg_mode' fails to accurately
reflect the current PCS negotiation mode, the MAC driver can determine the
mode based on the interface mode, current link negotiation mode, and
advertising link mode.

For instance, if the interface switches from 2500baseX to SGMII mode,
and the current link mode is MLO_AN_PHY, calling 'phylink_pcs_neg_mode'
would yield PHYLINK_PCS_NEG_OUTBAND. Since the MAC and PCS driver require
PHYLINK_PCS_NEG_INBAND_ENABLED, the 'mac_get_pcs_neg_mode' function
will calculate the mode based on the interface, current link negotiation
mode, and advertising link mode, returning PHYLINK_PCS_NEG_OUTBAND to
enable the PCS to configure the correct settings.

Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 drivers/net/phy/phylink.c | 14 +++++++++++---
 include/linux/phylink.h   |  5 +++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 38ee2624169c..27aa5d0a9fc6 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1151,9 +1151,17 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 
 	phylink_dbg(pl, "major config %s\n", phy_modes(state->interface));
 
-	pl->pcs_neg_mode = phylink_pcs_neg_mode(pl->cur_link_an_mode,
-						state->interface,
-						state->advertising);
+	if (pl->mac_ops->mac_get_pcs_neg_mode) {
+		pl->pcs_neg_mode = pl->mac_ops->mac_get_pcs_neg_mode
+						(pl->config,
+						 pl->cur_link_an_mode,
+						 state->interface,
+						 state->advertising);
+	} else {
+		pl->pcs_neg_mode = phylink_pcs_neg_mode(pl->cur_link_an_mode,
+							state->interface,
+							state->advertising);
+	}
 
 	if (pl->using_mac_select_pcs) {
 		pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index b362d3231aa4..adb47d1aa67b 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -169,6 +169,7 @@ void phylink_limit_mac_speed(struct phylink_config *config, u32 max_speed);
  * @mac_finish: finish a major reconfiguration of the interface.
  * @mac_link_down: take the link down.
  * @mac_link_up: allow the link to come up.
+ * @mac_get_pcs_neg_mode: Get PCS negotiation mode for interface mode.
  *
  * The individual methods are described more fully below.
  */
@@ -189,6 +190,10 @@ struct phylink_mac_ops {
 			    struct phy_device *phy, unsigned int mode,
 			    phy_interface_t interface, int speed, int duplex,
 			    bool tx_pause, bool rx_pause);
+	unsigned int (*mac_get_pcs_neg_mode)(struct phylink_config *config,
+				    unsigned int mode,
+				    phy_interface_t interface,
+				    const unsigned long *advertising);
 };
 
 #if 0 /* For kernel-doc purposes only. */
-- 
2.34.1


