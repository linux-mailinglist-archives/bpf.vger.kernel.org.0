Return-Path: <bpf+bounces-32729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C222C9127C4
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 16:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CCBE1F21E75
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 14:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382E92BB1B;
	Fri, 21 Jun 2024 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="G2riJ6mm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FA6C148
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718980204; cv=none; b=jrlZ1hJsE27xvZOH/FtOIBfA7lz5jRkxOWk1nZzq9tA7fsCucdhR2PvK2URYWXHtQDo8cPc9Yx+fgp9L7UApCP/GnWvHM0e1bMyVkwZSczOAksr7TMq/XAeZZ5Q+LYtWEOGBUl58SHR+SheNyaJKCgphgCswUUcXoUccZ4dRHoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718980204; c=relaxed/simple;
	bh=74XNNsrGcyt42W0i4MGFAN1ASfBc1WU+Wx8RPbhBId0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPKHIQpdEE25sKEi9huJ4D/SFAGllBpJdcOXRYJENgfmKNwsrnA798WwHUyXh+eQwRBtgM3srvTIBWOLr6u8edrx8KcVJ57pzQtWPxOvBgjpshAUd+OUcehAqZJyrbEjN4ggpWkfc2y4jLAaNC9fXg8PrptzPq/GhER2jk2hrGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=G2riJ6mm; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00b97so2005658a12.0
        for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 07:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718980201; x=1719585001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ne9VJpx8ATDhafgirOBTQVVX5apXj+MyTTRFOBCHPQI=;
        b=G2riJ6mm83GI9hpvQ1ed6E3z1bAbY4V7dQde1ZnuiOP8gVTFLnV4hUSbkOCeKUGGzw
         nKXNQDpabIsBHnUU9w8HTmxwh4ZBI5uNl7kPoptYXgm6Qb2d+/0Z3zTecIO9PGezlyvP
         bNsMjYi58JVupyl/5NvNzfNcldHBLGGegAAXeaLWBvuSwLK8+VKzaMm6Y5bTFHGWTA6+
         MpELz/t/tRJrah/6KM95zNpK9xeQtZ9m7dhrktL1nxIs68eZc2MuRwdfgzQoUq9JnqCq
         oip+9sYRa252b5j2WlrC/LqVi+CcXh6V3iBLoiJXGzScQh6Pachbjv6Bq/go4O344F4Q
         jCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718980201; x=1719585001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ne9VJpx8ATDhafgirOBTQVVX5apXj+MyTTRFOBCHPQI=;
        b=p/r4eq77NF0p0xETujBy4WgzcIkkBhqGpn8ihr+5VmAwDOmeRkTj7emF6l3kaTAtsg
         QemRSgmB4J/OiIdkYf9t/D+SBoCTCZC9r6xWKQBIjPWE+6L+4PfNM2FN/T8celh/2hjO
         Ok0AgSSgztGZRWnosYh/ASMnj+JrvnGDtkFHyqOA4T3JZIbR+AIa6QdxJyq2PkeI7KS4
         pdZVS+eDFBt6TV2yH+rIlwf2FvMotP3bdKp+hWEJgczYlkrt206RHILObI9JwEbMjl8Z
         OlU80iSWDxFZEsOoTYGgAR7GTCUZO2LZaW1D3o8Ci2mzpF0yZAUzTpuMp3J8pY2tvjCb
         VDkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUBk4RhbbiyxIrNueTLbqvSktNs7/UyKfW8WGW1WvkfYdfL31UvLF64K747OizuSbnch0h8ba/MtybNfy3i1fw+UCL
X-Gm-Message-State: AOJu0YxWnUboWOOCFmSPL3lCv7ySpceNYSVBoRTcJS2uB1DecF9CCe7f
	2Jj2Vs41uOlMe5/+L+EGWnRohTC8XVtBFQ5SB+zZeuZ7HtB7cjOqilaz36U529HKtQv/xprSSMz
	m1IfqXbTy9s/agdqg8SG+VWNjbQkqH9IQs4mFxw==
