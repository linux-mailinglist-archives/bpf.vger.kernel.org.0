Return-Path: <bpf+bounces-20654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAAD8419B2
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 03:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA76728270F
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 02:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3330E37153;
	Tue, 30 Jan 2024 02:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlNocdS7"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1303F374D9
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 02:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706583402; cv=none; b=i461lqxwIpuucYvY2r1KeQtF9t13bdlR1T60WM9kPCp+caHh1L94q+3lMGTHuBStnf44wTsKs8Z8lStcF7jM2W2vXyDhMzYTLj5aJLyfEToeHhr7tJL5ZMwGHzSm5DgcEn177qy5K5wDAoqwBRFca0iTiWXsf8jCtU1Yys+VSIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706583402; c=relaxed/simple;
	bh=sWfQJ4xrld3vrYQoUZBDeJypauKT06q8NqlOetqiyiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PRbMVS/pW7NBdIB6ZINC/zCCzOBbDQneA/pz+pTRkaZ11+YwIOnAFXKCURmus9QLDu2fW4GV3Qw+wLzCaH9c95bbG1e+EZHxi+DJhfS2YW+6tJAn2gBZoV9MjsqFfB5H2qapFjKTx2fy5eoQi/bKzFQlz7G6PB6qhm8SeM2ZNRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MlNocdS7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706583399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ibydxiBCW6EYpzd0/EzGNxJhSnZkw8hqylGX8wqHxec=;
	b=MlNocdS7yLlOVYjMvx1J6AD+QVZNPpI5g3SOWW3XsAmusFXyHrkabtFftO4I8KPdnGztfz
	wkWHGTEWNi0O6w2ma6umMFvUMacZWrHlV0Hv+WSOcMFDAYtONE5ZRswub/sw4M7x4lky19
	NMnt+BgVIQ8M5P8AiMmtv8TdzCwTN/0=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-1Vnp2B-sOIqCo2Y3SLDuZA-1; Mon, 29 Jan 2024 21:56:37 -0500
X-MC-Unique: 1Vnp2B-sOIqCo2Y3SLDuZA-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3bd97c17091so4771884b6e.3
        for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 18:56:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706583396; x=1707188196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibydxiBCW6EYpzd0/EzGNxJhSnZkw8hqylGX8wqHxec=;
        b=YzEhpPgTlW2ySj+7EC0Rzm7wMArVQFi20zkee4t+KK2MIeBn4xyxqox++aeYh2I4ww
         V2zp8o3Dl0vZR2Cop9jbmXaayLFnqH/J2lG3MiYA77ZoPIwDZK+0Rdu1CMZ49ctFcgBh
         6Xmf2oheYp1y5rvK9zkhCJHrz+g7niN/KWFAcMLUymrl9TltTK0DuQgviZNxN9u7OQkL
         cW12gSnj8Vb6PVDu4CGT2ANBb5DRI+Nm0XzOQNHUl7Ux5/B6c/E6h1WK7Qrjurf0VtPD
         RRdisJ3Q4lOkPreI0IEWSeIvgREavZQBe8lGLZWevP042d8q0L8JmqtxrJX1K5wVJlPV
         xBnw==
X-Gm-Message-State: AOJu0Yyg8zqvTAQ0iR+CMj66TR/VvdSK0RWzbEoRM5JrbtwxcTHCWcBO
	gjmBFVOlnM+Nyd410xkRYPNd845l57V0tI/XMFBve+JkVlO0u7oB5Vkzeqid6ia59D/LvRJxAhK
	rBjjVlflIELMwny5/UiAu7f79IGuJ1QfQYfnvzohDl/oBOVnqVk2//bVOKuHRwuyFMyzOSKQkmw
	/1peXuoNWIXR/YPbhDl0odUxlA
X-Received: by 2002:a05:6808:17a5:b0:3bd:a880:d248 with SMTP id bg37-20020a05680817a500b003bda880d248mr9688967oib.41.1706583396490;
        Mon, 29 Jan 2024 18:56:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGl7/WPNAWrvbnnAvdXUZ9NQYNIp8/+gS3dy819TUkbAMI/YMTrbyGxSwjyD+Q+tSz5mgShkYDCbiO1lv5XbPg=
