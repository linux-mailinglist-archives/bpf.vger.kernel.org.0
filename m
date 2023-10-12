Return-Path: <bpf+bounces-12022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEB37C69D2
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 11:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870021C20F5B
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 09:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC9021355;
	Thu, 12 Oct 2023 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AiHazCle"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F1AFC13
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 09:40:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA2C9D
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 02:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697103644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=00tS3vVt56YLB6HCDNOpijtr1BRbbD0u9qHtCnGMKDk=;
	b=AiHazCleplnKBx9CgWgZcG5LToJPElPuVpvlGBJ2f43arT6qlntda3ID3jsYsZzALQ7fNI
	nhiHWaa3MLTJnVpKyy2ln3PXyDvNp6JAIh2Ebci+k9ObkxE8K1GKUj5S3vOYlioczSTnSs
	3PHePnN55v77QWmBlf026VIB/qflVKQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-dJkOeBkjNECcpjCHETCRDA-1; Thu, 12 Oct 2023 05:40:43 -0400
X-MC-Unique: dJkOeBkjNECcpjCHETCRDA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40590e6bd67so6471865e9.2
        for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 02:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697103642; x=1697708442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00tS3vVt56YLB6HCDNOpijtr1BRbbD0u9qHtCnGMKDk=;
        b=ELQkdDeb4+TjpvvUxB8REMmNC4drhrHQxH87/68Z9sqzDbunCS668HvT0mybiNuR9A
         QiSi+WHMZ/YhHsTjX2AUbYEsvSgrSMSjyrOppoN0OqsAmCAcPgU2o3F3KL1EFsJVsDKB
         BRvNi4HjMRPruRrITpe8fILVyvSD6DW7lWc6ngOyyAVCW/C00EvC2LozBEw9MlULbTD/
         +WBNQdYSqyUt1eBQ0KQo0G80w+usrBaz3YJwo4iOCORrumLQfB+QipbQT6AxWVGVntSd
         ERyM0tLs6wMixHpoy4dwhoe1bQrLPYqg6ZuRhL8o3VUCtZiT+tB/0Fa5z9ZT0VV8Zu/S
         hPiw==
X-Gm-Message-State: AOJu0Yx3Xa38S4Ze6LG58umzhhpNj40M7RbFML5N19nSIRsJOCK/QETI
	7hXT1fqE0fdhS1VW1b52U7ZzGz6U99fME6XgbWncK4jdnp7w05MILx3+M4ctChS5i9Wqyt8/SoK
	gehduUfU2UI2p
X-Received: by 2002:a05:6000:81b:b0:329:6b5b:57b8 with SMTP id bt27-20020a056000081b00b003296b5b57b8mr17336967wrb.25.1697103642340;
        Thu, 12 Oct 2023 02:40:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl7KzQPIMAq5kHVaTLlIETFIobOXBWJ/kPIl5UMZdZb+nC75A7URLvftxFpanZ8usGUXKKfg==
X-Received: by 2002:a05:6000:81b:b0:329:6b5b:57b8 with SMTP id bt27-20020a056000081b00b003296b5b57b8mr17336944wrb.25.1697103641913;
        Thu, 12 Oct 2023 02:40:41 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d6904000000b0032710f5584fsm17786997wru.25.2023.10.12.02.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 02:40:41 -0700 (PDT)
Date: Thu, 12 Oct 2023 05:40:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH vhost 01/22] virtio_ring: virtqueue_set_dma_premapped
 support disable
Message-ID: <20231012053812-mutt-send-email-mst@kernel.org>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-2-xuanzhuo@linux.alibaba.com>
 <20231012051416-mutt-send-email-mst@kernel.org>
 <1697102334.7060938-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697102334.7060938-2-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 05:18:54PM +0800, Xuan Zhuo wrote:
