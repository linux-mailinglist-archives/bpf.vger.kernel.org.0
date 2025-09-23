Return-Path: <bpf+bounces-69356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47700B953D6
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 11:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C12174E3C
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 09:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA05320A01;
	Tue, 23 Sep 2025 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4eu7SJ6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0C02F4A11
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619540; cv=none; b=nBuaNnl6VWSh5aAh6kwrtt9xphppnKSzarQhxPtTAjvpLLrbbQk012PIeNpqDi6QGYBnpMBL0RbhGcAJ24kcTZ+0DLup9SXpHgROXkw2WUs+KDsPBQYNsqPizhERRD3G/hKT3Gr5H8weMZq3d+/YJxFu8b3nw5f0Fm8b1Lo3NyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619540; c=relaxed/simple;
	bh=fMf5eIWWkXYxQExGvoSDFoDPSlY4nxrLOkS7IvheYMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdAmdnTuis0uEYajZlVESaCjWr1z25aC+QtPWjoEAb5b5sYZuNAGUPKosSVoBKHSOiP4xCcdA6HIxPx5KV8/udq4kwoYkOiFXWjXYDGzrrq9sXlbFijHsUkbXNg53O/L6gEveD+SDPwCMTegUQyEcI8ZlzXhZz6yI2QR/1T5dBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4eu7SJ6; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-4247d991161so26313345ab.3
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 02:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758619538; x=1759224338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8c604ZewnRLpeU1grbtsjwAHU/dMxGUwcFpSgof8tEc=;
        b=B4eu7SJ6ZNL82mnnJiONY2hhJMKUYGNG6GXAg/LvNZr1tS49FT2EyiuxsbonDz8qg+
         Wzq75S7XbQ4DN0vdYr849ONOyELVJQDRQCuV8rN7UEBpGn2K4wTYTYpwedDCRB6Luc79
         /UemQDJrwP9pxXuUsTLeDC0vRg04iIUZ7WYnwnnHdRJ/4h89XySFZML0S5mTPyhkgvFT
         aNkoD+RGjKwJW9ou2ZPXSIb3m4Ua8/JGAL7MpjSQnyzgbuMI+6lIvc0WjDFNAiOyxP82
         CY/XExYf3STlWMjCCjnDfmlrGc9bB5S7hLA1xbTgTqWbtf6bux9c+/YnItZJuIYej+3a
         oxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758619538; x=1759224338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8c604ZewnRLpeU1grbtsjwAHU/dMxGUwcFpSgof8tEc=;
        b=tbcgX/iDJB51feo6A9zKzKmFcBIci00BMiOXA55+N1obfaqExraftVsfhX/h+z/j2E
         0fQ4jhx4dDE8L+sZquNLXjD9sd3sWtbz3LccNcA/DhHfFf/q2ClFGjbr1x23sNtvwUIh
         QJ4qm26FUCti4sPZKHQxJFREx2N6D0p5HeiY+WAhElNxuVbXGMM4Hrgz2CYI0etXleVw
         iumgrAOEKlG8Yc/Ul895q4IHtRJsvNlH43LdUhDdEiat9eULdqU7lFVmkaw4f/4b7VNu
         RJ7htc8L2snljRFV2tV5ST9R14Mk9/TzZRdi7E2Nii6wy2zHWiprZDlW1vHvChKyTZ6V
         49dA==
X-Forwarded-Encrypted: i=1; AJvYcCX9lZQev0bcXjs3qczY5UIAxBdD04h4M8LNFvE30qGXVtt79KH4mRFQLq+wO3a6JOudZbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZU3EBwnz40l9kvNHmh+1ZPWlrmAx7XbrExeau82IZM3fLcWiZ
	KELR4IZTW2INXswWwqgu+zTAX6XuYToiQpuE4D+rGuiQKEDgMKVEcum2SKuXVvd3gfKt9IzfHK5
	m4k+3JGv6n6Stfel31FvlZl4UEF2mwZ0=
X-Gm-Gg: ASbGncuv8eu/eskwzG2XDolfhAbdsJKtchdgUwY7RfCjSEPWXGS1pMx+yNmiDBOELBI
	rOn9ZP1BLmyDbt0fM1Zd0IUituT2Jns+iHH9qTZXy3maqjlxhRH6KxfaHl6o6t9U2eYdfnU2KTP
	g+j2H1exQYdhOsXMotfv/8LsVTs1wFVweWi3JSQZouZswlutKVsaGSeybnPE0AlM32rmAkMpD3D
	tDncQ==
X-Google-Smtp-Source: AGHT+IEjT4SocX5FhebiEjGhxs0SM0vZNdNl+BudtmG49n/wCpyZbXWMt/4Y305ItjayGKKti/7Ycqo7bi5YtESFk28=
X-Received: by 2002:a05:6e02:1b06:b0:424:b860:7d84 with SMTP id
 e9e14a558f8ab-42581eb0702mr28738025ab.27.1758619537928; Tue, 23 Sep 2025
 02:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922152600.2455136-1-maciej.fijalkowski@intel.com>
 <20250922152600.2455136-3-maciej.fijalkowski@intel.com> <aNGL5qS8aIfcSDnD@mini-arch>
In-Reply-To: <aNGL5qS8aIfcSDnD@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 23 Sep 2025 17:25:01 +0800
X-Gm-Features: AS18NWC2iono7x-0aOIrKhxyLnSFqZ01fci9a33xhn49Oig56YKLbiLZFuB19Sk
Message-ID: <CAL+tcoDp0k74jJtUo179J7mkcf1KCAPMy+fWh-Mn7oC236n-kQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] xsk: remove @first_frag from xsk_build_skb()
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, netdev@vger.kernel.org, 
	magnus.karlsson@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 1:48=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 09/22, Maciej Fijalkowski wrote:
