Return-Path: <bpf+bounces-69649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7491B9CE06
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 02:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A998C1BC54B8
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 00:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6EB258CE9;
	Thu, 25 Sep 2025 00:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVITXUdS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C47823A564
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 00:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758759481; cv=none; b=gi1/luy9z22YBmA6vxClVGjuz8IL1/X9GnPGQo1Uyj+jQM/4e/RGPQ08Z9o9pGYBF/S84cZqeK/CF0H/25bN/my90JSufjEbezvXakbIfjKW9yxTKAd6ZzbSQS/tSCsLxo3ohmx5g6dOSNGmVOZTKzPS7IRn5HFaLAJtjEF2gT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758759481; c=relaxed/simple;
	bh=FXj4jpgxx1BHl/d5F/THOBV6OUMdc1WhDaVQeJbPu/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AM5x3fJcbe00HV3OXXzLPqrD7AJAxTFWEm5t4WTCvlJJ1ww6EMeiM6s1zy78w1vz4JlmdLwkHmrOsiEX7QS0DHtA9UuJv/SJKOyBKLPsOyyPNy3kxIsyEGWWmKxOwAw5G1lpzrCWKKIlYsNhlW65H3Wn7iMiGkq2n/Lulhnub2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVITXUdS; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-88cdb27571eso23648039f.0
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 17:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758759476; x=1759364276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHJd71Ln/PmmX98mc5g7h6xoWxHqerCZ7osIfkTwz3c=;
        b=MVITXUdSCkTg+bZbsQZTpC2wNJmhMso/8qzbC4xLo4YN2EqOj9m+HP1QhHtMkCbzZT
         F7i/jQYILITMTbXdwEaPQCWaTqb1KaD52rPlPISty9WH/LzshcFhW9Td+xyLDvcpVEXg
         bDCw9lbbhy+XXFk527eovyyLkr8UuZXkqnDy4tdtWWqMjfY6Vxet2I/AhrIJ1qchfwII
         E2sz+hDj5zKWOiFBO8lYLqSHflWhA5Tf6UUejXBJJtwtSv9IIww82ojF/QQRt7LbxPy9
         Kh+A6SrPW+uzoGlll2NJJsDFmWBvYuXzuZS68THQsPvzNO9CVd6vJiKqxWcNCOuACs7W
         SbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758759476; x=1759364276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHJd71Ln/PmmX98mc5g7h6xoWxHqerCZ7osIfkTwz3c=;
        b=Ljf74VOZW7rFvNmL1d+p3IDyWuTWNMWF1/XJNfar9QE8lVgI4lcbtN5SkA4uxdPo+C
         +LbMmugSre3kMBIpyC0J4QjhyEZV9VLUNodqOptlUiXCo+O0jcHyWMKBSEFWoRzMjIog
         gssqLLG8HIqYQP2YR2/Hqw6wZcA0b/gb0dlWRZgt9Zi35E8w77PtUnLp++DzgIXwHOmc
         lw7ZD/ocwwv9UMSm+9KcdbtyfE1yW/Cbw5YZZ4oGisfrIYjhUj8MaRT0v6PkliHAkfvs
         BsBALD9Mw4NlxWPJaYKSLpG8rI3ogXujSkAtfYn0CQv8Tdcq+D5BByna48rBzLHjYWSU
         Srbw==
X-Forwarded-Encrypted: i=1; AJvYcCXBgbNl1LieU5/yu/CDQjmoVgR1ajE4fyeOiup7HB1zn8Iu2Y0cS9wKzhjKLw64kLN0QDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzik83GSer/HG6C4JHApoSo3MKOmyXRhrET3odL4gVoiHxY0vi6
	KomSTPEFeeRxJqGfbiyaEgyct4Olw63EsbPt8UJuqk/oix87aXiRj1a7o+6/kNLMKqtGOButJhv
	/TkgtcxGkVK7653SUnVR3MzBZgCmI4lxlryYrPjw=
X-Gm-Gg: ASbGncv2AibGpKp/Xwovt7zkP0TNTyEBQS9lTQYvvm5tOtelNjD8I/QZ31tOQBgwrOn
	2dBidPeXKwAF9+vAfqXgShyxy4tkmn/z11IsBn1H8e5Jq3C/HR0hslPtxcYbBu7rKdhWwG6Nz4c
	h7EsgLngUVwrlYPm6i+7Jgh1r8grvet6blaFEGu0u4DL+mdzCetVTRkQuhvHBrwvLJ6fDcl9EkL
	PqxYw==
