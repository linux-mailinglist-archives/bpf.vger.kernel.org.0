Return-Path: <bpf+bounces-68704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F6CB81A8B
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 21:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DFFB487F9C
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 19:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F247A3002B6;
	Wed, 17 Sep 2025 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7VOPK+8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92902727ED
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 19:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137843; cv=none; b=P1yjO0HOtc8aPIo45uwMoBfDBiySK+fmq0uUA3kfc+UENexc9b+Ld1FbB6NRx1X6RFvMotdZLRoM33KzJA6KW0BGFRViVrI+x8ZFc9mS4Akv57qaHJI+8o6oPqrrRmax5pvqGrc+b+Cg4uu3SjxcPj0BzE+kXqdxzMJo2JhJQ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137843; c=relaxed/simple;
	bh=q1iCwZvMDFTy7Jc4lEAA87uuTHihaEy+2OvWFQBL1cU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=szZD8MH5mbkcxNEsDVtGAr/biLqte26q02L4cISOCMQjHG5KOFVo5v4ZPJIx8wTwrmdrPWIvPrNp4FVq7u2kQ5RxLX1JoAA6T775m0kbwUZpMyxPjxPFxVD+qauvqo+UehEqLaPOEyqjofantWwVzMWawm8AxNPYKBWcxPtYwGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7VOPK+8; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d6083cc69so2349057b3.2
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 12:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758137841; x=1758742641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g500mWMdVffBJl/bJFPiPQYd74E9jSVxrHMEKT+H8A8=;
        b=O7VOPK+8Z7xaryTcqCNwSfKAEwGN9O8X1KkQNtOFPvpU8IMT9pdplW/8pzWgOsIyCe
         0v8iwJHJvutRVtFv7QhDqV8MJjSP22Oc+W3dLBYnTAw1C+KclFRdWCdgmWpnOk+zUvLy
         DVf9+NmcPSEd1bI5gNXIeIR0qUF5sSjqTrTOI7BUUPLdkSCWUgoXTHnA6PXvBtMFitx2
         CWS1H5y+EbIeA6Bn6O7yB9th9vVD8tiONBhF6fBHGgiCtja9MfZUsultaCvu9rGWcbcy
         NPR1PrbDb0ONy3wMhNibtI0n/OUjlsC034tteTio+16TJlBuIMTuNNu6Hb7KTC/18QkS
         t1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758137841; x=1758742641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g500mWMdVffBJl/bJFPiPQYd74E9jSVxrHMEKT+H8A8=;
        b=wh8KXFEECnBB5sjnHcIFhy49hkxveUoaQkuS9ytb3EM/OCYw0v6J67SP1tsSOcHjT+
         55kU/F8Da3wUGHoKWXXL05ny5a+cuSfjy1DFn9GWH/JT6iYbZBf8lp2lV/yP3s+FBLDS
         r1n4cpJCl+uj8WvJSZl2ciLeY7ES43zWNmfXSI4rWTjAMfYlSXLUtaXeIPwRd1JS91d4
         noIySZK5zi0uF6UuxBMUhDduLxezBaONjVj6gIWhvSHnr8BeibrvY+oz57/m74mRNScz
         t/o7A2ZPNEJwbSul5dpvOVYU8nfHa+VuHSS9F76Inx1IM5b1NKhvRme+y2zLiU4W61Rb
         M1Nw==
X-Gm-Message-State: AOJu0YznvPdu1B+IvJIKOuTGD5UYt5x/xYAAabaMcMuNQEol4lq3X5w7
	9BGHNb6OEXae+q1ztpvNsbt+eR/3PBnp4N1nwCma9foFe/mEhXnD0oVTG1aJylbRGftde7e3OHr
	UIk5HHAdMftgT6HhUtbuFQST4nZEChps=
X-Gm-Gg: ASbGncvWewalw2hvA94Zvl6FA4sQaVQ7t+jzoFEUfJY1kqoWwosQVMmPRwpS71xtQG7
	7hkOCR2UJjmQFaEq7wCljHx9VXkgbU1qHe9/r01fsymVH39+5d5uIZ7itP9RG0ymEdDG+gqk8TP
	izIel7JTHP3otAXWBcrD4Pr8KXgsErf4qv6F0TJe8vt6khIBCl00ZN7fbpjCrLAXbVDKk6W5Bvv
	G8fBHhkUMbj+t6tQX+LEpg=
