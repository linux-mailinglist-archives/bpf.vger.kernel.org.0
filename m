Return-Path: <bpf+bounces-34047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B241929DF9
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 10:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0B01F21B10
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 08:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304E33A1B0;
	Mon,  8 Jul 2024 08:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9VTTzDn"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B82522611
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 08:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720426144; cv=none; b=vDACA8r1K/USYsLrgqX8mSRLseCgNEHZ36o9fSAq+i0FJz/E2ej5vfwz3Cd/G6wZ9gvvVa9yUdFFSNy4f91j1Yv2lgFbwGtCJCs5eNwrxIrq24NeF4Auz27uit20bORuF74n1YJN+2PBJA6TXAXkIHB2RwRxaSvFHcJ/V30tZtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720426144; c=relaxed/simple;
	bh=qMf0cWEIBDJI1wPVxIfS9rEbR2iypK+ArwrlvfqcS4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxNzqrPk/pmTgCdJhqYJBJAZ1YtIz9oOUxKfEpbFhdfO6LRy/8WViTYlRR0sPmxLh++2omo30La30K/8A+j0tJ3M36/DByrkngHDCnWA2wvzVFTwZqo0cG3EDeg7g9TNJYmCU7akmpf+sNjJPlwxT8G/EZaaPOMDMnDTIGeZYeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c9VTTzDn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720426142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CLTQ2PKwxy+i8qaPB4UwrsoPh7735CAQV0lSOIofn4k=;
	b=c9VTTzDnDSCcZ698GPncCu/JHe2SHLhWAiRLCpkDGquOu7SUmpz1//gf89gtYAtDoSJs7Q
	ep6j+P1xF1VEkemN/MIAHFskAyT7NFG+91Y43wfSm/u8bcYSAAAryHg5pwIeyhqnFABuHY
	IHy8Dm2DkY/cYWqX4kE7JC/BIcdqpo0=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-kNXI45-aN0C50i5_YHrIlA-1; Mon, 08 Jul 2024 04:08:58 -0400
X-MC-Unique: kNXI45-aN0C50i5_YHrIlA-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3d929eb4f2dso1396515b6e.2
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2024 01:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720426137; x=1721030937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLTQ2PKwxy+i8qaPB4UwrsoPh7735CAQV0lSOIofn4k=;
        b=HOdTxdPZNndyrXZMsFpkbuVJQcth6s3EkbFYNGABON5PEuaCvnsdF3JNRYwAf7VTbX
         5AeEwHueL3aCIKLcmV+fjRMN+5I7pZ6/+l7B3uVGr3z1iJNIQy5vLshKJS2dGuT0BF14
         tjLoyzRZxJQi5GV6MvrS7QOLZt4SlHc+XoitQq/lgFoxCS37EG/I+b5D/CMNjbUgPugO
         HwjoK0C8wr/akQJFmZsPw5YWef4rM9oSkb9N6gJKDY/WpKtWd0Ca4S4CL7Bg0UiszhTY
         Uiwy5eoMtsJwJJlMLNVUcZDjbbuvt7HwWwU+RoJc4NtRlDMBfmstrGAWImmSFdBaxjou
         nAnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmA8+FTLQ6Fft/hvLN08ZMdBz03yglB5VWqwQtbnCsHj8gt5xE1db75EM1alPzC4MM5zXldQgCEOBJouI9jFcqDinD
X-Gm-Message-State: AOJu0YyP8DW5ydOdb2TBo6XfEFfDpf5nvX6G+zXIb4HPliIqWpxnugB7
	2mi3nejFUb0kszIvIifnw7jBJTbzdhOv53Ynz03b9ZRC/3e4kVvkpZxIqdZz9Fzmvw4V5sx3lZP
	GzooLdAEm1Kk+bvO/fk6gMqPlg/0WBF1bhI6Oz0gRF9tbyWIw+grY9IqNpBjwmsi4UknWffclND
	ktZyCIScH2m90CXv+g8pTaA1Yw
