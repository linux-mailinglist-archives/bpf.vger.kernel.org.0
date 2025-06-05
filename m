Return-Path: <bpf+bounces-59753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D91F4ACF143
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 15:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02AE07A4F6D
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 13:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494BB272E67;
	Thu,  5 Jun 2025 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lAUCz3OF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD02225405
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749131446; cv=none; b=q3ebENnYcU0jyE5/TrauBIZcc+LA8nftW1KNHQARuQwn2/lw8Dyx20MtiH2pUAD/i2gwwBxcrFL2JDPR0hTHN7iUXCfqeV1rgWhIdUoeu+3u18a9ZSZIOD/S79pO9Yipz10blYvi71Gg9ELXoOf8h4jksdZQbnMwEGpawONg4RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749131446; c=relaxed/simple;
	bh=iycvAym55zDq0ONZ+OdsiZLhqKfAFZep34CpDeTosPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FqhnRqkTWDlw839ewM6E59F6vrmyMJaZ7RR/8/Z5IuZ2oCMMCwapVQJ0JBn+T5Ao9Se3n9r3nOx/9loQE8stjxGdkc4kuYeUlH7TDCB1l7/QpwNBesf7nDMBJZd32qCUauVEhbzjQetA0+kPkzX67xryQCsgcbyYPlr7qrUuIWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lAUCz3OF; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6024087086dso27021a12.0
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 06:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749131443; x=1749736243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UP6QQrSrVHGFWmqLtZ3wGH+SPjvIgHjssFRQIo3s1Ps=;
        b=lAUCz3OFaF4tExnQAmOS0oLAEKG9AvGw0d6b8pFsokoZa6Xk6uFabudBmnJ5etQFHK
         PrFjaQhUbmzh+k1mgPf8b4RdOhJCK9HtM03jWo25PQdPR7MiIniMDAI4Y5TxZo/JiZHE
         s8ZaxGIqWVhdkRUumLqEuVQOi+84NdRIDWw2C7hTAR4O4A5de6JZi/sfbkDzZc9ZmgpG
         3oLaHfo8nU2HiYLrzdTzFkhhx3xNW41yS/7+MwDZomdLAPgH1iKnkSL7JtlW0MvCj8+j
         g1J71ncRerqY7I03CHJP+pTOycPTAzqVvbBlZuyZC26kpXZeJ9D6P+Gz6aPvNzQad4xP
         12tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749131443; x=1749736243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UP6QQrSrVHGFWmqLtZ3wGH+SPjvIgHjssFRQIo3s1Ps=;
        b=DZtTBE73uMn7buIUetYILOVPXo6Dm8jBRa5dd2JZNJ/1C06OPpl2OmagCuWcW6iZUO
         mI0tNV8yiUfG45XKsyvYVI+0IF2sTu+zIn5ECFX9j/3J9C+ypUZ3/OpM/BwaPkF76yy7
         s4wmUezn1DlxLdBraKblni0q/DSHnIjX4pomcnJ3J2VCq6pLE7kHmMz7PEP/OIMSDs12
         18L0cuyS/lzldDVPLLu4ikJBS8iGKzmdFq1U8/7eyEgpTmZTlv1FDPM2ND0GUEJgXOMu
         FgTlfT6iHJCOXYQmleZCYwZ0ZrmsoHuTCaTaM7v87dbcGz+CaRKLj9SAyBL8VBufiBrh
         qKRA==
X-Forwarded-Encrypted: i=1; AJvYcCU2Zso96fZo21RpvTMK/saYnbGb+TzQIwpF7x3yKAI9vgGMGfGBt5e5UQ9aaZnvckUN8Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFyK9z5A2qfXzki8QU3Zz47dTvPzHf1UwCPKUZZ1v88+Tfnu+0
	tCXbaWn++FLn+U5nWCKljDlmc/aClNNoZYaWA1DEhGFgSldULd3t/0qXYLfvxA5y6eJ6VX5W7GV
	+2RVV378H5Er6hr9BGTWIGW5wE8rWH4c2QYz83Ewc
