Return-Path: <bpf+bounces-44263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A82C9C0B40
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 17:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB6A1F21E7B
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 16:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BFB219C8E;
	Thu,  7 Nov 2024 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WoiYQn07"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F332194B5;
	Thu,  7 Nov 2024 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996067; cv=none; b=jA9CHq+ZAKrurLlAtKmwe9qCBMn8uvQTftV5Lt9GAL5ZlmgM+9OcONz77XiQgCJ1XaBY/tbIzb3olaXxUeMGImYkF/xsvILg/nze+weGlBTjS98I1vXuKO9hJSWQqSOGI8rFTMfWoq5zkkOKDrdp/DXQ+y+fZRchpUvbaYbmguE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996067; c=relaxed/simple;
	bh=AUfgxC1hbYERhOuFgSeAFVqgl/lLxACb0B2Z0vllRWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNywAeTCGtvW/18kmiBLfDnT+DAuIuA7S/MzQN7/jHGicg1FWeTg7RMWqJR/j2lZLJIZ8ptKVAeKnZAGyuQFEo0m5pKgVRAKMttGjmgwAL1oKvYugtzPm7RZg0pklTaKvDahqUEqnReZSIPoFyW1P5zTqYkp4CsKSnFMg3wGkv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WoiYQn07; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730996065; x=1762532065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AUfgxC1hbYERhOuFgSeAFVqgl/lLxACb0B2Z0vllRWU=;
  b=WoiYQn07gn0cbnF6+M8oWPcJADs7e/TtcLHRPaUWwrQzqMbhakbOWG3A
   /jraMD0gU0vHKZGGX1VRXd5t+LPdlFY4ln5QDWIjB0X9mhRdz0s9A4kMi
   5sjTd7U0G0jl2g3URklzcJ4Lw+uEzexdPUHftX+ps3eQiOhshExn4ibTn
   KBOfxUQWWeMK/G53nu/+zy9DkwPvxedYbKSgW4frQLa8R2ISRpbhg3q+i
   t4esDRpdWyDVOpjvP1bXrE7awiqHIwLfLmZqM4Qe39VF6xrNSfFXbjYTl
   lP0/k0RaUkd0R6PJMGey+0BVgZ0LwqDzfKhhuabAIl3y2X4Q9A/b+aw1R
   A==;
