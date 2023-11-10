Return-Path: <bpf+bounces-14721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64877E7902
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 07:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6DF81C20DC1
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 06:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDEF4C8E;
	Fri, 10 Nov 2023 06:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/adb+0c"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0465236
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 06:13:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EC24C1A
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 22:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699596781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KA0v3OBMTeHRtp+JBUoL+seQE2z12N8pOIFQ7+xs9p8=;
	b=E/adb+0caTfjzy166o8xGw2lMbHTk9ZMrOEDp4O5bdGTQ1i3YzzjO6iH6OH0Ul7oJxIZdf
	p9MkqxHeURq31H8mSQl9/GEIqLPxBok0I2qCX13z/3Aicbt1EoUJ1/ppYmsLU9itlGZQGj
	6kNXPsanIpqtSELCyDFgkbegEE4G2/o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-GivTQHpDME6Apt8xH1v9uw-1; Fri, 10 Nov 2023 00:33:54 -0500
X-MC-Unique: GivTQHpDME6Apt8xH1v9uw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9ddae43f3f7so126859766b.3
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 21:33:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699594413; x=1700199213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KA0v3OBMTeHRtp+JBUoL+seQE2z12N8pOIFQ7+xs9p8=;
        b=tyuddR43vlKQHGbO+hxdkuzDr/mJuxBqgTDxkLZVDgD1q7tCOeNZKKjFhsqA0LgmpB
         XmXI+AzMG+Bp20t2h7DwcLtps/Bbz5h7iGGND2j5nb+H+yH5i2Ufjy4DZkUSmtdJQ7OH
         aIt3aT1YQ3V5U/5IY3qldSTuflmO5Cy85hGiNFvT+ArIq6+fYrw4jZvYduqrTegRvYMP
         eC27njD7ufFhltsgOCq74klJPlucwMF3MblPtx8oJIRy3DhUqmcFo8gNngXohasgCJc8
         zLipH0Y2TiSZpWzu6615fNCxw3fooe6IziM5e1y4XPiJ9c2p/gRy2SoV5OnxaK6Remjw
         BOjw==
X-Gm-Message-State: AOJu0YybLMgdxGw2ASl0AoHT2OgnikmK2DW+dpUdANGNzDeSQ9Tjc7Mo
	w6PdHVXzwCZpo/9dlKsBvCudP+uGvVJ4Nt5qxNBAq8taJcU1BBJzaPwWsCcMR3legFOc1drQPyQ
	fzKBI13nMg6gh
X-Received: by 2002:a17:907:26c4:b0:9d2:20ee:b18b with SMTP id bp4-20020a17090726c400b009d220eeb18bmr5823227ejc.42.1699594413700;
        Thu, 09 Nov 2023 21:33:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBbBn5im1hOWZJw1AgpLiSs3sWtFi9jJ5Mxh5qC987b7swzUCnrRO1vlcquRH3RcU71Up0TQ==
X-Received: by 2002:a17:907:26c4:b0:9d2:20ee:b18b with SMTP id bp4-20020a17090726c400b009d220eeb18bmr5823208ejc.42.1699594413357;
        Thu, 09 Nov 2023 21:33:33 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f4:2044:be5a:328c:4b98:1420])
        by smtp.gmail.com with ESMTPSA id y27-20020a170906071b00b009b285351817sm3385639ejb.116.2023.11.09.21.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 21:33:32 -0800 (PST)
Date: Fri, 10 Nov 2023 00:33:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 17/21] virtio_net: xsk: rx: skip dma unmap
 when rq is bind with AF_XDP
Message-ID: <20231110003305-mutt-send-email-mst@kernel.org>
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
 <20231107031227.100015-18-xuanzhuo@linux.alibaba.com>
 <20231109031347-mutt-send-email-mst@kernel.org>
 <1699528202.3090942-4-xuanzhuo@linux.alibaba.com>
 <20231109070015-mutt-send-email-mst@kernel.org>
 <1699580836.3647869-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1699580836.3647869-2-xuanzhuo@linux.alibaba.com>

