Return-Path: <bpf+bounces-33448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E5A91D1DA
	for <lists+bpf@lfdr.de>; Sun, 30 Jun 2024 15:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAE151C20B5B
	for <lists+bpf@lfdr.de>; Sun, 30 Jun 2024 13:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F9913F439;
	Sun, 30 Jun 2024 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvcHmVGb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAA412DD90;
	Sun, 30 Jun 2024 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719754821; cv=none; b=rLQ5b7+DfJUsVz73valtz0JpByZKsOOSnEjdm/ptp6qvRZ6U8BD8KQUwMfu+hF+HkHBU3Z5fJSz0WSj+t16OmXa4ljEMMYE9IEGbVALV/TQ17fP0VXpywMHt8At26lKOoo1LGjkJj8XCLbNqkPs++KMy7nyc0FX924ifu3ITEV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719754821; c=relaxed/simple;
	bh=K1iSFLq5ePba2KehTDuSb8d5VR75RXpx8jz4H5SWxu4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DTeWNcWehiaFWy6n66I7CzTpKP95KtTFf9N+umimVTxH71HehTPplD0mgZdiRv17u2zIfMpgNexBHidwrajmzaaBL0W7YiEquh2aLdOcLMVa80T3Eqt09YNowWQK3NnI+UI0QvBdtkXhXt2uBaeDESjhn1LEWWuqloSyLWSBDi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvcHmVGb; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5c444e7d18fso197425eaf.3;
        Sun, 30 Jun 2024 06:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719754819; x=1720359619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQcDa+wDXNNN/mQ/HwttTTXR+alCmusd4OT/lRAH1tA=;
        b=FvcHmVGb3rk805OkQQGxJ8mgD5V6eoz6JxyN/BPhpW2sri6QaRyKrrQqwoJC0vZlnf
         3OW4G/EzWNIz1CwNo4FkcnJkTGYVpoda7RAQtVdacNP1iKb6gOXGqB9211ENOM48GHjp
         331p3xeD62GxDsPGi40+X5Mlnh3TPGIS/XowZCyCwylSMUMsfw+LJl5CsSAHRqArW5K7
         cS9ijfDyNbAlLJCFX0wSyYzgeUq+tAsn1E35HLk7TgNww04jHG4Q5A4RtBhZ54mpVf5n
         apnpQ3hBq3FkFPfWbYuV1lN0I4t0pob9j8BiLv0QJfkWDARKMzdxm0Mz/rmT61M2PfoB
         4H7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719754819; x=1720359619;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MQcDa+wDXNNN/mQ/HwttTTXR+alCmusd4OT/lRAH1tA=;
        b=IURW4r7ahKz5J1QnraNUGY/kdvj9CQuczmaPN5Jenx80csrHK3myOMV/9xjTOQRFfE
         IQdHWpqNBSZuN4tjtI5AoL+TifyWf8O0fTQfn5d/oczeQhYKWItgFNMupTPkna5UIve5
         5d7S1TPcQCtQSqUh0+N9hjpB/JXNYkxww4xaXi2KaHn/rgedLulScg2aBQYCmLsVt/k0
         FfVbXq42DeB8JMimiM6Mjd0BzvxXGg3wbVYeslUoYXQv7WtbtQMghDVsLfW/IXeKrh5e
         dlP5vSvMmit3uNZyRf9dChDLrkj2WPni+sDq+H8UY1ucFJ7u2itIlODs5w6sPYvTR0i3
         vbLA==
X-Forwarded-Encrypted: i=1; AJvYcCXRXrnkntTpz+vEbDyDscIcyi2zZkq+WnMHC7/oVT0ZDfhu5vZdtSqai4oikRCd7nPfxdnOwDIF6G5/iuKto3TJkqZcL7jm5v4oceG/bwgPB+qP2ZQvUZ9TyKwolbLzHNzb
X-Gm-Message-State: AOJu0Yw9w8D/mLAEhxfVGyleff+40ngxt2zYkMmykbZqHJM4w+wTFxxy
	EqRmaWqUw81xKa82jWD4OAEVyTh/v1YTW9YyFlOTMuipILHlOPkt
X-Google-Smtp-Source: AGHT+IEUNMMZuVhVUIWv2yyDj7cheQEwWk3+Vfqb53sl5ZI0k2IxiEwvSe2rRf3iG2EgVF68Zkw1Ig==
X-Received: by 2002:a05:6358:4327:b0:1a2:11d6:3b26 with SMTP id e5c5f4694b2df-1a6accda99dmr381208555d.2.1719754818361;
        Sun, 30 Jun 2024 06:40:18 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d6929be9esm253760685a.60.2024.06.30.06.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 06:40:17 -0700 (PDT)