X-CSE-ConnectionGUID: QrwiMiRuSJyV0JH8jBCAcg==
X-CSE-MsgGUID: 7BHJ7PslSSK986+fVPvAPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41955974"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41955974"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 08:14:24 -0800
X-CSE-ConnectionGUID: +JPMt5aeTrONpEs3Jx9wYA==
X-CSE-MsgGUID: 6xVCgUSeRGCkQGGoMxKePw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="90258221"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 07 Nov 2024 08:14:21 -0800
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
Subject: [PATCH net-next v4 10/19] xdp: get rid of xdp_frame::mem.id
Date: Thu,  7 Nov 2024 17:10:17 +0100
Message-ID: <20241107161026.2903044-11-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107161026.2903044-1-aleksander.lobakin@intel.com>
References: <20241107161026.2903044-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Initially, xdp_frame::mem.id was used to search for the corresponding
&page_pool to return the page correctly.
However, after that struct page now contains a direct pointer to its PP,
further keeping of this field makes no sense. xdp_return_frame_bulk()
still uses it to do a lookup, but this is rather a leftover.
Remove xdp_frame::mem and replace it with ::mem_type, as only memory
type still matters and we need to know it to be able to free the frame
correctly.
As a cute side effect, we can now make every scalar field in &xdp_frame
of 4 byte width, speeding up accesses to them.

Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/xdp.h                             | 14 +++++-----
 .../net/ethernet/freescale/dpaa/dpaa_eth.c    |  2 +-
 drivers/net/veth.c                            |  4 +--
 kernel/bpf/cpumap.c                           |  2 +-
 net/bpf/test_run.c                            |  4 +--
 net/core/filter.c                             | 12 ++++----
 net/core/xdp.c                                | 28 +++++++++----------
 7 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index cce819ee17d3..d33d73e798fe 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -169,13 +169,13 @@ xdp_get_buff_len(const struct xdp_buff *xdp)
 
 struct xdp_frame {
 	void *data;
-	u16 len;
-	u16 headroom;
+	u32 len;
+	u32 headroom;
 	u32 metasize; /* uses lower 8-bits */
 	/* Lifetime of xdp_rxq_info is limited to NAPI/enqueue time,
-	 * while mem info is valid on remote CPU.
+	 * while mem_type is valid on remote CPU.
 	 */
-	struct xdp_mem_info mem;
+	enum xdp_mem_type mem_type:32;
 	struct net_device *dev_rx; /* used by cpumap */
 	u32 frame_sz;
 	u32 flags; /* supported values defined in xdp_buff_flags */
@@ -306,13 +306,13 @@ struct xdp_frame *xdp_convert_buff_to_frame(struct xdp_buff *xdp)
 	if (unlikely(xdp_update_frame_from_buff(xdp, xdp_frame) < 0))
 		return NULL;
 
-	/* rxq only valid until napi_schedule ends, convert to xdp_mem_info */
-	xdp_frame->mem = xdp->rxq->mem;
+	/* rxq only valid until napi_schedule ends, convert to xdp_mem_type */
+	xdp_frame->mem_type = xdp->rxq->mem.type;
 
 	return xdp_frame;
 }
 
