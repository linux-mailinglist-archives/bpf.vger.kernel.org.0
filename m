Return-Path: <bpf+bounces-20536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D4883FC92
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 04:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C248F1F223A4
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 03:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE78EFBEB;
	Mon, 29 Jan 2024 03:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MuBNLiP3"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEDCFBE9
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 03:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706497612; cv=none; b=cRUZ9TZv4be7dyDzThKclJE0AcI4DQ6ShbLBS9f/yeuIHo+HAbWwZqntLTlhbSlF2DhzfqE/Ct7PDO0tJVYki7kHpWGI5c2u9Sp7g1t9EF70z3cb0ge5StaQ1ZKN7lZ6fCGjvjAogb/zQTJr06v2RqNfSawlE1cy4roUFP1v/Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706497612; c=relaxed/simple;
	bh=uoL9MVcBZOmcFpmwSX7/PNbmXoMDKS5u4dhu5G3pVl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzZe+4kRqqKAK+kdLQWTfNwQ9EfptbmMXr8mFdSXmZYxwNkJNSRrKt3m81vTtZA3DNHgrjOAy4/yK0HA/yLkIV/dbNb8r29R/k64eRhFk20Hp4JqDUloBS9dRb9LSeZD6XPVWG4SZaEAqCqs6Us4R/6LX+P4d4kvnTNblX68lhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MuBNLiP3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706497609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SWPFLiOLF4l5AKxHN/CuOqQJd8AmXqw2Y9PK6N9dqEo=;
	b=MuBNLiP3iKK1Jxcb5p/wRsh3O74K3K+43mpwxiZ6E1qANYtyuV29kDZndokcOC+sRSdONi
	SkFAw8I00ZChUUAOaPcklGd9YNRbNNoOiRClhG8lcBTl1gSUlNua0H7VW2K3H4WaG9CAop
	38RYZompVvgK4bxAmlBvla++lGyA/QI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-AZ-qZC_oPiKTkVFfsplEbA-1; Sun, 28 Jan 2024 22:06:47 -0500
X-MC-Unique: AZ-qZC_oPiKTkVFfsplEbA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-29028587648so1214799a91.0
        for <bpf@vger.kernel.org>; Sun, 28 Jan 2024 19:06:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706497607; x=1707102407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWPFLiOLF4l5AKxHN/CuOqQJd8AmXqw2Y9PK6N9dqEo=;
        b=oyW13PRp967WcQyIBlMMFvfVwrBZyAgijtV922GUze8n/AK3J2+bu+mMPxlB1exQqT
         EyLw6yyevrgUpdoMeri/xY/OM0S2OQn6lxWlpOJT6vVu02Siy9xoXWPtAaZa1PZv1bRo
         B+FjT1DxguJBmQ4PUZdmGXRmAl86lMK5OSzSQ9Xt2JHsd5ux1UCYWftdHVTl6Mfl8YYY
         gXkJtfjB+t+yWPBtOuDT+oQqdTycOpHPhlCoOgO1LI70o17BQ7PF7WVAd5dMHY+xviW0
         69gENkGL5HIZLulFK8jQwOyvF9UMLVCymGROdSEcAL2h2jrMOwEJnHayFFkk55NOvPan
         MKzQ==
X-Gm-Message-State: AOJu0YxyCbZINCaKWygHGB9uuy+VUXimT9bdsjCs3eP1Axy4lzXAjWQV
	lGDqjvAZasnf7/udbQlronlyy8/3zfiPkxTf+uKdXmuESk/5CbvRNc35fvUWhv+JkywkX+Pij7P
	cyGwMoEUg/GYSSOaV/qnv+BhlIln/aChBx6ICGRnMa8mE3SyJQM0W6f7gN6il1wtWvlxB1470n4
	kmg7qJL5QduZkzLXxMJPHU1v8g
X-Received: by 2002:a17:90a:c284:b0:293:e888:a2c4 with SMTP id f4-20020a17090ac28400b00293e888a2c4mr2141653pjt.15.1706497606876;
        Sun, 28 Jan 2024 19:06:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlLo+qJieTRC49jTjixqHGkkaR76oUEJmvcQHVYvWELYfmAmuTutPyCgt4KafQNX0adX6R74pEX/VPO/KT254=
