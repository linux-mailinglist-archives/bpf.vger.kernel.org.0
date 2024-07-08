Return-Path: <bpf+bounces-34044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82433929CA7
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 09:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA831B21146
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 07:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891101B974;
	Mon,  8 Jul 2024 07:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/bS8L6B"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A98218E1E
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 07:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720422069; cv=none; b=cqkviwAvNByFqRuakMnYTfEAOJwEa9w+z1rigFkiXDuxU8anEL2iVhFX/7oLilLmAXkAOX/yqcqjjtjwCE1vrlyqYlBfL2se9vL/O4Y3oGMFg8jl7rtE0LOcXNTk4ihtd6ZyOHB6/9xZP5tk+vwQk5DXYOl8cOSTmrwYwHzd8e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720422069; c=relaxed/simple;
	bh=abzvPZ9aMqHcWYduVBI7v95AXAHY1ldyKfg0qH647b0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxxMXYf0AtSXv5BELJCOtJ+FvFmILiO/bFtJ5gdPsjflEfN0lRxT7hPLUaa2PWPW0i3vFIlni6RYOH09Yc7SY33vuFZJCDnlssdCj9AU0mBLuauDcaag3ajw+9YDCAcYyBXV/4lvdkkEWBJ0iLNMlQQLVCJigx3kGSEaRO7P7BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/bS8L6B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720422066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uIiSiOPGT74LKdsGWbRlafq9sMVz9Zj8uvoYvrXoHLI=;
	b=G/bS8L6BhM1aE2/dTwewmGDJO7yQJhleG6OQGuBjzAxZUPfdOyPMohloey26cVZY8a8BFO
	IZPdjXVU8cW512wDx9N5Xtfz1CSQzA7Bt1kzu4up1lKr7t7rSdMzhPleCtsUhBJRxhez8M
	F5+UfIMmEGqtDvD/jSPOqldq02YYwGk=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-Mdns9GX6PxWf8l7bq15cFQ-1; Mon, 08 Jul 2024 03:01:03 -0400
X-MC-Unique: Mdns9GX6PxWf8l7bq15cFQ-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-25e3350651eso4034683fac.3
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2024 00:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720422063; x=1721026863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIiSiOPGT74LKdsGWbRlafq9sMVz9Zj8uvoYvrXoHLI=;
        b=Ujm9XQCtu0tfg25eFbRaqsBQEJW+biD8gLb1oB6WaW65Yf1qrz5bGL6N7L2RYsa9FS
         xsGdtAvXRB66yfWbSUTiT5SQVtrMKlN01FVYkW7GAogX24wug0K44C42F9WNBvRYA5Sj
         obIGeoZPULvHxvfgkPoW5CjGcLR/VKRlbqflyQ8FCKRlhQyrczm1OZzzKYzfIkSMyzN7
         2vhhQ047RkfVuIvXRQyH4IV2da8qXpx8nsnoCBkw3FzcfB4p6fpo0GEzvni8plOgy/N2
         iONPH275d2Z2/atw7VRG3tVclsksQ7BdJesxKEoEWkZG7s3LZXpHHHF7KdszqpIyelB9
         oV7w==
X-Forwarded-Encrypted: i=1; AJvYcCUEdEgdjwBxUt0G2+oKH7h5XWv2fKUt80vR+DuJgqlk94ABIvijTXTzLF31AP8za6rYIIxF6u1UzDwKjB7gkoPf/R5L
X-Gm-Message-State: AOJu0Ywztx3NQ31QWNIH2iaGIWMRaK7oqjmJHK0dz+ChQQizZu8Y9JX9
	mLGC5cdbvMgUkWR4ozwMc86E6+8dMhOj7CHOOndvaBu+wVRloC7buQlXZjVxOblXwYN/7gZENAM
	dU+k180EW+dJdjmVSIX3+mRIcAWMZT6NAXMv3sjFFoSiUkGLjBxRnsC7wiCaH17g+ADyw7QCSwf
	NiqU+RNuvTA5WzuWJVFli5l/Dt