On Fri, Nov 10, 2023 at 09:47:16AM +0800, Xuan Zhuo wrote:
> On Thu, 9 Nov 2023 07:00:51 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Nov 09, 2023 at 07:10:02PM +0800, Xuan Zhuo wrote:
> > > On Thu, 9 Nov 2023 03:15:03 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Tue, Nov 07, 2023 at 11:12:23AM +0800, Xuan Zhuo wrote:
> > > > > When rq is bound with AF_XDP, the buffer dma is managed
> > > > > by the AF_XDP APIs. So the buffer got from the virtio core should
> > > > > skip the dma unmap operation.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > >
> > > >
> > > > I don't get it - is this like a bugfix?
> > >
> > > I want focus on this. So let it as an independent commit.
> > >
> > > > And why do we need our own flag and checks?
> > > > Doesn't virtio core DTRT?
> > >
> > >
> > > struct vring_virtqueue {
> > > 	[....]
> > >
> > > 	/* Do DMA mapping by driver */
> > > 	bool premapped;
> > >
> > > We can not.
> > >
> > > So I add own flag.
> > >
> > > Thanks.
> >
> > Still don't get it. Why not check the premapped flag?
> 
> premapped is in the struct vring_virtqueue.
> 
> We can not access it from the driver.


If it's useful, move it.


> 
> >
> > >
> > > >
> > > > > ---
> > > > >  drivers/net/virtio/main.c       | 8 +++++---
> > > > >  drivers/net/virtio/virtio_net.h | 3 +++
> > > > >  drivers/net/virtio/xsk.c        | 1 +
> > > > >  3 files changed, 9 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > > > > index 15943a22e17d..a318b2533b94 100644
> > > > > --- a/drivers/net/virtio/main.c
> > > > > +++ b/drivers/net/virtio/main.c
> > > > > @@ -430,7 +430,7 @@ static void *virtnet_rq_get_buf(struct virtnet_rq *rq, u32 *len, void **ctx)
> > > > >  	void *buf;
> > > > >
> > > > >  	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > > > > -	if (buf && rq->do_dma)
> > > > > +	if (buf && rq->do_dma_unmap)
> > > > >  		virtnet_rq_unmap(rq, buf, *len);
> > > > >
> > > > >  	return buf;
> > > > > @@ -561,8 +561,10 @@ static void virtnet_set_premapped(struct virtnet_info *vi)
> > > > >
> > > > >  		/* disable for big mode */
> > > > >  		if (vi->mergeable_rx_bufs || !vi->big_packets) {
> > > > > -			if (!virtqueue_set_dma_premapped(vi->rq[i].vq))
> > > > > +			if (!virtqueue_set_dma_premapped(vi->rq[i].vq)) {
> > > > >  				vi->rq[i].do_dma = true;
> > > > > +				vi->rq[i].do_dma_unmap = true;
> > > > > +			}
> > > > >  		}
> > > > >  	}
> > > > >  }
> > > > > @@ -3944,7 +3946,7 @@ void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
> > > > >
> > > > >  	rq = &vi->rq[i];
> > > > >
> > > > > -	if (rq->do_dma)
> > > > > +	if (rq->do_dma_unmap)
> > > > >  		virtnet_rq_unmap(rq, buf, 0);
> > > > >
> > > > >  	virtnet_rq_free_buf(vi, rq, buf);
> > > > > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
> > > > > index 1242785e311e..2005d0cd22e2 100644
> > > > > --- a/drivers/net/virtio/virtio_net.h
> > > > > +++ b/drivers/net/virtio/virtio_net.h
> > > > > @@ -135,6 +135,9 @@ struct virtnet_rq {
> > > > >  	/* Do dma by self */
> > > > >  	bool do_dma;
> > > > >
> > > > > +	/* Do dma unmap after getting buf from virtio core. */
> > > > > +	bool do_dma_unmap;
> > > > > +
> > > > >  	struct {
> > > > >  		struct xsk_buff_pool *pool;
> > > > >
> > > > > diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> > > > > index e737c3353212..b09c473c29fb 100644
> > > > > --- a/drivers/net/virtio/xsk.c
> > > > > +++ b/drivers/net/virtio/xsk.c
> > > > > @@ -210,6 +210,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct virtnet_rq *
> > > > >  		xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> > > > >
> > > > >  	rq->xsk.pool = pool;
> > > > > +	rq->do_dma_unmap = !pool;
> > > > >
> > > > >  	virtnet_rx_resume(vi, rq);
> > > > >
> > > > > --
> > > > > 2.32.0.3.g01195cf9f
> > > >
> > > >
> >
> >


