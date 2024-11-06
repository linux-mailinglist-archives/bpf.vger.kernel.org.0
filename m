Return-Path: <bpf+bounces-44125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1FE9BE66E
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 12:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D271C2322F
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 11:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7AF1DFE23;
	Wed,  6 Nov 2024 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wa0zQf9r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A304A1DF97E;
	Wed,  6 Nov 2024 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894293; cv=none; b=KWRsIILTv6x8A8mBsZOSJMWgAzZL/3DXF56nBa69aTdPW+EByvAahiJd9APN4vGzubPDVsrZ1/+dfr/ccMFEVHlFcKZYntg7YS2vCCrkJRWcVyIHv8m4s2pv0+hJDOfNGanOY+ibmg7s7s51Lluf3EUPKL66mFhaQvlzKlPd2Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894293; c=relaxed/simple;
	bh=lPtdyFjSX7/UnqsyuM5h54naOd6rYeJQC1kkvUSDPdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+MktolMKXMqHgoJ+yU6S8/UMWHahDlaOqsbdZ8LCCoYr7wGpIbqmo28XVDLH6xkOXSXtBJ4PFwlqsEcHUwROKETRc3mQLdchG7SWdEqeb07UuMJs1+G5c1lbwlTsgBTsoEOWQSoi8ncKfU8T9Zb8N0Q7lKdPUDKPsQPwWIblwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wa0zQf9r; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-6ea50585bf2so70141787b3.3;
        Wed, 06 Nov 2024 03:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730894290; x=1731499090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAqjHxmUrO89VjVjpuY++87pz4fEOVeyoRet1eIwJ2o=;
        b=Wa0zQf9rrLCvAwQ5d14mvBeuc8Vy5SADkiZxHg27F5vaNiOdl1netCiGu4FeTeoKGi
         yyvzHo05tjX+hoMOTbjxz1RU+BJSYvCI+7hSJm/xT8UMwIxVWFFND4lTOlQ9e2K9/z5b
         fykV4heCNgU1i0SjotFgIIXWbiaQPqfX4SIlVMWrNWHIRqmrQupH4ik7LmT6XZE87yiU
         QFJ32x5IXSnJyBJqaA6RKy+hMlSCkfLU7lAoEmtip3FEPLK0H1mnTjauPsv6aLWBe4ex
         HDvOy1G/BuuIVrd3o0qOSvXin7A1pja2oKlqq1SvRsgHDbmLkVvn3YY4yxCIToovufjW
         umCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730894290; x=1731499090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAqjHxmUrO89VjVjpuY++87pz4fEOVeyoRet1eIwJ2o=;
        b=TgpVJjwmWQivACxuxnaMljFg56Q7qqsUlTCu+70OgNHDkLe0zfNDzVFmgNyzbtH3Ah
         w6qHndltCL5UEPZDJCjroeHbJAk5tT16qQZ7mCedxrIwLD8BLW8VOwAeNHEjAu9pTPF4
         XugITG1J/f1paRxoPLzp2EBLW1QejWkdB+inT5dJItQRK7TtVgZuMAmBnHNJL1tf2eDr
         0KuD5jAnl0GLb+pyVdNCtfHgu3Yv8gkRXMJerqfoZq7mVFIIgNLs5RwJFjeSzgxG7Fvj
         7uDKcu5GqI6wJDEQ/9dV65YHEItEZLQ/K043zOhpH6AHw9vXv8+dkvCPFv8/bcbf2n9k
         JXuA==
X-Forwarded-Encrypted: i=1; AJvYcCUo+WaWLfygJtZ3ylYAZ1fardzd0V5nDHAXdnJhDpOKebw95FS6ZjeIV5Gm1nnYUGu5TKouQ3uz8+M/l2gax9RZ@vger.kernel.org, AJvYcCV48u8f5Pn2BBpCFrNL2sQNVJW6NVj4fEOSRgqG/5DOZOrqMxBcBDOTnC41efnTAK0G6lA=@vger.kernel.org, AJvYcCVawiQ70dphkzfwwh6TOm+2tNSOHdZ2z23SgI0a5DoW+N/8eJW2xYTPnmNFvMpqbJXCtPwJkfxQQsq2XkRb@vger.kernel.org, AJvYcCVr/eWrNFUAaTdtnJQw4xMC0Kg0xB1twyKhU1aLKrKZoAd4W1w2+Z8Hin8GOfQBf7pK2KlGX2qL@vger.kernel.org
X-Gm-Message-State: AOJu0YwOIqjJCYeAgxrQHeoQzsOEX7ihL8JPZe8cGEyp+kPYe1/Sjn0O
	GKSabsMonFUHpivlkOETKzVyFaJkxZiWWFMXgtlLD1gOCDgk0CTgFZ5F8iYJAIewRYzpMj/de8w
	Y1GrgQFvWp2kmQA6rjunxE2Yl3Zs=
