Return-Path: <bpf+bounces-33462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE9891D694
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 05:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315241C2100C
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 03:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900FF171AF;
	Mon,  1 Jul 2024 03:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zy3VtTO8"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E748D535
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 03:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719804355; cv=none; b=l1D3qt/5TrjdBbByUo1Xdn4HFZFc7wJtT9NGLYLA+DIDNyLhOAQRFcn6kAVV1yJND9AILPjXtwCj+bg0Z4y7oLgbOcp6Rg4Rt8EXb2HbSNIi3Z92SOOy9Rc4Z7x88r1nlI7D/rcYkg9hmETPn7jhhGcK0saxYPCNHeRMXQMuSbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719804355; c=relaxed/simple;
	bh=s4nVTK2KTbIjVdx28ShlaPVwenhKfgYKoF82q7KJQis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sezbSX+9Vsz2Kt/Gffnuh7B+2Zc2lD+1c9QOw3FNg7xMcaEbw2NSkDxXySk/l/Rqdy4DOT6dTGLtNegg+5sumv3E03ToenDPqJ1iMbVIcVKUUqIo7of/MBEkIgp8+NaeXDU/zgC1D0CcGPZguEV/snPCaYxt8xbBA/kn0e2KJtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zy3VtTO8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719804352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYy/QXHWlN/QqTcjaImGGNsQrVgv7jQprJu9HBpYjGs=;
	b=Zy3VtTO8vjmsBoz6nlv+6DQNZ/EPWcr6hfF3OX6uUZejdMkeMSuGwXQ1y+m71xr5x8tvcT
	tJSVWLduNh1x4ScEpOrCGihqB+2WvzQ7SrEes965AkMEJLCvLTjwh/xIs2hsRz7a+r9t8G
	m54uBM6/02DdEcSjXdFOlra1Nyeto+4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-GtxgNExJMTKl-YQ28d_Vgw-1; Sun, 30 Jun 2024 23:25:50 -0400
X-MC-Unique: GtxgNExJMTKl-YQ28d_Vgw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c9351da06bso2106511a91.3
        for <bpf@vger.kernel.org>; Sun, 30 Jun 2024 20:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719804350; x=1720409150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYy/QXHWlN/QqTcjaImGGNsQrVgv7jQprJu9HBpYjGs=;
        b=NOAL/9MeFY+I6thTb6/0HZuYT8D4UyIYopNAj3p/t4dFtFcDvIc/f7H3Hv3qW48/b9
         spxQQPp9CGT5AvG85tRdeaf4y7XDXLbrzUAEWtTioAyetOubWcNtFe2oxHYNUrrwyPUI
         ss6rn/6ExyxnodKYr1+EXZwFtTpsBOwYUr/d5OJbH+RJ7DEladNUHQDTbuZXLiHmnLSa
         rMKA35T2zEbNIwPrwbQ8T2qsNnD2dYRU+rbgU1qxFw/liDmrkjw6nl3D1e21AyngHQAM
         7fpEXjOSU8mnkGE/BpQ/VPQr55RdogKf6bE1J21+kfUJM4VNoRpNiVpzNJjFaUs/N6LV
         fU7w==
X-Forwarded-Encrypted: i=1; AJvYcCWfVNQCeJ7uP3VwFonTMhrjdMzVhbW3GF7TFucqPl5Zoispq4n+FQhwOTvxlhEYPzNrRg7svhU5JWGsE/QWPW9t1NDq
X-Gm-Message-State: AOJu0YxnJuEtblsikeB10YmdomkwMqE3VKLeQQI/8VlHiOZD2MeTOR8z
	2ziQUQcSwQxr9WE2mc57JOKDdhEaeX6lbKkm2s/JOpSubK3L1SL3crR2tFpsA9PQxaNUvqch8sz
	FsLkFiQatcY/+TgUBPxDCzHYtaHYV35Hh01fi114YVPaGQPo26zM9mYdMMuUf2hKhhCTBZKdTb6
	CXlu0QoPdWxfBj98sqUDX/UGjW
X-Received: by 2002:a17:90a:883:b0:2c9:2d00:44e with SMTP id 98e67ed59e1d1-2c93d710b9cmr3753908a91.14.1719804349682;
        Sun, 30 Jun 2024 20:25:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHduIufG4WANJnLRi5aDt5eDOq7OtlS9JEpavC0JAXNKp5/pniVJyLfLsXHRcq/cIO2E70iYH4H1OsNAqfAFhg=
X-Received: by 2002:a17:90a:883:b0:2c9:2d00:44e with SMTP id
 98e67ed59e1d1-2c93d710b9cmr3753887a91.14.1719804349194; Sun, 30 Jun 2024
 20:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com>
 <20240618075643.24867-9-xuanzhuo@linux.alibaba.com> <CACGkMEuPB=We-pnj8QH9Oiv4F=XHTcrRsHVVmOnUn9H7+Nrihw@mail.gmail.com>
 <1719553452.932589-3-xuanzhuo@linux.alibaba.com> <CACGkMEv_MOMHz1U48aVPXSj9gVJqA_h-UDt+oNgVgCQww4Jbdg@mail.gmail.com>
