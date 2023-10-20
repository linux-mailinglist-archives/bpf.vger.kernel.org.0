Return-Path: <bpf+bounces-12794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 041557D08CC
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 08:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E191C20F64
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 06:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51493CA57;
	Fri, 20 Oct 2023 06:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hS7YSZgG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F640CA43
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 06:51:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E3BB8
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 23:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697784689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jy9ts7HKnjoFz7fQ778FA+/tkscazdJPl/wCGXjdUow=;
	b=hS7YSZgGfdpM1St4Ou6evZ46HvCkLBQ8nCEN3797FHJLg32sbYmcIQ6XuktSZObpGceX5h
	5lU+jAbYL1QcgjLzEiJg5cRyjo4P97t8wU4pYvuXVeVOlQFyDdMV1ZlBTyq7oG0cwvfP/C
	K4S6lp8X8dItOA6t/aJ/lb6FjNhrNuI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-sBWeCEVXPr6AaWWeI3qZbQ-1; Fri, 20 Oct 2023 02:51:27 -0400
X-MC-Unique: sBWeCEVXPr6AaWWeI3qZbQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-507ce973a03so452546e87.3
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 23:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697784686; x=1698389486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jy9ts7HKnjoFz7fQ778FA+/tkscazdJPl/wCGXjdUow=;
        b=M6a3sa9saPOOAdRH4lAdCasdr/bLiz2kviVT25WBl0uU1Idz8hTEgGfXuYwtfcgoEY
         X8dSrzXBC7ddIMeMAn+UwGh3Tps5u2tZ5MQl/iU16CcmPwUdn3gnwVmJwp6LAaHvYLze
         hKp4vaouYp7PVZuGN6uqkq0L773Ll2o9J9RpUyZpMgesKTAMKMrU78hNv9MettpWZV/Y
         4Zd2tpRxHkXchH9DOPU9c0UAOkNPQWOGqO4FqoPDxoHYwo3HFcRXjVq9HPSVDjSJZTvn
         fDeE/gkNE1xRvhuH4YAEybRvWqt9Ji1PRKXFA9BpQvwtDpIh3qfnih+mu0Un9cve11aO
         zM1g==
X-Gm-Message-State: AOJu0YxAFa3HSQBmW+5oMCzB04NN40sG0ZsW7RhVykM/NkejCwEQ35vb
	XBkTlI+2e/pNBX/ggLyTER62IR89lSO1msexYZTn+YLMlleB+5CRH73vvwJ9EIiWXiIRsRNkbn/
	xtNji+0r/lJf8U1Ci/a8XM5m1sQTG
X-Received: by 2002:a19:7411:0:b0:502:a4f4:ced9 with SMTP id v17-20020a197411000000b00502a4f4ced9mr581260lfe.62.1697784686223;
        Thu, 19 Oct 2023 23:51:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHLoFKQYUFzAfSKu+SNiTuWJlECMqPfiv9geD75cR3oqj1Hu33zdL1TA6rkswu8ps3SOVJErytNJzdIFTNvwI=
X-Received: by 2002:a19:7411:0:b0:502:a4f4:ced9 with SMTP id
 v17-20020a197411000000b00502a4f4ced9mr581247lfe.62.1697784685836; Thu, 19 Oct
 2023 23:51:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com> <20231016120033.26933-10-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-10-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Oct 2023 14:51:15 +0800
