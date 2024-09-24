Return-Path: <bpf+bounces-40241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B060C983F34
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 09:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33451C2277B
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 07:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7669714B081;
	Tue, 24 Sep 2024 07:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZsmnmnM"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6092914831E
	for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 07:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163327; cv=none; b=MrVCWlJDdDtQioeDvSWNoDl8uHxSQVyWJAwHEDXXSn5Uhto31fWHaPICCu3AjK9L5O6rDZFEc3cf/En4xOHYc5w5KW92Q/K0QPm0dC+Qyuo8pRLU1F/FVqMWpsKGS3xr/nu9pUg8gANeqTmBqWn77y1fitnDyv+Z/V444X5JGM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163327; c=relaxed/simple;
	bh=nGrD9aJJ12vCH6ZjTw/xT3YBjiT6C05aP6mv5exXcVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jy1MeOZegV/ak7GFaFe5Jh20Bxk8T4uYe+Vg280DQBjWIx4MwzCOKwSJGgymRMEbq7OhDFg6SpPHYh0wppIzIwhnWBeb9PT8tlpBjQi0O3slPw7eYyMrPl6P/vruM2NmGHbPfpnxmc8bLLpg/tcMnc8CO3A1z9yXQ1P04tl68Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NZsmnmnM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727163324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SkdleeoYHmjV0rgCaK0PF5BOZ0On78yySbx4KlfG6Q8=;
	b=NZsmnmnMJh3XKrGP2bWD233SZlMorG9vvaXWb2ADrUre3q9MBMqEXzlxNGCHjmYZ75dZp4
	OKOYyX07i5kbyXlgxEoLn/6uBrOBn79Aui9ejtKkmCbwcy2fgfGBlKDe7wvXhKrhIxZwQX
	I6NhO3M9E8+zqCQyd1wJg2mC/OibsG8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-p6y58bvhPrOe-Pe8YrjuNQ-1; Tue, 24 Sep 2024 03:35:22 -0400
X-MC-Unique: p6y58bvhPrOe-Pe8YrjuNQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2da511a99e1so7309819a91.2
        for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 00:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727163321; x=1727768121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkdleeoYHmjV0rgCaK0PF5BOZ0On78yySbx4KlfG6Q8=;
        b=b9/mIxPEzKuQNCrEBQEh4kvtfMGfLEMYQVLRVkFlOnAfZPvVcYVnnmJfs7j6R9hl34
         pOg9kBJgIIp8E5291DkUTbVRHHVOttcVoWAf6e8XxuCdiugrR1tYGAz5woBhmkZiSLRH
         MP21MbNFEOmcXJvZDFgfZwVzGmeSlqi8G3hvVDitoOsZjZLKIz6437wcx0K0gqW/st1E
         eMxErfcCT6RrvAvhgsZ/2yHhhj0VzwXTNfly1KhQnot1CqgjEvoGdJ1cZtBM/d+Cef94
         jPnXmUCT1xHqunYmJRRQh6mLBGMOF8DAx8gBoTYCkRb24POC4tAaYdoIRBoKAPsZkl0C
         OSgA==
X-Forwarded-Encrypted: i=1; AJvYcCUcLZ9GXw3hnM+4X7STPVZgmYdX+r8ZamhCm+ZSjk/9DQXAapNDArTAdBTB8MCXneC11eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGjsUSh33k9K+kdARNpeupXL1McmMVJgRaON9UH8uLTcHeyKD2
	xZ+p3dYnOG7pLGC+HbI+5pC+3uAv2aZfZ8tdzCgaN50w8prccCTscxesHMuYefT22Cs5B+FdHDS
	4STqLqFf2BqjDv2O/+aIpOta5XzO/pdWF5Ehr2ApDVUWATULlvVyK8weFJgF1J/BpQvv/sqvIZF
	hi+VmTf+J8OmYSwWhecrkaRys7
X-Received: by 2002:a17:90b:80c:b0:2d3:bc5e:8452 with SMTP id 98e67ed59e1d1-2dd7f71b8ebmr17997764a91.32.1727163321288;
        Tue, 24 Sep 2024 00:35:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGtwmr8kXYoi5zPDyettpT9rzG7ud8DIrdWvD+E6J2/iSlGVYhMozMOkZyC1J7Ok5LgpKlekTQZNsNgBAlUCY=
X-Received: by 2002:a17:90b:80c:b0:2d3:bc5e:8452 with SMTP id
 98e67ed59e1d1-2dd7f71b8ebmr17997743a91.32.1727163320766; Tue, 24 Sep 2024
 00:35:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924013204.13763-1-xuanzhuo@linux.alibaba.com> <20240924013204.13763-11-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240924013204.13763-11-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Sep 2024 15:35:08 +0800
Message-ID: <CACGkMEvbxs4AK+xCW0i-ZMo4B5WEKMLmFHBu_7ZRa+4Pv+-44w@mail.gmail.com>
Subject: Re: [RFC net-next v1 10/12] virtio_net: xsk: tx: support xmit xsk buffer
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

