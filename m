Return-Path: <bpf+bounces-50220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07482A242FF
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 19:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA98F3A8511
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 18:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EBA1F37B4;
	Fri, 31 Jan 2025 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WpDkoNwd"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F491F2C25;
	Fri, 31 Jan 2025 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738349677; cv=none; b=VHOJ82mLTV9L/85EVtvSYVrmv2oA1IiXtBIn7igUoXnSHM5Gp3XswsPKxnZPJR3MLZwrpFIrjwRQS+VXiddQvKLeq0jZ4ZcUrJm01fsTUiVn3C97CHpb50e5t0nXNOx2GXnI5oSrWTd4YgkubVbuHsNlKewGHTr1WEpnefMyFgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738349677; c=relaxed/simple;
	bh=sy3DW62W/WxwoDoeUAVeTvp1JDb2vzivKpRkpYTUvt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgPqabQyIiuo/V8D1XEjk/438i85QfWoi7z4yFT1LG/y6PYsOotdMuutk9cnsxvu1TwFuB4DBjrBOVMnjZJSFtgIUd3hP/gZJbLPLKx6Ybq0esPUMJhf5TG3TfOLY6GUQpU+VK5hwalYW66pM5OD7uCxkD9qxOLX4Bgh92+uFOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WpDkoNwd; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738349675; x=1769885675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sy3DW62W/WxwoDoeUAVeTvp1JDb2vzivKpRkpYTUvt0=;
  b=WpDkoNwdM7rgwDy4fYkjH2gxlryOucvTt7XbZeYOKdPHGNjYEntidarX
   352Xx4Gsz7mCvqu3Fh4cKHsHSSHl+rjLZALMpjW0/FEXxcOcCVftglijX
   7hKALArOMyr3iv4mdun8l0I2qVUAiYfEDs5qqF52sMiuRcWqSt57/ZD4P
   qrKDbLuOBmV3KZDXq9CFbZV7x0ca6KvL3Zc2vzoFqmt9nh4kHtVkV5Jd0
   yg/nlvF/ngGxpwX9+ionIf6bqs4Dn5D7n4TV+Sloo8WutvsqRdcKdYLet
   F2pzBdnXWVj6zCANWUjyp8ZnjnTYtGgVLrC22w3jZC4z1ThKPuk1FGaoJ
   w==;
X-CSE-ConnectionGUID: QA/qKxG3Q3+7C7zC0wQb4A==
X-CSE-MsgGUID: p2k53WUOQ7yL6T+L+NLQLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11332"; a="38163434"
X-IronPort-AV: E=Sophos;i="6.13,249,1732608000"; 
   d="scan'208";a="38163434"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 10:54:25 -0800
X-CSE-ConnectionGUID: 1fu71MmkShGnnw2est6YCQ==
X-CSE-MsgGUID: oP8Lx1RwRD26Zrc4psXuaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110149724"
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
Subject: [PATCH net 3/3] ice: stop storing XDP verdict within ice_rx_buf
Date: Fri, 31 Jan 2025 10:54:13 -0800
Message-ID: <20250131185415.3741532-4-anthony.l.nguyen@intel.com>
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

Idea behind having ice_rx_buf::act was to simplify and speed up the Rx
data path by walking through buffers that were representing cleaned HW
Rx descriptors. Since it caused us a major headache recently and we
rolled back to old approach that 'puts' Rx buffers right after running
XDP prog/creating skb, this is useless now and should be removed.

Get rid of ice_rx_buf::act and related logic. We still need to take care
of a corner case where XDP program releases a particular fragment.

Make ice_run_xdp() to return its result and use it within
ice_put_rx_mbuf().

Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx side")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 62 +++++++++++--------
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 -
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 43 -------------
 3 files changed, 36 insertions(+), 70 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index cf46bcf143b4..9c9ea4c1b93b 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -527,15 +527,14 @@ int ice_setup_rx_ring(struct ice_rx_ring *rx_ring)
  * @xdp: xdp_buff used as input to the XDP program
  * @xdp_prog: XDP program to run
  * @xdp_ring: ring to be used for XDP_TX action
- * @rx_buf: Rx buffer to store the XDP action
  * @eop_desc: Last descriptor in packet to read metadata from
  *
  * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
  */
-static void
+static u32
 ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 	    struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
