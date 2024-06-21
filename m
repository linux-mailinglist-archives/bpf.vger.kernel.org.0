Return-Path: <bpf+bounces-32737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98170912AC5
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 18:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B923E1C232F6
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 16:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C40F15FA8C;
	Fri, 21 Jun 2024 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KDE+h/v5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E043C208D4
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718985673; cv=none; b=GmkbWkcPV5fochuUWfxa0OlnpqjFrdTUnCRBeFWh3wHjs1SOiJ3nkzrdWT4b8erEXWHu8z0gN+Epn80yYUbGQvMpb5ZtVIcg2tOMrGc1tz/QbOjTBa6LQrGKB3hEZC3LaF86q51GHiApwVuN46RlrPUim9mrNv9/FgZII+V3bTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718985673; c=relaxed/simple;
	bh=bLByArEYUpYI3dt6YWX3IyUutLDU3bI2yI1nVC3d2yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9XlkkyBraytuwtA7BkihPZns0wucax1GrJooWRuQuNlkEApuP/Mdvm1f2EVYeLpcKZ3p9iErSuMsmt+JlJrj9e+muHEJygoYXIOxy4LB6nE5t9lhWyRKFWDN5Vx7MPPW5NetMaAJBgHI4v+vm/a6dhOTto8UEV5cS+2Z6IN9wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KDE+h/v5; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6ef46d25efso256063666b.0
        for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 09:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718985669; x=1719590469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhjJ4nn864WCrKOSZLKnhxFounuXABQFkqKHcC/VvnA=;
        b=KDE+h/v5J8x7DRunQcoXAJfoP2CKXk0Z8wvGO770AS4BXFxyepJ2wTgOgonIn5W840
         tjyIuDk0maX3loDmUXEUC0Z36IGO/dCzY8dLhaK/YzyDmSmNEecfwjYX5hFEa1O+cxF1
         A5+WGChqPVo2FiU6z2RYPBBwECo6GR8Eg9h/ap2NiYNXYZapadn6hV9GD4G001khw6nb
         LlqiqF0VmpeHdCJkwa6f/jRjEYLtn8U6OLIzHUeZENws2l24dKcfECk5+lEqFln9eLZQ
         BF+YsLooyv7676xppob+ZHlUrv8oIsxE9u3Ek67RxaMvuSNRL/tRY15cGQ4p6Pd58KyA
         7oug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718985669; x=1719590469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhjJ4nn864WCrKOSZLKnhxFounuXABQFkqKHcC/VvnA=;
        b=sUQTC+KK3SevnyTU8ccT/wgifWSP3qNjdeCFlXQIeFhfgvGy8CXNu13CKp4Thv72tG
         PI/x23ZlTqH7xaC8jK/wNT3YzXR7c9+sUYksZJSst+U5i1Vx1zYItK1JagcBDAS7KatF
         9/qfnrElpXPRuH2lDIjTCYmlZe7+EkrIZj8raxVQwucm29iwolH+/xRNKKA6Cfmlm/q1
         9Dz7wiWV+dLJrAlTT91w2ESl3QOVzRS76weJfzIY3lnu8e6QrIdFq0obydefGwG9HVKC
         a4dX9DC37UHtO1XLsyKh/N+zAn2xv1rl1MYsTCjPqcxRgBM8ABb/2DBtAohSOMXui5sk
         VfWA==
X-Forwarded-Encrypted: i=1; AJvYcCXDktGrw9coHFFST7wHaTDJ+lGB4UlMmGOte/2RmiR7mhEnTAeVLP3pqgGlkVRC1Dy0hL0euOtjxfUYi13StCTeKKj7
X-Gm-Message-State: AOJu0YwkLbMmAZJ+l8zYvQv04szj3Bf3jLtfS/1QxQ7st+LEqR5Zbt0L
	m2RRFmdIDM0LzSAl0BJOxRZWu9okA2W9sdNxNyhkU2O3ILKoG5Jn3K974Yozd4lLUjtFsbFwg2I
	s5pd9jPOiORydjCCHm4gGaZEeOMGsYnWc0BMwiHqWnVdGHno0LEQ=
X-Google-Smtp-Source: AGHT+IEpRqcMDdiBbz0GyX6dt5W0JqEq7phpDvzBhFKJwWKJcStSGa/ky12EWpk6XnkInTLfmN+VUVAJ+a5pmOhSTCM=
X-Received: by 2002:a17:907:a0d2:b0:a6f:af8e:a385 with SMTP id
 a640c23a62f3a-a6faf8ea560mr403540366b.77.1718985669235; Fri, 21 Jun 2024
 09:01:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718919473.git.yan@cloudflare.com> <b8c183a24285c2ab30c51622f4f9eff8f7a4752f.1718919473.git.yan@cloudflare.com>
 <66756ed3f2192_2e64f929491@willemb.c.googlers.com.notmuch> <44ac34f6-c78e-16dd-14da-15d729fecb5b@iogearbox.net>