X-Received: by 2002:a05:6808:17a5:b0:3bd:a880:d248 with SMTP id
 bg37-20020a05680817a500b003bda880d248mr9688944oib.41.1706583396204; Mon, 29
 Jan 2024 18:56:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com>
 <20240116075924.42798-6-xuanzhuo@linux.alibaba.com> <CACGkMEujO6EdmY_b2wPgG1uBo0DEWhLh81aEX4DHGMfCU7tzUw@mail.gmail.com>
 <1706162331.1486428-4-xuanzhuo@linux.alibaba.com> <CACGkMEvk7eiq6HKzoqHqmQ0DTuK-3tbc5r5rro1unyKYM61mMg@mail.gmail.com>
 <1706497888.0777724-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1706497888.0777724-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 30 Jan 2024 10:56:25 +0800
Message-ID: <CACGkMEsAx=VTOcxdTR555ZVVdmx57o5qr=t+kNQO1u-RM4Dspw@mail.gmail.com>
Subject: Re: [PATCH net-next 5/5] virtio_net: sq support premapped mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 11:28=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> On Mon, 29 Jan 2024 11:06:35 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Thu, Jan 25, 2024 at 2:24=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Thu, 25 Jan 2024 11:39:20 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Tue, Jan 16, 2024 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > If the xsk is enabling, the xsk tx will share the send queue.
> > > >
> > > > Any reason for this? Technically, virtio-net can work as other NIC
> > > > like 256 queues. There could be some work like optimizing the
> > > > interrupt allocations etc.
> > >
> > > Just like the logic of XDP_TX.
> > >
> > > Now the virtio spec does not allow to add new dynamic queues.
> > > As I know, most hypervisors just support few queues.
> >
> > When multiqueue is developed in Qemu, it support as least 256 queue
> > pairs if my memory is correct.
> >
>
>
> YES, but that is configured by the hypervisor.
>
> For the user on any platform, when he got a vm, the queue num is fixed.
> As I know, on most case, the num is less.
> If we want the af-xdp/xdp-tx has the the independent queues
> I think the dynamic queue is good way.

Yes, we can start from this.

>
>
> > > The num of
> > > queues is not bigger than the cpu num. So the best way is
> > > to share the send queues.
> > >
> > > Parav and I tried to introduce dynamic queues.
> >
> > Virtio-net doesn't differ from real NIC where most of them can create
> > queue dynamically. It's more about the resource allocation, if mgmt
> > can start with 256 queues, then we probably fine.
>
> But now, if the devices has 256, we will enable the 256 queues by default=
.
> that is too much.

It doesn't differ from the other NIC. E.g currently the active #qps is
determined by the number of cpus. this is only true if we have 256
cpus.

>
> So, the dynamic queue is not to create a new queue out of the resource.
>
> The device may tell the driver, the max queue resource is 256,
> but let we start from 8. If the driver need more, then we can
> enable more.

This is the policy we used now.

>
> But for me, the xdp tx can share the sq queue, so let we start
> the af-xdp from sharing sq queue.
>
>
> >
> > But I think we can leave this question now.
> >
> > > But that is dropped.
> > > Before that I think we can share the send queues.
> > >
> > >
> > > >
> > > > > But the xsk requires that the send queue use the premapped mode.
> > > > > So the send queue must support premapped mode.
> > > > >
> > > > > command: pktgen_sample01_simple.sh -i eth0 -s 16/1400 -d 10.0.0.1=
23 -m 00:16:3e:12:e1:3e -n 0 -p 100
> > > > > machine:  ecs.ebmg6e.26xlarge of Aliyun
> > > > > cpu: Intel(R) Xeon(R) Platinum 8269CY CPU @ 2.50GHz
> > > > > iommu mode: intel_iommu=3Don iommu.strict=3D1 iommu=3Dnopt
> > > > >
> > > > >                       |        iommu off           |        iommu=
 on
> > > > > ----------------------|------------------------------------------=
-----------
> > > > >                       | 16         |  1400         | 16         |=
 1400
> > > > > ----------------------|------------------------------------------=
-----------
> > > > > Before:               |1716796.00  |  1581829.00   | 390756.00  |=
 374493.00
> > > > > After(premapped off): |1733794.00  |  1576259.00   | 390189.00  |=
 378128.00
