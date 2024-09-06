Return-Path: <bpf+bounces-39109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C3D96F042
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 11:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204A11F29C3E
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 09:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89331C9DC3;
	Fri,  6 Sep 2024 09:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRgan3Lf"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00321C7B8C
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616352; cv=none; b=LDhAc2yCkWgxBqHv4skvM/FnAM+wMRF71LS5k9SMUOk2cz3uEnlarjO/XjiZmlyGTgLOWRE5gUxiNO1aCv3NsleENB3v+FeqY7oYkdBP30ElFnATxiUa7Yv356a+kOKFNi926YnursrHCwqiYYYRyEgs9aNKmkgNNFrMuTRUtys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616352; c=relaxed/simple;
	bh=KyPP1o9S1U5UC6LtE50yMluFJTn7axsCXpK4LciRg5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1bb8f1DfH+br/eJAOtRfmqKIsRaMTDGsC2fJIsWnLWRjJYeJSFwx0dRG/yqgZwxq/qy+bf+tNL/lOIzhpTB5f42StX1yQeglIPryN0cQ2DhePYLIzLmgGg8MJTsBGd85pgKazL7aVRu8eXaBD0Fgim92CoAayhEdkxXjokjO9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iRgan3Lf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725616349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vyImZpVyScr+sYVvHBd0P2jX1+a+RifktquzyDOii9A=;
	b=iRgan3LfKuWqUAfjeATMpjIbKTJ9pmDWVm3WM9XDhE41dH5VRg+xvpq+Jr7UQ3FtV80/AQ
	YkStOCSF70YOC4mcJRKNsyEDKdrKxQnRcYg5bozGMTx/q/2lYy0MoLEFDj85xTiTEMybNu
	4vRohIUv3O2AGDJoLjNSgBiDNGQUqbE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-wrPTUhL5N86skLnMxPx2fA-1; Fri, 06 Sep 2024 05:52:28 -0400
X-MC-Unique: wrPTUhL5N86skLnMxPx2fA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374bb1e931cso1480706f8f.0
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 02:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725616347; x=1726221147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyImZpVyScr+sYVvHBd0P2jX1+a+RifktquzyDOii9A=;
        b=GqwHAEEjzzNDHiLyN07pAD16geqgdoXIWXbY+M6iOuj3nNfIJUv7/B4qM9kt2/dROS
         CX2ngA76oW/BAvmtoiVmj+Kfz8nuWVrgwPCFK2QOEHDDOfAe8ezCr8Gvcu3Nc4FgYP5/
         aUxH9ZxbbURSpFKcuwd2F4tNBMyXdTB7dg/nQj5t59TZFwmsrAKG4/PKd7PVGJ4PTEhZ
         6ILm+LsnH/X6F7RRealvxZugRyC3rSjLGIYWWsqa1zTinZOTCcaM0CI4g++sVy29QmI3
         gJ/MAEXBF9KGAcUIYIDti8vIcBwR2gEDTw7MRRzxxxb+dpHT7H44ZuB1EOwBXEsQI7en
         bjyA==
X-Forwarded-Encrypted: i=1; AJvYcCUMo/OiQQPWFvbBYEtTRwACXeNXnHy9Tk/IkYD//XHEkgUOkNzkdTkGh/QUz2KKrRBE0Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YydqSzq56Mer5jXPh8vToed+5ywdgb8ZGfGvLd3kvAjwimkWtLq
	6gtLdGjl/pFtZQncyZUtPnLavrPt1g5OXs4D11Gyyz88pkHTJOVWwewX0zlIuZJMVbx/EXxvRdw
	/PK1EdMhDN2EdXOW3t0Xxew2F0lAJaHZuSfC7Ddhq8Hvypu27ug==
X-Received: by 2002:a05:600c:468a:b0:428:b4a:7001 with SMTP id 5b1f17b1804b1-42c95be865emr55954425e9.15.1725616347147;
        Fri, 06 Sep 2024 02:52:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAzjIbOhY0yl5ABAsozjpxMGlePH4FD0Zgd3LEMcGMp/X5jhGJ5bKacT+G2O0mgJRKlVceNA==
