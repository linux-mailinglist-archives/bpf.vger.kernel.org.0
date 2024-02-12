Return-Path: <bpf+bounces-21729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FF685100D
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 10:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38041286298
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 09:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4901804A;
	Mon, 12 Feb 2024 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUTcpFl6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCE617BD8;
	Mon, 12 Feb 2024 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731519; cv=none; b=XFtAlqs953KmJJzLgNaAoBpMh3cE94DHdhfAFCS5cL400+qV5CbX1zRXvH8OjoTqBdsrqyoNZSX2YPeVNmc5vc1vV6zwPc9/lHVFZUFtrsawhS3e14Ac6Ct6oWlKdDt05yVzWILCKBOneH+brfzXOpfNXD+oWWHnpuJF+U+Dfcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731519; c=relaxed/simple;
	bh=+WTSaUZYDlEHHF6ChEfAI9mA34tk2e5g3TUHRboE6NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iu7ppf++Z8FzKQ30a3zTRFkwSOfj+hqysvMp5dU7O/3dO3C6RKloxVbQfnTmlxwruA09xSZqOCNLjfiYrBfvTuVj4WZD2P+dkgNdheziwOCXw3seSar4KhiJ5E2I+1fRSNN14g123eNxvi4K9Eei6KoPgJz5XlK91dDYTCImJOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUTcpFl6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB5DC433C7;
	Mon, 12 Feb 2024 09:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707731518;
	bh=+WTSaUZYDlEHHF6ChEfAI9mA34tk2e5g3TUHRboE6NI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mUTcpFl65N4tyxVTbRx3Lj6P+f9tl/XUGAS2+KK/TMwSI4DTH2Ro4ZyEmoKlnFDQ9
	 LO/IKZj9VLOte5FkUmGsMGeAdECbz24hmPFhfSBIeAt5U+dYEJoH/GnHzv2rAvaael
	 lwOd6ImOkSY7MvQDQDtlQ4/eQEPb04XMXZh89dnieuaAGxywmfvwP7apjyZsNrzz0S
	 ioarpyLcO5BmFUB2hiiuoX+vU/ZNyTzbrsHXWhcL5heJXfes6tE241qBNHzA53kLdO
	 MjqPs340NChY8KYpChMFUSStFaQzDRs5KozX+eEkEhOXMmHEu0oy+eYqHYakkRsij1
	 QVFymUfZbYs3w==
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
Subject: [PATCH v9 net-next 4/4] veth: rely on skb_pp_cow_data utility routine
Date: Mon, 12 Feb 2024 10:50:57 +0100
Message-ID: <029cc14cce41cb242ee7efdcf32acc81f1ce4e9f.1707729884.git.lorenzo@kernel.org>
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

Rely on skb_pp_cow_data utility routine and remove duplicated code.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Reviewed-by: Toke Hoiland-Jorgensen <toke@redhat.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/veth.c     | 74 ++----------------------------------------
 include/linux/skbuff.h |  2 ++
 net/core/skbuff.c      |  5 +--
 3 files changed, 7 insertions(+), 74 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 578e36ea1589..4116e4c4072c 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -729,80 +729,10 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
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
+		if (skb_pp_cow_data(rq->page_pool, pskb, XDP_PACKET_HEADROOM))
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
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index def3d8689c3d..696e7680656f 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3446,6 +3446,8 @@ static inline void skb_frag_ref(struct sk_buff *skb, int f)
 	__skb_frag_ref(&skb_shinfo(skb)->frags[f]);
 }
 
+int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
+		    unsigned int headroom);
 int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
 			 struct bpf_prog *prog);
 bool napi_pp_put_page(struct page *page, bool napi_safe);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index bdb94749f05d..0d9a489e6ae1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -895,8 +895,8 @@ static bool is_pp_page(struct page *page)
 	return (page->pp_magic & ~0x3UL) == PP_SIGNATURE;
 }
 
-static int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
-			   unsigned int headroom)
+int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
+		    unsigned int headroom)
 {
 #if IS_ENABLED(CONFIG_PAGE_POOL)
 	u32 size, truesize, len, max_head_size, off;
@@ -975,6 +975,7 @@ static int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 	return -EOPNOTSUPP;
 #endif
 }
+EXPORT_SYMBOL(skb_pp_cow_data);
 
 int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
 			 struct bpf_prog *prog)
-- 
2.43.0


