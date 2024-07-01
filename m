Return-Path: <bpf+bounces-33460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBE291D67A
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 05:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8D82B21300
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 03:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84618125C1;
	Mon,  1 Jul 2024 03:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aPrdr5+x"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A16C10A0E
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 03:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719803156; cv=none; b=p2W5nubHYOthdXXm5wlHlvaayQDeiUaoFCc1OboN1B20k/r4DZGGb/JIdmVKk6WtOa8nc/4bX2qEBxoD84AZYE92oNyQMGBjx00ZgTYsCXfx1zZrYi4GqFzxYGWDOxzToQAGHumPbw+N/rsGMhrioina2VGODAwCoLa3pYTNQTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719803156; c=relaxed/simple;
	bh=x7CIyMnhiWMh15XzadY+hegqA0fxD1v2PlohvDWSh7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eow+ic19XJgc7YB2oPl/xfNPPn16ALePoL0ov9iDMTJp4F2V+CRrPE0obf8bmJoFG7OwzlYa1+GTty7vIbgSdIL26kLbW2EiBWktzDWsIlQSCBmxpAyIlUZFXA41VURB8E1tlsHst0wQoR9A2T4to3hum4v6FYXqHGWagBMKICE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aPrdr5+x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719803153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jBHQBjWIdUQuBh+7vJ7Urb/sZUQn569LJ1AIL3BHqDg=;
	b=aPrdr5+x77I9GwTCHBdGafDvYERFRdFcDZHjFqFPWG2UhiswQ0Y2EoII8XH2zu1ponfyYs
	guW5UOEBkFUpnfvIcgcs0wFIFefWlEsTg3pKCyxIzPqSLSnBagGAab6ZMQft/4C5Xz6aOf
	baLJgkOFawMpoOzuG2qybE7OeAMqUe8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-ka80NGauNJmCJjwIMzPl2Q-1; Sun, 30 Jun 2024 23:05:45 -0400
X-MC-Unique: ka80NGauNJmCJjwIMzPl2Q-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c7c3401dfdso1693937a91.1
        for <bpf@vger.kernel.org>; Sun, 30 Jun 2024 20:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719803145; x=1720407945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBHQBjWIdUQuBh+7vJ7Urb/sZUQn569LJ1AIL3BHqDg=;
        b=XpUr6Y+m57A+huIsL0yFR6pJzZ3GgkGsa/enJMT0f8kbXgciFg0oVvw+mwzune6qIN
         2Cd5BsAca+9uUqqGD1egWB/rKmIbk3ecVkmkdw1jed8I6QK/hniYn8+NIbsmWZ5SCHRG
         Z5L/d0pFM+tnl4rs8dNNjugAHBrwl6FJpBvknMtAAbmWVMCDIP5FxQ+wS7rse7zlNTFL
         ieQiPLoHPR/S7YH4zjiBLS5rmydU1nWqh8f9HVidGz07P1yxhGHwO9TtMb4b/V2748T0
         EWqptLVVxeRURrUTPbIdUB5lV3mOlPEGqDzjTqeRRhNqq5a98RKUelnDCrhAqSg8ZGzU
         ulUw==
X-Forwarded-Encrypted: i=1; AJvYcCVM/Hto7ePJ5261AUQJYdd5bujtUrPa35HK0VAEhgjAsvgWO5HB9FUaemFJrMipyek7tFnb7XO7u2aCGSX+4hZsXmzB
X-Gm-Message-State: AOJu0YxE/zB1AcyMvqUCJKahaaGVP68FWhFhJ1wq06s6PPC4E8WWwmD2
	Uv5Lemjub2xLXzK4kPub5tWGQc8PwbkggAm7ENFw8RRHDvwYZBiFzuv+5oIaDITqNQEIZ3Q0bZj
	cfdvIJBPojgQqmprfj4JZqoF+gKBBBDtdplW7nwzh3egk8hBWH5bHj98tsD3dtjrfEqEDnecSGY
	iXe+aOTm6+N3evEeiyfw5xag66
