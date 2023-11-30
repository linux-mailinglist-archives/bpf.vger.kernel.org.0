Return-Path: <bpf+bounces-16249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704C97FEC92
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 11:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12891C20EAC
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 10:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAFC3B7B3;
	Thu, 30 Nov 2023 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sb6wSiOh"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CB110D1
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 02:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701339051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mog5a4tE2VffmSpLM7m0gtLx5poQ9B/lXLESgJQeZsA=;
	b=Sb6wSiOhlHhO/qH1aKmh3dcYtmo+UCQcE+NBexFYZKpEaCFSaBiiiuK/OvPIpk+S53lP2+
	qdwaj2/ikcX9yNiYsAW7xSVvfysrqnqsjiXgZ7lsYmxRsXl4XCqdmzZ2PY/lPZVLcA1MgO
	5xvJ933XQqGKmmX1Xi/nvZPCdWeRYJQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-xRvVe51gPqOVvTl8jts8ig-1; Thu, 30 Nov 2023 05:10:49 -0500
X-MC-Unique: xRvVe51gPqOVvTl8jts8ig-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-332fab597afso664660f8f.3
        for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 02:10:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701339048; x=1701943848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mog5a4tE2VffmSpLM7m0gtLx5poQ9B/lXLESgJQeZsA=;
        b=u23JeAFmb7hppybrYOl3fcmincBIAF8UtIsRnjhnTUdSFqmwgyjlTbUCPBEf0xYzjL
         gKN/p3EmRdtt8wMVcOm5OlErSKvoVFQjwc3KnN/n2FecFTji3qv1y0fafhZ8f3WabPFI
         42MHEhyn4ls5VHOT0xByPlKUkAzCTBnbOvAiYNMSNbcxCpbuCI+k/Z6r82gc6W0Jze3X
         Ua+FcUEvm3L+R1unFP5w2jQ+iQj0HUzSyH+H1G3ucLcmIpEYjGCkAavgH7VRgjmNZnfK
         dbn/EGwQmR6g2mojA8COLNZOL3wByWrnn1BBpbey29GF9pvx+AoGhmicT/47pJWS3BYS
         SRKg==
X-Gm-Message-State: AOJu0YxMzD9an+wU8xMWDMNFRTo97PXbRzmD0aj+POBAEd0Bin36hW7m
	6cMXTPJekiM5uJZLy6CsDmR1tp4b2eyzVu7QXAwEl2iGUvLyXUqCM3wdo4JRfNVODtzIHQX3GOS
	+yruhev2/K11H
X-Received: by 2002:adf:b1d2:0:b0:332:d288:30de with SMTP id r18-20020adfb1d2000000b00332d28830demr11281968wra.6.1701339047934;
        Thu, 30 Nov 2023 02:10:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoDzxOJY6GbVA8OrUwNUrxvIoPjhP1/utIyFxQxHxsGwbyA0pb6sv8J5tkTTv7ZFjei6GKCg==
X-Received: by 2002:adf:b1d2:0:b0:332:d288:30de with SMTP id r18-20020adfb1d2000000b00332d28830demr11281948wra.6.1701339047555;
        Thu, 30 Nov 2023 02:10:47 -0800 (PST)
Received: from redhat.com ([2.55.57.48])
        by smtp.gmail.com with ESMTPSA id q3-20020adfcd83000000b00333085ceca5sm1082840wrj.64.2023.11.30.02.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 02:10:46 -0800 (PST)
Date: Thu, 30 Nov 2023 05:10:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH vhost v13 11/12] virtio_ring: introduce dma sync api for
 virtqueue
Message-ID: <20231130050852-mutt-send-email-mst@kernel.org>
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-12-xuanzhuo@linux.alibaba.com>
 <20231130044512-mutt-send-email-mst@kernel.org>
 <1701337778.899533-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1701337778.899533-1-xuanzhuo@linux.alibaba.com>

