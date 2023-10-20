Return-Path: <bpf+bounces-12796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC6A7D08D6
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 08:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEDB61C20F14
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 06:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB7BCA5C;
	Fri, 20 Oct 2023 06:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KN3+W2iv"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665AFCA6A
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 06:52:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB39D5E
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 23:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697784748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xiWFZgyTdOatMwrsl9tAqUdxKGO4izrc8eXUlwyd3ZE=;
	b=KN3+W2iv8mkZx86sZeWlK2dM+IDPokG/qk8XZ2XVDzoorndAikXaERCflPLi8UJUOXkUZ8
	PCfca3/zZF4FiEyW2ebnRr8K8gQpxjSRWuG3FXC4hU/YN7+9NLUxhPcp/iK4XD9ai8kFcu
	zqHNearJOOVagl4WLghrcxG79b/wkGE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638--wVYo1_NPzWkqt5rVHUgKg-1; Fri, 20 Oct 2023 02:52:21 -0400
X-MC-Unique: -wVYo1_NPzWkqt5rVHUgKg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5079c865541so429907e87.3
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 23:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697784740; x=1698389540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xiWFZgyTdOatMwrsl9tAqUdxKGO4izrc8eXUlwyd3ZE=;
        b=KVQZuzwvZJt0tsChRWVR6EkoJgIREh3R/p+Y361+8KP3C8uj9n6WyFHkOKwZ8EnnLo
         ku1eaNm4TSOaeJby3L2Y3TX84i+x27B741OOUNSH6D/p/HVZp+QGlKy244ZEkQMZYZA0
         mO9Uks8Yp9xa0PyES0ZT1047SGW6iodryT9Je0IMu4TbnxrpCh/I3Bg3KkoVe2wwu9De
         MrwTIw13kAX5w7BRFp0xT6pk5cEgXZBEkH8EdKvY+dulzlFARGRqKcwwMT8tOgB/eTXK
         t0UbRjS+dU8nh7NPE7utVXTqVRZmIKxHJwnp+YTtPit26d3pYKukLNL7UzaKovWcy6NQ
         sBkQ==
X-Gm-Message-State: AOJu0YzJ0O0nLZIqI5WwsPS4pjEi74XrsFc5ov5VkswsIEuQm5L96IoZ
	w0SHhbjbfmPQwreydGo4f9m3SCK40y5UEdU1iVIgeQkmiJkmWqGXfRORhElXKU5rbARMGWg7fMN
	aQGywpO+wiMkKue0GeGMAPb8UyvDc
X-Received: by 2002:ac2:4a63:0:b0:507:9803:ff8b with SMTP id q3-20020ac24a63000000b005079803ff8bmr627531lfp.44.1697784739957;
        Thu, 19 Oct 2023 23:52:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDGUIP9Cdis47PBbdYSDYY4QWceX817DJez1b/O4eRVyNIN8GFhk6x0OYoPPaeSxsyqYiqGT2gMTXhJw46RRQ=
X-Received: by 2002:ac2:4a63:0:b0:507:9803:ff8b with SMTP id
 q3-20020ac24a63000000b005079803ff8bmr627512lfp.44.1697784739508; Thu, 19 Oct
 2023 23:52:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com> <20231016120033.26933-12-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-12-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Oct 2023 14:52:08 +0800
