Return-Path: <bpf+bounces-46015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2189E2C65
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 20:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C633B855EA
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 17:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E944204092;
	Tue,  3 Dec 2024 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XBh7Cg7L"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95771FBCB2;
	Tue,  3 Dec 2024 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247663; cv=none; b=omUgih61ELxVXmZ2utNazCMIsJh3ltGmK3gkMPDyeIN4gYXDXKV+trZe+2mX1UCX+c0guRhcctYRGkDpU8vzp0zQPdPg4/quyVoENxJhxzhPYpNjhlHZuBlwiJ4uev8KQdpF1/xY49WZK9SY+VVmMScHybWf/jfbdxbvT1xkGoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247663; c=relaxed/simple;
	bh=WZHidRDKPdD7CptHFczDk4P2mgnWZeYFroM61vl4WEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HEH+TWjRdtYdocoVoB6s/Givz//wBNezN+3Ed8PhJjIXNrnWXacfAXL2GbPU6GstVuZSlge1soGXnKplGKU4gl5lGUxAqxj/qkkwnnjTHtwlCxdkqFlq3LMpYLUWQr9Z+mD9NaiHV4xmeoaKre34I7CxbiQF+fI/J/zwcU+a4wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XBh7Cg7L; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733247662; x=1764783662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WZHidRDKPdD7CptHFczDk4P2mgnWZeYFroM61vl4WEY=;
  b=XBh7Cg7Lbro6lIuZGLK64smEG3hulT+pA7rPqUt7J6zEk0gqq5uDH6Te
   R2eo8LmWNiuZ5+OwBZUSUbfu6WP/pN+XUSrPcGI+1FY5owFov3A4jjdKE
   FYCDr8kNN9n9wx0qxD1GBON17ILD7x4aELBybYgEqKzghAoxjFI6KaFzJ
   8SGQTZJlg2kIIuN88IJWUBGyWhoPQW8/z8cnQyjDIag1fJBtIsnnO+nKj
   F9pFKwlXZ1cPWQGzYNXz+j7TZYRGSlAcWfkyUIPJhTE7mhbQhozGhkYGu
   UTtpW2rn4p349CbC/vZTPono8QQFvpgNgVcmX2AMXxdNrv9um6dYZHwdY
   g==;
X-CSE-ConnectionGUID: 39m+luvTQgKuoq/mkcRpvA==
X-CSE-MsgGUID: 6/HxaPWrSKuHuwFylOMOfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="37135307"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="37135307"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 09:41:02 -0800
X-CSE-ConnectionGUID: qmrTu8fGRhO6ocAlxUXqfQ==
X-CSE-MsgGUID: /gZzYCe1S1iAWYIrhiNTwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="124337017"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 03 Dec 2024 09:40:58 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 03/10] xdp, xsk: constify read-only arguments of some static inline helpers
Date: Tue,  3 Dec 2024 18:37:26 +0100
Message-ID: <20241203173733.3181246-4-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241203173733.3181246-1-aleksander.lobakin@intel.com>
References: <20241203173733.3181246-1-aleksander.lobakin@intel.com>
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
index 7637799b6c19..50779406bc2d 100644
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


