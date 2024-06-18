Return-Path: <bpf+bounces-32357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D7990C0D2
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 02:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6241F225B3
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 00:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDDF6AC0;
	Tue, 18 Jun 2024 00:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMD7MnFu"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759CDC8E9
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 00:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718672289; cv=none; b=oSsvGkLDQnaxNGX+sJu2PMmeTr1qVLGb7u5p9CEPr2bHcy1jVWcnmyALh1HIM9UTK/9TQIOdn3LyZ8PGKgFmmnKBsDU3cF4Izbk4YeuPAAlUq7pA5zecvdUZJtDAaeeHgfkCUOaWLnOCAmzCwMb8eBUqA0eGu8+7l1lFR4kNRfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718672289; c=relaxed/simple;
	bh=BcZiEvbUPWAEXb1/HWwVCeV6Dbuj8tN2IOHOXPgW+6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3YYLLlneQ358NBGcUjTfMrJ/RNXmQYNIJd8+SuUUXbSyVBMUXgIBApQOxGUl6XmQSRGBu5VMPopqOdqApJzAcOTAQnOUCGYfb8eB542wRtUttfSaRNgUv3dKPeGqYwQLpwfo57Td4Rhgn+j+aZ9EK6BK89DU0TFuqGxq8O66cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AMD7MnFu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718672286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+okBG7PpWy4DufQEdFfLyzbevb4glnqxJQBbXfup58=;
	b=AMD7MnFuCo/UymqvEAf2dBsEPWqlOKitC5VUKBH9Qnpwtn0QvAbJUkTz535yE95SG6SqHB
	wiPdHhq+OBBltZXYaJfLBgMA095KrKIb/mfIAi0UmKaWng+TMMKRDsTOtA+/BxduX6jY26
	VubH76sq9K4+/E7m/QwZjV0w8Ygcftk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-CDdMXPnDOi6-U93i2SkLAQ-1; Mon, 17 Jun 2024 20:58:05 -0400
X-MC-Unique: CDdMXPnDOi6-U93i2SkLAQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c24109ad3fso5154802a91.0
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 17:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718672284; x=1719277084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+okBG7PpWy4DufQEdFfLyzbevb4glnqxJQBbXfup58=;
        b=C11KrXHB697eii/Rr3q4ZaF28EOtD4YyCyzJDVWfFC+qxIReVbyRkz60Y2HkY0lMEn
         t2eBkPgKEOVnLPwMC7fDEWvV0e6imsZiwol5nrDEAR5s7WgPmmWxkQpThdW8KjulLHjJ
         Eke6/29yHpnPpejylShjMMfv2MdYIVCZvtDYgFTD2j99iU0VwI3yEMOoLWJiU4Ui+TRi
         eMFXJ1cZqJeJGnsd/GdTDGOiXLdWv6chuYItAWx7gOwn+FDw6qDNL5ExX30lZAJNj2K2
         9lEPcUNWOaDi9Fq3X+7txVV+9FIVewQO4lhU7wD4NdrWHs8uHeb2aIx78whDlM2ukTOy
         S/Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXoj8i2vU3ePSWJKZYGsCO8lnk2r4rlu64gBhSucyehCcuW+eqt2Dk+B3vB9NR1UCui8ZNlgTS9ISQbz8edUmkRcY01
X-Gm-Message-State: AOJu0YxIV092raleWlh0O9hZIHTZkKazBpfOHV55fsbWAO9c3K+UXU6D
	1bq6IUhpFRXuEmKLafvTCKWzSCWZq4dab0eL9PVTzCTJeaxf8+T2PeFarfWDsEDBD1ZkH8VFI2c
	rNvfrvAQqkVS/z7PO53dCsCkhk3sIoCf7i0fp8EEdW6Kkk/1wF4xhcVplpXwtkrHUfbORnOFLX8
	jZJ7HAofXdhmv4LWr8uUecbEj7
X-Received: by 2002:a17:90a:d710:b0:2c2:dd0b:3d78 with SMTP id 98e67ed59e1d1-2c4db242536mr2409802a91.18.1718672283888;
        Mon, 17 Jun 2024 17:58:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFInXJzYplRO3ASLqLbn+uSgyN6soGHyPycPHBS3eUTSuLbgFdWsMgokUAZDHLUU+Qcszixp8pt/1/YhZVZ20=
X-Received: by 2002:a17:90a:d710:b0:2c2:dd0b:3d78 with SMTP id
 98e67ed59e1d1-2c4db242536mr2409782a91.18.1718672283464; Mon, 17 Jun 2024
 17:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
 <20240614063933.108811-9-xuanzhuo@linux.alibaba.com> <CACGkMEu49yaJ+ZBAqP_e1T7kw-9GV8rKMeT1=GtG08ty52XWMw@mail.gmail.com>
 <1718609026.3881757-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1718609026.3881757-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Jun 2024 08:57:52 +0800
