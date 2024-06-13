Return-Path: <bpf+bounces-32038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D6D90621C
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 04:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCE62830E1
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 02:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D414912BF3D;
	Thu, 13 Jun 2024 02:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="I8zDe9TI"
X-Original-To: bpf@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE67179AF;
	Thu, 13 Jun 2024 02:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718246868; cv=none; b=JYd/34IEP4jOef2JihQqUR3XdT52LqCAn97WGLoN/rQYpOl2tp73VsyWD/fr9XlQ+L/MjhdeSWq/khj81hnpfZUIe+frh48D52fHkvxG0bv6KW0tVCSskPtGF0E0UkZmljSND1EEU+1FIaGt0z3PJjqSUoaPJ95RHkNFLE5+cDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718246868; c=relaxed/simple;
	bh=Fk2QR47WNwL6i5eWlx0PEyZdMMMZqMVlXwK2LTiPINg=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=hsb5VcCEnGXieqgLlfjcjV8poLF1JIbBPQeN7F5gD+UGn0ssb5H6vUI68CfFZB6oI6YNS4EwzxlHdhjBlqBLFVBDejjSak/8+8YH4JFjcyB0hPa7dab7cZ1kLLw+vUFoHDU0l54StojUfzvSgyWBfMZAuj/rP2Cm2YDI2gm+uG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=I8zDe9TI; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718246863; h=Message-ID:Subject:Date:From:To;
	bh=9mBFyTfwYfcGHejtP0JgDSk+03X495VUp8Fzw+i5ulQ=;
	b=I8zDe9TIeJ4qxlUkSshFLlkSIDGnFuQp/Iak/19bmW3AFBO0ACLr16M/mxZ2yS7S27e3tuD1VrIrupdiQ3FSxT3oA6s6FVxRKOa5a8NJ21HjG9/1UIDNMUyuYjB4dAWjzU8OjWBZgtOZXbrTHs98ofDTN5tGwVZDFdekUOo27/c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W8MKEwK_1718246862;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8MKEwK_1718246862)
          by smtp.aliyun-inc.com;
          Thu, 13 Jun 2024 10:47:43 +0800
Message-ID: <1718246847.2253225-5-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v4 08/15] virtio_net: sq support premapped mode
Date: Thu, 13 Jun 2024 10:47:27 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
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
References: <20240611114147.31320-1-xuanzhuo@linux.alibaba.com>
 <20240611114147.31320-9-xuanzhuo@linux.alibaba.com>
 <20240612193142-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240612193142-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Wed, 12 Jun 2024 19:41:51 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Tue, Jun 11, 2024 at 07:41:40PM +0800, Xuan Zhuo wrote:
