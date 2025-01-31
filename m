Return-Path: <bpf+bounces-50219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76980A242FD
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 19:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69DAF3A84E2
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 18:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2261F2C54;
	Fri, 31 Jan 2025 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dStYr5ZW"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D021F2379;
	Fri, 31 Jan 2025 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738349676; cv=none; b=auC/sdZs/XTDAf45O8INQn3HIL/Tu9Ur/Qbu1kxXEQr4CB8Di31ATF0paH/SQbNpKcD7JY4KuRaWSq7fhd8hki3Yz88DdaykryuoKoZ0zcWa4oQfwKag75c1L6qGPqR6oy+K2HnaG7EHhifv3L7J/DzFcPxQ9ps7G1lE1YFMv+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738349676; c=relaxed/simple;
	bh=IaqDlxrLJT7VxPUWzoRmV5hVO7mUVEW2ku4xiY9svlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXwNqIty/NHOsgmy8Uc1/q2EYqc4TT3ka3w9RLsIcmKx48NudQzwVIyjjn8oTAmqttcLEvV5AjVQ96GzVkrTqIE3q5nlGHa7YPitrM5G5TWyMKXLvdG/F5thpzQIUT8y198t4YtYaPvQaCnQvzYv5SWPVtIqfthPRWtEB61puPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dStYr5ZW; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738349674; x=1769885674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IaqDlxrLJT7VxPUWzoRmV5hVO7mUVEW2ku4xiY9svlU=;
  b=dStYr5ZWrq0G1DI1kGqoxGK0KPqdpx5caqfd2E3YMlfqAA7y9SyZbQvY
   fePx9yYN0ukNgeKNa/YX9YeNOwpZFqICN6+KxsL9Vg409MqscE7VdmGN0
   1VlFFjQyegGdz30VNuVjVkqJ1Hw4eo8v8ZxNrhWwbZQVaza0iTwVV10wx
   2w05m9HDsqheZ/2ow1Q29giryvFu8hMNvk0G06yJYSLGecuWQEOrkvq6o
   iTRVvb5VCjNAjTTDa9gMHqj46EoPuqU+ZI94dT9ROj+SHgzJqaSwVW3HG
   29vFVE+GECjIfQHVL8V6tKKA4+9rKoczv2TTGq6lup9879Q1VBE7fZ0z/
   Q==;
X-CSE-ConnectionGUID: M+nUx/uvRPCUMG/LyFJqGA==
X-CSE-MsgGUID: oFurwX14Qp246CjTJUlTtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11332"; a="38163427"
X-IronPort-AV: E=Sophos;i="6.13,249,1732608000"; 
   d="scan'208";a="38163427"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 10:54:25 -0800
X-CSE-ConnectionGUID: olH1dUI7Q6KCnWKfnE49mw==
X-CSE-MsgGUID: WzEm42KlTo27Ng9B4xp2QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110149720"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 31 Jan 2025 10:54:23 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	horms@kernel.org,
	xudu@redhat.com,
	jmaxwell@redhat.com,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH net 1/3] ice: put Rx buffers after being done with current frame
Date: Fri, 31 Jan 2025 10:54:11 -0800
Message-ID: <20250131185415.3741532-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131185415.3741532-1-anthony.l.nguyen@intel.com>
References: <20250131185415.3741532-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Introduce a new helper ice_put_rx_mbuf() that will go through gathered
frags from current frame and will call ice_put_rx_buf() on them. Current
logic that was supposed to simplify and optimize the driver where we go
through a batch of all buffers processed in current NAPI instance turned
out to be broken for jumbo frames and very heavy load that was coming
from both multi-thread iperf and nginx/wrk pair between server and
client. The delay introduced by approach that we are dropping is simply
too big and we need to take the decision regarding page
recycling/releasing as quick as we can.

While at it, address an error path of ice_add_xdp_frag() - we were
missing buffer putting from day 1 there.

As a nice side effect we get rid of annoying and repetitive three-liner:

	xdp->data = NULL;
	rx_ring->first_desc = ntc;
	rx_ring->nr_frags = 0;

by embedding it within introduced routine.

Fixes: 1dc1a7e7f410 ("ice: Centrallize Rx buffer recycling")
Reported-and-tested-by: Xu Du <xudu@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 79 ++++++++++++++---------
 1 file changed, 50 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 5d2d7736fd5f..e173d9c98988 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1103,6 +1103,49 @@ ice_put_rx_buf(struct ice_rx_ring *rx_ring, struct ice_rx_buf *rx_buf)
 	rx_buf->page = NULL;
 }
 