Message-ID: <CACGkMEvLv8g7BHC2Dhy_BsrcUxshaY=49DhFJDz7uqw-AH0GXg@mail.gmail.com>
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

On Mon, Jun 17, 2024 at 3:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Mon, 17 Jun 2024 13:00:13 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Fri, Jun 14, 2024 at 2:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > If the xsk is enabling, the xsk tx will share the send queue.
> > > But the xsk requires that the send queue use the premapped mode.
> > > So the send queue must support premapped mode when it is bound to
> > > af-xdp.
> > >
> > > * virtnet_sq_set_premapped(sq, true) is used to enable premapped mode=
.
> > >
> > >     In this mode, the driver will record the dma info when skb or xdp
> > >     frame is sent.
> > >
> > >     Currently, the SQ premapped mode is operational only with af-xdp.=
 In
> > >     this mode, af-xdp, the kernel stack, and xdp tx/redirect will sha=
re
> > >     the same SQ. Af-xdp independently manages its DMA. The kernel sta=
ck
> > >     and xdp tx/redirect utilize this DMA metadata to manage the DMA
> > >     info.
> > >
> > >     If the indirect descriptor feature be supported, the volume of DM=
A
> > >     details we need to maintain becomes quite substantial. Here, we h=
ave
> > >     a cap on the amount of DMA info we manage.
> > >
> > >     If the kernel stack and xdp tx/redirect attempt to use more
> > >     descriptors, virtnet_add_outbuf() will return an -ENOMEM error. B=
ut
> > >     the af-xdp can work continually.
> >
> > Rethink of this whole logic, it looks like all the complication came
> > as we decided to go with a pre queue pre mapping flag. I wonder if
> > things could be simplified if we do that per buffer?
>
> YES. That will be simply.
>
> Then this patch will be not needed. The virtio core must record the prema=
pped
> imfo to the virtio ring state or extra.
>
>          http://lore.kernel.org/all/20230517022249.20790-6-xuanzhuo@linux=
.alibaba.com

Yes, something like this. I think it's worthwhile to re-consider that
approach. If my memory is correct, we haven't spotted the complicated
issues we need to deal with like this patch.

>
> >
> > Then we don't need complex logic like dmainfo and cap.
>
> So the premapped mode and the internal dma mode can coexist.
> Then we do not need to make the sq to support the premapped mode.

Probably.

>
>
> >
> > >
> > > * virtnet_sq_set_premapped(sq, false) is used to disable premapped mo=
de.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 228 +++++++++++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 224 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index e84a4624549b..88ab9ea1646f 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -25,6 +25,7 @@
> > >  #include <net/net_failover.h>
> > >  #include <net/netdev_rx_queue.h>
> > >  #include <net/netdev_queues.h>
> > > +#include <uapi/linux/virtio_ring.h>
> >
> > Why do we need this?
>
> for using VIRTIO_RING_F_INDIRECT_DESC

Ok. It's probably a hint that something like layer violation happens.
A specific driver should not know details about the ring layout ...