-	    struct ice_rx_buf *rx_buf, union ice_32b_rx_flex_desc *eop_desc)
+	    union ice_32b_rx_flex_desc *eop_desc)
 {
 	unsigned int ret = ICE_XDP_PASS;
 	u32 act;
@@ -574,7 +573,7 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 		ret = ICE_XDP_CONSUMED;
 	}
 exit:
-	ice_set_rx_bufs_act(xdp, rx_ring, ret);
+	return ret;
 }
 
 /**
@@ -860,10 +859,8 @@ ice_add_xdp_frag(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 		xdp_buff_set_frags_flag(xdp);
 	}
 
-	if (unlikely(sinfo->nr_frags == MAX_SKB_FRAGS)) {
-		ice_set_rx_bufs_act(xdp, rx_ring, ICE_XDP_CONSUMED);
+	if (unlikely(sinfo->nr_frags == MAX_SKB_FRAGS))
 		return -ENOMEM;
-	}
 
 	__skb_fill_page_desc_noacc(sinfo, sinfo->nr_frags++, rx_buf->page,
 				   rx_buf->page_offset, size);
@@ -1075,12 +1072,12 @@ ice_construct_skb(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp)
 				rx_buf->page_offset + headlen, size,
 				xdp->frame_sz);
 	} else {
-		/* buffer is unused, change the act that should be taken later
-		 * on; data was copied onto skb's linear part so there's no
+		/* buffer is unused, restore biased page count in Rx buffer;
+		 * data was copied onto skb's linear part so there's no
 		 * need for adjusting page offset and we can reuse this buffer
 		 * as-is
 		 */
-		rx_buf->act = ICE_SKB_CONSUMED;
+		rx_buf->pagecnt_bias++;
 	}
 
 	if (unlikely(xdp_buff_has_frags(xdp))) {
@@ -1133,29 +1130,34 @@ ice_put_rx_buf(struct ice_rx_ring *rx_ring, struct ice_rx_buf *rx_buf)
  * @xdp: XDP buffer carrying linear + frags part
  * @xdp_xmit: XDP_TX/XDP_REDIRECT verdict storage
  * @ntc: a current next_to_clean value to be stored at rx_ring
+ * @verdict: return code from XDP program execution
  *
  * Walk through gathered fragments and satisfy internal page
  * recycle mechanism; we take here an action related to verdict
  * returned by XDP program;
  */
 static void ice_put_rx_mbuf(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
-			    u32 *xdp_xmit, u32 ntc)
+			    u32 *xdp_xmit, u32 ntc, u32 verdict)
 {
 	u32 nr_frags = rx_ring->nr_frags + 1;
 	u32 idx = rx_ring->first_desc;
 	u32 cnt = rx_ring->count;
+	u32 post_xdp_frags = 1;
 	struct ice_rx_buf *buf;
 	int i;
 
-	for (i = 0; i < nr_frags; i++) {
+	if (unlikely(xdp_buff_has_frags(xdp)))
+		post_xdp_frags += xdp_get_shared_info_from_buff(xdp)->nr_frags;
+
+	for (i = 0; i < post_xdp_frags; i++) {
 		buf = &rx_ring->rx_buf[idx];
 
-		if (buf->act & (ICE_XDP_TX | ICE_XDP_REDIR)) {
+		if (verdict & (ICE_XDP_TX | ICE_XDP_REDIR)) {
 			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
-			*xdp_xmit |= buf->act;
-		} else if (buf->act & ICE_XDP_CONSUMED) {
+			*xdp_xmit |= verdict;
+		} else if (verdict & ICE_XDP_CONSUMED) {
 			buf->pagecnt_bias++;
-		} else if (buf->act == ICE_XDP_PASS) {
+		} else if (verdict == ICE_XDP_PASS) {
 			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
 		}
 
@@ -1164,6 +1166,17 @@ static void ice_put_rx_mbuf(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 		if (++idx == cnt)
 			idx = 0;
 	}
+	/* handle buffers that represented frags released by XDP prog;
+	 * for these we keep pagecnt_bias as-is; refcount from struct page
+	 * has been decremented within XDP prog and we do not have to increase
+	 * the biased refcnt
+	 */
+	for (; i < nr_frags; i++) {
+		buf = &rx_ring->rx_buf[idx];
+		ice_put_rx_buf(rx_ring, buf);
+		if (++idx == cnt)
+			idx = 0;
+	}
 
 	xdp->data = NULL;
 	rx_ring->first_desc = ntc;
@@ -1190,9 +1203,9 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 	struct ice_tx_ring *xdp_ring = NULL;
 	struct bpf_prog *xdp_prog = NULL;
 	u32 ntc = rx_ring->next_to_clean;
+	u32 cached_ntu, xdp_verdict;
 	u32 cnt = rx_ring->count;
 	u32 xdp_xmit = 0;
-	u32 cached_ntu;
 	bool failure;
 
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
@@ -1255,7 +1268,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 			xdp_prepare_buff(xdp, hard_start, offset, size, !!offset);
 			xdp_buff_clear_frags_flag(xdp);
 		} else if (ice_add_xdp_frag(rx_ring, xdp, rx_buf, size)) {
-			ice_put_rx_mbuf(rx_ring, xdp, NULL, ntc);
+			ice_put_rx_mbuf(rx_ring, xdp, NULL, ntc, ICE_XDP_CONSUMED);
 			break;
 		}
 		if (++ntc == cnt)
@@ -1266,13 +1279,13 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 			continue;
 
 		ice_get_pgcnts(rx_ring);
-		ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_buf, rx_desc);
-		if (rx_buf->act == ICE_XDP_PASS)
+		xdp_verdict = ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_desc);
+		if (xdp_verdict == ICE_XDP_PASS)
 			goto construct_skb;
 		total_rx_bytes += xdp_get_buff_len(xdp);
 		total_rx_pkts++;
 
-		ice_put_rx_mbuf(rx_ring, xdp, &xdp_xmit, ntc);
+		ice_put_rx_mbuf(rx_ring, xdp, &xdp_xmit, ntc, xdp_verdict);
 
 		continue;
 construct_skb:
@@ -1283,12 +1296,9 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
 			rx_ring->ring_stats->rx_stats.alloc_page_failed++;
-			rx_buf->act = ICE_XDP_CONSUMED;
-			if (unlikely(xdp_buff_has_frags(xdp)))
-				ice_set_rx_bufs_act(xdp, rx_ring,
-						    ICE_XDP_CONSUMED);
+			xdp_verdict = ICE_XDP_CONSUMED;
 		}
