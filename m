Return-Path: <bpf+bounces-20455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE65C83EAE7
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 05:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F280B1C22A0F
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 04:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC661D521;
	Sat, 27 Jan 2024 04:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UweUYZW4"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954DD1D694;
	Sat, 27 Jan 2024 04:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706328315; cv=none; b=PL765w5WOaB2i2uuX7Vtn6nK7yEFvR8/AnRJ6ZQ1fFafwW87XVqAjWrsozbqRL425LvlkGdANYQ/z6S+dBhIEr4KHiNEAGDU6nEw3Fzw6zPbEJHcIrkyUgURKpk8lvvwWGNqcFe26Pf/OAUv11H0EeKgZooXzzjTe6vAQwPmVOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706328315; c=relaxed/simple;
	bh=arnNZFPeOWnn8Q5oQ59hKd7A7dEFpKto5u5vQcBQRZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hk5SZv0Ymm3uQAdh/t3pi54ED2oIdNeVWXkmhxXPW3XUzV2jZWq7/v5EfWSlOINUjounN10QZ0LsqqFF3WBgqVqCKjg8Q9O30avTSBQ5m5oGSSCZATnPQXYSvlDbeZG0w7OmWsynJ/KoAuBcUCEq4XqrWY8G5bEG/kNJmuQW6jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UweUYZW4; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706328313; x=1737864313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=arnNZFPeOWnn8Q5oQ59hKd7A7dEFpKto5u5vQcBQRZw=;
  b=UweUYZW4a8vix7R4ZpV8BwbBeByhmxWa6KOFQbUAlluEy+7WbFCx9zwO
   Fg4n6ggUR7d+wCxCJ39bBXiHRAhNb7ShnkLLNz1fFo08eveZ39n5NXYmd
   oWKCFvD72eYTMp13u+n9ATdEn78D5I5ntzbOMimNqHrQZvaEx7X2RxqY9
   0mOu5VdkXEtd20UagexzeWafbst0aPRFJfwtFDJcu5z/9NZ8RK7yOJAK0
   U9XJTupWcoq60+/xkAj90pXbMdqdQiB0Ca9drzwoAZ0JsszBx634Uq2Kk
   icWSPRz1V6h6P5NRx7QMRvlcEjmwEsScX15j6pIPSUMmqIYAysjE4iOa4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="402289698"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="402289698"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 20:05:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="787309871"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="787309871"
Received: from ppglcf2090.png.intel.com ([10.126.160.96])
  by orsmga002.jf.intel.com with ESMTP; 26 Jan 2024 20:05:07 -0800
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
Subject: [PATCH net-next 3/3] net: stmmac: Report taprio offload status
Date: Sat, 27 Jan 2024 12:04:43 +0800
Message-Id: <20240127040443.24835-4-rohan.g.thomas@intel.com>
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

Report taprio offload status. This includes per txq and global
counters of window_drops and tx_overruns.

Window_drops count include count of frames dropped because of
queueMaxSDU setting and HLBF error. Transmission overrun counter
inform the user application whether any packets are currently being
transmitted on a particular queue during a gate-close event.DWMAC IPs
takes care Transmission overrun won't happen hence this is always 0.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 62 +++++++++++++++++--
 1 file changed, 58 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 07aa3a3089dc..cce00719937d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -937,8 +937,8 @@ static void tc_taprio_map_maxsdu_txq(struct stmmac_priv *priv,
 	}
 }
 
-static int tc_setup_taprio(struct stmmac_priv *priv,
-			   struct tc_taprio_qopt_offload *qopt)
+static int tc_taprio_configure(struct stmmac_priv *priv,
+			       struct tc_taprio_qopt_offload *qopt)
 {
 	u32 size, wid = priv->dma_cap.estwid, dep = priv->dma_cap.estdep;
 	struct plat_stmmacenet_data *plat = priv->plat;
@@ -990,8 +990,6 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 
 	if (qopt->cmd == TAPRIO_CMD_DESTROY)
 		goto disable;
-	else if (qopt->cmd != TAPRIO_CMD_REPLACE)
-		return -EOPNOTSUPP;
 
 	if (qopt->num_entries >= dep)
 		return -EINVAL;
@@ -1102,6 +1100,11 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 		priv->plat->est->enable = false;
 		stmmac_est_configure(priv, priv, priv->plat->est,
 				     priv->plat->clk_ptp_rate);
+		/* Reset taprio status */
+		for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
+			priv->xstats.max_sdu_txq_drop[i] = 0;
+			priv->xstats.mtl_est_txq_hlbf[i] = 0;
+		}
 		mutex_unlock(&priv->plat->est->lock);
 	}
 
@@ -1119,6 +1122,57 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 	return ret;
 }
 
+static void tc_taprio_stats(struct stmmac_priv *priv,
+			    struct tc_taprio_qopt_offload *qopt)
+{
+	u64 window_drops = 0;
+	int i = 0;
+
+	for (i = 0; i < priv->plat->tx_queues_to_use; i++)
+		window_drops += priv->xstats.max_sdu_txq_drop[i] +
+				priv->xstats.mtl_est_txq_hlbf[i];
+	qopt->stats.window_drops = window_drops;
+
+	/* Transmission overrun doesn't happen for stmmac, hence always 0 */
+	qopt->stats.tx_overruns = 0;
+}
+
+static void tc_taprio_queue_stats(struct stmmac_priv *priv,
+				  struct tc_taprio_qopt_offload *qopt)
+{
+	struct tc_taprio_qopt_queue_stats *q_stats = &qopt->queue_stats;
+	int queue = qopt->queue_stats.queue;
+
+	q_stats->stats.window_drops = priv->xstats.max_sdu_txq_drop[queue] +
+				      priv->xstats.mtl_est_txq_hlbf[queue];
+
+	/* Transmission overrun doesn't happen for stmmac, hence always 0 */
+	q_stats->stats.tx_overruns = 0;
+}
+
+static int tc_setup_taprio(struct stmmac_priv *priv,
+			   struct tc_taprio_qopt_offload *qopt)
+{
+	int err = 0;
+
+	switch (qopt->cmd) {
+	case TAPRIO_CMD_REPLACE:
+	case TAPRIO_CMD_DESTROY:
+		err = tc_taprio_configure(priv, qopt);
+		break;
+	case TAPRIO_CMD_STATS:
+		tc_taprio_stats(priv, qopt);
+		break;
+	case TAPRIO_CMD_QUEUE_STATS:
+		tc_taprio_queue_stats(priv, qopt);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+	}
+
+	return err;
+}
+
 static int tc_setup_etf(struct stmmac_priv *priv,
 			struct tc_etf_qopt_offload *qopt)
 {
-- 
2.26.2


