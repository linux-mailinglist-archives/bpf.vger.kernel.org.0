Return-Path: <bpf+bounces-14691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550E27E77DA
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 04:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5201B210DE
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 03:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C3415BB;
	Fri, 10 Nov 2023 03:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70ECA4E;
	Fri, 10 Nov 2023 03:04:44 +0000 (UTC)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651824496;
	Thu,  9 Nov 2023 19:04:43 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vw2yIua_1699585477;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vw2yIua_1699585477)
          by smtp.aliyun-inc.com;
          Fri, 10 Nov 2023 11:04:38 +0800
Message-ID: <1699585459.226797-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 16/21] virtio_net: xsk: rx: introduce add_recvbuf_xsk()
Date: Fri, 10 Nov 2023 11:04:19 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux-foundation.org,
 bpf@vger.kernel.org
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
 <20231107031227.100015-17-xuanzhuo@linux.alibaba.com>
 <20231109031003-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231109031003-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Thu, 9 Nov 2023 03:12:27 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Tue, Nov 07, 2023 at 11:12:22AM +0800, Xuan Zhuo wrote:
> > Implement the logic of filling rq with XSK buffers.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio/main.c       |  4 ++-
> >  drivers/net/virtio/virtio_net.h |  5 ++++
> >  drivers/net/virtio/xsk.c        | 49 ++++++++++++++++++++++++++++++++-
> >  drivers/net/virtio/xsk.h        |  2 ++
> >  4 files changed, 58 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > index 6210a6e37396..15943a22e17d 100644
> > --- a/drivers/net/virtio/main.c
> > +++ b/drivers/net/virtio/main.c
> > @@ -1798,7 +1798,9 @@ static bool try_fill_recv(struct virtnet_info *vi, struct virtnet_rq *rq,
> >  	bool oom;
> >
> >  	do {
> > -		if (vi->mergeable_rx_bufs)
> > +		if (rq->xsk.pool)
> > +			err = virtnet_add_recvbuf_xsk(vi, rq, rq->xsk.pool, gfp);
> > +		else if (vi->mergeable_rx_bufs)
> >  			err = add_recvbuf_mergeable(vi, rq, gfp);
> >  		else if (vi->big_packets)
> >  			err = add_recvbuf_big(vi, rq, gfp);
>
> I'm not sure I understand. How does this handle mergeable flag still being set?


# xsk with merge

## fill ring

We fill the ring with the buffers from the xdp socket just like we alloc buffer
from the kernel.

## receive buffer

Now the xsk supported the multi-buffer recently. But I want to support that after
this packet set. So if the packet uses more buffers, I drop that.

If the xdp is not bound or the xdp prog does not redirect the packet to xsk socket.
all buffers are used to make skbs, whatever the packet uses one buffer or more.
But the buffers is from the xsk socket. So we must allocat new pages and copy
the data to the new pages. And free the buffers of xsk socket.


Thanks.


>
>
> > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
> > index a13d6d301fdb..1242785e311e 100644
> > --- a/drivers/net/virtio/virtio_net.h
> > +++ b/drivers/net/virtio/virtio_net.h
> > @@ -140,6 +140,11 @@ struct virtnet_rq {
> >
> >  		/* xdp rxq used by xsk */
> >  		struct xdp_rxq_info xdp_rxq;
> > +
> > +		struct xdp_buff **xsk_buffs;
> > +		u32 nxt_idx;
> > +		u32 num;
> > +		u32 size;
> >  	} xsk;
> >  };
> >
> > diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> > index ea5804ddd44e..e737c3353212 100644
> > --- a/drivers/net/virtio/xsk.c
> > +++ b/drivers/net/virtio/xsk.c
> > @@ -38,6 +38,41 @@ static void virtnet_xsk_check_queue(struct virtnet_sq *sq)
> >  		netif_stop_subqueue(dev, qnum);
> >  }
> >
> > +int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct virtnet_rq *rq,
> > +			    struct xsk_buff_pool *pool, gfp_t gfp)
> > +{
> > +	struct xdp_buff **xsk_buffs;
> > +	dma_addr_t addr;
> > +	u32 len, i;
> > +	int err = 0;
> > +
> > +	xsk_buffs = rq->xsk.xsk_buffs;
> > +
> > +	if (rq->xsk.nxt_idx >= rq->xsk.num) {
> > +		rq->xsk.num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->xsk.size);
> > +		if (!rq->xsk.num)
> > +			return -ENOMEM;
> > +		rq->xsk.nxt_idx = 0;
> > +	}
>
> Another manually rolled linked list implementation.
> Please, don't.
>
>
> > +
> > +	i = rq->xsk.nxt_idx;
> > +
> > +	/* use the part of XDP_PACKET_HEADROOM as the virtnet hdr space */
> > +	addr = xsk_buff_xdp_get_dma(xsk_buffs[i]) - vi->hdr_len;
> > +	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
> > +
> > +	sg_init_table(rq->sg, 1);
> > +	sg_fill_dma(rq->sg, addr, len);
> > +
> > +	err = virtqueue_add_inbuf(rq->vq, rq->sg, 1, xsk_buffs[i], gfp);
> > +	if (err)
> > +		return err;
> > +
> > +	rq->xsk.nxt_idx++;
> > +
> > +	return 0;
> > +}
> > +
> >  static int virtnet_xsk_xmit_one(struct virtnet_sq *sq,
> >  				struct xsk_buff_pool *pool,
> >  				struct xdp_desc *desc)
> > @@ -213,7 +248,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
> >  	struct virtnet_sq *sq;
> >  	struct device *dma_dev;
> >  	dma_addr_t hdr_dma;
> > -	int err;
> > +	int err, size;
> >
> >  	/* In big_packets mode, xdp cannot work, so there is no need to
> >  	 * initialize xsk of rq.
> > @@ -249,6 +284,16 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
> >  	if (!dma_dev)
> >  		return -EPERM;
> >
> > +	size = virtqueue_get_vring_size(rq->vq);
> > +
> > +	rq->xsk.xsk_buffs = kcalloc(size, sizeof(*rq->xsk.xsk_buffs), GFP_KERNEL);
> > +	if (!rq->xsk.xsk_buffs)
> > +		return -ENOMEM;
> > +
> > +	rq->xsk.size = size;
> > +	rq->xsk.nxt_idx = 0;
> > +	rq->xsk.num = 0;
> > +
> >  	hdr_dma = dma_map_single(dma_dev, &xsk_hdr, vi->hdr_len, DMA_TO_DEVICE);
> >  	if (dma_mapping_error(dma_dev, hdr_dma))
> >  		return -ENOMEM;
> > @@ -307,6 +352,8 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
> >
> >  	dma_unmap_single(dma_dev, sq->xsk.hdr_dma_address, vi->hdr_len, DMA_TO_DEVICE);
> >
> > +	kfree(rq->xsk.xsk_buffs);
> > +
> >  	return err1 | err2;
> >  }
> >
> > diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
> > index 7ebc9bda7aee..bef41a3f954e 100644
> > --- a/drivers/net/virtio/xsk.h
> > +++ b/drivers/net/virtio/xsk.h
> > @@ -23,4 +23,6 @@ int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp);
> >  bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
> >  		      int budget);
> >  int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag);
> > +int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct virtnet_rq *rq,
> > +			    struct xsk_buff_pool *pool, gfp_t gfp);
> >  #endif
> > --
> > 2.32.0.3.g01195cf9f
>
>

