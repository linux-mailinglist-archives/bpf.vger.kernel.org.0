Return-Path: <bpf+bounces-32358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF4590C0D7
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 02:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5751C20EFB
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 00:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C07D7484;
	Tue, 18 Jun 2024 00:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="On4v9n5S"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC494C8F
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 00:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718672380; cv=none; b=A0bz1dpvafnjm8F5WpO8TYEJ4mfLOoq+x0slklNJTrEME5v3NhK3aXLDJpYLrVTIq5IrEHW/kbexFxX3yM28vyqDZGIVMFFHKiM8wdrjVlRmViHxGLmk9+Y6g3ErZJ9veHMahEGURtVuXQITZQt1/89qmRMl1IW2U/k/9DEQLlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718672380; c=relaxed/simple;
	bh=Pk1yKo9gsoG0t/RyORKSuIQiTfqTdkDCUEZ9vvF6adU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TysDNTXOJpRNdeTDd+bdYKcAIEunfK5Q8m/cZhk1MIrMNdJocqD7aCY4suQVVTlbjSGvzE5lNbzJbrODCPsr/G/b5WlC8P/P3sJDMTa2gYNu0WxTebar3SZbPSEFV2hmBTh8SSlQmBfnYABl652UArG2kS1M2IhROPdxW6fLcts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=On4v9n5S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718672378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzyt9kOcpJi2DGG/xn8GdBqzjYxoqXEBoljXFOSP+A4=;
	b=On4v9n5Svcae8AHZkOFBLqVjj8vd1BXmJ4oTy/RrEB7IhumbvdVJRAuhCMqi71SLdPjEJg
	7w+PsMMMmtbo4I1doglPUXYgOlz9kT3r9+QoxD/6PO3r+jeBsPUt5ELlr1rg46KTV5UYSU
	rPyMQr+WHCS79azbUeuZ7aMZxAq4u9M=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-_R1YS9HUOjKYDt1G2NDqpQ-1; Mon, 17 Jun 2024 20:59:36 -0400
X-MC-Unique: _R1YS9HUOjKYDt1G2NDqpQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c2dd66e05dso5399412a91.0
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 17:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718672375; x=1719277175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzyt9kOcpJi2DGG/xn8GdBqzjYxoqXEBoljXFOSP+A4=;
        b=DlrrFTOE7dNvtzHPaySnU6cEMWdH74mEaWlDGvYLK36OVVNjJCyPSghv52t/6ti+H6
         W4z6cihuQ8V0EpFhVTKpzjVrdEKmZsRSHmLXBfO+qYfge1Jibg8dyDzx4gKeLWjrazBX
         LliKQIIbief0KmuJaulI5e2rvoPbLmuwGuOvmNXktxgy7cmBsbsqB6Itqfp/fwANjosr
         mYr09GU6eNI947OzboZczBZMbwOfmFNFfE/lIEgMlU+vXNkOIGef5VkI8GhzE2l018Wr
         dC6dblvHpBvU3WzSyq9zikMznRi1WLwF7L7atzVxqXEuy3oP+pr0Gy0IF6yPqbXajVvX
         XIvg==
X-Forwarded-Encrypted: i=1; AJvYcCV57fBHUefXptW9FPHaw1v/038AAxIAVG0uHZUs2cmL6x3eLoQ/IRPfIlX7etUm4wYL1kymI6xaPpmdWulm7WsB+JpF
X-Gm-Message-State: AOJu0YxPe1hGkQjMUHys3a3DoBH8vtNX3xh+GUkx1oU3TMav8GNS0ZC7
	S3ozTxTVg+Xzo45zkQuDkIHfmTNA4Iw49uZa1yQ5+NHCBIdqVSPpizHEHSSg3kALH9qiznWg40M
	GjRjh/LpA1DKhwKCstghcJ1EDu/bfY10Taph/jFXVU1hlzHQZyYOGSFQfAZAV4VrJDdvQi6l730
	ewCqvUkgowN02wiD7DlqeUol7M
X-Received: by 2002:a17:90b:3656:b0:2c2:e4b2:c99e with SMTP id 98e67ed59e1d1-2c4dbd44f03mr10194586a91.46.1718672375371;
        Mon, 17 Jun 2024 17:59:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPdGQPIG50ZyA2ScZ7mwZ2DrSWm4WYxZlq+xGLx6qeeM8Up9ka0BGhhMBdq/qQvJHEPxWBflcdogJesnN2Kok=
X-Received: by 2002:a17:90b:3656:b0:2c2:e4b2:c99e with SMTP id
 98e67ed59e1d1-2c4dbd44f03mr10194580a91.46.1718672375006; Mon, 17 Jun 2024
 17:59:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
 <20240614063933.108811-9-xuanzhuo@linux.alibaba.com> <CACGkMEu49yaJ+ZBAqP_e1T7kw-9GV8rKMeT1=GtG08ty52XWMw@mail.gmail.com>
 <1718609026.3881757-2-xuanzhuo@linux.alibaba.com> <CACGkMEvLv8g7BHC2Dhy_BsrcUxshaY=49DhFJDz7uqw-AH0GXg@mail.gmail.com>
