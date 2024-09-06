Return-Path: <bpf+bounces-39108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6767696F040
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 11:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C16E7B221F2
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 09:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2951C8FD8;
	Fri,  6 Sep 2024 09:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LKnyHv6v"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2471C8FB0
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616351; cv=none; b=qXKa17lA0PoNvpqUBxoVYu1S9D5ChpLRf4aUYjDgqW28MlRvk8jeBUTAfWAgPz6td3YwsU9UER+OtOumR6B94Gx0/JV1ExaRe43P1TlZ99IaoVUvbCPOjjXNEkbzUSMuRJs4nQHzP2s/nZwglcMhQjDql6ziumH9/T0bqlZSNE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616351; c=relaxed/simple;
	bh=DWPyC70aofNTN8NzN76YlcX1EqMQAr3p3SCqYoehNM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwJ1V5bVjrHYu9oP4I1Y8CTH6JOMeJGUsRg3RXzROKR95d71oQNsOCg7xHJoUyjCtLw88MzH3gQ8OWFAZ8QDU78h6oUfmv501DVmGrDxZgN87BF7EvDJNSgEMTiF32EDTRRcF789ARgMcSDp3eVVEdxiDUkcvuGNg8La4ruY+58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LKnyHv6v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725616349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qOfH+ccoyBiuGopATmlM0rbjaC0DlQkgKBk3NY2p3mM=;
	b=LKnyHv6vVQ0BXzHtfZtjc8wcmIR7uO30BtQtaKXvEAUT8IZ5qTJOi54n7J5GgG2InwQsMF
	K3ghbcNflgkelmcFRfABIZhZjVsU+VocbqaBIvgqUK87ZbdmnTg0XFbbwQ9mIkjd6NgRyM
	jdZBzuyqx8OuU2xoWHTwqlL785DJnQQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-nmQbWcFPMZyRejq820IUlw-1; Fri, 06 Sep 2024 05:52:28 -0400
X-MC-Unique: nmQbWcFPMZyRejq820IUlw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-374cd315c68so1190304f8f.0
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 02:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725616342; x=1726221142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOfH+ccoyBiuGopATmlM0rbjaC0DlQkgKBk3NY2p3mM=;
        b=mYgxbt+CXmqDFI4S2J7QPYlR6B68tyTb7xCAqYvEWgklwfcD2e8P/KtWIXXFJQO0a6
         1jD8SWdvFU0PNkbkw3m1fuY4I2lDcr0MdRNUgvqcRCyXWYazaCw3FWq2tjqsC6O+14Vg
         ydJHSHV/2Ne0M26FCSoAq0ySZIe+cWpytPblYl/RiIlwHQHm6Qch32yDUGS6XNyNtgls
         yrngEKrWdyRdgwyUNlHGh8zStGSIq+AGOmfOPT0PnFpvi2vPhgyibwwu4lR8UbWA06Sd
         abhbBxfvO0jDGKFlFPSHx7I7c2TzkubDXBrn7n8ZAolUkhtcUuZU5Ke59evKQLh4/obq
         AbKA==
X-Forwarded-Encrypted: i=1; AJvYcCXsxf6BGKwyIW8pUdtI01DILWHGp1I2mcieyumz/bBJ+vPCBy0w2ZVadIhyGXVEC8gMi9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFb5VPWLsGlvsG6ojmJmLuQRXoiOMouYo7Ioy3kN7FtT5GCkEt
	tCW3He7jFV9t03vXumaY5XZg5ERd2XG87eDji8Uxdj4EkS9OTD+JSM7t0v3IFUefD43JTIIt7nx
	20WamfUVVTvslnG+7wtAx8P5+xBCmW0HpKriDLkdsm1U+VqJNkk0MheepwwDZ
X-Received: by 2002:adf:fb11:0:b0:371:8845:a3af with SMTP id ffacd0b85a97d-3749b57f2f1mr16703545f8f.39.1725616341752;
        Fri, 06 Sep 2024 02:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTt73JKwPHK16Z3/RYkW5dDFMWDG3+e0lk0yoShyoCu8E1G8MPLSTYcu8GmLc/SunC8mGUWg==
X-Received: by 2002:adf:fb11:0:b0:371:8845:a3af with SMTP id ffacd0b85a97d-3749b57f2f1mr16703518f8f.39.1725616340741;
        Fri, 06 Sep 2024 02:52:20 -0700 (PDT)
Received: from redhat.com ([155.133.17.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c958c471sm13302350f8f.25.2024.09.06.02.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 02:52:20 -0700 (PDT)
Date: Fri, 6 Sep 2024 05:52:16 -0400
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
Subject: [RFC PATCH v2 1/7] Revert "virtio_net: xsk: rx: support recv merge
 mode"
Message-ID: <51e961cfb4f0a4db7fb4a7dc97cc966af05bf895.1725616135.git.mst@redhat.com>
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

This reverts commit 99c861b44eb1fb9dfe8776854116a6a9064c19bb.

leads to crashes with no ACCESS_PLATFORM when
sysctl net.core.high_order_alloc_disable=1

Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Reported-by: Si-Wei Liu <si-wei.liu@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 144 ---------------------------------------
 1 file changed, 144 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c6af18948092..15e202dd6964 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -504,10 +504,6 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 			       struct virtnet_rq_stats *stats);
 static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
 				 struct sk_buff *skb, u8 flags);