+/**
+ * ice_put_rx_mbuf - ice_put_rx_buf() caller, for all frame frags
+ * @rx_ring: Rx ring with all the auxiliary data
+ * @xdp: XDP buffer carrying linear + frags part
+ * @xdp_xmit: XDP_TX/XDP_REDIRECT verdict storage
+ * @ntc: a current next_to_clean value to be stored at rx_ring
+ *
+ * Walk through gathered fragments and satisfy internal page
+ * recycle mechanism; we take here an action related to verdict
+ * returned by XDP program;
+ */
+static void ice_put_rx_mbuf(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
+			    u32 *xdp_xmit, u32 ntc)
+{
+	u32 nr_frags = rx_ring->nr_frags + 1;
+	u32 idx = rx_ring->first_desc;
+	u32 cnt = rx_ring->count;
+	struct ice_rx_buf *buf;
+	int i;
+
+	for (i = 0; i < nr_frags; i++) {
+		buf = &rx_ring->rx_buf[idx];
+
+		if (buf->act & (ICE_XDP_TX | ICE_XDP_REDIR)) {
+			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
+			*xdp_xmit |= buf->act;
+		} else if (buf->act & ICE_XDP_CONSUMED) {
+			buf->pagecnt_bias++;
+		} else if (buf->act == ICE_XDP_PASS) {
+			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
+		}
+
+		ice_put_rx_buf(rx_ring, buf);
+
+		if (++idx == cnt)
+			idx = 0;
+	}
+
+	xdp->data = NULL;
+	rx_ring->first_desc = ntc;
+	rx_ring->nr_frags = 0;
+}
+
 /**
  * ice_clean_rx_irq - Clean completed descriptors from Rx ring - bounce buf
  * @rx_ring: Rx descriptor ring to transact packets on
@@ -1120,7 +1163,6 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 	unsigned int total_rx_bytes = 0, total_rx_pkts = 0;
 	unsigned int offset = rx_ring->rx_offset;
 	struct xdp_buff *xdp = &rx_ring->xdp;
-	u32 cached_ntc = rx_ring->first_desc;
 	struct ice_tx_ring *xdp_ring = NULL;
 	struct bpf_prog *xdp_prog = NULL;
 	u32 ntc = rx_ring->next_to_clean;
@@ -1128,7 +1170,6 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 	u32 xdp_xmit = 0;
 	u32 cached_ntu;
 	bool failure;
-	u32 first;
 
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 	if (xdp_prog) {
@@ -1190,6 +1231,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 			xdp_prepare_buff(xdp, hard_start, offset, size, !!offset);
 			xdp_buff_clear_frags_flag(xdp);
 		} else if (ice_add_xdp_frag(rx_ring, xdp, rx_buf, size)) {
+			ice_put_rx_mbuf(rx_ring, xdp, NULL, ntc);
 			break;
 		}
 		if (++ntc == cnt)
@@ -1205,9 +1247,8 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		total_rx_bytes += xdp_get_buff_len(xdp);
 		total_rx_pkts++;
 
-		xdp->data = NULL;
-		rx_ring->first_desc = ntc;
-		rx_ring->nr_frags = 0;
+		ice_put_rx_mbuf(rx_ring, xdp, &xdp_xmit, ntc);
+
 		continue;
 construct_skb:
 		if (likely(ice_ring_uses_build_skb(rx_ring)))
@@ -1221,14 +1262,11 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 			if (unlikely(xdp_buff_has_frags(xdp)))
 				ice_set_rx_bufs_act(xdp, rx_ring,
 						    ICE_XDP_CONSUMED);
-			xdp->data = NULL;
-			rx_ring->first_desc = ntc;
-			rx_ring->nr_frags = 0;
-			break;
 		}
-		xdp->data = NULL;
-		rx_ring->first_desc = ntc;
-		rx_ring->nr_frags = 0;
+		ice_put_rx_mbuf(rx_ring, xdp, &xdp_xmit, ntc);
+
+		if (!skb)
+			break;
 
 		stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_RXE_S);
 		if (unlikely(ice_test_staterr(rx_desc->wb.status_error0,
@@ -1257,23 +1295,6 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		total_rx_pkts++;
 	}
 
-	first = rx_ring->first_desc;
-	while (cached_ntc != first) {
-		struct ice_rx_buf *buf = &rx_ring->rx_buf[cached_ntc];
-
-		if (buf->act & (ICE_XDP_TX | ICE_XDP_REDIR)) {
-			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
-			xdp_xmit |= buf->act;
-		} else if (buf->act & ICE_XDP_CONSUMED) {
-			buf->pagecnt_bias++;
-		} else if (buf->act == ICE_XDP_PASS) {
-			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
-		}
-
-		ice_put_rx_buf(rx_ring, buf);
-		if (++cached_ntc >= cnt)
-			cached_ntc = 0;
-	}
 	rx_ring->next_to_clean = ntc;
 	/* return up to cleaned_count buffers to hardware */
 	failure = ice_alloc_rx_bufs(rx_ring, ICE_RX_DESC_UNUSED(rx_ring));
-- 
2.47.1