X-Gm-Gg: ASbGncuZjfzbJtive/PcYcCcbqTf+8EvMtvZLC/TTGuHkeE31x+POP77m5Q2BVwtCPU
	BsXDMM7CFYGYks0p/Khi39rI9RYdI2XpCk0dxIU4lbj4xMlIaO7e6rzywTtCjcq9n4WfrL9eUDn
	TDJpFhrPdNMZtanE5pnzI1WugMJjz837gmRoZqVR88/iX1vCodIpa8PCgbLOr1hP9o1FUILH0Mn
	lTu
X-Google-Smtp-Source: AGHT+IFJwDCr1QdAf2/cV6M/7+hs0GtdNbyD5dcEvnEOPjKG2iZlqraF0lpMTdH8kDNgLHjbFeDjGHz7Nq3rysBIWnU=
X-Received: by 2002:aa7:d9d3:0:b0:604:58e9:516c with SMTP id
 4fb4d7f45d1cf-60728a7df98mr76246a12.5.1749131443129; Thu, 05 Jun 2025
 06:50:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604210604.257036-1-kuba@kernel.org> <CANP3RGfRaYwve_xgxH6Tp2zenzKn2-DjZ9tg023WVzfdJF3p_w@mail.gmail.com>
 <20250605062234.1df7e74a@kernel.org>
In-Reply-To: <20250605062234.1df7e74a@kernel.org>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Thu, 5 Jun 2025 15:50:31 +0200
X-Gm-Features: AX0GCFt38U4Amf5oK7uaxU1djgDwN78xrGBlAlvwxVepqyAoubdE3lY2Xp7U1rU
Message-ID: <CANP3RGc=U4g7aGfX9Hmi24FGQ0daBXLVv_S=Srk288x57amVDg@mail.gmail.com>
Subject: Re: [PATCH net] net: clear the dst when changing skb protocol
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	martin.lau@linux.dev, daniel@iogearbox.net, john.fastabend@gmail.com, 
	eddyz87@gmail.com, sdf@fomichev.me, haoluo@google.com, willemb@google.com, 
	william.xuanziyang@huawei.com, alan.maguire@oracle.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 3:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 4 Jun 2025 23:21:02 +0200 Maciej =C5=BBenczykowski wrote:
> > > @@ -3550,10 +3557,10 @@ static int bpf_skb_net_grow(struct sk_buff *s=
kb, u32 off, u32 len_diff,
> > >                 /* Match skb->protocol to new outer l3 protocol */
> > >                 if (skb->protocol =3D=3D htons(ETH_P_IP) &&
> > >                     flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV6)
> > > -                       skb->protocol =3D htons(ETH_P_IPV6);
> > > +                       bpf_skb_change_protocol(skb, ETH_P_IPV6);
> > >                 else if (skb->protocol =3D=3D htons(ETH_P_IPV6) &&
> > >                          flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV4)
> > > -                       skb->protocol =3D htons(ETH_P_IP);
> > > +                       bpf_skb_change_protocol(skb, ETH_P_IP);
> >
> > I wonder if this shouldn't drop dst even when doing ipv4->ipv4 or
> > ipv6->ipv6 -- it's encapping, presumably old dst is irrelevant...
>
> I keep going back and forth on this. You definitely have a point,
> but I feel like there are levels to how BPF prog can make the dst
> irrelevant:
>  - change proto
>  - encap
>  - adjust room but not set any encap flag
>  - overwrite the addrs without calling any helpers
> First case we have to cover for safety, last we can't possibly cover.
> So the question is whether we should draw the line somewhere in
> the middle, or leave this patch as is and if the actual use case arrives
> - let BPF call skb_dst_drop() as a kfunc. Right now I'm leaning towards
> the latter.
>
> Does that make sense? Does anyone else have an opinion?

It does make a fair bit of sense.
Question: does calling it as a kfunc require kernel BTF?
Specifically some ram limited devices want to disable CONFIG_DEBUG_INFO_BTF=
...
I know normal bpf helpers don't need that...
I guess you could always convert ipv4 -> ipv6 -> ipv4 ;-)
--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

