Return-Path: <bpf+bounces-22555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE96860AB1
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 07:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 441D5B2236A
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 06:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C572125C8;
	Fri, 23 Feb 2024 06:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3KiNF2+"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28C5125B3
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 06:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708669049; cv=none; b=fHST93U1oglJqgsa/U6lA4ag9eW05J1/z68BlimIJ0jrrSwQ2w6NVgwTscX3IBGHgQsxbCSX/ZbCNz7YaAjGwQcFHW5ieiQF0taz3C1JT+kLPrl8CUWgo7/gDTxCScdUxMxrfDljEW6xRzPxsuRxKEQX7agZncGnt8pbLoN5eKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708669049; c=relaxed/simple;
	bh=hCc9kfG3fizGgPgmdpClFKjoPRwjceJwvl8VPjdByMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8mKGIfrlu9EDbiCv3Wndc7Usq7I0jrppdGuhSzqb1N11TtMfEhmMHkz8PyFsc9djiSYBtAw0QYJUKqetj09D1n72HmJNsYGwU3UYwru19oHXcyTyXKqU0h7GJP7BX77qVteVqU0fE/II89Ij+HgY8SZWCxste3RmckfqgItt+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G3KiNF2+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708669046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aBnxjcZte0s2OKjIGIRhh7IFZ830goa5+vVUZQ5r/JI=;
	b=G3KiNF2+Hkr+NIQX+tUP1CRVOMDQuWJ/gVR0b0YPW2+bhYh/VECD6GelPBSUWelQ45V0YR
	YGIdU+v/TFBf4p4Rhn/gF0PHFyIscskdEve/Qj5mUZ/aNXgz4d3MgKMF4qHcR0XKt4G+kR
	kkdwFoAkbO7l979s5r17piUz5i9z7rM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-d2ps06u2P_O3JKZhwpvFrw-1; Fri, 23 Feb 2024 01:17:25 -0500
X-MC-Unique: d2ps06u2P_O3JKZhwpvFrw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33d19ac07c5so258017f8f.0
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 22:17:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708669044; x=1709273844;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aBnxjcZte0s2OKjIGIRhh7IFZ830goa5+vVUZQ5r/JI=;
        b=l2HScj9XFK3hsWXgZ6JjnBGgcMzAQ/O4rhEnXWlYpbcyDmXQARJ2XnZFXcHt2dUDZK
         LfGFD2zrVIT6xXTLEgJErg+NFCEt8N3QTPIpqpZAF/znA+lSGLYtdmikAGWB/az9OniI
         ShLLrZCujqkyOOk9qzgdTKu2+VTnCCqpA0Ic3PB0s9Jtki68w9sZ1gZI8pIs83GNtWyb
         kIFBJCkXrzFj/oliatA63+eRRS+f0S2oiRnWV67JkYEe7xEmPhJpJQyl0IBVR7Ore1aZ
         96Uy6G6zzEsWG31G2xmaB5h8I+5GlMLlGWF8dgErWq/JTqGcZOQoDE0a+LIvmkK49933
         pCMw==
X-Forwarded-Encrypted: i=1; AJvYcCWBYCus+Fm2lDhwZ1KJplNsQD4taCcPwO/FFT7QlgJB/ATOXgIgZYwJZJmUZFzKptQudis9r+/RKPgGlX5vvYvq8x/3
X-Gm-Message-State: AOJu0YyRm0SYlhecohq/ZITVc/94wcHnbwPWq60jA9Cj7HxQlAE40EM8
	p+d286QPHiowy1IlQNP5IKupJPj3e0tUH5+0fZ0bikR79PrA0kKYiuQPoW3bhfl0t3DmqF370jA
	K1h6kGoPHz5Ks7CJP8bjOduDVObVsP/Ho90V8nogY85h7i9XJyg==
X-Received: by 2002:a5d:56c8:0:b0:33d:157d:a7ad with SMTP id m8-20020a5d56c8000000b0033d157da7admr777494wrw.40.1708669043856;
        Thu, 22 Feb 2024 22:17:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVKDZZEwUcJIP7Avgmc2vr49V1+/ON8riI60u8BDNJ0hulyyOwnRcCKT7Cy9K6Xle99vWjdw==
X-Received: by 2002:a5d:56c8:0:b0:33d:157d:a7ad with SMTP id m8-20020a5d56c8000000b0033d157da7admr777452wrw.40.1708669043422;
        Thu, 22 Feb 2024 22:17:23 -0800 (PST)
Received: from redhat.com ([147.235.213.72])
        by smtp.gmail.com with ESMTPSA id bo10-20020a056000068a00b0033cddadde6esm1494453wrb.80.2024.02.22.22.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 22:17:22 -0800 (PST)