In-Reply-To: <CACGkMEvLv8g7BHC2Dhy_BsrcUxshaY=49DhFJDz7uqw-AH0GXg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Jun 2024 08:59:23 +0800
Message-ID: <CACGkMEstxtg56pPZkwhLETEvCPMQzM0tdGk795igZY0_uUGJJw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 08/15] virtio_net: sq support premapped mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 8:57=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Jun 17, 2024 at 3:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Mon, 17 Jun 2024 13:00:13 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Fri, Jun 14, 2024 at 2:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > If the xsk is enabling, the xsk tx will share the send queue.
> > > > But the xsk requires that the send queue use the premapped mode.
> > > > So the send queue must support premapped mode when it is bound to
> > > > af-xdp.
> > > >
> > > > * virtnet_sq_set_premapped(sq, true) is used to enable premapped mo=
de.
> > > >
> > > >     In this mode, the driver will record the dma info when skb or x=
dp
> > > >     frame is sent.
> > > >
> > > >     Currently, the SQ premapped mode is operational only with af-xd=
p. In
> > > >     this mode, af-xdp, the kernel stack, and xdp tx/redirect will s=
hare
> > > >     the same SQ. Af-xdp independently manages its DMA. The kernel s=
tack
> > > >     and xdp tx/redirect utilize this DMA metadata to manage the DMA
> > > >     info.
> > > >
> > > >     If the indirect descriptor feature be supported, the volume of =
DMA
> > > >     details we need to maintain becomes quite substantial. Here, we=
 have
> > > >     a cap on the amount of DMA info we manage.
> > > >
> > > >     If the kernel stack and xdp tx/redirect attempt to use more
> > > >     descriptors, virtnet_add_outbuf() will return an -ENOMEM error.=
 But
> > > >     the af-xdp can work continually.
> > >
> > > Rethink of this whole logic, it looks like all the complication came
> > > as we decided to go with a pre queue pre mapping flag. I wonder if
> > > things could be simplified if we do that per buffer?
> >
> > YES. That will be simply.
> >
> > Then this patch will be not needed. The virtio core must record the pre=
mapped
> > imfo to the virtio ring state or extra.
> >
> >          http://lore.kernel.org/all/20230517022249.20790-6-xuanzhuo@lin=
ux.alibaba.com
>
> Yes, something like this. I think it's worthwhile to re-consider that
> approach. If my memory is correct, we haven't spotted the complicated
> issues we need to deal with like this patch.

Btw, it would be even nicer to piggyback with some existing fields.

Thanks