-		ice_put_rx_mbuf(rx_ring, xdp, &xdp_xmit, ntc);
+		ice_put_rx_mbuf(rx_ring, xdp, &xdp_xmit, ntc, xdp_verdict);
 
 		if (!skb)
 			break;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index cb347c852ba9..806bce701df3 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -201,7 +201,6 @@ struct ice_rx_buf {
 	struct page *page;
 	unsigned int page_offset;
 	unsigned int pgcnt;
-	unsigned int act;
 	unsigned int pagecnt_bias;
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
index 79f960c6680d..6cf32b404127 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
@@ -5,49 +5,6 @@
 #define _ICE_TXRX_LIB_H_
 #include "ice.h"
 
-/**
- * ice_set_rx_bufs_act - propagate Rx buffer action to frags
- * @xdp: XDP buffer representing frame (linear and frags part)
- * @rx_ring: Rx ring struct
- * act: action to store onto Rx buffers related to XDP buffer parts
- *
- * Set action that should be taken before putting Rx buffer from first frag
- * to the last.
- */
-static inline void
-ice_set_rx_bufs_act(struct xdp_buff *xdp, const struct ice_rx_ring *rx_ring,
-		    const unsigned int act)
-{
-	u32 sinfo_frags = xdp_get_shared_info_from_buff(xdp)->nr_frags;
-	u32 nr_frags = rx_ring->nr_frags + 1;
-	u32 idx = rx_ring->first_desc;
-	u32 cnt = rx_ring->count;
-	struct ice_rx_buf *buf;
-
-	for (int i = 0; i < nr_frags; i++) {
-		buf = &rx_ring->rx_buf[idx];
-		buf->act = act;
-
-		if (++idx == cnt)
-			idx = 0;
-	}
-
-	/* adjust pagecnt_bias on frags freed by XDP prog */
-	if (sinfo_frags < rx_ring->nr_frags && act == ICE_XDP_CONSUMED) {
-		u32 delta = rx_ring->nr_frags - sinfo_frags;
-
-		while (delta) {
-			if (idx == 0)
-				idx = cnt - 1;
-			else
-				idx--;
-			buf = &rx_ring->rx_buf[idx];
-			buf->pagecnt_bias--;
-			delta--;
-		}
-	}
-}
-
 /**
  * ice_test_staterr - tests bits in Rx descriptor status and error fields
  * @status_err_n: Rx descriptor status_error0 or status_error1 bits
-- 
2.47.1


