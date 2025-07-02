Return-Path: <bpf+bounces-62122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30ECDAF5BE6
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 16:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321503A61A7
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 14:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE01D30B986;
	Wed,  2 Jul 2025 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHPXdAA3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECA030AAD2;
	Wed,  2 Jul 2025 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468305; cv=none; b=YVSQU68+mItWvuWComsN0aukW2GUIoEwSbLIqj1mBWAGsorPneHiC0Ii3/+DWQ0gaCDBhPpsyXBXRQpuI5cYlhMhiIAzT/+mnnMW1Pz+O6NWDTrImNGf6u9zbNrMx/0rLYNKOdqCSS8M1nZG3Gvby6H5ij2tTu5dsUkta2SURH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468305; c=relaxed/simple;
	bh=jqlJSY6tBiQOqO1kaimerFcbgakCOt6jYGH0KGX3vtI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ouhNopgDs/Znavev8P4rPByhHAerK8a2vDXP1ZtfKQ99SsfcveGcNt+sGucmZvIYPBmJkbJHbTB7DUIG+BcbuuCg1p+szXIXJRwP02jbhg5Otbu2sisxNFYQFgggyK1smkSwf+Fm0PvxirRcS/3LEgfLO6hlzSjWK87A3X98bTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHPXdAA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46776C4CEE7;
	Wed,  2 Jul 2025 14:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751468304;
	bh=jqlJSY6tBiQOqO1kaimerFcbgakCOt6jYGH0KGX3vtI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=YHPXdAA3BFjEHA0RpZVmQd1H9W24i+ZXKStqkiNt4mt4+tl+0U01JL+9wGzdeFRro
	 PgReAlaFJOyG2pOYKo+3NTttkZ1QXrI+mZVEC3j33Db7KiXShM7w95qFJ4RLWc/CaD
	 eOqc9msCwVkV23JP0rTZNoh7osj7pzXV+P5rhkj/dXZCuics+zg2Nkfh/SckaToX4d
	 0WeN9kOqvMWX/Lwfj00xF+yrx/tHzkHnK1iJsGZRh1sshJq/CJosH4x8y7XKj+bL7j
	 TOJb/X4e0r0ZL1xfaZT8FLeeogmN7LY/o/Q3MEgdtV0apZ5wKOdJY/up1k8bFh2Oc9
	 0R3XXFqwvWlQw==
Subject: [PATCH bpf-next V2 1/7] net: xdp: Add xdp_rx_meta structure
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, lorenzo@kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <borkmann@iogearbox.net>,
 Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 sdf@fomichev.me, kernel-team@cloudflare.com, arthur@arthurfabre.com,
 jakub@cloudflare.com
Date: Wed, 02 Jul 2025 16:58:19 +0200
Message-ID: <175146829944.1421237.13943404585579626611.stgit@firesoul>
In-Reply-To: <175146824674.1421237.18351246421763677468.stgit@firesoul>
References: <175146824674.1421237.18351246421763677468.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Lorenzo Bianconi <lorenzo@kernel.org>

Introduce the `xdp_rx_meta` structure to serve as a container for XDP RX
hardware hints within XDP packet buffers. Initially, this structure will
accommodate `rx_hash` and `rx_vlan` metadata. (The `rx_timestamp` hint will
get stored in `skb_shared_info`).

A key design aspect is making this metadata accessible both during BPF
program execution (via `struct xdp_buff`) and later if an `struct
xdp_frame` is materialized (e.g., for XDP_REDIRECT).
To achieve this:
  - The `struct xdp_frame` embeds an `xdp_rx_meta` field directly for
    storage.
  - The `struct xdp_buff` includes an `xdp_rx_meta` pointer. This pointer
    is initialized (in `xdp_prepare_buff`) to point to the memory location
    within the packet buffer's headroom where the `xdp_frame`'s embedded
    `rx_meta` field would reside.

This setup allows BPF kfuncs, operating on `xdp_buff`, to populate the
metadata in the precise location where it will be found if an `xdp_frame`
is subsequently created.

The availability of this metadata storage area within the buffer is
indicated by the `XDP_FLAGS_META_AREA` flag in `xdp_buff->flags` (and
propagated to `xdp_frame->flags`). This flag is only set if sufficient
headroom (at least `XDP_MIN_HEADROOM`, currently 192 bytes) is present.
Specific hints like `XDP_FLAGS_META_RX_HASH` and `XDP_FLAGS_META_RX_VLAN`
will then denote which types of metadata have been populated into the
`xdp_rx_meta` structure.

This patch is a step for enabling the preservation and use of XDP RX
hints across operations like XDP_REDIRECT.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 include/net/xdp.h       |   57 +++++++++++++++++++++++++++++++++++------------
 net/core/xdp.c          |    1 +
 net/xdp/xsk_buff_pool.c |    4 ++-
 3 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index b40f1f96cb11..f52742a25212 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -71,11 +71,31 @@ struct xdp_txq_info {
 	struct net_device *dev;
 };
 