-void __xdp_return(void *data, struct xdp_mem_info *mem, bool napi_direct,
+void __xdp_return(void *data, enum xdp_mem_type mem_type, bool napi_direct,
 		  struct xdp_buff *xdp);
 void xdp_return_frame(struct xdp_frame *xdpf);
 void xdp_return_frame_rx_napi(struct xdp_frame *xdpf);
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index bf5baef5c3e0..4948b4906584 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2281,7 +2281,7 @@ static int dpaa_a050385_wa_xdpf(struct dpaa_priv *priv,
 	new_xdpf->len = xdpf->len;
 	new_xdpf->headroom = priv->tx_headroom;
 	new_xdpf->frame_sz = DPAA_BP_RAW_SIZE;
-	new_xdpf->mem.type = MEM_TYPE_PAGE_ORDER0;
+	new_xdpf->mem_type = MEM_TYPE_PAGE_ORDER0;
 
 	/* Release the initial buffer */
 	xdp_return_frame_rx_napi(xdpf);
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 18148e068aa0..fd36d0529e51 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -634,7 +634,7 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
 			break;
 		case XDP_TX:
 			orig_frame = *frame;
-			xdp->rxq->mem = frame->mem;
+			xdp->rxq->mem.type = frame->mem_type;
 			if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
 				trace_xdp_exception(rq->dev, xdp_prog, act);
 				frame = &orig_frame;
@@ -646,7 +646,7 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
 			goto xdp_xmit;
 		case XDP_REDIRECT:
 			orig_frame = *frame;
-			xdp->rxq->mem = frame->mem;
+			xdp->rxq->mem.type = frame->mem_type;
 			if (xdp_do_redirect(rq->dev, xdp, xdp_prog)) {
 				frame = &orig_frame;
 				stats->rx_drops++;
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index a2f46785ac3b..774accbd4a22 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -190,7 +190,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 		int err;
 
 		rxq.dev = xdpf->dev_rx;
-		rxq.mem = xdpf->mem;
+		rxq.mem.type = xdpf->mem_type;
 		/* TODO: report queue_index to xdp_rxq_info */
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 501ec4249fed..9ae2a7f1738b 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -153,7 +153,7 @@ static void xdp_test_run_init_page(netmem_ref netmem, void *arg)
 	new_ctx->data = new_ctx->data_meta + meta_len;
 
 	xdp_update_frame_from_buff(new_ctx, frm);
-	frm->mem = new_ctx->rxq->mem;
+	frm->mem_type = new_ctx->rxq->mem.type;
 
 	memcpy(&head->orig_ctx, new_ctx, sizeof(head->orig_ctx));
 }
@@ -246,7 +246,7 @@ static void reset_ctx(struct xdp_page_head *head)
 	head->ctx.data_meta = head->orig_ctx.data_meta;
 	head->ctx.data_end = head->orig_ctx.data_end;
 	xdp_update_frame_from_buff(&head->ctx, head->frame);
-	head->frame->mem = head->orig_ctx.rxq->mem;
+	head->frame->mem_type = head->orig_ctx.rxq->mem.type;
 }
 
 static int xdp_recv_frames(struct xdp_frame **frames, int nframes,
diff --git a/net/core/filter.c b/net/core/filter.c
index b40e091a764d..3ea82ff692fb 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4105,13 +4105,13 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)
 }
 
 static void bpf_xdp_shrink_data_zc(struct xdp_buff *xdp, int shrink,
-				   struct xdp_mem_info *mem_info, bool release)
+				   enum xdp_mem_type mem_type, bool release)
 {
 	struct xdp_buff *zc_frag = xsk_buff_get_tail(xdp);
 
 	if (release) {
 		xsk_buff_del_tail(zc_frag);
-		__xdp_return(NULL, mem_info, false, zc_frag);
+		__xdp_return(NULL, mem_type, false, zc_frag);
 	} else {
 		zc_frag->data_end -= shrink;
 	}
@@ -4120,18 +4120,18 @@ static void bpf_xdp_shrink_data_zc(struct xdp_buff *xdp, int shrink,
 static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
 				int shrink)
 {
-	struct xdp_mem_info *mem_info = &xdp->rxq->mem;
+	enum xdp_mem_type mem_type = xdp->rxq->mem.type;
 	bool release = skb_frag_size(frag) == shrink;
 
-	if (mem_info->type == MEM_TYPE_XSK_BUFF_POOL) {
-		bpf_xdp_shrink_data_zc(xdp, shrink, mem_info, release);
+	if (mem_type == MEM_TYPE_XSK_BUFF_POOL) {
+		bpf_xdp_shrink_data_zc(xdp, shrink, mem_type, release);
 		goto out;
 	}
 
 	if (release) {
 		struct page *page = skb_frag_page(frag);
 
-		__xdp_return(page_address(page), mem_info, false, NULL);
+		__xdp_return(page_address(page), mem_type, false, NULL);
 	}
 
 out:
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 0fde1bb54192..b1b426a9b146 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -427,12 +427,12 @@ EXPORT_SYMBOL_GPL(xdp_rxq_info_attach_page_pool);
  * is used for those calls sites.  Thus, allowing for faster recycling
  * of xdp_frames/pages in those cases.
  */
-void __xdp_return(void *data, struct xdp_mem_info *mem, bool napi_direct,
+void __xdp_return(void *data, enum xdp_mem_type mem_type, bool napi_direct,
 		  struct xdp_buff *xdp)
 {
 	struct page *page;
 
-	switch (mem->type) {
+	switch (mem_type) {
 	case MEM_TYPE_PAGE_POOL:
 		page = virt_to_head_page(data);
 		if (napi_direct && xdp_return_frame_no_direct())
@@ -455,7 +455,7 @@ void __xdp_return(void *data, struct xdp_mem_info *mem, bool napi_direct,
 		break;
 	default:
 		/* Not possible, checked in xdp_rxq_info_reg_mem_model() */
-		WARN(1, "Incorrect XDP memory type (%d) usage", mem->type);
+		WARN(1, "Incorrect XDP memory type (%d) usage", mem_type);
 		break;
 	}
 }
@@ -472,10 +472,10 @@ void xdp_return_frame(struct xdp_frame *xdpf)
 	for (i = 0; i < sinfo->nr_frags; i++) {
 		struct page *page = skb_frag_page(&sinfo->frags[i]);
 
-		__xdp_return(page_address(page), &xdpf->mem, false, NULL);
+		__xdp_return(page_address(page), xdpf->mem_type, false, NULL);
 	}
 out:
-	__xdp_return(xdpf->data, &xdpf->mem, false, NULL);
+	__xdp_return(xdpf->data, xdpf->mem_type, false, NULL);
 }
 EXPORT_SYMBOL_GPL(xdp_return_frame);
 
@@ -491,10 +491,10 @@ void xdp_return_frame_rx_napi(struct xdp_frame *xdpf)
 	for (i = 0; i < sinfo->nr_frags; i++) {
 		struct page *page = skb_frag_page(&sinfo->frags[i]);
 
-		__xdp_return(page_address(page), &xdpf->mem, true, NULL);
+		__xdp_return(page_address(page), xdpf->mem_type, true, NULL);
 	}
 out:
-	__xdp_return(xdpf->data, &xdpf->mem, true, NULL);
+	__xdp_return(xdpf->data, xdpf->mem_type, true, NULL);
 }
 EXPORT_SYMBOL_GPL(xdp_return_frame_rx_napi);
 
@@ -513,7 +513,7 @@ EXPORT_SYMBOL_GPL(xdp_return_frame_rx_napi);
 void xdp_return_frame_bulk(struct xdp_frame *xdpf,
 			   struct xdp_frame_bulk *bq)
 {
-	if (xdpf->mem.type != MEM_TYPE_PAGE_POOL) {
+	if (xdpf->mem_type != MEM_TYPE_PAGE_POOL) {
 		xdp_return_frame(xdpf);
 		return;
 	}
@@ -550,10 +550,11 @@ void xdp_return_buff(struct xdp_buff *xdp)
 	for (i = 0; i < sinfo->nr_frags; i++) {
 		struct page *page = skb_frag_page(&sinfo->frags[i]);
 
-		__xdp_return(page_address(page), &xdp->rxq->mem, true, xdp);
+		__xdp_return(page_address(page), xdp->rxq->mem.type, true,
+			     xdp);
 	}
 out:
-	__xdp_return(xdp->data, &xdp->rxq->mem, true, xdp);
+	__xdp_return(xdp->data, xdp->rxq->mem.type, true, xdp);
 }
 EXPORT_SYMBOL_GPL(xdp_return_buff);
 
@@ -599,7 +600,7 @@ struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
 	xdpf->headroom = 0;
 	xdpf->metasize = metasize;
 	xdpf->frame_sz = PAGE_SIZE;
-	xdpf->mem.type = MEM_TYPE_PAGE_ORDER0;
+	xdpf->mem_type = MEM_TYPE_PAGE_ORDER0;
 
 	xsk_buff_free(xdp);
 	return xdpf;
@@ -669,7 +670,7 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 	 * - RX ring dev queue index	(skb_record_rx_queue)
 	 */
 
-	if (xdpf->mem.type == MEM_TYPE_PAGE_POOL)
+	if (xdpf->mem_type == MEM_TYPE_PAGE_POOL)
 		skb_mark_for_recycle(skb);
 
 	/* Allow SKB to reuse area used by xdp_frame */
@@ -716,8 +717,7 @@ struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf)
 	nxdpf = addr;
 	nxdpf->data = addr + headroom;
 	nxdpf->frame_sz = PAGE_SIZE;
-	nxdpf->mem.type = MEM_TYPE_PAGE_ORDER0;
-	nxdpf->mem.id = 0;
+	nxdpf->mem_type = MEM_TYPE_PAGE_ORDER0;
 
 	return nxdpf;
 }
-- 
2.47.0


