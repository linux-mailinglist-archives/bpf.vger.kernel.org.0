Return-Path: <bpf+bounces-32838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 886F8913903
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 10:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C96E0B21BD0
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 08:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BF576F17;
	Sun, 23 Jun 2024 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQupYGTU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A0F15E83;
	Sun, 23 Jun 2024 08:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719131023; cv=none; b=PY7LYlIFWvdC08gkx2XY+ZKYIwBtLwCmToHHZZ+18KGOVHgxpwGFx4eliJIH0zmzd9rGAtBi8PaiKTE515riFr/OnBt3oXg3WOCln6ob7t9hVv1O+9529uP3Q1Eerx82JTpGVLxFxZ1f8MY7poG+6/r2Zlz6tm8jd1wgCXhJ208=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719131023; c=relaxed/simple;
	bh=oaVrtpISLUXLLldD4lTqGinRJvKGvzbqV4Orc8IXIsU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cVYKsbxZzauVYFBkWQUJUiVYj5DjJeZyFy4HYQVLQJDzoWwJZ9EmlqS7x0SK1UOBd+RXYVJPT3+PlKqdJTdB4l8EWYgsRyQXuzGmU69uITT4SukPStNbbiNjNw3cBJLs8a1YJ0Erxw3X+CLj2p7UAShAKj0558UdOXcmC3P4MWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQupYGTU; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7955841fddaso292593685a.1;
        Sun, 23 Jun 2024 01:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719131020; x=1719735820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qj6OX+9vOEaDgE253CKn3DTtuWduYa4ZO1Ed6FzmWo=;
        b=SQupYGTUbqUlXIgEa7hckOtk+HKayKFuojSLA+2IoNW/5a+UG7PwAEU/6TAizFFP2C
         BYvx/tyIXwGdK4br2L7jY2b0JODW6V3C62cVr6RUEusTTN6f94fg8J6hL0/6y3arfr0H
         PS5uUhhic69TGl3+bXOvkMq/T6JMtgDA9gImlWA0ad9qtM3VcRIpbqdvKsoSXRZG1xPU
         XYtxSRZzr9p/bRzOMh0WPHvwIlhKQT2qCdMT9KgXGN8qzFylRlY3BMeuD27yvPM6ekqT
         Ds6iSw8GA9XMySS73v4PIkIHqOnO++zR/RT6SgGeqhfSiVYk2VlhK7ugHv3BxobshFgH
         H3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719131020; x=1719735820;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/qj6OX+9vOEaDgE253CKn3DTtuWduYa4ZO1Ed6FzmWo=;
        b=NJZejeGCtvoCStmj1HlRhe0jHrWSUr97sWIp9Vs2PB4l+5BPsOTpZzrDLGChC8G+vN
         f5Rfyf3fs8bgLesz3kDQNQT77+W3tBu4ULeESsUtQstqvJ8d4RV5JCWHtKk3EwGiTABB
         WE2bAsxGNVeDAGm3F2xZUti3V80TqAq7+G9X7QriHByQZYWwePQt9nV0wUGjV96IcmZ7
         vYRXvqgZM1UZEzdiuSEt+N4OEwLM0tw3rQMIQATcdeLHVBqWTgLw1jc150GMv5YX292q
         Q0JdYYkfztLRzB3zS65LMWjEDLnW0CUONeuHIADJTIQiKtwgXdio2hd6U0XwkrFEyi5g
         nDNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVepO2fD7fE0WPei8GymZAuru2NzbDFhyvrt2snKEZzanxTfMqvYhnwoaWvvHPW81mtXoy+w4R2fSK3HrVFOxz5hBA6agjWZ9JAafuE+IXe9MOaVkc7J403ympp0C3cfkIr
X-Gm-Message-State: AOJu0Yxlpgd1aYXhVU85tR3KaOMjBoSUZ5sTfx9p0ebAVdQIXTCduoiJ
	1BulK0bbOrMpiB/qtIchFbsDEgW5ip+mmal59F3nL4BNxHaplStKGoXaWw==
