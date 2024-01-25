Return-Path: <bpf+bounces-20297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBFE83B865
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 04:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0487BB20CA3
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 03:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A236FCA;
	Thu, 25 Jan 2024 03:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRgsuuJ0"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B686FBE
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 03:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706153960; cv=none; b=t4wzRQtFxAsdvMV5AscQVUdpFZfGQAOps8R0p/0htuZr9DWoW4FWyo0dPkIFgJRHP6c/150IZv4RW35/d5hpkXSS4hIPAgfF3JeDQ97DIHuQ8tHMpuBKCNVnx8CXu2JBvj3l/JmlqoW3/YHrD1Sl0jwgU57Y66jOwnIl1Hn39kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706153960; c=relaxed/simple;
	bh=aYtraKeg/phW07/7iPMWoTxqzaJdJOv0+Sxt7exwBJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUanzzn7fBt2m2LgPKv2gk2pwYtHcWAgKRpoVjlUOETMuCjXeLTg0u0H+dhUGx8IZudi4anF9hmFqIQOoNsaY6DKuLWiM0Rjcy+FHKrYjXprf+Jvbfs8L9JlgNzbrshXqOp4H1FwbiHO+M+bjzZ/+UElouMihS295gbXstBru0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gRgsuuJ0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706153957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7+kv1E8M93VST5z9hGMNp++MAPNLoKeq0RXuFtSVRPM=;
	b=gRgsuuJ0jhKlJYXDngQJze+wBkKplSGK3q9O0+dfdVzwP8AkNDvZv/0dAhxIl+6vYFWIIs
	TPnr0jym0Zvvk/NYtAu/+vzH3vmSSVhXIR7ssi2wyQp2pSM2FcU5F2vaBcqNA5XVDC8vGg
	Tor9NcAwH9PDuczUPrjCEaZT9UJb2wg=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-cEuhwJeZPpSkvmdV57us1A-1; Wed, 24 Jan 2024 22:39:15 -0500
X-MC-Unique: cEuhwJeZPpSkvmdV57us1A-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5cf555b2a53so280982a12.1
        for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 19:39:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706153955; x=1706758755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+kv1E8M93VST5z9hGMNp++MAPNLoKeq0RXuFtSVRPM=;
        b=vFN57Rj2fsX+EgbDHKd8k/1gYsL//9aJbDz4UzpDszEcA1r9ctWry+q694z8I5tKpV
         6yNTkG3iHfjxWttmuY/Qw2BqL+f2cdGkTOESRP2cEWxcSLWh3NaFOTdsifRRmLim6P1x
         ixybukXNpTtNNFKk0FhjSTDgBzGgRXY3HFO08NL3TKbX11mGURFQfqfVyRKtxwtcqIzB
         jGwwooVZiERwJV6N9DjXaJFtdtyYtmbGxbILMdNszLNMRebQSssKiyhOY9acKtOMlb18
         ievtxY2p1CBWQNHXMYEVfJKwN51KsKv016lXkDW82LCBpLcGSS2o8I7iYpKELi3BbpPI
         eUFg==
X-Gm-Message-State: AOJu0YwEpQ5JCLu9WOUIjomEiDb8Z83RFN29IyNw43+4bcZjkQnBMnEl
	6sRCpgQn7ApYqUVputrcbWOapvVV68FL0tMutka31eyrWjohpBdNrgLFbrsDVCUVwpxpf/AuwQo
	tYdhIk3RrOSV8ud8qpIaqymxnYoOD3N4QuvNp4xuWizQLOGGnInSgDCiO0c2h+GYvZ4OrWhVl+b
	5UD14uVIvkZcE9WpeiVNxhC4mx
X-Received: by 2002:a05:6a20:938d:b0:19a:f0ef:ffc with SMTP id x13-20020a056a20938d00b0019af0ef0ffcmr561787pzh.3.1706153954765;
        Wed, 24 Jan 2024 19:39:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVvYsNNKLu8vKw6h7D0IpqxiuwRhcQvL/n+p++mwu2Jx6DGQNuoinfcujLAu57LUqNpXdniTVSTxpEPUGA4Ms=
X-Received: by 2002:a05:6a20:938d:b0:19a:f0ef:ffc with SMTP id
 x13-20020a056a20938d00b0019af0ef0ffcmr561774pzh.3.1706153954482; Wed, 24 Jan
 2024 19:39:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com> <20240116075924.42798-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240116075924.42798-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Jan 2024 11:39:03 +0800