On Thu, Nov 30, 2023 at 05:49:38PM +0800, Xuan Zhuo wrote:
> On Thu, 30 Nov 2023 04:45:58 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Aug 10, 2023 at 08:30:56PM +0800, Xuan Zhuo wrote:
> > > These API has been introduced:
> > >
> > > * virtqueue_dma_need_sync
> > > * virtqueue_dma_sync_single_range_for_cpu
> > > * virtqueue_dma_sync_single_range_for_device
> > >
> > > These APIs can be used together with the premapped mechanism to sync the
> > > DMA address.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 76 ++++++++++++++++++++++++++++++++++++
> > >  include/linux/virtio.h       |  8 ++++
> > >  2 files changed, 84 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 916479c9c72c..81ecb29c88f1 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -3175,4 +3175,80 @@ int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr)
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_dma_mapping_error);
> > >
> > > +/**
> > > + * virtqueue_dma_need_sync - check a dma address needs sync
> > > + * @_vq: the struct virtqueue we're talking about.
> > > + * @addr: DMA address
> > > + *
> > > + * Check if the dma address mapped by the virtqueue_dma_map_* APIs needs to be
> > > + * synchronized
> > > + *
> > > + * return bool
> > > + */
> > > +bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr)
> > > +{
> > > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > > +
> > > +	if (!vq->use_dma_api)
> > > +		return false;
> > > +
> > > +	return dma_need_sync(vring_dma_dev(vq), addr);
> > > +}
> > > +EXPORT_SYMBOL_GPL(virtqueue_dma_need_sync);
> > > +
> > > +/**
> > > + * virtqueue_dma_sync_single_range_for_cpu - dma sync for cpu
> > > + * @_vq: the struct virtqueue we're talking about.
> > > + * @addr: DMA address
> > > + * @offset: DMA address offset
> > > + * @size: buf size for sync
> > > + * @dir: DMA direction
> > > + *
> > > + * Before calling this function, use virtqueue_dma_need_sync() to confirm that
> > > + * the DMA address really needs to be synchronized
> > > + *
> > > + */
> > > +void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq,
> > > +					     dma_addr_t addr,
> > > +					     unsigned long offset, size_t size,
> > > +					     enum dma_data_direction dir)
> > > +{
> > > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > > +	struct device *dev = vring_dma_dev(vq);
> > > +
> > > +	if (!vq->use_dma_api)
> > > +		return;
> > > +
> > > +	dma_sync_single_range_for_cpu(dev, addr, offset, size,
> > > +				      DMA_BIDIRECTIONAL);
> > > +}
> >
> >
> > Why did you use DMA_BIDIRECTIONAL here?
> > Why is "dir" ignored?
> 
> This is a mistake.
> 
> I see Jason has a fix patch.

the one he sent in response to the bug report? it's incomplete though.

> How can I help?
> 
> Thanks.

develop a full patch with commit log, explanation of what
the result of the bug is, Fixes tag etc, test
in some environment where dir makes a difference and post.


> 
> >
> >
> > > +EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_cpu);
> > > +
> > > +/**
> > > + * virtqueue_dma_sync_single_range_for_device - dma sync for device
> > > + * @_vq: the struct virtqueue we're talking about.
> > > + * @addr: DMA address
> > > + * @offset: DMA address offset
> > > + * @size: buf size for sync
> > > + * @dir: DMA direction
> > > + *
> > > + * Before calling this function, use virtqueue_dma_need_sync() to confirm that
> > > + * the DMA address really needs to be synchronized
> > > + */
> > > +void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq,
> > > +						dma_addr_t addr,
> > > +						unsigned long offset, size_t size,
> > > +						enum dma_data_direction dir)
> > > +{
> > > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > > +	struct device *dev = vring_dma_dev(vq);
> > > +
> > > +	if (!vq->use_dma_api)
> > > +		return;
> > > +
> > > +	dma_sync_single_range_for_device(dev, addr, offset, size,
> > > +					 DMA_BIDIRECTIONAL);
> > > +}
> > > +EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_device);
> > > +
> > >  MODULE_LICENSE("GPL");
> >
> > same question here.
> >
> > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > index 79e3c74391e0..1311a7fbe675 100644
> > > --- a/include/linux/virtio.h
> > > +++ b/include/linux/virtio.h
> > > @@ -220,4 +220,12 @@ void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
> > >  				      size_t size, enum dma_data_direction dir,
> > >  				      unsigned long attrs);
> > >  int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr);
> > > +
> > > +bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr);
> > > +void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq, dma_addr_t addr,
> > > +					     unsigned long offset, size_t size,
> > > +					     enum dma_data_direction dir);
> > > +void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq, dma_addr_t addr,
> > > +						unsigned long offset, size_t size,
> > > +						enum dma_data_direction dir);
> > >  #endif /* _LINUX_VIRTIO_H */
> > > --
> > > 2.32.0.3.g01195cf9f
> >
> >


