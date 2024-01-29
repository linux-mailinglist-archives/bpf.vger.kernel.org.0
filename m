Return-Path: <bpf+bounces-20539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 725A883FCBD
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 04:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2967428303E
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 03:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B5F101EE;
	Mon, 29 Jan 2024 03:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ENBWkwkn"
X-Original-To: bpf@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7078DFC12;
	Mon, 29 Jan 2024 03:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706498932; cv=none; b=uvrmyZgjZFlbEnjRRliQ8E1L1vhofNgxtCsccLESdmjtiDLjySSsR7xFWZqPH+VJJ+mZSBGYIlAkZfgRl92wSGwIPkQZA3BBRH+JohgoV3mcta1GW+pHS5v4jY1dQ3PqG41EK1IKa7zIAtZ/PFvXCTvZNuRLhN4kPg4agqhUCps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706498932; c=relaxed/simple;
	bh=NdAhBcMFgn1xF9S6gCSnyJgaDNGlgBMiF94UmuonfG0=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=Fs7tw01n3Sz16B0qbFrZ0QghDm9lppupUTESC8fPNGp1c6G9iI5fETRZGFziMw4/J+ObFdw8e75mG9Aote0iow/rWynL7no9k9Tdn9PQMF4iuNsilHZ5NUupK+KCL+gwWEcqx03RBmkzO6VYDX2uHx9KLok+qXJl0uKmm0rmjl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ENBWkwkn; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706498920; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=ik1nI6uTT9SB0d2nqai/CGdKG3c+vxHq140YSTgcSSc=;
	b=ENBWkwknv7hDC/WSzzgwFTSkESgZBm4OO/oquXr5qcj1gkTe8O0XzWsjOpRKHZ99Pgdo7YTKfh/Q5fLyniO+eLFfwFPM4W5rjib6s0tzNwPNHF+hxOKUOTKnVxMK8ioGhRiMNJhDhcn6DVuSi4wnDDM3Zigui/K8iVSlHGPlSaM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W.UEPwK_1706498919;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.UEPwK_1706498919)
          by smtp.aliyun-inc.com;
          Mon, 29 Jan 2024 11:28:39 +0800
Message-ID: <1706497888.0777724-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 5/5] virtio_net: sq support premapped mode
Date: Mon, 29 Jan 2024 11:11:28 +0800
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
 <1706162331.1486428-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEvk7eiq6HKzoqHqmQ0DTuK-3tbc5r5rro1unyKYM61mMg@mail.gmail.com>
In-Reply-To: <CACGkMEvk7eiq6HKzoqHqmQ0DTuK-3tbc5r5rro1unyKYM61mMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Mon, 29 Jan 2024 11:06:35 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Thu, Jan 25, 2024 at 2:24=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Thu, 25 Jan 2024 11:39:20 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Tue, Jan 16, 2024 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > If the xsk is enabling, the xsk tx will share the send queue.
> > >
> > > Any reason for this? Technically, virtio-net can work as other NIC
> > > like 256 queues. There could be some work like optimizing the
> > > interrupt allocations etc.
> >
> > Just like the logic of XDP_TX.
> >
> > Now the virtio spec does not allow to add new dynamic queues.
> > As I know, most hypervisors just support few queues.
>
> When multiqueue is developed in Qemu, it support as least 256 queue
> pairs if my memory is correct.
>


YES, but that is configured by the hypervisor.

For the user on any platform, when he got a vm, the queue num is fixed.
As I know, on most case, the num is less.
If we want the af-xdp/xdp-tx has the the independent queues
I think the dynamic queue is good way.


> > The num of
> > queues is not bigger than the cpu num. So the best way is
> > to share the send queues.
> >
> > Parav and I tried to introduce dynamic queues.
>
> Virtio-net doesn't differ from real NIC where most of them can create
> queue dynamically. It's more about the resource allocation, if mgmt
> can start with 256 queues, then we probably fine.

But now, if the devices has 256, we will enable the 256 queues by default.
that is too much.

So, the dynamic queue is not to create a new queue out of the resource.

The device may tell the driver, the max queue resource is 256,
but let we start from 8. If the driver need more, then we can
enable more.

But for me, the xdp tx can share the sq queue, so let we start
the af-xdp from sharing sq queue.