X-Google-Smtp-Source: AGHT+IHu722/W2NzM3zkxbJCLjCC3dcpEDBSWk5h4XLnEzOecSZ1eDXB2TdZ5si3lH28ULeHd32peTeplNmHAde6ZdQ=
X-Received: by 2002:a05:6e02:3813:b0:424:8858:6ba9 with SMTP id
 e9e14a558f8ab-4259566c92emr24540535ab.32.1758759476175; Wed, 24 Sep 2025
 17:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922152600.2455136-1-maciej.fijalkowski@intel.com>
 <20250922152600.2455136-3-maciej.fijalkowski@intel.com> <aNGL5qS8aIfcSDnD@mini-arch>
 <CAL+tcoDp0k74jJtUo179J7mkcf1KCAPMy+fWh-Mn7oC236n-kQ@mail.gmail.com> <aNQBuQYHGHuekAhV@boxer>
In-Reply-To: <aNQBuQYHGHuekAhV@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 25 Sep 2025 08:17:19 +0800
X-Gm-Features: AS18NWBcfyeVd45xlKDGtKhzcf2zpsE5AXRVABPBlxuPwpOTJ90BI8MDX5g1wP8
Message-ID: <CAL+tcoDkcKNKCe9B1bQvsZEiKmJEVSKJy_gQ-PONu9qqUXF9AQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] xsk: remove @first_frag from xsk_build_skb()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, netdev@vger.kernel.org, 
	magnus.karlsson@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 10:36=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Tue, Sep 23, 2025 at 05:25:01PM +0800, Jason Xing wrote:
> > On Tue, Sep 23, 2025 at 1:48=E2=80=AFAM Stanislav Fomichev <stfomichev@=
gmail.com> wrote:
> > >
> > > On 09/22, Maciej Fijalkowski wrote:
> > > > Devices that set IFF_TX_SKB_NO_LINEAR will not execute branch that
> > > > handles metadata, as we set @first_frag only for !IFF_TX_SKB_NO_LIN=
EAR
> > > > code in xsk_build_skb().
> > > >
> > > > Same functionality can be achieved with checking if xsk_get_num_des=
c()
> > > > returns 0. To replace current usage of @first_frag with
> > > > XSKCB(skb)->num_descs check, pull out the code from
> > > > xsk_set_destructor_arg() that initializes sk_buff::cb and call it b=
efore
> > > > skb_store_bits() in branch that creates skb against first processed
> > > > frag. This so error path has the XSKCB(skb)->num_descs initialized =
and
> > > > can free skb in case skb_store_bits() failed.
> > > >
> > > > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > > ---
> > > >  net/xdp/xsk.c | 20 +++++++++++---------
> > > >  1 file changed, 11 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > index 72194f0a3fc0..064238400036 100644
> > > > --- a/net/xdp/xsk.c
> > > > +++ b/net/xdp/xsk.c
> > > > @@ -605,6 +605,13 @@ static u32 xsk_get_num_desc(struct sk_buff *sk=
b)
> > > >       return XSKCB(skb)->num_descs;
> > > >  }
> > > >
> > > > +static void xsk_init_cb(struct sk_buff *skb)
> > > > +{
> > > > +     BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
> > > > +     INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
> > > > +     XSKCB(skb)->num_descs =3D 0;
> > > > +}
> > > > +
> > > >  static void xsk_destruct_skb(struct sk_buff *skb)
> > > >  {
> > > >       struct xsk_tx_metadata_compl *compl =3D &skb_shinfo(skb)->xsk=
_meta;
> > > > @@ -620,9 +627,6 @@ static void xsk_destruct_skb(struct sk_buff *sk=
b)
> > > >
> > > >  static void xsk_set_destructor_arg(struct sk_buff *skb, u64 addr)
> > > >  {
> > > > -     BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
> > > > -     INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
> > > > -     XSKCB(skb)->num_descs =3D 0;
> > > >       skb_shinfo(skb)->destructor_arg =3D (void *)(uintptr_t)addr;
> > > >  }
> > > >
> > > > @@ -672,7 +676,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(s=
truct xdp_sock *xs,
> > > >                       return ERR_PTR(err);
> > > >
> > > >               skb_reserve(skb, hr);
> > > > -
> > > > +             xsk_init_cb(skb);
> > > >               xsk_set_destructor_arg(skb, desc->addr);
> > > >       } else {
> > > >               xsk_addr =3D kmem_cache_zalloc(xsk_tx_generic_cache, =
GFP_KERNEL);
> > > > @@ -725,7 +729,6 @@ static struct sk_buff *xsk_build_skb(struct xdp=
_sock *xs,
> > > >       struct xsk_tx_metadata *meta =3D NULL;
> > > >       struct net_device *dev =3D xs->dev;
> > > >       struct sk_buff *skb =3D xs->skb;
> > > > -     bool first_frag =3D false;
> > > >       int err;
> > > >
> > > >       if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
> > > > @@ -742,8 +745,6 @@ static struct sk_buff *xsk_build_skb(struct xdp=
_sock *xs,
> > > >               len =3D desc->len;
> > > >
> > > >               if (!skb) {
> > > > -                     first_frag =3D true;
> > > > -
> > > >                       hr =3D max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->n=
eeded_headroom));
> > > >                       tr =3D dev->needed_tailroom;
> > > >                       skb =3D sock_alloc_send_skb(&xs->sk, hr + len=
 + tr, 1, &err);
> > > > @@ -752,6 +753,7 @@ static struct sk_buff *xsk_build_skb(struct xdp=
_sock *xs,
> > > >
> > > >                       skb_reserve(skb, hr);
> > > >                       skb_put(skb, len);
> > > > +                     xsk_init_cb(skb);
> > > >
> > > >                       err =3D skb_store_bits(skb, 0, buffer, len);
> > > >                       if (unlikely(err))
> > > > @@ -797,7 +799,7 @@ static struct sk_buff *xsk_build_skb(struct xdp=
_sock *xs,
> > > >                       list_add_tail(&xsk_addr->addr_node, &XSKCB(sk=
b)->addrs_list);
> > > >               }
> > > >
> > > > -             if (first_frag && desc->options & XDP_TX_METADATA) {
> > > > +             if (!xsk_get_num_desc(skb) && desc->options & XDP_TX_=
METADATA) {
> > > >                       if (unlikely(xs->pool->tx_metadata_len =3D=3D=
 0)) {
> > > >                               err =3D -EINVAL;
> > > >                               goto free_err;
> > > > @@ -839,7 +841,7 @@ static struct sk_buff *xsk_build_skb(struct xdp=
_sock *xs,
> > > >       return skb;
> > > >
> > > >  free_err:
> > > > -     if (first_frag && skb)
> > >
> > > [..]
> > >
> > > > +     if (skb && !xsk_get_num_desc(skb))
> > > >               kfree_skb(skb);
> > > >
> > > >       if (err =3D=3D -EOVERFLOW) {
> > >
> > > For IFF_TX_SKB_NO_LINEAR case, the 'goto free_err' is super confusing=
.
> > > xsk_build_skb_zerocopy either returns skb or an IS_ERR. Can we
> > > add a separate label to jump directly to 'if err =3D=3D -EOVERFLOW' f=
or
> > > the IFF_TX_SKB_NO_LINEAR case?
>
> Right, I got hit with this when running xdpsock within VM now against
> virtio-net driver. Since I removed @first_frag and sock_alloc_send_skb()
> managed to give me -EAGAIN at start, skb was treated as valid pointer and
> then I got splat when accessing either cb or skb_shared_info.
>
> So either we NULL the skb for xsk_build_skb_zerocopy() error path (which
> would be fine even for -EOVERFLOW as error path uses xs->skb pointer, not
> the local one) or we introduce separate label as you suggest. No strong
> opinions here.
>
> > >
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index 72e34bd2d925..f56182c61c99 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -732,7 +732,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_s=
ock *xs,
> > >                 skb =3D xsk_build_skb_zerocopy(xs, desc);
> > >                 if (IS_ERR(skb)) {
> > >                         err =3D PTR_ERR(skb);
> > > -                       goto free_err;
> > > +                       goto out;
> > >                 }
> > >         } else {
> > >                 u32 hr, tr, len;
> > > @@ -842,6 +842,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_s=
ock *xs,
> > >         if (first_frag && skb)
> > >                 kfree_skb(skb);
> > >
> > > +out:
> > >         if (err =3D=3D -EOVERFLOW) {
> > >                 /* Drop the packet */
> > >                 xsk_inc_num_desc(xs->skb);
> > >
> > > After that, it seems we can look at skb_shinfo(skb)->nr_frags? Instea=
d
> > > of adding new xsk_init_cb, seems more robust?
>
> Thanks! I'll do it.
>
> >
> > +1. It would be simpler.
> >
> > And I think this patch should be a standalone one because it actually
> > supports the missing feature for the VM scenario.
>
> Hi Jason,
> in commit message, I wrote about enabling tx metadata for
> xsk_build_skb_zerocopy() but code did not reflect that as you point out i=
n
> your later reply.
>
> Unless there are any objections I will actually enable it there.

Oh, if you made up your mind enabling it in the next version, how
about changing the title of this series because the core changes are
all about tx metadata rather than simply cleaning up the codes. See,
patch 1, I think, will be scrapped; patch 2 is used to support that
missing feature; patch 3 is a follow-up to patch 2. WDYT?

Thanks,
Jason

