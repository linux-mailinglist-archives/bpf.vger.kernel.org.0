Return-Path: <bpf+bounces-12807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A80C7D0A37
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 10:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87D291C20EAF
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 08:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6462D107A9;
	Fri, 20 Oct 2023 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28F7101CA;
	Fri, 20 Oct 2023 08:05:17 +0000 (UTC)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6294BE8;
	Fri, 20 Oct 2023 01:05:14 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VuWbBuF_1697789110;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VuWbBuF_1697789110)
          by smtp.aliyun-inc.com;
          Fri, 20 Oct 2023 16:05:10 +0800
Message-ID: <1697786930.9987535-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v1 09/19] virtio_net: xsk: bind/unbind xsk
Date: Fri, 20 Oct 2023 15:28:50 +0800
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
 <20231016120033.26933-10-xuanzhuo@linux.alibaba.com>
 <CACGkMEstVnDZ03E0s_+kOAkHy1wdTxG716gFGfR2mwNEFrpiKQ@mail.gmail.com>
In-Reply-To: <CACGkMEstVnDZ03E0s_+kOAkHy1wdTxG716gFGfR2mwNEFrpiKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Fri, 20 Oct 2023 14:51:15 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Oct 16, 2023 at 8:01=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > This patch implement the logic of bind/unbind xsk pool to sq and rq.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio/Makefile     |   2 +-
> >  drivers/net/virtio/main.c       |  10 +-
> >  drivers/net/virtio/virtio_net.h |  18 ++++
> >  drivers/net/virtio/xsk.c        | 186 ++++++++++++++++++++++++++++++++
> >  drivers/net/virtio/xsk.h        |   7 ++
> >  5 files changed, 216 insertions(+), 7 deletions(-)
> >  create mode 100644 drivers/net/virtio/xsk.c
> >  create mode 100644 drivers/net/virtio/xsk.h
> >
> > diff --git a/drivers/net/virtio/Makefile b/drivers/net/virtio/Makefile
> > index 15ed7c97fd4f..8c2a884d2dba 100644
> > --- a/drivers/net/virtio/Makefile
> > +++ b/drivers/net/virtio/Makefile
> > @@ -5,4 +5,4 @@
> >
> >  obj-$(CONFIG_VIRTIO_NET) +=3D virtio_net.o
> >
> > -virtio_net-y :=3D main.o
> > +virtio_net-y :=3D main.o xsk.o
> > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > index 02d27101fef1..38733a782f12 100644
> > --- a/drivers/net/virtio/main.c
> > +++ b/drivers/net/virtio/main.c
> > @@ -8,7 +8,6 @@
> >  #include <linux/etherdevice.h>
> >  #include <linux/module.h>
> >  #include <linux/virtio.h>
> > -#include <linux/virtio_net.h>
> >  #include <linux/bpf.h>
> >  #include <linux/bpf_trace.h>
> >  #include <linux/scatterlist.h>
> > @@ -139,9 +138,6 @@ struct virtio_net_common_hdr {
> >         };
> >  };
> >
> > -static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf=
);
> > -static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf=
);
> > -
> >  static void *xdp_to_ptr(struct xdp_frame *ptr)
> >  {
> >         return (void *)((unsigned long)ptr | VIRTIO_XDP_FLAG);
> > @@ -3664,6 +3660,8 @@ static int virtnet_xdp(struct net_device *dev, st=
ruct netdev_bpf *xdp)
> >         switch (xdp->command) {
> >         case XDP_SETUP_PROG:
> >                 return virtnet_xdp_set(dev, xdp->prog, xdp->extack);
> > +       case XDP_SETUP_XSK_POOL:
> > +               return virtnet_xsk_pool_setup(dev, xdp);
> >         default:
> >                 return -EINVAL;
> >         }
> > @@ -3849,7 +3847,7 @@ static void free_receive_page_frags(struct virtne=
t_info *vi)
> >                 }
> >  }
> >
> > -static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
> > +void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
> >  {
> >         if (!virtnet_is_xdp_frame(buf))
> >                 dev_kfree_skb(buf);
> > @@ -3857,7 +3855,7 @@ static void virtnet_sq_free_unused_buf(struct vir=
tqueue *vq, void *buf)
> >                 xdp_return_frame(virtnet_ptr_to_xdp(buf));
> >  }
> >
> > -static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
> > +void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
> >  {
> >         struct virtnet_info *vi =3D vq->vdev->priv;
> >         int i =3D vq2rxq(vq);
> > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virti=
o_net.h
> > index cc742756e19a..9e69b6c5921b 100644
> > --- a/drivers/net/virtio/virtio_net.h
> > +++ b/drivers/net/virtio/virtio_net.h
> > @@ -5,6 +5,8 @@
> >
> >  #include <linux/ethtool.h>
> >  #include <linux/average.h>
> > +#include <linux/virtio_net.h>
> > +#include <net/xdp_sock_drv.h>
> >
> >  #define VIRTIO_XDP_FLAG        BIT(0)
> >  #define VIRTIO_XMIT_DATA_MASK (VIRTIO_XDP_FLAG)
> > @@ -94,6 +96,11 @@ struct virtnet_sq {
> >         bool do_dma;
> >
> >         struct virtnet_sq_dma_head dmainfo;
> > +       struct {
> > +               struct xsk_buff_pool __rcu *pool;
> > +
> > +               dma_addr_t hdr_dma_address;
> > +       } xsk;
> >  };
> >
> >  /* Internal representation of a receive virtqueue */
> > @@ -134,6 +141,13 @@ struct virtnet_rq {
> >
> >         /* Do dma by self */
> >         bool do_dma;
> > +
> > +       struct {
> > +               struct xsk_buff_pool __rcu *pool;
> > +
> > +               /* xdp rxq used by xsk */
> > +               struct xdp_rxq_info xdp_rxq;
> > +       } xsk;
> >  };
> >
> >  struct virtnet_info {
> > @@ -218,6 +232,8 @@ struct virtnet_info {
> >         struct failover *failover;
> >  };
> >
> > +#include "xsk.h"
> > +
>
> Any reason we don't do it with other headers?

Because xsk.h will reference the struct virtnet_sq..., if we put xsk.h
at the start of virtio_net.h, the gcc will not happy.
But the virtio-net.h references the api(virtnet_ptr_to_xsk) of the xsk.h.


>
> >  static inline bool virtnet_is_xdp_frame(void *ptr)
> >  {
> >         return (unsigned long)ptr & VIRTIO_XDP_FLAG;
> > @@ -308,4 +324,6 @@ void virtnet_rx_pause(struct virtnet_info *vi, stru=
ct virtnet_rq *rq);
> >  void virtnet_rx_resume(struct virtnet_info *vi, struct virtnet_rq *rq);
> >  void virtnet_tx_pause(struct virtnet_info *vi, struct virtnet_sq *sq);
> >  void virtnet_tx_resume(struct virtnet_info *vi, struct virtnet_sq *sq);
> > +void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
> > +void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
> >  #endif
> > diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> > new file mode 100644
> > index 000000000000..dddd01962a3f
> > --- /dev/null
> > +++ b/drivers/net/virtio/xsk.c
> > @@ -0,0 +1,186 @@

[...]

> > +
> > +       if (!rq->do_dma || !sq->do_dma)
> > +               return -EPERM;
> > +
> > +       if (virtqueue_dma_dev(rq->vq) !=3D virtqueue_dma_dev(sq->vq))
> > +               return -EPERM;
>
> Any reason we need this check? Is there any code that has this
> assumption? E.g dma sync in XDP_TX?

For the xsk, the tx and rx should have the same dev.
But vq->dma_dev allows every vq has the respective dma dev.

So I check the dma dev of vq and sq is the same dev.

>
> > +
> > +       dma_dev =3D virtqueue_dma_dev(rq->vq);
> > +       if (!dma_dev)
> > +               return -EPERM;
> > +
> > +       hdr_dma =3D dma_map_single(dma_dev, &xsk_hdr, vi->hdr_len, DMA_=
TO_DEVICE);
> > +       if (dma_mapping_error(dma_dev, hdr_dma))
> > +               return -ENOMEM;
> > +
> > +       err =3D xsk_pool_dma_map(pool, dma_dev, 0);
> > +       if (err)
> > +               goto err_xsk_map;
> > +
> > +       err =3D virtnet_rq_bind_xsk_pool(vi, rq, pool);
> > +       if (err)
> > +               goto err_rq;
> > +
> > +       err =3D virtnet_sq_bind_xsk_pool(vi, sq, pool);
> > +       if (err)
> > +               goto err_sq;
> > +
> > +       sq->xsk.hdr_dma_address =3D hdr_dma;
>
> I think we probably need some comments to explain why a single hdr can
> work. Like it means we use the same hdr for all XSK packets?

Will fix.

>
> > +
> > +       return 0;
> > +
> > +err_sq:
> > +       virtnet_rq_bind_xsk_pool(vi, rq, NULL);
> > +err_rq:
> > +       xsk_pool_dma_unmap(pool, 0);
> > +err_xsk_map:
> > +       dma_unmap_single(dma_dev, hdr_dma, vi->hdr_len, DMA_TO_DEVICE);
> > +       return err;
> > +}
> > +
> > +static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
> > +{
> > +       struct virtnet_info *vi =3D netdev_priv(dev);
> > +       struct xsk_buff_pool *pool;
> > +       struct device *dma_dev;
> > +       struct virtnet_rq *rq;
> > +       struct virtnet_sq *sq;
> > +       int err1, err2;
> > +
> > +       if (qid >=3D vi->curr_queue_pairs)
> > +               return -EINVAL;
> > +
> > +       sq =3D &vi->sq[qid];
> > +       rq =3D &vi->rq[qid];
> > +
> > +       dma_dev =3D virtqueue_dma_dev(rq->vq);
> > +
> > +       /* Sync with the XSK wakeup and NAPI. */
> > +       synchronize_net();
>
> Any reason we couldn't do bind_xsk_pool(NULL) here? It seems easier.

Do you mean rcu_assign_pointer() is enough?

Let me check it.

Thanks


>
> Thanks
>
>
> > +
> > +       dma_unmap_single(dma_dev, sq->xsk.hdr_dma_address, vi->hdr_len,=
 DMA_TO_DEVICE);
> > +
> > +       rcu_read_lock();
> > +       pool =3D rcu_dereference(sq->xsk.pool);
> > +       xsk_pool_dma_unmap(pool, 0);
> > +       rcu_read_unlock();
> > +
> > +       err1 =3D virtnet_sq_bind_xsk_pool(vi, sq, NULL);
> > +       err2 =3D virtnet_rq_bind_xsk_pool(vi, rq, NULL);
> > +
> > +       return err1 | err2;
> > +}
> > +
> > +int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *=
xdp)
> > +{
> > +       if (xdp->xsk.pool)
> > +               return virtnet_xsk_pool_enable(dev, xdp->xsk.pool,
> > +                                              xdp->xsk.queue_id);
> > +       else
> > +               return virtnet_xsk_pool_disable(dev, xdp->xsk.queue_id);
> > +}
> > diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
> > new file mode 100644
> > index 000000000000..1918285c310c
> > --- /dev/null
> > +++ b/drivers/net/virtio/xsk.h
> > @@ -0,0 +1,7 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +
> > +#ifndef __XSK_H__
> > +#define __XSK_H__
> > +
> > +int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *=
xdp);
> > +#endif
> > --
> > 2.32.0.3.g01195cf9f
> >
>