On Tue, Sep 24, 2024 at 9:32=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> The driver's tx napi is very important for XSK. It is responsible for
> obtaining data from the XSK queue and sending it out.
>
> At the beginning, we need to trigger tx napi.
>
> virtnet_free_old_xmit distinguishes three type ptr(skb, xdp frame, xsk
> buffer) by the last bits of the pointer.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 176 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 166 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 3ad4c6e3ef18..1a870f1df910 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -83,6 +83,7 @@ struct virtnet_sq_free_stats {
>         u64 bytes;
>         u64 napi_packets;
>         u64 napi_bytes;
> +       u64 xsk;
>  };
>
>  struct virtnet_sq_stats {
> @@ -514,16 +515,20 @@ static struct sk_buff *virtnet_skb_append_frag(stru=
ct sk_buff *head_skb,
>                                                struct sk_buff *curr_skb,
>                                                struct page *page, void *b=
uf,
>                                                int len, int truesize);
> +static void virtnet_xsk_completed(struct send_queue *sq, int num);
>
>  enum virtnet_xmit_type {
>         VIRTNET_XMIT_TYPE_SKB,
>         VIRTNET_XMIT_TYPE_SKB_ORPHAN,
>         VIRTNET_XMIT_TYPE_XDP,
> +       VIRTNET_XMIT_TYPE_XSK,
>  };
>
>  /* We use the last two bits of the pointer to distinguish the xmit type.=
 */
>  #define VIRTNET_XMIT_TYPE_MASK (BIT(0) | BIT(1))
>
> +#define VIRTIO_XSK_FLAG_OFFSET 4

Any reason this is not 2?

> +
>  static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)
>  {
>         unsigned long p =3D (unsigned long)*ptr;
> @@ -546,6 +551,11 @@ static int virtnet_add_outbuf(struct send_queue *sq,=
 int num, void *data,
>                                     GFP_ATOMIC);
>  }
>
> +static u32 virtnet_ptr_to_xsk_buff_len(void *ptr)
> +{
> +       return ((unsigned long)ptr) >> VIRTIO_XSK_FLAG_OFFSET;
> +}
> +
>  static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len=
)
>  {
>         sg_assign_page(sg, NULL);
> @@ -587,11 +597,27 @@ static void __free_old_xmit(struct send_queue *sq, =
struct netdev_queue *txq,
>                         stats->bytes +=3D xdp_get_frame_len(frame);
>                         xdp_return_frame(frame);
>                         break;
> +
> +               case VIRTNET_XMIT_TYPE_XSK:
> +                       stats->bytes +=3D virtnet_ptr_to_xsk_buff_len(ptr=
);
> +                       stats->xsk++;
> +                       break;
>                 }
>         }
>         netdev_tx_completed_queue(txq, stats->napi_packets, stats->napi_b=
ytes);

Not related to this patch, but this seems unnecessary to AF_XDP.

