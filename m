Return-Path: <bpf+bounces-21728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1889685100B
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 10:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1151C21C76
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 09:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0F818026;
	Mon, 12 Feb 2024 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKuurmRs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218BB17C60;
	Mon, 12 Feb 2024 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731515; cv=none; b=FzfTAal5RF3MAzzbR/qcBVuNZ/M4hayxCmgAyvatMWpvKtzsXJcQ5rahNbzjgxDy0oWvmstQqQgzNJICHiIwng1uO+m8qe1XWvi+QjJejsUWwIOKvCMBEIRToMvPms8D2o5+m+pu7LAwErvQCABXShw56sXlIjfgOhZrhQ66H8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731515; c=relaxed/simple;
	bh=TsAjqNET8x2PfS9wWtM4z5Q+ffuMqUEUFdYNmT6Bxok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eh/uoKEDoalf14YAdHjeEQoLZZdQfhuNbPHUjP3e7Y/o6sS7ka3rt0cbLb5jX571EwYSpDx8VSnhjKktC+X5iMKbEkvj/X3pv7JR5Noqw1m6cQ4kilb2MNV6zOUmmpo86dCFf3aEDu9fLD05snAz/swNNe0TzigHp+rnSZEmCkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKuurmRs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9A2C433F1;
	Mon, 12 Feb 2024 09:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707731514;
	bh=TsAjqNET8x2PfS9wWtM4z5Q+ffuMqUEUFdYNmT6Bxok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mKuurmRsZihW9Z694XhHHf9FJDKjZ6w6Tl1+GofV52L8Z4Tmhcr/FKkWC1pjOi4Rr
	 CWgOYjRsIbF05S2rWfPTXQdaz4dUd/X8pf2nl5O1m22JmNvOBkVUoE4yi+D1A933/F
	 OjiASddyW9H+6ehIWLrvckHCXipkBUQZ9XxaQhIidLZFpkeLtSxso7zr936MTJYlm2
	 0hJ4pAcZsanGlw4Pak5EBAF5VkzrlWukbeQJSI1tqb4lny343KN6PR4zV/wBtO9X4K
	 EhNMQS6V0hUPhjQD+cXSMUPQmV6cEbu6V1mYaQVVyCe84ycmGQEJsqAM5Hm6tfc4vy
	 jA8hipbQdOXtw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	toke@redhat.com,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	sdf@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	linyunsheng@huawei.com
Subject: [PATCH v9 net-next 3/4] xdp: add multi-buff support for xdp running in generic mode
Date: Mon, 12 Feb 2024 10:50:56 +0100
Message-ID: <1044d6412b1c3e95b40d34993fd5f37cd2f319fd.1707729884.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707729884.git.lorenzo@kernel.org>
References: <cover.1707729884.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to native xdp, do not always linearize the skb in
netif_receive_generic_xdp routine but create a non-linear xdp_buff to be
processed by the eBPF program. This allow to add multi-buffer support
for xdp running in generic mode.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Reviewed-by: Toke Hoiland-Jorgensen <toke@redhat.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/linux/skbuff.h |  2 +
 net/core/dev.c         | 70 +++++++++++++++++++++++---------
 net/core/skbuff.c      | 91 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+), 19 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2dde34c29203..def3d8689c3d 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3446,6 +3446,8 @@ static inline void skb_frag_ref(struct sk_buff *skb, int f)
 	__skb_frag_ref(&skb_shinfo(skb)->frags[f]);
 }
 
+int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
+			 struct bpf_prog *prog);
 bool napi_pp_put_page(struct page *page, bool napi_safe);
 
 static inline void
diff --git a/net/core/dev.c b/net/core/dev.c
index 1482c3058fc2..97de7700d3cb 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4874,6 +4874,12 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
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
@@ -4903,6 +4909,14 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
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
@@ -4936,12 +4950,35 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	return act;
 }
 
+static int
+netif_skb_check_for_xdp(struct sk_buff **pskb, struct bpf_prog *prog)
+{
+	struct sk_buff *skb = *pskb;
+	int err, hroom, troom;
+
+	if (!skb_cow_data_for_xdp(this_cpu_read(system_page_pool), pskb, prog))
+		return 0;
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
@@ -4949,41 +4986,36 @@ static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
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
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 9e5eb47b4025..bdb94749f05d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -895,6 +895,97 @@ static bool is_pp_page(struct page *page)
 	return (page->pp_magic & ~0x3UL) == PP_SIGNATURE;
 }
 
+static int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
+			   unsigned int headroom)
+{
+#if IS_ENABLED(CONFIG_PAGE_POOL)
+	u32 size, truesize, len, max_head_size, off;
+	struct sk_buff *skb = *pskb, *nskb;
+	int err, i, head_off;
+	void *data;
+
+	/* XDP does not support fraglist so we need to linearize
+	 * the skb.
+	 */
+	if (skb_has_frag_list(skb))
+		return -EOPNOTSUPP;
+
+	max_head_size = SKB_WITH_OVERHEAD(PAGE_SIZE - headroom);
+	if (skb->len > max_head_size + MAX_SKB_FRAGS * PAGE_SIZE)
+		return -ENOMEM;
+
+	size = min_t(u32, skb->len, max_head_size);
+	truesize = SKB_HEAD_ALIGN(size) + headroom;
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
+	skb_reserve(nskb, headroom);
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
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
+int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
+			 struct bpf_prog *prog)
+{
+	if (!prog->aux->xdp_has_frags)
+		return -EINVAL;
+
+	return skb_pp_cow_data(pool, pskb, XDP_PACKET_HEADROOM);
+}
+EXPORT_SYMBOL(skb_cow_data_for_xdp);
+
 #if IS_ENABLED(CONFIG_PAGE_POOL)
 bool napi_pp_put_page(struct page *page, bool napi_safe)
 {
-- 
2.43.0