X-Received: by 2002:a17:90a:c284:b0:293:e888:a2c4 with SMTP id
 f4-20020a17090ac28400b00293e888a2c4mr2141635pjt.15.1706497606478; Sun, 28 Jan
 2024 19:06:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com>
 <20240116075924.42798-6-xuanzhuo@linux.alibaba.com> <CACGkMEujO6EdmY_b2wPgG1uBo0DEWhLh81aEX4DHGMfCU7tzUw@mail.gmail.com>
 <1706162331.1486428-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1706162331.1486428-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Jan 2024 11:06:35 +0800
Message-ID: <CACGkMEvk7eiq6HKzoqHqmQ0DTuK-3tbc5r5rro1unyKYM61mMg@mail.gmail.com>
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

On Thu, Jan 25, 2024 at 2:24=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 25 Jan 2024 11:39:20 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Jan 16, 2024 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > If the xsk is enabling, the xsk tx will share the send queue.
> >
> > Any reason for this? Technically, virtio-net can work as other NIC
> > like 256 queues. There could be some work like optimizing the
> > interrupt allocations etc.
>
> Just like the logic of XDP_TX.
>
> Now the virtio spec does not allow to add new dynamic queues.
> As I know, most hypervisors just support few queues.

When multiqueue is developed in Qemu, it support as least 256 queue
pairs if my memory is correct.

> The num of
> queues is not bigger than the cpu num. So the best way is
> to share the send queues.
>
> Parav and I tried to introduce dynamic queues.

Virtio-net doesn't differ from real NIC where most of them can create
queue dynamically. It's more about the resource allocation, if mgmt
can start with 256 queues, then we probably fine.

But I think we can leave this question now.

