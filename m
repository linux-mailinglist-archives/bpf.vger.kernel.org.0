Return-Path: <bpf+bounces-34068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6748292A117
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 13:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7DC1C21132
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 11:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ADD824B2;
	Mon,  8 Jul 2024 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hK0FUbBJ"
X-Original-To: bpf@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CA480BEE;
	Mon,  8 Jul 2024 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437953; cv=none; b=OIg5EGsjosx+MJ2zNp/+ZDsCyooStJCm8rXNoAL26SNsZgUwrbarTQslfHfok5llKZNrorfMW3gqNDcq9NlvP/k5NONNvU4FbLC+84VHKqPftqwNbqFR0ISUOaRatLxQIyVvEkwOiJWP78c1oQvbb2tGHyxPTGASY6xVBzsGCVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437953; c=relaxed/simple;
	bh=sZpqAbVXi+XO0m/5CQvURm1MpzINwCxkFnJBeS9FkHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dfq+HvGDDHc+2YwOWDEsDf5Ub/iX8HJi9SAqeO7++K7LY6LA/p0F+nwp4N97/vy0b2N+CbykRTD0+OkBfXbQDFWBqUKAxULJe44iz3p1nH24swiLB7uP5Dx0JSWnXzoPRJuQ41YfNOmiRINjtPT6Tg+rJTwuYrYG8Lpy8egej+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hK0FUbBJ; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720437949; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ZaIEVMNqF6/DKm9EQ2/U0Cl6o+YFmfjz+SXOHjLL8Ho=;
	b=hK0FUbBJuC9KNI75rqznRrOEemsufMCI0Jyc+8+wSq3Y82XQkC8TTPzle80GyOYk8aWwKpbVMRcZNr4vWzNiv6IgUj5E6Rzq5bsUNqAiYrofO1YeGk3xILyNFFwLG1qQQRK+2OGJmmvSBCNUcy10AzYpbNfjrO/bnWFQMNZvKcg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0WA5oE9-_1720437947;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WA5oE9-_1720437947)
          by smtp.aliyun-inc.com;
          Mon, 08 Jul 2024 19:25:48 +0800
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
Subject: [PATCH net-next v8 10/10] virtio_net: xsk: rx: support recv merge mode
Date: Mon,  8 Jul 2024 19:25:37 +0800
Message-Id: <20240708112537.96291-11-xuanzhuo@linux.alibaba.com>
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

Support AF-XDP for merge mode.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 144 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c9c65948b71f..b6323346208d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -504,6 +504,10 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 			       struct virtnet_rq_stats *stats);
 static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
 				 struct sk_buff *skb, u8 flags);
+static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
+					       struct sk_buff *curr_skb,
+					       struct page *page, void *buf,
+					       int len, int truesize);
 
 static bool is_xdp_frame(void *ptr)
 {
@@ -984,6 +988,11 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 
 	rq = &vi->rq[i];
 
+	if (rq->xsk_pool) {
+		xsk_buff_free((struct xdp_buff *)buf);
+		return;
+	}
+
 	if (!vi->big_packets || vi->mergeable_rx_bufs)
 		virtnet_rq_unmap(rq, buf, 0);
 
@@ -1152,6 +1161,139 @@ static struct sk_buff *virtnet_receive_xsk_small(struct net_device *dev, struct
 	}
 }
 
