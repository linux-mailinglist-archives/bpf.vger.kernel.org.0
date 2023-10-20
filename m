Return-Path: <bpf+bounces-12808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 540BD7D0A3C
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 10:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC52DB21547
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 08:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E220107BD;
	Fri, 20 Oct 2023 08:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3848B10941;
	Fri, 20 Oct 2023 08:06:33 +0000 (UTC)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E1EE8;
	Fri, 20 Oct 2023 01:06:30 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VuWbaGz_1697789184;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VuWbaGz_1697789184)
          by smtp.aliyun-inc.com;
          Fri, 20 Oct 2023 16:06:25 +0800
Message-ID: <1697789168.0141354-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v1 11/19] virtio_net: xsk: tx: support tx
Date: Fri, 20 Oct 2023 16:06:08 +0800
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
 <20231016120033.26933-12-xuanzhuo@linux.alibaba.com>
 <CACGkMEuigM1k5kMc8qU3z2ZBvTGH6=oVRkOCAZ0apsoQF3yuaA@mail.gmail.com>
In-Reply-To: <CACGkMEuigM1k5kMc8qU3z2ZBvTGH6=oVRkOCAZ0apsoQF3yuaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Fri, 20 Oct 2023 14:52:08 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Oct 16, 2023 at 8:01=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > The driver's tx napi is very important for XSK. It is responsible for
> > obtaining data from the XSK queue and sending it out.
> >
> > At the beginning, we need to trigger tx napi.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio/main.c       |  18 +++++-
> >  drivers/net/virtio/virtio_net.h |   3 +-
> >  drivers/net/virtio/xsk.c        | 108 ++++++++++++++++++++++++++++++++
> >  drivers/net/virtio/xsk.h        |  13 ++++
> >  4 files changed, 140 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > index b320770e5f4e..a08429bef61f 100644
> > --- a/drivers/net/virtio/main.c
> > +++ b/drivers/net/virtio/main.c
> > @@ -2054,7 +2054,9 @@ static int virtnet_poll_tx(struct napi_struct *na=
pi, int budget)
> >         struct virtnet_sq *sq =3D container_of(napi, struct virtnet_sq,=
 napi);
