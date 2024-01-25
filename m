Return-Path: <bpf+bounces-20304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0731783B9F1
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 07:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CFF71F2678F
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 06:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE4E1BDC3;
	Thu, 25 Jan 2024 06:30:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684F06FAE;
	Thu, 25 Jan 2024 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164208; cv=none; b=Nz5vUoD5W/rVz/CTs+6dk1lmbN2vrA4tuQHQ6Kb+sprFRvHLeA8BQNGqUeAkMiZJI9SKFH7nDClWAXb/MO64sVuLs8sKQ8E6oQCZxwaSUETIYxCc3yLjWljYc9zsfv7veJpDbzXI6l5SjjfkI8MqfxsUTzhBuRlyoty+0l/jKNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164208; c=relaxed/simple;
	bh=DHppIuKbF41hC6h0/0j3U/Gvfh3ii+AG6+sdDt/JK2A=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=lrQXscRJei++hLbQ+HsGO75QhV48sBj9QTYerlPhTs81Jjlyn8vLqZDF/cwz5rJDscMhwKzciZdXtf85UQ3nPrhPTnqtJQg2ayH9F86M13MCO7H6uI8na/fhVIC32tVizCKYmAfV3iuk5CwUWxVwBICgAPh+vuJUBF2gqwRjmsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W.JHEX3_1706163882;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.JHEX3_1706163882)
          by smtp.aliyun-inc.com;
          Thu, 25 Jan 2024 14:24:42 +0800
Message-ID: <1706162331.1486428-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 5/5] virtio_net: sq support premapped mode
Date: Thu, 25 Jan 2024 13:58:51 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
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
References: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com>
 <20240116075924.42798-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEujO6EdmY_b2wPgG1uBo0DEWhLh81aEX4DHGMfCU7tzUw@mail.gmail.com>
In-Reply-To: <CACGkMEujO6EdmY_b2wPgG1uBo0DEWhLh81aEX4DHGMfCU7tzUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Thu, 25 Jan 2024 11:39:20 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Jan 16, 2024 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > If the xsk is enabling, the xsk tx will share the send queue.
>
> Any reason for this? Technically, virtio-net can work as other NIC
> like 256 queues. There could be some work like optimizing the
> interrupt allocations etc.

Just like the logic of XDP_TX.

Now the virtio spec does not allow to add new dynamic queues.
As I know, most hypervisors just support few queues. The num of
queues is not bigger than the cpu num. So the best way is
to share the send queues.

Parav and I tried to introduce dynamic queues. But that is dropped.
Before that I think we can share the send queues.


