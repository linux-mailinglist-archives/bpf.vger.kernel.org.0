Return-Path: <bpf+bounces-69359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2C7B9545D
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 11:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A16190638B
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 09:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDACE3203BE;
	Tue, 23 Sep 2025 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBoK487u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36CB2EA462
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620203; cv=none; b=Y2IBwpXdGN7UsHf24iCuu3uX3eBH1PbOVs6axZffmQxLhWkeXWiP4FE8rlk2cwdLCd2C2trg/T9/cZIuXE+Ld5KHdRFmvTgoz4SJNiB4/+7Dxi8lU87hj0OHxUmvoPIQ3KYI9FQ/hokzRcFDJI7MzVLsFfuTb29jyunWbTIgaa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620203; c=relaxed/simple;
	bh=nv2ke6tn+rwle1SH1fZDsEGZYGu0aTRrE5FX+xqK+Ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yf5dY78Ch04j1RcptqoCj4APbFp5gae0mOnd6uQYNX3UrbJpCmVp4PJAPyKEa7wSfbjCAXQ1NOqW7pRL3UK3EXefCvw2wXg/ECrhXrwo2bcyOr6Slbf7vyhAPjez16KFDvGIyrHFA144ExsPMVWk0ThfLskpY44r9ee7KcsXSUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBoK487u; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-424da17e309so35062475ab.2
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 02:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758620201; x=1759225001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07gczeZCoNqWTne4WpSyGRUqszogELTK9eMrM+d5nCE=;
        b=eBoK487ufHEv5ed/Bzy/+oNYCHQnoWX/5jdiYnZBGr2uu7I/h2AKvb95Q37XgA4OYk
         XGw9TYo1bAN4kSTf68zxx5/UZMKFU784lHbntNRTB3kmACfLrHPg/hIo5OcpML/iWwao
         4/QZHeI8CuF6ydth/6BEcgrVz9Hm14rCUC7k91eAxg/v8YMocseX6WLYttNCj6xbfEAI
         X2EdakSil3v3A+RBmudTCsXzGMiXa+PRr/CK7xB+w1qMm0n/JcxpbBnlk/1kWsySZXBE
         C5OgADuBwTxRAcV4ta8J/Ph85SejykRpREfuII9dzYvVlHsO21StlERs/bGmJBcvLDye
         nClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758620201; x=1759225001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07gczeZCoNqWTne4WpSyGRUqszogELTK9eMrM+d5nCE=;
        b=nPGp5XR75lgiBNQtSMCvEmFFGFVhAIEOzvc5leEGcnrXNejFBDW+tz30Wm5Hjv2+fo
         9a1pWezzA7rY8EmQXtREIpDuToxEajQg4tAupY4uODQ1FPt0mg2wOfwbYcL4cDM/kegS
         7pTgaR/XTH1yOdS+C/tEHO4wzSVUd/xHDrrlV8HFshzeB6qBPcFsmIVAYop83us0Ul5I
         fXBhBV40eieM9+VFlVT9smyM4l18HBIOJVvvB3MnzwMhZt2NsOVGYiIwGK4bIiTAeUya
         xP2+vX5hiupB8dNVTvc4DwR8kCtBLOgwgFAdgsSpZw6lPaYV7Swe0baa0AASkuKBKvKI
         YLdg==
X-Forwarded-Encrypted: i=1; AJvYcCViukM5xem67fWOQ5fjg8ZUaAzYM8XbomjQDgc6X5zmhA3CPwzF2Zk7iUc7ITwUytCS5zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWdqRulvsr4zjqxjynqTrhECxqvB3SnGEtcrCy/rHT9YS5mbc8
	Mro/FOyy4IVCqwTv5Hj37OY6yfOdu1VR7NQi17SLq/8x7NztGyAsVrGPvNgtsEQa50in/QP23Sy
	pQD32PdkLWZaCcjp0Ks3l44VBTMESFvU=