> >         struct virtnet_info *vi =3D sq->vq->vdev->priv;
> >         unsigned int index =3D vq2txq(sq->vq);
> > +       struct xsk_buff_pool *pool;
> >         struct netdev_queue *txq;
> > +       int busy =3D 0;
> >         int opaque;
> >         bool done;
> >
> > @@ -2067,11 +2069,25 @@ static int virtnet_poll_tx(struct napi_struct *=
napi, int budget)
> >         txq =3D netdev_get_tx_queue(vi->dev, index);
> >         __netif_tx_lock(txq, raw_smp_processor_id());
> >         virtqueue_disable_cb(sq->vq);
> > -       free_old_xmit(sq, true);
> > +
> > +       rcu_read_lock();
> > +       pool =3D rcu_dereference(sq->xsk.pool);
> > +       if (pool) {
> > +               busy |=3D virtnet_xsk_xmit(sq, pool, budget);
> > +               rcu_read_unlock();
> > +       } else {
> > +               rcu_read_unlock();
> > +               free_old_xmit(sq, true);
> > +       }
> >
> >         if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS)
> >                 netif_tx_wake_queue(txq);
> >
> > +       if (busy) {
> > +               __netif_tx_unlock(txq);
> > +               return budget;
> > +       }
> > +
> >         opaque =3D virtqueue_enable_cb_prepare(sq->vq);
> >
> >         done =3D napi_complete_done(napi, 0);
> > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virti=
o_net.h
> > index 9e69b6c5921b..3bbb1f5baad5 100644
> > --- a/drivers/net/virtio/virtio_net.h
> > +++ b/drivers/net/virtio/virtio_net.h
> > @@ -9,7 +9,8 @@
> >  #include <net/xdp_sock_drv.h>
> >
> >  #define VIRTIO_XDP_FLAG        BIT(0)
> > -#define VIRTIO_XMIT_DATA_MASK (VIRTIO_XDP_FLAG)
> > +#define VIRTIO_XSK_FLAG        BIT(1)
> > +#define VIRTIO_XMIT_DATA_MASK (VIRTIO_XDP_FLAG | VIRTIO_XSK_FLAG)
> >
> >  /* RX packet size EWMA. The average packet size is used to determine t=
he packet
> >   * buffer size when refilling RX rings. As the entire RX ring may be r=
efilled
> > diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> > index dddd01962a3f..0e775a9d270f 100644
> > --- a/drivers/net/virtio/xsk.c
> > +++ b/drivers/net/virtio/xsk.c
> > @@ -7,6 +7,114 @@
> >
> >  static struct virtio_net_hdr_mrg_rxbuf xsk_hdr;
> >
> > +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 l=
en)
> > +{
> > +       sg->dma_address =3D addr;
> > +       sg->length =3D len;
> > +}
> > +
> > +static void virtnet_xsk_check_queue(struct virtnet_sq *sq)
> > +{
> > +       struct virtnet_info *vi =3D sq->vq->vdev->priv;
> > +       struct net_device *dev =3D vi->dev;
> > +       int qnum =3D sq - vi->sq;
> > +
> > +       /* If it is a raw buffer queue, it does not check whether the s=
tatus
> > +        * of the queue is stopped when sending. So there is no need to=
 check
> > +        * the situation of the raw buffer queue.
> > +        */
> > +       if (virtnet_is_xdp_raw_buffer_queue(vi, qnum))
> > +               return;
> > +
> > +       /* If this sq is not the exclusive queue of the current cpu,
> > +        * then it may be called by start_xmit, so check it running out
> > +        * of space.
> > +        *
> > +        * Stop the queue to avoid getting packets that we are
> > +        * then unable to transmit. Then wait the tx interrupt.
> > +        */
> > +       if (sq->vq->num_free < 2 + MAX_SKB_FRAGS)
> > +               netif_stop_subqueue(dev, qnum);
> > +}
> > +
> > +static int virtnet_xsk_xmit_one(struct virtnet_sq *sq,
> > +                               struct xsk_buff_pool *pool,
> > +                               struct xdp_desc *desc)
> > +{
> > +       struct virtnet_info *vi;
> > +       dma_addr_t addr;
> > +
> > +       vi =3D sq->vq->vdev->priv;
> > +
> > +       addr =3D xsk_buff_raw_get_dma(pool, desc->addr);
> > +       xsk_buff_raw_dma_sync_for_device(pool, addr, desc->len);
> > +
> > +       sg_init_table(sq->sg, 2);
> > +
> > +       sg_fill_dma(sq->sg, sq->xsk.hdr_dma_address, vi->hdr_len);
> > +       sg_fill_dma(sq->sg + 1, addr, desc->len);
> > +
> > +       return virtqueue_add_outbuf(sq->vq, sq->sg, 2,
> > +                                   virtnet_xsk_to_ptr(desc->len), GFP_=
ATOMIC);
> > +}
> > +
> > +static int virtnet_xsk_xmit_batch(struct virtnet_sq *sq,
> > +                                 struct xsk_buff_pool *pool,
> > +                                 unsigned int budget,
> > +                                 struct virtnet_sq_stats *stats)
> > +{
> > +       struct xdp_desc *descs =3D pool->tx_descs;
> > +       u32 nb_pkts, max_pkts, i;
> > +       bool kick =3D false;
> > +       int err;
> > +
> > +       max_pkts =3D min_t(u32, budget, sq->vq->num_free / 2);
>
> Need document why num_free / 2 is chosen here.

Will fix.

Thanks.


>
> Others look fine.
>
> Thanks
>
>
> > +
> > +       nb_pkts =3D xsk_tx_peek_release_desc_batch(pool, max_pkts);
> > +       if (!nb_pkts)
> > +               return 0;
> > +
> > +       for (i =3D 0; i < nb_pkts; i++) {
> > +               err =3D virtnet_xsk_xmit_one(sq, pool, &descs[i]);
> > +               if (unlikely(err))
> > +                       break;
> > +
> > +               kick =3D true;
> > +       }
> > +
> > +       if (kick && virtqueue_kick_prepare(sq->vq) && virtqueue_notify(=
sq->vq))
> > +               ++stats->kicks;
> > +
> > +       stats->xdp_tx +=3D i;
> > +
> > +       return i;
> > +}
> > +
> > +bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *poo=
l,
> > +                     int budget)
> > +{
> > +       struct virtnet_sq_stats stats =3D {};
> > +       int sent;
> > +
> > +       virtnet_free_old_xmit(sq, true, &stats);
> > +
> > +       sent =3D virtnet_xsk_xmit_batch(sq, pool, budget, &stats);
> > +
> > +       virtnet_xsk_check_queue(sq);
> > +
> > +       u64_stats_update_begin(&sq->stats.syncp);
> > +       sq->stats.packets +=3D stats.packets;
> > +       sq->stats.bytes +=3D stats.bytes;
> > +       sq->stats.kicks +=3D stats.kicks;
> > +       sq->stats.xdp_tx +=3D stats.xdp_tx;
> > +       u64_stats_update_end(&sq->stats.syncp);
> > +
> > +       if (xsk_uses_need_wakeup(pool))
> > +               xsk_set_tx_need_wakeup(pool);
> > +
> > +       return sent =3D=3D budget;
> > +}
> > +
> >  static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct vi=
rtnet_rq *rq,
> >                                     struct xsk_buff_pool *pool)
> >  {
> > diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
> > index 1918285c310c..73ca8cd5308b 100644
> > --- a/drivers/net/virtio/xsk.h
> > +++ b/drivers/net/virtio/xsk.h
> > @@ -3,5 +3,18 @@
> >  #ifndef __XSK_H__
> >  #define __XSK_H__
> >
> > +#define VIRTIO_XSK_FLAG_OFFSET 4
> > +
> > +static inline void *virtnet_xsk_to_ptr(u32 len)
> > +{
> > +       unsigned long p;
> > +
> > +       p =3D len << VIRTIO_XSK_FLAG_OFFSET;
> > +
> > +       return (void *)(p | VIRTIO_XSK_FLAG);
> > +}
> > +
> >  int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *=
xdp);
> > +bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *poo=
l,
> > +                     int budget);
> >  #endif
> > --
> > 2.32.0.3.g01195cf9f
> >
>

