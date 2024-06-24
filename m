Return-Path: <bpf+bounces-32928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647D39155CD
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 19:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC9FFB22AD9
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 17:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3276919F48A;
	Mon, 24 Jun 2024 17:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="d31jN/H9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA9C19F488
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 17:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251376; cv=none; b=IdAhfgYS68biR/d6BAYqsJNt0N0754O4t4ObS+EkTWetnPhfVcaSkRWyD1htFt2RYRekwq2/fJNkLRulVc054CE+GW0/TZ5xlc0P5nHnCtThtI9B6gzdkbFhGJKy0fMkZmXkAVb6bgOrKuSKPiMu/BVH6rTgju1Gs3NhBjHst20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251376; c=relaxed/simple;
	bh=Bf9Guv1QNbjMVDwFxJHiYuhL1KV7H82L0MrTLCU+2YI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQwvcHTRlo+L6oNvRk0OUFnCoMi+AKbwhFAoX6TI5VCo7g/0H8LQxSbdg8ovugfmuQ8R0WvwW9wxLa5VOl6KEcKFtujxnJRvXqB2f1AKXJaUyCnqyyq1OBLydCQi1kfVgUj8Aim9zUjUhXG8mNJGypGGviJLXDmympNrxxEMNWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=d31jN/H9; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ec408c6d94so53724971fa.3
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 10:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1719251372; x=1719856172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbbAfpo2+pMau+1QdjEGlkS2E4OZnyRsc/b85mU5Vvg=;
        b=d31jN/H9XfV+QTnqrFSjSR/Z58iD2vSnlVATBKEAz4vtBQZAL7Gwi7E4MNME7Kdh7p
         HBmMZEPxbo/HApDx4doayGNSSZkzQh9FaoMI0uLDgiFUvATpTF2/iP6FW5QbNVx0dxHQ
         BCtIJY30d3WLe9bgAuxV5ZpK4n6o1N9hp0ncVqje1jNLcyRH+2VZX5tgt7p5mzdq/ou2
         cwBgmTjgs0W5Wzi66vXYvVKX8fsou4KnrLOQUxFkg05KLjfR3UR5MX4XXx7sck+iyU7S
         AhcWDMgcqeGiyJyUujkUUMCCwKCe9Bh2PCwVrqUdPCs2gVFWG/toVuWMrpPbYciAw48E
         BxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719251372; x=1719856172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbbAfpo2+pMau+1QdjEGlkS2E4OZnyRsc/b85mU5Vvg=;
        b=canb6zmfuOE65cN93PTFGZMHAOeLsA2Wtkvsd4PjEX2p8x+CJmC04RV5AFmU5dlNJu
         pbxf008Dp2yJ2ze132LLSl03FUjJtjOrGQCGry3nYCNZrf/IpIjHZQwiuTypkM8BUaLf
         Lf8c+UxSC0tT+X1f3AaHy5JXQYOeE3NiZKv3UBC8+Hceihwf1MnUX3lryj6ZZDHMS7XA
         yBbUuA0OzRnBkcVHRGTxUfwlt62vDZgicR+tY04jI4rTAIp7DNEfJ651cZCRcOXh3gke
         ovSS68b8EcCDe2wUJaxAGPcrercrtM/uP1fDvDjDLdxQv3GNsNw2lS5q1K1NK6lQ6jfD
         XPqg==
X-Forwarded-Encrypted: i=1; AJvYcCV0YIO3GEZby4kVjZcTonKFQRP+2UgUTgiKjleY2PuKIMSsP6J5d/lNhbPQeMjvar3YnqPGK8n/TxG+SepLMk0ueBc3
X-Gm-Message-State: AOJu0YziL5SMP4zc/cUpzjuNEKgj79UIYEqjX3kzEbhSxYTXm/ffeeig
	bT5hs1BlnB0HFfKpqSqyRzHAU0pc5A28bFDQskDktAGZpQkPhN+UzfF9qqYMX6/uP3hdASbtcBD
	IWVwXLg5F5pnPP8YmaXAmF9I7P3pzqFgoWJzibMLmVbiyO74B