X-Google-Smtp-Source: AGHT+IG3vQaW005fde5b4zqUMR17PartwKIJqcAzKGwXOiUPVogF/n8idXHAuFYB7+1VXUc9LmJOJFHjv/G3JVn+EAw=
X-Received: by 2002:a05:690c:62c3:b0:730:72a:7991 with SMTP id
 00721157ae682-7388ffc0ef8mr27948337b3.4.1758137840814; Wed, 17 Sep 2025
 12:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915224801.2961360-1-ameryhung@gmail.com> <20250915224801.2961360-3-ameryhung@gmail.com>
 <20250916171711.1b0d0bc4@kernel.org>
In-Reply-To: <20250916171711.1b0d0bc4@kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 17 Sep 2025 12:37:07 -0700
X-Gm-Features: AS18NWDv6Ea5HmSGFJJW07mg_OFNMakkxNsk-0L_X3PaPDq3T_ITlK-yfGXNQ_A
Message-ID: <CAMB2axODF+XGfe-yrsCCzSO1er6KKBBXCaiEHYGsLBNFZnpOHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] bpf: Support pulling non-linear xdp data
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, paul.chaignon@gmail.com, 
	stfomichev@gmail.com, martin.lau@kernel.org, mohsin.bashr@gmail.com, 
	noren@nvidia.com, dtatulea@nvidia.com, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, maciej.fijalkowski@intel.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 5:17=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 15 Sep 2025 15:47:57 -0700 Amery Hung wrote:
> > +/**
> > + * bpf_xdp_pull_data() - Pull in non-linear xdp data.
> > + * @x: &xdp_md associated with the XDP buffer
> > + * @len: length of data to be made directly accessible in the linear p=
art
> > + *
> > + * Pull in non-linear data in case the XDP buffer associated with @x i=
s
>
> looks like there will be a v4, so nit, I'd drop the first non-linear:
>
>         Pull in data in case the XDP buffer associated with @x is
>
> we say linear too many times, makes the doc hard to read
>
> > + * non-linear and not all @len are in the linear data area.
> > + *
> > + * Direct packet access allows reading and writing linear XDP data thr=
ough
> > + * packet pointers (i.e., &xdp_md->data + offsets). The amount of data=
 which
> > + * ends up in the linear part of the xdp_buff depends on the NIC and i=
ts
> > + * configuration. When an eBPF program wants to directly access header=
s that
>
> s/eBPF/frag-capable XDP/ ?
>

Will change. Thanks for helping improve the comments.

> > + * may be in the non-linear area, call this kfunc to make sure the dat=
a is
> > + * available in the linear area. Alternatively, use dynptr or
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
> > +     int i, delta, shift, headroom, tailroom, n_frags_free =3D 0, len_=
free =3D 0;
> > +     struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff(x=
dp);
> > +     void *data_hard_end =3D xdp_data_hard_end(xdp);
> > +     int data_len =3D xdp->data_end - xdp->data;
> > +     void *start, *new_end =3D xdp->data + len;
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
> > +
> > +             new_end =3D data_hard_end;
> > +     }
> > +
> > +     for (i =3D 0; i < sinfo->nr_frags && delta; i++) {
> > +             skb_frag_t *frag =3D &sinfo->frags[i];
> > +             u32 shrink =3D min_t(u32, delta, skb_frag_size(frag));
> > +
> > +             memcpy(xdp->data_end + len_free, skb_frag_address(frag), =
shrink);
> > +
> > +             len_free +=3D shrink;
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
> > +     }
> > +
> > +     sinfo->xdp_frags_size -=3D len_free;
> > +     xdp->data_end =3D new_end;
>
> Not sure I see the benefit of maintaining the new_end, and len_free.
> We could directly adjust
>
>         xdp->data_end +=3D shrink;
>         sinfo->xdp_frags_size -=3D shrink;
>
> as we copy from the frags. But either way:
>

Great suggestion! I will drop new_end and len_free.

> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
>
> The whole things actually looks pretty clean, I was worried
> the shifting down of the data would add a lot of complexity :)

