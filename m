Return-Path: <bpf+bounces-56246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A609DA93B25
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 18:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB287B2548
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 16:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B14321506E;
	Fri, 18 Apr 2025 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5fLkc0D"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BA521B9DF;
	Fri, 18 Apr 2025 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994323; cv=none; b=Vy26St6BuYQdrNjZiQMYlvgNaB8TDIMaHnyNC9VUQL55evA591TZdIjz+djENhdjRi46PtUZErrSGefuqPDNqMYJwVPdvbfVaMwDhAycwhxzKbRzdXOilIbgR5oqZwSmpbiw23Ofp2HP+eyLsEyiS2nEvXQvH5QjlCMt1oAt4wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994323; c=relaxed/simple;
	bh=y+sPxnK4agLH0GHm8BwfzRpkrP/ygcap9LC/O3MI0PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAII6GrsogQdMT/7Z2tWyKviXBS2u5SL67eNQF8P/z+N4TCyoRlPyhO+4pSBU7JzN5mLqinjhnMtRNPcH3KLMsUvZneW/dCweOHBWu56/MQlGpzHAwWyVoPBsIub76eV7asJi3zGKgkcEB4+l6T7sC2WG45uiDBzluFoRsoFkfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P5fLkc0D; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744994321; x=1776530321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y+sPxnK4agLH0GHm8BwfzRpkrP/ygcap9LC/O3MI0PA=;
  b=P5fLkc0DI10e5Yc28pStZR1pkSkvKyq8OPF4A1N9Y+d41cp/+pC4NjbX
   2IVWjTqd4d4ekHlYa9aOIQJSJkRvcek/cCjwCZpAz63Pyy4I7cTXer0BM
   I+DI6OJAvXNzj+C+Z7OCLj+/c3Fb3CIxYoiZoGDTm78tGZuBlxEW+jSxe
   t5j/AnlxGZOKVRtsRJ+MASfJIP+GXJ0JGLXUzclRRdVh4fvWNa9WPUitZ
   PDbKH+3YqDUE7EKd8YOfHqIuC5h2hSd+Uy03w5rdtSEgNgjGIyIu0sUI7
   ywQPM1hewT6lGxI566d9gEWNGO7JwmgDcxn43pM4QTrN3SESQ1o9q85vR
   g==;
X-CSE-ConnectionGUID: 6iqjHCHEQsirTBizKMRmjQ==
X-CSE-MsgGUID: GFeGc52QR9Wn2vKXyExCXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="50454438"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="50454438"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 09:38:36 -0700
X-CSE-ConnectionGUID: 96tB1Qk/SJi1/Yk4zAg7ZA==
X-CSE-MsgGUID: +SmQEmMKQgCrp+hp4oK3Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="130892281"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 18 Apr 2025 09:38:36 -0700
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
	bpf@vger.kernel.org,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net-next 09/14] igc: set the RX packet buffer size for TSN mode
Date: Fri, 18 Apr 2025 09:38:15 -0700
Message-ID: <20250418163822.3519810-10-anthony.l.nguyen@intel.com>
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

In preparation for supporting frame preemption, when entering TSN mode,
set the receive packet buffer to 15KB for the Express MAC, 15KB for
the Preemptible MAC and 2KB for the BMC.

References:
I225/I226 SW User Manual, Section 4.7.9, Section 7.1.3.2, Section 8.3.1

The newly introduced macros follow the naming from the i226 SW User Manual
for easy reference.

Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h |  5 ++++
 drivers/net/ethernet/intel/igc/igc_tsn.c     | 27 ++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 12a16a7acb03..86abd3bafb37 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -399,17 +399,22 @@
 /* Mask for RX packet buffer size */
 #define IGC_RXPBSIZE_EXP_MASK		GENMASK(5, 0)
 #define IGC_BMC2OSPBSIZE_MASK		GENMASK(11, 6)
