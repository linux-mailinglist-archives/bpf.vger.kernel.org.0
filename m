Return-Path: <bpf+bounces-20521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81F483F5D3
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 15:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 385ABB226B8
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 14:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BB128E0F;
	Sun, 28 Jan 2024 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2DVhC5a"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6E324208;
	Sun, 28 Jan 2024 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706451736; cv=none; b=BcmzOpsiKW8cA/o/dIZHIG4kfVLxL3ZrPneHlngsOvSBDvzL99rPZJlDhN6HU3MOXo9wEeKsDylKs7fAPJn42ybggWgHALnBCBeKCW7h0WK9SpeeobZUyoeIyZ67rW7mVr9BGj4hVkr0FLG72uHMTD/ti4EFsx0PtaEwRfgZ9Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706451736; c=relaxed/simple;
	bh=JLsVjDwv4U9XRkH6tXDLlha24RZBYQV0xD3WrVD51lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csp+wWxXuCHwUq2p7oGf5+v17uJWsawdr9dmjlALTilTg/5m/crfdh8k8IYituzbx4dEhIAkbdn9mofmHPy+GFEqC2m5GwetLi7I5hSfGzEUPaJeMOVmDNBIMnu0n/ePvj6mfMx1ThleIEDJowQWanFTjiJr67G6TK78rIABcCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2DVhC5a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04275C433C7;
	Sun, 28 Jan 2024 14:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706451736;
	bh=JLsVjDwv4U9XRkH6tXDLlha24RZBYQV0xD3WrVD51lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b2DVhC5agQiFGFxl32tkKen55MO1E3Va1IOoTYk0ouFrOD4hIM4MlKBTOX1hbKo13
	 D2g8wDtoddry6TUvRfMQhYzhjvk4mTd3MYM/b6YeYPVFZqypTNZdXLK18OTScJtZHu
	 b+cHgKaRWBHpMQndCmILyl+SRgAHUsvl5fUJMcI4oQ18BJVq1xyMYd2xqXg7DW1/Cc
	 +cploIlH2VZq0fq/EO1/iR+8J2KLt/nmKXmI7vPQCGzOBDeQ4aeRD6/Ypy25yRVhhE
	 kfiL67kPhBf66+ALpMJC+vFEOqAoNhMR5zC0AEejqWwYjFHy4G4gQCXWdymVqHH3gF
	 Nt4903cP7i9Qw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	toke@redhat.com,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	sdf@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org
Subject: [PATCH v6 net-next 3/5] xdp: add multi-buff support for xdp running in generic mode
Date: Sun, 28 Jan 2024 15:20:39 +0100
Message-ID: <c93dce1f78bd383c117311e4d53e2766264f6759.1706451150.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706451150.git.lorenzo@kernel.org>
References: <cover.1706451150.git.lorenzo@kernel.org>
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
 net/core/dev.c | 152 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 133 insertions(+), 19 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 960f39ac5e33..19f92ba90e49 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4862,6 +4862,12 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
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
@@ -4891,6 +4897,14 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
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
@@ -4924,12 +4938,117 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	return act;
 }
 
