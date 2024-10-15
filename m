Return-Path: <bpf+bounces-42046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E0399F048
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31FEC1C22B4D
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 14:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E960D212640;
	Tue, 15 Oct 2024 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nmg/QrBn"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04E2207A2F;
	Tue, 15 Oct 2024 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004076; cv=none; b=euDDuH/BOHbXcHWxLNSXpocYNEWCd/Z/liDaeNo3uNcQrmEfVz1sRKiwsQ3cW6yjJ+wTmtVR2RkalibpZnRrP/HmzRGrmJKZZSG4WQzT7ktiuWFgwP8kM5TGKazIywR9/lNM7GbnYoSQDNxm5F7SIdfLdkcLIYJaeg6qq40ZY7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004076; c=relaxed/simple;
	bh=RNyaYnyteFIz6zKtFPJP7EcSjidiNZkHkakpv5FKJHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZrdg5oKnpMY7y3CnkVOQeqzp0cIEd0RSpnDImv3tLmzhWmf9klaVa0j8eR5r9FeCSfEgry162B4/CKGsWfHi0nyCo1zFLFAHwDRDCpZoHdGlrR3ba5k6EDiGny85kVgI4Biao795YipqHUkkLN95tQStFpU5Umu9poY+XWnXOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nmg/QrBn; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729004075; x=1760540075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RNyaYnyteFIz6zKtFPJP7EcSjidiNZkHkakpv5FKJHs=;
  b=nmg/QrBncviZpTPSHIzhkKWzyveZ3pic82nPKUkaG/pDBms64Noa9c0c
   agXCC80hcwcFT7KW5q+w40iCQAEZcLqPk69hEBqqSA2WvlhDo+lYdxYwI
   nzAR+j2+JJDtSxMQ9+HGN17JLrXTrj5jUch5aDL8zHR4TbHIUhtouE6UG
   bC4CyZaHsxy3QlFxRkXLpypbgVZLLpn0RPkYCo7DwihtNuu8trt6ltyl6
   tWU/M7eLUC1RwnjyxStn1X4rC4GxZ2dtz+KT+BFIGSD5+lXeygxUkpmzV
   BreBS/G8K3P2I5e+ywgZpG4gJFpC6gqP10xTZcAJg8S4cV3YNwQnyGulF
   A==;
X-CSE-ConnectionGUID: 8LWsYFacRZ2oDTquHXwMPQ==
X-CSE-MsgGUID: Df9Ccd8/SuquWzZX7Fakaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="31277499"
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="31277499"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 07:54:34 -0700
X-CSE-ConnectionGUID: 5plrXB7hScGGOR83ycZKqQ==
X-CSE-MsgGUID: N7dFN+/7Sg2lzqVSMR6Dkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82723083"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa003.jf.intel.com with ESMTP; 15 Oct 2024 07:54:31 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 05/18] xdp, xsk: constify read-only arguments of some static inline helpers
Date: Tue, 15 Oct 2024 16:53:37 +0200
Message-ID: <20241015145350.4077765-6-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lots of read-only helpers for &xdp_buff and &xdp_frame, such as getting
the frame length, skb_shared_info etc., don't have their arguments
marked with `const` for no reason. Add the missing annotations to leave
less place for mistakes and more for optimization.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/xdp.h           | 29 +++++++++++++++++------------
 include/net/xdp_sock_drv.h  | 11 ++++++-----
 include/net/xsk_buff_pool.h |  2 +-
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index e6770dd40c91..197808df1ee1 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -88,7 +88,7 @@ struct xdp_buff {
 	u32 flags; /* supported values defined in xdp_buff_flags */
 };
 
-static __always_inline bool xdp_buff_has_frags(struct xdp_buff *xdp)
+static __always_inline bool xdp_buff_has_frags(const struct xdp_buff *xdp)
 {
 	return !!(xdp->flags & XDP_FLAGS_HAS_FRAGS);
 }
@@ -103,7 +103,8 @@ static __always_inline void xdp_buff_clear_frags_flag(struct xdp_buff *xdp)
 	xdp->flags &= ~XDP_FLAGS_HAS_FRAGS;
 }
 
-static __always_inline bool xdp_buff_is_frag_pfmemalloc(struct xdp_buff *xdp)
+static __always_inline bool
+xdp_buff_is_frag_pfmemalloc(const struct xdp_buff *xdp)
 {
 	return !!(xdp->flags & XDP_FLAGS_FRAGS_PF_MEMALLOC);
 }