X-Google-Smtp-Source: AGHT+IH3pCfEpAMJvD46ojBZBA0m7JkKFkrZwsZS3r+xQwu70WEB/qS1C/CtVh4wZ7UKbN75NfSbPn/QZn+xXZNnu9M=
X-Received: by 2002:a2e:87d3:0:b0:2ec:55b5:ed41 with SMTP id
 38308e7fff4ca-2ec5931d876mr41742601fa.16.1719251371796; Mon, 24 Jun 2024
 10:49:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718919473.git.yan@cloudflare.com> <b8c183a24285c2ab30c51622f4f9eff8f7a4752f.1718919473.git.yan@cloudflare.com>
 <66756ed3f2192_2e64f929491@willemb.c.googlers.com.notmuch>
 <44ac34f6-c78e-16dd-14da-15d729fecb5b@iogearbox.net> <CAO3-PbrhnvmdYmQubNsTX3gX917o=Q+MBWTBkxUd=YWt4dNGuA@mail.gmail.com>
 <e6553be1-4eaa-e90a-17f8-dece2bb95e7b@iogearbox.net> <CAO3-PboYruuLrF7D_rMiuG-AnWdR4BhsgP+MhVmOm-f3MzJFyQ@mail.gmail.com>
 <6677db8b2ef78_33522729492@willemb.c.googlers.com.notmuch> <caecbff8-ffc4-976b-4516-dba41848ef30@iogearbox.net>
In-Reply-To: <caecbff8-ffc4-976b-4516-dba41848ef30@iogearbox.net>
From: Yan Zhai <yan@cloudflare.com>
Date: Mon, 24 Jun 2024 12:49:20 -0500
Message-ID: <CAO3-PbpmS8=gTSb84X8wV4NiCA8JNXrEXYONJKmc6RoM4QQwYg@mail.gmail.com>
Subject: Re: [RFC net-next 1/9] skb: introduce gro_disabled bit
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 8:30=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 6/23/24 10:23 AM, Willem de Bruijn wrote:
> > Yan Zhai wrote:
> >> On Fri, Jun 21, 2024 at 11:41=E2=80=AFAM Daniel Borkmann <daniel@iogea=
rbox.net> wrote:
> >>> On 6/21/24 6:00 PM, Yan Zhai wrote:
> >>>> On Fri, Jun 21, 2024 at 8:13=E2=80=AFAM Daniel Borkmann <daniel@ioge=
arbox.net> wrote:
> >>>>> On 6/21/24 2:15 PM, Willem de Bruijn wrote:
> >>>>>> Yan Zhai wrote:
> >>>>>>> Software GRO is currently controlled by a single switch, i.e.
> >>>>>>>
> >>>>>>>      ethtool -K dev gro on|off
> >>>>>>>
> >>>>>>> However, this is not always desired. When GRO is enabled, even if=
 the
> >>>>>>> kernel cannot GRO certain traffic, it has to run through the GRO =
receive
> >>>>>>> handlers with no benefit.
> >>>>>>>
> >>>>>>> There are also scenarios that turning off GRO is a requirement. F=
or
> >>>>>>> example, our production environment has a scenario that a TC egre=
ss hook
> >>>>>>> may add multiple encapsulation headers to forwarded skbs for load
> >>>>>>> balancing and isolation purpose. The encapsulation is implemented=
 via
> >>>>>>> BPF. But the problem arises then: there is no way to properly off=
load a
> >>>>>>> double-encapsulated packet, since skb only has network_header and
> >>>>>>> inner_network_header to track one layer of encapsulation, but not=
 two.
> >>>>>>> On the other hand, not all the traffic through this device needs =
double
> >>>>>>> encapsulation. But we have to turn off GRO completely for any ing=
ress
> >>>>>>> device as a result.
> >>>>>>>
> >>>>>>> Introduce a bit on skb so that GRO engine can be notified to skip=
 GRO on