>
> > But the xsk requires that the send queue use the premapped mode.
> > So the send queue must support premapped mode.
> >
> > command: pktgen_sample01_simple.sh -i eth0 -s 16/1400 -d 10.0.0.123 -m =
00:16:3e:12:e1:3e -n 0 -p 100
> > machine:  ecs.ebmg6e.26xlarge of Aliyun
> > cpu: Intel(R) Xeon(R) Platinum 8269CY CPU @ 2.50GHz
> > iommu mode: intel_iommu=3Don iommu.strict=3D1 iommu=3Dnopt
> >
> >                       |        iommu off           |        iommu on
> > ----------------------|------------------------------------------------=
-----
> >                       | 16         |  1400         | 16         | 1400
> > ----------------------|------------------------------------------------=
-----
> > Before:               |1716796.00  |  1581829.00   | 390756.00  | 37449=
3.00
> > After(premapped off): |1733794.00  |  1576259.00   | 390189.00  | 37812=
8.00
> > After(premapped on):  |1707107.00  |  1562917.00   | 385667.00  | 37358=
4.00
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio/main.c       | 119 ++++++++++++++++++++++++++++----
> >  drivers/net/virtio/virtio_net.h |  10 ++-
> >  2 files changed, 116 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > index 4fbf612da235..53143f95a3a0 100644
> > --- a/drivers/net/virtio/main.c
> > +++ b/drivers/net/virtio/main.c
> > @@ -168,13 +168,39 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
> >         return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FL=
AG);
> >  }
> >
> > +static void virtnet_sq_unmap_buf(struct virtnet_sq *sq, struct virtio_=
dma_head *dma)
> > +{
> > +       int i;
> > +
> > +       if (!dma)
> > +               return;
> > +
> > +       for (i =3D 0; i < dma->next; ++i)
> > +               virtqueue_dma_unmap_single_attrs(sq->vq,
> > +                                                dma->items[i].addr,
> > +                                                dma->items[i].length,
> > +                                                DMA_TO_DEVICE, 0);
> > +       dma->next =3D 0;
> > +}
> > +
> >  static void __free_old_xmit(struct virtnet_sq *sq, bool in_napi,
> >                             u64 *bytes, u64 *packets)
> >  {
> > +       struct virtio_dma_head *dma;
> >         unsigned int len;
> >         void *ptr;
> >
> > -       while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D NULL) {
> > +       if (virtqueue_get_dma_premapped(sq->vq)) {
>
> Any chance this.can be false?

__free_old_xmit is the common path.

The virtqueue_get_dma_premapped() is used to check whether the sq is premap=
ped
mode.

>
> > +               dma =3D &sq->dma.head;
> > +               dma->num =3D ARRAY_SIZE(sq->dma.items);
> > +               dma->next =3D 0;
>
> Btw, I found in the case of RX we have:
>
> virtnet_rq_alloc():
>
>                         alloc_frag->offset =3D sizeof(*dma);
>
> This seems to defeat frag coalescing when the memory is highly
> fragmented or high order allocation is disallowed.
>
> Any idea to solve this?


On the rq premapped pathset, I answered this.

http://lore.kernel.org/all/1692156147.7470396-3-xuanzhuo@linux.alibaba.com

>
> > +       } else {
> > +               dma =3D NULL;
> > +       }
> > +
> > +       while ((ptr =3D virtqueue_get_buf_ctx_dma(sq->vq, &len, dma, NU=
LL)) !=3D NULL) {
> > +               virtnet_sq_unmap_buf(sq, dma);
> > +
> >                 if (!is_xdp_frame(ptr)) {
> >                         struct sk_buff *skb =3D ptr;
> >
> > @@ -572,16 +598,70 @@ static void *virtnet_rq_alloc(struct virtnet_rq *=
rq, u32 size, gfp_t gfp)
> >         return buf;
> >  }
> >
> > -static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> > +static void virtnet_set_premapped(struct virtnet_info *vi)
> >  {
> >         int i;
> >
> > -       /* disable for big mode */
> > -       if (!vi->mergeable_rx_bufs && vi->big_packets)
> > -               return;
> > +       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > +               virtqueue_set_dma_premapped(vi->sq[i].vq);
> >
> > -       for (i =3D 0; i < vi->max_queue_pairs; i++)
> > -               virtqueue_set_dma_premapped(vi->rq[i].vq);
> > +               /* TODO for big mode */
>
> Btw, how hard to support big mode? If we can do premapping for that
> code could be simplified.
>
> (There are vendors that doesn't support mergeable rx buffers).

I will do that after these patch-sets

>
> > +               if (vi->mergeable_rx_bufs || !vi->big_packets)
> > +                       virtqueue_set_dma_premapped(vi->rq[i].vq);
> > +       }
> > +}
> > +
> > +static void virtnet_sq_unmap_sg(struct virtnet_sq *sq, u32 num)
> > +{
> > +       struct scatterlist *sg;
> > +       u32 i;
> > +
> > +       for (i =3D 0; i < num; ++i) {
> > +               sg =3D &sq->sg[i];
> > +
> > +               virtqueue_dma_unmap_single_attrs(sq->vq,
> > +                                                sg->dma_address,
> > +                                                sg->length,
> > +                                                DMA_TO_DEVICE, 0);
> > +       }
> > +}
> > +
> > +static int virtnet_sq_map_sg(struct virtnet_sq *sq, u32 num)
> > +{
> > +       struct scatterlist *sg;
> > +       u32 i;
> > +
> > +       for (i =3D 0; i < num; ++i) {
> > +               sg =3D &sq->sg[i];
> > +               sg->dma_address =3D virtqueue_dma_map_single_attrs(sq->=
vq, sg_virt(sg),
> > +                                                                sg->le=
ngth,
> > +                                                                DMA_TO=
_DEVICE, 0);
> > +               if (virtqueue_dma_mapping_error(sq->vq, sg->dma_address=
))
> > +                       goto err;
> > +       }
> > +
>
> This seems nothing virtio-net specific, let's move it to the core?


This is the dma api style.

And the caller can not judge it by the return value of
virtqueue_dma_map_single_attrs.

Thanks


>
> Thanks
>
>
> > +       return 0;
> > +
> > +err:
> > +       virtnet_sq_unmap_sg(sq, i);
> > +       return -ENOMEM;
> > +}
> > +
> > +static int virtnet_add_outbuf(struct virtnet_sq *sq, u32 num, void *da=
ta)
> > +{
> > +       int ret;
> > +
> > +       if (virtqueue_get_dma_premapped(sq->vq)) {
> > +               ret =3D virtnet_sq_map_sg(sq, num);
> > +               if (ret)
> > +                       return -ENOMEM;
> > +       }
> > +
> > +       ret =3D virtqueue_add_outbuf(sq->vq, sq->sg, num, data, GFP_ATO=
MIC);
> > +       if (ret && virtqueue_get_dma_premapped(sq->vq))
> > +               virtnet_sq_unmap_sg(sq, num);
> > +
> > +       return ret;
> >  }
> >
> >  static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
> > @@ -687,8 +767,7 @@ static int __virtnet_xdp_xmit_one(struct virtnet_in=
fo *vi,
> >                             skb_frag_size(frag), skb_frag_off(frag));
> >         }
> >
> > -       err =3D virtqueue_add_outbuf(sq->vq, sq->sg, nr_frags + 1,
> > -                                  xdp_to_ptr(xdpf), GFP_ATOMIC);
> > +       err =3D virtnet_add_outbuf(sq, nr_frags + 1, xdp_to_ptr(xdpf));
> >         if (unlikely(err))
> >                 return -ENOSPC; /* Caller handle free/refcnt */
> >
> > @@ -2154,7 +2233,7 @@ static int xmit_skb(struct virtnet_sq *sq, struct=
 sk_buff *skb)
> >                         return num_sg;
> >                 num_sg++;
> >         }
> > -       return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_AT=
OMIC);
> > +       return virtnet_add_outbuf(sq, num_sg, skb);
> >  }
> >
> >  static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *=
dev)
> > @@ -4011,9 +4090,25 @@ static void free_receive_page_frags(struct virtn=
et_info *vi)
> >
> >  static void virtnet_sq_free_unused_bufs(struct virtqueue *vq)
> >  {
> > +       struct virtnet_info *vi =3D vq->vdev->priv;
> > +       struct virtio_dma_head *dma;
> > +       struct virtnet_sq *sq;
> > +       int i =3D vq2txq(vq);
> >         void *buf;
> >
> > -       while ((buf =3D virtqueue_detach_unused_buf(vq)) !=3D NULL) {
> > +       sq =3D &vi->sq[i];
> > +
> > +       if (virtqueue_get_dma_premapped(sq->vq)) {
> > +               dma =3D &sq->dma.head;
> > +               dma->num =3D ARRAY_SIZE(sq->dma.items);
> > +               dma->next =3D 0;
> > +       } else {
> > +               dma =3D NULL;
> > +       }
> > +
> > +       while ((buf =3D virtqueue_detach_unused_buf_dma(vq, dma)) !=3D =
NULL) {
> > +               virtnet_sq_unmap_buf(sq, dma);
> > +
> >                 if (!is_xdp_frame(buf))
> >                         dev_kfree_skb(buf);
> >                 else
> > @@ -4228,7 +4323,7 @@ static int init_vqs(struct virtnet_info *vi)
> >         if (ret)
> >                 goto err_free;
> >
> > -       virtnet_rq_set_premapped(vi);
> > +       virtnet_set_premapped(vi);
> >
> >         cpus_read_lock();
> >         virtnet_set_affinity(vi);
> > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virti=
o_net.h
> > index 066a2b9d2b3c..dda144cc91c7 100644
> > --- a/drivers/net/virtio/virtio_net.h
> > +++ b/drivers/net/virtio/virtio_net.h
> > @@ -48,13 +48,21 @@ struct virtnet_rq_dma {
> >         u16 need_sync;
> >  };
> >
> > +struct virtnet_sq_dma {
> > +       struct virtio_dma_head head;
> > +       struct virtio_dma_item items[MAX_SKB_FRAGS + 2];
> > +};
> > +
> >  /* Internal representation of a send virtqueue */
> >  struct virtnet_sq {
> >         /* Virtqueue associated with this virtnet_sq */
> >         struct virtqueue *vq;
> >
> >         /* TX: fragments + linear part + virtio header */
> > -       struct scatterlist sg[MAX_SKB_FRAGS + 2];
> > +       union {
> > +               struct scatterlist sg[MAX_SKB_FRAGS + 2];
> > +               struct virtnet_sq_dma dma;
> > +       };
> >
> >         /* Name of the send queue: output.$index */
> >         char name[16];
> > --
> > 2.32.0.3.g01195cf9f
> >
>