In-Reply-To: <44ac34f6-c78e-16dd-14da-15d729fecb5b@iogearbox.net>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 21 Jun 2024 11:00:55 -0500
Message-ID: <CAO3-PbrhnvmdYmQubNsTX3gX917o=Q+MBWTBkxUd=YWt4dNGuA@mail.gmail.com>
Subject: Re: [RFC net-next 1/9] skb: introduce gro_disabled bit
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
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
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 8:13=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 6/21/24 2:15 PM, Willem de Bruijn wrote:
> > Yan Zhai wrote:
> >> Software GRO is currently controlled by a single switch, i.e.
> >>
> >>    ethtool -K dev gro on|off
> >>
> >> However, this is not always desired. When GRO is enabled, even if the
> >> kernel cannot GRO certain traffic, it has to run through the GRO recei=
ve
> >> handlers with no benefit.
> >>
> >> There are also scenarios that turning off GRO is a requirement. For
> >> example, our production environment has a scenario that a TC egress ho=
ok
> >> may add multiple encapsulation headers to forwarded skbs for load
> >> balancing and isolation purpose. The encapsulation is implemented via
> >> BPF. But the problem arises then: there is no way to properly offload =
a
> >> double-encapsulated packet, since skb only has network_header and
> >> inner_network_header to track one layer of encapsulation, but not two.
> >> On the other hand, not all the traffic through this device needs doubl=
e
> >> encapsulation. But we have to turn off GRO completely for any ingress
> >> device as a result.
> >>
> >> Introduce a bit on skb so that GRO engine can be notified to skip GRO =
on
> >> this skb, rather than having to be 0-or-1 for all traffic.
> >>
> >> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> >> ---
> >>   include/linux/netdevice.h |  9 +++++++--
> >>   include/linux/skbuff.h    | 10 ++++++++++
> >>   net/Kconfig               | 10 ++++++++++
> >>   net/core/gro.c            |  2 +-
> >>   net/core/gro_cells.c      |  2 +-
> >>   net/core/skbuff.c         |  4 ++++
> >>   6 files changed, 33 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> >> index c83b390191d4..2ca0870b1221 100644
> >> --- a/include/linux/netdevice.h
> >> +++ b/include/linux/netdevice.h
> >> @@ -2415,11 +2415,16 @@ struct net_device {
> >>      ((dev)->devlink_port =3D (port));                         \
> >>   })
> >>
> >> -static inline bool netif_elide_gro(const struct net_device *dev)
> >> +static inline bool netif_elide_gro(const struct sk_buff *skb)
> >>   {
> >> -    if (!(dev->features & NETIF_F_GRO) || dev->xdp_prog)
> >> +    if (!(skb->dev->features & NETIF_F_GRO) || skb->dev->xdp_prog)
> >>              return true;
> >> +
> >> +#ifdef CONFIG_SKB_GRO_CONTROL
> >> +    return skb->gro_disabled;
> >> +#else
> >>      return false;
> >> +#endif
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
>
> Mentioning it here b/c it perhaps fits in this context, longer time ago
> there was the idea mentioned to have BPF operating as GRO engine which
> might also help to reduce attack surface by only having to handle packets
> of interest for the concrete production use case. Perhaps here meta data
> buffer could be used to pass a notification from XDP to exit early w/o
> aggregation.

Metadata is in fact one of our interests as well. We discussed using
metadata instead of a skb bit to carry this information internally.
Since metadata is opaque atm so it seems the only option is to have a
GRO control hook before napi_gro_receive, and let BPF decide
netif_receive_skb or napi_gro_receive (echo what Paolo said). With BPF
it could indeed be more flexible, but the cons is that it could be
even more slower than taking a bit on skb. I am actually open to
either approach, as long as it gives us more control on when to enable
GRO :)

To extend the discussion a bit, putting GRO aside, I think some common
hook before GRO would be still valuable moving forward: it is a
limited window where the driver code has both access to XDP context
and skb. Today we do not have a good way to transfer HW offloading
info to skbs if XDP redirect-to-cpu or if XDP encap-and-tx for load
balancing purposes. The XDP metadata infrastructure already allows XDP
to read this information with driver supports, so to complete that, a
place to use it (which I introduced as
xdp_buff/frame_fixup_skb_offloading in a later patch) would be
beneficial to pass on things like the flow hash, vlan information,
etc.

best
Yan

