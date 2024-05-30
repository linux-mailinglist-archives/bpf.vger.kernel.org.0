Return-Path: <bpf+bounces-30910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0C18D4609
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 09:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0127F2847B6
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 07:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC10F55898;
	Thu, 30 May 2024 07:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Xjud81Ps"
X-Original-To: bpf@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB6E1C2326;
	Thu, 30 May 2024 07:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717054021; cv=none; b=aza5czKlUn315uXhLA8b3Fa9d0/HfzItv1uF6urBBTxMQM/BOYrys5GAVxkPjg3vDql16bU8gT/L3qBM9vREJtT46n6qK3xT33YlRz2XnhOYPt8H9ufSLu1JOZgYZvACR4qWIOFXh34KeXEnXsHNXAc8EIN+1fQM6U8XiMbiw4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717054021; c=relaxed/simple;
	bh=cC+bEAHBNyC7StFMR4VvC32/E/bLjFWtNpuSJ5Ez/0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DmFfin1YfH4lkaO8vB6SJ2GnUidWnrtD8Mail+IWZiTu/q9DUQzCIiVHSc2nUu15OQFQv8IcclfVjb/qddUlwqG06GIrKqf752Pc8ebPj3In5kCZi4vtr6pmHfTC8/Fwvqjnlu39/UEN7Q6uDBpe6SurI0nBjpLuk102RwQDPY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Xjud81Ps; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717054016; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=mvZKY1cghsedjBkZv6KzfNPULAWPQ40ClJhNF1cg/mk=;
	b=Xjud81PstHFK7cRrViiU96G/mFtH9rIp1ZFtyr3vqMGoUE104zfc8FtA5uwjMFNi1kyOA9MkLJ3xLSH/O9W64I3t7LnpGYAqzs0SwLeyX4dZ5HLPH57Ij9859GSq4JJuxNXa2oUKhTTMDsGv1qaH0IrzJ+u+krxRM3btK9gfxU8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W7WBAxw_1717054015;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7WBAxw_1717054015)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 15:26:56 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v1 6/7] virtio_net: separate receive_mergeable
Date: Thu, 30 May 2024 15:26:48 +0800
Message-Id: <20240530072649.102437-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240530072649.102437-1-xuanzhuo@linux.alibaba.com>
References: <20240530072649.102437-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 12be1d34ab2c
Content-Transfer-Encoding: 8bit

This commit separates the function receive_mergeable(),
put the logic of appending frag to the skb as an independent function.
The subsequent commit will reuse it.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio/virtnet.h      |  4 ++
 drivers/net/virtio/virtnet_main.c | 77 +++++++++++++++++++------------
 2 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/drivers/net/virtio/virtnet.h b/drivers/net/virtio/virtnet.h
index b56ebc7fcdcc..c6ef54160ddc 100644
--- a/drivers/net/virtio/virtnet.h
+++ b/drivers/net/virtio/virtnet.h
@@ -241,4 +241,8 @@ void virtnet_rx_pause(struct virtnet_info *vi, struct virtnet_rq *rq);
 void virtnet_rx_resume(struct virtnet_info *vi, struct virtnet_rq *rq);
 void virtnet_tx_pause(struct virtnet_info *vi, struct virtnet_sq *sq);
 void virtnet_tx_resume(struct virtnet_info *vi, struct virtnet_sq *sq);
+struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
+					struct sk_buff *curr_skb,
+					struct page *page, void *buf,
+					int len, int truesize);
 #endif
diff --git a/drivers/net/virtio/virtnet_main.c b/drivers/net/virtio/virtnet_main.c
index 285443da040c..6cc99d9b768b 100644
--- a/drivers/net/virtio/virtnet_main.c
+++ b/drivers/net/virtio/virtnet_main.c
@@ -1557,6 +1557,49 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
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
@@ -1606,8 +1649,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	if (unlikely(!curr_skb))
 		goto err_skb;
 	while (--num_buf) {
-		int num_skb_frags;
-
 		buf = virtnet_rq_get_buf(rq, &len, &ctx);
 		if (unlikely(!buf)) {
 			pr_debug("%s: rx error: %d buffers out of %d missing\n",
@@ -1632,34 +1673,10 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
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