In-Reply-To: <CACGkMEv_MOMHz1U48aVPXSj9gVJqA_h-UDt+oNgVgCQww4Jbdg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 1 Jul 2024 11:25:37 +0800
Message-ID: <CACGkMEu-zmNtueGTNPUZsimf5XSXOWO3oCXgetaBS7g1UjHmuQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 08/10] virtio_net: xsk: rx: support recv small mode
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

On Mon, Jul 1, 2024 at 11:20=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Jun 28, 2024 at 1:48=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Fri, 28 Jun 2024 10:19:41 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Tue, Jun 18, 2024 at 3:57=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > In the process:
> > > > 1. We may need to copy data to create skb for XDP_PASS.
> > > > 2. We may need to call xsk_buff_free() to release the buffer.
> > > > 3. The handle for xdp_buff is difference from the buffer.
> > > >
> > > > If we pushed this logic into existing receive handle(merge and smal=
l),
> > > > we would have to maintain code scattered inside merge and small (an=
d big).
> > > > So I think it is a good choice for us to put the xsk code into an
> > > > independent function.
> > >
> > > I think it's better to try to reuse the existing functions.
> > >
> > > More below:
> > >
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 135 +++++++++++++++++++++++++++++++++++=
+++-
> > > >  1 file changed, 133 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 2ac5668a94ce..06608d696e2e 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -500,6 +500,10 @@ struct virtio_net_common_hdr {
> > > >  };
> > > >
> > > >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void =
*buf);
> > > > +static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct x=
dp_buff *xdp,
> > > > +                              struct net_device *dev,
> > > > +                              unsigned int *xdp_xmit,
> > > > +                              struct virtnet_rq_stats *stats);
> > > >
> > > >  static bool is_xdp_frame(void *ptr)
> > > >  {
> > > > @@ -1040,6 +1044,120 @@ static void sg_fill_dma(struct scatterlist =
*sg, dma_addr_t addr, u32 len)
> > > >         sg->length =3D len;
> > > >  }
> > > >
> > > > +static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
> > > > +                                  struct receive_queue *rq, void *=
buf, u32 len)
> > > > +{
> > > > +       struct xdp_buff *xdp;
> > > > +       u32 bufsize;
> > > > +
> > > > +       xdp =3D (struct xdp_buff *)buf;
> > > > +
> > > > +       bufsize =3D xsk_pool_get_rx_frame_size(rq->xsk.pool) + vi->=
hdr_len;
> > > > +
> > > > +       if (unlikely(len > bufsize)) {
> > > > +               pr_debug("%s: rx error: len %u exceeds truesize %u\=
n",
> > > > +                        vi->dev->name, len, bufsize);
> > > > +               DEV_STATS_INC(vi->dev, rx_length_errors);
> > > > +               xsk_buff_free(xdp);
> > > > +               return NULL;
> > > > +       }
> > > > +
> > > > +       xsk_buff_set_size(xdp, len);
> > > > +       xsk_buff_dma_sync_for_cpu(xdp);
> > > > +
> > > > +       return xdp;
> > > > +}
> > > > +
> > > > +static struct sk_buff *xdp_construct_skb(struct receive_queue *rq,
> > > > +                                        struct xdp_buff *xdp)
> > > > +{
> > >
> > > So we have a similar caller which is receive_small_build_skb(). Any
> > > chance to reuse that?
> >
> > receive_small_build_skb works with build_skb.
>
> RIght.
>
> >
> > Here we need to copy the packet from the xsk buffer to the skb buffer.
> > So I do not think we can reuse it.
> >
>
> Let's rename this to xsk_construct_skb() ?
>
> >
> > >
> > > > +       unsigned int metasize =3D xdp->data - xdp->data_meta;
> > > > +       struct sk_buff *skb;
> > > > +       unsigned int size;
> > > > +
> > > > +       size =3D xdp->data_end - xdp->data_hard_start;
> > > > +       skb =3D napi_alloc_skb(&rq->napi, size);
> > > > +       if (unlikely(!skb)) {
> > > > +               xsk_buff_free(xdp);
> > > > +               return NULL;
> > > > +       }
> > > > +
> > > > +       skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
> > > > +
> > > > +       size =3D xdp->data_end - xdp->data_meta;
> > > > +       memcpy(__skb_put(skb, size), xdp->data_meta, size);
> > > > +
> > > > +       if (metasize) {
> > > > +               __skb_pull(skb, metasize);
> > > > +               skb_metadata_set(skb, metasize);
> > > > +       }
> > > > +
> > > > +       xsk_buff_free(xdp);
> > > > +
> > > > +       return skb;
> > > > +}
> > > > +
> > > > +static struct sk_buff *virtnet_receive_xsk_small(struct net_device=
 *dev, struct virtnet_info *vi,
> > > > +                                                struct receive_que=
ue *rq, struct xdp_buff *xdp,
> > > > +                                                unsigned int *xdp_=
xmit,
> > > > +                                                struct virtnet_rq_=
stats *stats)
> > > > +{
> > > > +       struct bpf_prog *prog;
> > > > +       u32 ret;
> > > > +
> > > > +       ret =3D XDP_PASS;
> > > > +       rcu_read_lock();
> > > > +       prog =3D rcu_dereference(rq->xdp_prog);
> > > > +       if (prog)
> > > > +               ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_xmi=
t, stats);
> > > > +       rcu_read_unlock();
> > > > +
> > > > +       switch (ret) {
> > > > +       case XDP_PASS:
> > > > +               return xdp_construct_skb(rq, xdp);
> > > > +
> > > > +       case XDP_TX:
> > > > +       case XDP_REDIRECT:
> > > > +               return NULL;
> > > > +
> > > > +       default:
> > > > +               /* drop packet */
> > > > +               xsk_buff_free(xdp);
> > > > +               u64_stats_inc(&stats->drops);
> > > > +               return NULL;
> > > > +       }
> > > > +}
> > > > +
> > > > +static struct sk_buff *virtnet_receive_xsk_buf(struct virtnet_info=
 *vi, struct receive_queue *rq,
> > > > +                                              void *buf, u32 len,
> > > > +                                              unsigned int *xdp_xm=
it,
> > > > +                                              struct virtnet_rq_st=
ats *stats)
> > > > +{
> > > > +       struct net_device *dev =3D vi->dev;
> > > > +       struct sk_buff *skb =3D NULL;
> > > > +       struct xdp_buff *xdp;
> > > > +
> > > > +       len -=3D vi->hdr_len;
> > > > +
> > > > +       u64_stats_add(&stats->bytes, len);
> > > > +
> > > > +       xdp =3D buf_to_xdp(vi, rq, buf, len);
> > > > +       if (!xdp)
> > > > +               return NULL;
> > > > +
> > > > +       if (unlikely(len < ETH_HLEN)) {
> > > > +               pr_debug("%s: short packet %i\n", dev->name, len);
> > > > +               DEV_STATS_INC(dev, rx_length_errors);
> > > > +               xsk_buff_free(xdp);
> > > > +               return NULL;
> > > > +       }
> > > > +
> > > > +       if (!vi->mergeable_rx_bufs)
> > > > +               skb =3D virtnet_receive_xsk_small(dev, vi, rq, xdp,=
 xdp_xmit, stats);
> > > > +
> > > > +       return skb;
> > > > +}
> > > > +
> > > >  static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct=
 receive_queue *rq,