> On Thu, 12 Oct 2023 05:15:52 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Oct 11, 2023 at 05:27:07PM +0800, Xuan Zhuo wrote:
> > > virtqueue_set_dma_premapped() adds a new parameter to disable the
> > > virtqueue premapped mode.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c     |  2 +-
> > >  drivers/virtio/virtio_ring.c | 11 ++++++++---
> > >  include/linux/virtio.h       |  2 +-
> > >  3 files changed, 10 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index fe7f314d65c9..6b5f47ebf9b2 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -737,7 +737,7 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> > >  		return;
> > >
> > >  	for (i = 0; i < vi->max_queue_pairs; i++) {
> > > -		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> > > +		if (virtqueue_set_dma_premapped(vi->rq[i].vq, true))
> > >  			continue;
> > >
> > >  		vi->rq[i].do_dma = true;
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 51d8f3299c10..b3ded56722f4 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -2784,7 +2784,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
> > >   * 0: success.
> > >   * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
> > >   */
> > > -int virtqueue_set_dma_premapped(struct virtqueue *_vq)
> > > +int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool mode)
> > >  {
> > >  	struct vring_virtqueue *vq = to_vvq(_vq);
> > >  	u32 num;
> > > @@ -2803,8 +2803,13 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
> > >  		return -EINVAL;
> > >  	}
> > >
> > > -	vq->premapped = true;
> > > -	vq->do_unmap = false;
> > > +	if (mode) {
> > > +		vq->premapped = true;
> > > +		vq->do_unmap = false;
> > > +	} else {
> > > +		vq->premapped = false;
> > > +		vq->do_unmap = vq->use_dma_api;
> > > +	}
> > >
> > >  	END_USE(vq);
> > >
> > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > index 4cc614a38376..1cf7b004348b 100644
> > > --- a/include/linux/virtio.h
> > > +++ b/include/linux/virtio.h
> > > @@ -81,7 +81,7 @@ bool virtqueue_enable_cb(struct virtqueue *vq);
> > >
> > >  unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
> > >
> > > -int virtqueue_set_dma_premapped(struct virtqueue *_vq);
> > > +int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool mode);
> > >
> > >  bool virtqueue_poll(struct virtqueue *vq, unsigned);
> >
> > Wait a sec I thought we never change premapped. If you make this
> > dynamic don't you need a bunch of locking?
> > Or maybe queue is empty when you change this?
> > If yes pls add a bunch of BUG_ON checks to make sure this is not misused.
> 
> 
> Actually, this api is called immediately after the vq init or vq reset.
> 
> We already have such a check.
> 
> Thanks.
> 
> /**
>  * virtqueue_set_dma_premapped - set the vring premapped mode
>  * @_vq: the struct virtqueue we're talking about.
>  *
>  * Enable the premapped mode of the vq.
>  *
>  * The vring in premapped mode does not do dma internally, so the driver must
>  * do dma mapping in advance. The driver must pass the dma_address through
>  * dma_address of scatterlist. When the driver got a used buffer from
>  * the vring, it has to unmap the dma address.
>  *
>  * This function must be called immediately after creating the vq, or after vq
>  * reset, and before adding any buffers to it.
>  *
>  * Caller must ensure we don't call this with other virtqueue operations
>  * at the same time (except where noted).
>  *
>  * Returns zero or a negative error.
>  * 0: success.
>  * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
>  */
> int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool mode)
> {
> 	struct vring_virtqueue *vq = to_vvq(_vq);
> 	u32 num;
> 
> 	START_USE(vq);
> 
> 	num = vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num;
> 
> -->	if (num != vq->vq.num_free) {
> 		END_USE(vq);
> 		return -EINVAL;
> 	}

But it turns out virtnet_rq_set_premapped actually just ignores errors.
So returning EINVAL here does nothing caller just proceeds?
And checking num_free without locks is never safe anyway.
I think the point is that this never triggers then just BUG_ON.


> 
> 	if (!vq->use_dma_api) {
> 		END_USE(vq);
> 		return -EINVAL;
> 	}
> 
> 	if (mode) {
> 		vq->premapped = true;
> 		vq->do_unmap = false;
> 	} else {
> 		vq->premapped = false;
> 		vq->do_unmap = vq->use_dma_api;
> 	}
> 
> 	END_USE(vq);
> 
> 	return 0;
> }
> EXPORT_SYMBOL_GPL(virtqueue_set_dma_premapped);
> 
> 
> >
> >
> > > --
> > > 2.32.0.3.g01195cf9f
> >


