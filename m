Return-Path: <bpf+bounces-66485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5825B35030
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 02:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66C9200648
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 00:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31962264BA;
	Tue, 26 Aug 2025 00:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBtBREfk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3442223301;
	Tue, 26 Aug 2025 00:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756168041; cv=none; b=uOcCedYvcqnfqkHJdI70lK/5UMREB/b5ZAlmeTchlegu2UgBnjueKN4IH+JBUY+XFjTQBl8FI4CcdZlFOMeMtZ9t9nUJLTRz+Wbj81kCSacKLFfghd+PB9GudrtC6XiiW4Kw2vZenRjCQ2qP3KJpO+R3x3LCatmp5AmhO4Mh9E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756168041; c=relaxed/simple;
	bh=j1HFH1Ni6KH6JRigY50EIcpFURZUGPgoV646lEmcdRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qmHQ7FX6s+hqpVHFEfW77Ecvd4nZ1qoRg7CJ2ipi8y/epEqV+f5hab3NnSs5HhMj2Y9vIEN/9+3WQmbnzQ0v2PvYapF79ASERYFCFl+EZ9uOlaYAEp3IIDjVeJ2YZTUqBl5xNY88byYWTfg5C0dLCzhcnNNpfew4m/XhkqNbqHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBtBREfk; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3ee1ffc230cso6949565ab.3;
        Mon, 25 Aug 2025 17:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756168037; x=1756772837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShedUifQzPZUIy6nARpeGR3JAhbLkZYHKyNUbAG0oVg=;
        b=iBtBREfkuZSwRpt/cluGaho894EQG8N4Pi3LPf3apLz5oGGCLIG/VMSTAc7SjeHN7y
         tZw8JuNUKwMb+3kJfZxSNJy7oyFFuGLaPdnGynXjwpB6mc8puWkkl3w65oYRTbYJeab3
         uAaLWDGWYuC9+u4W+nTyZeHb8O40EyX8wMvHcH13ktRORN1m8SGItAee+ub7dFqQ3fT4
         jMBlBNsN7xtzaec8m+hxPhOjnAXauwEop7D8t7lgT6FqwcksgBg3yY5Vuhxl3X3k0WuG
         fnDFWlltOYrPcKcU41WYnDs4z7lgglj8BpkY7HfGDvLCWoB6KIw9HpDuATHu4KI4QxZR
         EhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756168037; x=1756772837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShedUifQzPZUIy6nARpeGR3JAhbLkZYHKyNUbAG0oVg=;
        b=oHKHgWPVlxOFE5S3zOZPhRgHNj0SJPtzGV5JJ6L3DUdj40yVIMKhgYh7yQdZVGm2kw
         BGvJ9mZ0GfjtJPr92Qkq4TPg6QNW5wKpzR62uWfb5NMxi6FJXrQwK7GEzkv0FzVvXtZQ
         Oc9rVAltirXvTLe9dwDCTsk2/VM/syrdtBRv2oEYlty4imzl5dhBjwoFDaHD1MDgKuA8
         Q3Cd/hr98k55pWwEmYRIWjGLtTikoQ8ymypdv2Rq7B7/kLUsrKHg4cimUO20pT+iOi4N
         Zb3OcMfszJGzrQOzmER3PcR0opyaBqTiUaAQ0qDWwTMpSf8syjhzJAhdRRWAKzI3QvTC
         2KtA==
X-Forwarded-Encrypted: i=1; AJvYcCUc9AT7zeymC8RD9imgdOOy61ZXpxAtWSW7djgY0IBQBI07piiAmNtW664gLwH000hs3+Q=@vger.kernel.org, AJvYcCVHL8XR6a91LljoQWWTgubtz1XzEXCCKNlinWjP3D7WupkRGiHeainpvNcFwyhLhP9cKJ0x70g1@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp1dRFd8s4BicBLp1EO1Y0jaO3GIqQKjaDYomRH4qSZGV2pTDh
	Bp2ah8dr7q5FR4YGNWVptuM+3gjgkOdGgBhGYBFQtcg3Mmu/eiaHmhsXnfnR5UCmLNDU5QWPxh5
	21dnQRgOX05gdUov+Dx60V93DscI1wo4=
X-Gm-Gg: ASbGncvRra04R6fxDZv1dAoDLAy3PGN1FqlrG0bT1spHATPfyExw2IYVCCcCtZTw1ZD
	9xqj8FsmdTt6OJKL5yDpqtuv3WfuT2ezPdFA+NOo+H80exFnkNwXg3xKyhD5OvY+DVFlKgfW1g/
	TIhQkBbZPfMR5GE8y15Hkj3oWfNxcKxftcOyKVqfqn11N2K8d0LNXEirib/2P8fS/dwOXDDjnyX
	pBC6ICOAxrPA87iIw==
X-Google-Smtp-Source: AGHT+IEEpqAsoKgN9Fe8A+hHsl5lAAgdF5Xrd8RNjA+FOtMXEiiJY35kLUEoQqp9p2de7+O4rkSsAHvD62iQEXVaKmg=
X-Received: by 2002:a05:6e02:2192:b0:3eb:cca5:55a5 with SMTP id
 e9e14a558f8ab-3ebcca5a064mr106750955ab.19.1756168037533; Mon, 25 Aug 2025
 17:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825135342.53110-1-kerneljasonxing@gmail.com>
 <20250825135342.53110-5-kerneljasonxing@gmail.com> <aKzaVRQeeSuH155P@boxer>
