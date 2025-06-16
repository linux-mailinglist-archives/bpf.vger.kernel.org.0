Return-Path: <bpf+bounces-60765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C598BADBB0B
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 22:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4293B57D7
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 20:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C6F2951BD;
	Mon, 16 Jun 2025 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="htK5Vj3f"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E481294A0C;
	Mon, 16 Jun 2025 20:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750105044; cv=none; b=bL68o/jmfAFdHEuFy7cbhgBJ1QUbvO5o23X80CjNc8Rxp2CT6fyks1BNgWU4bOSSSnUIvNndfthNP6vRl3Rn+2AYiU6K40yblmVJvafAETZJSdfrp+hyQOcofcDFV1qpHSjzsELPAncCFiJHcHDf/1DkfDB9t3dvhlfM/j84j6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750105044; c=relaxed/simple;
	bh=NIWiQ+Ymd77ZFCA5QgzkWdrfprp8YRylFH+h+Kci50Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFeckvWNcXNjwnsPVIpUPdnagZ8Wa9vhReQo6g8LEyBswDeoGFlVeR5y/laOrkIB6fhmaqC1tf6+ouIAtxfH9MnddIKSo14ZuWQds+68nB3vZa1nBEn+qbzHlwSX7msmhKIccT+dSkA8DQO+OeF9qyV+iLnelxIjZcTsrA2geSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=htK5Vj3f; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750105043; x=1781641043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NIWiQ+Ymd77ZFCA5QgzkWdrfprp8YRylFH+h+Kci50Y=;
  b=htK5Vj3f7hOdTEAnfnUDDt9mP2NcbWCbZi8uWkarYBzhPGoPglq9rlY6
   bcV6L0wH/C+O2u8ceEE+Ofk9tveJkgeDkzZ7Lg1VyMl+RUyxoMSUiOwGi
   vkvfXjXBRqtkPvztUPZZ0TNuSKVnfhvVxfvuiBchPNRzmje3UuMZAstP9
   cOXgRiUrdz/XcEbYjbaGaEmi/VZkegNpAMbgVCWi0fBfKqnsqgHYZpblS
   Gzn0Pz7qs45UJp0/4UJS09l6d/NzFhThq1E11hM2FqLZah1mXs+q/WEB1
   gw1ZVrR0aMHfkISG89rymvly+8CchqdZ9hGTWvklB5mO5p6wCcFVfxQ75
   A==;
X-CSE-ConnectionGUID: 6gABodibQK2/TVFM4vSUeg==
X-CSE-MsgGUID: 4Lshfs+iRryV9ECcnh+a4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="62533579"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="62533579"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 13:17:13 -0700
X-CSE-ConnectionGUID: 5uIZfyryRu+98SOfTZCscA==
X-CSE-MsgGUID: uAnwhPIFRc+cGK/965scvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="153531023"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 16 Jun 2025 13:17:13 -0700
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
Subject: [PATCH net-next v2 17/17] libeth: xdp, xsk: access adjacent u32s as u64 where applicable
Date: Mon, 16 Jun 2025 13:16:38 -0700
Message-ID: <20250616201639.710420-18-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250616201639.710420-1-anthony.l.nguyen@intel.com>
References: <20250616201639.710420-1-anthony.l.nguyen@intel.com>
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
2.47.1