X-Google-Smtp-Source: AGHT+IHSOppKzSm+kjtySl83Xy2s0lY1tdgWQ/xnbihr5ZcC5awX/1jregyRR8ecqABG8aV7I3my61NvkLz1w0cvTgQ=
X-Received: by 2002:a50:d699:0:b0:579:ca97:da1b with SMTP id
 4fb4d7f45d1cf-57d07e0d427mr5079082a12.6.1718980200824; Fri, 21 Jun 2024
 07:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718919473.git.yan@cloudflare.com> <b8c183a24285c2ab30c51622f4f9eff8f7a4752f.1718919473.git.yan@cloudflare.com>
 <a1c983cdb95bdd44385dae29ca7451da16a70c98.camel@redhat.com>
In-Reply-To: <a1c983cdb95bdd44385dae29ca7451da16a70c98.camel@redhat.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 21 Jun 2024 09:29:49 -0500
Message-ID: <CAO3-Pboc_r-owOxkZcD9Tyo4MD0ey9bBJj827R+o_NnMMkF2Ow@mail.gmail.com>
Subject: Re: [RFC net-next 1/9] skb: introduce gro_disabled bit
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
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
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 4:49=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Thu, 2024-06-20 at 15:19 -0700, Yan Zhai wrote:
> > Software GRO is currently controlled by a single switch, i.e.
> >
> >   ethtool -K dev gro on|off
> >
> > However, this is not always desired. When GRO is enabled, even if the
> > kernel cannot GRO certain traffic, it has to run through the GRO receiv=
e
> > handlers with no benefit.
> >
> > There are also scenarios that turning off GRO is a requirement. For
> > example, our production environment has a scenario that a TC egress hoo=
k
> > may add multiple encapsulation headers to forwarded skbs for load
> > balancing and isolation purpose. The encapsulation is implemented via
> > BPF. But the problem arises then: there is no way to properly offload a
> > double-encapsulated packet, since skb only has network_header and
> > inner_network_header to track one layer of encapsulation, but not two.
> > On the other hand, not all the traffic through this device needs double
> > encapsulation. But we have to turn off GRO completely for any ingress
> > device as a result.
> >
> > Introduce a bit on skb so that GRO engine can be notified to skip GRO o=
n
> > this skb, rather than having to be 0-or-1 for all traffic.
> >
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > ---
> >  include/linux/netdevice.h |  9 +++++++--
> >  include/linux/skbuff.h    | 10 ++++++++++
> >  net/Kconfig               | 10 ++++++++++
> >  net/core/gro.c            |  2 +-
> >  net/core/gro_cells.c      |  2 +-
> >  net/core/skbuff.c         |  4 ++++
> >  6 files changed, 33 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index c83b390191d4..2ca0870b1221 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -2415,11 +2415,16 @@ struct net_device {
> >       ((dev)->devlink_port =3D (port));                         \
> >  })
> >
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
> This will generate OoO if the gro_disabled is flipped in the middle of
> a stream.
>
> Assuming the above is fine for your use case (I think it's _not_ in
> general), you could get the same result without an additional costly
> bit in sk_buff.

Calling it per-packet control seems inaccurate here, the motivation is
to give users the ability to control per-flow behaviors. OoO is indeed
a consequence if users don't do it correctly.

>
> Let xdp_frame_fixup_skb_offloading() return a bool - e.g. 'true' when
> gro should be avoided - and let the NIC driver call netif_receive_skb()
> instead of the gro rx hook for such packet.
>
For rx on a single device, directly calling netif_receive_skb is
reasonable. For tunnel receivers it is kinda inconsistent IMHO. For
example, we terminate GRE tunnels in a netns, and it is necessary to
disable GRO on both the entering veth device and also the GRE tunnel
to shutdown GRO. That's why I'd hope to use a bit of skb, to be
consistent within the same netns. Let me add a bit more context to
clarify why we think this is necessary in another thread.

best,
Yan

> All in all the approach implemented in this series does not look worthy
> to me.
>
> Thanks,
>
> Paolo
>