Date: Fri, 23 Feb 2024 01:17:17 -0500
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
	Benjamin Berg <benjamin.berg@intel.com>,
	linux-um@lists.infradead.org, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH vhost v1 00/19] virtio: drivers maintain dma info for
 premapped vq
Message-ID: <20240223011631-mutt-send-email-mst@kernel.org>
References: <20240202093951.120283-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240202093951.120283-1-xuanzhuo@linux.alibaba.com>

On Fri, Feb 02, 2024 at 05:39:32PM +0800, Xuan Zhuo wrote:
> As discussed:
> http://lore.kernel.org/all/CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPaVmJ3rHYqRZxYg@mail.gmail.com
> 
> If the virtio is premapped mode, the driver should manage the dma info by self.
> So the virtio core should not store the dma info.
> So we can release the memory used to store the dma info.
> 
> But if the desc_extra has not dma info, we face a new question,
> it is hard to get the dma info of the desc with indirect flag.
> For split mode, that is easy from desc, but for the packed mode,
> it is hard to get the dma info from the desc. And for hardening
> the dma unmap is saft, we should store the dma info of indirect
> descs.
> 
> So I introduce the "structure the indirect desc table" to
> allocate space to store dma info with the desc table.
> 
> On the other side, we mix the descs with indirect flag
> with other descs together to share the unmap api. That
> is complex. I found if we we distinguish the descs with
> VRING_DESC_F_INDIRECT before unmap, thing will be clearer.
> 
> Because of the dma array is allocated in the find_vqs(),
> so I introduce a new parameter to find_vqs().
> 
> Please review.
> 
> Thanks

this needs a rebase - conflicts with e.g.
commit e3fe8d28c67bf6c291e920c6d04fa22afa14e6e4
Author: Zhu Yanjun <yanjun.zhu@linux.dev>
Date:   Thu Jan 4 10:09:02 2024 +0800

    virtio_net: Fix "‘%d’ directive writing between 1 and 11 bytes into a region of size 10" warnings
    
    Fix the warnings when building virtio_net driver.
    

thanks!


> v1:
>     1. rename transport_vq_config to vq_transport_config
>     2. virtio-net set dma meta number to (ring-size + 1)(MAX_SKB_FRGAS +2)
>     3. introduce virtqueue_dma_map_sg_attrs
>     4. separate vring_create_virtqueue to an independent commit
> 
> Xuan Zhuo (19):
>   virtio_ring: introduce vring_need_unmap_buffer
>   virtio_ring: packed: remove double check of the unmap ops
>   virtio_ring: packed: structure the indirect desc table
>   virtio_ring: split: remove double check of the unmap ops
>   virtio_ring: split: structure the indirect desc table
>   virtio_ring: no store dma info when unmap is not needed
>   virtio: find_vqs: pass struct instead of multi parameters
>   virtio: vring_create_virtqueue: pass struct instead of multi
>     parameters
>   virtio: vring_new_virtqueue(): pass struct instead of multi parameters
>   virtio_ring: reuse the parameter struct of find_vqs()
>   virtio: find_vqs: add new parameter premapped
>   virtio_ring: export premapped to driver by struct virtqueue
>   virtio_net: set premapped mode by find_vqs()
>   virtio_ring: remove api of setting vq premapped
>   virtio_ring: introduce dma map api for page
>   virtio_ring: introduce virtqueue_dma_map_sg_attrs
>   virtio_net: unify the code for recycling the xmit ptr
>   virtio_net: rename free_old_xmit_skbs to free_old_xmit
>   virtio_net: sq support premapped mode
> 
>  arch/um/drivers/virtio_uml.c             |  31 +-
>  drivers/net/virtio_net.c                 | 291 +++++++---
>  drivers/platform/mellanox/mlxbf-tmfifo.c |  24 +-
>  drivers/remoteproc/remoteproc_virtio.c   |  31 +-
>  drivers/s390/virtio/virtio_ccw.c         |  33 +-
>  drivers/virtio/virtio_mmio.c             |  30 +-
>  drivers/virtio/virtio_pci_common.c       |  59 +-
>  drivers/virtio/virtio_pci_common.h       |   9 +-
>  drivers/virtio/virtio_pci_legacy.c       |  16 +-
>  drivers/virtio/virtio_pci_modern.c       |  24 +-
>  drivers/virtio/virtio_ring.c             | 698 ++++++++++++-----------
>  drivers/virtio/virtio_vdpa.c             |  45 +-
>  include/linux/virtio.h                   |  13 +-
>  include/linux/virtio_config.h            |  48 +-
>  include/linux/virtio_ring.h              |  82 +--
>  tools/virtio/virtio_test.c               |   4 +-
>  tools/virtio/vringh_test.c               |  28 +-
>  17 files changed, 848 insertions(+), 618 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f


