Return-Path: <bpf+bounces-32273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 444E190A686
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 09:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE43B1F217EE
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 07:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91044187339;
	Mon, 17 Jun 2024 07:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBsh5nmq"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8113569D31
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 07:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718608268; cv=none; b=mHtiHTD8aeaNUDytOgSWK6ZWZ5ZZpNUdXizq/MGN9jeHZ9EEbEDKOKYI0KSnEqAO5G5f6ImwnJp14ywISQbFDiNhdf/k2ALwkTLyEUUAVSkPu3JK2YOIuhcbwbvULmzFOZM4hNh981IYNBVROi70OOb51Xyo8yDMZp54cNJ76ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718608268; c=relaxed/simple;
	bh=6633V2bjhmmnWxtMqMCNjlvJya1ZhAcbR8OTqtJTJ5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NAW58GKX9ysPChW2h1DLcscuyxOALG4cFxRqVIl8BTeq9Kt/LEIe5gz2SabJO4mhcyJvTfyz3vgSUt2ZYsa3kIN0q9XzHm2qTlYDluJGHSJxGmNcK2r8Ct9Mi5ackC9papxU//IbOJvC0heDI0Tgz3oK/KZ+gEpQw5RMK8NUeGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fBsh5nmq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718608265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0A6xFIxYVYWY8NB35Vto5VqJn6J8P3Bcug0GbeOWLGc=;
	b=fBsh5nmqrOHinoUfS0lWMQ/JNkPyU2VJUab3KdCbTSqrGKQXxi4IdFFm8R9VJ340JWPRpc
	hQezhvwtj1ZrOSeF5dwemTC54QoWgoJyLuh2CAy3f2L+E8ItkjX0B722qmIdQNBbr4r+E/
	S/tHpcwWhjFqODqbKlgF2VdzGrw3IOY=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-pOq9CxOQMdW1eiB4Ry_RBQ-1; Mon, 17 Jun 2024 03:11:04 -0400
X-MC-Unique: pOq9CxOQMdW1eiB4Ry_RBQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-6e79f0ff303so3220414a12.2
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 00:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718608263; x=1719213063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0A6xFIxYVYWY8NB35Vto5VqJn6J8P3Bcug0GbeOWLGc=;
        b=GSWu9FSusAS779JoDga4vvhPq/KZeXCk6WfhFpODxyrM12WrCEReh9EooupitBpY88
         k1CDGl8Ha+op8L5ESzkj9yVFcR7o5MrqgfG0VEmdqqMxlEsi3GXSUIy8VoJgMAfieOWh
         YQ92OB5YqwN4PVWmKeOmI/cstIsW+zde0tgE04dj+2S8we8dLnTOauXFQymrg2lo4TyX
         NFPcnGhMPqUqZRMv+9G4bi30CmTm1TtodRXdaOGv5nvrpsxg5o/YCkruXbqRahB1IPyL
         FGjdA1ihQWhh+/8Yo9AGb7lALUQfTw/qzpXRvY7dJr0tuT0RXw47gHEVuIDje2sVZfxR
         dv1w==
X-Forwarded-Encrypted: i=1; AJvYcCUAV2XaCgWCmheRiQk9AxmX5g1psh+T62gbiUJpUpm9w2ZG1VBrLdtJbbneVkUGO+MdiQngsdMJ91nFPAOi6NCVC30c
X-Gm-Message-State: AOJu0YxbGuVXKnrSBWc84YOQEnGFKV1vHJ1OLqDsfQK7y8sj9f7lodxw
	Lqsv7BQ6Pw33UvuNVLS5fdoV1uaFFMb/XkyRQVV32ab6Jcy0nnnaR39I21qD2aB7IajDIL3W1wt
	OLCuL/ztLkRqGC9YG9wW9yhu/VBAXBA3Kgz93bt3CRqj+ksyURsEEgyDh8F7FcRMtT8+wbjapZC
	hgKMOpGH2+kTd56KGM6Kq+ANaSq/JUbE/mQJw=