> >>>>>>> this skb, rather than having to be 0-or-1 for all traffic.
> >>>>>>>
> >>>>>>> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> >>>>>>> ---
> >>>>>>>     include/linux/netdevice.h |  9 +++++++--
> >>>>>>>     include/linux/skbuff.h    | 10 ++++++++++
> >>>>>>>     net/Kconfig               | 10 ++++++++++
> >>>>>>>     net/core/gro.c            |  2 +-
> >>>>>>>     net/core/gro_cells.c      |  2 +-
> >>>>>>>     net/core/skbuff.c         |  4 ++++
> >>>>>>>     6 files changed, 33 insertions(+), 4 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.=
h
> >>>>>>> index c83b390191d4..2ca0870b1221 100644
> >>>>>>> --- a/include/linux/netdevice.h
> >>>>>>> +++ b/include/linux/netdevice.h
> >>>>>>> @@ -2415,11 +2415,16 @@ struct net_device {
> >>>>>>>        ((dev)->devlink_port =3D (port));                         =
\
> >>>>>>>     })
> >>>>>>>
> >>>>>>> -static inline bool netif_elide_gro(const struct net_device *dev)
> >>>>>>> +static inline bool netif_elide_gro(const struct sk_buff *skb)
> >>>>>>>     {
> >>>>>>> -    if (!(dev->features & NETIF_F_GRO) || dev->xdp_prog)
> >>>>>>> +    if (!(skb->dev->features & NETIF_F_GRO) || skb->dev->xdp_pro=
g)
> >>>>>>>                return true;
> >>>>>>> +
> >>>>>>> +#ifdef CONFIG_SKB_GRO_CONTROL
> >>>>>>> +    return skb->gro_disabled;
> >>>>>>> +#else
> >>>>>>>        return false;
> >>>>>>> +#endif
> >>>>>>
> >>>>>> Yet more branches in the hot path.
> >>>>>>
> >>>>>> Compile time configurability does not help, as that will be
> >>>>>> enabled by distros.
> >>>>>>
> >>>>>> For a fairly niche use case. Where functionality of GRO already
> >>>>>> works. So just a performance for a very rare case at the cost of a
> >>>>>> regression in the common case. A small regression perhaps, but dea=
th
> >>>>>> by a thousand cuts.
> >>>>>
> >>>>> Mentioning it here b/c it perhaps fits in this context, longer time=
 ago
> >>>>> there was the idea mentioned to have BPF operating as GRO engine wh=
ich
> >>>>> might also help to reduce attack surface by only having to handle p=
ackets
> >>>>> of interest for the concrete production use case. Perhaps here meta=
 data
> >>>>> buffer could be used to pass a notification from XDP to exit early =
w/o
> >>>>> aggregation.
> >>>>
> >>>> Metadata is in fact one of our interests as well. We discussed using
> >>>> metadata instead of a skb bit to carry this information internally.
> >>>> Since metadata is opaque atm so it seems the only option is to have =
a
> >>>> GRO control hook before napi_gro_receive, and let BPF decide
> >>>> netif_receive_skb or napi_gro_receive (echo what Paolo said). With B=
PF
> >>>> it could indeed be more flexible, but the cons is that it could be
> >>>> even more slower than taking a bit on skb. I am actually open to
> >>>> either approach, as long as it gives us more control on when to enab=
le
> >>>> GRO :)
> >>>
> >>> Oh wait, one thing that just came to mind.. have you tried u64 per-CP=
U
> >>> counter map in XDP? For packets which should not be GRO-aggregated yo=
u
> >>> add count++ into the meta data area, and this forces GRO to not aggre=
gate
> >>> since meta data that needs to be transported to tc BPF layer mismatch=
es
> >>> (and therefore the contract/intent is that tc BPF needs to see the di=
fferent
> >>> meta data passed to it).
> >>
> >> We did this before accidentally (we put a timestamp for debugging
> >> purposes in metadata) and this actually caused about 20% of OoO for
> >> TCP in production: all PSH packets are reordered. GRO does not fire
> >> the packet to the upper layer when a diff in metadata is found for a
> >> non-PSH packet, instead it is queued as a =E2=80=9Cnew flow=E2=80=9D o=
n the GRO list
> >> and waits for flushing. When a PSH packet arrives, its semantic is to
> >> flush this packet immediately and thus precedes earlier packets of the
> >> same flow.
> >
> > Is that a bug in XDP metadata handling for GRO?
> >
> > Mismatching metadata should not be taken as separate flows, but as a
> > flush condition.
>
> Definitely a bug as it should flush. If noone is faster I can add it to m=
y
> backlog todo to fix it, but might probably take a week before I get to it=
.
>
In theory we should flush if the same flow has different metadata.
However "same flow" is not finally confirmed until GRO proceeds to the
TCP layer in this case. So to achieve this flush semantic, metadata
should be compared at the leaf protocol handlers instead of initially
inside dev_gro_receive. I am not quite sure if it is worthwhile, or
just allow skipping GRO from XDP, since it's the XDP program who sets
this metadata.

Yan

> Thanks,
> Daniel