X-Received: by 2002:a17:90b:46ca:b0:2b1:b1a1:1310 with SMTP id 98e67ed59e1d1-2c93d730ac1mr1806237a91.29.1719803144833;
        Sun, 30 Jun 2024 20:05:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRcE1jBGXfj1LwD0BYVw6F3AonJHCmNmKtTt+BJqVg5um4oaX/fZpPg6T9n8Zeh2Xj82KJmoNFJNctTcIFAiE=
X-Received: by 2002:a17:90b:46ca:b0:2b1:b1a1:1310 with SMTP id
 98e67ed59e1d1-2c93d730ac1mr1806222a91.29.1719803144364; Sun, 30 Jun 2024
 20:05:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com>
 <20240618075643.24867-8-xuanzhuo@linux.alibaba.com> <CACGkMEta9o97cqUy+wV=1Xpu8MBoFt4CEtWS35dhTMs0Dm4AKg@mail.gmail.com>
 <1719553356.2373846-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1719553356.2373846-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 1 Jul 2024 11:05:33 +0800
Message-ID: <CACGkMEtMSXumzmziWoMagEf-vA+j84oCJWMGAh0vGtmU_QupyA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/10] virtio_net: xsk: rx: support fill with
 xsk buffer
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

On Fri, Jun 28, 2024 at 1:44=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Fri, 28 Jun 2024 10:19:37 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Jun 18, 2024 at 3:57=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > Implement the logic of filling rq with XSK buffers.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 68 ++++++++++++++++++++++++++++++++++++++=
--
> > >  1 file changed, 66 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 2bbc715f22c6..2ac5668a94ce 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -355,6 +355,8 @@ struct receive_queue {
> > >
> > >                 /* xdp rxq used by xsk */
> > >                 struct xdp_rxq_info xdp_rxq;
> > > +
> > > +               struct xdp_buff **xsk_buffs;
> > >         } xsk;
> > >  };
> > >
> > > @@ -1032,6 +1034,53 @@ static void check_sq_full_and_disable(struct v=
irtnet_info *vi,
> > >         }
> > >  }
> > >
> > > +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32=
 len)
> > > +{
> > > +       sg->dma_address =3D addr;
> > > +       sg->length =3D len;
> > > +}
> > > +
> > > +static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct r=
eceive_queue *rq,
> > > +                                  struct xsk_buff_pool *pool, gfp_t =
gfp)
> > > +{
> > > +       struct xdp_buff **xsk_buffs;
> > > +       dma_addr_t addr;
> > > +       u32 len, i;
> > > +       int err =3D 0;
> > > +       int num;
> > > +
> > > +       xsk_buffs =3D rq->xsk.xsk_buffs;
> > > +
> > > +       num =3D xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_fre=
e);
> > > +       if (!num)
> > > +               return -ENOMEM;
> > > +
> > > +       len =3D xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
> > > +
> > > +       for (i =3D 0; i < num; ++i) {
> > > +               /* use the part of XDP_PACKET_HEADROOM as the virtnet=
 hdr space */
> > > +               addr =3D xsk_buff_xdp_get_dma(xsk_buffs[i]) - vi->hdr=
_len;
> >
> > We had VIRTIO_XDP_HEADROOM, can we reuse it? Or if it's redundant
> > let's send a patch to switch to XDP_PACKET_HEADROOM.
>
> Do you mean replace it inside the comment?

I meant a patch to s/VIRTIO_XDP_HEADROOM/XDP_PACKET_HEADROOM/g.

>
> I want to describe use the headroom of xsk, the size of the headroom is
> XDP_PACKET_HEADROOM.
>
> >
> > Btw, the code assumes vi->hdr_len < xsk_pool_get_headroom(). It's
> > better to fail if it's not true when enabling xsk.
>
> It is ok.

I mean do we need a check to fail xsk binding if vi->hdr_len >
xsk_pool_get_headroom() or it has been guaranteed by the code already.

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
>