Message-ID: <CACGkMEtSnuo6yAsiFZkrv6bMaJtLXuLQtL-qvKn-Y_L_PLHdcw@mail.gmail.com>
Subject: Re: [PATCH net-next 4/5] virtio_ring: introduce virtqueue_get_dma_premapped()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Introduce helper virtqueue_get_dma_premapped(), then the driver
> can know whether dma unmap is needed.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/main.c       | 22 +++++++++-------------
>  drivers/net/virtio/virtio_net.h |  3 ---
>  drivers/virtio/virtio_ring.c    | 22 ++++++++++++++++++++++
>  include/linux/virtio.h          |  1 +
>  4 files changed, 32 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index 186b2cf5d8fc..4fbf612da235 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -483,7 +483,7 @@ static void *virtnet_rq_get_buf(struct virtnet_rq *rq=
, u32 *len, void **ctx)
>         void *buf;
>
>         buf =3D virtqueue_get_buf_ctx(rq->vq, len, ctx);
> -       if (buf && rq->do_dma)
> +       if (buf && virtqueue_get_dma_premapped(rq->vq))
>                 virtnet_rq_unmap(rq, buf, *len);
>
>         return buf;
> @@ -496,7 +496,7 @@ static void virtnet_rq_init_one_sg(struct virtnet_rq =
*rq, void *buf, u32 len)
>         u32 offset;
>         void *head;
>
> -       if (!rq->do_dma) {
> +       if (!virtqueue_get_dma_premapped(rq->vq)) {
>                 sg_init_one(rq->sg, buf, len);
>                 return;
>         }
> @@ -526,7 +526,7 @@ static void *virtnet_rq_alloc(struct virtnet_rq *rq, =
u32 size, gfp_t gfp)
>
>         head =3D page_address(alloc_frag->page);
>
> -       if (rq->do_dma) {
> +       if (virtqueue_get_dma_premapped(rq->vq)) {
>                 dma =3D head;
>
>                 /* new pages */
> @@ -580,12 +580,8 @@ static void virtnet_rq_set_premapped(struct virtnet_=
info *vi)
>         if (!vi->mergeable_rx_bufs && vi->big_packets)
>                 return;
>
> -       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> -               if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> -                       continue;
> -
> -               vi->rq[i].do_dma =3D true;
> -       }
> +       for (i =3D 0; i < vi->max_queue_pairs; i++)
> +               virtqueue_set_dma_premapped(vi->rq[i].vq);
>  }
>
>  static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
> @@ -1643,7 +1639,7 @@ static int add_recvbuf_small(struct virtnet_info *v=
i, struct virtnet_rq *rq,
>
>         err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp)=
;
>         if (err < 0) {
> -               if (rq->do_dma)
> +               if (virtqueue_get_dma_premapped(rq->vq))
>                         virtnet_rq_unmap(rq, buf, 0);
>                 put_page(virt_to_head_page(buf));
>         }
> @@ -1758,7 +1754,7 @@ static int add_recvbuf_mergeable(struct virtnet_inf=
o *vi,
>         ctx =3D mergeable_len_to_ctx(len + room, headroom);
>         err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp)=
;
>         if (err < 0) {
> -               if (rq->do_dma)
> +               if (virtqueue_get_dma_premapped(rq->vq))
>                         virtnet_rq_unmap(rq, buf, 0);
>                 put_page(virt_to_head_page(buf));
>         }
> @@ -4007,7 +4003,7 @@ static void free_receive_page_frags(struct virtnet_=
info *vi)
>         int i;
>         for (i =3D 0; i < vi->max_queue_pairs; i++)
>                 if (vi->rq[i].alloc_frag.page) {
> -                       if (vi->rq[i].do_dma && vi->rq[i].last_dma)
> +                       if (virtqueue_get_dma_premapped(vi->rq[i].vq) && =
vi->rq[i].last_dma)
>                                 virtnet_rq_unmap(&vi->rq[i], vi->rq[i].la=
st_dma, 0);
>                         put_page(vi->rq[i].alloc_frag.page);
>                 }
> @@ -4035,7 +4031,7 @@ static void virtnet_rq_free_unused_bufs(struct virt=
queue *vq)
>         rq =3D &vi->rq[i];
>
>         while ((buf =3D virtqueue_detach_unused_buf(vq)) !=3D NULL) {
> -               if (rq->do_dma)
> +               if (virtqueue_get_dma_premapped(rq->vq))
>                         virtnet_rq_unmap(rq, buf, 0);
>
>                 virtnet_rq_free_buf(vi, rq, buf);
> diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_=
net.h
> index b28a4d0a3150..066a2b9d2b3c 100644
> --- a/drivers/net/virtio/virtio_net.h
> +++ b/drivers/net/virtio/virtio_net.h
> @@ -115,9 +115,6 @@ struct virtnet_rq {
>
>         /* Record the last dma info to free after new pages is allocated.=
 */
>         struct virtnet_rq_dma *last_dma;
> -
> -       /* Do dma by self */
> -       bool do_dma;
>  };
>
>  struct virtnet_info {
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 2c5089d3b510..9092bcdebb53 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2905,6 +2905,28 @@ int virtqueue_set_dma_premapped(struct virtqueue *=
_vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_set_dma_premapped);
>
> +/**
> + * virtqueue_get_dma_premapped - get the vring premapped mode
> + * @_vq: the struct virtqueue we're talking about.
> + *
> + * Get the premapped mode of the vq.
> + *
> + * Returns bool for the vq premapped mode.
> + */
> +bool virtqueue_get_dma_premapped(struct virtqueue *_vq)
> +{
> +       struct vring_virtqueue *vq =3D to_vvq(_vq);
> +       bool premapped;
> +
> +       START_USE(vq);
> +       premapped =3D vq->premapped;
> +       END_USE(vq);

Why do we need to protect premapped like this? Is the user allowed to
change it on the fly?

Thanks


