Return-Path: <bpf+bounces-32839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EB7913906
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 10:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3A92820C7
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 08:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728816E5ED;
	Sun, 23 Jun 2024 08:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8Gd6oN1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A89915E83;
	Sun, 23 Jun 2024 08:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719131232; cv=none; b=o4WlH/JlsoSGxqmdsoOW3ZyufT/4lti5rbkBAYXFuRoYXy1NDVanLE/VOOJuyY6u6SR19oSetTmT4CQtnmUcByUhK5hgG81ytf4WtvIek7lkq2jW8hyDbWppSaUDAxd5i0lMlO4FPATDYMfXxtDI6h6HaftWX2Fc5JKmWddR2bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719131232; c=relaxed/simple;
	bh=wXzpF52hVLUV+mMEdLc6cpCfXOaETnrKNX3HhFMc35U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=BYxO5DG8N0ScBNtWrK2GCK8Vb7MsQnXFE226L7Vn/k8jVfyDj+pcImip7SW2yrm0U5RulLuvq2so3Fci3I+I+Rb3DP6xvX2yNviy43wozKdK13i1raSflRPFhlsRdO5Ve5KUHfeQueFDg3dsahPAgvQZJ1ita9z1lKzT+++E+lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8Gd6oN1; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f8d0a1e500so2723650a34.3;
        Sun, 23 Jun 2024 01:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719131229; x=1719736029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVlxddzmWsceHIvjH6A3lb+w9ZlDbtGGCb1DyEkJCpk=;
        b=M8Gd6oN1UK5tBzoGfqALdnwvLNG460s5JhpQiylasvIduIlOSj3RVjoy/9i+WgsiHH
         Ool0DGTco7FitXROffjKXGpFnNX3lJYmxUeheKaRc8dlMF3QaaPwvVn7IAdIlueF8BUz
         iZit8Qydp/lEi236tZla2k4qKIlQrhrjwDYzdQLrGNKrfe0LMuUqu1XfySmi+G4nw6kR
         yB8zQMdOxaABLpPqCs3jzWogF051BeJcAuD23hggMFd9zemtV50lbnKvWavw6BgC2gbK
         s+8lgpwG+CoLojCc227UNJCTJEX5q07CmtbG0xPuTJpi/noF705kd3TfWDD33sYFO8tf
         iIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719131229; x=1719736029;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rVlxddzmWsceHIvjH6A3lb+w9ZlDbtGGCb1DyEkJCpk=;
        b=D0Lniob84RFky81SK5fFpIiACcJH6XT7kZAQsWr4W069B5lrYEQiM5q0RNSXVib60u
         ga9ZzvrKJ7PiyaoQHC9gszJnZapT6bzeoxQYYFND+UfpA/a+/KBe3oEpbblYFhzK2hEH
         P34zODuP7lF+6yyk989wZ9olU8l0fLnQ6JZoFnK1GqKCpBWaG24OGKBvldmnkV58hOgR
         29leiH0j9KocSKeEaXNDQOx63yMMxwDK74BwaPJGjHNzWVOsaaB6lDHnRQtVeOv5K660
         3IUhSsdMgX8IvffHqRoE5yzsG4zc0RA686Xi2iWTIGubBRo6YCfqsutwRFmVQ6Fsofo/
         TYsw==
X-Forwarded-Encrypted: i=1; AJvYcCX7cIWzsI80zZzqidNG/jc7VF3xqtjRXi7xMTNU7nxsgmtfhP7pVw93KqpyxZZaQnmi9dzluejZ9W85As846hGzVATmTfoR6KeWyjtfUVhOQQw/C8N9Hc9uTXIaAKB/BJH9
X-Gm-Message-State: AOJu0Yy+olIYqMPuUMYNN3CEdmmwpO0cJW4pMvIbuvq2UAXPrKKRtx2q
	4WdjPVsdY7R9BYq5i2cxdHkYDWhUyzLjIuX8tY/GwxpAM4ASSm+q
