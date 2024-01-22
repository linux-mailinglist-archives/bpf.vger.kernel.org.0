Return-Path: <bpf+bounces-19984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AF9835ADF
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 07:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C1661C21AA4
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 06:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E048C6125;
	Mon, 22 Jan 2024 06:17:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57135D262;
	Mon, 22 Jan 2024 06:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705904255; cv=none; b=NjR9UTZ8K4+I9mRClejTVHzZTb+UgF7NBVj4ulysdIsDG6RR2U3ukYWOC35SmvpfeHIOD7s6ciFt9rwFX9zTbAVhrlzx6cCZYkxvXIA5mNtm+Y+ekzyeR9cbJ67vn2pM0+elVEYBr37LgDrlXCbrthGk5e4pbuI/5rwhns6sMx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705904255; c=relaxed/simple;
	bh=ZuxfKqos1iB9Had5ORFMI/UkY5m/YWXWSgmx7Txplas=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=u/M401z3w99aCJlWF88hiZRX7Yx8juQt/lPz4+vYAsbXsBgDMJTfDcBlKlmPj3N0Op3XlRngD91OpZZH16+I3xZxyd0FPgvbvcIRYoWU8JIHZx/gl/Xi6Btov4iIkrI5/GcUWBctM+5ya+xQxnr6QOHO++u/obRX6tagrCQhITc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W.1fZgZ_1705903929;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.1fZgZ_1705903929)
          by smtp.aliyun-inc.com;
          Mon, 22 Jan 2024 14:12:10 +0800
Message-ID: <1705903444.5368986-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3 06/27] virtio_ring: introduce virtqueue_get_buf_ctx_dma()
Date: Mon, 22 Jan 2024 14:04:04 +0800
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
 <1705390340.4814627-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEuo7m82cTxFSeryyYemMP8AgeKgE6kKYqoFGChTZ7KNWA@mail.gmail.com>
In-Reply-To: <CACGkMEuo7m82cTxFSeryyYemMP8AgeKgE6kKYqoFGChTZ7KNWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Mon, 22 Jan 2024 12:18:51 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Jan 16, 2024 at 3:47=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Thu, 11 Jan 2024 16:34:09 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Fri, Dec 29, 2023 at 3:31=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > introduce virtqueue_get_buf_ctx_dma() to collect the dma info when
> > > > get buf from virtio core for premapped mode.
> > > >
> > > > If the virtio queue is premapped mode, the virtio-net send buf may
> > > > have many desc. Every desc dma address need to be unmap. So here we
> > > > introduce a new helper to collect the dma address of the buffer from
> > > > the virtio core.
> > > >
> > > > Because the BAD_RING is called (that may set vq->broken), so
> > > > the relative "const" of vq is removed.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  drivers/virtio/virtio_ring.c | 174 +++++++++++++++++++++++++------=
----
> > > >  include/linux/virtio.h       |  16 ++++
> > > >  2 files changed, 142 insertions(+), 48 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_r=
ing.c
> > > > index 51d8f3299c10..1374b3fd447c 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -362,6 +362,45 @@ static struct device *vring_dma_dev(const stru=
ct vring_virtqueue *vq)
> > > >         return vq->dma_dev;
> > > >  }
> > > >
> > > > +/*
> > > > + *     use_dma_api premapped -> do_unmap
> > > > + *  1. false       false        false
> > > > + *  2. true        false        true
> > > > + *  3. true        true         false
> > > > + *
> > > > + * Only #3, we should return the DMA info to the driver.
> > >
> > > Btw, I guess you meant "#3 is false" here?
> > >
> > > And could we reduce the size of these 3 * 3 matrices? It's usually a
> > > hint that the code is not optmized.
> >
> > On the process of doing dma map, we force the (use_dma_api, premapped).
> >
> > if premapped:
> >      virtio core skip dma map
> > else:
> >         if use_dma_api:
> >                 do dma map
> >         else:
> >                 work with the physical address.
> >
> > Here we force the (premapped, do_unmap).
> >
> > do_unmap is an optimization. We just check this to know should we do dm=
a unmap
> > or not.
> >
> > Now, we introduced an new case, when the virtio core skip dma unmap,
> > we may need to return the dma info to the driver. That just occur when
> > the (premapped, do_unmap) is (true, false). Because that the (premmaped,
> > do_unmap) may be (false, false).
> >
> > For the matrices, I just want to show where the do_unmap comes from.
> > That is a optimization, we use this many places, not to check (use_dma_=
api,
> > premapped) on the process of doing unmap. And only for the case #3, we =
should
> > return the dma info to drivers.
>
> Ok, it tries to ease the life of the readers.
>
> I wonder if something like
>
> bool virtqueue_needs_unmap() can help, it can judge based on the value
> of use_dma_api and premapped.


I think not too much.

Because do_unmap is for this.



+static bool vring_need_unmap(struct vring_virtqueue *vq,
+			     struct virtio_dma_head *dma,
+			     dma_addr_t addr, unsigned int length)
+{
+	if (vq->do_unmap)
+		return true;

Before this, we is to judge whether we should do unmap or not.
After this, we is to judge whehter we should return dma info to driver or n=
ot.

If you want to simplify this function, I will say no.

If you want to replace "do_unmap" with virtqueue_needs_unmap(), I will say =
ok.
But I think we donot need to do that.

+
+	if (!vq->premapped)
+		return false;
+
+	if (!dma)
+		return false;
+
+	if (unlikely(dma->next >=3D dma->num)) {
+		BAD_RING(vq, "premapped vq: collect dma overflow: %pad %u\n",
+			 &addr, length);
+		return false;
+	}
+
+	dma->items[dma->next].addr =3D addr;
+	dma->items[dma->next].length =3D length;
+
+	++dma->next;
+
+	return false;
+}


Thanks.


>
> Thanks
>
> >
> > Thanks.
> >
> > >
> > > Thanks
> > >
> > >
> >
>

