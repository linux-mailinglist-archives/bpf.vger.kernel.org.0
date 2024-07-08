Return-Path: <bpf+bounces-34069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65CC92A118
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 13:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74C01C20E7F
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 11:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2709A82890;
	Mon,  8 Jul 2024 11:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZBVT5Jq7"
X-Original-To: bpf@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A597380BF7;
	Mon,  8 Jul 2024 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437953; cv=none; b=FHJDtVcaS/zV6IqdqzaoTlXthtSGv05xtVcqSkYMAGhMAWYV8PWkovIhtcYF2SBk0ocY+W5neAUAlZFhOiyAbz5f/sydnuSNBZQnCaJFD2U5SWU0RWl1WXNtSF5OtVuuSZ0N8ayxh7GuNOZjAWHpHawW1/WPMqy4xHFEx91q4rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437953; c=relaxed/simple;
	bh=Q8quGDSZzYUbIq22I2pv0We8cWtmL2jLiqoJdbdM8As=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oObRZHPtPNb9U8n6vR+vgJtAd9o9FVspNCP9Nxr7VQJDL30BnQ3lCBe6RPDIutImmD46pq5zNeiZNP+cZTuItgr0Jn6LiU1l3jTaeIbNLBHol7CCWaWDMLzcAYH9pm7NNtZv7+iUbO6JdQi+W2g6vLr3D7HWPuiN8faVNVzC6rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZBVT5Jq7; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720437944; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=zNeiDwdkqzBfnWgHli0nRbhmznR8NhiOcj4IWvM1Tec=;
	b=ZBVT5Jq7Ncmpm8E0n97JiCRX7J3xudZhhlLkanmohT0pWpdjJRdAOcmlZyQ91b9CMUxadHiFLoLXnXSGwb2xMqCWeqNuab5QrsoHfScJ4KVs0WurUbGR+orKCU0WepOMPDL7Ds7EfCeHVC9DoCFgeh3XS1k+5kV1kQ/QH6Z+4ew=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0WA59bz2_1720437943;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WA59bz2_1720437943)
          by smtp.aliyun-inc.com;
          Mon, 08 Jul 2024 19:25:43 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v8 05/10] virtio_net: separate receive_mergeable
Date: Mon,  8 Jul 2024 19:25:32 +0800
Message-Id: <20240708112537.96291-6-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240708112537.96291-1-xuanzhuo@linux.alibaba.com>
References: <20240708112537.96291-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 74fbc055cff2
Content-Transfer-Encoding: 8bit

This commit separates the function receive_mergeable(),
put the logic of appending frag to the skb as an independent function.
The subsequent commit will reuse it.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 77 ++++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 30 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index abfc84af90ce..3c828cdd438b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1821,6 +1821,49 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 	return NULL;
 }
 
+static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
+					       struct sk_buff *curr_skb,
+					       struct page *page, void *buf,
+					       int len, int truesize)
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
 					 struct receive_queue *rq,
@@ -1870,8 +1913,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	if (unlikely(!curr_skb))
 		goto err_skb;
 	while (--num_buf) {
-		int num_skb_frags;
-
 		buf = virtnet_rq_get_buf(rq, &len, &ctx);
 		if (unlikely(!buf)) {
 			pr_debug("%s: rx error: %d buffers out of %d missing\n",
@@ -1896,34 +1937,10 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
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


