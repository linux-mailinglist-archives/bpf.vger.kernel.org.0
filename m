Return-Path: <bpf+bounces-21216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7628498FA
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 12:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18971F213FA
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 11:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C542199DC;
	Mon,  5 Feb 2024 11:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUYmeCYS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949A0199B8;
	Mon,  5 Feb 2024 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707132955; cv=none; b=jqMShpGiHcOuBhyOp9Tqq76D14HjkatHYcKSjx0Ea3OMsyQvgGxcsAY8fqE1jHfkeIr2y8ZTze6EyrGb+BzAWARAdiUCPeSCenOX31eLmndgGHtiPK6UVezkgQfG3CAmvsvjwqKqGGkO3h1ehQ4MpSg1eS1s3asNQc9c21qMO4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707132955; c=relaxed/simple;
	bh=npnGTxqdAfxgLB2h7ew4AfQNQpV2lZxre+vKff1Nc9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMafEv77CEvzfrnHHVMPHGemD9+o0Bry1mq7dPhg5Somp+0/w1ArvoXBsXaMo5i+s28Gsg/DD4dUch5z97TkKuB4WoyUwzFciDsmZgsGeXf3mlE5e49ZZu0rIoyzZg/rk1Zi+6xLhXzILgwIdGef0CloL58RI4bUxkQvLZf1nTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUYmeCYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEBEC433C7;
	Mon,  5 Feb 2024 11:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707132955;
	bh=npnGTxqdAfxgLB2h7ew4AfQNQpV2lZxre+vKff1Nc9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sUYmeCYSimpi1aLTo3AHZwqHvFjX57nknHyXoKLknTGF20IDIPx3iRzdxx3fwqC4e
	 H1lze1Hotf2vICSPJjRLq4QA4Mu5r0y5KVjIEmZ4390R2Eqi3Hi7tRG28H8web9iwv
	 kYhZ9PEJA++fr0iXXUh6TOx38XWM9ewbwyeAJzbrjkHDisnPn1LMLTB8k9bLOimNt3
	 PNiGvQl//4RKX/r2eG8sE1zie5JuA/duDQTZs6+xxtAlYikETM3m1hEyX9CvItaFq4
	 ZAjCVrs4ZFXIXgB4vgGicUW6SckMvKYVdmcBEW7AvkqUE7pMzkBwYIicNrNTpHK48Q
	 esWHiCXANsw9w==
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
Subject: [PATCH v8 net-next 4/4] veth: rely on skb_cow_data_for_xdp utility routine
Date: Mon,  5 Feb 2024 12:35:15 +0100
Message-ID: <0585c5f792121d8cfb29d8e0224b00d1e4a30f84.1707132752.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707132752.git.lorenzo@kernel.org>
References: <cover.1707132752.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rely on skb_cow_data_for_xdp utility routine and remove duplicated
code.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Reviewed-by: Toke Hoiland-Jorgensen <toke@redhat.com>
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