X-Received: by 2002:a05:6870:fb8b:b0:259:89a5:440e with SMTP id 586e51a60fabf-25e2bb7fb35mr10043097fac.27.1720422062745;
        Mon, 08 Jul 2024 00:01:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFazS2vrLBF7mr6COd4hzxBHu/Wd4B/eVuXoVldrurab2QJeEsJRFzSmFq0IZSYZwx+a0prDz/Fkp629+/OW+Y=
X-Received: by 2002:a05:6870:fb8b:b0:259:89a5:440e with SMTP id
 586e51a60fabf-25e2bb7fb35mr10043066fac.27.1720422062307; Mon, 08 Jul 2024
 00:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com> <20240705073734.93905-10-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240705073734.93905-10-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Jul 2024 15:00:50 +0800
Message-ID: <CACGkMEsiMTs=PymmPrrfhmF6W=Oviwg4hWEbSFb1sghGYadSgg@mail.gmail.com>
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

On Fri, Jul 5, 2024 at 3:38=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> In the process:
> 1. We may need to copy data to create skb for XDP_PASS.
> 2. We may need to call xsk_buff_free() to release the buffer.
> 3. The handle for xdp_buff is difference from the buffer.
>
> If we pushed this logic into existing receive handle(merge and small),
> we would have to maintain code scattered inside merge and small (and big)=
.
> So I think it is a good choice for us to put the xsk code into an
> independent function.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>
> v7:
>    1. rename xdp_construct_skb to xsk_construct_skb
>    2. refactor virtnet_receive()
>
>  drivers/net/virtio_net.c | 176 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 168 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2b27f5ada64a..64d8cd481890 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -498,6 +498,12 @@ struct virtio_net_common_hdr {
>  };
>
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
> +static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buf=
f *xdp,
> +                              struct net_device *dev,
> +                              unsigned int *xdp_xmit,
> +                              struct virtnet_rq_stats *stats);
> +static void virtnet_receive_done(struct virtnet_info *vi, struct receive=
_queue *rq,
> +                                struct sk_buff *skb, u8 flags);
>
>  static bool is_xdp_frame(void *ptr)
>  {
> @@ -1062,6 +1068,124 @@ static void sg_fill_dma(struct scatterlist *sg, d=
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
> +       bufsize =3D xsk_pool_get_rx_frame_size(rq->xsk_pool) + vi->hdr_le=
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
> +static struct sk_buff *xsk_construct_skb(struct receive_queue *rq,
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
> +               return xsk_construct_skb(rq, xdp);
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
> +
> +static void virtnet_receive_xsk_buf(struct virtnet_info *vi, struct rece=
ive_queue *rq,
> +                                   void *buf, u32 len,
> +                                   unsigned int *xdp_xmit,
> +                                   struct virtnet_rq_stats *stats)
> +{
> +       struct net_device *dev =3D vi->dev;
> +       struct sk_buff *skb =3D NULL;
> +       struct xdp_buff *xdp;
> +       u8 flags;
> +
> +       len -=3D vi->hdr_len;
> +
> +       u64_stats_add(&stats->bytes, len);
> +
> +       xdp =3D buf_to_xdp(vi, rq, buf, len);
> +       if (!xdp)
> +               return;
> +
> +       if (unlikely(len < ETH_HLEN)) {
> +               pr_debug("%s: short packet %i\n", dev->name, len);
> +               DEV_STATS_INC(dev, rx_length_errors);
> +               xsk_buff_free(xdp);
> +               return;
> +       }
> +
> +       flags =3D ((struct virtio_net_common_hdr *)(xdp->data - vi->hdr_l=
en))->hdr.flags;
> +
> +       if (!vi->mergeable_rx_bufs)
> +               skb =3D virtnet_receive_xsk_small(dev, vi, rq, xdp, xdp_x=
mit, stats);

I wonder if we add the mergeable support in the next patch would it be
better to re-order the patch? For example, the xsk binding needs to be
moved to the last patch, otherwise we break xsk with a mergeable
buffer here?

Or anything I missed here?

Thanks