> But that is dropped.
> Before that I think we can share the send queues.
>
>
> >
> > > But the xsk requires that the send queue use the premapped mode.
> > > So the send queue must support premapped mode.
> > >
> > > command: pktgen_sample01_simple.sh -i eth0 -s 16/1400 -d 10.0.0.123 -=
m 00:16:3e:12:e1:3e -n 0 -p 100
> > > machine:  ecs.ebmg6e.26xlarge of Aliyun
> > > cpu: Intel(R) Xeon(R) Platinum 8269CY CPU @ 2.50GHz
> > > iommu mode: intel_iommu=3Don iommu.strict=3D1 iommu=3Dnopt
> > >
> > >                       |        iommu off           |        iommu on
> > > ----------------------|----------------------------------------------=
-------
> > >                       | 16         |  1400         | 16         | 140=
0
> > > ----------------------|----------------------------------------------=
-------
> > > Before:               |1716796.00  |  1581829.00   | 390756.00  | 374=
493.00
> > > After(premapped off): |1733794.00  |  1576259.00   | 390189.00  | 378=
128.00
> > > After(premapped on):  |1707107.00  |  1562917.00   | 385667.00  | 373=
584.00
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio/main.c       | 119 ++++++++++++++++++++++++++++--=
--
> > >  drivers/net/virtio/virtio_net.h |  10 ++-
> > >  2 files changed, 116 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > > index 4fbf612da235..53143f95a3a0 100644
> > > --- a/drivers/net/virtio/main.c
> > > +++ b/drivers/net/virtio/main.c
> > > @@ -168,13 +168,39 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
> > >         return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_=
FLAG);
> > >  }
> > >
> > > +static void virtnet_sq_unmap_buf(struct virtnet_sq *sq, struct virti=
o_dma_head *dma)
> > > +{
> > > +       int i;
> > > +
> > > +       if (!dma)
> > > +               return;
> > > +
> > > +       for (i =3D 0; i < dma->next; ++i)
> > > +               virtqueue_dma_unmap_single_attrs(sq->vq,
> > > +                                                dma->items[i].addr,
> > > +                                                dma->items[i].length=
,
> > > +                                                DMA_TO_DEVICE, 0);
> > > +       dma->next =3D 0;
> > > +}
> > > +
> > >  static void __free_old_xmit(struct virtnet_sq *sq, bool in_napi,
> > >                             u64 *bytes, u64 *packets)
> > >  {
> > > +       struct virtio_dma_head *dma;
> > >         unsigned int len;
> > >         void *ptr;
> > >
> > > -       while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D NULL) {
> > > +       if (virtqueue_get_dma_premapped(sq->vq)) {
> >
> > Any chance this.can be false?
>
> __free_old_xmit is the common path.

Did you mean the XDP path doesn't work with this? If yes, we need to
change that.

>
> The virtqueue_get_dma_premapped() is used to check whether the sq is prem=
apped
> mode.
>
> >
> > > +               dma =3D &sq->dma.head;
> > > +               dma->num =3D ARRAY_SIZE(sq->dma.items);
> > > +               dma->next =3D 0;
> >
> > Btw, I found in the case of RX we have:
> >
> > virtnet_rq_alloc():
> >
> >                         alloc_frag->offset =3D sizeof(*dma);
> >
> > This seems to defeat frag coalescing when the memory is highly
> > fragmented or high order allocation is disallowed.
> >
> > Any idea to solve this?
>
>
> On the rq premapped pathset, I answered this.
>
> http://lore.kernel.org/all/1692156147.7470396-3-xuanzhuo@linux.alibaba.co=
m

Oops, I forget that.

>
> >
> > > +       } else {
> > > +               dma =3D NULL;
> > > +       }
> > > +
> > > +       while ((ptr =3D virtqueue_get_buf_ctx_dma(sq->vq, &len, dma, =
NULL)) !=3D NULL) {
> > > +               virtnet_sq_unmap_buf(sq, dma);
> > > +
> > >                 if (!is_xdp_frame(ptr)) {
> > >                         struct sk_buff *skb =3D ptr;
> > >
> > > @@ -572,16 +598,70 @@ static void *virtnet_rq_alloc(struct virtnet_rq=
 *rq, u32 size, gfp_t gfp)
> > >         return buf;
> > >  }
> > >
> > > -static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> > > +static void virtnet_set_premapped(struct virtnet_info *vi)
> > >  {
> > >         int i;
> > >
> > > -       /* disable for big mode */
> > > -       if (!vi->mergeable_rx_bufs && vi->big_packets)
> > > -               return;
> > > +       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > +               virtqueue_set_dma_premapped(vi->sq[i].vq);
> > >
> > > -       for (i =3D 0; i < vi->max_queue_pairs; i++)
> > > -               virtqueue_set_dma_premapped(vi->rq[i].vq);
> > > +               /* TODO for big mode */
> >
> > Btw, how hard to support big mode? If we can do premapping for that
> > code could be simplified.
> >
> > (There are vendors that doesn't support mergeable rx buffers).
>
> I will do that after these patch-sets

If it's not too hard, I'd suggest to do it now.

>
> >
> > > +               if (vi->mergeable_rx_bufs || !vi->big_packets)
> > > +                       virtqueue_set_dma_premapped(vi->rq[i].vq);
> > > +       }
> > > +}
> > > +
> > > +static void virtnet_sq_unmap_sg(struct virtnet_sq *sq, u32 num)
> > > +{
> > > +       struct scatterlist *sg;
> > > +       u32 i;
> > > +
> > > +       for (i =3D 0; i < num; ++i) {
> > > +               sg =3D &sq->sg[i];
> > > +
> > > +               virtqueue_dma_unmap_single_attrs(sq->vq,
> > > +                                                sg->dma_address,
> > > +                                                sg->length,
> > > +                                                DMA_TO_DEVICE, 0);
> > > +       }
> > > +}
> > > +
> > > +static int virtnet_sq_map_sg(struct virtnet_sq *sq, u32 num)
> > > +{
> > > +       struct scatterlist *sg;
> > > +       u32 i;
> > > +
> > > +       for (i =3D 0; i < num; ++i) {
> > > +               sg =3D &sq->sg[i];
> > > +               sg->dma_address =3D virtqueue_dma_map_single_attrs(sq=
->vq, sg_virt(sg),
> > > +                                                                sg->=
length,
> > > +                                                                DMA_=
TO_DEVICE, 0);
> > > +               if (virtqueue_dma_mapping_error(sq->vq, sg->dma_addre=
ss))
> > > +                       goto err;
> > > +       }
> > > +
> >
> > This seems nothing virtio-net specific, let's move it to the core?
>
>
> This is the dma api style.
>
> And the caller can not judge it by the return value of
> virtqueue_dma_map_single_attrs.

I meant, if e.g virtio-fs want to use premapped, the code will for
sure be duplicated there as well.

Thanks


>
> Thanks
>
>
> >
> > Thanks
> >
> >
> > > +       return 0;
> > > +
> > > +err:
> > > +       virtnet_sq_unmap_sg(sq, i);
> > > +       return -ENOMEM;
> > > +}
> > > +
> > > +static int virtnet_add_outbuf(struct virtnet_sq *sq, u32 num, void *=
data)
> > > +{
> > > +       int ret;
> > > +
> > > +       if (virtqueue_get_dma_premapped(sq->vq)) {
> > > +               ret =3D virtnet_sq_map_sg(sq, num);
> > > +               if (ret)
> > > +                       return -ENOMEM;
> > > +       }
> > > +
> > > +       ret =3D virtqueue_add_outbuf(sq->vq, sq->sg, num, data, GFP_A=
TOMIC);
> > > +       if (ret && virtqueue_get_dma_premapped(sq->vq))
> > > +               virtnet_sq_unmap_sg(sq, num);
> > > +
> > > +       return ret;
> > >  }
> > >
> > >  static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
> > > @@ -687,8 +767,7 @@ static int __virtnet_xdp_xmit_one(struct virtnet_=
info *vi,
> > >                             skb_frag_size(frag), skb_frag_off(frag));
> > >         }
> > >
> > > -       err =3D virtqueue_add_outbuf(sq->vq, sq->sg, nr_frags + 1,
> > > -                                  xdp_to_ptr(xdpf), GFP_ATOMIC);
> > > +       err =3D virtnet_add_outbuf(sq, nr_frags + 1, xdp_to_ptr(xdpf)=
);
> > >         if (unlikely(err))
> > >                 return -ENOSPC; /* Caller handle free/refcnt */
> > >
> > > @@ -2154,7 +2233,7 @@ static int xmit_skb(struct virtnet_sq *sq, stru=
ct sk_buff *skb)
> > >                         return num_sg;
> > >                 num_sg++;
> > >         }
> > > -       return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_=
ATOMIC);
> > > +       return virtnet_add_outbuf(sq, num_sg, skb);
> > >  }
> > >
> > >  static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device=
 *dev)
