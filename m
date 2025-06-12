Return-Path: <bpf+bounces-60504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA43AD77F8
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 18:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C72D188DAC9
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 16:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79BD2BCF54;
	Thu, 12 Jun 2025 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HCF+7YLO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03672D8771;
	Thu, 12 Jun 2025 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744649; cv=none; b=PjDwkVZ2hOe/kG4+OTDwMDqGOXcMXT/PAqwIQbcRU/AEhWI59yBQO8bKeT2k2fF+VPc0iDRhkWiW+K2ZnXPgSqKc0T/zXOKvVYn5gNQ5VzsTnhMSTbd3QW+QrZnVmvYGtY1xNbCYxb/M/1v5SSYq5y7vb9ckDVrI4cLCKVzsI3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744649; c=relaxed/simple;
	bh=X29ySbF7NIGDlQVp1woOlVIfnUo3FpZJcl8ba1PlchM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RkoiqT9lMnt0oeiiRckGXvR/tJHbeWL3nBDp1AjJJhfECr8cnjTTKNGgMa+UDXFrylWuIdKp2CWLUllkpwzLAdmMzxLOZx5acPuKGJPXhwR0VmAteY6repzNW2DBX+Frw/M640LtufzihrI264uwBx2RQ7Gb9jU8HXlhJz3u6KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HCF+7YLO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749744648; x=1781280648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X29ySbF7NIGDlQVp1woOlVIfnUo3FpZJcl8ba1PlchM=;
  b=HCF+7YLO5YHN4Mt8/qS9QehXe1gCyUZlj77SyO+NF9Velst+o53JQEuP
   g81BEN1PGQMXJd2r5gu62w1HUdIxEs33zPORwXSYVVrCgRbd+CMWnOHzS
   KY4Gm9eWRBh90OhWlfTRShLsm/hK0v/38ShMF2n+zGepatZkcB3G5CeQJ
   etUp95qsWaBfhb//j07Bg8dK5P/wad+WEO2uYr80jYEcR3AKmN98CI4Vo
   J74J8ECS21n57i02RgjH5wANYmiwQJ3DjsJdV19kcaFPliy64wmB6/Vl6
   I1jUXFD+YjzGM2U5IbdyMiijj3A8MzCZiG9GJlmd6VGOyZBhDJ4rFa+Xl
   g==;
X-CSE-ConnectionGUID: RGyQPX1uS76A+zJMUqLU+g==
X-CSE-MsgGUID: t0t8SJ/+TDq8gSG7J7LAHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="55739197"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="55739197"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 09:10:48 -0700
X-CSE-ConnectionGUID: 6p3/DrJsTg6ZPyqWIzD1aw==
X-CSE-MsgGUID: Uk5iDxCfSqaD0NS/1emfpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="148468690"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 12 Jun 2025 09:10:43 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Simon Horman <horms@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v2 17/17] libeth: xdp, xsk: access adjacent u32s as u64 where applicable
Date: Thu, 12 Jun 2025 18:02:34 +0200
Message-ID: <20250612160234.68682-18-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612160234.68682-1-aleksander.lobakin@intel.com>
References: <20250612160234.68682-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 include/net/libeth/xdp.h | 29 ++++++++++++++++++++++++++---
 include/net/libeth/xsk.h | 10 +++++-----
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
index dba09a9168f1..6ce6aec6884c 100644
--- a/include/net/libeth/xdp.h
+++ b/include/net/libeth/xdp.h
@@ -475,6 +475,21 @@ struct libeth_xdp_tx_desc {
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
@@ -870,8 +885,7 @@ static inline u32 libeth_xdp_xmit_queue_head(struct libeth_xdp_tx_bulk *bq,
 
 	bq->bulk[bq->count++] = (typeof(*bq->bulk)){
 		.xdpf	= xdpf,
-		.len	= xdpf->len,
-		.flags	= LIBETH_XDP_TX_FIRST,
+		__libeth_xdp_tx_len(xdpf->len, LIBETH_XDP_TX_FIRST),
 	};
 
 	if (!xdp_frame_has_frags(xdpf))
@@ -902,7 +916,7 @@ static inline bool libeth_xdp_xmit_queue_frag(struct libeth_xdp_tx_bulk *bq,
 
 	bq->bulk[bq->count++] = (typeof(*bq->bulk)){
 		.dma	= dma,
-		.len	= skb_frag_size(frag),
+		__libeth_xdp_tx_len(skb_frag_size(frag)),
 	};
 
 	return true;
@@ -1260,6 +1274,7 @@ bool libeth_xdp_buff_add_frag(struct libeth_xdp_buff *xdp,
  * Internal, use libeth_xdp_process_buff() instead. Initializes XDP buffer
  * head with the Rx buffer data: data pointer, length, headroom, and
  * truesize/tailroom. Zeroes the flags.
+ * Uses faster single u64 write instead of per-field access.
  */
 static inline void libeth_xdp_prepare_buff(struct libeth_xdp_buff *xdp,
 					   const struct libeth_fqe *fqe,
@@ -1267,7 +1282,15 @@ static inline void libeth_xdp_prepare_buff(struct libeth_xdp_buff *xdp,
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
2.49.0


