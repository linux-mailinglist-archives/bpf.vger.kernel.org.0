Return-Path: <bpf+bounces-31992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7ED905F64
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 01:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A90DB21569
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 23:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C32712D219;
	Wed, 12 Jun 2024 23:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blNH34hy"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7FA4EB5E
	for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 23:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718235796; cv=none; b=PkppUmbsb/A1QP89WxGTSbkn5VzZqjezRw6zorT3ocI6adnASgXmOyQsyoh4oPDW8Ai7aQ4WWomRHqjTVCIh0bQGZGW0CoonrH2druc0sk8YXudT8Fe0gR2bjYTpmLAXOR2BiLYvD0AQdXRlHge9H3Z3dcFqsYmxgd1Uz2Qx6n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718235796; c=relaxed/simple;
	bh=cnRYODpI9tJUf9+ZvQzdf60fb/6enZf0LGZPGMXVci4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFOKoYgWqqNKITcePzTkSMMk5AwS5jt95QlP2+xH13KFCOKbKEuZIisVNohgv8CsGm2meyy2yzNcaoFJAtmp4NMSFChs5kZJU/YEK0kUBoG+WEjlB6h/mL5AbJNjwd89mrib38qzF+x6QHYVkwOS3cSnl5htUNJ7q3zn98njBpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=blNH34hy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718235793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AdR9/iXzfdISa1S4l83S4hXJaIuX2PTnPsQYxX/u7oc=;
	b=blNH34hyPqeT1mnWMYMOIcZHBk0ZLfMS9RlDDIALrtZWsUcc4FP46LZuFbxc1hhBo0u3eG
	YW623iirqisN1DEcqgW2CHFh9j4DuR7Rb6UQQBZ+IjLzHjlBKhyDRZoJM4LWJ9G4fcUFnu
	ozh4cJ7JiadV/oHdtgo/lTereJr3HbE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-_7L_c2nUP-67Q-ihSJOGVw-1; Wed, 12 Jun 2024 19:43:07 -0400
X-MC-Unique: _7L_c2nUP-67Q-ihSJOGVw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35f1f958b7dso272665f8f.3
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 16:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718235786; x=1718840586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdR9/iXzfdISa1S4l83S4hXJaIuX2PTnPsQYxX/u7oc=;
        b=mAd4YNrEHwVTLMlxXcNBliEmUrVjrAaI/Mi6HleNwGlQ5xkUER4XsMWtcMARY4jR55
         hSOvaBm6r1wd/js9fXzsofiRpP/9WcRX3o8w9Dc6uyjYZ7rmxGLQaKvE+FDqY3+WG7Kd
         GtgfZi80gyjRUHzk3Yk6FiFqbOySpvg6D/oe5J9rNSHf0yv77lONvFZwHYcOTUjoF6p/
         PxCc6KJpDxF0NBlSFlwjbBojxFc7xkwSqD5xweziOj2QJR0ZyuT77w/PcRgppgHlDjDa
         +Zhc679CFzatADt6FPQbKgxBc5hhJ44kVweYzqemECKAG06MtQgw5ZVxrK6S9abQUTJW
         uV9g==
X-Forwarded-Encrypted: i=1; AJvYcCXSUEqAtCNKmiJGkecc8LR3nQGi1pg2jeUPQTnp/GrSRXOeEArFRoEZD380hAPB7/TRspgHnq8CwT9pZSir73BzhqxT
X-Gm-Message-State: AOJu0YxrJlklkbr0fm199eOoarU0LX8Blhxtl10e0+xR0hrCxAXI2hv0
	6QCDnxNXCK/Ua4qUXk+MkxxfTEwxx5nKCBK4rtnpRGJd/slldUvkzUnqlqLB1NLOb8iALDaqan2
	GXhfdMiW1wYPCC3npeUPo2xqS0wZW3ouKwR4Zn5A3uAY0RHVK3Q==
X-Received: by 2002:adf:e802:0:b0:360:70d2:ee10 with SMTP id ffacd0b85a97d-36070d2f410mr1279984f8f.54.1718235786137;
        Wed, 12 Jun 2024 16:43:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6hzPJD1DX6PMVA6/sd3MOh4PiIJ+wBZ8biS1Vx6k1PCZmiRmm60tKos+GyabcplT5JHB9JA==
X-Received: by 2002:adf:e802:0:b0:360:70d2:ee10 with SMTP id ffacd0b85a97d-36070d2f410mr1279965f8f.54.1718235785559;
        Wed, 12 Jun 2024 16:43:05 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:94c5:b48b:41a4:81c0:f1c8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075104954sm107591f8f.99.2024.06.12.16.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 16:43:04 -0700 (PDT)
