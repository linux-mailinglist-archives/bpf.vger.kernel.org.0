Return-Path: <bpf+bounces-14586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 945AF7E6A34
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 13:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485C52811DA
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 12:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DD81DA20;
	Thu,  9 Nov 2023 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNX5qZp4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD791CAA4
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 12:01:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB8A258A
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 04:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699531258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6eDiBFLAnCrKz/HLR+x0JbeNr1epw8uPCaTepk4XHCs=;
	b=DNX5qZp46/L/dMKjFewutad11Q5iQRgQL2GwxLlJKkC/muSKLZqLbtQYdBogYivnleG5Mz
	TTwDh4TL2aJvkQqlDjbmF2Q40UXKc/5Ab4/LRdfG8W9+i68X0UbYB6r9iPuqKBom1UGUJL
	vdg0EzxujQ237I91I0a6rm62vuB/CVE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-c3c1L_StM2WtV8dzHt_qjA-1; Thu, 09 Nov 2023 07:00:57 -0500
X-MC-Unique: c3c1L_StM2WtV8dzHt_qjA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9dd89e2ce17so66261266b.0
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 04:00:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699531256; x=1700136056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6eDiBFLAnCrKz/HLR+x0JbeNr1epw8uPCaTepk4XHCs=;
        b=cJlesmQLkoAZq3A3/G31kRppumvwLuRzeMvMQu9JdpLuCXXN+jmDz94LCIcnUZybT2
         GSDeaDBMmT9Ecd++92ih/Lw884L6ZkLaBSe2OrZ+V8he8teZFv+cVJPVa7HUC1SOkEtI
         Qyn3dE5SHeiPXYoRb/QO3Ts0tNvLrSvoKqG9kW2pKql3XbGC+HzyzMkW6r42mTaXpCXn
         ytsoRGfDxwHIlPCvV5y9cf2bX6/t5GpUBUa9ove48op+Uxm3oOI0yW7/+ta27kI4zYGK
         3Pe5KThcZCpwZmZdf3GAeyYHE/Gj+eWGZR/wRS4LfSO1V5+CNM0YarLL7Fmb6fjjHNHe
         gl/A==
X-Gm-Message-State: AOJu0YwiYP4U6lmNOD7/Xc0U0wU7s0PpYAWaSDgiJWagXcfBd3ABnqUa
	fuvSTPWL3TrzqdRr7C44C9sDNCLxUWkWQ2b4SceKVSTlkOxzN4xZ1fuzI7i07sXdFL+P6a7v/23
	svFSpAkSqNMxu
X-Received: by 2002:a17:906:c10c:b0:9da:ede1:12b0 with SMTP id do12-20020a170906c10c00b009daede112b0mr4147310ejc.19.1699531256086;
        Thu, 09 Nov 2023 04:00:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiSGqYF9oN/EASaOZpvyHTXGo5qMc9peSAyaQSqNz6dFHoiBc0UQOM8QPa5WXgzBjhS7oiYg==
X-Received: by 2002:a17:906:c10c:b0:9da:ede1:12b0 with SMTP id do12-20020a170906c10c00b009daede112b0mr4147283ejc.19.1699531255774;
        Thu, 09 Nov 2023 04:00:55 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f4:2044:be5a:328c:4b98:1420])
        by smtp.gmail.com with ESMTPSA id n22-20020a170906841600b009b27d4153c0sm2456322ejx.178.2023.11.09.04.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 04:00:55 -0800 (PST)
Date: Thu, 9 Nov 2023 07:00:51 -0500
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
Message-ID: <20231109070015-mutt-send-email-mst@kernel.org>
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
 <20231107031227.100015-18-xuanzhuo@linux.alibaba.com>
 <20231109031347-mutt-send-email-mst@kernel.org>
 <1699528202.3090942-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1699528202.3090942-4-xuanzhuo@linux.alibaba.com>

On Thu, Nov 09, 2023 at 07:10:02PM +0800, Xuan Zhuo wrote:
> On Thu, 9 Nov 2023 03:15:03 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Tue, Nov 07, 2023 at 11:12:23AM +0800, Xuan Zhuo wrote:
> > > When rq is bound with AF_XDP, the buffer dma is managed
> > > by the AF_XDP APIs. So the buffer got from the virtio core should
> > > skip the dma unmap operation.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >
> >
> > I don't get it - is this like a bugfix?
> 
> I want focus on this. So let it as an independent commit.
> 
> > And why do we need our own flag and checks?
> > Doesn't virtio core DTRT?
> 
> 
> struct vring_virtqueue {
> 	[....]
> 
> 	/* Do DMA mapping by driver */
> 	bool premapped;
> 
> We can not.
> 
> So I add own flag.
> 
> Thanks.

Still don't get it. Why not check the premapped flag?

> 
> >
> > > ---
> > >  drivers/net/virtio/main.c       | 8 +++++---
> > >  drivers/net/virtio/virtio_net.h | 3 +++
> > >  drivers/net/virtio/xsk.c        | 1 +
> > >  3 files changed, 9 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > > index 15943a22e17d..a318b2533b94 100644
> > > --- a/drivers/net/virtio/main.c
> > > +++ b/drivers/net/virtio/main.c
> > > @@ -430,7 +430,7 @@ static void *virtnet_rq_get_buf(struct virtnet_rq *rq, u32 *len, void **ctx)
> > >  	void *buf;
> > >
> > >  	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > > -	if (buf && rq->do_dma)
> > > +	if (buf && rq->do_dma_unmap)
> > >  		virtnet_rq_unmap(rq, buf, *len);
> > >
> > >  	return buf;
> > > @@ -561,8 +561,10 @@ static void virtnet_set_premapped(struct virtnet_info *vi)
> > >
> > >  		/* disable for big mode */
> > >  		if (vi->mergeable_rx_bufs || !vi->big_packets) {
> > > -			if (!virtqueue_set_dma_premapped(vi->rq[i].vq))
> > > +			if (!virtqueue_set_dma_premapped(vi->rq[i].vq)) {
> > >  				vi->rq[i].do_dma = true;
> > > +				vi->rq[i].do_dma_unmap = true;
> > > +			}
> > >  		}
> > >  	}
> > >  }
> > > @@ -3944,7 +3946,7 @@ void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
> > >
> > >  	rq = &vi->rq[i];
> > >
> > > -	if (rq->do_dma)
> > > +	if (rq->do_dma_unmap)
> > >  		virtnet_rq_unmap(rq, buf, 0);
> > >
> > >  	virtnet_rq_free_buf(vi, rq, buf);
> > > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
> > > index 1242785e311e..2005d0cd22e2 100644
> > > --- a/drivers/net/virtio/virtio_net.h
> > > +++ b/drivers/net/virtio/virtio_net.h
> > > @@ -135,6 +135,9 @@ struct virtnet_rq {
> > >  	/* Do dma by self */
> > >  	bool do_dma;
> > >
> > > +	/* Do dma unmap after getting buf from virtio core. */
> > > +	bool do_dma_unmap;
> > > +
> > >  	struct {
> > >  		struct xsk_buff_pool *pool;
> > >
> > > diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> > > index e737c3353212..b09c473c29fb 100644
> > > --- a/drivers/net/virtio/xsk.c
> > > +++ b/drivers/net/virtio/xsk.c
> > > @@ -210,6 +210,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct virtnet_rq *
> > >  		xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> > >
> > >  	rq->xsk.pool = pool;
> > > +	rq->do_dma_unmap = !pool;
> > >
> > >  	virtnet_rx_resume(vi, rq);
> > >
> > > --
> > > 2.32.0.3.g01195cf9f
> >
> >