>
> >
> > >
> > > Then we don't need complex logic like dmainfo and cap.
> >
> > So the premapped mode and the internal dma mode can coexist.
> > Then we do not need to make the sq to support the premapped mode.
>
> Probably.
>
> >
> >
> > >
> > > >
> > > > * virtnet_sq_set_premapped(sq, false) is used to disable premapped =
mode.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 228 +++++++++++++++++++++++++++++++++++=
+++-
> > > >  1 file changed, 224 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index e84a4624549b..88ab9ea1646f 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -25,6 +25,7 @@
> > > >  #include <net/net_failover.h>
> > > >  #include <net/netdev_rx_queue.h>
> > > >  #include <net/netdev_queues.h>
> > > > +#include <uapi/linux/virtio_ring.h>
> > >
> > > Why do we need this?
> >
> > for using VIRTIO_RING_F_INDIRECT_DESC
>
> Ok. It's probably a hint that something like layer violation happens.
> A specific driver should not know details about the ring layout ...
>
> >
> >
> > >
> > > >
> > > >  static int napi_weight =3D NAPI_POLL_WEIGHT;
> > > >  module_param(napi_weight, int, 0444);
> > > > @@ -276,6 +277,26 @@ struct virtnet_rq_dma {
> > > >         u16 need_sync;
> > > >  };
> > > >
> > > > +struct virtnet_sq_dma {
> > > > +       union {
> > > > +               struct llist_node node;
> > > > +               struct llist_head head;
> > >
> > > If we want to cap the #dmas, could we simply use an array instead of
> > > the list here?
> > >
> > > > +               void *data;
> > > > +       };
> > > > +       dma_addr_t addr;
> > > > +       u32 len;
> > > > +       u8 num;
> > > > +};
> > > > +
> > > > +struct virtnet_sq_dma_info {
> > > > +       /* record for kfree */
> > > > +       void *p;
> > > > +
> > > > +       u32 free_num;
> > > > +
> > > > +       struct llist_head free;
> > > > +};
> > > > +
> > > >  /* Internal representation of a send virtqueue */
> > > >  struct send_queue {
> > > >         /* Virtqueue associated with this send _queue */
> > > > @@ -295,6 +316,11 @@ struct send_queue {
> > > >
> > > >         /* Record whether sq is in reset state. */
> > > >         bool reset;
> > > > +
> > > > +       /* SQ is premapped mode or not. */
> > > > +       bool premapped;
> > > > +
> > > > +       struct virtnet_sq_dma_info dmainfo;
> > > >  };
> > > >
> > > >  /* Internal representation of a receive virtqueue */
> > > > @@ -492,9 +518,11 @@ static void virtnet_sq_free_unused_buf(struct =
virtqueue *vq, void *buf);
> > > >  enum virtnet_xmit_type {
> > > >         VIRTNET_XMIT_TYPE_SKB,
> > > >         VIRTNET_XMIT_TYPE_XDP,
> > > > +       VIRTNET_XMIT_TYPE_DMA,
> > >
> > > I think the name is confusing, how about TYPE_PREMAPPED?
> > >
> > > >  };
> > > >
> > > > -#define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XM=
IT_TYPE_XDP)
> > > > +#define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XM=
IT_TYPE_XDP \
> > > > +                               | VIRTNET_XMIT_TYPE_DMA)
> > > >
> > > >  static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)
> > > >  {
> > > > @@ -510,12 +538,180 @@ static void *virtnet_xmit_ptr_mix(void *ptr,=
 enum virtnet_xmit_type type)
> > > >         return (void *)((unsigned long)ptr | type);
> > > >  }
> > > >
> > > > +static void virtnet_sq_unmap(struct send_queue *sq, void **data)
> > > > +{
> > > > +       struct virtnet_sq_dma *head, *tail, *p;
> > > > +       int i;
> > > > +
> > > > +       head =3D *data;
> > > > +
> > > > +       p =3D head;
> > > > +
> > > > +       for (i =3D 0; i < head->num; ++i) {
> > > > +               virtqueue_dma_unmap_page_attrs(sq->vq, p->addr, p->=
len,
> > > > +                                              DMA_TO_DEVICE, 0);
> > > > +               tail =3D p;
> > > > +               p =3D llist_entry(llist_next(&p->node), struct virt=
net_sq_dma, node);
> > > > +       }
> > > > +
> > > > +       *data =3D tail->data;
> > > > +
> > > > +       __llist_add_batch(&head->node, &tail->node,  &sq->dmainfo.f=
ree);
> > > > +
> > > > +       sq->dmainfo.free_num +=3D head->num;
> > > > +}
> > > > +
> > > > +static void *virtnet_dma_chain_update(struct send_queue *sq,
> > > > +                                     struct virtnet_sq_dma *head,
> > > > +                                     struct virtnet_sq_dma *tail,
> > > > +                                     u8 num, void *data)
> > > > +{
> > > > +       sq->dmainfo.free_num -=3D num;
> > > > +       head->num =3D num;
> > > > +
> > > > +       tail->data =3D data;
> > > > +
> > > > +       return virtnet_xmit_ptr_mix(head, VIRTNET_XMIT_TYPE_DMA);
> > > > +}
> > > > +
> > > > +static struct virtnet_sq_dma *virtnet_sq_map_sg(struct send_queue =
*sq, int num, void *data)
> > > > +{
> > > > +       struct virtnet_sq_dma *head =3D NULL, *p =3D NULL;
> > > > +       struct scatterlist *sg;
> > > > +       dma_addr_t addr;
> > > > +       int i, err;
> > > > +
> > > > +       if (num > sq->dmainfo.free_num)
> > > > +               return NULL;
> > > > +
> > > > +       for (i =3D 0; i < num; ++i) {
> > > > +               sg =3D &sq->sg[i];
> > > > +
> > > > +               addr =3D virtqueue_dma_map_page_attrs(sq->vq, sg_pa=
ge(sg),
> > > > +                                                   sg->offset,
> > > > +                                                   sg->length, DMA=
_TO_DEVICE,
> > > > +                                                   0);
> > > > +               err =3D virtqueue_dma_mapping_error(sq->vq, addr);
> > > > +               if (err)
> > > > +                       goto err;
> > > > +
> > > > +               sg->dma_address =3D addr;
> > > > +
> > > > +               p =3D llist_entry(llist_del_first(&sq->dmainfo.free=
),
> > > > +                               struct virtnet_sq_dma, node);
> > > > +
> > > > +               p->addr =3D sg->dma_address;
> > > > +               p->len =3D sg->length;
> > >
> > > I may miss something, but I don't see how we cap the total number of =
dmainfos.
> >
> > static void *virtnet_dma_chain_update(struct send_queue *sq,
> >                                      struct virtnet_sq_dma *head,
> >                                      struct virtnet_sq_dma *tail,
> >                                      u8 num, void *data)
> > {
> >        sq->dmainfo.free_num -=3D num;
> > ->       head->num =3D num;
> >
> >        tail->data =3D data;
> >
> >        return virtnet_xmit_ptr_mix(head, VIRTNET_XMIT_TYPE_DMA);
> > }
>
> Ok, speak too fast I guess it should be more like:
>
>  if (num > sq->dmainfo.free_num)
>                return NULL;
>
> Thanks
>
> >
> >
> >
> > Thanks.
> >
> > >
> > > Thanks
> > >
> >