+static void xsk_drop_follow_bufs(struct net_device *dev,
+				 struct receive_queue *rq,
+				 u32 num_buf,
+				 struct virtnet_rq_stats *stats)
+{
+	struct xdp_buff *xdp;
+	u32 len;
+
+	while (num_buf-- > 1) {
+		xdp = virtqueue_get_buf(rq->vq, &len);
+		if (unlikely(!xdp)) {
+			pr_debug("%s: rx error: %d buffers missing\n",
+				 dev->name, num_buf);
+			DEV_STATS_INC(dev, rx_length_errors);
+			break;
+		}
+		u64_stats_add(&stats->bytes, len);
+		xsk_buff_free(xdp);
+	}
+}
+
+static int xsk_append_merge_buffer(struct virtnet_info *vi,
+				   struct receive_queue *rq,
+				   struct sk_buff *head_skb,
+				   u32 num_buf,
+				   struct virtio_net_hdr_mrg_rxbuf *hdr,
+				   struct virtnet_rq_stats *stats)
+{
+	struct sk_buff *curr_skb;
+	struct xdp_buff *xdp;
+	u32 len, truesize;
+	struct page *page;
+	void *buf;
+
+	curr_skb = head_skb;
+
+	while (--num_buf) {
+		buf = virtqueue_get_buf(rq->vq, &len);
+		if (unlikely(!buf)) {
+			pr_debug("%s: rx error: %d buffers out of %d missing\n",
+				 vi->dev->name, num_buf,
+				 virtio16_to_cpu(vi->vdev,
+						 hdr->num_buffers));
+			DEV_STATS_INC(vi->dev, rx_length_errors);
+			return -EINVAL;
+		}
+
+		u64_stats_add(&stats->bytes, len);
+
+		xdp = buf_to_xdp(vi, rq, buf, len);
+		if (!xdp)
+			goto err;
+
+		buf = napi_alloc_frag(len);
+		if (!buf) {
+			xsk_buff_free(xdp);
+			goto err;
+		}
+
+		memcpy(buf, xdp->data - vi->hdr_len, len);
+
+		xsk_buff_free(xdp);
+
+		page = virt_to_page(buf);
+
+		truesize = len;
+
+		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
+						    buf, len, truesize);
+		if (!curr_skb) {
+			put_page(page);
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	xsk_drop_follow_bufs(vi->dev, rq, num_buf, stats);
+	return -EINVAL;
+}
+
+static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct virtnet_info *vi,
+						 struct receive_queue *rq, struct xdp_buff *xdp,
+						 unsigned int *xdp_xmit,
+						 struct virtnet_rq_stats *stats)
+{
+	struct virtio_net_hdr_mrg_rxbuf *hdr;
+	struct bpf_prog *prog;
+	struct sk_buff *skb;
+	u32 ret, num_buf;
+
+	hdr = xdp->data - vi->hdr_len;
+	num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
+
+	ret = XDP_PASS;
+	rcu_read_lock();
+	prog = rcu_dereference(rq->xdp_prog);
+	/* TODO: support multi buffer. */
+	if (prog && num_buf == 1)
+		ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
+	rcu_read_unlock();
+
+	switch (ret) {
+	case XDP_PASS:
+		skb = xsk_construct_skb(rq, xdp);
+		if (!skb)
+			goto drop_bufs;
+
+		if (xsk_append_merge_buffer(vi, rq, skb, num_buf, hdr, stats)) {
+			dev_kfree_skb(skb);
+			goto drop;
+		}
+
+		return skb;
+
+	case XDP_TX:
+	case XDP_REDIRECT:
+		return NULL;
+
+	default:
+		/* drop packet */
+		xsk_buff_free(xdp);
+	}
+
+drop_bufs:
+	xsk_drop_follow_bufs(dev, rq, num_buf, stats);
+
+drop:
+	u64_stats_inc(&stats->drops);
+	return NULL;
+}
+
 static void virtnet_receive_xsk_buf(struct virtnet_info *vi, struct receive_queue *rq,
 				    void *buf, u32 len,
 				    unsigned int *xdp_xmit,
@@ -1181,6 +1323,8 @@ static void virtnet_receive_xsk_buf(struct virtnet_info *vi, struct receive_queu
 
 	if (!vi->mergeable_rx_bufs)
 		skb = virtnet_receive_xsk_small(dev, vi, rq, xdp, xdp_xmit, stats);
+	else
+		skb = virtnet_receive_xsk_merge(dev, vi, rq, xdp, xdp_xmit, stats);
 
 	if (skb)
 		virtnet_receive_done(vi, rq, skb, flags);
-- 
2.32.0.3.g01195cf9f