X-Google-Smtp-Source: AGHT+IEicBeNuuKcBuxj8PHbVAzeh5q36ut7RhJLw1zsm8LW4+5N2cnbcMPl7qD+TVVga0oNtp2Xo5uEhULkgazh6rI=
X-Received: by 2002:a05:690c:6c88:b0:6e3:3dbc:ca60 with SMTP id
 00721157ae682-6ea64a9f24bmr191545627b3.8.1730894290438; Wed, 06 Nov 2024
 03:58:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030014145.1409628-1-dongml2@chinatelecom.cn>
 <20241030014145.1409628-10-dongml2@chinatelecom.cn> <8f83725e-1ea9-438f-8ab1-ff528ca761fb@redhat.com>
In-Reply-To: <8f83725e-1ea9-438f-8ab1-ff528ca761fb@redhat.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 6 Nov 2024 19:59:18 +0800
Message-ID: <CADxym3YK5QYHs8oFwY8FQdcpuQSSY5N=Pj8N40U+vaUdi4er-w@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next v4 9/9] net: ip: make ip_route_use_hint()
 return drop reasons
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	horms@kernel.org, dsahern@kernel.org, pablo@netfilter.org, 
	kadlec@netfilter.org, roopa@nvidia.com, razor@blackwall.org, 
	gnault@redhat.com, bigeasy@linutronix.de, hawk@kernel.org, idosch@nvidia.com, 
	dongml2@chinatelecom.cn, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	bridge@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 7:28=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 10/30/24 02:41, Menglong Dong wrote:
> > diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> > index e248e5577d0e..7f969c865c81 100644
> > --- a/net/ipv4/route.c
> > +++ b/net/ipv4/route.c
> > @@ -2142,28 +2142,34 @@ ip_mkroute_input(struct sk_buff *skb, struct fi=
b_result *res,
> >   * assuming daddr is valid and the destination is not a local broadcas=
t one.
> >   * Uses the provided hint instead of performing a route lookup.
> >   */
> > -int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
> > -                   dscp_t dscp, struct net_device *dev,
> > -                   const struct sk_buff *hint)
> > +enum skb_drop_reason
> > +ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
> > +               dscp_t dscp, struct net_device *dev,
> > +               const struct sk_buff *hint)
> >  {
> > +     enum skb_drop_reason reason =3D SKB_DROP_REASON_NOT_SPECIFIED;
> >       struct in_device *in_dev =3D __in_dev_get_rcu(dev);
> >       struct rtable *rt =3D skb_rtable(hint);
> >       struct net *net =3D dev_net(dev);
> > -     enum skb_drop_reason reason;
> > -     int err =3D -EINVAL;
> >       u32 tag =3D 0;
> >
> >       if (!in_dev)
> > -             return -EINVAL;
> > +             return reason;
> >
> > -     if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr))
> > +     if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr)) {
> > +             reason =3D SKB_DROP_REASON_IP_INVALID_SOURCE;
> >               goto martian_source;
> > +     }
> >
> > -     if (ipv4_is_zeronet(saddr))
> > +     if (ipv4_is_zeronet(saddr)) {
> > +             reason =3D SKB_DROP_REASON_IP_INVALID_SOURCE;
> >               goto martian_source;
> > +     }
> >
> > -     if (ipv4_is_loopback(saddr) && !IN_DEV_NET_ROUTE_LOCALNET(in_dev,=
 net))
> > +     if (ipv4_is_loopback(saddr) && !IN_DEV_NET_ROUTE_LOCALNET(in_dev,=
 net)) {
> > +             reason =3D IP_LOCALNET;
> >               goto martian_source;
> > +     }
> >
> >       if (rt->rt_type !=3D RTN_LOCAL)
> >               goto skip_validate_source;
>
> Please explicitly replace also the
>
>         return 0;
>
> with
>
>         return SKB_NOT_DROPPED_YET;
>
> So that is clear the drop reason is always specified.

Okay!

Thanks!
Menglong Dong


> Thanks,
>
> Paolo
>