> > > > > After(premapped on):  |1707107.00  |  1562917.00   | 385667.00  |=
 373584.00
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/net/virtio/main.c       | 119 ++++++++++++++++++++++++++=
++----
> > > > >  drivers/net/virtio/virtio_net.h |  10 ++-
> > > > >  2 files changed, 116 insertions(+), 13 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.=
c
> > > > > index 4fbf612da235..53143f95a3a0 100644
> > > > > --- a/drivers/net/virtio/main.c
> > > > > +++ b/drivers/net/virtio/main.c
> > > > > @@ -168,13 +168,39 @@ static struct xdp_frame *ptr_to_xdp(void *p=
tr)
> > > > >         return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_=
XDP_FLAG);
> > > > >  }
> > > > >
> > > > > +static void virtnet_sq_unmap_buf(struct virtnet_sq *sq, struct v=
irtio_dma_head *dma)
> > > > > +{
> > > > > +       int i;
> > > > > +
> > > > > +       if (!dma)
> > > > > +               return;
> > > > > +
> > > > > +       for (i =3D 0; i < dma->next; ++i)
> > > > > +               virtqueue_dma_unmap_single_attrs(sq->vq,
> > > > > +                                                dma->items[i].ad=
dr,
> > > > > +                                                dma->items[i].le=
ngth,
> > > > > +                                                DMA_TO_DEVICE, 0=
);
> > > > > +       dma->next =3D 0;
> > > > > +}
> > > > > +
> > > > >  static void __free_old_xmit(struct virtnet_sq *sq, bool in_napi,
> > > > >                             u64 *bytes, u64 *packets)
> > > > >  {
> > > > > +       struct virtio_dma_head *dma;
> > > > >         unsigned int len;
> > > > >         void *ptr;
> > > > >
> > > > > -       while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D NUL=
L) {
> > > > > +       if (virtqueue_get_dma_premapped(sq->vq)) {
> > > >
> > > > Any chance this.can be false?
> > >
> > > __free_old_xmit is the common path.
> >
> > Did you mean the XDP path doesn't work with this? If yes, we need to
> > change that.
>
>
> NO. If the virtio core use_dma_api is false, the dma premapped
> can not be ture.

Ok, I see.

>
> >
> > >
> > > The virtqueue_get_dma_premapped() is used to check whether the sq is =
premapped
> > > mode.
> > >
> > > >
> > > > > +               dma =3D &sq->dma.head;
> > > > > +               dma->num =3D ARRAY_SIZE(sq->dma.items);
> > > > > +               dma->next =3D 0;
> > > >
> > > > Btw, I found in the case of RX we have:
> > > >
> > > > virtnet_rq_alloc():
> > > >
> > > >                         alloc_frag->offset =3D sizeof(*dma);
> > > >
> > > > This seems to defeat frag coalescing when the memory is highly
> > > > fragmented or high order allocation is disallowed.
> > > >
> > > > Any idea to solve this?
> > >
> > >
> > > On the rq premapped pathset, I answered this.
> > >
> > > http://lore.kernel.org/all/1692156147.7470396-3-xuanzhuo@linux.alibab=
a.com
> >
> > Oops, I forget that.
> >
> > >
> > > >
> > > > > +       } else {
> > > > > +               dma =3D NULL;
> > > > > +       }
> > > > > +
> > > > > +       while ((ptr =3D virtqueue_get_buf_ctx_dma(sq->vq, &len, d=
ma, NULL)) !=3D NULL) {
> > > > > +               virtnet_sq_unmap_buf(sq, dma);
> > > > > +
> > > > >                 if (!is_xdp_frame(ptr)) {
> > > > >                         struct sk_buff *skb =3D ptr;
> > > > >
> > > > > @@ -572,16 +598,70 @@ static void *virtnet_rq_alloc(struct virtne=
t_rq *rq, u32 size, gfp_t gfp)
> > > > >         return buf;
> > > > >  }
> > > > >
> > > > > -static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> > > > > +static void virtnet_set_premapped(struct virtnet_info *vi)
> > > > >  {
> > > > >         int i;
> > > > >
> > > > > -       /* disable for big mode */
> > > > > -       if (!vi->mergeable_rx_bufs && vi->big_packets)
> > > > > -               return;
> > > > > +       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > > > +               virtqueue_set_dma_premapped(vi->sq[i].vq);
> > > > >
> > > > > -       for (i =3D 0; i < vi->max_queue_pairs; i++)
> > > > > -               virtqueue_set_dma_premapped(vi->rq[i].vq);
> > > > > +               /* TODO for big mode */
> > > >
> > > > Btw, how hard to support big mode? If we can do premapping for that
> > > > code could be simplified.
> > > >
> > > > (There are vendors that doesn't support mergeable rx buffers).
> > >
> > > I will do that after these patch-sets
> >
> > If it's not too hard, I'd suggest to do it now.
>
>
> YES. Is not too hard, but I was doing too much.
>
> * virtio-net + device stats
> * virtio-net + af-xdp, this patch set has about 27 commits
>
> And I was pushing this too long, I just want to finish the work.
> Then I can work on the next (premapped big mode, af-xdp multi-buf....).
>
> So, let we step by step.

That's fine.

Thanks


