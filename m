Return-Path: <bpf+bounces-33946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 242B39282EB
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 09:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98BC61F2290D
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 07:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7464A146A79;
	Fri,  5 Jul 2024 07:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dVpTUb1X"
X-Original-To: bpf@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4086145330;
	Fri,  5 Jul 2024 07:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165076; cv=none; b=mLGKeGcqGNB9raaO9Z+Bvel+dqQ62itAsvAqF9xfWMFoxghzV63IQ/5NmjQxBlgTQsafSythpB32fUPjgPSQICgXDuLXnmTSYFW//8FPra/oBOL3Kalo7KB8SGOMQ7HMQz0r6zvKe2j1LigUzUuy5AFRax5NYK3I6p1bOFGS1rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165076; c=relaxed/simple;
	bh=bCWFnpj9o4+DpBTMgUBEoOAo1WULrZdndvRQAbBqfIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=beD0jUwjxnKNWIssB0UjdzjK06HxXWwTmJ8OlEZtuDgz/8a6FQsPuEIAbGpF+Z/bDbOYm2gRTnPG3DPzuDZsPcPSdYxO0Gr3/wwC1RTLxi6a810ErNfE16KCunIgOSwhR/UFyvip52319VLNpeK0mNHrsk9Z5xm20oM3RZLgCRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dVpTUb1X; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720165065; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=eSqZLYw1tnfN969d85a/aQLFRowDtR6gMpOsMidxQW0=;
	b=dVpTUb1X2FBg4szybyal7vzHRGXwl7NCYkD+E0aBan9rT6bc8SJnZQySySCKpEEfEMsw9twjRJdI1wNJZVU5GuQ//xYTU9huJ2MXI2YQcwWbAfg1YBBai6ZAOXAq9GOvOgyU448FlobnFPReJzi8Tj/ZRMp26G7qgEG2/ijLrwk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W9u53qw_1720165064;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W9u53qw_1720165064)
          by smtp.aliyun-inc.com;
          Fri, 05 Jul 2024 15:37:45 +0800
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
Subject: [PATCH net-next v7 10/10] virtio_net: xsk: rx: support recv merge mode
Date: Fri,  5 Jul 2024 15:37:34 +0800
Message-Id: <20240705073734.93905-11-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com>
References: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: bfc652b69f2c
Content-Transfer-Encoding: 8bit

Support AF-XDP for merge mode.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---

v7:
    1. include the handle for unused buffers

 drivers/net/virtio_net.c | 144 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 64d8cd481890..67724e7ab5e8 100644
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