Date: Sun, 30 Jun 2024 09:40:17 -0400
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
Message-ID: <668160415228c_c6202948c@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAO3-PbrKRqeA4bCPnv7xkDiUFtuCMfzYZiEur3wM=+x8nc2xpQ@mail.gmail.com>
References: <cover.1718919473.git.yan@cloudflare.com>
 <b8c183a24285c2ab30c51622f4f9eff8f7a4752f.1718919473.git.yan@cloudflare.com>
 <66756ed3f2192_2e64f929491@willemb.c.googlers.com.notmuch>
 <CAO3-Pbp8frVM-i6NKkmyNOFrqqW=g58rK8m4vfdWbiSHHdQBsg@mail.gmail.com>
 <6677dc5cb5cca_33522729474@willemb.c.googlers.com.notmuch>
 <CAO3-PbrKRqeA4bCPnv7xkDiUFtuCMfzYZiEur3wM=+x8nc2xpQ@mail.gmail.com>
Subject: Re: [RFC net-next 1/9] skb: introduce gro_disabled bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yan Zhai wrote:
> On Sun, Jun 23, 2024 at 3:27=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Yan Zhai wrote:
> > > > > -static inline bool netif_elide_gro(const struct net_device *de=
v)
> > > > > +static inline bool netif_elide_gro(const struct sk_buff *skb)
> > > > >  {
> > > > > -     if (!(dev->features & NETIF_F_GRO) || dev->xdp_prog)
> > > > > +     if (!(skb->dev->features & NETIF_F_GRO) || skb->dev->xdp_=
prog)
> > > > >               return true;
> > > > > +
> > > > > +#ifdef CONFIG_SKB_GRO_CONTROL
> > > > > +     return skb->gro_disabled;
> > > > > +#else
> > > > >       return false;
> > > > > +#endif
> > > >
> > > > Yet more branches in the hot path.
> > > >
> > > > Compile time configurability does not help, as that will be
> > > > enabled by distros.
> > > >
> > > > For a fairly niche use case. Where functionality of GRO already
> > > > works. So just a performance for a very rare case at the cost of =
a
> > > > regression in the common case. A small regression perhaps, but de=
ath
> > > > by a thousand cuts.
> > > >
> > >
> > > I share your concern on operating on this hotpath. Will a
> > > static_branch + sysctl make it less aggressive?
> >
> > That is always a possibility. But we have to use it judiciously,
> > cannot add a sysctl for every branch.
> >
> > I'm still of the opinion that Paolo shared that this seems a lot of
> > complexity for a fairly minor performance optimization for a rare
> > case.
> >
> Actually combining the discussion in this thread, I think it would be
> more than the corner cases that we encounter. Let me elaborate below.
> =

> > > Speaking of
> > > performance, I'd hope this can give us more control so we can achie=
ve
> > > the best of two worlds: for TCP and some UDP traffic, we can enable=

> > > GRO, while for some other classes that we know GRO does no good or
> > > even harm, let's disable GRO to save more cycles. The key observati=
on
> > > is that developers may already know which traffic is blessed by GRO=
,
> > > but lack a way to realize it.
> >
> > Following up also on Daniel's point on using BPF as GRO engine. Even
> > earlier I tried to add an option to selectively enable GRO protocols
> > without BPF. Definitely worthwhile to be able to disable GRO handlers=

> > to reduce attack surface to bad input.
> >
> I was probably staring too hard at my own things, which is indeed a
> corner case. But reducing the attack surface is indeed a good
> motivation for this patch. I checked briefly with our DoS team today,
> the DoS scenario will definitely benefit from skipping GRO, for
> example on SYN/RST floods. XDP is our main weapon to drop attack
> traffic today, but it does not always drop 100% of the floods, and
> time by time it does need to fall back to iptables due to the delay of
> XDP program assembly or the BPF limitation on analyzing the packet. I
> did an ad hoc measurement just now on a mostly idle server, with
> ~1.3Mpps SYN flood concentrated on one CPU and dropped them early in
> raw-PREROUTING. w/ GRO this would consume about 35-41% of the CPU
> time, while w/o GRO the time dropped to 9-12%. This seems a pretty
> significant breath room under heavy attacks.

A GRO opt-out might make sense.

A long time ago I sent a patch that configured GRO protocols using
syscalls, selectively (un)registering handlers. The interface was not
very nice, so I did not pursue it further. On the upside, the datapath
did not introduce any extra code. The intent was to reduce attack
surface of packet parsing code.

A few concerns with an XDP based opt-out. It is more work to enable:
requires compiling and load an XDP program. It adds cycles in the
hot path. And I do not entirely understand when an XDP program will be
able to detect that a packet should not enter the GRO engine, but
cannot drop the packet (your netfilter example above).

> But I am not sure I understand "BPF as GRO engine" here, it seems to
> me that being able to disable GRO by XDP is already good enough. Any
> more motivations to do more complex work here?

FWIW, we looked into this a few years ago. Analogous to the BPF flow
dissector: if the BPF program is loaded, use that instead of the C
code path. But we did not arrive at a practical implementation at the
time. Things may have changed, but one issue is how to store and
access the list (or table) of outstanding GRO skbs.

> best
> Yan
> =

> >
> > >
> > > best
> > > Yan
> >
> >



