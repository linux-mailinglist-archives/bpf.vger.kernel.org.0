Return-Path: <bpf+bounces-32741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8727D912B07
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 18:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF7A28337C
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 16:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A6115FA6A;
	Fri, 21 Jun 2024 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WNz3epab"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD85208AF
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718986377; cv=none; b=m6d1mQ1BHpxk4SCwM4h6DssyyNW3fw74+LNfth/y5RsNYPuyMMVu/pHi7qI3qapHDDcLBUHP1lnP8/A5uL6wtEknlStbX9vJI2ldYijTWq3i5ohQsOUFklVzPBKT/hYa2aG+ifywoqDRXDco8JrBKRxtqSmJ94cD0K/9fOymoio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718986377; c=relaxed/simple;
	bh=jWlOoYuVaoLS+56u4GNV8VdQktFIi2pVchKpOlGoiw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDUna0FX8SoqZKRPOgNkt8gwJTj5B6UhSV6SoSRQHN6ybba4h2ZKfkf5UWejKVCxlQcFC+mnIsEN3Y5VHEqG2tcLDEkpf9jsYGasxGW9uFmtIEHkDrc3SosRSHarR02fK8MlUWp/F9tUp4oBUFq14UdOSrdQmdhhN9ULXOeGBzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WNz3epab; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57d07f07a27so2457810a12.3
        for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 09:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718986374; x=1719591174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0zYMWy18YNNETi7e8eQDmKjdjVWK9tOu69sXy0qbaU=;
        b=WNz3epabe8jtWysPqdeHzNbiO785PVmdJbPIJR9cY+lIKloSzUnXzGfO8F9Tcuio3j
         x5XZ3Ms3qGMWbDZz9Bag2bV0Xlr5puMzdXxob8/o7dsFWfQ50BrG3wZ9rhcvGrcU8LnN
         uyIjJuV2l6fC1mLSNAfi4a4SXwBbiXZWw4gZE11vzzyBaKqUZ9ySxDl4toaLMlg6kydk
         wlWpmfjVWD08Q5IIIXNa8nkRaQdBTj2z/F9+69zI8ieWW7cd+XJhtHzhUPg4HEmSKMN+
         deK0JNe7tHJ/9/1D89C6OlKywmx5dxhqr/8y67kn0WAhmcbW2LT6GT5P2Y/bzq2u9GxX
         B5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718986374; x=1719591174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0zYMWy18YNNETi7e8eQDmKjdjVWK9tOu69sXy0qbaU=;
        b=ClKD9YVovLHJl0FA3sujSVVvZcwJ5f9z1K/BmkrHgNhQ1k/44jXOjLijdpKImY0c80
         QDNxWwIQvq+IMYeUBlhRvYmR3H8WvJTWv5dMsNIOYQf/4fPQDhWR5rWRcQv9By3NA4+4
         B94Ptjbv2D+M8aRwiVNcA3HVDBKf54yS5EzlwbHDmdh5DPc4qgKEmtX/slbKuc07VpJ9
         kfazU3XJO4QoEES8NYlHzYmKnTcO2/Y44ENmpFwHdmwlNuYTXM2nrj5M6VbpEPYgmu1R
         006XoYd9FdSW6zNhqTEDu9cYL7H5o2n5AfYoLUUHf47aoj/fgPT3nF8fTAbytmbU8Q9j
         mjtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBRby3/ycudkHBn2Nw9i7aOTeSOjot7JzYXIGkVigkG40xxeH4G84u6qbE+MhKvpnejdPIEfaFq3WKU+gFgybDY/BI
X-Gm-Message-State: AOJu0YzaBYFg3kUqKRIZ62L7DOLUmfOWwsOEqyXxUNy4c8aMBIVGRlQ1
	4gSXwmGPXVOAm04GZO6GaKEz3lTjObu7kTktuXOEVOCDns9IOb9RtKnxxuia7FgoyzxHY1T6ErS
	bNF78aixEDCvonqaoiea8c0C4IboaHufsIM8drQ==
X-Google-Smtp-Source: AGHT+IF7ObXHDh6mLXvGuKl49qYAnntiqa3n0WDZ6sIU1vmldDPL6jOhnwAlmJHdvCTF05jpm/342x1EYcFV1AmFL8w=
X-Received: by 2002:a50:d74a:0:b0:57d:669:cafb with SMTP id
 4fb4d7f45d1cf-57d07ebf2abmr5129115a12.40.1718986373992; Fri, 21 Jun 2024
 09:12:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718919473.git.yan@cloudflare.com> <39f5cbdfaa67e3319bce64ee8e4e5585b9e0c11e.1718919473.git.yan@cloudflare.com>
 <7ce408ff-77e1-4d7b-8b4a-5ce5e16397dc@intel.com>
