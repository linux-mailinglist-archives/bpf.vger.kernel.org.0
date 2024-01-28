Return-Path: <bpf+bounces-20523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6984F83F5D7
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 15:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32CC284613
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 14:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32542D60A;
	Sun, 28 Jan 2024 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRdBYhcD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290192D044;
	Sun, 28 Jan 2024 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706451744; cv=none; b=UKkBxJiEqjG6VZoAg+neocsqqy0trF4hMA4K0rcI3Tvatc6mKnk3HZ1bRTJhcYpZ3WM4fTopch2m8YNlRlo2V2PF8Vu1qVv7QpqtrAoM/V8Rj838HOB4b1NZ63j6nx/dM5E+7sZKlgLeuNgK8B+Diz89Ig0UE15y4zwn0+VcBzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706451744; c=relaxed/simple;
	bh=eA07ywQOGA3josKKVG7GzOBzSj4bcU+K56EhXf7uxFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKpttSiBMXhmXc5bm5wrHUkBLsSHE05XsabmCSgVLCMf6qRXY86q7Q4drXLG9lJiOUFqMLRQB/Hp/fWIpDlEfOMsabYe+O6gsVcazgmU5ps8fXJVsPG6SPO/Xitvnw4f/yA2IyfOpcpYJSQ6wSOUDBhKciIZzhVCJ2jYnx6MPtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRdBYhcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537C2C433F1;
	Sun, 28 Jan 2024 14:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706451743;
	bh=eA07ywQOGA3josKKVG7GzOBzSj4bcU+K56EhXf7uxFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vRdBYhcDgpySoAjcJETKyLMOfqFtFOC3pCkEj1/iXhSMuPe509Q4q9iv3TCv+/nFM
	 BRCmzerzq4M8Ti+MdwfGBnMuVWL/6l0oNZEw5ZajttN9saeOtMBd2JvPUW5Osl5YL+
	 H4IkMVLxXJ31ja953FPObQwNT32D8FQqJAcVimDG8fuyJPC5ZF78JGdgC2DqMZepgU
	 /1XyQsBruBd63cOaqrCWqaT1tldNNww4A3J92wnbGdyapFO8wgPVDP8o62kvrsx0Rn
	 jKTR26zdgiyWvSbDAxQMEOqRHD2Cpfg7MnXAUN7GchAi3SZIyaFNXD2p+yM5cpKw/T
	 M9gF9uIi+g49w==
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
Subject: [PATCH v6 net-next 5/5] veth: rely on netif_skb_segment_for_xdp utility routine
Date: Sun, 28 Jan 2024 15:20:41 +0100
Message-ID: <72aa14d2c15a4367d59ac232772d3bf08852bc30.1706451150.git.lorenzo@kernel.org>
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

Rely on netif_skb_segment_for_xdp utility routine and remove duplicated
code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/veth.c        | 79 +++------------------------------------
 include/linux/netdevice.h |  4 ++
 net/core/dev.c            |  6 +--
 3 files changed, 12 insertions(+), 77 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 578e36ea1589..ddb163f134ea 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -721,7 +721,8 @@ static void veth_xdp_get(struct xdp_buff *xdp)
 
 static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 					struct xdp_buff *xdp,