X-Received: by 2002:a05:600c:468a:b0:428:b4a:7001 with SMTP id 5b1f17b1804b1-42c95be865emr55954205e9.15.1725616346621;
        Fri, 06 Sep 2024 02:52:26 -0700 (PDT)
Received: from redhat.com ([155.133.17.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05d925dsm14786045e9.39.2024.09.06.02.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 02:52:24 -0700 (PDT)
Date: Fri, 6 Sep 2024 05:52:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Si-Wei Liu <si-wei.liu@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Subject: [RFC PATCH v2 2/7] Revert "virtio_net: xsk: rx: support recv small
 mode"
Message-ID: <6838211b8b864c757204a2bfd1ad3ffc7aa42e52.1725616135.git.mst@redhat.com>
References: <cover.1725616135.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725616135.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

This reverts commit a4e7ba7027012f009f22a68bcfde670f9298d3a4.

leads to crashes with no ACCESS_PLATFORM when
sysctl net.core.high_order_alloc_disable=1

Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Reported-by: Si-Wei Liu <si-wei.liu@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 198 ++++-----------------------------------
 1 file changed, 19 insertions(+), 179 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 15e202dd6964..041c483a06c5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -498,12 +498,6 @@ struct virtio_net_common_hdr {
 };
 
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
-static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
-			       struct net_device *dev,
-			       unsigned int *xdp_xmit,
-			       struct virtnet_rq_stats *stats);
-static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
-				 struct sk_buff *skb, u8 flags);
 
 static bool is_xdp_frame(void *ptr)
 {
@@ -1068,124 +1062,6 @@ static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
 	sg->length = len;
 }
 
-static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
-				   struct receive_queue *rq, void *buf, u32 len)
-{
-	struct xdp_buff *xdp;
-	u32 bufsize;
-
-	xdp = (struct xdp_buff *)buf;
-
-	bufsize = xsk_pool_get_rx_frame_size(rq->xsk_pool) + vi->hdr_len;
-
-	if (unlikely(len > bufsize)) {
-		pr_debug("%s: rx error: len %u exceeds truesize %u\n",
-			 vi->dev->name, len, bufsize);
-		DEV_STATS_INC(vi->dev, rx_length_errors);
-		xsk_buff_free(xdp);
-		return NULL;
-	}
-
-	xsk_buff_set_size(xdp, len);
-	xsk_buff_dma_sync_for_cpu(xdp);
-
-	return xdp;
-}
-
-static struct sk_buff *xsk_construct_skb(struct receive_queue *rq,
-					 struct xdp_buff *xdp)
-{
-	unsigned int metasize = xdp->data - xdp->data_meta;
-	struct sk_buff *skb;
-	unsigned int size;
-
-	size = xdp->data_end - xdp->data_hard_start;
-	skb = napi_alloc_skb(&rq->napi, size);
-	if (unlikely(!skb)) {
-		xsk_buff_free(xdp);
-		return NULL;
-	}
-
-	skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
-
-	size = xdp->data_end - xdp->data_meta;
-	memcpy(__skb_put(skb, size), xdp->data_meta, size);
-
-	if (metasize) {
-		__skb_pull(skb, metasize);
-		skb_metadata_set(skb, metasize);
-	}
-
-	xsk_buff_free(xdp);
-
-	return skb;
-}
-
-static struct sk_buff *virtnet_receive_xsk_small(struct net_device *dev, struct virtnet_info *vi,
-						 struct receive_queue *rq, struct xdp_buff *xdp,
-						 unsigned int *xdp_xmit,
-						 struct virtnet_rq_stats *stats)
-{
-	struct bpf_prog *prog;
-	u32 ret;
-
-	ret = XDP_PASS;
-	rcu_read_lock();
-	prog = rcu_dereference(rq->xdp_prog);
-	if (prog)
-		ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
-	rcu_read_unlock();
-
-	switch (ret) {
-	case XDP_PASS:
-		return xsk_construct_skb(rq, xdp);
-
-	case XDP_TX:
-	case XDP_REDIRECT:
-		return NULL;
-
-	default:
-		/* drop packet */
-		xsk_buff_free(xdp);
-		u64_stats_inc(&stats->drops);
-		return NULL;
-	}
-}
-
-static void virtnet_receive_xsk_buf(struct virtnet_info *vi, struct receive_queue *rq,
-				    void *buf, u32 len,
-				    unsigned int *xdp_xmit,
-				    struct virtnet_rq_stats *stats)
-{
-	struct net_device *dev = vi->dev;
-	struct sk_buff *skb = NULL;
-	struct xdp_buff *xdp;
-	u8 flags;
-
-	len -= vi->hdr_len;
-
-	u64_stats_add(&stats->bytes, len);
-
-	xdp = buf_to_xdp(vi, rq, buf, len);
-	if (!xdp)
-		return;
-
-	if (unlikely(len < ETH_HLEN)) {
-		pr_debug("%s: short packet %i\n", dev->name, len);
-		DEV_STATS_INC(dev, rx_length_errors);
-		xsk_buff_free(xdp);
-		return;
-	}
-
-	flags = ((struct virtio_net_common_hdr *)(xdp->data - vi->hdr_len))->hdr.flags;
-
-	if (!vi->mergeable_rx_bufs)
-		skb = virtnet_receive_xsk_small(dev, vi, rq, xdp, xdp_xmit, stats);
-
-	if (skb)
-		virtnet_receive_done(vi, rq, skb, flags);
-}
-
 static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue *rq,
 				   struct xsk_buff_pool *pool, gfp_t gfp)
 {
@@ -2516,67 +2392,31 @@ static void refill_work(struct work_struct *work)
 	}
 }
 