>
>
> >
> > >
> > >  static int napi_weight =3D NAPI_POLL_WEIGHT;
> > >  module_param(napi_weight, int, 0444);
> > > @@ -276,6 +277,26 @@ struct virtnet_rq_dma {
> > >         u16 need_sync;
> > >  };
> > >
> > > +struct virtnet_sq_dma {
> > > +       union {
> > > +               struct llist_node node;
> > > +               struct llist_head head;
> >
> > If we want to cap the #dmas, could we simply use an array instead of
> > the list here?
> >
> > > +               void *data;
> > > +       };
> > > +       dma_addr_t addr;
> > > +       u32 len;
> > > +       u8 num;
> > > +};
> > > +
> > > +struct virtnet_sq_dma_info {
> > > +       /* record for kfree */
> > > +       void *p;
> > > +
> > > +       u32 free_num;
> > > +
> > > +       struct llist_head free;
> > > +};
> > > +
> > >  /* Internal representation of a send virtqueue */
> > >  struct send_queue {
> > >         /* Virtqueue associated with this send _queue */
> > > @@ -295,6 +316,11 @@ struct send_queue {
> > >
> > >         /* Record whether sq is in reset state. */
> > >         bool reset;
> > > +
> > > +       /* SQ is premapped mode or not. */
> > > +       bool premapped;
> > > +
> > > +       struct virtnet_sq_dma_info dmainfo;
> > >  };
> > >
> > >  /* Internal representation of a receive virtqueue */
> > > @@ -492,9 +518,11 @@ static void virtnet_sq_free_unused_buf(struct vi=
rtqueue *vq, void *buf);
> > >  enum virtnet_xmit_type {
> > >         VIRTNET_XMIT_TYPE_SKB,
> > >         VIRTNET_XMIT_TYPE_XDP,
> > > +       VIRTNET_XMIT_TYPE_DMA,
> >
> > I think the name is confusing, how about TYPE_PREMAPPED?
> >
> > >  };
> > >
> > > -#define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT=
_TYPE_XDP)
> > > +#define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT=
_TYPE_XDP \
> > > +                               | VIRTNET_XMIT_TYPE_DMA)
> > >
> > >  static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)
> > >  {
> > > @@ -510,12 +538,180 @@ static void *virtnet_xmit_ptr_mix(void *ptr, e=
num virtnet_xmit_type type)
> > >         return (void *)((unsigned long)ptr | type);
> > >  }
> > >
> > > +static void virtnet_sq_unmap(struct send_queue *sq, void **data)
> > > +{
> > > +       struct virtnet_sq_dma *head, *tail, *p;
> > > +       int i;
> > > +
> > > +       head =3D *data;
> > > +
> > > +       p =3D head;
> > > +
> > > +       for (i =3D 0; i < head->num; ++i) {
> > > +               virtqueue_dma_unmap_page_attrs(sq->vq, p->addr, p->le=
n,
> > > +                                              DMA_TO_DEVICE, 0);
> > > +               tail =3D p;
> > > +               p =3D llist_entry(llist_next(&p->node), struct virtne=
t_sq_dma, node);
> > > +       }
> > > +
> > > +       *data =3D tail->data;
> > > +
> > > +       __llist_add_batch(&head->node, &tail->node,  &sq->dmainfo.fre=
e);
> > > +
> > > +       sq->dmainfo.free_num +=3D head->num;
> > > +}
> > > +
> > > +static void *virtnet_dma_chain_update(struct send_queue *sq,
> > > +                                     struct virtnet_sq_dma *head,
> > > +                                     struct virtnet_sq_dma *tail,
> > > +                                     u8 num, void *data)
> > > +{
> > > +       sq->dmainfo.free_num -=3D num;
> > > +       head->num =3D num;
> > > +
> > > +       tail->data =3D data;
> > > +
> > > +       return virtnet_xmit_ptr_mix(head, VIRTNET_XMIT_TYPE_DMA);
> > > +}
> > > +
> > > +static struct virtnet_sq_dma *virtnet_sq_map_sg(struct send_queue *s=
q, int num, void *data)
> > > +{
> > > +       struct virtnet_sq_dma *head =3D NULL, *p =3D NULL;
> > > +       struct scatterlist *sg;
> > > +       dma_addr_t addr;
> > > +       int i, err;
> > > +
> > > +       if (num > sq->dmainfo.free_num)
> > > +               return NULL;
> > > +
> > > +       for (i =3D 0; i < num; ++i) {
> > > +               sg =3D &sq->sg[i];
> > > +
> > > +               addr =3D virtqueue_dma_map_page_attrs(sq->vq, sg_page=
(sg),
> > > +                                                   sg->offset,
> > > +                                                   sg->length, DMA_T=
O_DEVICE,
> > > +                                                   0);
> > > +               err =3D virtqueue_dma_mapping_error(sq->vq, addr);
> > > +               if (err)
> > > +                       goto err;
> > > +
> > > +               sg->dma_address =3D addr;
> > > +
> > > +               p =3D llist_entry(llist_del_first(&sq->dmainfo.free),
> > > +                               struct virtnet_sq_dma, node);
> > > +
> > > +               p->addr =3D sg->dma_address;
> > > +               p->len =3D sg->length;
> >
> > I may miss something, but I don't see how we cap the total number of dm=
ainfos.
>
> static void *virtnet_dma_chain_update(struct send_queue *sq,
>                                      struct virtnet_sq_dma *head,
>                                      struct virtnet_sq_dma *tail,
>                                      u8 num, void *data)
> {
>        sq->dmainfo.free_num -=3D num;
> ->       head->num =3D num;
>
>        tail->data =3D data;
>
>        return virtnet_xmit_ptr_mix(head, VIRTNET_XMIT_TYPE_DMA);
> }

Ok, speak too fast I guess it should be more like:

 if (num > sq->dmainfo.free_num)
               return NULL;

Thanks

>
>
>
> Thanks.
>
> >
> > Thanks
> >
>


