Return-Path: <bpf+bounces-42763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BC79A9D56
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 10:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8C01C21356
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 08:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DB418859B;
	Tue, 22 Oct 2024 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3sz6Tss"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231CE137747;
	Tue, 22 Oct 2024 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729586817; cv=none; b=sN6oDrKXNjRZhATEmkPXXRNLVFj91Zy5EKZhTRrl3OhZvvoR0fqLcNsNxWQj1BCYFI7IHuf5gG5Gy2O6yfbV9834DsxXPl2r6HtKPDVV81MeqLvVj+bXW40chl9WiB6E33VnA9yBkliP5wd5vHYWRk3/D8yFoCelKVLhSUoYYQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729586817; c=relaxed/simple;
	bh=KoxzzeJo6etocqx2b/o+OlOXOv6uNN7rqTozMtP8LX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEd5JBzbFyduy/ee3uvUW0eH+8AuEuZdONDvsCB2D2sR0LeBwD1UihB1CaUqmWRqHiMKTOE9SD2gF+JTyJKLDzN2FPgMm7iQchtEACxMwu9V3ZJZqLrgrkSZDrc++oAI3ANIgHLFoSxFPjuxx6auN4VPA5DumJkbSrD8wMm49Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3sz6Tss; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-6e38ebcc0abso58682267b3.2;
        Tue, 22 Oct 2024 01:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729586815; x=1730191615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUFrYT1eNOid4dqFuQyZap0oTpnRGPS1wGDonRnbV+Y=;
        b=f3sz6TsskkMLkxbWVZYYpXmCpStSEutAQ1CfwXpPc2n3z7qjpD34HGUFgdzfmM0+H5
         d1xhaOxB/WMFrKtc5v7oQ22aJPZsiTpT4ezSNu3d+DAxNbtgJbcCI7MTxctpeRyI9khN
         72Vv+hxkkET9qFsvY32OAuKI4Ue8FETXAJ5KOGv1ld3J6VvvOaXkUmtcUuODc9vZj1xs
         fT3tvaSZRNouSrtlGiLeUeaIM7NjjBoz6NAGEYaQH7Ce9YK2eFb07pkOywZBlq1X7JKx
         Hj/bi3ALVvL7hEKIl9lElUydJx8SWDA5NG1s/kUiGe77sikehveVxW4ARCE5RpefVLo/
         GV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729586815; x=1730191615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUFrYT1eNOid4dqFuQyZap0oTpnRGPS1wGDonRnbV+Y=;
        b=rz7a8XNlCaku0RFN21CA/FsqWvIT+ArTk4hwu2gA8nLsTdntoUYajTRpJHgNd1kcLe
         x7p0A3CjRuXCfKqB5/dSlskvUiOOuace/iwqdZZRTU7NQEpSQESJEd12Ro55aYaiuGz1
         l3UECzvuobzhR5E/beDiVGNFgdi6T8Pjw8LgZxI2CM9B4bC44Dd1FW7hmdg/BxO6nRmZ
         lqwOX8d0VqNeZkDTbPxEso/+25TyJnSC008J6QnM89GJ/oWyGTt61bi8dJgDcNc5s7Vn
         dke1KJNtWfJyi2mOWqKKyyJsdvhOcQP5E0RZmbl0+BWuddB3SI7TtDU972/1NVfNXGik
         tEdw==
X-Forwarded-Encrypted: i=1; AJvYcCUPmTrQic0DerTIBLiAQ9AJHECtbjt2qtjDBFBopsoCscQKEFleOmGfXlQZBdK18ihPJdaLWYRe@vger.kernel.org, AJvYcCUQ9qLNq0dVtdlv/GuNam3iOuAaKARQN68umxnGwpd6ByWaqCgnaYRa3EE+D0up5Hg6KxX3xIAjhz7xxyIY@vger.kernel.org, AJvYcCW2b04eZ+Zv7LtlERuvFwbNiTSsGW6Z4EoHivUZBz8AuetNAILCo++smyF9off5EF4VgJ4=@vger.kernel.org, AJvYcCXfLWgf8fT4tK9s22jcJKOWbCFlfl2ogjhF8faQ986Kp7n+6qTJtrlXSHpaS7sgq4uu3yKotaOKJqiDahxoFQfN@vger.kernel.org
X-Gm-Message-State: AOJu0YwMOOl7gU5iMpMziA0kcgCedhYvw+wJTc0otyRv1fhHMu+VVwyQ
	RAV0xJn1a+W9o3bXFmXXodpTtxIAxwnZ3SlLVjMHQjLUIsLd1UyOTXSouik43dWbrrjyIXS6uXS
	4lpcvqg1MHHML1y5jlKs47nnEcuE=