-					struct sk_buff **pskb)
+					struct sk_buff **pskb,
+					struct bpf_prog *prog)
 {
 	struct sk_buff *skb = *pskb;
 	u32 frame_sz;
@@ -729,80 +730,10 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 	if (skb_shared(skb) || skb_head_is_locked(skb) ||
 	    skb_shinfo(skb)->nr_frags ||
 	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
-		u32 size, len, max_head_size, off, truesize, page_offset;
-		struct sk_buff *nskb;
-		struct page *page;
-		int i, head_off;
-		void *va;
-
-		/* We need a private copy of the skb and data buffers since
-		 * the ebpf program can modify it. We segment the original skb
-		 * into order-0 pages without linearize it.
-		 *
-		 * Make sure we have enough space for linear and paged area
-		 */
-		max_head_size = SKB_WITH_OVERHEAD(PAGE_SIZE -
-						  VETH_XDP_HEADROOM);
-		if (skb->len > PAGE_SIZE * MAX_SKB_FRAGS + max_head_size)
-			goto drop;
-
-		size = min_t(u32, skb->len, max_head_size);
-		truesize = SKB_HEAD_ALIGN(size) + VETH_XDP_HEADROOM;
-
-		/* Allocate skb head */
-		va = page_pool_dev_alloc_va(rq->page_pool, &truesize);
-		if (!va)
-			goto drop;
-
-		nskb = napi_build_skb(va, truesize);
-		if (!nskb) {
-			page_pool_free_va(rq->page_pool, va, true);
+		if (netif_skb_segment_for_xdp(rq->page_pool, pskb, prog))
 			goto drop;
-		}
-
-		skb_reserve(nskb, VETH_XDP_HEADROOM);
-		skb_copy_header(nskb, skb);
-		skb_mark_for_recycle(nskb);
-
-		if (skb_copy_bits(skb, 0, nskb->data, size)) {
-			consume_skb(nskb);
-			goto drop;
-		}
-		skb_put(nskb, size);
 
-		head_off = skb_headroom(nskb) - skb_headroom(skb);
-		skb_headers_offset_update(nskb, head_off);
-
-		/* Allocate paged area of new skb */
-		off = size;
-		len = skb->len - off;
-
-		for (i = 0; i < MAX_SKB_FRAGS && off < skb->len; i++) {
-			size = min_t(u32, len, PAGE_SIZE);
-			truesize = size;
-
-			page = page_pool_dev_alloc(rq->page_pool, &page_offset,
-						   &truesize);
-			if (!page) {
-				consume_skb(nskb);
-				goto drop;
-			}
-
-			skb_add_rx_frag(nskb, i, page, page_offset, size,
-					truesize);
-			if (skb_copy_bits(skb, off,
-					  page_address(page) + page_offset,
-					  size)) {
-				consume_skb(nskb);
-				goto drop;
-			}
-
-			len -= size;
-			off += size;
-		}
-
-		consume_skb(skb);
-		skb = nskb;
+		skb = *pskb;
 	}
 
 	/* SKB "head" area always have tailroom for skb_shared_info */
@@ -850,7 +781,7 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	}
 
 	__skb_push(skb, skb->data - skb_mac_header(skb));
-	if (veth_convert_skb_to_xdp_buff(rq, xdp, &skb))
+	if (veth_convert_skb_to_xdp_buff(rq, xdp, &skb, xdp_prog))
 		goto drop;
 	vxbuf.skb = skb;
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7eee99a58200..8c1f6954de47 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3955,6 +3955,10 @@ static inline void dev_consume_skb_any(struct sk_buff *skb)
 	dev_kfree_skb_any_reason(skb, SKB_CONSUMED);
 }
 
+#if IS_ENABLED(CONFIG_PAGE_POOL)
+int netif_skb_segment_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
+			      struct bpf_prog *prog);
+#endif
 u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 			     struct bpf_prog *xdp_prog);
 void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog);
diff --git a/net/core/dev.c b/net/core/dev.c
index 19f92ba90e49..b2fc8f0683dd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4939,9 +4939,8 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 }
 
 #if IS_ENABLED(CONFIG_PAGE_POOL)
-static int
-netif_skb_segment_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
-			  struct bpf_prog *prog)
+int netif_skb_segment_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
+			      struct bpf_prog *prog)
 {
 	u32 size, truesize, len, max_head_size, off;
 	struct sk_buff *skb = *pskb, *nskb;
@@ -5016,6 +5015,7 @@ netif_skb_segment_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(netif_skb_segment_for_xdp);
 #endif
 
 static int
-- 
2.43.0