X-Received: by 2002:a05:6808:1392:b0:3d9:1f05:845 with SMTP id 5614622812f47-3d91f050a43mr10973210b6e.19.1720426136686;
        Mon, 08 Jul 2024 01:08:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHx08npK6Y9eZ9wfcXTZ97ykJuf1vmZybpLRDDSHLjVuDj4PfnM/DqOi0LEjJIYUprg6VDeGTzORQHHaGgkqlk=
X-Received: by 2002:a05:6808:1392:b0:3d9:1f05:845 with SMTP id
 5614622812f47-3d91f050a43mr10973179b6e.19.1720426135888; Mon, 08 Jul 2024
 01:08:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com>
 <20240705073734.93905-10-xuanzhuo@linux.alibaba.com> <CACGkMEsiMTs=PymmPrrfhmF6W=Oviwg4hWEbSFb1sghGYadSgg@mail.gmail.com>
 <1720424536.972943-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1720424536.972943-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Jul 2024 16:08:44 +0800
Message-ID: <CACGkMEukkp9FxLfBGTXvSGso48Ugy2-m3rWNFiVGuEa52LT_-Q@mail.gmail.com>
Subject: Re: [PATCH net-next v7 09/10] virtio_net: xsk: rx: support recv small mode
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

On Mon, Jul 8, 2024 at 3:47=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> On Mon, 8 Jul 2024 15:00:50 +0800, Jason Wang <jasowang@redhat.com> wrote=
:
> > On Fri, Jul 5, 2024 at 3:38=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> > >
> > > In the process:
> > > 1. We may need to copy data to create skb for XDP_PASS.
> > > 2. We may need to call xsk_buff_free() to release the buffer.
> > > 3. The handle for xdp_buff is difference from the buffer.
> > >
> > > If we pushed this logic into existing receive handle(merge and small)=
,
> > > we would have to maintain code scattered inside merge and small (and =
big).
> > > So I think it is a good choice for us to put the xsk code into an
> > > independent function.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >
> > > v7:
> > >    1. rename xdp_construct_skb to xsk_construct_skb
> > >    2. refactor virtnet_receive()
> > >
> > >  drivers/net/virtio_net.c | 176 +++++++++++++++++++++++++++++++++++++=
--
> > >  1 file changed, 168 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 2b27f5ada64a..64d8cd481890 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -498,6 +498,12 @@ struct virtio_net_common_hdr {
> > >  };
> > >
> > >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *b=
uf);
> > > +static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp=
_buff *xdp,
> > > +                              struct net_device *dev,
> > > +                              unsigned int *xdp_xmit,
> > > +                              struct virtnet_rq_stats *stats);
> > > +static void virtnet_receive_done(struct virtnet_info *vi, struct rec=
eive_queue *rq,
> > > +                                struct sk_buff *skb, u8 flags);
> > >
> > >  static bool is_xdp_frame(void *ptr)
> > >  {
> > > @@ -1062,6 +1068,124 @@ static void sg_fill_dma(struct scatterlist *s=
g, dma_addr_t addr, u32 len)
> > >         sg->length =3D len;
> > >  }
> > >
> > > +static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
> > > +                                  struct receive_queue *rq, void *bu=
f, u32 len)
> > > +{
> > > +       struct xdp_buff *xdp;
> > > +       u32 bufsize;
> > > +
> > > +       xdp =3D (struct xdp_buff *)buf;
> > > +
> > > +       bufsize =3D xsk_pool_get_rx_frame_size(rq->xsk_pool) + vi->hd=
r_len;
> > > +
> > > +       if (unlikely(len > bufsize)) {
> > > +               pr_debug("%s: rx error: len %u exceeds truesize %u\n"=
,
> > > +                        vi->dev->name, len, bufsize);
> > > +               DEV_STATS_INC(vi->dev, rx_length_errors);
> > > +               xsk_buff_free(xdp);
> > > +               return NULL;
> > > +       }
> > > +
> > > +       xsk_buff_set_size(xdp, len);
> > > +       xsk_buff_dma_sync_for_cpu(xdp);
> > > +
> > > +       return xdp;
> > > +}
> > > +
> > > +static struct sk_buff *xsk_construct_skb(struct receive_queue *rq,
> > > +                                        struct xdp_buff *xdp)
> > > +{
> > > +       unsigned int metasize =3D xdp->data - xdp->data_meta;
> > > +       struct sk_buff *skb;
> > > +       unsigned int size;
> > > +
> > > +       size =3D xdp->data_end - xdp->data_hard_start;
> > > +       skb =3D napi_alloc_skb(&rq->napi, size);
> > > +       if (unlikely(!skb)) {
> > > +               xsk_buff_free(xdp);
> > > +               return NULL;
> > > +       }
> > > +
> > > +       skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
> > > +
> > > +       size =3D xdp->data_end - xdp->data_meta;
> > > +       memcpy(__skb_put(skb, size), xdp->data_meta, size);
> > > +
> > > +       if (metasize) {
> > > +               __skb_pull(skb, metasize);
> > > +               skb_metadata_set(skb, metasize);
> > > +       }
> > > +
> > > +       xsk_buff_free(xdp);
> > > +
> > > +       return skb;
> > > +}
> > > +
> > > +static struct sk_buff *virtnet_receive_xsk_small(struct net_device *=
dev, struct virtnet_info *vi,
> > > +                                                struct receive_queue=
 *rq, struct xdp_buff *xdp,
> > > +                                                unsigned int *xdp_xm=
it,
> > > +                                                struct virtnet_rq_st=
ats *stats)
> > > +{
> > > +       struct bpf_prog *prog;
> > > +       u32 ret;
> > > +
> > > +       ret =3D XDP_PASS;
> > > +       rcu_read_lock();
> > > +       prog =3D rcu_dereference(rq->xdp_prog);
> > > +       if (prog)
> > > +               ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_xmit,=
 stats);
