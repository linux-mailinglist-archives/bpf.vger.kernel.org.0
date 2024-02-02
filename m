Return-Path: <bpf+bounces-21007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C817846A81
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 09:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F9CCB230F2
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 08:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E561148789;
	Fri,  2 Feb 2024 08:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOSlPi7E"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607F048780;
	Fri,  2 Feb 2024 08:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861644; cv=none; b=U1glU3n86jdiH8CSa6a5cTDlgUtfqtHFLbpFy8P7rdUzw5+QPWclvvJwjus+Rb8tDIPm0JgrrOcgmEdIxvUFv1cxZ11WDNAd8bEC4MkJxTOyp/LtK4+7cAYHWYAOvgFXrloqja1+/HUsNA4rJqKn/H5maFOhdRhJpL14TZ+Z9jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861644; c=relaxed/simple;
	bh=k4jDvR92VAQHALmyLDtxq5/QT/C3tJQjMZ+ixmZ+GFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLk57efd7Mk4oLORBHIJcHnmGaqE6JI1r9Jnv8+wf8xwu6kk2SBRsRiHwgpU5rPLni2MndKQvFtnrDku4SLDf6hlSfiailHAoq9wOSMEf3UwVvgYm09Vwp16iSytJ2J5AJf+c7c+A4TDgcUoeCLVYfLWKfudxEU5i2VblGYlLMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOSlPi7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F8EC433F1;
	Fri,  2 Feb 2024 08:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706861644;
	bh=k4jDvR92VAQHALmyLDtxq5/QT/C3tJQjMZ+ixmZ+GFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tOSlPi7E3IlRtxqf8Jrd1vMJAwQbMT+2v6n+e4BqXJsF9dmOriqbOFJnzifnoz1Hx
	 pIIRXBYXvtgp2LvlhXndmhkplzGlumirkzqHI/7xDvliPeYj/78q3va8EDoAI1HSNv
	 lZW3X/b68iaw0a4s3AUq8yECHbCpcIJkSvWFxbYCHPrIfrFmmZXGL6GN5/n6xN75mk
	 NZ6I8dSjIe7f4KqOS/OYDg+l8qqo1KgLLbzIhop6AWYaWxXry10l7D5WKBh7bmBODf
	 qOxnudsx5YFAeoja3VRak9BU8j4zkikPCZqNmApaB49f+nX25wPS4sGla1B778hgqT
	 src6r8StN7QGA==
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
	ilias.apalodimas@linaro.org,
	linyunsheng@huawei.com
Subject: [PATCH v7 net-next 4/4] veth: rely on skb_cow_data_for_xdp utility routine
Date: Fri,  2 Feb 2024 09:12:47 +0100
Message-ID: <a9e7f6c9c3f14b43e9f963d767d396f0eb611c5f.1706861261.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706861261.git.lorenzo@kernel.org>
References: <cover.1706861261.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rely on skb_cow_data_for_xdp utility routine and remove duplicated
code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/veth.c | 79 +++-------------------------------------------
 1 file changed, 5 insertions(+), 74 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 578e36ea1589..a7a541c1a374 100644
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
+		if (skb_cow_data_for_xdp(rq->page_pool, pskb, prog))
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
 
-- 
2.43.0