+#if IS_ENABLED(CONFIG_PAGE_POOL)
+static int
+netif_skb_segment_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
+			  struct bpf_prog *prog)
+{
+	u32 size, truesize, len, max_head_size, off;
+	struct sk_buff *skb = *pskb, *nskb;
+	int err, i, head_off;
+	void *data;
+
+	/* XDP does not support fraglist so we need to linearize
+	 * the skb.
+	 */
+	if (skb_has_frag_list(skb) || !prog->aux->xdp_has_frags)
+		return -EOPNOTSUPP;
+
+	max_head_size = SKB_WITH_OVERHEAD(PAGE_SIZE - XDP_PACKET_HEADROOM);
+	if (skb->len > max_head_size + MAX_SKB_FRAGS * PAGE_SIZE)
+		return -ENOMEM;
+
+	size = min_t(u32, skb->len, max_head_size);
+	truesize = SKB_HEAD_ALIGN(size) + XDP_PACKET_HEADROOM;
+	data = page_pool_dev_alloc_va(pool, &truesize);
+	if (!data)
+		return -ENOMEM;
+
+	nskb = napi_build_skb(data, truesize);
+	if (!nskb) {
+		page_pool_free_va(pool, data, true);
+		return -ENOMEM;
+	}
+
+	skb_reserve(nskb, XDP_PACKET_HEADROOM);
+	skb_copy_header(nskb, skb);
+	skb_mark_for_recycle(nskb);
+
+	err = skb_copy_bits(skb, 0, nskb->data, size);
+	if (err) {
+		consume_skb(nskb);
+		return err;
+	}
+	skb_put(nskb, size);
+
+	head_off = skb_headroom(nskb) - skb_headroom(skb);
+	skb_headers_offset_update(nskb, head_off);
+
+	off = size;
+	len = skb->len - off;
+	for (i = 0; i < MAX_SKB_FRAGS && off < skb->len; i++) {
+		struct page *page;
+		u32 page_off;
+
+		size = min_t(u32, len, PAGE_SIZE);
+		truesize = size;
+
+		page = page_pool_dev_alloc(pool, &page_off, &truesize);
+		if (!data) {
+			consume_skb(nskb);
+			return -ENOMEM;
+		}
+
+		skb_add_rx_frag(nskb, i, page, page_off, size, truesize);
+		err = skb_copy_bits(skb, off, page_address(page) + page_off,
+				    size);
+		if (err) {
+			consume_skb(nskb);
+			return err;
+		}
+
+		len -= size;
+		off += size;
+	}
+
+	consume_skb(skb);
+	*pskb = nskb;
+
+	return 0;
+}
+#endif
+
+static int
+netif_skb_check_for_xdp(struct sk_buff **pskb, struct bpf_prog *prog)
+{
+	struct sk_buff *skb = *pskb;
+	int err, hroom, troom;
+
+#if IS_ENABLED(CONFIG_PAGE_POOL)
+	if (!netif_skb_segment_for_xdp(this_cpu_read(page_pool), pskb, prog))
+		return 0;
+#endif
+
+	/* In case we have to go down the path and also linearize,
+	 * then lets do the pskb_expand_head() work just once here.
+	 */
+	hroom = XDP_PACKET_HEADROOM - skb_headroom(skb);
+	troom = skb->tail + skb->data_len - skb->end;
+	err = pskb_expand_head(skb,
+			       hroom > 0 ? ALIGN(hroom, NET_SKB_PAD) : 0,
+			       troom > 0 ? troom + 128 : 0, GFP_ATOMIC);
+	if (err)
+		return err;
+
+	return skb_linearize(skb);
+}
+
 static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
 				     struct xdp_buff *xdp,
 				     struct bpf_prog *xdp_prog)
 {
 	struct sk_buff *skb = *pskb;
-	u32 act = XDP_DROP;
+	u32 mac_len, act = XDP_DROP;
 
 	/* Reinjected packets coming from act_mirred or similar should
 	 * not get XDP generic processing.
@@ -4937,41 +5056,36 @@ static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
 	if (skb_is_redirected(skb))
 		return XDP_PASS;
 
-	/* XDP packets must be linear and must have sufficient headroom
-	 * of XDP_PACKET_HEADROOM bytes. This is the guarantee that also
-	 * native XDP provides, thus we need to do it here as well.
+	/* XDP packets must have sufficient headroom of XDP_PACKET_HEADROOM
+	 * bytes. This is the guarantee that also native XDP provides,
+	 * thus we need to do it here as well.
 	 */
+	mac_len = skb->data - skb_mac_header(skb);
+	__skb_push(skb, mac_len);
+
 	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
 	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
-		int hroom = XDP_PACKET_HEADROOM - skb_headroom(skb);
-		int troom = skb->tail + skb->data_len - skb->end;
-
-		/* In case we have to go down the path and also linearize,
-		 * then lets do the pskb_expand_head() work just once here.
-		 */
-		if (pskb_expand_head(skb,
-				     hroom > 0 ? ALIGN(hroom, NET_SKB_PAD) : 0,
-				     troom > 0 ? troom + 128 : 0, GFP_ATOMIC))
-			goto do_drop;
-		if (skb_linearize(skb))
+		if (netif_skb_check_for_xdp(pskb, xdp_prog))
 			goto do_drop;
 	}
 
-	act = bpf_prog_run_generic_xdp(skb, xdp, xdp_prog);
+	__skb_pull(*pskb, mac_len);
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


