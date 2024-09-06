Return-Path: <bpf+bounces-39110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADE296F047
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 11:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256E71C23521
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 09:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EE81C9EB0;
	Fri,  6 Sep 2024 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZ58DOvE"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779741C9DFE
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616357; cv=none; b=Q8z/gSIoSNtXVvJ/rvsUhkUKAw2lI81hU34tVQ8qHppXJ8HA+zawybjacbZsCgC9YWMvM8kjVM4xRYmV8PA6ABDWWVeUXP1getAXLXMALiEZCLiF7YzDB6BYYLVAKHY/+Jata5pWA7Ub919ezKiiRzoo0O40OIETLyS3jtNqQbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616357; c=relaxed/simple;
	bh=dCHcn/1FgMWhuuHVvEWKLUbibFBqHz7uA0Xt+uzcciM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FE3p9Ti5TTgSE/hrZSq8c8WEFxMhV2mU7Sitkpwg1RRbAe+HcvUAPx+pLOmEXeS3X1eZEPVqAW/gwgh2BmhhyDtYd0zGQC76im/wSS9maTDhJE3bhkfKyib7XFwrHJIPgzqLwTyl1hxKXknE4ez1GvVTJTN/fRIIf7mXaDms4H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iZ58DOvE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725616354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8H99B9KUPJW7l1/czX9Tp6t+iue87wNuoi4+eOXBhL0=;
	b=iZ58DOvEYptrYhELD1PIhma+iZOsioKenGRMRNinI6ugMvp1/pZdNnpljCQTLbhB5JVTG7
	5WFlvtKqINQMUXq3Xs9Ub0B+71pjMVBV28IVKXetA4fsWrzMaX0obBJ+lyjD5qnXo+kzWD
	suTeJt5jJf7tHZx0nvbjqiW3UhHtch8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-8WKdBfzFOM-1UqXk46aqfg-1; Fri, 06 Sep 2024 05:52:33 -0400
X-MC-Unique: 8WKdBfzFOM-1UqXk46aqfg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3771b6da3ceso1088711f8f.3
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 02:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725616352; x=1726221152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8H99B9KUPJW7l1/czX9Tp6t+iue87wNuoi4+eOXBhL0=;
        b=tfjzngmK+rdzaUQDx/ORJxY/XIzyytOa3s0cXml/V2PpQCW+yIHofq9HCrUVp5F5wZ
         HfGHqw0DKLyNndo5ThcOvfEeFspMzzCD2B+DKrPpknStOCYHmNPWgp176PQ8hSL4bnAY
         4RgobG+XKGAJf9UieqW2Cu0qIRHRlEzG+07AhW2NneQPwZeFDOl2ZUOpU+UnwxWl809A
         XBZk9KtEzuXQ5yDeiAyktVxCfD5whCHeIzIjMopQJxVbcGQaiFVpioABwXm+k4DEIRIN
         Y+JwMoJ/hq/RdPZp330TS1vqvBIPif3skGYYIazn+7Dg+OLOSw31vAswTB2st29nz7Op
         wymA==
X-Forwarded-Encrypted: i=1; AJvYcCXnRYyF2yaOHB1nPspWlvrLqu1gtgL4zb8Qgf2UBSRuXPKPpXH8+19R7Upk4d0TjaHOv6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YytQAKEFOxh7c0M1tMUa19MQBMOmBeBa6psB8OG0NdeLTv4krzK
	TVQCxpaQ/IDdrJwpSifpX/A5bv503cIggZijA9DAMVIMRUsLSk5S4wTSGJzPOZrb7aAX40bIJcl
	CytIvyfV76S7YhPXo83sXRMgSdIGH85QMjvINWusmzf3FAUxVrw==
X-Received: by 2002:a05:6000:18a7:b0:376:7a68:bc42 with SMTP id ffacd0b85a97d-3767a68c23dmr9293275f8f.27.1725616352183;
        Fri, 06 Sep 2024 02:52:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFIF65gKfiZPFBH5iQEaBnXgeO1FhuaZdZ4FK0I9pUsn3NYiq1dGZhLD2zESCViTEQMrN15g==
X-Received: by 2002:a05:6000:18a7:b0:376:7a68:bc42 with SMTP id ffacd0b85a97d-3767a68c23dmr9293241f8f.27.1725616351706;
        Fri, 06 Sep 2024 02:52:31 -0700 (PDT)