X-Gm-Gg: ASbGnctjfS6qcfJeIQnWdGE5yd3Y2egAFfj2SObWDGqlLYmyTfRki1tvpn0hafVNd8m
	bac9cBecgUkJIYOeTUMFWvJQ5Gjcj0UoJizOE7zXErk1Otmzzb25t/7oPE57U+YGvmV19hcAo4C
	ME+Cuqs9aJxVFsSyVxunKFmBY2NSBMM5KJaPzUUpY9qHAs6NJYELPb2wtDBZOdS9KoifMWokMOl
	tlKkw==
X-Google-Smtp-Source: AGHT+IG0ztFnUownBdDBZUywkW11itbt3hvmhNXknfo4SY5E9GEOqr5UDXaGVO3b8CjtbXoeLITn8WMo1FbyiKecXUU=
X-Received: by 2002:a05:6e02:3c8a:b0:418:aefa:bb83 with SMTP id
 e9e14a558f8ab-42581e1722fmr28029285ab.5.1758620200853; Tue, 23 Sep 2025
 02:36:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922152600.2455136-1-maciej.fijalkowski@intel.com>
 <20250922152600.2455136-3-maciej.fijalkowski@intel.com> <aNGL5qS8aIfcSDnD@mini-arch>
 <CAL+tcoDp0k74jJtUo179J7mkcf1KCAPMy+fWh-Mn7oC236n-kQ@mail.gmail.com>
In-Reply-To: <CAL+tcoDp0k74jJtUo179J7mkcf1KCAPMy+fWh-Mn7oC236n-kQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 23 Sep 2025 17:36:04 +0800
X-Gm-Features: AS18NWDG-AjJmMTzE5WawY-uelapX-3CU9ipRLmQKLZ9nTIBG8k0JR09_V8lFP8
Message-ID: <CAL+tcoBWtG7VHifO0rXxJqs7OC5Raf-RmhqO5=6AvvHD+NsVgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] xsk: remove @first_frag from xsk_build_skb()
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, netdev@vger.kernel.org, 
	magnus.karlsson@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 5:25=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Tue, Sep 23, 2025 at 1:48=E2=80=AFAM Stanislav Fomichev <stfomichev@gm=
