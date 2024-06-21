Return-Path: <bpf+bounces-32733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B98912A47
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 17:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3EE28659F
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 15:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E29181AD1;
	Fri, 21 Jun 2024 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dMR8juBi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DB678C84
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718984062; cv=none; b=P/z6JPcmJ52sYDmocGMBfrRPuDFdAaD+uDqqVf4IzfweJsLBkTW0n17+Z+wMZeJSKQTo8G0cDKfZvBGPkiEjdMa+GDCupDB2BXIgc+AWnrN6P4GSCgsEYbVOToNVD7511xxWS+032DAKGLs52+p4o1QY405dNuAddHki4OGUaZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718984062; c=relaxed/simple;
	bh=7BVrpORkcBqP2dT5WJ8y/6uqH33UciLP1pUJUesNWxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1x1m4dLw3K18gzUEgZhcPvLK/HGflTnY20x01zvHRW/X9LtFo6+svokiL/vtP5EtV27BQlZC/HAc+NbhlRzhUOPggtj64D4ZBJSIzfEimZxE44iFqOzF7Lp51puOyjdo8N8dJpRuEOpVwxFM7X3xh6YxmDTSgUCz8SC7aZxq+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dMR8juBi; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57d26a4ee65so1913067a12.2
        for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 08:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718984059; x=1719588859; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DA7SWPRLXcST+Xc+dDz/AkjKFIf/1VqV1Qjkx7u2MTI=;
        b=dMR8juBiATC8rDlAot0OgQYlyKpeh49SeOG+cmeKaYxmMICVgq9IkfjcLousij5J0q
         2Ub4KuRrQB5SU80050jn36uR6SOaJ+N67g88PDcFKodTcEIIW7RR/tbSO9sbhdrfqDK+
         NS+XPRPeofoY2cSkuYdujogIcVN+IsuuAlqOPe3dTLXo7qp9mI0OgcO1uClvRc/7M5vq
         o6GBrLXDivZtuUQncavf2Zqc4seASGaj+uogv7OCnIPfVr/wt3szpqkcGbTg1sFBlZVO
         KfoZQGA0VvmNZzywtfbbN2+y9ihhM2MrMSpPy3pB/nqLVeehOzoHp6oAN2+uEFqE1Jwf
         OCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718984059; x=1719588859;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DA7SWPRLXcST+Xc+dDz/AkjKFIf/1VqV1Qjkx7u2MTI=;
        b=DAsem1+WyCEg04apWhqcsEVOfDUNI+ZvjE9hszTb/YX++RjbBMjSWkPtHTHOFvl1OM
         E+ws/nzj/XlIahLZl3cPEkLvHSC4FXnaKnUxRleexkYquHQ1kvgy6d6VAOe0m1cGeZb5
         PQN26UknfiQa76lNdyHBHrzNb3qe2ovnIJeMUk6W3SHpAji24M+D2q6hwI2QMUdGgXKS
         54yRPpqIMYtJrotrQoBUJFFGmCBIagSi1/JIRrjMMLcxjFea1pSsyoLdggTDsXZ+gDFE
         XwaY3R7PKBWYas1laalSRT8PfWVq+xXhovj4yy/q5KTuuFwshcaljCHJZF7xxZYyWBUL
         0ySQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiyp11Fwmhz/U/VHKL8/DbR/thEJT8epMl2GoI/jT22/Cn7Hwo3q8A7AIUAMp+XlefOhcG2Zutt12wXp/Klx2Xv1b4
X-Gm-Message-State: AOJu0Yz4SaodEDlZONtANPvkKR2XeHeXx1NwHp77pOjJ7XG3cAfXf+hw
	Rn0UYNWlSHVn8V2IsJeWgDbBNTOV+HOmc5W4oEnbLJPEUY8GDuLr2Xp9ZuxtlKqRdVD88nI4YhS
	vPOqY1BiKPYMVVwmPEC2gna8+fZFNh+S5+/3+Cw==
X-Google-Smtp-Source: AGHT+IFelAbcXvIcTJONWEgNkYFPnbf9VtHPK2SF57Y6Pp8Jls6KOYI5Jfb52Fhrp461oy2MjvD2G93eYtYsdGMJHNY=
X-Received: by 2002:a17:907:d043:b0:a6f:96ac:3436 with SMTP id
 a640c23a62f3a-a6fab602e81mr540464366b.11.1718984059371; Fri, 21 Jun 2024
 08:34:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718919473.git.yan@cloudflare.com> <b8c183a24285c2ab30c51622f4f9eff8f7a4752f.1718919473.git.yan@cloudflare.com>
 <66756ed3f2192_2e64f929491@willemb.c.googlers.com.notmuch>
In-Reply-To: <66756ed3f2192_2e64f929491@willemb.c.googlers.com.notmuch>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 21 Jun 2024 10:34:08 -0500
Message-ID: <CAO3-Pbp8frVM-i6NKkmyNOFrqqW=g58rK8m4vfdWbiSHHdQBsg@mail.gmail.com>
Subject: Re: [RFC net-next 1/9] skb: introduce gro_disabled bit
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Mina Almasry <almasrymina@google.com>, Abhishek Chauhan <quic_abchauha@quicinc.com>, 
	David Howells <dhowells@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	David Ahern <dsahern@kernel.org>, Richard Gobert <richardbgobert@gmail.com>, 
	Antoine Tenart <atenart@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > -static inline bool netif_elide_gro(const struct net_device *dev)
> > +static inline bool netif_elide_gro(const struct sk_buff *skb)
> >  {
> > -     if (!(dev->features & NETIF_F_GRO) || dev->xdp_prog)
> > +     if (!(skb->dev->features & NETIF_F_GRO) || skb->dev->xdp_prog)
> >               return true;
> > +
> > +#ifdef CONFIG_SKB_GRO_CONTROL
> > +     return skb->gro_disabled;
> > +#else
> >       return false;
> > +#endif
>
> Yet more branches in the hot path.
>
> Compile time configurability does not help, as that will be
> enabled by distros.
>
> For a fairly niche use case. Where functionality of GRO already
> works. So just a performance for a very rare case at the cost of a
> regression in the common case. A small regression perhaps, but death
> by a thousand cuts.
>

I share your concern on operating on this hotpath. Will a
static_branch + sysctl make it less aggressive? Speaking of
performance, I'd hope this can give us more control so we can achieve
the best of two worlds: for TCP and some UDP traffic, we can enable
GRO, while for some other classes that we know GRO does no good or
even harm, let's disable GRO to save more cycles. The key observation
is that developers may already know which traffic is blessed by GRO,
but lack a way to realize it.

best
Yan