X-Google-Smtp-Source: AGHT+IGa70DbIzj17jnQMKvxrqZzKAIwpBsupiT5kH056AnnXaak0bg1EodNANRT8iYvRLR4hMiz9fU4XeAZxEwSSaU=
X-Received: by 2002:a05:690c:f8f:b0:6d3:f9a6:e29c with SMTP id
 00721157ae682-6e5bf9a0846mr134520257b3.12.1729586814908; Tue, 22 Oct 2024
 01:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015140800.159466-1-dongml2@chinatelecom.cn>
 <20241015140800.159466-3-dongml2@chinatelecom.cn> <71a20e24-10e8-42a8-8509-7e704aff9c5c@redhat.com>
In-Reply-To: <71a20e24-10e8-42a8-8509-7e704aff9c5c@redhat.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 22 Oct 2024 16:47:50 +0800
Message-ID: <CADxym3b6gat7Xs20oN12xsYNSGM3zaJkGirzGv57jA-+Kyr7+A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/10] net: ip: make fib_validate_source()
 return drop reason
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	dsahern@kernel.org, pablo@netfilter.org, kadlec@netfilter.org, 
	roopa@nvidia.com, razor@blackwall.org, gnault@redhat.com, 
	bigeasy@linutronix.de, idosch@nvidia.com, ast@kernel.org, 
	dongml2@chinatelecom.cn, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	bridge@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 6:20=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/15/24 16:07, Menglong Dong wrote:
> > diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
> > index 90ff815f212b..b3f7a1562140 100644
> > --- a/include/net/ip_fib.h
> > +++ b/include/net/ip_fib.h
> > @@ -452,13 +452,16 @@ int __fib_validate_source(struct sk_buff *skb, __=
be32 src, __be32 dst,
> >                         dscp_t dscp, int oif, struct net_device *dev,
> >                         struct in_device *idev, u32 *itag);
> >
> > -static inline int
> > +static inline enum skb_drop_reason
> >  fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
> >                   dscp_t dscp, int oif, struct net_device *dev,
> >                   struct in_device *idev, u32 *itag)
> >  {
> > -     return __fib_validate_source(skb, src, dst, dscp, oif, dev, idev,
> > -                                  itag);
> > +     int err =3D __fib_validate_source(skb, src, dst, dscp, oif, dev, =
idev,
> > +                                     itag);
> > +     if (err < 0)
> > +             return -err;
> > +     return SKB_NOT_DROPPED_YET;
> >  }
>
> It looks like the code churn in patch 1 is not needed??? You could just
> define here a fib_validate_source_reason() helper doing the above, and
> replace fib_validate_source with the the new helper as needed. Would
> that work?
>

Of course, that works fine. I'm just trying to find a graceful way
for this part. Defining a fib_validate_source_reason() here looks
nice too, and we can ignore the 1st patch. I'll do it this way in
the next version.

Thanks!
Menglong Dong

> > @@ -1785,9 +1785,10 @@ static int __mkroute_input(struct sk_buff *skb, =
const struct fib_result *res,
> >               return -EINVAL;
> >       }
> >
> > -     err =3D fib_validate_source(skb, saddr, daddr, dscp, FIB_RES_OIF(=
*res),
> > -                               in_dev->dev, in_dev, &itag);
> > +     err =3D __fib_validate_source(skb, saddr, daddr, dscp, FIB_RES_OI=
F(*res),
> > +                                 in_dev->dev, in_dev, &itag);
> >       if (err < 0) {
> > +             err =3D -EINVAL;
> >               ip_handle_martian_source(in_dev->dev, in_dev, skb, daddr,
> >                                        saddr);
>
> I'm sorry for not noticing this issue before, but must preserve (at
> least) the -EXDEV error code from the unpatched version or RP Filter MIB
> accounting in ip_rcv_finish_core() will be fooled.
>
> Thanks,
>
> Paolo
>