In-Reply-To: <7ce408ff-77e1-4d7b-8b4a-5ce5e16397dc@intel.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 21 Jun 2024 11:12:42 -0500
Message-ID: <CAO3-PbqxuvZwz0edh-OYiGv57LbKJtUh64QCvDoz9c8XqkeHdw@mail.gmail.com>
Subject: Re: [RFC net-next 2/9] xdp: add XDP_FLAGS_GRO_DISABLED flag
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 4:17=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Yan Zhai <yan@cloudflare.com>
> Date: Thu, 20 Jun 2024 15:19:13 -0700
>
> > Allow XDP program to set XDP_FLAGS_GRO_DISABLED flag in xdp_buff and
> > xdp_frame, and disable GRO when building an sk_buff if this flag is set=
.
> >
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > ---
> >  include/net/xdp.h | 38 +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 37 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > index e6770dd40c91..cc3bce8817b0 100644
> > --- a/include/net/xdp.h
> > +++ b/include/net/xdp.h
> > @@ -75,6 +75,7 @@ enum xdp_buff_flags {
> >       XDP_FLAGS_FRAGS_PF_MEMALLOC     =3D BIT(1), /* xdp paged memory i=
s under
> >                                                  * pressure
> >                                                  */
> > +     XDP_FLAGS_GRO_DISABLED          =3D BIT(2), /* GRO disabled */
>
> There should be tabs, not spaces.
>
> >  };
> >
> >  struct xdp_buff {
> > @@ -113,12 +114,35 @@ static __always_inline void xdp_buff_set_frag_pfm=
emalloc(struct xdp_buff *xdp)
> >       xdp->flags |=3D XDP_FLAGS_FRAGS_PF_MEMALLOC;
> >  }
> >
> > +static __always_inline void xdp_buff_disable_gro(struct xdp_buff *xdp)
> > +{
> > +     xdp->flags |=3D XDP_FLAGS_GRO_DISABLED;
> > +}
> > +
> > +static __always_inline bool xdp_buff_gro_disabled(struct xdp_buff *xdp=
)
> > +{
> > +     return !!(xdp->flags & XDP_FLAGS_GRO_DISABLED);
> > +}
> > +
> > +static __always_inline void
> > +xdp_buff_fixup_skb_offloading(struct xdp_buff *xdp, struct sk_buff *sk=
b)
> > +{
> > +     if (xdp_buff_gro_disabled(xdp))
> > +             skb_disable_gro(skb);
> > +}
>
> I don't think this should be named "fixup". "propagate", "update",
> "promote", ...?
>
> Maybe `if` is not needed here?
>
>         skb->gro_disabled =3D xdp_buff_gro_disabled(xdp)
>
> ?
>
I called it fixup mainly considering current skb fields could be set
incorrectly (or maybe not?) For example when XDP load balances
traffic, it could encap and send from server A to server B, but that
means HW on B may have no good way to calculate the actual flow
hash/csum. The original values could be read from A and sent within
the encapsulation header, so that B can use this value to "fixup" the
things.

But tbh, I am never good at naming, it's too hard for a non-native
speaker sometimes... So I am very open on what to use if majority of
the participants like it :D

The if is still needed since I added a control config to wrap that bit.

best
Yan

> > +
> > +static __always_inline void
> > +xdp_init_buff_minimal(struct xdp_buff *xdp)
> > +{
> > +     xdp->flags =3D 0;
> > +}
>
> "xdp_buff_clear_flags"?
>
> > +
> >  static __always_inline void
> >  xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info =
*rxq)
> >  {
> >       xdp->frame_sz =3D frame_sz;
> >       xdp->rxq =3D rxq;
> > -     xdp->flags =3D 0;
> > +     xdp_init_buff_minimal(xdp);
> >  }
> >
> >  static __always_inline void
> > @@ -187,6 +211,18 @@ static __always_inline bool xdp_frame_is_frag_pfme=
malloc(struct xdp_frame *frame
> >       return !!(frame->flags & XDP_FLAGS_FRAGS_PF_MEMALLOC);
> >  }
> >
> > +static __always_inline bool xdp_frame_gro_disabled(struct xdp_frame *f=
rame)
> > +{
> > +     return !!(frame->flags & XDP_FLAGS_GRO_DISABLED);
> > +}
> > +
> > +static __always_inline void
> > +xdp_frame_fixup_skb_offloading(struct xdp_frame *frame, struct sk_buff=
 *skb)
> > +{
> > +     if (xdp_frame_gro_disabled(frame))
> > +             skb_disable_gro(skb);
> > +}
>
> (same)
>
> > +
> >  #define XDP_BULK_QUEUE_SIZE  16
> >  struct xdp_frame_bulk {
> >       int count;
>
> Thanks,
> Olek

