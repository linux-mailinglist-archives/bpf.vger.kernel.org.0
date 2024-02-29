Return-Path: <bpf+bounces-23028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA1986C568
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 10:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326581F26359
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 09:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72145F47C;
	Thu, 29 Feb 2024 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g2alaydc"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE485EE71
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199276; cv=none; b=JG25dGnuE6o02WQn+pkM9KhNgMBy2nIg7g/lX87J1reg3L3ZSAEFS0YmpdjpWnp3SVH/17uotiGs1+CXMUAK80eo5CpoVT5Utn02CwST1+UH9O0Zwebzt57lcxR/TNMLgdLEoD77Or6t6amiPCryTmzJ7r6NYfAKJ79pnBCiVVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199276; c=relaxed/simple;
	bh=GkGAw/dbvtAPuNf/2pfICzWyjWviIwP6O5SJmj0u3KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkD08pk1jmdbzlpUf+ogU/Rb6OHw5NCIF21tpAiRqC98w7t6lihIRi4hqRd/odqWmEp9+xg95DGUotXtLQhcnpPHQtQrJ86OU9CfGN3bMCp9Eev/onGnGXc8OdIxqKIEQx6lXMUfIAvHKNtrx+1lVWmsndBM4jN4DxrSdJDLOZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g2alaydc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709199272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TZsdg3ZN0LxY9nQESQ96ahFfH0ahlO3yM9XYoF9kTdE=;
	b=g2alaydcw/3+dNV3hb+N0zV7tM3lRdC+yKBtZ05pnYubRhHGtRfJm5VRN/P2vBQFtFqp0W
	r1jCNwIqE82HlOpvzxmAoVTQCiIT0c0GJfM9/ddH4bMjRvEhDd/tfJvzmQugdASAN5xms6
	KiM147sgrss5prS6/7a1VZsdE0Mh2ok=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-QyPjZuqwNPanNK6mvIl0aA-1; Thu, 29 Feb 2024 04:34:29 -0500
X-MC-Unique: QyPjZuqwNPanNK6mvIl0aA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-412b0d34a42so3246915e9.0
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 01:34:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709199268; x=1709804068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZsdg3ZN0LxY9nQESQ96ahFfH0ahlO3yM9XYoF9kTdE=;
        b=oeNkLCxAd9yi4uooLFF8dr+CpzowHBpELWNaz6OsjRpPUeevszAW2YgGUvyjJtuWYk
         NGDozqJK2lj/tEuQnaHowbTlPi8prAg2YGbv2tFDhS3N8VnyFLXDjdz3nVt05PgqnIfQ
         20aB9CcltBJuDPRTXbQY7L9tatw92ycPa3VHUdlwba/tHkW3ICO7mg9rNPzj/YcV0SGI
         NrWxdIg6Adfr7CjLMMAvFy8nnZs52FHDhhE0tPTcxFmN0cwf33yfoH8+D3Ky6K+Yps52
         RT8AA9NCq//Z/p6MhSWTst0H+QL8bpJUR4gn7SScMttKg0RxSQFjW6Fu/XDtYU1SjuFL
         H64w==
X-Forwarded-Encrypted: i=1; AJvYcCXeiGLL8z8G75cWADauL+mp0YAjeaLCYKJWpApMoCHl4z/2TNxFMxa9ESIz22d26tryieo+Q5vurFHmvfEZ2Imctcsp
X-Gm-Message-State: AOJu0YyrvsEk/NsqfGyRiTuZyIqQBgkdpa9/vv7xLak+OSA7zgOT/zNH
	mMzjXSAt1GNAu5bid4W5yj+5tB4QBRqh98vSbNhFXiC0JBuYxU40z16mjP/9pCTY/scDvvsvxug
	f0d0fRrfD6R3SIbrNeGgKFdseIbuDhyXZ081lnUaoIGzdiSEtOQ==
X-Received: by 2002:a05:600c:1548:b0:412:aec6:484f with SMTP id f8-20020a05600c154800b00412aec6484fmr1414587wmg.15.1709199268318;
        Thu, 29 Feb 2024 01:34:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfnF8uRkHXZC7wKNnT1fDTSMQyKX3qeooc5Rt0FsbIbstjuFdW8armLc3YEo+G0sH6Cq11xQ==
X-Received: by 2002:a05:600c:1548:b0:412:aec6:484f with SMTP id f8-20020a05600c154800b00412aec6484fmr1414542wmg.15.1709199267841;
        Thu, 29 Feb 2024 01:34:27 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:d6b0:a21c:61c4:2098:5db])
        by smtp.gmail.com with ESMTPSA id o17-20020adfa111000000b0033df8854f0dsm1256096wro.26.2024.02.29.01.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 01:34:27 -0800 (PST)
Date: Thu, 29 Feb 2024 04:34:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-um@lists.infradead.org, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH vhost v3 00/19] virtio: drivers maintain dma info for
 premapped vq
Message-ID: <20240229043238-mutt-send-email-mst@kernel.org>
References: <20240229072044.77388-1-xuanzhuo@linux.alibaba.com>
 <20240229031755-mutt-send-email-mst@kernel.org>
 <1709197357.626784-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1709197357.626784-1-xuanzhuo@linux.alibaba.com>