> > Devices that set IFF_TX_SKB_NO_LINEAR will not execute branch that
> > handles metadata, as we set @first_frag only for !IFF_TX_SKB_NO_LINEAR
> > code in xsk_build_skb().
> >
> > Same functionality can be achieved with checking if xsk_get_num_desc()
> > returns 0. To replace current usage of @first_frag with
> > XSKCB(skb)->num_descs check, pull out the code from
> > xsk_set_destructor_arg() that initializes sk_buff::cb and call it befor=
e
> > skb_store_bits() in branch that creates skb against first processed
> > frag. This so error path has the XSKCB(skb)->num_descs initialized and
> > can free skb in case skb_store_bits() failed.
> >
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >  net/xdp/xsk.c | 20 +++++++++++---------
> >  1 file changed, 11 insertions(+), 9 deletions(-)
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 72194f0a3fc0..064238400036 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -605,6 +605,13 @@ static u32 xsk_get_num_desc(struct sk_buff *skb)
> >       return XSKCB(skb)->num_descs;
> >  }
> >
> > +static void xsk_init_cb(struct sk_buff *skb)
> > +{
> > +     BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
> > +     INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
> > +     XSKCB(skb)->num_descs =3D 0;
> > +}
> > +
> >  static void xsk_destruct_skb(struct sk_buff *skb)
> >  {
> >       struct xsk_tx_metadata_compl *compl =3D &skb_shinfo(skb)->xsk_met=
a;
> > @@ -620,9 +627,6 @@ static void xsk_destruct_skb(struct sk_buff *skb)
> >
> >  static void xsk_set_destructor_arg(struct sk_buff *skb, u64 addr)
> >  {
> > -     BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
> > -     INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
> > -     XSKCB(skb)->num_descs =3D 0;
> >       skb_shinfo(skb)->destructor_arg =3D (void *)(uintptr_t)addr;
> >  }
> >
> > @@ -672,7 +676,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struc=
t xdp_sock *xs,
> >                       return ERR_PTR(err);
> >
> >               skb_reserve(skb, hr);
> > -
> > +             xsk_init_cb(skb);
> >               xsk_set_destructor_arg(skb, desc->addr);
> >       } else {
> >               xsk_addr =3D kmem_cache_zalloc(xsk_tx_generic_cache, GFP_=
KERNEL);
> > @@ -725,7 +729,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> >       struct xsk_tx_metadata *meta =3D NULL;
> >       struct net_device *dev =3D xs->dev;
> >       struct sk_buff *skb =3D xs->skb;
> > -     bool first_frag =3D false;
> >       int err;
> >
> >       if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
> > @@ -742,8 +745,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> >               len =3D desc->len;
> >
> >               if (!skb) {
> > -                     first_frag =3D true;
> > -
> >                       hr =3D max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->neede=
d_headroom));
> >                       tr =3D dev->needed_tailroom;
> >                       skb =3D sock_alloc_send_skb(&xs->sk, hr + len + t=
r, 1, &err);
> > @@ -752,6 +753,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> >
> >                       skb_reserve(skb, hr);
> >                       skb_put(skb, len);
> > +                     xsk_init_cb(skb);
> >
> >                       err =3D skb_store_bits(skb, 0, buffer, len);
> >                       if (unlikely(err))
> > @@ -797,7 +799,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> >                       list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->=
addrs_list);
> >               }
> >
> > -             if (first_frag && desc->options & XDP_TX_METADATA) {
> > +             if (!xsk_get_num_desc(skb) && desc->options & XDP_TX_META=
DATA) {
> >                       if (unlikely(xs->pool->tx_metadata_len =3D=3D 0))=
 {
> >                               err =3D -EINVAL;
> >                               goto free_err;
> > @@ -839,7 +841,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> >       return skb;
> >
> >  free_err:
> > -     if (first_frag && skb)
>
> [..]
>
> > +     if (skb && !xsk_get_num_desc(skb))
> >               kfree_skb(skb);
> >
> >       if (err =3D=3D -EOVERFLOW) {
>
> For IFF_TX_SKB_NO_LINEAR case, the 'goto free_err' is super confusing.
> xsk_build_skb_zerocopy either returns skb or an IS_ERR. Can we
> add a separate label to jump directly to 'if err =3D=3D -EOVERFLOW' for
> the IFF_TX_SKB_NO_LINEAR case?
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 72e34bd2d925..f56182c61c99 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -732,7 +732,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock =
*xs,
>                 skb =3D xsk_build_skb_zerocopy(xs, desc);
>                 if (IS_ERR(skb)) {
>                         err =3D PTR_ERR(skb);
> -                       goto free_err;
> +                       goto out;
>                 }
>         } else {
>                 u32 hr, tr, len;
> @@ -842,6 +842,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock =
*xs,
>         if (first_frag && skb)
>                 kfree_skb(skb);
>
> +out:
>         if (err =3D=3D -EOVERFLOW) {
>                 /* Drop the packet */
>                 xsk_inc_num_desc(xs->skb);
>
> After that, it seems we can look at skb_shinfo(skb)->nr_frags? Instead
> of adding new xsk_init_cb, seems more robust?

+1. It would be simpler.

And I think this patch should be a standalone one because it actually
supports the missing feature for the VM scenario.

Thanks,
Jason