X-Google-Smtp-Source: AGHT+IEPnHZgwRnFZw7obFPFu8jUqYIbs+JhSQHcLq8iHy+u9jUR71Vf3XfHdewzB/T8/FCUr7l5hw==
X-Received: by 2002:a05:620a:2481:b0:795:609e:6633 with SMTP id af79cd13be357-79bded5055dmr422081185a.30.1719131020109;
        Sun, 23 Jun 2024 01:23:40 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444d25627a8sm13120421cf.3.2024.06.23.01.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 01:23:39 -0700 (PDT)
Date: Sun, 23 Jun 2024 04:23:39 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yan Zhai <yan@cloudflare.com>, 
 Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 kernel-team <kernel-team@cloudflare.com>
Message-ID: <6677db8b2ef78_33522729492@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAO3-PboYruuLrF7D_rMiuG-AnWdR4BhsgP+MhVmOm-f3MzJFyQ@mail.gmail.com>
References: <cover.1718919473.git.yan@cloudflare.com>
 <b8c183a24285c2ab30c51622f4f9eff8f7a4752f.1718919473.git.yan@cloudflare.com>
 <66756ed3f2192_2e64f929491@willemb.c.googlers.com.notmuch>
 <44ac34f6-c78e-16dd-14da-15d729fecb5b@iogearbox.net>
 <CAO3-PbrhnvmdYmQubNsTX3gX917o=Q+MBWTBkxUd=YWt4dNGuA@mail.gmail.com>
 <e6553be1-4eaa-e90a-17f8-dece2bb95e7b@iogearbox.net>
 <CAO3-PboYruuLrF7D_rMiuG-AnWdR4BhsgP+MhVmOm-f3MzJFyQ@mail.gmail.com>
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
> On Fri, Jun 21, 2024 at 11:41=E2=80=AFAM Daniel Borkmann <daniel@iogear=
box.net> wrote:
> >
> > On 6/21/24 6:00 PM, Yan Zhai wrote:
> > > On Fri, Jun 21, 2024 at 8:13=E2=80=AFAM Daniel Borkmann <daniel@iog=
earbox.net> wrote:
> > >> On 6/21/24 2:15 PM, Willem de Bruijn wrote:
> > >>> Yan Zhai wrote:
> > >>>> Software GRO is currently controlled by a single switch, i.e.
> > >>>>
> > >>>>     ethtool -K dev gro on|off
> > >>>>
> > >>>> However, this is not always desired. When GRO is enabled, even i=
f the
> > >>>> kernel cannot GRO certain traffic, it has to run through the GRO=
 receive
> > >>>> handlers with no benefit.
> > >>>>
> > >>>> There are also scenarios that turning off GRO is a requirement. =
For
> > >>>> example, our production environment has a scenario that a TC egr=
ess hook
> > >>>> may add multiple encapsulation headers to forwarded skbs for loa=
d
> > >>>> balancing and isolation purpose. The encapsulation is implemente=
d via
> > >>>> BPF. But the problem arises then: there is no way to properly of=
fload a
> > >>>> double-encapsulated packet, since skb only has network_header an=
d
> > >>>> inner_network_header to track one layer of encapsulation, but no=
t two.
> > >>>> On the other hand, not all the traffic through this device needs=
 double
