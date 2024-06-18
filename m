Return-Path: <bpf+bounces-32363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2A590C151
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 03:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12B89B21725
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 01:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4FD13AD8;
	Tue, 18 Jun 2024 01:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="osGOljmg"
X-Original-To: bpf@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210E64C6D;
	Tue, 18 Jun 2024 01:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718674560; cv=none; b=gTEtCcjaMaewOV01fWdCq2+7+9OMu6t8cCLxZusTfOVs0CdNCko7nwSc47ZDHI8YqTzb5M2QuafEQwhGwHLnpV6oMDkFAYW2jhBJOx2s+CBmLODomKix7TkZ1DgvVzm76RMPRJYMzoAE3Kq56UxAncm6rtXOq+LCBZZKP1mHMis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718674560; c=relaxed/simple;
	bh=9sIrpHhqzbljKBweO1zZyfe8Jh3oFpiEElL0iEAuvBA=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=rBWEjDWuO+fFe7eZFc+CMTG3moYxM57hxUUNdJpHIKT6O6DwDGHe3kxT2B6UEVEepbDGYKuJg8Mcd9TNCh/Y7uw0wziHWEy0+0E3cqVMIYFoVmFruJtHgJGqnipkC7kOjI/DLAJyw/X96iR6Pl4xgP8ZiGiErTKxXvhA6w5Josw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=osGOljmg; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718674554; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=0z5qdwS0T6arSmcf0UnOaxxsuUxJ+ak/sBo1d+8WJ1M=;
	b=osGOljmgAP0r2ExkkngRhv0xVH54DBhkWbKBqr4nuq+pb3bu9qQlcrz5bBqw1sTBrAYOLaKtUOnEbZPFgrAXhIjCQF+tZewqDXD0oVOKhlFajAWuExwrmPtqGgaA5DmRkEpr8QWYGd9XnMzkfdHf2RfzwNXosJs6N8DSJKqtLj4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W8hwAXk_1718674553;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8hwAXk_1718674553)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 09:35:54 +0800
Message-ID: <1718674455.8696394-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 08/15] virtio_net: sq support premapped mode
Date: Tue, 18 Jun 2024 09:34:15 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
 <20240614063933.108811-9-xuanzhuo@linux.alibaba.com>
 <CACGkMEu49yaJ+ZBAqP_e1T7kw-9GV8rKMeT1=GtG08ty52XWMw@mail.gmail.com>
 <1718609026.3881757-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEvLv8g7BHC2Dhy_BsrcUxshaY=49DhFJDz7uqw-AH0GXg@mail.gmail.com>
In-Reply-To: <CACGkMEvLv8g7BHC2Dhy_BsrcUxshaY=49DhFJDz7uqw-AH0GXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Tue, 18 Jun 2024 08:57:52 +0800, Jason Wang <jasowang@redhat.com> wrote:
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


But the blk device did the same thing.


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


static struct virtnet_sq_dma *virtnet_sq_map_sg(struct send_queue *sq, int =
num, void *data)
{
       struct virtnet_sq_dma *head =3D NULL, *p =3D NULL;
       struct scatterlist *sg;
       dma_addr_t addr;
       int i, err;

       if (num > sq->dmainfo.free_num)
               return NULL;

Do you mean this?

Thanks.

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
>