X-Google-Smtp-Source: AGHT+IHpnh6RRlhqyBweCkLdGRplsGRhYi3dnF+hgw7fZIcOsYXsE3quUOoHyU/QgLsrOKiHA2S/mg==
X-Received: by 2002:a9d:6c13:0:b0:6f9:62ae:10fa with SMTP id 46e09a7af769-700b11a842emr2023616a34.5.1719131229480;
        Sun, 23 Jun 2024 01:27:09 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ecfe7a9sm23596306d6.27.2024.06.23.01.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 01:27:08 -0700 (PDT)
Date: Sun, 23 Jun 2024 04:27:08 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yan Zhai <yan@cloudflare.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Simon Horman <horms@kernel.org>, 
 Florian Westphal <fw@strlen.de>, 
 Mina Almasry <almasrymina@google.com>, 
 Abhishek Chauhan <quic_abchauha@quicinc.com>, 
 David Howells <dhowells@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 David Ahern <dsahern@kernel.org>, 
 Richard Gobert <richardbgobert@gmail.com>, 
 Antoine Tenart <atenart@kernel.org>, 
 Felix Fietkau <nbd@nbd.name>, 
 Soheil Hassas Yeganeh <soheil@google.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 =?UTF-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
Message-ID: <6677dc5cb5cca_33522729474@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAO3-Pbp8frVM-i6NKkmyNOFrqqW=g58rK8m4vfdWbiSHHdQBsg@mail.gmail.com>
References: <cover.1718919473.git.yan@cloudflare.com>
 <b8c183a24285c2ab30c51622f4f9eff8f7a4752f.1718919473.git.yan@cloudflare.com>
 <66756ed3f2192_2e64f929491@willemb.c.googlers.com.notmuch>
 <CAO3-Pbp8frVM-i6NKkmyNOFrqqW=g58rK8m4vfdWbiSHHdQBsg@mail.gmail.com>
Subject: Re: [RFC net-next 1/9] skb: introduce gro_disabled bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yan Zhai wrote:
> > > -static inline bool netif_elide_gro(const struct net_device *dev)
> > > +static inline bool netif_elide_gro(const struct sk_buff *skb)
> > >  {
> > > -     if (!(dev->features & NETIF_F_GRO) || dev->xdp_prog)
> > > +     if (!(skb->dev->features & NETIF_F_GRO) || skb->dev->xdp_prog)
> > >               return true;
> > > +
> > > +#ifdef CONFIG_SKB_GRO_CONTROL
> > > +     return skb->gro_disabled;
> > > +#else
> > >       return false;
> > > +#endif
> >
> > Yet more branches in the hot path.
> >
> > Compile time configurability does not help, as that will be
> > enabled by distros.
> >
> > For a fairly niche use case. Where functionality of GRO already
> > works. So just a performance for a very rare case at the cost of a
> > regression in the common case. A small regression perhaps, but death
> > by a thousand cuts.
> >
> 
> I share your concern on operating on this hotpath. Will a
> static_branch + sysctl make it less aggressive?

That is always a possibility. But we have to use it judiciously,
cannot add a sysctl for every branch.

I'm still of the opinion that Paolo shared that this seems a lot of
complexity for a fairly minor performance optimization for a rare
case.

> Speaking of
> performance, I'd hope this can give us more control so we can achieve
> the best of two worlds: for TCP and some UDP traffic, we can enable
> GRO, while for some other classes that we know GRO does no good or
> even harm, let's disable GRO to save more cycles. The key observation
> is that developers may already know which traffic is blessed by GRO,
> but lack a way to realize it.

Following up also on Daniel's point on using BPF as GRO engine. Even
earlier I tried to add an option to selectively enable GRO protocols
without BPF. Definitely worthwhile to be able to disable GRO handlers
to reduce attack surface to bad input.


> 
> best
> Yan



