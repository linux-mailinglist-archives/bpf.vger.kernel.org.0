Return-Path: <bpf+bounces-58617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654E8ABE566
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 23:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8239B4C6FF4
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 21:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874CC263F49;
	Tue, 20 May 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVYBuYlH"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53786262802;
	Tue, 20 May 2025 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747774785; cv=none; b=DhJPI887d+t4RKLWU5QaEqNA8dfMT6QBmp7mbAhTVokQB/6fpgncxz7PyNBR8f3DRVWOaDvBBPiQhrAjvuNbL9UBS0ub0hnfFY156Fu34YAzniwAKL/GJoGS7PDPqIMPCeFG4O1y/tXhg5/nKeYe9K/GEf83GE8yUcv3SuvbLoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747774785; c=relaxed/simple;
	bh=TxnEzQ9iMtKzyMMd8shQeHwasKbl/Er7rP8Xn3KpqNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFAjEaZu5Anh4X13KxylBNyqJelfPaulwhbeEiN1aWxJLMscPNod90rvuGdrdaYk+D834pYp6ZEzeDjpP/IXEsRRlLQOqOH2q5uq31Vk7/6AUDckrIfHKjh8SjlhWDM70llpjz3NE/kE88A9YpD/EzViRZLqzSHktZ4IIBY8ekY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eVYBuYlH; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747774783; x=1779310783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TxnEzQ9iMtKzyMMd8shQeHwasKbl/Er7rP8Xn3KpqNw=;
  b=eVYBuYlHtnSp4p5dzu6kKboiZqBgOvvAKMQ9YjtJoS2pvgJ0Qm1z7pwh
   ivrWKGSAZzcvsunmPiyff3ix87t0UHnDLlljDrUrBz9/UbPrfJECm1N8i
   28MjrjOvWuo4ooWiR2Jf+bO2OzFN4ymFdIysMe6pN+9lGgyQTVCL90EN2
   2ZUpBlU1DE5Ypv6qN11RpYQegezd1OuVJ9mHlORtmMmTwrYSAnxG/Feh+
   su67Fks6QcMiJIZ35rKEVk3aJScB1FdPzV3R2Xx5Xye7zUUspjY64RFhq
   0Ci2/SMm61a/wt/zHv4wHVSEXHTF6EohUwud9vmJRyvAuQH/4ZZxCp095
   w==;
X-CSE-ConnectionGUID: Vb7FJxMeQ+6i6diuD2EIiw==
X-CSE-MsgGUID: lrQ3diEpQaq7J7k8Q7UWXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="67142814"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="67142814"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 13:59:40 -0700
X-CSE-ConnectionGUID: /vE/MEVlTPi/5ilASCMRYQ==
X-CSE-MsgGUID: zuIZ/Xg8TU+sTrF0Bu6YPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139850973"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 20 May 2025 13:59:40 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	michal.kubiak@intel.com,
	przemyslaw.kitszel@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next 16/16] libeth: xdp, xsk: access adjacent u32s as u64 where applicable
Date: Tue, 20 May 2025 13:59:17 -0700
Message-ID: <20250520205920.2134829-17-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250520205920.2134829-1-anthony.l.nguyen@intel.com>
References: <20250520205920.2134829-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

On 64-bit systems, writing/reading one u64 is faster than two u32s even
when they're are adjacent in a struct. The compilers won't guarantee
they will combine those; I observed both successful and unsuccessful
attempts with both GCC and Clang, and it's not easy to say what it
depends on.
There's a few places in libeth_xdp winning up to several percent from
combined access (both performance and object code size, especially
when unrolling). Add __LIBETH_WORD_ACCESS and use it there on LE.
Drivers are free to optimize HW-specific callbacks under the same
definition.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 include/net/libeth/xdp.h | 29 ++++++++++++++++++++++++++---
 include/net/libeth/xsk.h | 10 +++++-----
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
index 85f058482fc7..6d15386aff31 100644
--- a/include/net/libeth/xdp.h
+++ b/include/net/libeth/xdp.h
@@ -464,6 +464,21 @@ struct libeth_xdp_tx_desc {
 	((const void *)(uintptr_t)(priv));				      \
 })
 