+struct xdp_rx_meta {
+	struct xdp_rx_meta_hash {
+		u32 val;
+		u32 type; /* enum xdp_rss_hash_type */
+	} hash;
+	struct xdp_rx_meta_vlan {
+		__be16 proto;
+		u16 tci;
+	} vlan;
+};
+
+/* Storage area for HW RX metadata only available with reasonable headroom
+ * available. Less than XDP_PACKET_HEADROOM due to Intel drivers.
+ */
+#define XDP_MIN_HEADROOM	192
+
 enum xdp_buff_flags {
 	XDP_FLAGS_HAS_FRAGS		= BIT(0), /* non-linear xdp buff */
 	XDP_FLAGS_FRAGS_PF_MEMALLOC	= BIT(1), /* xdp paged memory is under
 						   * pressure
 						   */
+	XDP_FLAGS_META_AREA		= BIT(2), /* storage area available */
+	XDP_FLAGS_META_RX_HASH		= BIT(3), /* hw rx hash */
+	XDP_FLAGS_META_RX_VLAN		= BIT(4), /* hw rx vlan */
+	XDP_FLAGS_META_RX_TS		= BIT(5), /* hw rx timestamp */
 };
 
 struct xdp_buff {
@@ -87,6 +107,24 @@ struct xdp_buff {
 	struct xdp_txq_info *txq;
 	u32 frame_sz; /* frame size to deduce data_hard_end/reserved tailroom*/
 	u32 flags; /* supported values defined in xdp_buff_flags */
+	struct xdp_rx_meta *rx_meta; /* rx hw metadata pointer in the
+				      * buffer headroom
+				      */
+};
+
+struct xdp_frame {
+	void *data;
+	u32 len;
+	u32 headroom;
+	u32 metasize; /* uses lower 8-bits */
+	/* Lifetime of xdp_rxq_info is limited to NAPI/enqueue time,
+	 * while mem_type is valid on remote CPU.
+	 */
+	enum xdp_mem_type mem_type:32;
+	struct net_device *dev_rx; /* used by cpumap */
+	u32 frame_sz;
+	u32 flags; /* supported values defined in xdp_buff_flags */
+	struct xdp_rx_meta rx_meta; /* rx hw metadata */
 };
 
 static __always_inline bool xdp_buff_has_frags(const struct xdp_buff *xdp)
@@ -133,6 +171,9 @@ xdp_prepare_buff(struct xdp_buff *xdp, unsigned char *hard_start,
 	xdp->data = data;
 	xdp->data_end = data + data_len;
 	xdp->data_meta = meta_valid ? data : data + 1;
+	xdp->flags = (headroom < XDP_MIN_HEADROOM) ? 0 : XDP_FLAGS_META_AREA;
+	xdp->rx_meta = (void *)(hard_start +
+				offsetof(struct xdp_frame, rx_meta));
 }
 
 /* Reserve memory area at end-of data area.
@@ -253,20 +294,6 @@ static inline bool xdp_buff_add_frag(struct xdp_buff *xdp, netmem_ref netmem,
 	return true;
 }
 
-struct xdp_frame {
-	void *data;
-	u32 len;
-	u32 headroom;
-	u32 metasize; /* uses lower 8-bits */
-	/* Lifetime of xdp_rxq_info is limited to NAPI/enqueue time,
-	 * while mem_type is valid on remote CPU.
-	 */
-	enum xdp_mem_type mem_type:32;
-	struct net_device *dev_rx; /* used by cpumap */
-	u32 frame_sz;
-	u32 flags; /* supported values defined in xdp_buff_flags */
-};
-
 static __always_inline bool xdp_frame_has_frags(const struct xdp_frame *frame)
 {
 	return !!(frame->flags & XDP_FLAGS_HAS_FRAGS);
@@ -355,6 +382,8 @@ void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
 	xdp->data_meta = frame->data - frame->metasize;
 	xdp->frame_sz = frame->frame_sz;
 	xdp->flags = frame->flags;
+	xdp->rx_meta = xdp->data_hard_start +
+		       offsetof(struct xdp_frame, rx_meta);
 }
 
 static inline
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 491334b9b8be..bd3110fc7ef8 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -606,6 +606,7 @@ struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
 	xdpf->metasize = metasize;
 	xdpf->frame_sz = PAGE_SIZE;
 	xdpf->mem_type = MEM_TYPE_PAGE_ORDER0;
+	memcpy(&xdpf->rx_meta, xdp->rx_meta, sizeof(*xdp->rx_meta));
 
 	xsk_buff_free(xdp);
 	return xdpf;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index aa9788f20d0d..de42dacdcb25 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -574,7 +574,9 @@ struct xdp_buff *xp_alloc(struct xsk_buff_pool *pool)
 
 	xskb->xdp.data = xskb->xdp.data_hard_start + XDP_PACKET_HEADROOM;
 	xskb->xdp.data_meta = xskb->xdp.data;
-	xskb->xdp.flags = 0;
+	xskb->xdp.flags = XDP_FLAGS_META_AREA;
+	xskb->xdp.rx_meta = (void *)(xskb->xdp.data_hard_start +
+				     offsetof(struct xdp_frame, rx_meta));
 
 	if (pool->dev)
 		xp_dma_sync_for_device(pool, xskb->dma, pool->frame_len);