@@ -144,15 +145,16 @@ xdp_prepare_buff(struct xdp_buff *xdp, unsigned char *hard_start,
 	 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
 
 static inline struct skb_shared_info *
-xdp_get_shared_info_from_buff(struct xdp_buff *xdp)
+xdp_get_shared_info_from_buff(const struct xdp_buff *xdp)
 {
 	return (struct skb_shared_info *)xdp_data_hard_end(xdp);
 }
 
-static __always_inline unsigned int xdp_get_buff_len(struct xdp_buff *xdp)
+static __always_inline unsigned int
+xdp_get_buff_len(const struct xdp_buff *xdp)
 {
 	unsigned int len = xdp->data_end - xdp->data;
-	struct skb_shared_info *sinfo;
+	const struct skb_shared_info *sinfo;
 
 	if (likely(!xdp_buff_has_frags(xdp)))
 		goto out;
@@ -177,12 +179,13 @@ struct xdp_frame {
 	u32 flags; /* supported values defined in xdp_buff_flags */
 };
 
-static __always_inline bool xdp_frame_has_frags(struct xdp_frame *frame)
+static __always_inline bool xdp_frame_has_frags(const struct xdp_frame *frame)
 {
 	return !!(frame->flags & XDP_FLAGS_HAS_FRAGS);
 }
 
-static __always_inline bool xdp_frame_is_frag_pfmemalloc(struct xdp_frame *frame)
+static __always_inline bool
+xdp_frame_is_frag_pfmemalloc(const struct xdp_frame *frame)
 {
 	return !!(frame->flags & XDP_FLAGS_FRAGS_PF_MEMALLOC);
 }
@@ -201,7 +204,7 @@ static __always_inline void xdp_frame_bulk_init(struct xdp_frame_bulk *bq)
 }
 
 static inline struct skb_shared_info *
-xdp_get_shared_info_from_frame(struct xdp_frame *frame)
+xdp_get_shared_info_from_frame(const struct xdp_frame *frame)
 {
 	void *data_hard_start = frame->data - frame->headroom - sizeof(*frame);
 
@@ -249,7 +252,8 @@ int xdp_alloc_skb_bulk(void **skbs, int n_skb, gfp_t gfp);
 struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf);
 
 static inline
-void xdp_convert_frame_to_buff(struct xdp_frame *frame, struct xdp_buff *xdp)
+void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
+			       struct xdp_buff *xdp)
 {
 	xdp->data_hard_start = frame->data - frame->headroom - sizeof(*frame);
 	xdp->data = frame->data;
@@ -260,7 +264,7 @@ void xdp_convert_frame_to_buff(struct xdp_frame *frame, struct xdp_buff *xdp)
 }
 
 static inline
-int xdp_update_frame_from_buff(struct xdp_buff *xdp,
+int xdp_update_frame_from_buff(const struct xdp_buff *xdp,
 			       struct xdp_frame *xdp_frame)
 {
 	int metasize, headroom;
@@ -317,9 +321,10 @@ void xdp_flush_frame_bulk(struct xdp_frame_bulk *bq);
 void xdp_return_frame_bulk(struct xdp_frame *xdpf,
 			   struct xdp_frame_bulk *bq);
 
-static __always_inline unsigned int xdp_get_frame_len(struct xdp_frame *xdpf)
+static __always_inline unsigned int
+xdp_get_frame_len(const struct xdp_frame *xdpf)
 {
-	struct skb_shared_info *sinfo;
+	const struct skb_shared_info *sinfo;
 	unsigned int len = xdpf->len;
 
 	if (likely(!xdp_frame_has_frags(xdpf)))
diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 40085afd9160..f3175a5d28f7 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -101,7 +101,7 @@ static inline struct xdp_buff *xsk_buff_alloc(struct xsk_buff_pool *pool)
 	return xp_alloc(pool);
 }
 
-static inline bool xsk_is_eop_desc(struct xdp_desc *desc)
+static inline bool xsk_is_eop_desc(const struct xdp_desc *desc)
 {
 	return !xp_mb_desc(desc);
 }
@@ -143,7 +143,7 @@ static inline void xsk_buff_add_frag(struct xdp_buff *xdp)
 	list_add_tail(&frag->list_node, &frag->pool->xskb_list);
 }
 
-static inline struct xdp_buff *xsk_buff_get_frag(struct xdp_buff *first)
+static inline struct xdp_buff *xsk_buff_get_frag(const struct xdp_buff *first)
 {
 	struct xdp_buff_xsk *xskb = container_of(first, struct xdp_buff_xsk, xdp);
 	struct xdp_buff *ret = NULL;
@@ -200,7 +200,8 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
 		XDP_TXMD_FLAGS_CHECKSUM | \
 	0)
 
-static inline bool xsk_buff_valid_tx_metadata(struct xsk_tx_metadata *meta)
+static inline bool
+xsk_buff_valid_tx_metadata(const struct xsk_tx_metadata *meta)
 {
 	return !(meta->flags & ~XDP_TXMD_FLAGS_VALID);
 }
@@ -337,7 +338,7 @@ static inline struct xdp_buff *xsk_buff_alloc(struct xsk_buff_pool *pool)
 	return NULL;
 }
 
-static inline bool xsk_is_eop_desc(struct xdp_desc *desc)
+static inline bool xsk_is_eop_desc(const struct xdp_desc *desc)
 {
 	return false;
 }
@@ -360,7 +361,7 @@ static inline void xsk_buff_add_frag(struct xdp_buff *xdp)
 {
 }
 
-static inline struct xdp_buff *xsk_buff_get_frag(struct xdp_buff *first)
+static inline struct xdp_buff *xsk_buff_get_frag(const struct xdp_buff *first)
 {
 	return NULL;
 }
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index bb03cee716b3..3832997cc605 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -183,7 +183,7 @@ static inline bool xp_desc_crosses_non_contig_pg(struct xsk_buff_pool *pool,
 	       !(pool->dma_pages[addr >> PAGE_SHIFT] & XSK_NEXT_PG_CONTIG_MASK);
 }
 
-static inline bool xp_mb_desc(struct xdp_desc *desc)
+static inline bool xp_mb_desc(const struct xdp_desc *desc)
 {
 	return desc->options & XDP_PKT_CONTD;
 }
-- 
2.46.2


