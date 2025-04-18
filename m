Return-Path: <bpf+bounces-56238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D3CA93B0A
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 18:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42509189C10D
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 16:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1E5218AC7;
	Fri, 18 Apr 2025 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TGTz4QDW"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EA3215168;
	Fri, 18 Apr 2025 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994317; cv=none; b=dSQsLPTk+ZYHYUAMsLHcMN5ObXCz8rbj5GlrvNybOQW/097+Fh3Bxmxt2gTBFf7zua2/+zjM7vtg56vqoqCAVzUJHkdZso8yur6xo0s2PEvDyXn8JLSTlMfu9oZfiBP+mVNRIEbKNCxFHB/gxBzen7sJguSUpY7eJ7bC+rIFDRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994317; c=relaxed/simple;
	bh=LBEVVzl9AqXsVCeuCIZBkBF+uqNuleXQBotMixba0Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovXZx/F6mlTSHexOH3XWwzxLjmybPNeB5zXX09m4tb71Itc7yMXtRGUK6+3Wj2H4ZnvI+MitWNJj9bLfARpYxhfoxSRSudzOFLIluR9Ni+um5aRfGpoHZ3D/7Qp+SCilqmEE/Nb4bRyOzdOJZeKBm9/yaBd3yMH81BtuDLwbQzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TGTz4QDW; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744994315; x=1776530315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LBEVVzl9AqXsVCeuCIZBkBF+uqNuleXQBotMixba0Y0=;
  b=TGTz4QDW2MwoMloF1zWyBuY2oYjPdp/VHT2j8QwLG7ZerR99yyPuIGiI
   HPcybk7LCZAyey4i2Z+xk3Q4Q4Sgz1RIouE1wTU61ExqEQE1wpF/0ESXS
   TTnUmOXyqXj5iYwSM0EHlqo+ELl4bNRgkHAfc/s8dQkbRMxAauJM/LU1+
   rN7z/PNiidFecVe99Ugk1DVvHp5jQpW4ScBwGYuU09f5a9tGYh2SDBOiK
   U5MWkzQIuzRC14gugmsmTmMQQvfzyUARpKcAdfD4Hfdh5wjPPESwXR1Yq
   p7pxhCpqR0nTZbNt05O4YkEjHeR7edWjdWPRb7iQuU56SCnW6S4X6MT+T
   A==;
X-CSE-ConnectionGUID: H2P/hHiRTlKJwk7/zB0Etg==
X-CSE-MsgGUID: sAhlY4ltTRe3cASk4v3pkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="50454266"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="50454266"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 09:38:33 -0700
X-CSE-ConnectionGUID: PvzPpXi1TC29X9FFsJKjtA==
X-CSE-MsgGUID: 2+PQ3pQOTYe7nr/OGXoxIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="130892221"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 18 Apr 2025 09:38:32 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	vinicius.gomes@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	przemyslaw.kitszel@intel.com,
	chwee.lin.choong@intel.com,
	yong.liang.choong@linux.intel.com,
	vladimir.oltean@nxp.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	xiaolei.wang@windriver.com,
	hayashi.kunihiko@socionext.com,
	ast@kernel.org,
	jesper.nilsson@axis.com,
	mcoquelin.stm32@gmail.com,
	rmk+kernel@armlinux.org.uk,
	fancer.lancer@gmail.com,
	kory.maincent@bootlin.com,
	linux-stm32@st-md-mailman.stormreply.com,
	hkelam@marvell.com,
	alexandre.torgue@foss.st.com,
	daniel@iogearbox.net,
	linux-arm-kernel@lists.infradead.org,
	hawk@kernel.org,
	quic_jsuraj@quicinc.com,
	gal@nvidia.com,
	john.fastabend@gmail.com,
	0x1207@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH net-next 01/14] net: stmmac: move frag_size handling out of spin_lock
Date: Fri, 18 Apr 2025 09:38:07 -0700
Message-ID: <20250418163822.3519810-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418163822.3519810-1-anthony.l.nguyen@intel.com>
References: <20250418163822.3519810-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

The upcoming patch will extract verification logic into a new module,
MMSV (MAC Merge Software Verification). MMSV will handle most FPE fields,
except frag_size. It introduces its own lock (mmsv->lock), replacing
fpe_cfg->lock.

Since frag_size handling remains in the driver, the existing rtnl_lock()
is sufficient. Move frag_size handling out of spin_lock_irq_save() to keep
the upcoming patch a pure refactoring without behavior changes.

Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Furong Xu <0x1207@gmail.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 844f7d516a40..53f51eebb746 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -1216,6 +1216,10 @@ static int stmmac_get_mm(struct net_device *ndev,
 	if (!stmmac_fpe_supported(priv))
 		return -EOPNOTSUPP;
 
+	state->rx_min_frag_size = ETH_ZLEN;
+	frag_size = stmmac_fpe_get_add_frag_size(priv);
+	state->tx_min_frag_size = ethtool_mm_frag_size_add_to_min(frag_size);
+
 	spin_lock_irqsave(&priv->fpe_cfg.lock, flags);
 
 	state->max_verify_time = STMMAC_FPE_MM_MAX_VERIFY_TIME_MS;
@@ -1224,7 +1228,6 @@ static int stmmac_get_mm(struct net_device *ndev,
 	state->verify_time = priv->fpe_cfg.verify_time;
 	state->tx_enabled = priv->fpe_cfg.tx_enabled;
 	state->verify_status = priv->fpe_cfg.status;
-	state->rx_min_frag_size = ETH_ZLEN;
 
 	/* FPE active if common tx_enabled and
 	 * (verification success or disabled(forced))
@@ -1236,9 +1239,6 @@ static int stmmac_get_mm(struct net_device *ndev,
 	else
 		state->tx_active = false;
 
-	frag_size = stmmac_fpe_get_add_frag_size(priv);
-	state->tx_min_frag_size = ethtool_mm_frag_size_add_to_min(frag_size);
-
 	spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
 
 	return 0;
@@ -1258,6 +1258,8 @@ static int stmmac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
 	if (err)
 		return err;
 
+	stmmac_fpe_set_add_frag_size(priv, frag_size);
+
 	/* Wait for the verification that's currently in progress to finish */
 	timer_shutdown_sync(&fpe_cfg->verify_timer);
 
@@ -1271,7 +1273,6 @@ static int stmmac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
 	if (!cfg->verify_enabled)
 		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
 
-	stmmac_fpe_set_add_frag_size(priv, frag_size);
 	stmmac_fpe_apply(priv);
 
 	spin_unlock_irqrestore(&fpe_cfg->lock, flags);
-- 
2.47.1