ail.com> wrote:
> >
> > On 09/22, Maciej Fijalkowski wrote:
> > > Devices that set IFF_TX_SKB_NO_LINEAR will not execute branch that
> > > handles metadata, as we set @first_frag only for !IFF_TX_SKB_NO_LINEA=
R
> > > code in xsk_build_skb().
> > >
> > > Same functionality can be achieved with checking if xsk_get_num_desc(=
)
> > > returns 0. To replace current usage of @first_frag with
> > > XSKCB(skb)->num_descs check, pull out the code from
> > > xsk_set_destructor_arg() that initializes sk_buff::cb and call it bef=
ore
> > > skb_store_bits() in branch that creates skb against first processed
> > > frag. This so error path has the XSKCB(skb)->num_descs initialized an=
d
> > > can free skb in case skb_store_bits() failed.
> > >
> > > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > ---
> > >  net/xdp/xsk.c | 20 +++++++++++---------
> > >  1 file changed, 11 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index 72194f0a3fc0..064238400036 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -605,6 +605,13 @@ static u32 xsk_get_num_desc(struct sk_buff *skb)
> > >       return XSKCB(skb)->num_descs;
> > >  }
> > >
> > > +static void xsk_init_cb(struct sk_buff *skb)
> > > +{
> > > +     BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
> > > +     INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
> > > +     XSKCB(skb)->num_descs =3D 0;
> > > +}
> > > +
> > >  static void xsk_destruct_skb(struct sk_buff *skb)
> > >  {
> > >       struct xsk_tx_metadata_compl *compl =3D &skb_shinfo(skb)->xsk_m=
eta;
> > > @@ -620,9 +627,6 @@ static void xsk_destruct_skb(struct sk_buff *skb)
> > >
> > >  static void xsk_set_destructor_arg(struct sk_buff *skb, u64 addr)
> > >  {
> > > -     BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
> > > -     INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
> > > -     XSKCB(skb)->num_descs =3D 0;
> > >       skb_shinfo(skb)->destructor_arg =3D (void *)(uintptr_t)addr;
> > >  }
> > >
> > > @@ -672,7 +676,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(str=
uct xdp_sock *xs,
> > >                       return ERR_PTR(err);
> > >
> > >               skb_reserve(skb, hr);
> > > -
> > > +             xsk_init_cb(skb);
> > >               xsk_set_destructor_arg(skb, desc->addr);
> > >       } else {
> > >               xsk_addr =3D kmem_cache_zalloc(xsk_tx_generic_cache, GF=
P_KERNEL);
> > > @@ -725,7 +729,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_s=
ock *xs,
> > >       struct xsk_tx_metadata *meta =3D NULL;
> > >       struct net_device *dev =3D xs->dev;
> > >       struct sk_buff *skb =3D xs->skb;
> > > -     bool first_frag =3D false;
> > >       int err;
> > >
> > >       if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
> > > @@ -742,8 +745,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_s=
ock *xs,
> > >               len =3D desc->len;
> > >
> > >               if (!skb) {
> > > -                     first_frag =3D true;
> > > -
> > >                       hr =3D max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->nee=
ded_headroom));
> > >                       tr =3D dev->needed_tailroom;
> > >                       skb =3D sock_alloc_send_skb(&xs->sk, hr + len +=
 tr, 1, &err);
> > > @@ -752,6 +753,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_s=
ock *xs,
> > >
> > >                       skb_reserve(skb, hr);
> > >                       skb_put(skb, len);
> > > +                     xsk_init_cb(skb);
> > >
> > >                       err =3D skb_store_bits(skb, 0, buffer, len);
> > >                       if (unlikely(err))
> > > @@ -797,7 +799,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_s=
ock *xs,
> > >                       list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)=
->addrs_list);
> > >               }
> > >
> > > -             if (first_frag && desc->options & XDP_TX_METADATA) {
> > > +             if (!xsk_get_num_desc(skb) && desc->options & XDP_TX_ME=
TADATA) {
> > >                       if (unlikely(xs->pool->tx_metadata_len =3D=3D 0=
)) {
> > >                               err =3D -EINVAL;
> > >                               goto free_err;
> > > @@ -839,7 +841,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_s=
ock *xs,
> > >       return skb;
> > >
> > >  free_err:
> > > -     if (first_frag && skb)
> >
> > [..]
> >
> > > +     if (skb && !xsk_get_num_desc(skb))
> > >               kfree_skb(skb);
> > >
> > >       if (err =3D=3D -EOVERFLOW) {
> >
> > For IFF_TX_SKB_NO_LINEAR case, the 'goto free_err' is super confusing.
> > xsk_build_skb_zerocopy either returns skb or an IS_ERR. Can we
> > add a separate label to jump directly to 'if err =3D=3D -EOVERFLOW' for
> > the IFF_TX_SKB_NO_LINEAR case?
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 72e34bd2d925..f56182c61c99 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -732,7 +732,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> >                 skb =3D xsk_build_skb_zerocopy(xs, desc);
> >                 if (IS_ERR(skb)) {
> >                         err =3D PTR_ERR(skb);
> > -                       goto free_err;
> > +                       goto out;
> >                 }
> >         } else {
> >                 u32 hr, tr, len;
> > @@ -842,6 +842,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> >         if (first_frag && skb)
> >                 kfree_skb(skb);
> >
> > +out:
> >         if (err =3D=3D -EOVERFLOW) {
> >                 /* Drop the packet */
> >                 xsk_inc_num_desc(xs->skb);
> >
> > After that, it seems we can look at skb_shinfo(skb)->nr_frags? Instead
> > of adding new xsk_init_cb, seems more robust?
>
> +1. It would be simpler.
>
> And I think this patch should be a standalone one because it actually
> supports the missing feature for the VM scenario.

Reading the commit message one more time, previously I wrongly
considered the original goal you wanted to achieve was to support the
VM case. So please ignore my previous suggestion since it's a simple
cleanup.

Thanks,
Jason

>
> Thanks,
> Jason