Message-ID: <CACGkMEstVnDZ03E0s_+kOAkHy1wdTxG716gFGfR2mwNEFrpiKQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 09/19] virtio_net: xsk: bind/unbind xsk
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 8:01=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> This patch implement the logic of bind/unbind xsk pool to sq and rq.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/Makefile     |   2 +-
>  drivers/net/virtio/main.c       |  10 +-
>  drivers/net/virtio/virtio_net.h |  18 ++++
>  drivers/net/virtio/xsk.c        | 186 ++++++++++++++++++++++++++++++++
>  drivers/net/virtio/xsk.h        |   7 ++
>  5 files changed, 216 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/net/virtio/xsk.c
>  create mode 100644 drivers/net/virtio/xsk.h
>
> diff --git a/drivers/net/virtio/Makefile b/drivers/net/virtio/Makefile
> index 15ed7c97fd4f..8c2a884d2dba 100644
> --- a/drivers/net/virtio/Makefile
> +++ b/drivers/net/virtio/Makefile
> @@ -5,4 +5,4 @@
>
>  obj-$(CONFIG_VIRTIO_NET) +=3D virtio_net.o
>
> -virtio_net-y :=3D main.o
> +virtio_net-y :=3D main.o xsk.o
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index 02d27101fef1..38733a782f12 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -8,7 +8,6 @@
>  #include <linux/etherdevice.h>
>  #include <linux/module.h>
>  #include <linux/virtio.h>
> -#include <linux/virtio_net.h>
>  #include <linux/bpf.h>
>  #include <linux/bpf_trace.h>
>  #include <linux/scatterlist.h>
> @@ -139,9 +138,6 @@ struct virtio_net_common_hdr {
>         };
>  };
>
> -static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
> -static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
> -
>  static void *xdp_to_ptr(struct xdp_frame *ptr)
>  {
>         return (void *)((unsigned long)ptr | VIRTIO_XDP_FLAG);
> @@ -3664,6 +3660,8 @@ static int virtnet_xdp(struct net_device *dev, stru=
ct netdev_bpf *xdp)
>         switch (xdp->command) {
>         case XDP_SETUP_PROG:
>                 return virtnet_xdp_set(dev, xdp->prog, xdp->extack);
> +       case XDP_SETUP_XSK_POOL:
> +               return virtnet_xsk_pool_setup(dev, xdp);
>         default:
>                 return -EINVAL;
>         }
> @@ -3849,7 +3847,7 @@ static void free_receive_page_frags(struct virtnet_=
info *vi)
>                 }
>  }
>
> -static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
> +void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
>  {
>         if (!virtnet_is_xdp_frame(buf))
>                 dev_kfree_skb(buf);
> @@ -3857,7 +3855,7 @@ static void virtnet_sq_free_unused_buf(struct virtq=
ueue *vq, void *buf)
>                 xdp_return_frame(virtnet_ptr_to_xdp(buf));
>  }
>
> -static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
> +void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
>  {
>         struct virtnet_info *vi =3D vq->vdev->priv;
>         int i =3D vq2rxq(vq);
> diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_=
net.h
> index cc742756e19a..9e69b6c5921b 100644
> --- a/drivers/net/virtio/virtio_net.h
> +++ b/drivers/net/virtio/virtio_net.h
> @@ -5,6 +5,8 @@
>
>  #include <linux/ethtool.h>
>  #include <linux/average.h>
> +#include <linux/virtio_net.h>
> +#include <net/xdp_sock_drv.h>
>
>  #define VIRTIO_XDP_FLAG        BIT(0)
>  #define VIRTIO_XMIT_DATA_MASK (VIRTIO_XDP_FLAG)
> @@ -94,6 +96,11 @@ struct virtnet_sq {
>         bool do_dma;
>
>         struct virtnet_sq_dma_head dmainfo;
> +       struct {
> +               struct xsk_buff_pool __rcu *pool;
> +
> +               dma_addr_t hdr_dma_address;
> +       } xsk;
>  };
>
>  /* Internal representation of a receive virtqueue */
> @@ -134,6 +141,13 @@ struct virtnet_rq {
>
>         /* Do dma by self */
>         bool do_dma;
> +
> +       struct {
> +               struct xsk_buff_pool __rcu *pool;
> +
> +               /* xdp rxq used by xsk */
> +               struct xdp_rxq_info xdp_rxq;
> +       } xsk;
>  };
>
>  struct virtnet_info {
> @@ -218,6 +232,8 @@ struct virtnet_info {
>         struct failover *failover;
>  };
>
> +#include "xsk.h"
> +

Any reason we don't do it with other headers?

>  static inline bool virtnet_is_xdp_frame(void *ptr)
>  {
>         return (unsigned long)ptr & VIRTIO_XDP_FLAG;
> @@ -308,4 +324,6 @@ void virtnet_rx_pause(struct virtnet_info *vi, struct=
 virtnet_rq *rq);
>  void virtnet_rx_resume(struct virtnet_info *vi, struct virtnet_rq *rq);
>  void virtnet_tx_pause(struct virtnet_info *vi, struct virtnet_sq *sq);
>  void virtnet_tx_resume(struct virtnet_info *vi, struct virtnet_sq *sq);
> +void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
> +void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
>  #endif
> diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> new file mode 100644
> index 000000000000..dddd01962a3f
> --- /dev/null
> +++ b/drivers/net/virtio/xsk.c
> @@ -0,0 +1,186 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * virtio-net xsk
> + */
> +
> +#include "virtio_net.h"
> +
> +static struct virtio_net_hdr_mrg_rxbuf xsk_hdr;
> +
> +static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct virt=
net_rq *rq,
> +                                   struct xsk_buff_pool *pool)
> +{
> +       int err, qindex;
> +
> +       qindex =3D rq - vi->rq;
> +
> +       if (pool) {
> +               err =3D xdp_rxq_info_reg(&rq->xsk.xdp_rxq, vi->dev, qinde=
x, rq->napi.napi_id);
> +               if (err < 0)
> +                       return err;
> +
> +               err =3D xdp_rxq_info_reg_mem_model(&rq->xsk.xdp_rxq,
> +                                                MEM_TYPE_XSK_BUFF_POOL, =
NULL);
> +               if (err < 0) {
> +                       xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> +                       return err;
> +               }
> +
> +               xsk_pool_set_rxq_info(pool, &rq->xsk.xdp_rxq);
> +       } else {
> +               xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> +       }
> +
> +       virtnet_rx_pause(vi, rq);
> +
> +       err =3D virtqueue_reset(rq->vq, virtnet_rq_free_unused_buf);
> +       if (err)
> +               netdev_err(vi->dev, "reset rx fail: rx queue index: %d er=
r: %d\n", qindex, err);
> +
> +       if (pool && err)
> +               xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> +       else
> +               rcu_assign_pointer(rq->xsk.pool, pool);
> +
> +       virtnet_rx_resume(vi, rq);
> +
> +       return err;
> +}
> +
> +static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
> +                                   struct virtnet_sq *sq,
> +                                   struct xsk_buff_pool *pool)
> +{
> +       int err, qindex;
> +
> +       qindex =3D sq - vi->sq;
> +
> +       virtnet_tx_pause(vi, sq);
> +
> +       err =3D virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
> +       if (err)
> +               netdev_err(vi->dev, "reset tx fail: tx queue index: %d er=
r: %d\n", qindex, err);
> +
> +       if (pool) {
> +               if (!err)
> +                       rcu_assign_pointer(sq->xsk.pool, pool);
> +       } else {
> +               rcu_assign_pointer(sq->xsk.pool, NULL);
> +       }
> +
> +       virtnet_tx_resume(vi, sq);
> +
> +       return err;
> +}
> +
> +static int virtnet_xsk_pool_enable(struct net_device *dev,
> +                                  struct xsk_buff_pool *pool,
> +                                  u16 qid)
> +{
> +       struct virtnet_info *vi =3D netdev_priv(dev);
> +       struct virtnet_rq *rq;
> +       struct virtnet_sq *sq;
> +       struct device *dma_dev;
> +       dma_addr_t hdr_dma;
> +       int err;
> +
> +       /* In big_packets mode, xdp cannot work, so there is no need to
> +        * initialize xsk of rq.
> +        */
> +       if (vi->big_packets && !vi->mergeable_rx_bufs)
> +               return -ENOENT;
> +
> +       if (qid >=3D vi->curr_queue_pairs)
> +               return -EINVAL;
> +
> +       sq =3D &vi->sq[qid];
> +       rq =3D &vi->rq[qid];
> +
> +       /* xsk tx zerocopy depend on the tx napi.
> +        *
> +        * All xsk packets are actually consumed and sent out from the xs=
k tx
> +        * queue under the tx napi mechanism.
> +        */
> +       if (!sq->napi.weight)
> +               return -EPERM;
> +
> +       if (!rq->do_dma || !sq->do_dma)
> +               return -EPERM;
> +
> +       if (virtqueue_dma_dev(rq->vq) !=3D virtqueue_dma_dev(sq->vq))
> +               return -EPERM;

Any reason we need this check? Is there any code that has this
assumption? E.g dma sync in XDP_TX?

> +
> +       dma_dev =3D virtqueue_dma_dev(rq->vq);
> +       if (!dma_dev)
> +               return -EPERM;
> +
> +       hdr_dma =3D dma_map_single(dma_dev, &xsk_hdr, vi->hdr_len, DMA_TO=
_DEVICE);
> +       if (dma_mapping_error(dma_dev, hdr_dma))
> +               return -ENOMEM;
> +
> +       err =3D xsk_pool_dma_map(pool, dma_dev, 0);
> +       if (err)
> +               goto err_xsk_map;
> +
> +       err =3D virtnet_rq_bind_xsk_pool(vi, rq, pool);
> +       if (err)
> +               goto err_rq;
> +
> +       err =3D virtnet_sq_bind_xsk_pool(vi, sq, pool);
> +       if (err)
> +               goto err_sq;
> +
> +       sq->xsk.hdr_dma_address =3D hdr_dma;

I think we probably need some comments to explain why a single hdr can
work. Like it means we use the same hdr for all XSK packets?

> +
> +       return 0;
> +
> +err_sq:
> +       virtnet_rq_bind_xsk_pool(vi, rq, NULL);
> +err_rq:
> +       xsk_pool_dma_unmap(pool, 0);
> +err_xsk_map:
> +       dma_unmap_single(dma_dev, hdr_dma, vi->hdr_len, DMA_TO_DEVICE);
> +       return err;
> +}
> +
> +static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
> +{
> +       struct virtnet_info *vi =3D netdev_priv(dev);
> +       struct xsk_buff_pool *pool;
> +       struct device *dma_dev;
> +       struct virtnet_rq *rq;
> +       struct virtnet_sq *sq;
> +       int err1, err2;
> +
> +       if (qid >=3D vi->curr_queue_pairs)
> +               return -EINVAL;
> +
> +       sq =3D &vi->sq[qid];
> +       rq =3D &vi->rq[qid];
> +
> +       dma_dev =3D virtqueue_dma_dev(rq->vq);
> +
> +       /* Sync with the XSK wakeup and NAPI. */
> +       synchronize_net();

Any reason we couldn't do bind_xsk_pool(NULL) here? It seems easier.

Thanks


> +
> +       dma_unmap_single(dma_dev, sq->xsk.hdr_dma_address, vi->hdr_len, D=
MA_TO_DEVICE);
> +
> +       rcu_read_lock();
> +       pool =3D rcu_dereference(sq->xsk.pool);
> +       xsk_pool_dma_unmap(pool, 0);
> +       rcu_read_unlock();
> +
> +       err1 =3D virtnet_sq_bind_xsk_pool(vi, sq, NULL);
> +       err2 =3D virtnet_rq_bind_xsk_pool(vi, rq, NULL);
> +
> +       return err1 | err2;
> +}
> +
> +int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xd=
p)
> +{
> +       if (xdp->xsk.pool)
> +               return virtnet_xsk_pool_enable(dev, xdp->xsk.pool,
> +                                              xdp->xsk.queue_id);
> +       else
> +               return virtnet_xsk_pool_disable(dev, xdp->xsk.queue_id);
> +}
> diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
> new file mode 100644
> index 000000000000..1918285c310c
> --- /dev/null
> +++ b/drivers/net/virtio/xsk.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef __XSK_H__
> +#define __XSK_H__
> +
> +int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xd=
p);
> +#endif
> --
> 2.32.0.3.g01195cf9f
>