> > If the xsk is enabling, the xsk tx will share the send queue.
> > But the xsk requires that the send queue use the premapped mode.
> > So the send queue must support premapped mode when it is bound to
> > af-xdp.
> >
> > * virtnet_sq_set_premapped(sq, true) is used to enable premapped mode.
> >
> >     In this mode, the driver will record the dma info when skb or xdp
> >     frame is sent.
> >
> >     Currently, the SQ premapped mode is operational only with af-xdp. In
> >     this mode, af-xdp, the kernel stack, and xdp tx/redirect will share
> >     the same SQ. Af-xdp independently manages its DMA. The kernel stack
> >     and xdp tx/redirect utilize this DMA metadata to manage the DMA
> >     info.
> >
> >     If the indirect descriptor feature be supported, the volume of DMA
> >     details we need to maintain becomes quite substantial. Here, we have
> >     a cap on the amount of DMA info we manage.
> >
> >     If the kernel stack and xdp tx/redirect attempt to use more
> >     descriptors, virtnet_add_outbuf() will return an -ENOMEM error. But
> >     the af-xdp can work continually.
> >
> > * virtnet_sq_set_premapped(sq, false) is used to disable premapped mode.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 219 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 215 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index e84a4624549b..4968ab7eb5a4 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -25,6 +25,7 @@
> >  #include <net/net_failover.h>
> >  #include <net/netdev_rx_queue.h>
> >  #include <net/netdev_queues.h>
> > +#include <uapi/linux/virtio_ring.h>
> >
> >  static int napi_weight = NAPI_POLL_WEIGHT;
> >  module_param(napi_weight, int, 0444);
> > @@ -276,6 +277,25 @@ struct virtnet_rq_dma {
> >  	u16 need_sync;
> >  };
> >
> > +struct virtnet_sq_dma {
> > +	union {
> > +		struct virtnet_sq_dma *next;
>
> Maybe:
>
> struct llist_node node;
>
> I'd like to avoid growing our own single linked list
> implementation if at all possible.

I will fix all the comments in next version.

Thanks.


>
>
>
> > +		void *data;
> > +	};
> > +	dma_addr_t addr;
> > +	u32 len;
> > +	u8 num;
> > +};
> > +
> > +struct virtnet_sq_dma_info {
> > +	/* record for kfree */
> > +	void *p;
> > +
> > +	u32 free_num;
> > +
> > +	struct virtnet_sq_dma *free;
> > +};
> > +
> >  /* Internal representation of a send virtqueue */
> >  struct send_queue {
> >  	/* Virtqueue associated with this send _queue */
> > @@ -295,6 +315,11 @@ struct send_queue {
> >
> >  	/* Record whether sq is in reset state. */
> >  	bool reset;
> > +
> > +	/* SQ is premapped mode or not. */
> > +	bool premapped;
> > +
> > +	struct virtnet_sq_dma_info dmainfo;
> >  };
> >
> >  /* Internal representation of a receive virtqueue */
> > @@ -492,9 +517,11 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
> >  enum virtnet_xmit_type {
> >  	VIRTNET_XMIT_TYPE_SKB,
> >  	VIRTNET_XMIT_TYPE_XDP,
> > +	VIRTNET_XMIT_TYPE_DMA,
> >  };
> >
> > -#define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT_TYPE_XDP)
> > +#define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT_TYPE_XDP \
> > +				| VIRTNET_XMIT_TYPE_DMA)
> >
> >  static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)
> >  {
> > @@ -510,12 +537,178 @@ static void *virtnet_xmit_ptr_mix(void *ptr, enum virtnet_xmit_type type)
> >  	return (void *)((unsigned long)ptr | type);
> >  }
> >
> > +static void virtnet_sq_unmap(struct send_queue *sq, void **data)
> > +{
> > +	struct virtnet_sq_dma *head, *tail, *p;
> > +	int i;
> > +
> > +	head = *data;
> > +
> > +	p = head;
> > +
> > +	for (i = 0; i < head->num; ++i) {
> > +		virtqueue_dma_unmap_page_attrs(sq->vq, p->addr, p->len,
> > +					       DMA_TO_DEVICE, 0);
> > +		tail = p;
> > +		p = p->next;
> > +	}
> > +
> > +	*data = tail->data;
> > +
> > +	tail->next = sq->dmainfo.free;
> > +	sq->dmainfo.free = head;
> > +	sq->dmainfo.free_num += head->num;
> > +}
> > +
> > +static void *virtnet_dma_chain_update(struct send_queue *sq,
> > +				      struct virtnet_sq_dma *head,
> > +				      struct virtnet_sq_dma *tail,
> > +				      u8 num, void *data)
> > +{
> > +	sq->dmainfo.free = tail->next;
> > +	sq->dmainfo.free_num -= num;
> > +	head->num = num;
> > +
> > +	tail->data = data;
> > +
> > +	return virtnet_xmit_ptr_mix(head, VIRTNET_XMIT_TYPE_DMA);
> > +}
> > +
> > +static struct virtnet_sq_dma *virtnet_sq_map_sg(struct send_queue *sq, int num, void *data)
> > +{
> > +	struct virtnet_sq_dma *head, *tail, *p;
> > +	struct scatterlist *sg;
> > +	dma_addr_t addr;
> > +	int i, err;
> > +
> > +	if (num > sq->dmainfo.free_num)
> > +		return NULL;
> > +
> > +	head = sq->dmainfo.free;
> > +	p = head;
> > +
> > +	tail = NULL;
> > +
> > +	for (i = 0; i < num; ++i) {
> > +		sg = &sq->sg[i];
> > +
> > +		addr = virtqueue_dma_map_page_attrs(sq->vq, sg_page(sg),
> > +						    sg->offset,
> > +						    sg->length, DMA_TO_DEVICE,
> > +						    0);
> > +		err = virtqueue_dma_mapping_error(sq->vq, addr);
> > +		if (err)
> > +			goto err;
> > +
> > +		sg->dma_address = addr;
> > +
> > +		tail = p;
> > +		tail->addr = sg->dma_address;
> > +		tail->len = sg->length;
> > +
> > +		p = p->next;
> > +	}
> > +
> > +	return virtnet_dma_chain_update(sq, head, tail, num, data);
> > +
> > +err:
> > +	if (tail) {
> > +		virtnet_dma_chain_update(sq, head, tail, i, data);
> > +		virtnet_sq_unmap(sq, (void **)&head);
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> >  static int virtnet_add_outbuf(struct send_queue *sq, int num, void *data,
> >  			      enum virtnet_xmit_type type)
> >  {
> > -	return virtqueue_add_outbuf(sq->vq, sq->sg, num,
> > -				    virtnet_xmit_ptr_mix(data, type),
> > -				    GFP_ATOMIC);
> > +	int ret;
> > +
> > +	data = virtnet_xmit_ptr_mix(data, type);
> > +
> > +	if (sq->premapped) {
> > +		data = virtnet_sq_map_sg(sq, num, data);
> > +		if (!data)
> > +			return -ENOMEM;
> > +	}
> > +
> > +	ret = virtqueue_add_outbuf(sq->vq, sq->sg, num, data, GFP_ATOMIC);
> > +	if (ret && sq->premapped) {
> > +		virtnet_xmit_ptr_strip(&data);
> > +		virtnet_sq_unmap(sq, &data);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int virtnet_sq_alloc_dma_meta(struct send_queue *sq)
> > +{
> > +	struct virtnet_sq_dma *d;
> > +	int num, i;
> > +
> > +	num = virtqueue_get_vring_size(sq->vq);
> > +
> > +	/* Currently, the SQ premapped mode is operational only with af-xdp. In
> > +	 * this mode, af-xdp, the kernel stack, and xdp tx/redirect will share
> > +	 * the same SQ. Af-xdp independently manages its DMA. The kernel stack
> > +	 * and xdp tx/redirect utilize this DMA metadata to manage the DMA info.
> > +	 *
> > +	 * If the indirect descriptor feature be supported, the volume of DMA
> > +	 * details we need to maintain becomes quite substantial. Here, we have
> > +	 * a cap on the amount of DMA info we manage, effectively limiting it to
> > +	 * twice the size of the ring buffer.
> > +	 *
> > +	 * If the kernel stack and xdp tx/redirect attempt to use more
> > +	 * descriptors than allowed by this double ring buffer size,
> > +	 * virtnet_add_outbuf() will return an -ENOMEM error. But the af-xdp can
> > +	 * work continually.
> > +	 */
> > +	if (virtio_has_feature(sq->vq->vdev, VIRTIO_RING_F_INDIRECT_DESC))
> > +		num = num * 2;
> > +
> > +	sq->dmainfo.free = kcalloc(num, sizeof(*sq->dmainfo.free), GFP_KERNEL);
>
> Can be large. kvmalloc seems more appropriate.
>
>
> > +	if (!sq->dmainfo.free)
> > +		return -ENOMEM;
> > +
> > +	sq->dmainfo.p = sq->dmainfo.free;
> > +	sq->dmainfo.free_num = num;
> > +
> > +	for (i = 0; i < num; ++i) {
> > +		d = &sq->dmainfo.free[i];
> > +		d->next = d + 1;
> > +	}
> > +
> > +	d->next = NULL;
> > +
> > +	return 0;
> > +}
> > +
> > +static void virtnet_sq_free_dma_meta(struct send_queue *sq)
> > +{
> > +	kfree(sq->dmainfo.p);
> > +
> > +	sq->dmainfo.p = NULL;
> > +	sq->dmainfo.free = NULL;
> > +	sq->dmainfo.free_num = 0;
> > +}
> > +
> > +/* This function must be called immediately after creating the vq, or after vq
> > + * reset, and before adding any buffers to it.
> > + */
> > +static int virtnet_sq_set_premapped(struct send_queue *sq, bool premapped)
> > +{
> > +	if (premapped) {
> > +		if (virtnet_sq_alloc_dma_meta(sq))
> > +			return -ENOMEM;
>
> I would just return what virtnet_sq_alloc_dma_meta returns.
> 	int r = virtnet_sq_alloc_dma_meta();
>
> 	if (r)
> 		return r;
>
> > +	} else {
> > +		virtnet_sq_free_dma_meta(sq);
> > +	}
> > +
> > +	BUG_ON(virtqueue_set_dma_premapped(sq->vq, premapped));
> > +
> > +	sq->premapped = premapped;
> > +	return 0;
> >  }
> >
> >  static void __free_old_xmit(struct send_queue *sq, bool in_napi,
> > @@ -529,6 +722,7 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
> >  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
> >  		++stats->packets;
> >
> > +retry:
> >  		switch (virtnet_xmit_ptr_strip(&ptr)) {
> >  		case VIRTNET_XMIT_TYPE_SKB:
> >  			skb = ptr;
> > @@ -545,6 +739,10 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
> >  			stats->bytes += xdp_get_frame_len(frame);
> >  			xdp_return_frame(frame);
> >  			break;
> > +
> > +		case VIRTNET_XMIT_TYPE_DMA:
> > +			virtnet_sq_unmap(sq, &ptr);
> > +			goto retry;
> >  		}
> >  	}
> >  }
> > @@ -5232,6 +5430,8 @@ static void virtnet_free_queues(struct virtnet_info *vi)
> >  	for (i = 0; i < vi->max_queue_pairs; i++) {
> >  		__netif_napi_del(&vi->rq[i].napi);
> >  		__netif_napi_del(&vi->sq[i].napi);
> > +
> > +		virtnet_sq_free_dma_meta(&vi->sq[i]);
> >  	}
> >
> >  	/* We called __netif_napi_del(),
> > @@ -5280,6 +5480,13 @@ static void free_receive_page_frags(struct virtnet_info *vi)
> >
> >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
> >  {
> > +	struct virtnet_info *vi = vq->vdev->priv;
> > +	struct send_queue *sq;
> > +	int i = vq2rxq(vq);
> > +
> > +	sq = &vi->sq[i];
> > +
> > +retry:
> >  	switch (virtnet_xmit_ptr_strip(&buf)) {
> >  	case VIRTNET_XMIT_TYPE_SKB:
> >  		dev_kfree_skb(buf);
> > @@ -5288,6 +5495,10 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
> >  	case VIRTNET_XMIT_TYPE_XDP:
> >  		xdp_return_frame(buf);
> >  		break;
> > +
> > +	case VIRTNET_XMIT_TYPE_DMA:
> > +		virtnet_sq_unmap(sq, &buf);
> > +		goto retry;
>
> document what's going on here? why are we retrying?
>
>
> >  	}
> >  }
> >
> > --
> > 2.32.0.3.g01195cf9f
>

