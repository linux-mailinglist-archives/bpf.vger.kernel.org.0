Return-Path: <bpf+bounces-20454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5AD83EAE4
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 05:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D836B2164C
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 04:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED6E179AB;
	Sat, 27 Jan 2024 04:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CfIxG8NW"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DA71C6B3;
	Sat, 27 Jan 2024 04:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706328308; cv=none; b=VZTmQ/oq9j3rk65Go51mYC2LvgPqtgmFdo1w595jg+CH7xkvzcHPovVoVUvW+nZJs1sPtJB8vAn/yKPTvw6BjNUKfnqmiEsnP4ZJ+ZzrAyAP1ZH6ptr1vkj+u3g1sVNftmZLmKMBrl31fMzRk2975iCP0+FNXSnLzMixSD21i60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706328308; c=relaxed/simple;
	bh=eCcylmKuGhzpjVUqVE5u3nCimW0l3ydQAg3Bgrb9n4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aujl3vZKJ5bqkL0dIJRBqUS/GdZAQu9iEuPvl4FaO/SuvMLcF21ZNxvpzVXN80sULBORKL+We6gitQmq1UtulE/IUDS0C3HOJkENkxTXp1mn5uat753/p0FVUFRGFYe0k8WSBUD+SZy/1JhZ2KTyearwlWSokQ+eQm1uyHPwXus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CfIxG8NW; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706328307; x=1737864307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eCcylmKuGhzpjVUqVE5u3nCimW0l3ydQAg3Bgrb9n4U=;
  b=CfIxG8NWEBSj6NkIl90iCENNmQ3Lftrnyb8B18PTozq7e1IrnB4mjZiR
   l/WzTXGcJVYbfAz9NpZ8psZYfsIQPZ9DzZSq0yhnyxT/jaaqH4fA2V+gv
   i5mtrW0sl6tFJe+mBldlxyAveDtTP78tO7mx+WrujLWx4zM0p0GwaZahH
   s16CrV+vK0i2QSqSUImRiVLA2UmVENkVKTasFdTXZcDO1CRYWmTSTBbYQ
   +IlnrsRjzFZxk/smzOr3KXLFyPN47a70O1pVUTMSSEA3dbEcAIjV+LCXd
   efkN/pVn7nT/FkMdXgih045x40eS3jjz6E+H6tLfRg3KTN7HXy9x4MtWv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="402289664"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="402289664"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 20:05:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="787309861"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="787309861"
Received: from ppglcf2090.png.intel.com ([10.126.160.96])
  by orsmga002.jf.intel.com with ESMTP; 26 Jan 2024 20:05:00 -0800
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
	Rohan G Thomas <rohan.g.thomas@intel.com>
Subject: [PATCH net-next 2/3] net: stmmac: est: Per Tx-queue error count for HLBF
Date: Sat, 27 Jan 2024 12:04:42 +0800
Message-Id: <20240127040443.24835-3-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240127040443.24835-1-rohan.g.thomas@intel.com>
References: <20240127040443.24835-1-rohan.g.thomas@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep per Tx-queue error count on Head-Of-Line Blocking due to frame
size(HLBF) error. The MAC raises HLBF error on one or more queues
when none of the time Intervals of open-gates in the GCL is greater
than or equal to the duration needed for frame transmission and by
default drops those packets that causes HLBF error. EST_FRM_SZ_ERR
register provides the One Hot encoded Queue numbers that have the
Frame Size related error.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h     | 1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index d8d2a90fd228..70bef7811c91 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -203,6 +203,7 @@ struct stmmac_extra_stats {
 	unsigned long mtl_est_btre;
 	unsigned long mtl_est_btrlm;
 	unsigned long max_sdu_txq_drop[MTL_MAX_TX_QUEUES];
+	unsigned long mtl_est_txq_hlbf[MTL_MAX_TX_QUEUES];
 	/* per queue statistics */
 	struct stmmac_txq_stats txq_stats[MTL_MAX_TX_QUEUES];
 	struct stmmac_rxq_stats rxq_stats[MTL_MAX_RX_QUEUES];
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
index 4da6ccc17c20..c9693f77e1f6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
@@ -81,6 +81,7 @@ static void est_irq_status(struct stmmac_priv *priv, struct net_device *dev,
 	u32 status, value, feqn, hbfq, hbfs, btrl, btrl_max;
 	void __iomem *est_addr = priv->estaddr;
 	u32 txqcnt_mask = BIT(txqcnt) - 1;
+	int i;
 
 	status = readl(est_addr + EST_STATUS);
 
@@ -125,6 +126,11 @@ static void est_irq_status(struct stmmac_priv *priv, struct net_device *dev,
 
 		x->mtl_est_hlbf++;
 
+		for (i = 0; i < txqcnt; i++) {
+			if (feqn & BIT(i))
+				x->mtl_est_txq_hlbf[i]++;
+		}
+
 		/* Clear Interrupt */
 		writel(feqn, est_addr + EST_FRM_SZ_ERR);
 
-- 
2.26.2


