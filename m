Return-Path: <bpf+bounces-19574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB29D82EA50
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 08:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4134E1F23AF9
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 07:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB2C111B2;
	Tue, 16 Jan 2024 07:47:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA121119F;
	Tue, 16 Jan 2024 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W-lNSlX_1705391227;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W-lNSlX_1705391227)
          by smtp.aliyun-inc.com;
          Tue, 16 Jan 2024 15:47:08 +0800
Message-ID: <1705390340.4814627-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3 06/27] virtio_ring: introduce virtqueue_get_buf_ctx_dma()
Date: Tue, 16 Jan 2024 15:32:20 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux-foundation.org,
 bpf@vger.kernel.org
References: <20231229073108.57778-1-xuanzhuo@linux.alibaba.com>
 <20231229073108.57778-7-xuanzhuo@linux.alibaba.com>
 <CACGkMEvaTr1iT1M7DXN1PNOAZPM75BGv-wTOkyqb-7Sgjshwaw@mail.gmail.com>
In-Reply-To: <CACGkMEvaTr1iT1M7DXN1PNOAZPM75BGv-wTOkyqb-7Sgjshwaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Thu, 11 Jan 2024 16:34:09 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Fri, Dec 29, 2023 at 3:31=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > introduce virtqueue_get_buf_ctx_dma() to collect the dma info when
> > get buf from virtio core for premapped mode.
> >
> > If the virtio queue is premapped mode, the virtio-net send buf may
> > have many desc. Every desc dma address need to be unmap. So here we
> > introduce a new helper to collect the dma address of the buffer from
> > the virtio core.
> >
> > Because the BAD_RING is called (that may set vq->broken), so
> > the relative "const" of vq is removed.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 174 +++++++++++++++++++++++++----------
> >  include/linux/virtio.h       |  16 ++++
> >  2 files changed, 142 insertions(+), 48 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 51d8f3299c10..1374b3fd447c 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -362,6 +362,45 @@ static struct device *vring_dma_dev(const struct v=
ring_virtqueue *vq)
> >         return vq->dma_dev;
> >  }
> >
> > +/*
> > + *     use_dma_api premapped -> do_unmap
> > + *  1. false       false        false
> > + *  2. true        false        true
> > + *  3. true        true         false
> > + *
> > + * Only #3, we should return the DMA info to the driver.
>
> Btw, I guess you meant "#3 is false" here?
>
> And could we reduce the size of these 3 * 3 matrices? It's usually a
> hint that the code is not optmized.

On the process of doing dma map, we force the (use_dma_api, premapped).

if premapped:
     virtio core skip dma map
else:
	if use_dma_api:
		do dma map
	else:
		work with the physical address.

Here we force the (premapped, do_unmap).

do_unmap is an optimization. We just check this to know should we do dma un=
map
or not.

Now, we introduced an new case, when the virtio core skip dma unmap,
we may need to return the dma info to the driver. That just occur when
the (premapped, do_unmap) is (true, false). Because that the (premmaped,
do_unmap) may be (false, false).

For the matrices, I just want to show where the do_unmap comes from.
That is a optimization, we use this many places, not to check (use_dma_api,
premapped) on the process of doing unmap. And only for the case #3, we shou=
ld
return the dma info to drivers.

Thanks.

>
> Thanks
>
>

