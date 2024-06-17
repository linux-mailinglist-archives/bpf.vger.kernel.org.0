Return-Path: <bpf+bounces-32271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FB890A5D9
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 08:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492BB1F21871
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 06:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9272F187337;
	Mon, 17 Jun 2024 06:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWGZ/Nkq"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8A01862B8
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 06:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718605826; cv=none; b=Bd1/3zsFKF2U4y1OWz5hoOgG6xB5jpXphAt+qAGQ/9f+zzYSVKHTNlrRPamLqL7Zo9wKumo8D++MwmVnJt3ES1/sPAofyLUmiwggfxnzoR/XnZDypa8sDcoC2kc/shB6LFC3HWLozFlPVdvUQ+MO2UwleZC4XYNwVgtfm2VZeRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718605826; c=relaxed/simple;
	bh=1vNAZpaWLsDmOCQWHPjOdnJz1MkV43RHrHiSXdX7QSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AS69TbRvgG7toAPfsr+5AA9xrsX5oXW5hpxUMk99X9kokPgQm1v8isJpxxKS9i9aEfLsI03+oJOB8bp0Z5p6QmG7wLRxZdRcShJndgF2uyL8+EWtD+jKF/Iiq5hf7AWOyBgxzFp4Cz8xqhkRV2lFf+q2n+LyAvAZ03PmLpTwYwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GWGZ/Nkq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718605823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l906IYyq70SFyJgtFbhtA8WRiFy7rbwEmyMP36goir0=;
	b=GWGZ/Nkq9Xbny66TO1u7WgmjAFGIqUlnn7XpHXLjUibz7zOJEHINWQkLVnG3d0WAjj/fop
	QzTF3yITmm3TlkkcLMqpjosql7HrEnbKI4K3M8Qr+slQsk5TLpvS9cVsw7fcsDNb/OdRRF
	s1Qftf9t+JFZoa6NuLJMwPVnEy3Bwdc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-NFFQculLOQ2dUKQv2YeIYQ-1; Mon, 17 Jun 2024 02:30:21 -0400
X-MC-Unique: NFFQculLOQ2dUKQv2YeIYQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-6507e2f0615so3586980a12.1
        for <bpf@vger.kernel.org>; Sun, 16 Jun 2024 23:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718605821; x=1719210621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l906IYyq70SFyJgtFbhtA8WRiFy7rbwEmyMP36goir0=;
        b=bAvj6jxpbsxt4UkqcIf+DmlIcO/1zJlW5gjdIZBIm+L4bjAPSwmW7tlQj2X5h8rMun
         IMcNwkl8T3hhJbmQfXtArKJBPtZvPrcAQLnOXs5pQ96k9GwFKfwCsrkwdZ0jqqGZmn81
         xexeQHc2FZi+47svCh6jJgSHyC/KsPnV9SKWVDIDyR2rqVcd2IHU30wLgkxbsys0K6OF
         7mmVLKVIjgUFCuLFq6MkBpmSQhHImctTlH3zDxNJWMrTS5pCin8dJWZUsUFtToCy1Vhl
         dd6FX9qynrrbhW35QmcYrp35JUBsbZSaZ0eFbCpR5Xb3oJHkaPV7ltlXMRs/2rAeVbzA
         J9pg==
X-Forwarded-Encrypted: i=1; AJvYcCXRGrBe2VTSBR6HBnXTh3H3xnlunBIcvw4YH0UdyogQO0WL8nmX2whygLfDLfMWGkmKYm+cl7eH3pfJvPDTJqOB0cJW
X-Gm-Message-State: AOJu0YxfeJKDfk6ar4tATDS0utYDJPn8CBdKMc/O8BizNgpT+Xlf0zJq
	lf8N9deT3ZdYlgqt1blZDMb/RYabF5mLzdOcO1JPAmpd0hikYcR74LIYyXncb1dRcTQcZQtHHmF
	ta90YCQRG54K8JwRnybX2UfBCDINq2IWfxIL0suBldChfI8jE/vUxmTAV3q/721H0mudNV/d1ev
	MHJxcb+O1SoAPkbJbk/4+7gXZf
X-Received: by 2002:a05:6a20:9187:b0:1b6:245d:7e58 with SMTP id adf61e73a8af0-1bae7eb9feemr8783615637.23.1718605820900;
        Sun, 16 Jun 2024 23:30:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFqQ1FgUq82J4MpPNruV45skSqWPLiKNK0Uzc8J41/jRNuyAR1XP4rOEjZ/IkXhyLdO/Ss0z/gPvKHjtrsLYg=
