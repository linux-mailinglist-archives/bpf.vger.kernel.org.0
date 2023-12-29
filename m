Return-Path: <bpf+bounces-18725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D8E81FDAA
	for <lists+bpf@lfdr.de>; Fri, 29 Dec 2023 08:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043B31C22E48
	for <lists+bpf@lfdr.de>; Fri, 29 Dec 2023 07:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E7011CBB;
	Fri, 29 Dec 2023 07:31:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12C61171F;
	Fri, 29 Dec 2023 07:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VzQtfBO_1703835092;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VzQtfBO_1703835092)
          by smtp.aliyun-inc.com;
          Fri, 29 Dec 2023 15:31:32 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux-foundation.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v3 20/27] virtio_net: separate receive_mergeable
Date: Fri, 29 Dec 2023 15:31:01 +0800
Message-Id: <20231229073108.57778-21-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231229073108.57778-1-xuanzhuo@linux.alibaba.com>
References: <20231229073108.57778-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 20112a26898d
Content-Transfer-Encoding: 8bit

This commit separates the function receive_mergeable(),
put the logic of appending frag to the skb as an independent function.
The subsequent commit will reuse it.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c | 77 ++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 30 deletions(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index ab1970158d85..212af542bfbe 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -1401,6 +1401,49 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 	return NULL;
 }
 
+struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
+					struct sk_buff *curr_skb,
+					struct page *page, void *buf,
+					int len, int truesize)
+{
+	int num_skb_frags;
+	int offset;
+
+	num_skb_frags = skb_shinfo(curr_skb)->nr_frags;
+	if (unlikely(num_skb_frags == MAX_SKB_FRAGS)) {
+		struct sk_buff *nskb = alloc_skb(0, GFP_ATOMIC);
+
+		if (unlikely(!nskb))
+			return NULL;
+
+		if (curr_skb == head_skb)
+			skb_shinfo(curr_skb)->frag_list = nskb;
+		else
+			curr_skb->next = nskb;
+		curr_skb = nskb;
+		head_skb->truesize += nskb->truesize;
+		num_skb_frags = 0;
+	}
+
+	if (curr_skb != head_skb) {
+		head_skb->data_len += len;
+		head_skb->len += len;
+		head_skb->truesize += truesize;
+	}
+
+	offset = buf - page_address(page);
+	if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) {
+		put_page(page);
+		skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
+				     len, truesize);
+	} else {
+		skb_add_rx_frag(curr_skb, num_skb_frags, page,
+				offset, len, truesize);
+	}
+
+	return curr_skb;
+}
+
 static struct sk_buff *receive_mergeable(struct net_device *dev,
 					 struct virtnet_info *vi,
 					 struct virtnet_rq *rq,
@@ -1450,8 +1493,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	if (unlikely(!curr_skb))
 		goto err_skb;
 	while (--num_buf) {
-		int num_skb_frags;
-
 		buf = virtnet_rq_get_buf(rq, &len, &ctx);
 		if (unlikely(!buf)) {
 			pr_debug("%s: rx error: %d buffers out of %d missing\n",
@@ -1476,34 +1517,10 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 			goto err_skb;
 		}
 
-		num_skb_frags = skb_shinfo(curr_skb)->nr_frags;
-		if (unlikely(num_skb_frags == MAX_SKB_FRAGS)) {
-			struct sk_buff *nskb = alloc_skb(0, GFP_ATOMIC);
-
-			if (unlikely(!nskb))
-				goto err_skb;
-			if (curr_skb == head_skb)
-				skb_shinfo(curr_skb)->frag_list = nskb;
-			else
-				curr_skb->next = nskb;
-			curr_skb = nskb;
-			head_skb->truesize += nskb->truesize;
-			num_skb_frags = 0;
-		}
-		if (curr_skb != head_skb) {
-			head_skb->data_len += len;
-			head_skb->len += len;
-			head_skb->truesize += truesize;
-		}
-		offset = buf - page_address(page);
-		if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) {
-			put_page(page);
-			skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
-					     len, truesize);
-		} else {
-			skb_add_rx_frag(curr_skb, num_skb_frags, page,
-					offset, len, truesize);
-		}
+		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
+						    buf, len, truesize);
+		if (!curr_skb)
+			goto err_skb;
 	}
 
 	ewma_pkt_len_add(&rq->mrg_avg_pkt_len, head_skb->len);
-- 
2.32.0.3.g01195cf9f