> > > @@ -4011,9 +4090,25 @@ static void free_receive_page_frags(struct vir=
tnet_info *vi)
> > >
> > >  static void virtnet_sq_free_unused_bufs(struct virtqueue *vq)
> > >  {
> > > +       struct virtnet_info *vi =3D vq->vdev->priv;
> > > +       struct virtio_dma_head *dma;
> > > +       struct virtnet_sq *sq;
> > > +       int i =3D vq2txq(vq);
> > >         void *buf;
> > >
> > > -       while ((buf =3D virtqueue_detach_unused_buf(vq)) !=3D NULL) {
> > > +       sq =3D &vi->sq[i];
> > > +
> > > +       if (virtqueue_get_dma_premapped(sq->vq)) {
> > > +               dma =3D &sq->dma.head;
> > > +               dma->num =3D ARRAY_SIZE(sq->dma.items);
> > > +               dma->next =3D 0;
> > > +       } else {
> > > +               dma =3D NULL;
> > > +       }
> > > +
> > > +       while ((buf =3D virtqueue_detach_unused_buf_dma(vq, dma)) !=
=3D NULL) {
> > > +               virtnet_sq_unmap_buf(sq, dma);
> > > +
> > >                 if (!is_xdp_frame(buf))
> > >                         dev_kfree_skb(buf);
> > >                 else
> > > @@ -4228,7 +4323,7 @@ static int init_vqs(struct virtnet_info *vi)
> > >         if (ret)
> > >                 goto err_free;
> > >
> > > -       virtnet_rq_set_premapped(vi);
> > > +       virtnet_set_premapped(vi);
> > >
> > >         cpus_read_lock();
> > >         virtnet_set_affinity(vi);
> > > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/vir=
tio_net.h
> > > index 066a2b9d2b3c..dda144cc91c7 100644
> > > --- a/drivers/net/virtio/virtio_net.h
> > > +++ b/drivers/net/virtio/virtio_net.h
> > > @@ -48,13 +48,21 @@ struct virtnet_rq_dma {
> > >         u16 need_sync;
> > >  };
> > >
> > > +struct virtnet_sq_dma {
> > > +       struct virtio_dma_head head;
> > > +       struct virtio_dma_item items[MAX_SKB_FRAGS + 2];
> > > +};
> > > +
> > >  /* Internal representation of a send virtqueue */
> > >  struct virtnet_sq {
> > >         /* Virtqueue associated with this virtnet_sq */
> > >         struct virtqueue *vq;
> > >
> > >         /* TX: fragments + linear part + virtio header */
> > > -       struct scatterlist sg[MAX_SKB_FRAGS + 2];
> > > +       union {
> > > +               struct scatterlist sg[MAX_SKB_FRAGS + 2];
> > > +               struct virtnet_sq_dma dma;
> > > +       };
> > >
> > >         /* Name of the send queue: output.$index */
> > >         char name[16];
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >
>