>
> But I think we can leave this question now.
>
> > But that is dropped.
> > Before that I think we can share the send queues.
> >
> >
> > >
> > > > But the xsk requires that the send queue use the premapped mode.
> > > > So the send queue must support premapped mode.
> > > >
> > > > command: pktgen_sample01_simple.sh -i eth0 -s 16/1400 -d 10.0.0.123=
 -m 00:16:3e:12:e1:3e -n 0 -p 100
> > > > machine:  ecs.ebmg6e.26xlarge of Aliyun
> > > > cpu: Intel(R) Xeon(R) Platinum 8269CY CPU @ 2.50GHz
> > > > iommu mode: intel_iommu=3Don iommu.strict=3D1 iommu=3Dnopt
> > > >
> > > >                       |        iommu off           |        iommu on
> > > > ----------------------|--------------------------------------------=
---------
> > > >                       | 16         |  1400         | 16         | 1=
400
> > > > ----------------------|--------------------------------------------=
---------
> > > > Before:               |1716796.00  |  1581829.00   | 390756.00  | 3=
74493.00
> > > > After(premapped off): |1733794.00  |  1576259.00   | 390189.00  | 3=
78128.00
> > > > After(premapped on):  |1707107.00  |  1562917.00   | 385667.00  | 3=
73584.00
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  drivers/net/virtio/main.c       | 119 ++++++++++++++++++++++++++++=
----
> > > >  drivers/net/virtio/virtio_net.h |  10 ++-
> > > >  2 files changed, 116 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > > > index 4fbf612da235..53143f95a3a0 100644
> > > > --- a/drivers/net/virtio/main.c
> > > > +++ b/drivers/net/virtio/main.c
> > > > @@ -168,13 +168,39 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
> > > >         return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XD=
P_FLAG);
> > > >  }
> > > >
> > > > +static void virtnet_sq_unmap_buf(struct virtnet_sq *sq, struct vir=
tio_dma_head *dma)
> > > > +{
> > > > +       int i;
> > > > +
> > > > +       if (!dma)
> > > > +               return;
> > > > +
> > > > +       for (i =3D 0; i < dma->next; ++i)
> > > > +               virtqueue_dma_unmap_single_attrs(sq->vq,
> > > > +                                                dma->items[i].addr,
> > > > +                                                dma->items[i].leng=
th,
> > > > +                                                DMA_TO_DEVICE, 0);
> > > > +       dma->next =3D 0;
> > > > +}
> > > > +
> > > >  static void __free_old_xmit(struct virtnet_sq *sq, bool in_napi,
> > > >                             u64 *bytes, u64 *packets)
> > > >  {
> > > > +       struct virtio_dma_head *dma;
> > > >         unsigned int len;
> > > >         void *ptr;
> > > >
> > > > -       while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D NULL)=
 {
> > > > +       if (virtqueue_get_dma_premapped(sq->vq)) {
> > >
> > > Any chance this.can be false?
> >
> > __free_old_xmit is the common path.
>
> Did you mean the XDP path doesn't work with this? If yes, we need to
> change that.


NO. If the virtio core use_dma_api is false, the dma premapped
can not be ture.

>
> >
> > The virtqueue_get_dma_premapped() is used to check whether the sq is pr=
emapped
> > mode.
> >
> > >
> > > > +               dma =3D &sq->dma.head;
> > > > +               dma->num =3D ARRAY_SIZE(sq->dma.items);
> > > > +               dma->next =3D 0;
> > >
> > > Btw, I found in the case of RX we have:
> > >
> > > virtnet_rq_alloc():
> > >
> > >                         alloc_frag->offset =3D sizeof(*dma);
> > >
> > > This seems to defeat frag coalescing when the memory is highly
> > > fragmented or high order allocation is disallowed.
> > >
> > > Any idea to solve this?
> >
> >
> > On the rq premapped pathset, I answered this.
> >
> > http://lore.kernel.org/all/1692156147.7470396-3-xuanzhuo@linux.alibaba.=
com
>
> Oops, I forget that.
>
> >
> > >
> > > > +       } else {
> > > > +               dma =3D NULL;
> > > > +       }
> > > > +
> > > > +       while ((ptr =3D virtqueue_get_buf_ctx_dma(sq->vq, &len, dma=
, NULL)) !=3D NULL) {
> > > > +               virtnet_sq_unmap_buf(sq, dma);
> > > > +
> > > >                 if (!is_xdp_frame(ptr)) {
> > > >                         struct sk_buff *skb =3D ptr;
> > > >
> > > > @@ -572,16 +598,70 @@ static void *virtnet_rq_alloc(struct virtnet_=
rq *rq, u32 size, gfp_t gfp)
> > > >         return buf;
> > > >  }
> > > >
> > > > -static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> > > > +static void virtnet_set_premapped(struct virtnet_info *vi)
> > > >  {
> > > >         int i;
> > > >
> > > > -       /* disable for big mode */
> > > > -       if (!vi->mergeable_rx_bufs && vi->big_packets)
> > > > -               return;
> > > > +       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > > +               virtqueue_set_dma_premapped(vi->sq[i].vq);
> > > >
> > > > -       for (i =3D 0; i < vi->max_queue_pairs; i++)
> > > > -               virtqueue_set_dma_premapped(vi->rq[i].vq);
> > > > +               /* TODO for big mode */
> > >
> > > Btw, how hard to support big mode? If we can do premapping for that
> > > code could be simplified.
> > >
> > > (There are vendors that doesn't support mergeable rx buffers).
> >
> > I will do that after these patch-sets
>
> If it's not too hard, I'd suggest to do it now.


YES. Is not too hard, but I was doing too much.

* virtio-net + device stats
* virtio-net + af-xdp, this patch set has about 27 commits

And I was pushing this too long, I just want to finish the work.
Then I can work on the next (premapped big mode, af-xdp multi-buf....).

So, let we step by step.


>
> >
> > >
> > > > +               if (vi->mergeable_rx_bufs || !vi->big_packets)
> > > > +                       virtqueue_set_dma_premapped(vi->rq[i].vq);
> > > > +       }
> > > > +}
> > > > +
> > > > +static void virtnet_sq_unmap_sg(struct virtnet_sq *sq, u32 num)
> > > > +{
> > > > +       struct scatterlist *sg;
> > > > +       u32 i;
> > > > +
> > > > +       for (i =3D 0; i < num; ++i) {
> > > > +               sg =3D &sq->sg[i];
> > > > +
> > > > +               virtqueue_dma_unmap_single_attrs(sq->vq,
> > > > +                                                sg->dma_address,
> > > > +                                                sg->length,
> > > > +                                                DMA_TO_DEVICE, 0);
> > > > +       }
> > > > +}
> > > > +
> > > > +static int virtnet_sq_map_sg(struct virtnet_sq *sq, u32 num)
> > > > +{
> > > > +       struct scatterlist *sg;
> > > > +       u32 i;
> > > > +
> > > > +       for (i =3D 0; i < num; ++i) {
> > > > +               sg =3D &sq->sg[i];
> > > > +               sg->dma_address =3D virtqueue_dma_map_single_attrs(=
sq->vq, sg_virt(sg),
> > > > +                                                                sg=
->length,
> > > > +                                                                DM=
A_TO_DEVICE, 0);
> > > > +               if (virtqueue_dma_mapping_error(sq->vq, sg->dma_add=
ress))
> > > > +                       goto err;
> > > > +       }
> > > > +
> > >
> > > This seems nothing virtio-net specific, let's move it to the core?
> >
> >
> > This is the dma api style.
> >
> > And the caller can not judge it by the return value of
> > virtqueue_dma_map_single_attrs.
>
> I meant, if e.g virtio-fs want to use premapped, the code will for
> sure be duplicated there as well.

If you mean this function virtnet_sq_map_sg, I think you are right.

I will put it to the virtio core.

Thanks.




>
> Thanks
>
>
> >
> > Thanks
> >
> >
> > >
> > > Thanks
> > >
> > >
> > > > +       return 0;
> > > > +
> > > > +err:
> > > > +       virtnet_sq_unmap_sg(sq, i);
> > > > +       return -ENOMEM;
> > > > +}
> > > > +
> > > > +static int virtnet_add_outbuf(struct virtnet_sq *sq, u32 num, void=
 *data)
> > > > +{
> > > > +       int ret;
> > > > +
> > > > +       if (virtqueue_get_dma_premapped(sq->vq)) {
> > > > +               ret =3D virtnet_sq_map_sg(sq, num);
> > > > +               if (ret)
> > > > +                       return -ENOMEM;
> > > > +       }
> > > > +
> > > > +       ret =3D virtqueue_add_outbuf(sq->vq, sq->sg, num, data, GFP=
_ATOMIC);
> > > > +       if (ret && virtqueue_get_dma_premapped(sq->vq))
> > > > +               virtnet_sq_unmap_sg(sq, num);
> > > > +
> > > > +       return ret;
> > > >  }
> > > >
> > > >  static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
> > > > @@ -687,8 +767,7 @@ static int __virtnet_xdp_xmit_one(struct virtne=
t_info *vi,
> > > >                             skb_frag_size(frag), skb_frag_off(frag)=
);
> > > >         }
> > > >
> > > > -       err =3D virtqueue_add_outbuf(sq->vq, sq->sg, nr_frags + 1,
> > > > -                                  xdp_to_ptr(xdpf), GFP_ATOMIC);
> > > > +       err =3D virtnet_add_outbuf(sq, nr_frags + 1, xdp_to_ptr(xdp=
f));
> > > >         if (unlikely(err))
> > > >                 return -ENOSPC; /* Caller handle free/refcnt */
> > > >
> > > > @@ -2154,7 +2233,7 @@ static int xmit_skb(struct virtnet_sq *sq, st=
ruct sk_buff *skb)
> > > >                         return num_sg;
> > > >                 num_sg++;
> > > >         }
> > > > -       return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GF=
P_ATOMIC);
> > > > +       return virtnet_add_outbuf(sq, num_sg, skb);
> > > >  }
> > > >
> > > >  static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_devi=
ce *dev)
> > > > @@ -4011,9 +4090,25 @@ static void free_receive_page_frags(struct v=
irtnet_info *vi)
> > > >
> > > >  static void virtnet_sq_free_unused_bufs(struct virtqueue *vq)
> > > >  {
> > > > +       struct virtnet_info *vi =3D vq->vdev->priv;
> > > > +       struct virtio_dma_head *dma;
> > > > +       struct virtnet_sq *sq;
> > > > +       int i =3D vq2txq(vq);
> > > >         void *buf;
> > > >
> > > > -       while ((buf =3D virtqueue_detach_unused_buf(vq)) !=3D NULL)=
 {
> > > > +       sq =3D &vi->sq[i];
> > > > +
> > > > +       if (virtqueue_get_dma_premapped(sq->vq)) {
> > > > +               dma =3D &sq->dma.head;
> > > > +               dma->num =3D ARRAY_SIZE(sq->dma.items);
> > > > +               dma->next =3D 0;
> > > > +       } else {
> > > > +               dma =3D NULL;
> > > > +       }
> > > > +
> > > > +       while ((buf =3D virtqueue_detach_unused_buf_dma(vq, dma)) !=
=3D NULL) {
> > > > +               virtnet_sq_unmap_buf(sq, dma);
> > > > +
> > > >                 if (!is_xdp_frame(buf))
> > > >                         dev_kfree_skb(buf);
> > > >                 else
> > > > @@ -4228,7 +4323,7 @@ static int init_vqs(struct virtnet_info *vi)
> > > >         if (ret)
> > > >                 goto err_free;
> > > >
> > > > -       virtnet_rq_set_premapped(vi);
> > > > +       virtnet_set_premapped(vi);
> > > >
> > > >         cpus_read_lock();
> > > >         virtnet_set_affinity(vi);
> > > > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/v=
irtio_net.h
> > > > index 066a2b9d2b3c..dda144cc91c7 100644
> > > > --- a/drivers/net/virtio/virtio_net.h
> > > > +++ b/drivers/net/virtio/virtio_net.h
> > > > @@ -48,13 +48,21 @@ struct virtnet_rq_dma {
> > > >         u16 need_sync;
> > > >  };
> > > >
> > > > +struct virtnet_sq_dma {
> > > > +       struct virtio_dma_head head;
> > > > +       struct virtio_dma_item items[MAX_SKB_FRAGS + 2];
> > > > +};
> > > > +
> > > >  /* Internal representation of a send virtqueue */
> > > >  struct virtnet_sq {
> > > >         /* Virtqueue associated with this virtnet_sq */
> > > >         struct virtqueue *vq;
> > > >
> > > >         /* TX: fragments + linear part + virtio header */
> > > > -       struct scatterlist sg[MAX_SKB_FRAGS + 2];
> > > > +       union {
> > > > +               struct scatterlist sg[MAX_SKB_FRAGS + 2];
> > > > +               struct virtnet_sq_dma dma;
> > > > +       };
> > > >
> > > >         /* Name of the send queue: output.$index */
> > > >         char name[16];
> > > > --
> > > > 2.32.0.3.g01195cf9f
> > > >
> > >
> >
>