On Thu, Feb 29, 2024 at 05:02:37PM +0800, Xuan Zhuo wrote:
> On Thu, 29 Feb 2024 03:21:14 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Feb 29, 2024 at 03:20:25PM +0800, Xuan Zhuo wrote:
> > > As discussed:
> > > http://lore.kernel.org/all/CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPaVmJ3rHYqRZxYg@mail.gmail.com
> > >
> > > If the virtio is premapped mode, the driver should manage the dma info by self.
> > > So the virtio core should not store the dma info.
> > > So we can release the memory used to store the dma info.
> > >
> > > But if the desc_extra has not dma info, we face a new question,
> > > it is hard to get the dma info of the desc with indirect flag.
> > > For split mode, that is easy from desc, but for the packed mode,
> > > it is hard to get the dma info from the desc. And for hardening
> > > the dma unmap is saft, we should store the dma info of indirect
> > > descs.
> > >
> > > So I introduce the "structure the indirect desc table" to
> > > allocate space to store dma info with the desc table.
> > >
> > > On the other side, we mix the descs with indirect flag
> > > with other descs together to share the unmap api. That
> > > is complex. I found if we we distinguish the descs with
> > > VRING_DESC_F_INDIRECT before unmap, thing will be clearer.
> > >
> > > Because of the dma array is allocated in the find_vqs(),
> > > so I introduce a new parameter to find_vqs().
> > >
> > > Note:
> > >     this is on the top of
> > >         [PATCH vhost v1] virtio: packed: fix unmap leak for indirect desc table
> > >         http://lore.kernel.org/all/20240223071833.26095-1-xuanzhuo@linux.alibaba.com
> > >
> > > Please review.
> > >
> > > Thanks
> > >
> > > v3:
> > >     1. fix the conflict with the vp_modern_create_avq().
> >
> > Okay but are you going to address huge memory waste all this is causing for
> > - people who never do zero copy
> > - systems where dma unmap is a nop
> >
> > ?
> >
> > You should address all comments when you post a new version, not just
> > what was expedient, or alternatively tag patch as RFC and explain
> > in commit log that you plan to do it later.
> 
> 
> Do you miss this one?
> http://lore.kernel.org/all/1708997579.5613105-1-xuanzhuo@linux.alibaba.com


I did. The answer is that no, you don't get to regress memory usage
for lots of people then fix it up.
So the patchset is big, I guess it will take a couple of cycles to
merge gradually.

> I asked you. But I didnot recv your answer.
> 
> Thanks.
> 
> 
> >
> > > v2:
> > >     1. change the dma item of virtio-net, every item have MAX_SKB_FRAGS + 2
> > >         addr + len pairs.
> > >     2. introduce virtnet_sq_free_stats for __free_old_xmit
> > >
> > > v1:
> > >     1. rename transport_vq_config to vq_transport_config
> > >     2. virtio-net set dma meta number to (ring-size + 1)(MAX_SKB_FRGAS +2)
> > >     3. introduce virtqueue_dma_map_sg_attrs
> > >     4. separate vring_create_virtqueue to an independent commit
> > >
> > >
> > >
> > > Xuan Zhuo (19):
> > >   virtio_ring: introduce vring_need_unmap_buffer
> > >   virtio_ring: packed: remove double check of the unmap ops
> > >   virtio_ring: packed: structure the indirect desc table
> > >   virtio_ring: split: remove double check of the unmap ops
> > >   virtio_ring: split: structure the indirect desc table
> > >   virtio_ring: no store dma info when unmap is not needed
> > >   virtio: find_vqs: pass struct instead of multi parameters
> > >   virtio: vring_create_virtqueue: pass struct instead of multi
> > >     parameters
> > >   virtio: vring_new_virtqueue(): pass struct instead of multi parameters
> > >   virtio_ring: simplify the parameters of the funcs related to
> > >     vring_create/new_virtqueue()
> > >   virtio: find_vqs: add new parameter premapped
> > >   virtio_ring: export premapped to driver by struct virtqueue
> > >   virtio_net: set premapped mode by find_vqs()
> > >   virtio_ring: remove api of setting vq premapped
> > >   virtio_ring: introduce dma map api for page
> > >   virtio_ring: introduce virtqueue_dma_map_sg_attrs
> > >   virtio_net: unify the code for recycling the xmit ptr
> > >   virtio_net: rename free_old_xmit_skbs to free_old_xmit
> > >   virtio_net: sq support premapped mode
> > >
> > >  arch/um/drivers/virtio_uml.c             |  31 +-
> > >  drivers/net/virtio_net.c                 | 283 ++++++---
> > >  drivers/platform/mellanox/mlxbf-tmfifo.c |  24 +-
> > >  drivers/remoteproc/remoteproc_virtio.c   |  31 +-
> > >  drivers/s390/virtio/virtio_ccw.c         |  33 +-
> > >  drivers/virtio/virtio_mmio.c             |  30 +-
> > >  drivers/virtio/virtio_pci_common.c       |  59 +-
> > >  drivers/virtio/virtio_pci_common.h       |   9 +-
> > >  drivers/virtio/virtio_pci_legacy.c       |  16 +-
> > >  drivers/virtio/virtio_pci_modern.c       |  38 +-
> > >  drivers/virtio/virtio_ring.c             | 698 ++++++++++++-----------
> > >  drivers/virtio/virtio_vdpa.c             |  45 +-
> > >  include/linux/virtio.h                   |  13 +-
> > >  include/linux/virtio_config.h            |  48 +-
> > >  include/linux/virtio_ring.h              |  82 +--
> > >  tools/virtio/virtio_test.c               |   4 +-
> > >  tools/virtio/vringh_test.c               |  28 +-
> > >  17 files changed, 847 insertions(+), 625 deletions(-)
> > >
> > > --
> > > 2.32.0.3.g01195cf9f
> >


