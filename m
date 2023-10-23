Return-Path: <bpf+bounces-12982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A26497D2AC5
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 08:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F132814D9
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 06:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA580747F;
	Mon, 23 Oct 2023 06:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACAD1850;
	Mon, 23 Oct 2023 06:57:55 +0000 (UTC)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C63F7;
	Sun, 22 Oct 2023 23:57:52 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VufF4U5_1698044269;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VufF4U5_1698044269)
          by smtp.aliyun-inc.com;
          Mon, 23 Oct 2023 14:57:50 +0800
Message-ID: <1698044212.9541101-5-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v1 15/19] virtio_net: xsk: rx: introduce add_recvbuf_xsk()
Date: Mon, 23 Oct 2023 14:56:52 +0800
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
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-16-xuanzhuo@linux.alibaba.com>
 <CACGkMEvmtUp4NxqiDVD3w5eDi5T4UYgnwYkGty+nfQS9h-bsuA@mail.gmail.com>
In-Reply-To: <CACGkMEvmtUp4NxqiDVD3w5eDi5T4UYgnwYkGty+nfQS9h-bsuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Fri, 20 Oct 2023 14:56:51 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Oct 16, 2023 at 8:01=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > Implement the logic of filling vq with XSK buffer.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio/main.c       | 13 +++++++
> >  drivers/net/virtio/virtio_net.h |  5 +++
> >  drivers/net/virtio/xsk.c        | 66 ++++++++++++++++++++++++++++++++-
> >  drivers/net/virtio/xsk.h        |  2 +
> >  4 files changed, 85 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > index 58bb38f9b453..0e740447b142 100644
> > --- a/drivers/net/virtio/main.c
> > +++ b/drivers/net/virtio/main.c
> > @@ -1787,9 +1787,20 @@ static int add_recvbuf_mergeable(struct virtnet_=
info *vi,
> >  static bool try_fill_recv(struct virtnet_info *vi, struct virtnet_rq *=
rq,
> >                           gfp_t gfp)
> >  {
> > +       struct xsk_buff_pool *pool;
> >         int err;
> >         bool oom;
> >
> > +       rcu_read_lock();
>
> A question here: should we sync with refill work during rx_pause?
>
> > +       pool =3D rcu_dereference(rq->xsk.pool);
> > +       if (pool) {
> > +               err =3D virtnet_add_recvbuf_xsk(vi, rq, pool, gfp);
> > +               oom =3D err =3D=3D -ENOMEM;
> > +               rcu_read_unlock();
> > +               goto kick;
> > +       }
> > +       rcu_read_unlock();
>
> And if we synchronize with that there's probably no need for the rcu
> and we can merge the logic with the following ones?


YES. we synchronize the rx_pause and this.

But for the rcu object, I think we should use rcu_xxx() API.

Thanks.


>
> Thanks
>
>
> > +
> >         do {
> >                 if (vi->mergeable_rx_bufs)
> >                         err =3D add_recvbuf_mergeable(vi, rq, gfp);
> > @@ -1802,6 +1813,8 @@ static bool try_fill_recv(struct virtnet_info *vi=
, struct virtnet_rq *rq,
> >                 if (err)
> >                         break;
> >         } while (rq->vq->num_free);
> > +
> > +kick:
> >         if (virtqueue_kick_prepare(rq->vq) && virtqueue_notify(rq->vq))=
 {
> >                 unsigned long flags;
> >
> > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virti=
o_net.h
> > index d4e620a084f4..6e71622fca45 100644
> > --- a/drivers/net/virtio/virtio_net.h
> > +++ b/drivers/net/virtio/virtio_net.h
> > @@ -156,6 +156,11 @@ struct virtnet_rq {
> >
> >                 /* xdp rxq used by xsk */
> >                 struct xdp_rxq_info xdp_rxq;
> > +
> > +               struct xdp_buff **xsk_buffs;
> > +               u32 nxt_idx;
> > +               u32 num;
> > +               u32 size;
> >         } xsk;
> >  };
> >
> > diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> > index 973e783260c3..841fb078882a 100644
> > --- a/drivers/net/virtio/xsk.c
> > +++ b/drivers/net/virtio/xsk.c
> > @@ -37,6 +37,58 @@ static void virtnet_xsk_check_queue(struct virtnet_s=
q *sq)
> >                 netif_stop_subqueue(dev, qnum);
> >  }
> >
> > +static int virtnet_add_recvbuf_batch(struct virtnet_info *vi, struct v=
irtnet_rq *rq,
> > +                                    struct xsk_buff_pool *pool, gfp_t =
gfp)
> > +{
> > +       struct xdp_buff **xsk_buffs;
> > +       dma_addr_t addr;
> > +       u32 len, i;
> > +       int err =3D 0;
> > +
> > +       xsk_buffs =3D rq->xsk.xsk_buffs;
> > +
> > +       if (rq->xsk.nxt_idx >=3D rq->xsk.num) {
> > +               rq->xsk.num =3D xsk_buff_alloc_batch(pool, xsk_buffs, r=
q->xsk.size);
> > +               if (!rq->xsk.num)
> > +                       return -ENOMEM;
> > +               rq->xsk.nxt_idx =3D 0;
> > +       }
> > +
> > +       while (rq->xsk.nxt_idx < rq->xsk.num) {
> > +               i =3D rq->xsk.nxt_idx;
> > +
> > +               /* use the part of XDP_PACKET_HEADROOM as the virtnet h=
dr space */
> > +               addr =3D xsk_buff_xdp_get_dma(xsk_buffs[i]) - vi->hdr_l=
en;
> > +               len =3D xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
> > +
> > +               sg_init_table(rq->sg, 1);
> > +               sg_fill_dma(rq->sg, addr, len);
> > +
> > +               err =3D virtqueue_add_inbuf(rq->vq, rq->sg, 1, xsk_buff=
s[i], gfp);
> > +               if (err)
> > +                       return err;
> > +
> > +               rq->xsk.nxt_idx++;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct virtnet_rq=
 *rq,
> > +                           struct xsk_buff_pool *pool, gfp_t gfp)
> > +{
> > +       int err;
> > +
> > +       do {
> > +               err =3D virtnet_add_recvbuf_batch(vi, rq, pool, gfp);
> > +               if (err)
> > +                       return err;
> > +
> > +       } while (rq->vq->num_free);
> > +
> > +       return 0;
> > +}
> > +
> >  static int virtnet_xsk_xmit_one(struct virtnet_sq *sq,
> >                                 struct xsk_buff_pool *pool,
> >                                 struct xdp_desc *desc)
> > @@ -244,7 +296,7 @@ static int virtnet_xsk_pool_enable(struct net_devic=
e *dev,
> >         struct virtnet_sq *sq;
> >         struct device *dma_dev;
> >         dma_addr_t hdr_dma;
> > -       int err;
> > +       int err, size;
> >
> >         /* In big_packets mode, xdp cannot work, so there is no need to
> >          * initialize xsk of rq.
> > @@ -276,6 +328,16 @@ static int virtnet_xsk_pool_enable(struct net_devi=
ce *dev,
> >         if (!dma_dev)
> >                 return -EPERM;
> >
> > +       size =3D virtqueue_get_vring_size(rq->vq);
> > +
> > +       rq->xsk.xsk_buffs =3D kcalloc(size, sizeof(*rq->xsk.xsk_buffs),=
 GFP_KERNEL);
> > +       if (!rq->xsk.xsk_buffs)
> > +               return -ENOMEM;
> > +
> > +       rq->xsk.size =3D size;
> > +       rq->xsk.nxt_idx =3D 0;
> > +       rq->xsk.num =3D 0;
> > +
> >         hdr_dma =3D dma_map_single(dma_dev, &xsk_hdr, vi->hdr_len, DMA_=
TO_DEVICE);
> >         if (dma_mapping_error(dma_dev, hdr_dma))
> >                 return -ENOMEM;
> > @@ -338,6 +400,8 @@ static int virtnet_xsk_pool_disable(struct net_devi=
ce *dev, u16 qid)
> >         err1 =3D virtnet_sq_bind_xsk_pool(vi, sq, NULL);
> >         err2 =3D virtnet_rq_bind_xsk_pool(vi, rq, NULL);
> >
> > +       kfree(rq->xsk.xsk_buffs);
> > +
> >         return err1 | err2;
> >  }
> >
> > diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
> > index 7ebc9bda7aee..bef41a3f954e 100644
> > --- a/drivers/net/virtio/xsk.h
> > +++ b/drivers/net/virtio/xsk.h
> > @@ -23,4 +23,6 @@ int virtnet_xsk_pool_setup(struct net_device *dev, st=
ruct netdev_bpf *xdp);
> >  bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *poo=
l,
> >                       int budget);
> >  int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag);
> > +int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct virtnet_rq=
 *rq,
> > +                           struct xsk_buff_pool *pool, gfp_t gfp);
> >  #endif
> > --
> > 2.32.0.3.g01195cf9f
> >
>