+/*
+ * On 64-bit systems, assigning one u64 is faster than two u32s. When ::len
+ * occupies lowest 32 bits (LE), whole ::opts can be assigned directly instead.
+ */
+#ifdef __LITTLE_ENDIAN
+#define __LIBETH_WORD_ACCESS		1
+#endif
+#ifdef __LIBETH_WORD_ACCESS
+#define __libeth_xdp_tx_len(flen, ...)					      \
+	.opts = ((flen) | FIELD_PREP(GENMASK_ULL(63, 32), (__VA_ARGS__ + 0)))
+#else
+#define __libeth_xdp_tx_len(flen, ...)					      \
+	.len = (flen), .flags = (__VA_ARGS__ + 0)
+#endif
+
 /**
  * libeth_xdp_tx_xmit_bulk - main XDP Tx function
  * @bulk: array of frames to send
@@ -863,8 +878,7 @@ static inline u32 libeth_xdp_xmit_queue_head(struct libeth_xdp_tx_bulk *bq,
 
 	bq->bulk[bq->count++] = (typeof(*bq->bulk)){
 		.xdpf	= xdpf,
-		.len	= xdpf->len,
-		.flags	= LIBETH_XDP_TX_FIRST,
+		__libeth_xdp_tx_len(xdpf->len, LIBETH_XDP_TX_FIRST),
 	};
 
 	if (!xdp_frame_has_frags(xdpf))
@@ -895,7 +909,7 @@ static inline bool libeth_xdp_xmit_queue_frag(struct libeth_xdp_tx_bulk *bq,
 
 	bq->bulk[bq->count++] = (typeof(*bq->bulk)){
 		.dma	= dma,
-		.len	= skb_frag_size(frag),
+		__libeth_xdp_tx_len(skb_frag_size(frag)),
 	};
 
 	return true;
@@ -1253,6 +1267,7 @@ bool libeth_xdp_buff_add_frag(struct libeth_xdp_buff *xdp,
  * Internal, use libeth_xdp_process_buff() instead. Initializes XDP buffer
  * head with the Rx buffer data: data pointer, length, headroom, and
  * truesize/tailroom. Zeroes the flags.
+ * Uses faster single u64 write instead of per-field access.
  */
 static inline void libeth_xdp_prepare_buff(struct libeth_xdp_buff *xdp,
 					   const struct libeth_fqe *fqe,
@@ -1260,7 +1275,15 @@ static inline void libeth_xdp_prepare_buff(struct libeth_xdp_buff *xdp,
 {
 	const struct page *page = __netmem_to_page(fqe->netmem);
 
+#ifdef __LIBETH_WORD_ACCESS
+	static_assert(offsetofend(typeof(xdp->base), flags) -
+		      offsetof(typeof(xdp->base), frame_sz) ==
+		      sizeof(u64));
+
+	*(u64 *)&xdp->base.frame_sz = fqe->truesize;
+#else
 	xdp_init_buff(&xdp->base, fqe->truesize, xdp->base.rxq);
+#endif
 	xdp_prepare_buff(&xdp->base, page_address(page) + fqe->offset,
 			 page->pp->p.offset, len, true);
 }
diff --git a/include/net/libeth/xsk.h b/include/net/libeth/xsk.h
index 213778a68476..481a7b28e6f2 100644
--- a/include/net/libeth/xsk.h
+++ b/include/net/libeth/xsk.h
@@ -26,8 +26,8 @@ static inline bool libeth_xsk_tx_queue_head(struct libeth_xdp_tx_bulk *bq,
 {
 	bq->bulk[bq->count++] = (typeof(*bq->bulk)){
 		.xsk	= xdp,
-		.len	= xdp->base.data_end - xdp->data,
-		.flags	= LIBETH_XDP_TX_FIRST,
+		__libeth_xdp_tx_len(xdp->base.data_end - xdp->data,
+				    LIBETH_XDP_TX_FIRST),
 	};
 
 	if (likely(!xdp_buff_has_frags(&xdp->base)))
@@ -48,7 +48,7 @@ static inline void libeth_xsk_tx_queue_frag(struct libeth_xdp_tx_bulk *bq,
 {
 	bq->bulk[bq->count++] = (typeof(*bq->bulk)){
 		.xsk	= frag,
-		.len	= frag->base.data_end - frag->data,
+		__libeth_xdp_tx_len(frag->base.data_end - frag->data),
 	};
 }
 
@@ -199,7 +199,7 @@ __libeth_xsk_xmit_fill_buf_md(const struct xdp_desc *xdesc,
 	ctx = xsk_buff_raw_get_ctx(sq->pool, xdesc->addr);
 	desc = (typeof(desc)){
 		.addr	= ctx.dma,
-		.len	= xdesc->len,
+		__libeth_xdp_tx_len(xdesc->len),
 	};
 
 	BUILD_BUG_ON(!__builtin_constant_p(tmo == libeth_xsktmo));
@@ -226,7 +226,7 @@ __libeth_xsk_xmit_fill_buf(const struct xdp_desc *xdesc,
 {
 	return (struct libeth_xdp_tx_desc){
 		.addr	= xsk_buff_raw_get_dma(sq->pool, xdesc->addr),
-		.len	= xdesc->len,
+		__libeth_xdp_tx_len(xdesc->len),
 	};
 }
 
-- 
2.47.1


