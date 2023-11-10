Return-Path: <bpf+bounces-14719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59E27E78FF
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 07:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B7E1C20E2F
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 06:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEBE5236;
	Fri, 10 Nov 2023 06:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008064C93;
	Fri, 10 Nov 2023 06:11:59 +0000 (UTC)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751A146B0;
	Thu,  9 Nov 2023 22:11:53 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vw3KG7D_1699595683;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vw3KG7D_1699595683)
          by smtp.aliyun-inc.com;
          Fri, 10 Nov 2023 13:54:43 +0800
Message-ID: <1699595508.3049185-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 17/21] virtio_net: xsk: rx: skip dma unmap when rq is bind with AF_XDP
Date: Fri, 10 Nov 2023 13:51:48 +0800
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
 <20231107031227.100015-18-xuanzhuo@linux.alibaba.com>
 <20231109031347-mutt-send-email-mst@kernel.org>
 <1699528202.3090942-4-xuanzhuo@linux.alibaba.com>
 <20231109070015-mutt-send-email-mst@kernel.org>
 <1699580836.3647869-2-xuanzhuo@linux.alibaba.com>
 <20231110003305-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231110003305-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Fri, 10 Nov 2023 00:33:27 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Fri, Nov 10, 2023 at 09:47:16AM +0800, Xuan Zhuo wrote:
> > On Thu, 9 Nov 2023 07:00:51 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Thu, Nov 09, 2023 at 07:10:02PM +0800, Xuan Zhuo wrote:
> > > > On Thu, 9 Nov 2023 03:15:03 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > On Tue, Nov 07, 2023 at 11:12:23AM +0800, Xuan Zhuo wrote:
> > > > > > When rq is bound with AF_XDP, the buffer dma is managed
> > > > > > by the AF_XDP APIs. So the buffer got from the virtio core should
> > > > > > skip the dma unmap operation.
> > > > > >
> > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > >
> > > > >
> > > > > I don't get it - is this like a bugfix?
> > > >
> > > > I want focus on this. So let it as an independent commit.
> > > >
> > > > > And why do we need our own flag and checks?
> > > > > Doesn't virtio core DTRT?
> > > >
> > > >
> > > > struct vring_virtqueue {
> > > > 	[....]
> > > >
> > > > 	/* Do DMA mapping by driver */
> > > > 	bool premapped;
> > > >
> > > > We can not.
> > > >
> > > > So I add own flag.
> > > >
> > > > Thanks.
> > >
> > > Still don't get it. Why not check the premapped flag?
> >
> > premapped is in the struct vring_virtqueue.
> >
> > We can not access it from the driver.
>
>
> If it's useful, move it.


We set that by API.

If we expose that to the driver. I worry some driver change it directly.
So I think it's better for the driver to add an own flag.

Thanks.


>
>
> >
> > >
> > > >
> > > > >
> > > > > > ---
> > > > > >  drivers/net/virtio/main.c       | 8 +++++---
> > > > > >  drivers/net/virtio/virtio_net.h | 3 +++
> > > > > >  drivers/net/virtio/xsk.c        | 1 +
> > > > > >  3 files changed, 9 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > > > > > index 15943a22e17d..a318b2533b94 100644
> > > > > > --- a/drivers/net/virtio/main.c
> > > > > > +++ b/drivers/net/virtio/main.c
> > > > > > @@ -430,7 +430,7 @@ static void *virtnet_rq_get_buf(struct virtnet_rq *rq, u32 *len, void **ctx)
> > > > > >  	void *buf;
> > > > > >
> > > > > >  	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > > > > > -	if (buf && rq->do_dma)
> > > > > > +	if (buf && rq->do_dma_unmap)
> > > > > >  		virtnet_rq_unmap(rq, buf, *len);
> > > > > >
> > > > > >  	return buf;
> > > > > > @@ -561,8 +561,10 @@ static void virtnet_set_premapped(struct virtnet_info *vi)
> > > > > >
> > > > > >  		/* disable for big mode */
> > > > > >  		if (vi->mergeable_rx_bufs || !vi->big_packets) {
> > > > > > -			if (!virtqueue_set_dma_premapped(vi->rq[i].vq))
> > > > > > +			if (!virtqueue_set_dma_premapped(vi->rq[i].vq)) {
> > > > > >  				vi->rq[i].do_dma = true;
> > > > > > +				vi->rq[i].do_dma_unmap = true;
> > > > > > +			}
> > > > > >  		}
> > > > > >  	}
> > > > > >  }
> > > > > > @@ -3944,7 +3946,7 @@ void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
> > > > > >
> > > > > >  	rq = &vi->rq[i];
> > > > > >
> > > > > > -	if (rq->do_dma)
> > > > > > +	if (rq->do_dma_unmap)
> > > > > >  		virtnet_rq_unmap(rq, buf, 0);
> > > > > >
> > > > > >  	virtnet_rq_free_buf(vi, rq, buf);
> > > > > > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
> > > > > > index 1242785e311e..2005d0cd22e2 100644
> > > > > > --- a/drivers/net/virtio/virtio_net.h
> > > > > > +++ b/drivers/net/virtio/virtio_net.h
> > > > > > @@ -135,6 +135,9 @@ struct virtnet_rq {
> > > > > >  	/* Do dma by self */
> > > > > >  	bool do_dma;
> > > > > >
> > > > > > +	/* Do dma unmap after getting buf from virtio core. */
> > > > > > +	bool do_dma_unmap;
> > > > > > +
> > > > > >  	struct {
> > > > > >  		struct xsk_buff_pool *pool;
> > > > > >
> > > > > > diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> > > > > > index e737c3353212..b09c473c29fb 100644
> > > > > > --- a/drivers/net/virtio/xsk.c
> > > > > > +++ b/drivers/net/virtio/xsk.c
> > > > > > @@ -210,6 +210,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct virtnet_rq *
> > > > > >  		xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> > > > > >
> > > > > >  	rq->xsk.pool = pool;
> > > > > > +	rq->do_dma_unmap = !pool;
> > > > > >
> > > > > >  	virtnet_rx_resume(vi, rq);
> > > > > >
> > > > > > --
> > > > > > 2.32.0.3.g01195cf9f
> > > > >
> > > > >
> > >
> > >
>
>

