Return-Path: <bpf+bounces-16243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C5F7FEB92
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 10:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF1B1C20D59
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 09:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FEC38DE2;
	Thu, 30 Nov 2023 09:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YranIyUt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC452F86F;
	Thu, 30 Nov 2023 09:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F77CC433C8;
	Thu, 30 Nov 2023 09:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701335531;
	bh=I4Fy42cpWb80ck4Ga7ZC5RVC+AVpRWGFGLUCF3klNzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YranIyUtr/XVKp4HZpTDTjJ9Eub5Q2SD/y6DQdaEIMCAtwjH3Qfg5BDV8EkeITKGj
	 gAmLITX45UWXwUJoSrT/ccGdLN2dEq6yoGst+tIO77YS+Zn3PI5VUTVOgDaxkE62wg
	 YHgzM56PRnPOD/pGPDLnQG0HqrbiV8OuPadSUK1LCdi4Pg9a7lnsBpuITVcQQhaau0
	 UaNP+yQ+53F0Cb5sZosr0HgyYHGHfH/Xbopw4SK0bp8NsR8HsF8SKrikcsG4t9l0YI
	 COskTnCP0odqcjjHGFNEfLOqUuA/JSfkj4/Rvl4D2C32IHRmYO4rXYeHmzmtvCYvvQ
	 HK6GfTZ5aZWWQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	lorenzo.bianconi@redhat.com,
	bpf@vger.kernel.org,
	hawk@kernel.org,
	toke@redhat.com,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com
Subject: [PATCH v2 net-next 2/2] xdp: add multi-buff support for xdp running in generic mode
Date: Thu, 30 Nov 2023 10:11:49 +0100
Message-ID: <ce8cc5ce6e25d5e455704aa42fbf633be206ce85.1701334869.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701334869.git.lorenzo@kernel.org>
References: <cover.1701334869.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to native xdp, do not always linearize the skb in
netif_receive_generic_xdp routine but create a non-linear xdp_buff to be
processed by the eBPF program. This allow to add  multi-buffer support
for xdp running in generic mode.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/core/dev.c | 144 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 119 insertions(+), 25 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 4df68d7f04a2..0d08e755bb7f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4853,6 +4853,12 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	xdp_init_buff(xdp, frame_sz, &rxqueue->xdp_rxq);
 	xdp_prepare_buff(xdp, hard_start, skb_headroom(skb) - mac_len,
 			 skb_headlen(skb) + mac_len, true);
+	if (skb_is_nonlinear(skb)) {
+		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
+		xdp_buff_set_frags_flag(xdp);
+	} else {
+		xdp_buff_clear_frags_flag(xdp);
+	}
 
 	orig_data_end = xdp->data_end;
 	orig_data = xdp->data;
@@ -4882,6 +4888,14 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 		skb->len += off; /* positive on grow, negative on shrink */
 	}
 
+	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
+	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
+	 */
+	if (xdp_buff_has_frags(xdp))
+		skb->data_len = skb_shinfo(skb)->xdp_frags_size;
+	else
+		skb->data_len = 0;
+
 	/* check if XDP changed eth hdr such SKB needs update */
 	eth = (struct ethhdr *)xdp->data;
 	if ((orig_eth_type != eth->h_proto) ||
@@ -4915,54 +4929,134 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	return act;
 }
 