-static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
-					       struct sk_buff *curr_skb,
-					       struct page *page, void *buf,
-					       int len, int truesize);
 
 static bool is_xdp_frame(void *ptr)
 {
@@ -988,11 +984,6 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 
 	rq = &vi->rq[i];
 
-	if (rq->xsk_pool) {
-		xsk_buff_free((struct xdp_buff *)buf);
-		return;
-	}
-
 	if (!vi->big_packets || vi->mergeable_rx_bufs)
 		virtnet_rq_unmap(rq, buf, 0);
 
@@ -1161,139 +1152,6 @@ static struct sk_buff *virtnet_receive_xsk_small(struct net_device *dev, struct
 	}
 }
 
-static void xsk_drop_follow_bufs(struct net_device *dev,
-				 struct receive_queue *rq,
-				 u32 num_buf,
-				 struct virtnet_rq_stats *stats)
-{
-	struct xdp_buff *xdp;
-	u32 len;
-
-	while (num_buf-- > 1) {
-		xdp = virtqueue_get_buf(rq->vq, &len);
-		if (unlikely(!xdp)) {
-			pr_debug("%s: rx error: %d buffers missing\n",
-				 dev->name, num_buf);
-			DEV_STATS_INC(dev, rx_length_errors);
-			break;
-		}
-		u64_stats_add(&stats->bytes, len);
-		xsk_buff_free(xdp);
-	}
-}
-
-static int xsk_append_merge_buffer(struct virtnet_info *vi,
-				   struct receive_queue *rq,
-				   struct sk_buff *head_skb,
-				   u32 num_buf,
-				   struct virtio_net_hdr_mrg_rxbuf *hdr,
-				   struct virtnet_rq_stats *stats)
-{
-	struct sk_buff *curr_skb;
-	struct xdp_buff *xdp;
-	u32 len, truesize;
-	struct page *page;
-	void *buf;
-
-	curr_skb = head_skb;
-
-	while (--num_buf) {
-		buf = virtqueue_get_buf(rq->vq, &len);
-		if (unlikely(!buf)) {
-			pr_debug("%s: rx error: %d buffers out of %d missing\n",
-				 vi->dev->name, num_buf,
-				 virtio16_to_cpu(vi->vdev,
-						 hdr->num_buffers));
-			DEV_STATS_INC(vi->dev, rx_length_errors);
-			return -EINVAL;
-		}
-
-		u64_stats_add(&stats->bytes, len);
-
-		xdp = buf_to_xdp(vi, rq, buf, len);
-		if (!xdp)
-			goto err;
-
-		buf = napi_alloc_frag(len);
-		if (!buf) {
-			xsk_buff_free(xdp);
-			goto err;
-		}
-
-		memcpy(buf, xdp->data - vi->hdr_len, len);
-
-		xsk_buff_free(xdp);
-
-		page = virt_to_page(buf);
-
-		truesize = len;
-
-		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
-						    buf, len, truesize);
-		if (!curr_skb) {
-			put_page(page);
-			goto err;
-		}
-	}
-
-	return 0;
-
-err:
-	xsk_drop_follow_bufs(vi->dev, rq, num_buf, stats);
-	return -EINVAL;
-}
-
-static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct virtnet_info *vi,
-						 struct receive_queue *rq, struct xdp_buff *xdp,
-						 unsigned int *xdp_xmit,
-						 struct virtnet_rq_stats *stats)
-{
-	struct virtio_net_hdr_mrg_rxbuf *hdr;
-	struct bpf_prog *prog;
-	struct sk_buff *skb;
-	u32 ret, num_buf;
-
-	hdr = xdp->data - vi->hdr_len;
-	num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
-
-	ret = XDP_PASS;
-	rcu_read_lock();
-	prog = rcu_dereference(rq->xdp_prog);
-	/* TODO: support multi buffer. */
-	if (prog && num_buf == 1)
-		ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
-	rcu_read_unlock();
-
-	switch (ret) {
-	case XDP_PASS:
-		skb = xsk_construct_skb(rq, xdp);
-		if (!skb)
-			goto drop_bufs;
-
-		if (xsk_append_merge_buffer(vi, rq, skb, num_buf, hdr, stats)) {
-			dev_kfree_skb(skb);
-			goto drop;
-		}
-
-		return skb;
-
-	case XDP_TX:
-	case XDP_REDIRECT:
-		return NULL;
-
-	default:
-		/* drop packet */
-		xsk_buff_free(xdp);
-	}
-
-drop_bufs:
-	xsk_drop_follow_bufs(dev, rq, num_buf, stats);
-
-drop:
-	u64_stats_inc(&stats->drops);
-	return NULL;
-}
-
 static void virtnet_receive_xsk_buf(struct virtnet_info *vi, struct receive_queue *rq,
 				    void *buf, u32 len,
 				    unsigned int *xdp_xmit,
@@ -1323,8 +1181,6 @@ static void virtnet_receive_xsk_buf(struct virtnet_info *vi, struct receive_queu
 
 	if (!vi->mergeable_rx_bufs)
 		skb = virtnet_receive_xsk_small(dev, vi, rq, xdp, xdp_xmit, stats);
-	else
-		skb = virtnet_receive_xsk_merge(dev, vi, rq, xdp, xdp_xmit, stats);
 
 	if (skb)
 		virtnet_receive_done(vi, rq, skb, flags);
-- 
MST


