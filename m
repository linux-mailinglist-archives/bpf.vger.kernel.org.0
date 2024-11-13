Return-Path: <bpf+bounces-44762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9C49C7721
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 16:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1152874B6
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 15:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C2B205140;
	Wed, 13 Nov 2024 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tlzoo7O6"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E488204001;
	Wed, 13 Nov 2024 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511534; cv=none; b=ErQcnrEhqRmTzR4ZAC0qqpXYsHZ4b0pz3qmg2kzPU8Opww+y0ZLCle7L+p+Zifqy9FdnskhGeEDrcw7bHwyU8MDWAsb2kXjf4qAHii1qxHO/fTH7Js6W1RkRswzd7C69Kp4htJlZJJCcJIvt+xpg/A+BIUt/spmostK8DvfBZMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511534; c=relaxed/simple;
	bh=0qxT/iWPgC0Ok9rBiKIjoDJnPFrQv3pHHINa8ccSEZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nyQ+erfbhcmO9J04F1xrHVZoNLnzJEDJ0RPFOz0BfJEQaJ5cLfZfKBM7wDuMXsFhtvtskI5NT2k7hCYECHe+s0IZyJyXRwhsHTM1aun7bU06AmHqczcVOUiZvWiO7EKtZbBrJZzhBKN39FMFWSuGy0kPn7rmk6bo7Jw+CkCSqW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tlzoo7O6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731511532; x=1763047532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0qxT/iWPgC0Ok9rBiKIjoDJnPFrQv3pHHINa8ccSEZo=;
  b=Tlzoo7O6taAb+V0kE982QQq2tO32XevSYvRw/zGwGowo3w0xckKgBxJt
   wsOqV/KOrJyyMjfrMrM7ncLLiJXGudYwvzDNqvF9t7D0oGuTjQ9lPfjHH
   hZD4DA4PTq/nllyeGKH6DZx8KwB+T4+FztKHPK/RCFsfV6QRPwavYrdKj
   TxxXB55SraKHunqZCot7iCHEMwuSTczQZ7GHkagAGVR1moCKeTOQ8eHOK
   vQhR8ygahW3hn1OaJz7m/r2otpCw80VLT384QPoXtl2JEMNCtzZSlAwIS
   mlBribD7EoOTcKQ2SbFW4Uas4dlUEy6eHpFX6lZy9hmrW8UTs3M/jrPXT
   A==;
X-CSE-ConnectionGUID: 447LmedeTFOrxmnfMiib8A==
X-CSE-MsgGUID: Pp/iOiCXQE2i/33SB0Srsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42799295"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="42799295"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 07:25:21 -0800
X-CSE-ConnectionGUID: IsePiTBSS7aK0SApW2dfCg==
X-CSE-MsgGUID: vkVuD9ZNRre1266gIoh4NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="118726900"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 13 Nov 2024 07:25:17 -0800
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
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 05/19] xdp, xsk: constify read-only arguments of some static inline helpers
Date: Wed, 13 Nov 2024 16:24:28 +0100
Message-ID: <20241113152442.4000468-6-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Lots of read-only helpers for &xdp_buff and &xdp_frame, such as getting
the frame length, skb_shared_info etc., don't have their arguments
marked with `const` for no reason. Add the missing annotations to leave
less place for mistakes and more for optimization.

Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
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
2.47.0