-static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
-				     struct xdp_buff *xdp,
-				     struct bpf_prog *xdp_prog)
+static int netif_skb_check_for_generic_xdp(struct sk_buff **pskb,
+					   struct bpf_prog *prog)
 {
 	struct sk_buff *skb = *pskb;
-	u32 act = XDP_DROP;
-
-	/* Reinjected packets coming from act_mirred or similar should
-	 * not get XDP generic processing.
-	 */
-	if (skb_is_redirected(skb))
-		return XDP_PASS;
+	int err;
 
-	/* XDP packets must be linear and must have sufficient headroom
-	 * of XDP_PACKET_HEADROOM bytes. This is the guarantee that also
-	 * native XDP provides, thus we need to do it here as well.
+	/* XDP does not support fraglist so we need to linearize
+	 * the skb.
 	 */
-	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
-	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
+	if (skb_has_frag_list(skb) || !prog->aux->xdp_has_frags) {
 		int hroom = XDP_PACKET_HEADROOM - skb_headroom(skb);
 		int troom = skb->tail + skb->data_len - skb->end;
 
 		/* In case we have to go down the path and also linearize,
 		 * then lets do the pskb_expand_head() work just once here.
 		 */
-		if (pskb_expand_head(skb,
-				     hroom > 0 ? ALIGN(hroom, NET_SKB_PAD) : 0,
-				     troom > 0 ? troom + 128 : 0, GFP_ATOMIC))
-			goto do_drop;
-		if (skb_linearize(skb))
-			goto do_drop;
+		err = pskb_expand_head(skb,
+				       hroom > 0 ? ALIGN(hroom, NET_SKB_PAD) : 0,
+				       troom > 0 ? troom + 128 : 0, GFP_ATOMIC);
+		if (err)
+			return err;
+
+		err = skb_linearize(skb);
+		if (err)
+			return err;
+
+		return 0;
+	}
+
+	/* XDP packets must have sufficient headroom of XDP_PACKET_HEADROOM
+	 * bytes. This is the guarantee that also native XDP provides,
+	 * thus we need to do it here as well.
+	 */
+	if (skb_cloned(skb) || skb_shinfo(skb)->nr_frags ||
+	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
+		u32 mac_len = skb->data - skb_mac_header(skb);
+		u32 size, len, max_head_size, off;
+		struct sk_buff *nskb;
+		int i, head_off;
+
+		__skb_push(skb, mac_len);
+		max_head_size = SKB_WITH_OVERHEAD(PAGE_SIZE -
+						  XDP_PACKET_HEADROOM);
+		if (skb->len > max_head_size + MAX_SKB_FRAGS * PAGE_SIZE)
+			return -ENOMEM;
+
+		size = min_t(u32, skb->len, max_head_size);
+		nskb = netdev_alloc_skb(skb->dev, size + XDP_PACKET_HEADROOM);
+		if (!nskb)
+			return -ENOMEM;
+
+		skb_reserve(nskb, XDP_PACKET_HEADROOM);
+		skb_copy_header(nskb, skb);
+
+		err = skb_copy_bits(skb, 0, nskb->data, size);
+		if (err) {
+			consume_skb(nskb);
+			return err;
+		}
+		skb_put(nskb, size);
+
+		head_off = skb_headroom(nskb) - skb_headroom(skb);
+		skb_headers_offset_update(nskb, head_off);
+
+		off = size;
+		len = skb->len - off;
+		for (i = 0; i < MAX_SKB_FRAGS && off < skb->len; i++) {
+			struct page *page;
+			void *frag;
+
+			size = min_t(u32, len, PAGE_SIZE);
+			frag = netdev_alloc_frag(size);
+			if (!frag) {
+				consume_skb(nskb);
+				return -ENOMEM;
+			}
+
+			page = virt_to_head_page(frag);
+			skb_add_rx_frag(nskb, i, page,
+					frag - page_address(page), size, size);
+			err = skb_copy_bits(skb, off, frag, size);
+			if (err) {
+				consume_skb(nskb);
+				return err;
+			}
+
+			len -= size;
+			off += size;
+		}
+
+		consume_skb(skb);
+		*pskb = nskb;
+		__skb_pull(nskb, mac_len);
 	}
 
-	act = bpf_prog_run_generic_xdp(skb, xdp, xdp_prog);
+	return 0;
+}
+
+static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
+				     struct xdp_buff *xdp,
+				     struct bpf_prog *xdp_prog)
+{
+	u32 act = XDP_DROP;
+
+	/* Reinjected packets coming from act_mirred or similar should
+	 * not get XDP generic processing.
+	 */
+	if (skb_is_redirected(*pskb))
+		return XDP_PASS;
+
+	if (netif_skb_check_for_generic_xdp(pskb, xdp_prog))
+		goto do_drop;
+
+	act = bpf_prog_run_generic_xdp(*pskb, xdp, xdp_prog);
 	switch (act) {
 	case XDP_REDIRECT:
 	case XDP_TX:
 	case XDP_PASS:
 		break;
 	default:
-		bpf_warn_invalid_xdp_action(skb->dev, xdp_prog, act);
+		bpf_warn_invalid_xdp_action((*pskb)->dev, xdp_prog, act);
 		fallthrough;
 	case XDP_ABORTED:
-		trace_xdp_exception(skb->dev, xdp_prog, act);
+		trace_xdp_exception((*pskb)->dev, xdp_prog, act);
 		fallthrough;
 	case XDP_DROP:
 	do_drop:
-		kfree_skb(skb);
+		kfree_skb(*pskb);
 		break;
 	}
 
-- 
2.43.0


