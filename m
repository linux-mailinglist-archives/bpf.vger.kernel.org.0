Return-Path: <bpf+bounces-68836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BA5B86563
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 19:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C541CC4672
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 17:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14707286D79;
	Thu, 18 Sep 2025 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVWiG7Px"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA7F284B20
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218220; cv=none; b=uAm8A6aboIhY7VG8QsaK6Lp/S4nvugT+Q4Chfl8mDZsnkZ3t3iXVHEkCbZpOrrc0DqZHaoKuA9GKdcna1xrdxxXprDabh8vsi0Sfxe+PCtiVbdLW245Z1xcapKVc46hsXhSN5czTnQLVcKE8WvLsmY87xDRMpnF3lxPFZKvn2/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218220; c=relaxed/simple;
	bh=MMwfYV8IBOMlbTI8PkZDmsqu1i7TUfdE88p04BfIMzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJhmCBZJFNnNh9wOIGcA7c78M4P1I03HLYA+HmG+xKEdTrSwaXmLB7MbSgys7mgSA2i++gISrtrEPI9UHhGgdmeC6pWo5+idDWZ4UZIDekO9p9/1neWb3Z/CjlPhZMkGOJsFChe1Ga5p+Tv9H0ueXR+B859Eo1wy6zPuYmJuIsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVWiG7Px; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7341b13f2dcso9124177b3.3
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 10:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758218218; x=1758823018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JI0ytwNsiNctSeqBGOIrCT7jeAkBboaje0nOE5Ad0nk=;
        b=LVWiG7Px6fA9PjA5/nSs7pvLjJF06nkFgBgQ1koHt+QrIcn0m9KB28ppeOQ4SsbrLD
         dANn6FILuxeM96pxPPd4mxqUBmSOpaWWFsnO8OXgdrJpFI52WDMUxyWLU3a18+6Plw53
         YAh+EoQ+xOcZveXUiwQ7KfBs/Ww4r6TB606hCV5Z4vsVymbVAuYYQUaXZGM5Lmp07OkJ
         AULfW2aq+9LogFLNaSTmqj1QdZUmQXhsYfH3x95Qr+Gx1AhgDpjFTo6Rjuudn1g+Su8s
         xQznnWM8xhnxd18fMeyUkDw3U8xmEytc0E5EfFT3k4REiKOZgeaaj3uVfZu92uNTDLeR
         PhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758218218; x=1758823018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JI0ytwNsiNctSeqBGOIrCT7jeAkBboaje0nOE5Ad0nk=;
        b=fiQGhvkUSxc6F3ujJNb0SgTUhCPmDZUELya4y/f6gMVz7Dc5hoHdhXIGCnGX6cR1ZY
         afCL99O06pQ2Pvxe2AqqPubbpwri0ya5hz8ETpTR4rO4uGVVDnbYmF0Ie4QSDsRgml00
         KdX5o9/CXjsJXa3FiXOx9cWDNM1OKhGkcev90g1Xw2eEK/QAckHcjm9asKHzNjK8es6f
         +05Xkdt3S/GtTQU674bHL4MUhXLbO8Po2/1tIPQSsyxcUIP+93pjYD6siGU7UIZWYYOx
         iGQ6hiyfr9X8aKNe3CjW4Ls8nhimG61ZxfqpO+9G8SstRLzvcQMK5PoaB8Z2oS60Xn1V
         sLDA==
X-Gm-Message-State: AOJu0YxpGQo5Lub1jCqQAeefNpp8XlIxBV2ANBbrAqj6tVlfQQD7oXhY
	K5wEOzODHpsw1b9gp5XL8EhxW9jwDaDjwtaYgBT63oLcOMTz8K/UJoaWQWWeoPVo/NEnqKeVvkN
	KfbkndcnBKldltypBjcv4DzH6sze4aPs=