In-Reply-To: <aKzaVRQeeSuH155P@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 26 Aug 2025 08:26:41 +0800
X-Gm-Features: Ac12FXwrLqaN6lq8RL47YLivniNHjmGiSwoC2jDJXXOo6sE0soyc-JjP64v8a1w
Message-ID: <CAL+tcoBv1sm+zQURFwS2E=pMdjWEMUUVBH9cLjBadZms+FvHNw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/9] xsk: extend xsk_build_skb() to support
 passing an already allocated skb
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 5:49=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Mon, Aug 25, 2025 at 09:53:37PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Batch xmit mode needs to allocate and build skbs at one time. To avoid
> > reinvent the wheel, use xsk_build_skb() as the second half process of
> > the whole initialization of each skb.
> >
> > The original xsk_build_skb() itself allocates a new skb by calling
> > sock_alloc_send_skb whether in copy mode or zerocopy mode. Add a new
> > parameter allocated skb to let other callers to pass an already
> > allocated skb to support later xmit batch feature. At that time,
> > another building skb function will generate a new skb and pass it to
> > xsk_build_skb() to finish the rest of building process, like
> > initializing structures and copying data.
>
> are you saying you were able to avoid sock_alloc_send_skb() calls for
> batching approach and your socket memory accounting problems disappeared?

IIUC, memory accounting is needed because it keeps safe for xsk [1].

The above description says I reused part of xsk_build_skb() in the
batching process.

[1]: https://lore.kernel.org/all/CAL+tcoBvLHFJJuYawJc3wY2aOrn5CQ3s5+sbC2M24=
_QNLyBHsg@mail.gmail.com/

>
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  include/net/xdp_sock.h |  4 ++++
> >  net/xdp/xsk.c          | 23 ++++++++++++++++-------
> >  2 files changed, 20 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > index c2b05268b8ad..cbba880c27c3 100644
> > --- a/include/net/xdp_sock.h
> > +++ b/include/net/xdp_sock.h
> > @@ -123,6 +123,10 @@ struct xsk_tx_metadata_ops {
> >       void    (*tmo_request_launch_time)(u64 launch_time, void *priv);
> >  };
> >
> > +
> > +struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > +                           struct sk_buff *allocated_skb,
> > +                           struct xdp_desc *desc);
>
> why do you export this?

Because patch 5 needs this in xsk_alloc_batch_skb().

Thanks,
Jason

>
> >  #ifdef CONFIG_XDP_SOCKETS
> >
> >  int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 173ad49379c3..213d6100e405 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -605,6 +605,7 @@ static void xsk_drop_skb(struct sk_buff *skb)
> >  }
> >
> >  static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> > +                                           struct sk_buff *allocated_s=
kb,
> >                                             struct xdp_desc *desc)
> >  {
> >       struct xsk_buff_pool *pool =3D xs->pool;
> > @@ -618,7 +619,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(stru=
ct xdp_sock *xs,
> >       if (!skb) {
> >               hr =3D max(NET_SKB_PAD, L1_CACHE_ALIGN(xs->dev->needed_he=
adroom));
> >
> > -             skb =3D sock_alloc_send_skb(&xs->sk, hr, 1, &err);
> > +             if (!allocated_skb)
> > +                     skb =3D sock_alloc_send_skb(&xs->sk, hr, 1, &err)=
;
> > +             else
> > +                     skb =3D allocated_skb;
> >               if (unlikely(!skb))
> >                       return ERR_PTR(err);
> >
> > @@ -657,8 +661,9 @@ static struct sk_buff *xsk_build_skb_zerocopy(struc=
t xdp_sock *xs,
> >       return skb;
> >  }
> >
> > -static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > -                                  struct xdp_desc *desc)
> > +struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > +                           struct sk_buff *allocated_skb,
> > +                           struct xdp_desc *desc)
> >  {
> >       struct xsk_tx_metadata *meta =3D NULL;
> >       struct net_device *dev =3D xs->dev;
> > @@ -667,7 +672,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> >       int err;
> >
> >       if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
> > -             skb =3D xsk_build_skb_zerocopy(xs, desc);
> > +             skb =3D xsk_build_skb_zerocopy(xs, allocated_skb, desc);
> >               if (IS_ERR(skb)) {
> >                       err =3D PTR_ERR(skb);
> >                       goto free_err;
> > @@ -683,8 +688,12 @@ static struct sk_buff *xsk_build_skb(struct xdp_so=
ck *xs,
> >                       first_frag =3D true;
> >
> >                       hr =3D max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->neede=
d_headroom));
> > -                     tr =3D dev->needed_tailroom;
> > -                     skb =3D sock_alloc_send_skb(&xs->sk, hr + len + t=
r, 1, &err);
> > +                     if (!allocated_skb) {
> > +                             tr =3D dev->needed_tailroom;
> > +                             skb =3D sock_alloc_send_skb(&xs->sk, hr +=
 len + tr, 1, &err);
> > +                     } else {
> > +                             skb =3D allocated_skb;
> > +                     }
> >                       if (unlikely(!skb))
> >                               goto free_err;
> >
> > @@ -818,7 +827,7 @@ static int __xsk_generic_xmit(struct sock *sk)
> >                       goto out;
> >               }
> >
> > -             skb =3D xsk_build_skb(xs, &desc);
> > +             skb =3D xsk_build_skb(xs, NULL, &desc);
> >               if (IS_ERR(skb)) {
> >                       err =3D PTR_ERR(skb);
> >                       if (err !=3D -EOVERFLOW)
> > --
> > 2.41.3
> >