> > > +       rcu_read_unlock();
> > > +
> > > +       switch (ret) {
> > > +       case XDP_PASS:
> > > +               return xsk_construct_skb(rq, xdp);
> > > +
> > > +       case XDP_TX:
> > > +       case XDP_REDIRECT:
> > > +               return NULL;
> > > +
> > > +       default:
> > > +               /* drop packet */
> > > +               xsk_buff_free(xdp);
> > > +               u64_stats_inc(&stats->drops);
> > > +               return NULL;
> > > +       }
> > > +}
> > > +
> > > +static void virtnet_receive_xsk_buf(struct virtnet_info *vi, struct =
receive_queue *rq,
> > > +                                   void *buf, u32 len,
> > > +                                   unsigned int *xdp_xmit,
> > > +                                   struct virtnet_rq_stats *stats)
> > > +{
> > > +       struct net_device *dev =3D vi->dev;
> > > +       struct sk_buff *skb =3D NULL;
> > > +       struct xdp_buff *xdp;
> > > +       u8 flags;
> > > +
> > > +       len -=3D vi->hdr_len;
> > > +
> > > +       u64_stats_add(&stats->bytes, len);
> > > +
> > > +       xdp =3D buf_to_xdp(vi, rq, buf, len);
> > > +       if (!xdp)
> > > +               return;
> > > +
> > > +       if (unlikely(len < ETH_HLEN)) {
> > > +               pr_debug("%s: short packet %i\n", dev->name, len);
> > > +               DEV_STATS_INC(dev, rx_length_errors);
> > > +               xsk_buff_free(xdp);
> > > +               return;
> > > +       }
> > > +
> > > +       flags =3D ((struct virtio_net_common_hdr *)(xdp->data - vi->h=
dr_len))->hdr.flags;
> > > +
> > > +       if (!vi->mergeable_rx_bufs)
> > > +               skb =3D virtnet_receive_xsk_small(dev, vi, rq, xdp, x=
dp_xmit, stats);
> >
> > I wonder if we add the mergeable support in the next patch would it be
> > better to re-order the patch? For example, the xsk binding needs to be
> > moved to the last patch, otherwise we break xsk with a mergeable
> > buffer here?
>
> If you worry that the user works with this commit, I want to say you do n=
ot
> worry.
>
> Because the flags NETDEV_XDP_ACT_XSK_ZEROCOPY is not added. I plan to add=
 that
> after the tx is completed.

Ok, this is something I missed, it would be better to mention it
somewhere (or it is already there but I miss it).

>
> I do test by adding this flags locally.
>
> Thanks.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> >
> > Or anything I missed here?
> >
> > Thanks
> >
>