Message-ID: <CACGkMEuigM1k5kMc8qU3z2ZBvTGH6=oVRkOCAZ0apsoQF3yuaA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 11/19] virtio_net: xsk: tx: support tx
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
> The driver's tx napi is very important for XSK. It is responsible for
> obtaining data from the XSK queue and sending it out.
>
> At the beginning, we need to trigger tx napi.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/main.c       |  18 +++++-
>  drivers/net/virtio/virtio_net.h |   3 +-
>  drivers/net/virtio/xsk.c        | 108 ++++++++++++++++++++++++++++++++
>  drivers/net/virtio/xsk.h        |  13 ++++
>  4 files changed, 140 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index b320770e5f4e..a08429bef61f 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -2054,7 +2054,9 @@ static int virtnet_poll_tx(struct napi_struct *napi=
, int budget)
>         struct virtnet_sq *sq =3D container_of(napi, struct virtnet_sq, n=
api);
>         struct virtnet_info *vi =3D sq->vq->vdev->priv;
>         unsigned int index =3D vq2txq(sq->vq);
> +       struct xsk_buff_pool *pool;
>         struct netdev_queue *txq;
> +       int busy =3D 0;
>         int opaque;
>         bool done;
>
> @@ -2067,11 +2069,25 @@ static int virtnet_poll_tx(struct napi_struct *na=
pi, int budget)
>         txq =3D netdev_get_tx_queue(vi->dev, index);
>         __netif_tx_lock(txq, raw_smp_processor_id());
>         virtqueue_disable_cb(sq->vq);
> -       free_old_xmit(sq, true);
> +
> +       rcu_read_lock();
> +       pool =3D rcu_dereference(sq->xsk.pool);
> +       if (pool) {
> +               busy |=3D virtnet_xsk_xmit(sq, pool, budget);
> +               rcu_read_unlock();
> +       } else {
> +               rcu_read_unlock();
> +               free_old_xmit(sq, true);
> +       }
>
>         if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS)
>                 netif_tx_wake_queue(txq);
>
> +       if (busy) {
> +               __netif_tx_unlock(txq);
> +               return budget;
> +       }
> +
>         opaque =3D virtqueue_enable_cb_prepare(sq->vq);
>
>         done =3D napi_complete_done(napi, 0);
> diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_=
net.h
> index 9e69b6c5921b..3bbb1f5baad5 100644
> --- a/drivers/net/virtio/virtio_net.h
> +++ b/drivers/net/virtio/virtio_net.h
> @@ -9,7 +9,8 @@
>  #include <net/xdp_sock_drv.h>
>
>  #define VIRTIO_XDP_FLAG        BIT(0)
> -#define VIRTIO_XMIT_DATA_MASK (VIRTIO_XDP_FLAG)
> +#define VIRTIO_XSK_FLAG        BIT(1)
> +#define VIRTIO_XMIT_DATA_MASK (VIRTIO_XDP_FLAG | VIRTIO_XSK_FLAG)
>
>  /* RX packet size EWMA. The average packet size is used to determine the=
 packet
>   * buffer size when refilling RX rings. As the entire RX ring may be ref=
illed
> diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> index dddd01962a3f..0e775a9d270f 100644
> --- a/drivers/net/virtio/xsk.c
> +++ b/drivers/net/virtio/xsk.c
> @@ -7,6 +7,114 @@
>
>  static struct virtio_net_hdr_mrg_rxbuf xsk_hdr;
>
> +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len=
)
> +{
> +       sg->dma_address =3D addr;
> +       sg->length =3D len;
> +}
> +
> +static void virtnet_xsk_check_queue(struct virtnet_sq *sq)
> +{
> +       struct virtnet_info *vi =3D sq->vq->vdev->priv;
> +       struct net_device *dev =3D vi->dev;
> +       int qnum =3D sq - vi->sq;
> +
> +       /* If it is a raw buffer queue, it does not check whether the sta=
tus
> +        * of the queue is stopped when sending. So there is no need to c=
heck
> +        * the situation of the raw buffer queue.
> +        */
> +       if (virtnet_is_xdp_raw_buffer_queue(vi, qnum))
> +               return;
> +
> +       /* If this sq is not the exclusive queue of the current cpu,
> +        * then it may be called by start_xmit, so check it running out
> +        * of space.
> +        *
> +        * Stop the queue to avoid getting packets that we are
> +        * then unable to transmit. Then wait the tx interrupt.
> +        */
> +       if (sq->vq->num_free < 2 + MAX_SKB_FRAGS)
> +               netif_stop_subqueue(dev, qnum);
> +}
> +
> +static int virtnet_xsk_xmit_one(struct virtnet_sq *sq,
> +                               struct xsk_buff_pool *pool,
> +                               struct xdp_desc *desc)
> +{
> +       struct virtnet_info *vi;
> +       dma_addr_t addr;
> +
> +       vi =3D sq->vq->vdev->priv;
> +
> +       addr =3D xsk_buff_raw_get_dma(pool, desc->addr);
> +       xsk_buff_raw_dma_sync_for_device(pool, addr, desc->len);
> +
> +       sg_init_table(sq->sg, 2);
> +
> +       sg_fill_dma(sq->sg, sq->xsk.hdr_dma_address, vi->hdr_len);
> +       sg_fill_dma(sq->sg + 1, addr, desc->len);
> +
> +       return virtqueue_add_outbuf(sq->vq, sq->sg, 2,
> +                                   virtnet_xsk_to_ptr(desc->len), GFP_AT=
OMIC);
> +}
> +
> +static int virtnet_xsk_xmit_batch(struct virtnet_sq *sq,
> +                                 struct xsk_buff_pool *pool,
> +                                 unsigned int budget,
> +                                 struct virtnet_sq_stats *stats)
> +{
> +       struct xdp_desc *descs =3D pool->tx_descs;
> +       u32 nb_pkts, max_pkts, i;
> +       bool kick =3D false;
> +       int err;
> +
> +       max_pkts =3D min_t(u32, budget, sq->vq->num_free / 2);

Need document why num_free / 2 is chosen here.

Others look fine.

Thanks


> +
> +       nb_pkts =3D xsk_tx_peek_release_desc_batch(pool, max_pkts);
> +       if (!nb_pkts)
> +               return 0;
> +
> +       for (i =3D 0; i < nb_pkts; i++) {
> +               err =3D virtnet_xsk_xmit_one(sq, pool, &descs[i]);
> +               if (unlikely(err))
> +                       break;
> +
> +               kick =3D true;
> +       }
> +
> +       if (kick && virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq=
->vq))
> +               ++stats->kicks;
> +
> +       stats->xdp_tx +=3D i;
> +
> +       return i;
> +}
> +
> +bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
> +                     int budget)
> +{
> +       struct virtnet_sq_stats stats =3D {};
> +       int sent;
> +
> +       virtnet_free_old_xmit(sq, true, &stats);
> +
> +       sent =3D virtnet_xsk_xmit_batch(sq, pool, budget, &stats);
> +
> +       virtnet_xsk_check_queue(sq);
> +
> +       u64_stats_update_begin(&sq->stats.syncp);
> +       sq->stats.packets +=3D stats.packets;
> +       sq->stats.bytes +=3D stats.bytes;
> +       sq->stats.kicks +=3D stats.kicks;
> +       sq->stats.xdp_tx +=3D stats.xdp_tx;
> +       u64_stats_update_end(&sq->stats.syncp);
> +
> +       if (xsk_uses_need_wakeup(pool))
> +               xsk_set_tx_need_wakeup(pool);
> +
> +       return sent =3D=3D budget;
> +}
> +
>  static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct virt=
net_rq *rq,
>                                     struct xsk_buff_pool *pool)
>  {
> diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
> index 1918285c310c..73ca8cd5308b 100644
> --- a/drivers/net/virtio/xsk.h
> +++ b/drivers/net/virtio/xsk.h
> @@ -3,5 +3,18 @@
>  #ifndef __XSK_H__
>  #define __XSK_H__
>
> +#define VIRTIO_XSK_FLAG_OFFSET 4
> +
> +static inline void *virtnet_xsk_to_ptr(u32 len)
> +{
> +       unsigned long p;
> +
> +       p =3D len << VIRTIO_XSK_FLAG_OFFSET;
> +
> +       return (void *)(p | VIRTIO_XSK_FLAG);
> +}
> +
>  int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xd=
p);
> +bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
> +                     int budget);
>  #endif
> --
> 2.32.0.3.g01195cf9f
>


