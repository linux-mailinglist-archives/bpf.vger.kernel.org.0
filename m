Return-Path: <bpf+bounces-17503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC48280E8A1
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 11:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092431C20C0A
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 10:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF30759547;
	Tue, 12 Dec 2023 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfjkjmhq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9A259524;
	Tue, 12 Dec 2023 10:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D96C433C8;
	Tue, 12 Dec 2023 10:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702375611;
	bh=/ToUaGg3Z1fHv105Ur3p76Jcy9CEpWlBEGYy915v3Sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nfjkjmhq5TpRXknUhyJ+8KwUauwQ+1Eh3rpLJ/dEtt7Yzl4hxZFpSmfJf8fpWc6gf
	 Bm//FZ5AfP1YGf4Orq0eXuLx+r7pkD2pM25ln7Qe6KWdq2ICL1IwLC4117Lo+Yu2Y7
	 69i51sU6DLvtHDr4VhSyv3znzJyLNICdvosVp1+vDbWUd7qbDtwyWRFo9KD/0WawQ+
	 YAl+Fgna2cGYKX/n5q5Yuh2862JwplF0RdQphRj9/s40r2TQmw26dnwDuebtR75s4n
	 2HP7E/gZQhSQMqOtnGeVdnky8l9t0mPocjCph2U5l8HsYcYvIokwU/R/sClsuLayDn
	 RB2h4aBNi975Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	hawk@kernel.org,
	toke@redhat.com,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	sdf@google.com
Subject: [PATCH v4 net-next 3/3] xdp: add multi-buff support for xdp running in generic mode
Date: Tue, 12 Dec 2023 11:06:15 +0100
Message-ID: <2d0f9388c6509192d88e359a402517a73124b50e.1702375338.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702375338.git.lorenzo@kernel.org>
References: <cover.1702375338.git.lorenzo@kernel.org>
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
 net/core/dev.c | 121 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 111 insertions(+), 10 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 14554698b1fa..3826e0ea08e3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4854,6 +4854,12 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
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
@@ -4883,6 +4889,14 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
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
@@ -4916,12 +4930,84 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	return act;
 }
 
+static int netif_skb_segment_for_xdp(struct sk_buff **pskb)
+{
+	struct softnet_data *sd = this_cpu_ptr(&softnet_data);
+	u32 size, truesize, len, max_head_size, off;
+	struct sk_buff *skb = *pskb, *nskb;
+	int err, i, head_off;
+	void *data;
+
+	max_head_size = SKB_WITH_OVERHEAD(PAGE_SIZE - XDP_PACKET_HEADROOM);
+	if (skb->len > max_head_size + MAX_SKB_FRAGS * PAGE_SIZE)
+		return -ENOMEM;
+
+	size = min_t(u32, skb->len, max_head_size);
+	truesize = SKB_HEAD_ALIGN(size) + XDP_PACKET_HEADROOM;
+	data = page_pool_dev_alloc_va(sd->page_pool, &truesize);
+	if (!data)
+		return -ENOMEM;
+
+	nskb = napi_build_skb(data, truesize);
+	if (!nskb) {
+		page_pool_free_va(sd->page_pool, data, true);
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
+		page = page_pool_dev_alloc(sd->page_pool, &page_off,
+					   &truesize);
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
@@ -4929,12 +5015,10 @@ static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
 	if (skb_is_redirected(skb))
 		return XDP_PASS;
 
-	/* XDP packets must be linear and must have sufficient headroom
-	 * of XDP_PACKET_HEADROOM bytes. This is the guarantee that also
-	 * native XDP provides, thus we need to do it here as well.
+	/* XDP does not support fraglist so we need to linearize
+	 * the skb.
 	 */
-	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
-	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
+	if (skb_has_frag_list(skb) || !xdp_prog->aux->xdp_has_frags) {
 		int hroom = XDP_PACKET_HEADROOM - skb_headroom(skb);
 		int troom = skb->tail + skb->data_len - skb->end;
 
@@ -4947,23 +5031,40 @@ static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
 			goto do_drop;
 		if (skb_linearize(skb))
 			goto do_drop;
+
+		goto do_xdp;
 	}
 
-	act = bpf_prog_run_generic_xdp(skb, xdp, xdp_prog);
+	/* XDP packets must have sufficient headroom of XDP_PACKET_HEADROOM
+	 * bytes. This is the guarantee that also native XDP provides,
+	 * thus we need to do it here as well.
+	 */
+	mac_len = skb->data - skb_mac_header(skb);
+	__skb_push(skb, mac_len);
+
+	if (skb_cloned(skb) || skb_shinfo(skb)->nr_frags ||
+	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
+		if (netif_skb_segment_for_xdp(pskb))
+			goto do_drop;
+	}
+
+	__skb_pull(*pskb, mac_len);
+do_xdp:
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