> > >>>> encapsulation. But we have to turn off GRO completely for any in=
gress
> > >>>> device as a result.
> > >>>>
> > >>>> Introduce a bit on skb so that GRO engine can be notified to ski=
p GRO on
> > >>>> this skb, rather than having to be 0-or-1 for all traffic.
> > >>>>
> > >>>> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > >>>> ---
> > >>>>    include/linux/netdevice.h |  9 +++++++--
> > >>>>    include/linux/skbuff.h    | 10 ++++++++++
> > >>>>    net/Kconfig               | 10 ++++++++++
> > >>>>    net/core/gro.c            |  2 +-
> > >>>>    net/core/gro_cells.c      |  2 +-
> > >>>>    net/core/skbuff.c         |  4 ++++
> > >>>>    6 files changed, 33 insertions(+), 4 deletions(-)
> > >>>>
> > >>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice=
.h
> > >>>> index c83b390191d4..2ca0870b1221 100644
> > >>>> --- a/include/linux/netdevice.h
> > >>>> +++ b/include/linux/netdevice.h
> > >>>> @@ -2415,11 +2415,16 @@ struct net_device {
> > >>>>       ((dev)->devlink_port =3D (port));                         =
\
> > >>>>    })
> > >>>>
> > >>>> -static inline bool netif_elide_gro(const struct net_device *dev=
)
> > >>>> +static inline bool netif_elide_gro(const struct sk_buff *skb)
> > >>>>    {
> > >>>> -    if (!(dev->features & NETIF_F_GRO) || dev->xdp_prog)
> > >>>> +    if (!(skb->dev->features & NETIF_F_GRO) || skb->dev->xdp_pr=
og)
> > >>>>               return true;
> > >>>> +
> > >>>> +#ifdef CONFIG_SKB_GRO_CONTROL
> > >>>> +    return skb->gro_disabled;
> > >>>> +#else
> > >>>>       return false;
> > >>>> +#endif
> > >>>
> > >>> Yet more branches in the hot path.
> > >>>
> > >>> Compile time configurability does not help, as that will be
> > >>> enabled by distros.
> > >>>
> > >>> For a fairly niche use case. Where functionality of GRO already
> > >>> works. So just a performance for a very rare case at the cost of =
a
> > >>> regression in the common case. A small regression perhaps, but de=
ath
> > >>> by a thousand cuts.
> > >>
> > >> Mentioning it here b/c it perhaps fits in this context, longer tim=
e ago
> > >> there was the idea mentioned to have BPF operating as GRO engine w=
hich
> > >> might also help to reduce attack surface by only having to handle =
packets
> > >> of interest for the concrete production use case. Perhaps here met=
a data
> > >> buffer could be used to pass a notification from XDP to exit early=
 w/o
> > >> aggregation.
> > >
> > > Metadata is in fact one of our interests as well. We discussed usin=
g
> > > metadata instead of a skb bit to carry this information internally.=

> > > Since metadata is opaque atm so it seems the only option is to have=
 a
> > > GRO control hook before napi_gro_receive, and let BPF decide
> > > netif_receive_skb or napi_gro_receive (echo what Paolo said). With =
BPF
> > > it could indeed be more flexible, but the cons is that it could be
> > > even more slower than taking a bit on skb. I am actually open to
> > > either approach, as long as it gives us more control on when to ena=
ble
> > > GRO :)
> >
> > Oh wait, one thing that just came to mind.. have you tried u64 per-CP=
U
> > counter map in XDP? For packets which should not be GRO-aggregated yo=
u
> > add count++ into the meta data area, and this forces GRO to not aggre=
gate
> > since meta data that needs to be transported to tc BPF layer mismatch=
es
> > (and therefore the contract/intent is that tc BPF needs to see the di=
fferent
> > meta data passed to it).
> >
> =

> We did this before accidentally (we put a timestamp for debugging
> purposes in metadata) and this actually caused about 20% of OoO for
> TCP in production: all PSH packets are reordered. GRO does not fire
> the packet to the upper layer when a diff in metadata is found for a
> non-PSH packet, instead it is queued as a =E2=80=9Cnew flow=E2=80=9D on=
 the GRO list
> and waits for flushing. When a PSH packet arrives, its semantic is to
> flush this packet immediately and thus precedes earlier packets of the
> same flow.

Is that a bug in XDP metadata handling for GRO?

Mismatching metadata should not be taken as separate flows, but as a
flush condition.=