-static int virtnet_receive_xsk_bufs(struct virtnet_info *vi,
-				    struct receive_queue *rq,
-				    int budget,
-				    unsigned int *xdp_xmit,
-				    struct virtnet_rq_stats *stats)
-{
-	unsigned int len;
-	int packets = 0;
-	void *buf;
-
-	while (packets < budget) {
-		buf = virtqueue_get_buf(rq->vq, &len);
-		if (!buf)
-			break;
-
-		virtnet_receive_xsk_buf(vi, rq, buf, len, xdp_xmit, stats);
-		packets++;
-	}
-
-	return packets;
-}
-
-static int virtnet_receive_packets(struct virtnet_info *vi,
-				   struct receive_queue *rq,
-				   int budget,
-				   unsigned int *xdp_xmit,
-				   struct virtnet_rq_stats *stats)
-{
-	unsigned int len;
-	int packets = 0;
-	void *buf;
-
-	if (!vi->big_packets || vi->mergeable_rx_bufs) {
-		void *ctx;
-		while (packets < budget &&
-		       (buf = virtnet_rq_get_buf(rq, &len, &ctx))) {
-			receive_buf(vi, rq, buf, len, ctx, xdp_xmit, stats);
-			packets++;
-		}
-	} else {
-		while (packets < budget &&
-		       (buf = virtqueue_get_buf(rq->vq, &len)) != NULL) {
-			receive_buf(vi, rq, buf, len, NULL, xdp_xmit, stats);
-			packets++;
-		}
-	}
-
-	return packets;
-}
-
 static int virtnet_receive(struct receive_queue *rq, int budget,
 			   unsigned int *xdp_xmit)
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
 	struct virtnet_rq_stats stats = {};
-	int i, packets;
+	unsigned int len;
+	int packets = 0;
+	void *buf;
+	int i;
 
-	if (rq->xsk_pool)
-		packets = virtnet_receive_xsk_bufs(vi, rq, budget, xdp_xmit, &stats);
-	else
-		packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
+	if (!vi->big_packets || vi->mergeable_rx_bufs) {
+		void *ctx;
+
+		while (packets < budget &&
+		       (buf = virtnet_rq_get_buf(rq, &len, &ctx))) {
+			receive_buf(vi, rq, buf, len, ctx, xdp_xmit, &stats);
+			packets++;
+		}
+	} else {
+		while (packets < budget &&
+		       (buf = virtqueue_get_buf(rq->vq, &len)) != NULL) {
+			receive_buf(vi, rq, buf, len, NULL, xdp_xmit, &stats);
+			packets++;
+		}
+	}
 
 	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
 		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
-- 
MST