>  }
>
> +static void virtnet_free_old_xmit(struct send_queue *sq,
> +                                 struct netdev_queue *txq,
> +                                 bool in_napi,
> +                                 struct virtnet_sq_free_stats *stats)
> +{
> +       __free_old_xmit(sq, txq, in_napi, stats);
> +
> +       if (stats->xsk)
> +               virtnet_xsk_completed(sq, stats->xsk);
> +}
> +
>  /* Converting between virtqueue no. and kernel tx/rx queue no.
>   * 0:rx0 1:tx0 2:rx1 3:tx1 ... 2N:rxN 2N+1:txN 2N+2:cvq
>   */
> @@ -1019,7 +1045,7 @@ static void free_old_xmit(struct send_queue *sq, st=
ruct netdev_queue *txq,
>  {
>         struct virtnet_sq_free_stats stats =3D {0};
>
> -       __free_old_xmit(sq, txq, in_napi, &stats);
> +       virtnet_free_old_xmit(sq, txq, in_napi, &stats);
>
>         /* Avoid overhead when no packets have been processed
>          * happens when called speculatively from start_xmit.
> @@ -1380,6 +1406,111 @@ static int virtnet_add_recvbuf_xsk(struct virtnet=
_info *vi, struct receive_queue
>         return err;
>  }
>
> +static void *virtnet_xsk_to_ptr(u32 len)
> +{
> +       unsigned long p;
> +
> +       p =3D len << VIRTIO_XSK_FLAG_OFFSET;
> +
> +       return virtnet_xmit_ptr_mix((void *)p, VIRTNET_XMIT_TYPE_XSK);
> +}
> +
> +static int virtnet_xsk_xmit_one(struct send_queue *sq,
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
> +       sg_fill_dma(sq->sg, sq->xsk_hdr_dma_addr, vi->hdr_len);
> +       sg_fill_dma(sq->sg + 1, addr, desc->len);
> +
> +       return virtqueue_add_outbuf(sq->vq, sq->sg, 2,
> +                                   virtnet_xsk_to_ptr(desc->len), GFP_AT=
OMIC);
> +}
> +
> +static int virtnet_xsk_xmit_batch(struct send_queue *sq,
> +                                 struct xsk_buff_pool *pool,
> +                                 unsigned int budget,
> +                                 u64 *kicks)
> +{
> +       struct xdp_desc *descs =3D pool->tx_descs;
> +       bool kick =3D false;
> +       u32 nb_pkts, i;
> +       int err;
> +
> +       budget =3D min_t(u32, budget, sq->vq->num_free);
> +
> +       nb_pkts =3D xsk_tx_peek_release_desc_batch(pool, budget);
> +       if (!nb_pkts)
> +               return 0;
> +
> +       for (i =3D 0; i < nb_pkts; i++) {
> +               err =3D virtnet_xsk_xmit_one(sq, pool, &descs[i]);
> +               if (unlikely(err)) {
> +                       xsk_tx_completed(sq->xsk_pool, nb_pkts - i);
> +                       break;
> +               }
> +
> +               kick =3D true;
> +       }
> +
> +       if (kick && virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq=
->vq))
> +               (*kicks)++;
> +
> +       return i;
> +}
> +
> +static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool=
 *pool,
> +                            int budget)
> +{
> +       struct virtnet_info *vi =3D sq->vq->vdev->priv;
> +       struct virtnet_sq_free_stats stats =3D {};
> +       struct net_device *dev =3D vi->dev;
> +       u64 kicks =3D 0;
> +       int sent;
> +
> +       /* Avoid to wakeup napi meanless, so call __free_old_xmit. */

I don't understand the meaning of this comment.

> +       __free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq), true, =
&stats);
> +
> +       if (stats.xsk)
> +               xsk_tx_completed(sq->xsk_pool, stats.xsk);
> +
> +       sent =3D virtnet_xsk_xmit_batch(sq, pool, budget, &kicks);
> +
> +       if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
> +               check_sq_full_and_disable(vi, vi->dev, sq);
> +
> +       u64_stats_update_begin(&sq->stats.syncp);
> +       u64_stats_add(&sq->stats.packets, stats.packets);
> +       u64_stats_add(&sq->stats.bytes,   stats.bytes);
> +       u64_stats_add(&sq->stats.kicks,   kicks);
> +       u64_stats_add(&sq->stats.xdp_tx,  sent);
> +       u64_stats_update_end(&sq->stats.syncp);
> +
> +       if (xsk_uses_need_wakeup(pool))
> +               xsk_set_tx_need_wakeup(pool);
> +
> +       return sent =3D=3D budget;
> +}
> +
> +static void xsk_wakeup(struct send_queue *sq)
> +{
> +       if (napi_if_scheduled_mark_missed(&sq->napi))
> +               return;
> +
> +       local_bh_disable();
> +       virtqueue_napi_schedule(&sq->napi, sq->vq);
> +       local_bh_enable();
> +}
> +
>  static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
>  {
>         struct virtnet_info *vi =3D netdev_priv(dev);
> @@ -1393,14 +1524,19 @@ static int virtnet_xsk_wakeup(struct net_device *=
dev, u32 qid, u32 flag)
>
>         sq =3D &vi->sq[qid];
>
> -       if (napi_if_scheduled_mark_missed(&sq->napi))
> -               return 0;
> +       xsk_wakeup(sq);
> +       return 0;
> +}
>
> -       local_bh_disable();
> -       virtqueue_napi_schedule(&sq->napi, sq->vq);
> -       local_bh_enable();
> +static void virtnet_xsk_completed(struct send_queue *sq, int num)
> +{
> +       xsk_tx_completed(sq->xsk_pool, num);
>
> -       return 0;
> +       /* If this is called by rx poll, start_xmit and xdp xmit we shoul=
d
> +        * wakeup the tx napi to consume the xsk tx queue, because the tx
> +        * interrupt may not be triggered.
> +        */
> +       xsk_wakeup(sq);
>  }
>
>  static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
> @@ -1516,8 +1652,8 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>         }
>
>         /* Free up any pending old buffers before queueing new ones. */
> -       __free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq),
> -                       false, &stats);
> +       virtnet_free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq),
> +                             false, &stats);
>
>         for (i =3D 0; i < n; i++) {
>                 struct xdp_frame *xdpf =3D frames[i];
> @@ -2961,6 +3097,7 @@ static int virtnet_poll_tx(struct napi_struct *napi=
, int budget)
>         struct virtnet_info *vi =3D sq->vq->vdev->priv;
>         unsigned int index =3D vq2txq(sq->vq);
>         struct netdev_queue *txq;
> +       bool xsk_busy =3D false;
>         int opaque;
>         bool done;
>
> @@ -2973,7 +3110,11 @@ static int virtnet_poll_tx(struct napi_struct *nap=
i, int budget)
>         txq =3D netdev_get_tx_queue(vi->dev, index);
>         __netif_tx_lock(txq, raw_smp_processor_id());
>         virtqueue_disable_cb(sq->vq);
> -       free_old_xmit(sq, txq, !!budget);
> +
> +       if (sq->xsk_pool)
> +               xsk_busy =3D virtnet_xsk_xmit(sq, sq->xsk_pool, budget);

I think we need a better name of "xsk_busy", it looks like it means we
exceeds the quota. Or just return the number of buffers received and
let the caller to judge.

Other looks good.

With this fixed.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


