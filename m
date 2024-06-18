Return-Path: <bpf+bounces-32391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E00590C6B3
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 12:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9E31F21DA9
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 10:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346C919E7FD;
	Tue, 18 Jun 2024 07:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="joYPijmT"
X-Original-To: bpf@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C367919DFBA;
	Tue, 18 Jun 2024 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697417; cv=none; b=mFaPNE0yvEDM4hd8duLimAuQ7AXSUMMO5DAfA3lJCQwizDFBOZofrmSI4DPPjAQcE1RCPiidQt5RUzAR7rlTRQtlneIDmJdQvc0BIYCH8ieoPvCJulWmUEy0rMCw5TEIJGKOsDJfM/YYUGVz6VYB5RMV47R3Cv9GCeg+9TX5OM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697417; c=relaxed/simple;
	bh=FWHKSY/+gape+qlMF1te0S6rQk+1EewFBWF0NTMojJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bx5OR7A5Z2L4kQ0B+HJbNQEg8yfC8rBOxxegXJJh+KYyX3+Ln6+XlTNXGyV4r7KKmeQDxI8Mg3pVUpEE/n05puFa+kiBgGUemuxHRPYg/zP97VXfCqlCeCR3gyR2cCj3BxWXbuTH9wVx+E7gBhxf/gWS6BkiLvFtt7n1Oy9/Ck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=joYPijmT; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718697413; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=v33T2BReP5MmEwR4SEGzkthhk2RVW62w9993rtHIlik=;
	b=joYPijmTzBB9mZ+aJRoEuzmJ6LeAZfNnYL4TpiJdfGH6KrmaCN/4PE0JKt+1iFgP0H9CJKf/7wlGIF6EIKUXqTTe6QQzd9LSILBGqj24SVzZaeK/Gc8zbLHe0QoYkq4eil77TC1t+IoivMu6GbztEKAhceYf+sOhq43jKurWAyk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8jSGCu_1718697412;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8jSGCu_1718697412)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 15:56:53 +0800
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
Subject: [PATCH net-next v6 09/10] virtio_net: xsk: rx: support recv merge mode
Date: Tue, 18 Jun 2024 15:56:42 +0800
Message-Id: <20240618075643.24867-10-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com>
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 8baa0af3684b
Content-Transfer-Encoding: 8bit

Support AF-XDP for merge mode.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 139 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 06608d696e2e..cfa106aa8039 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -504,6 +504,10 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 			       struct net_device *dev,
 			       unsigned int *xdp_xmit,
 			       struct virtnet_rq_stats *stats);
+static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
+					       struct sk_buff *curr_skb,
+					       struct page *page, void *buf,
+					       int len, int truesize);
 
 static bool is_xdp_frame(void *ptr)
 {
@@ -1128,6 +1132,139 @@ static struct sk_buff *virtnet_receive_xsk_small(struct net_device *dev, struct
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
+		skb = xdp_construct_skb(rq, xdp);
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
 static struct sk_buff *virtnet_receive_xsk_buf(struct virtnet_info *vi, struct receive_queue *rq,
 					       void *buf, u32 len,
 					       unsigned int *xdp_xmit,
@@ -1154,6 +1291,8 @@ static struct sk_buff *virtnet_receive_xsk_buf(struct virtnet_info *vi, struct r
 
 	if (!vi->mergeable_rx_bufs)
 		skb = virtnet_receive_xsk_small(dev, vi, rq, xdp, xdp_xmit, stats);
+	else
+		skb = virtnet_receive_xsk_merge(dev, vi, rq, xdp, xdp_xmit, stats);
 
 	return skb;
 }
-- 
2.32.0.3.g01195cf9f