X-Gm-Gg: ASbGncspiPsFfgwT0kNCQbvZuAazOYl/n7oePuYUnlNcKlFwD5ojXDbhKRDf8gCQM4o
	kJMNF4rRO5UBJ31dMjkWvG+9B+e+XEQAYwo8R2ldDWFrOiBirPVpP5FfCYbKpr7dRIDsnt5xC7V
	HztkQAQg0We7gpfsPSrO/JTN2YXmC3jlM0odb6jJ0YVdLnj2BUmMXfEiqAHFMM58raEE+tWO5o0
	+fIYsUpeHzgXsbbdAf3/H4qX/Ts4gvWIIUW1e/11A==
X-Google-Smtp-Source: AGHT+IE+8cBTRYJzRPs3+7tJhep8jqUtXCLSGs0FbvnGToRJnguWGZ5Aab8qHeptaWqqfVDrIM5VaKIdIw5SwSgIw38=
X-Received: by 2002:a05:690c:d19:b0:731:1bc7:7830 with SMTP id
 00721157ae682-73d32a41e01mr3892487b3.23.1758218217685; Thu, 18 Sep 2025
 10:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917225513.3388199-1-ameryhung@gmail.com> <20250917225513.3388199-3-ameryhung@gmail.com>
 <aMvMxrPsNXbTuF3c@boxer>
In-Reply-To: <aMvMxrPsNXbTuF3c@boxer>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 18 Sep 2025 10:56:46 -0700
X-Gm-Features: AS18NWA_T3MwfeYWVpB3zq7u66T9v5I9hJ0hjLahAY1YXy-Fb3NX4oDmLBXdasc
Message-ID: <CAMB2axMg6unuuO-Reu3qU3cU_u+sDjkpwd5srW+9RyJW9coqig@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/6] bpf: Support pulling non-linear xdp data
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, paul.chaignon@gmail.com, 
	kuba@kernel.org, stfomichev@gmail.com, martin.lau@kernel.org, 
	mohsin.bashr@gmail.com, noren@nvidia.com, dtatulea@nvidia.com, 
	saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 2:11=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Sep 17, 2025 at 03:55:09PM -0700, Amery Hung wrote:
> > Add kfunc, bpf_xdp_pull_data(), to support pulling data from xdp
> > fragments. Similar to bpf_skb_pull_data(), bpf_xdp_pull_data() makes
> > the first len bytes of data directly readable and writable in bpf
> > programs. If the "len" argument is larger than the linear data size,
> > data in fragments will be copied to the linear data area when there
> > is enough room. Specifically, the kfunc will try to use the tailroom
> > first. When the tailroom is not enough, metadata and data will be
> > shifted down to make room for pulling data.
> >
> > A use case of the kfunc is to decapsulate headers residing in xdp
> > fragments. It is possible for a NIC driver to place headers in xdp
> > fragments. To keep using direct packet access for parsing and
> > decapsulating headers, users can pull headers into the linear data
> > area by calling bpf_xdp_pull_data() and then pop the header with
> > bpf_xdp_adjust_head().
> >
> > Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  net/core/filter.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 0b82cb348ce0..0e8d63bf1d30 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -12212,6 +12212,96 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(=
struct bpf_sock_ops_kern *skops,
> >       return 0;
> >  }
> >
> > +/**
> > + * bpf_xdp_pull_data() - Pull in non-linear xdp data.
> > + * @x: &xdp_md associated with the XDP buffer
> > + * @len: length of data to be made directly accessible in the linear p=
art
> > + *
> > + * Pull in data in case the XDP buffer associated with @x is non-linea=
r and
> > + * not all @len are in the linear data area.
> > + *
> > + * Direct packet access allows reading and writing linear XDP data thr=
ough
> > + * packet pointers (i.e., &xdp_md->data + offsets). The amount of data=
 which
> > + * ends up in the linear part of the xdp_buff depends on the NIC and i=
ts
> > + * configuration. When a frag-capable XDP program wants to directly ac=
cess
> > + * headers that may be in the non-linear area, call this kfunc to make=
 sure
> > + * the data is available in the linear area. Alternatively, use dynptr=
 or
> > + * bpf_xdp_{load,store}_bytes() to access data without pulling.
> > + *
> > + * This kfunc can also be used with bpf_xdp_adjust_head() to decapsula=
te
> > + * headers in the non-linear data area.
> > + *
> > + * A call to this kfunc may reduce headroom. If there is not enough ta=
ilroom
> > + * in the linear data area, metadata and data will be shifted down.
> > + *
> > + * A call to this kfunc is susceptible to change the buffer geometry.
> > + * Therefore, at load time, all checks on pointers previously done by =
the
> > + * verifier are invalidated and must be performed again, if the kfunc =
is used
> > + * in combination with direct packet access.
> > + *
> > + * Return:
> > + * * %0         - success
> > + * * %-EINVAL   - invalid len
> > + */
> > +__bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
> > +{
> > +     struct xdp_buff *xdp =3D (struct xdp_buff *)x;
> > +     struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff(x=
dp);
> > +     int i, delta, shift, headroom, tailroom, n_frags_free =3D 0;
> > +     void *data_hard_end =3D xdp_data_hard_end(xdp);
> > +     int data_len =3D xdp->data_end - xdp->data;
> > +     void *start;
> > +
> > +     if (len <=3D data_len)
> > +             return 0;
> > +
> > +     if (unlikely(len > xdp_get_buff_len(xdp)))
> > +             return -EINVAL;
> > +
> > +     start =3D xdp_data_meta_unsupported(xdp) ? xdp->data : xdp->data_=
meta;
> > +
> > +     headroom =3D start - xdp->data_hard_start - sizeof(struct xdp_fra=
me);
> > +     tailroom =3D data_hard_end - xdp->data_end;
> > +
> > +     delta =3D len - data_len;
> > +     if (unlikely(delta > tailroom + headroom))
> > +             return -EINVAL;
> > +
> > +     shift =3D delta - tailroom;
> > +     if (shift > 0) {
> > +             memmove(start - shift, start, xdp->data_end - start);
> > +
> > +             xdp->data_meta -=3D shift;
> > +             xdp->data -=3D shift;
> > +             xdp->data_end -=3D shift;
> > +     }
> > +
> > +     for (i =3D 0; i < sinfo->nr_frags && delta; i++) {
> > +             skb_frag_t *frag =3D &sinfo->frags[i];
> > +             u32 shrink =3D min_t(u32, delta, skb_frag_size(frag));
> > +
> > +             memcpy(xdp->data_end, skb_frag_address(frag), shrink);
> > +
> > +             xdp->data_end +=3D shrink;
> > +             sinfo->xdp_frags_size -=3D shrink;
> > +             delta -=3D shrink;
> > +             if (bpf_xdp_shrink_data(xdp, frag, shrink, false))
> > +                     n_frags_free++;
> > +     }
> > +
> > +     if (unlikely(n_frags_free)) {
> > +             memmove(sinfo->frags, sinfo->frags + n_frags_free,
> > +                     (sinfo->nr_frags - n_frags_free) * sizeof(skb_fra=
g_t));
> > +
> > +             sinfo->nr_frags -=3D n_frags_free;
> > +
> > +             if (!sinfo->nr_frags)
> > +                     xdp_buff_clear_frags_flag(xdp);
>
> Nit: should we take care of pfmemalloc flag as well?
>

Does it mean we should also clear this bit in bpf_xdp_adjsut_tail()?

> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  __bpf_kfunc_end_defs();
> >
> >  int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
> > @@ -12239,6 +12329,7 @@ BTF_KFUNCS_END(bpf_kfunc_check_set_skb_meta)
> >
> >  BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
> >  BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
> > +BTF_ID_FLAGS(func, bpf_xdp_pull_data)
> >  BTF_KFUNCS_END(bpf_kfunc_check_set_xdp)
> >
> >  BTF_KFUNCS_START(bpf_kfunc_check_set_sock_addr)
> > --
> > 2.47.3
> >