X-Received: by 2002:a05:6a20:914d:b0:1b5:c8f2:4a9 with SMTP id adf61e73a8af0-1bae7ec28e5mr9515771637.25.1718608262713;
        Mon, 17 Jun 2024 00:11:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9p3V6xtCzT5QURZCOGaQAU5h2vPd+q2x2ohZ1OoECgrFwwBLYJygGsSCnAnxNQlqFMIYvzpScu9iumunpHW8=
X-Received: by 2002:a05:6a20:914d:b0:1b5:c8f2:4a9 with SMTP id
 adf61e73a8af0-1bae7ec28e5mr9515742637.25.1718608262295; Mon, 17 Jun 2024
 00:11:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com> <20240614063933.108811-16-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240614063933.108811-16-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jun 2024 15:10:48 +0800
Message-ID: <CACGkMEtzWQLN9D9+5jZFcn4MNNfDPQ77TK3D5B78NXPyq5u-Gg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 15/15] virtio_net: xsk: rx: support recv small mode
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

On Fri, Jun 14, 2024 at 2:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> The virtnet_xdp_handler() is re-used. But
>
> 1. We need to copy data to create skb for XDP_PASS.
> 2. We need to call xsk_buff_free() to release the buffer.
> 3. The handle for xdp_buff is difference.
>
> If we pushed this logic into existing receive handle(merge and small),
> we would have to maintain code scattered inside merge and small (and big)=
.
> So I think it is a good choice for us to put the xsk code into an
> independent function.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 142 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 138 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4e5645d8bb7d..72c4d2f0c0ea 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -534,8 +534,10 @@ struct virtio_net_common_hdr {
>
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
>  static void virtnet_xsk_completed(struct send_queue *sq, int num);
> -static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct recei=
ve_queue *rq,
> -                                  struct xsk_buff_pool *pool, gfp_t gfp)=
;
> +static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buf=
f *xdp,
> +                              struct net_device *dev,
> +                              unsigned int *xdp_xmit,
> +                              struct virtnet_rq_stats *stats);
>
>  enum virtnet_xmit_type {
>         VIRTNET_XMIT_TYPE_SKB,
> @@ -1218,6 +1220,11 @@ static void virtnet_rq_unmap_free_buf(struct virtq=
ueue *vq, void *buf)
>
>         rq =3D &vi->rq[i];
>
> +       if (rq->xsk.pool) {
> +               xsk_buff_free((struct xdp_buff *)buf);
> +               return;
> +       }
> +
>         if (!vi->big_packets || vi->mergeable_rx_bufs)
>                 virtnet_rq_unmap(rq, buf, 0);
>
> @@ -1308,6 +1315,120 @@ static void sg_fill_dma(struct scatterlist *sg, d=
ma_addr_t addr, u32 len)
>         sg->length =3D len;
>  }
>
> +static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
> +                                  struct receive_queue *rq, void *buf, u=
32 len)
> +{
> +       struct xdp_buff *xdp;
> +       u32 bufsize;
> +
> +       xdp =3D (struct xdp_buff *)buf;
> +
> +       bufsize =3D xsk_pool_get_rx_frame_size(rq->xsk.pool) + vi->hdr_le=
n;
> +
> +       if (unlikely(len > bufsize)) {
> +               pr_debug("%s: rx error: len %u exceeds truesize %u\n",
> +                        vi->dev->name, len, bufsize);
> +               DEV_STATS_INC(vi->dev, rx_length_errors);
> +               xsk_buff_free(xdp);
> +               return NULL;
> +       }
> +
> +       xsk_buff_set_size(xdp, len);
> +       xsk_buff_dma_sync_for_cpu(xdp);
> +
> +       return xdp;
> +}
> +
> +static struct sk_buff *xdp_construct_skb(struct receive_queue *rq,
> +                                        struct xdp_buff *xdp)
> +{
> +       unsigned int metasize =3D xdp->data - xdp->data_meta;
> +       struct sk_buff *skb;
> +       unsigned int size;
> +
> +       size =3D xdp->data_end - xdp->data_hard_start;
> +       skb =3D napi_alloc_skb(&rq->napi, size);
> +       if (unlikely(!skb)) {
> +               xsk_buff_free(xdp);
> +               return NULL;
> +       }
> +
> +       skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
> +
> +       size =3D xdp->data_end - xdp->data_meta;
> +       memcpy(__skb_put(skb, size), xdp->data_meta, size);
> +
> +       if (metasize) {
> +               __skb_pull(skb, metasize);
> +               skb_metadata_set(skb, metasize);
> +       }
> +
> +       xsk_buff_free(xdp);
> +
> +       return skb;
> +}
> +
> +static struct sk_buff *virtnet_receive_xsk_small(struct net_device *dev,=
 struct virtnet_info *vi,
> +                                                struct receive_queue *rq=
, struct xdp_buff *xdp,
> +                                                unsigned int *xdp_xmit,
> +                                                struct virtnet_rq_stats =
*stats)
> +{
> +       struct bpf_prog *prog;
> +       u32 ret;
> +
> +       ret =3D XDP_PASS;
> +       rcu_read_lock();
> +       prog =3D rcu_dereference(rq->xdp_prog);
> +       if (prog)
> +               ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, sta=
ts);
> +       rcu_read_unlock();
> +
> +       switch (ret) {
> +       case XDP_PASS:
> +               return xdp_construct_skb(rq, xdp);
> +
> +       case XDP_TX:
> +       case XDP_REDIRECT:
> +               return NULL;
> +
> +       default:
> +               /* drop packet */
> +               xsk_buff_free(xdp);
> +               u64_stats_inc(&stats->drops);
> +               return NULL;
> +       }
> +}