X-Received: by 2002:a05:6a20:9187:b0:1b6:245d:7e58 with SMTP id
 adf61e73a8af0-1bae7eb9feemr8783592637.23.1718605820508; Sun, 16 Jun 2024
 23:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com> <20240614063933.108811-12-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240614063933.108811-12-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jun 2024 14:30:07 +0800
Message-ID: <CACGkMEsWg95zXVsnDWrAU1qRS0uuEJJR0rw7LVOV-fGuBGzQCQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 11/15] virtio_net: xsk: tx: support xmit xsk buffer
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

On Fri, Jun 14, 2024 at 2:40=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> The driver's tx napi is very important for XSK. It is responsible for
> obtaining data from the XSK queue and sending it out.
>
> At the beginning, we need to trigger tx napi.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 121 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 119 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2767338dc060..7e811f392768 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -535,10 +535,13 @@ enum virtnet_xmit_type {
>         VIRTNET_XMIT_TYPE_SKB,
>         VIRTNET_XMIT_TYPE_XDP,
>         VIRTNET_XMIT_TYPE_DMA,
> +       VIRTNET_XMIT_TYPE_XSK,
>  };
>
>  #define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT_TYP=
E_XDP \
> -                               | VIRTNET_XMIT_TYPE_DMA)
> +                               | VIRTNET_XMIT_TYPE_DMA | VIRTNET_XMIT_TY=
PE_XSK)
> +
> +#define VIRTIO_XSK_FLAG_OFFSET 4
>
>  static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)
>  {
> @@ -768,6 +771,10 @@ static void __free_old_xmit(struct send_queue *sq, b=
ool in_napi,
>                          * func again.
>                          */
>                         goto retry;
> +
> +               case VIRTNET_XMIT_TYPE_XSK:
> +                       /* Make gcc happy. DONE in subsequent commit */

This is probably a hint that the next patch should be squashed here.

> +                       break;
>                 }
>         }
>  }
> @@ -1265,6 +1272,102 @@ static void check_sq_full_and_disable(struct virt=
net_info *vi,
>         }
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
> +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len=
)
> +{
> +       sg->dma_address =3D addr;
> +       sg->length =3D len;
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
> +       sg_fill_dma(sq->sg, sq->xsk.hdr_dma_address, vi->hdr_len);
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
> +                       xsk_tx_completed(sq->xsk.pool, nb_pkts - i);
> +                       break;

Any reason we don't need a kick here?

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
> +       u64 kicks =3D 0;
> +       int sent;
> +
> +       __free_old_xmit(sq, true, &stats);
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
>  static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
>                                    struct send_queue *sq,
>                                    struct xdp_frame *xdpf)
> @@ -2707,6 +2810,7 @@ static int virtnet_poll_tx(struct napi_struct *napi=
, int budget)
>         struct virtnet_info *vi =3D sq->vq->vdev->priv;
>         unsigned int index =3D vq2txq(sq->vq);
>         struct netdev_queue *txq;
> +       bool xsk_busy =3D false;
>         int opaque;
>         bool done;
>
> @@ -2719,7 +2823,11 @@ static int virtnet_poll_tx(struct napi_struct *nap=
i, int budget)
>         txq =3D netdev_get_tx_queue(vi->dev, index);
>         __netif_tx_lock(txq, raw_smp_processor_id());
>         virtqueue_disable_cb(sq->vq);
> -       free_old_xmit(sq, true);
> +
> +       if (sq->xsk.pool)
> +               xsk_busy =3D virtnet_xsk_xmit(sq, sq->xsk.pool, budget);

How about rename this to "xsk_sent"?

> +       else
> +               free_old_xmit(sq, true);
>
>         if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
>                 if (netif_tx_queue_stopped(txq)) {
> @@ -2730,6 +2838,11 @@ static int virtnet_poll_tx(struct napi_struct *nap=
i, int budget)
>                 netif_tx_wake_queue(txq);
>         }
>
> +       if (xsk_busy) {
> +               __netif_tx_unlock(txq);
> +               return budget;
> +       }
> +
>         opaque =3D virtqueue_enable_cb_prepare(sq->vq);
>
>         done =3D napi_complete_done(napi, 0);
> @@ -5715,6 +5828,10 @@ static void virtnet_sq_free_unused_buf(struct virt=
queue *vq, void *buf)
>         case VIRTNET_XMIT_TYPE_DMA:
>                 virtnet_sq_unmap(sq, &buf);
>                 goto retry;
> +
> +       case VIRTNET_XMIT_TYPE_XSK:
> +               /* Make gcc happy. DONE in subsequent commit */
> +               break;
>         }
>  }
>
> --
> 2.32.0.3.g01195cf9f
>

Thanks