Received: from redhat.com ([155.133.17.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca0606984sm14793275e9.40.2024.09.06.02.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 02:52:31 -0700 (PDT)
Date: Fri, 6 Sep 2024 05:52:26 -0400
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
Subject: [RFC PATCH v2 3/7] Revert "virtio_net: xsk: rx: support fill with
 xsk buffer"
Message-ID: <9559b3ff39bbe94bb81caf2e6c1e464eea0e9de9.1725616135.git.mst@redhat.com>
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

This reverts commit e9f3962441c0a4d6f16c656e6c8aa02a3ccdd568.

leads to crashes with no ACCESS_PLATFORM when
sysctl net.core.high_order_alloc_disable=1

Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Reported-by: Si-Wei Liu <si-wei.liu@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 70 +++-------------------------------------
 1 file changed, 4 insertions(+), 66 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 041c483a06c5..3cb0f8adf2e6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -354,8 +354,6 @@ struct receive_queue {
 
 	/* xdp rxq used by xsk */
 	struct xdp_rxq_info xsk_rxq_info;
-
-	struct xdp_buff **xsk_buffs;
 };
 
 /* This structure can contain rss message with maximum settings for indirection table and keysize
@@ -1056,53 +1054,6 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
 	}
 }
 
-static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
-{
-	sg->dma_address = addr;
-	sg->length = len;
-}
-
-static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue *rq,
-				   struct xsk_buff_pool *pool, gfp_t gfp)
-{
-	struct xdp_buff **xsk_buffs;
-	dma_addr_t addr;
-	int err = 0;
-	u32 len, i;
-	int num;
-
-	xsk_buffs = rq->xsk_buffs;
-
-	num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
-	if (!num)
-		return -ENOMEM;
-
-	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
-
-	for (i = 0; i < num; ++i) {
-		/* Use the part of XDP_PACKET_HEADROOM as the virtnet hdr space.
-		 * We assume XDP_PACKET_HEADROOM is larger than hdr->len.
-		 * (see function virtnet_xsk_pool_enable)
-		 */
-		addr = xsk_buff_xdp_get_dma(xsk_buffs[i]) - vi->hdr_len;
-
-		sg_init_table(rq->sg, 1);
-		sg_fill_dma(rq->sg, addr, len);
-
-		err = virtqueue_add_inbuf(rq->vq, rq->sg, 1, xsk_buffs[i], gfp);
-		if (err)
-			goto err;
-	}
-
-	return num;
-
-err:
-	for (; i < num; ++i)
-		xsk_buff_free(xsk_buffs[i]);
-
-	return err;
-}
-
 static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -2294,11 +2245,7 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
 			  gfp_t gfp)
 {
 	int err;
-
-	if (rq->xsk_pool) {
-		err = virtnet_add_recvbuf_xsk(vi, rq, rq->xsk_pool, gfp);
-		goto kick;
-	}
+	bool oom;
 
 	do {
 		if (vi->mergeable_rx_bufs)
@@ -2308,11 +2255,10 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
 		else
 			err = add_recvbuf_small(vi, rq, gfp);
 
+		oom = err == -ENOMEM;
 		if (err)
 			break;
 	} while (rq->vq->num_free);
-
-kick:
 	if (virtqueue_kick_prepare(rq->vq) && virtqueue_notify(rq->vq)) {
 		unsigned long flags;
 
@@ -2321,7 +2267,7 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
 		u64_stats_update_end_irqrestore(&rq->stats.syncp, flags);
 	}
 
-	return err != -ENOMEM;
+	return !oom;
 }
 
 static void skb_recv_done(struct virtqueue *rvq)
@@ -5168,7 +5114,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	struct receive_queue *rq;
 	struct device *dma_dev;
 	struct send_queue *sq;
-	int err, size;
+	int err;
 
 	if (vi->hdr_len > xsk_pool_get_headroom(pool))
 		return -EINVAL;
@@ -5199,12 +5145,6 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	if (!dma_dev)
 		return -EINVAL;
 
-	size = virtqueue_get_vring_size(rq->vq);
-
-	rq->xsk_buffs = kvcalloc(size, sizeof(*rq->xsk_buffs), GFP_KERNEL);
-	if (!rq->xsk_buffs)
-		return -ENOMEM;
-
 	err = xsk_pool_dma_map(pool, dma_dev, 0);
 	if (err)
 		goto err_xsk_map;
@@ -5239,8 +5179,6 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
 
 	xsk_pool_dma_unmap(pool, 0);
 
-	kvfree(rq->xsk_buffs);
-
 	return err;
 }
 
-- 
MST