Let's use a separate patch for this to decouple new functions with refactor=
ing.

Or even use a separate series for rx zerocopy.

> +
> +static struct sk_buff *virtnet_receive_xsk_buf(struct virtnet_info *vi, =
struct receive_queue *rq,
> +                                              void *buf, u32 len,
> +                                              unsigned int *xdp_xmit,
> +                                              struct virtnet_rq_stats *s=
tats)
> +{
> +       struct net_device *dev =3D vi->dev;
> +       struct sk_buff *skb =3D NULL;
> +       struct xdp_buff *xdp;
> +
> +       len -=3D vi->hdr_len;
> +
> +       u64_stats_add(&stats->bytes, len);
> +
> +       xdp =3D buf_to_xdp(vi, rq, buf, len);
> +       if (!xdp)
> +               return NULL;

Don't we need to check if XDP is enabled before those operations?

> +
> +       if (unlikely(len < ETH_HLEN)) {
> +               pr_debug("%s: short packet %i\n", dev->name, len);
> +               DEV_STATS_INC(dev, rx_length_errors);
> +               xsk_buff_free(xdp);
> +               return NULL;
> +       }
> +
> +       if (!vi->mergeable_rx_bufs)
> +               skb =3D virtnet_receive_xsk_small(dev, vi, rq, xdp, xdp_x=
mit, stats);
> +
> +       return skb;
> +}
> +
>  static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct recei=
ve_queue *rq,
>                                    struct xsk_buff_pool *pool, gfp_t gfp)
>  {
> @@ -2713,9 +2834,22 @@ static int virtnet_receive(struct receive_queue *r=
q, int budget,
>         void *buf;
>         int i;
>
> -       if (!vi->big_packets || vi->mergeable_rx_bufs) {
> -               void *ctx;
> +       if (rq->xsk.pool) {
> +               struct sk_buff *skb;
> +
> +               while (packets < budget) {
> +                       buf =3D virtqueue_get_buf(rq->vq, &len);
> +                       if (!buf)
> +                               break;
>
> +                       skb =3D virtnet_receive_xsk_buf(vi, rq, buf, len,=
 xdp_xmit, &stats);

The function name is confusing for example, xsk might not be even enabled.

> +                       if (skb)
> +                               virtnet_receive_done(vi, rq, skb);
> +
> +                       packets++;
> +               }
> +       } else if (!vi->big_packets || vi->mergeable_rx_bufs) {
> +               void *ctx;
>                 while (packets < budget &&
>                        (buf =3D virtnet_rq_get_buf(rq, &len, &ctx))) {
>                         receive_buf(vi, rq, buf, len, ctx, xdp_xmit, &sta=
ts);
> --
> 2.32.0.3.g01195cf9f
>

Thanks