+#define IGC_RXPBSIZE_BE_MASK		GENMASK(17, 12)
 /* Mask for timestamp in RX buffer */
 #define IGC_RXPBS_CFG_TS_EN_MASK	GENMASK(31, 31)
 /* High-priority RX packet buffer size (KB). Used for Express traffic when preemption is enabled */
 #define IGC_RXPBSIZE_EXP(x)		FIELD_PREP(IGC_RXPBSIZE_EXP_MASK, (x))
 /* BMC to OS packet buffer size in KB */
 #define IGC_BMC2OSPBSIZE(x)		FIELD_PREP(IGC_BMC2OSPBSIZE_MASK, (x))
+/* Low-priority RX packet buffer size (KB). Used for BE traffic when preemption is enabled */
+#define IGC_RXPBSIZE_BE(x)		FIELD_PREP(IGC_RXPBSIZE_BE_MASK, (x))
 /* Enable RX packet buffer for timestamp descriptor, saving 16 bytes per packet if set */
 #define IGC_RXPBS_CFG_TS_EN		FIELD_PREP(IGC_RXPBS_CFG_TS_EN_MASK, 1)
 /* Default value following I225/I226 SW User Manual Section 8.3.1 */
 #define IGC_RXPBSIZE_EXP_BMC_DEFAULT ( \
 	IGC_RXPBSIZE_EXP(34) | IGC_BMC2OSPBSIZE(2))
+#define IGC_RXPBSIZE_EXP_BMC_BE_TSN ( \
+	IGC_RXPBSIZE_EXP(15) | IGC_BMC2OSPBSIZE(2) | IGC_RXPBSIZE_BE(15))
 
 /* Mask for TX packet buffer size */
 #define IGC_TXPB0SIZE_MASK		GENMASK(5, 0)
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 498741d83ca6..2254f255cc3b 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -125,6 +125,29 @@ static void igc_tsn_tx_arb(struct igc_adapter *adapter, u16 *queue_per_tc)
 	wr32(IGC_TXARB, txarb);
 }
 
+/**
+ * igc_tsn_set_rxpbsize - Set the receive packet buffer size
+ * @adapter: Pointer to the igc_adapter structure
+ * @rxpbs_exp_bmc_be: Value to set the receive packet buffer size, including
+ *                    express buffer, BMC buffer, and Best Effort buffer
+ *
+ * The IGC_RXPBS register value may include allocations for the Express buffer,
+ * BMC buffer, Best Effort buffer, and the timestamp descriptor buffer
+ * (IGC_RXPBS_CFG_TS_EN).
+ */
+static void igc_tsn_set_rxpbsize(struct igc_adapter *adapter,
+				 u32 rxpbs_exp_bmc_be)
+{
+	struct igc_hw *hw = &adapter->hw;
+	u32 rxpbs = rd32(IGC_RXPBS);
+
+	rxpbs &= ~(IGC_RXPBSIZE_EXP_MASK | IGC_BMC2OSPBSIZE_MASK |
+		   IGC_RXPBSIZE_BE_MASK);
+	rxpbs |= rxpbs_exp_bmc_be;
+
+	wr32(IGC_RXPBS, rxpbs);
+}
+
 /* Returns the TSN specific registers to their default values after
  * the adapter is reset.
  */
@@ -139,6 +162,8 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 	wr32(IGC_TXPBS, IGC_TXPBSIZE_DEFAULT);
 	wr32(IGC_DTXMXPKTSZ, IGC_DTXMXPKTSZ_DEFAULT);
 
+	igc_tsn_set_rxpbsize(adapter, IGC_RXPBSIZE_EXP_BMC_DEFAULT);
+
 	if (igc_is_device_id_i226(hw))
 		igc_tsn_restore_retx_default(adapter);
 
@@ -202,6 +227,8 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 	wr32(IGC_DTXMXPKTSZ, IGC_DTXMXPKTSZ_TSN);
 	wr32(IGC_TXPBS, IGC_TXPBSIZE_TSN);
 
+	igc_tsn_set_rxpbsize(adapter, IGC_RXPBSIZE_EXP_BMC_BE_TSN);
+
 	if (igc_is_device_id_i226(hw))
 		igc_tsn_set_retx_qbvfullthreshold(adapter);
 
-- 
2.47.1