Date: Wed, 12 Jun 2024 19:43:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 09/15] virtio_net: xsk: bind/unbind xsk
Message-ID: <20240612194235-mutt-send-email-mst@kernel.org>
References: <20240611114147.31320-1-xuanzhuo@linux.alibaba.com>
 <20240611114147.31320-10-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611114147.31320-10-xuanzhuo@linux.alibaba.com>

On Tue, Jun 11, 2024 at 07:41:41PM +0800, Xuan Zhuo wrote:
> This patch implement the logic of bind/unbind xsk pool to sq and rq.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

I'd just squash with previous patch. This one is hard to review in
isolation.

> ---
>  drivers/net/virtio_net.c | 199 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 199 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4968ab7eb5a4..c82a0691632c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -26,6 +26,7 @@
>  #include <net/netdev_rx_queue.h>
>  #include <net/netdev_queues.h>
>  #include <uapi/linux/virtio_ring.h>
> +#include <net/xdp_sock_drv.h>
>  
>  static int napi_weight = NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -57,6 +58,8 @@ DECLARE_EWMA(pkt_len, 0, 64)
>  
>  #define VIRTNET_DRIVER_VERSION "1.0.0"
>  
> +static struct virtio_net_hdr_mrg_rxbuf xsk_hdr;
> +
>  static const unsigned long guest_offloads[] = {
>  	VIRTIO_NET_F_GUEST_TSO4,
>  	VIRTIO_NET_F_GUEST_TSO6,
> @@ -320,6 +323,12 @@ struct send_queue {
>  	bool premapped;
>  
>  	struct virtnet_sq_dma_info dmainfo;
> +
> +	struct {
> +		struct xsk_buff_pool *pool;
> +
> +		dma_addr_t hdr_dma_address;
> +	} xsk;
>  };
>  
>  /* Internal representation of a receive virtqueue */
> @@ -371,6 +380,13 @@ struct receive_queue {
>  
>  	/* Record the last dma info to free after new pages is allocated. */
>  	struct virtnet_rq_dma *last_dma;
> +
> +	struct {
> +		struct xsk_buff_pool *pool;
> +
> +		/* xdp rxq used by xsk */
> +		struct xdp_rxq_info xdp_rxq;
> +	} xsk;
>  };
>  
>  /* This structure can contain rss message with maximum settings for indirection table and keysize
> @@ -5168,6 +5184,187 @@ static int virtnet_restore_guest_offloads(struct virtnet_info *vi)
>  	return virtnet_set_guest_offloads(vi, offloads);
>  }
>  
> +static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queue *rq,
> +				    struct xsk_buff_pool *pool)
> +{
> +	int err, qindex;
> +
> +	qindex = rq - vi->rq;
> +
> +	if (pool) {
> +		err = xdp_rxq_info_reg(&rq->xsk.xdp_rxq, vi->dev, qindex, rq->napi.napi_id);
> +		if (err < 0)
> +			return err;
> +
> +		err = xdp_rxq_info_reg_mem_model(&rq->xsk.xdp_rxq,
> +						 MEM_TYPE_XSK_BUFF_POOL, NULL);
> +		if (err < 0) {
> +			xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> +			return err;
> +		}
> +
> +		xsk_pool_set_rxq_info(pool, &rq->xsk.xdp_rxq);
> +	}
> +
> +	virtnet_rx_pause(vi, rq);
> +
> +	err = virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf);
> +	if (err) {
> +		netdev_err(vi->dev, "reset rx fail: rx queue index: %d err: %d\n", qindex, err);
> +
> +		pool = NULL;
> +	}
> +
> +	if (!pool)
> +		xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> +
> +	rq->xsk.pool = pool;
> +
> +	virtnet_rx_resume(vi, rq);
> +
> +	return err;
> +}
> +
> +static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
> +				    struct send_queue *sq,
> +				    struct xsk_buff_pool *pool)
> +{
> +	int err, qindex;
> +
> +	qindex = sq - vi->sq;
> +
> +	virtnet_tx_pause(vi, sq);
> +
> +	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
> +	if (err)
> +		netdev_err(vi->dev, "reset tx fail: tx queue index: %d err: %d\n", qindex, err);
> +	else
> +		err = virtnet_sq_set_premapped(sq, !!pool);
> +
> +	if (err)
> +		pool = NULL;
> +
> +	sq->xsk.pool = pool;
> +
> +	virtnet_tx_resume(vi, sq);
> +
> +	return err;
> +}
> +
> +static int virtnet_xsk_pool_enable(struct net_device *dev,
> +				   struct xsk_buff_pool *pool,
> +				   u16 qid)
> +{
> +	struct virtnet_info *vi = netdev_priv(dev);
> +	struct receive_queue *rq;
> +	struct send_queue *sq;
> +	struct device *dma_dev;
> +	dma_addr_t hdr_dma;
> +	int err;
> +
> +	/* In big_packets mode, xdp cannot work, so there is no need to
> +	 * initialize xsk of rq.
> +	 *
> +	 * Support for small mode firstly.
> +	 */
> +	if (vi->big_packets)
> +		return -ENOENT;
> +
> +	if (qid >= vi->curr_queue_pairs)
> +		return -EINVAL;
> +
> +	sq = &vi->sq[qid];
> +	rq = &vi->rq[qid];
> +
> +	/* xsk tx zerocopy depend on the tx napi.
> +	 *
> +	 * All xsk packets are actually consumed and sent out from the xsk tx
> +	 * queue under the tx napi mechanism.
> +	 */
> +	if (!sq->napi.weight)
> +		return -EPERM;
> +
> +	/* For the xsk, the tx and rx should have the same device. But
> +	 * vq->dma_dev allows every vq has the respective dma dev. So I check
> +	 * the dma dev of vq and sq is the same dev.
> +	 */
> +	if (virtqueue_dma_dev(rq->vq) != virtqueue_dma_dev(sq->vq))
> +		return -EPERM;
> +
> +	dma_dev = virtqueue_dma_dev(rq->vq);
> +	if (!dma_dev)
> +		return -EPERM;
> +
> +	hdr_dma = dma_map_single(dma_dev, &xsk_hdr, vi->hdr_len, DMA_TO_DEVICE);
> +	if (dma_mapping_error(dma_dev, hdr_dma))
> +		return -ENOMEM;
> +
> +	err = xsk_pool_dma_map(pool, dma_dev, 0);
> +	if (err)
> +		goto err_xsk_map;
> +
> +	err = virtnet_rq_bind_xsk_pool(vi, rq, pool);
> +	if (err)
> +		goto err_rq;
> +
> +	err = virtnet_sq_bind_xsk_pool(vi, sq, pool);
> +	if (err)
> +		goto err_sq;
> +
> +	/* Now, we do not support tx offset, so all the tx virtnet hdr is zero.
> +	 * So all the tx packets can share a single hdr.
> +	 */
> +	sq->xsk.hdr_dma_address = hdr_dma;
> +
> +	return 0;
> +
> +err_sq:
> +	virtnet_rq_bind_xsk_pool(vi, rq, NULL);
> +err_rq:
> +	xsk_pool_dma_unmap(pool, 0);
> +err_xsk_map:
> +	dma_unmap_single(dma_dev, hdr_dma, vi->hdr_len, DMA_TO_DEVICE);
> +	return err;
> +}
> +
> +static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
> +{
> +	struct virtnet_info *vi = netdev_priv(dev);
> +	struct xsk_buff_pool *pool;
> +	struct device *dma_dev;
> +	struct receive_queue *rq;
> +	struct send_queue *sq;
> +	int err1, err2;
> +
> +	if (qid >= vi->curr_queue_pairs)
> +		return -EINVAL;
> +
> +	sq = &vi->sq[qid];
> +	rq = &vi->rq[qid];
> +
> +	pool = sq->xsk.pool;
> +
> +	err1 = virtnet_sq_bind_xsk_pool(vi, sq, NULL);
> +	err2 = virtnet_rq_bind_xsk_pool(vi, rq, NULL);
> +
> +	xsk_pool_dma_unmap(pool, 0);
> +
> +	dma_dev = virtqueue_dma_dev(rq->vq);
> +
> +	dma_unmap_single(dma_dev, sq->xsk.hdr_dma_address, vi->hdr_len, DMA_TO_DEVICE);
> +
> +	return err1 | err2;
> +}
> +
> +static int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp)
> +{
> +	if (xdp->xsk.pool)
> +		return virtnet_xsk_pool_enable(dev, xdp->xsk.pool,
> +					       xdp->xsk.queue_id);
> +	else
> +		return virtnet_xsk_pool_disable(dev, xdp->xsk.queue_id);
> +}
> +
>  static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  			   struct netlink_ext_ack *extack)
>  {
> @@ -5293,6 +5490,8 @@ static int virtnet_xdp(struct net_device *dev, struct netdev_bpf *xdp)
>  	switch (xdp->command) {
>  	case XDP_SETUP_PROG:
>  		return virtnet_xdp_set(dev, xdp->prog, xdp->extack);
> +	case XDP_SETUP_XSK_POOL:
> +		return virtnet_xsk_pool_setup(dev, xdp);
>  	default:
>  		return -EINVAL;
>  	}
> -- 
> 2.32.0.3.g01195cf9f


