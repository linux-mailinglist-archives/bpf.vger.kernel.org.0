Return-Path: <bpf+bounces-14675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1257E76C3
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 02:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D927B20FF8
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 01:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26775EC5;
	Fri, 10 Nov 2023 01:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E65A47;
	Fri, 10 Nov 2023 01:44:55 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDE344A4;
	Thu,  9 Nov 2023 17:44:53 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vw2ST8O_1699580689;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vw2ST8O_1699580689)
          by smtp.aliyun-inc.com;
          Fri, 10 Nov 2023 09:44:50 +0800
Message-ID: <1699580672.387567-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 14/21] virtio_net: xsk: tx: virtnet_free_old_xmit() distinguishes xsk buffer
Date: Fri, 10 Nov 2023 09:44:32 +0800
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
 <20231107031227.100015-15-xuanzhuo@linux.alibaba.com>
 <20231109061056-mutt-send-email-mst@kernel.org>
 <1699528568.0674586-6-xuanzhuo@linux.alibaba.com>
 <20231109065912-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231109065912-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Thu, 9 Nov 2023 06:59:48 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Nov 09, 2023 at 07:16:08PM +0800, Xuan Zhuo wrote:
> > On Thu, 9 Nov 2023 06:11:49 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Tue, Nov 07, 2023 at 11:12:20AM +0800, Xuan Zhuo wrote:
> > > > virtnet_free_old_xmit distinguishes three type ptr(skb, xdp frame, xsk
> > > > buffer) by the last bits of the pointer.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  drivers/net/virtio/virtio_net.h | 18 ++++++++++++++++--
> > > >  drivers/net/virtio/xsk.h        |  5 +++++
> > > >  2 files changed, 21 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
> > > > index a431a2c1ee47..a13d6d301fdb 100644
> > > > --- a/drivers/net/virtio/virtio_net.h
> > > > +++ b/drivers/net/virtio/virtio_net.h
> > > > @@ -225,6 +225,11 @@ struct virtnet_info {
> > > >  	struct failover *failover;
> > > >  };
> > > >
> > > > +static inline bool virtnet_is_skb_ptr(void *ptr)
> > > > +{
> > > > +	return !((unsigned long)ptr & VIRTIO_XMIT_DATA_MASK);
> > > > +}
> > > > +
> > > >  static inline bool virtnet_is_xdp_frame(void *ptr)
> > > >  {
> > > >  	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
> > > > @@ -235,6 +240,8 @@ static inline struct xdp_frame *virtnet_ptr_to_xdp(void *ptr)
> > > >  	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
> > > >  }
> > > >
> > > > +static inline u32 virtnet_ptr_to_xsk(void *ptr);
> > > > +
> > >
> > > I don't understand why you need this here.
> >
> > The below function virtnet_free_old_xmit needs this.
> >
> > Thanks.
>
> I don't understand why is virtnet_free_old_xmit inline, either.

That is in the header file.


>
> > >
> > >
> > > >  static inline void *virtnet_sq_unmap(struct virtnet_sq *sq, void *data)
> > > >  {
> > > >  	struct virtnet_sq_dma *next, *head;
> > > > @@ -261,11 +268,12 @@ static inline void *virtnet_sq_unmap(struct virtnet_sq *sq, void *data)
> > > >  static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
> > > >  					 u64 *bytes, u64 *packets)
> > > >  {
> > > > +	unsigned int xsknum = 0;
> > > >  	unsigned int len;
> > > >  	void *ptr;
> > > >
> > > >  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
> > > > -		if (!virtnet_is_xdp_frame(ptr)) {
> > > > +		if (virtnet_is_skb_ptr(ptr)) {
> > > >  			struct sk_buff *skb;
> > > >
> > > >  			if (sq->do_dma)
> > > > @@ -277,7 +285,7 @@ static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
> > > >
> > > >  			*bytes += skb->len;
> > > >  			napi_consume_skb(skb, in_napi);
> > > > -		} else {
> > > > +		} else if (virtnet_is_xdp_frame(ptr)) {
> > > >  			struct xdp_frame *frame;
> > > >
> > > >  			if (sq->do_dma)
> > > > @@ -287,9 +295,15 @@ static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
> > > >
> > > >  			*bytes += xdp_get_frame_len(frame);
> > > >  			xdp_return_frame(frame);
> > > > +		} else {
> > > > +			*bytes += virtnet_ptr_to_xsk(ptr);
> > > > +			++xsknum;
> > > >  		}
> > > >  		(*packets)++;
> > > >  	}
> > > > +
> > > > +	if (xsknum)
> > > > +		xsk_tx_completed(sq->xsk.pool, xsknum);
> > > >  }
> > > >
> > > >  static inline bool virtnet_is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
> > > > diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
> > > > index 1bd19dcda649..7ebc9bda7aee 100644
> > > > --- a/drivers/net/virtio/xsk.h
> > > > +++ b/drivers/net/virtio/xsk.h
> > > > @@ -14,6 +14,11 @@ static inline void *virtnet_xsk_to_ptr(u32 len)
> > > >  	return (void *)(p | VIRTIO_XSK_FLAG);
> > > >  }
> > > >
> > > > +static inline u32 virtnet_ptr_to_xsk(void *ptr)
> > > > +{
> > > > +	return ((unsigned long)ptr) >> VIRTIO_XSK_FLAG_OFFSET;
> > > > +}
> > > > +
> > > >  int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp);
> > > >  bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
> > > >  		      int budget);
> > > > --
> > > > 2.32.0.3.g01195cf9f
> > >
> > >
>