> > > >                                    struct xsk_buff_pool *pool, gfp_=
t gfp)
> > > >  {
> > > > @@ -2363,9 +2481,22 @@ static int virtnet_receive(struct receive_qu=
eue *rq, int budget,
> > > >         void *buf;
> > > >         int i;
> > > >
> > > > -       if (!vi->big_packets || vi->mergeable_rx_bufs) {
> > > > -               void *ctx;
> > > > +       if (rq->xsk.pool) {
> > > > +               struct sk_buff *skb;
> > > > +
> > > > +               while (packets < budget) {
> > > > +                       buf =3D virtqueue_get_buf(rq->vq, &len);
> > > > +                       if (!buf)
> > > > +                               break;
> > > >
> > > > +                       skb =3D virtnet_receive_xsk_buf(vi, rq, buf=
, len, xdp_xmit, &stats);
> > > > +                       if (skb)
> > > > +                               virtnet_receive_done(vi, rq, skb);
> > > > +
> > > > +                       packets++;
> > > > +               }
> > >
> > > If reusing turns out to be hard, I'd rather add new paths in receive_=
small().
> >
> > The exist function is called after virtnet_rq_get_buf(), that will do d=
ma unmap.
> > But for xsk, the dma unmap is not need. So xsk receive handle should us=
e
> > virtqueue_get_buf directly.
>
> Probably but if it's just virtnet_rq_get_buf() we can simply did:
>
> static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void =
**ctx)
> {
>         void *buf;
>
>         buf =3D virtqueue_get_buf_ctx(rq->vq, len, ctx);
>         if (buf && rq->xsk.pool)
>                 virtnet_rq_unmap(rq, buf, *len);
>
>         return buf;
> }

Or maybe it would be much more clearer if we did:

static int virtnet_receive()
{

if (rq->xsk.pool)
        virtnet_receive_xsk()
else
        virtnet_receive_xxx()
...
}

Thanks

>
> Thanks
>
> >
> > Thanks.
> >
> > >
> > > > +       } else if (!vi->big_packets || vi->mergeable_rx_bufs) {
> > > > +               void *ctx;
> > > >                 while (packets < budget &&
> > > >                        (buf =3D virtnet_rq_get_buf(rq, &len, &ctx))=
) {
> > > >                         receive_buf(vi, rq, buf, len, ctx, xdp_xmit=
, &stats);
> > > > --
> > > > 2.32.0.3.g01195cf9f
> > > >
> > >
> > > Thanks
> > >
> >


