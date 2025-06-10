Return-Path: <bpf+bounces-60188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84255AD3BA3
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 16:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B60C3A9E9C
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 14:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4FE20DD6B;
	Tue, 10 Jun 2025 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wt9WAt1Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EA41FE44D
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749566979; cv=none; b=AFYwKfacTvCEd39tg4orJYydeDMu/7tIyzDnVLGnK3HMbPjrqgfYK7J9L6/2Mh/nPGWk9vRH8kL2Lq+en+r54MNB58giDqJLKJ3j7qlFU/yc+ctf+QuLzw31p1BXE0fNfsoBpC9YXdz0GvWlvWYBibCB0OZOXvD71ica8yx3UtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749566979; c=relaxed/simple;
	bh=IWRUrEd7brUxEQ1vU5PPByxfISsVCWANzqeHUhsa5EQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceu9ur5mPAsUKNqTG53iC7QwW1ldye2Z9e2AUbDUL0LC6UGQF3y2BaRTF69v/kCOoliNZzCm10u0egh/3pCnioDBrhAjlOh8PkL/vDAZn9S1XK1q24GBKcU2pDjmb7arY3p4r7HeklPPT6nrIj0INkPo4NURb15OUox417DWaEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wt9WAt1Y; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a58c2430edso60262551cf.1
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 07:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749566976; x=1750171776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z15tMFb2reZO+eqtRhpVQfHqAPcEFXwc1PjRxRnjSKw=;
        b=wt9WAt1Y6fc8RmPRkhkelTg+oyzRE0B7IXiPjQdjNQJNRfVr8e832ui9i8rc9BkHGQ
         57YR9n06KLMxv7WkhqPeZfu7MRk8eH1TDQ8eRQhsnarB+5FQBlyW2UXaNRQ/lXHDVMZU
         NpuoTjLb0k868r7AE9RVHdiaDrf7t6BgLJOkKD12nUNzmZ4bFZBb1zp1X/WHb71XjhXD
         bxbvjriRlHT1GadeX22pnsQEy3gBAcRBqGLp6Dk2DY+jUjFi2b2HNBWxW8ghvzDibYje
         F+/y/tRlQgO7a17prgMFezKztYruoiQkTHMQQLzFalh0LqNhgD/ttYhgZNg7icZawJwa
         qGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749566976; x=1750171776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z15tMFb2reZO+eqtRhpVQfHqAPcEFXwc1PjRxRnjSKw=;
        b=rNFptDH68rup6vBFTBJweiCbj0F2UTjAABKGv+VpEoELDV7uwyC2eadXuxfBTGlVQr
         rO40oRkDDPAwkCO8+6RdR2tRVx038JyC61zLvzg57LwIxgAdQvy+IRjGikOgGACyP663
         2cd/W6fi7oWsEL3cTnOxEGQg5XZr1PeZxien2hyPG+4TX/GhQUhEauJc0w0L09HHzqds
         48Qrdc0tBJgklV3xDuHSEA2BMXWmc4D93Lt5WHVMnP8tOZCItThvlDxwJzVgZi8QN3+T
         Od+Hv4m97wOwfSkdRsWFQA81Qy4N4otI1LRAeXLdxaKZ2KyN1DfzEjqmwZjKr59jKgus
         RNDA==
X-Forwarded-Encrypted: i=1; AJvYcCVShgAsbom/XxO1b4xgS6rk0ER0wkWWZjfJt5iBci8UGUqPqBzdvgJn9yiapku/Ac1beQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEqWMWWeyHlXQu+oymL5X2A5Tv3IK5pkI16idRXgEnqzjqT3if
	EmuYhiTNLQVQmLWBy0PThGmmYwsce0AEUmYX5V232G3vT05+m2hNS6zYOjg5d97pPcnzFu8qVdW
	egR6r8nIsAP9lJqjV5sgq4m/D64TQLmn/7qXDLStB
X-Gm-Gg: ASbGncsXPHVZI0bCFainNw88r1/JFRKFNOKWiD5LA92yqUj+HX/2CNyEU5H3Uj6+76m
	Ik1jy2EOC7XOvQUjTpUxep8lOL462DJxR3KUbDGj1U+Aufih/AXE9yQqxg26ot97Jrafq/x1j0i
	e3O5JXKxPYbNE1PYTX9mv70Wy/xqb4FD8gQ+EYeDz1qgw=
X-Google-Smtp-Source: AGHT+IE7AxlYGiV8s47P7BrFuP3emvjItDe1dAR8WPAPSqot9vEQvUGV4Rp4OaweBpSE3WeuZGT2Lp8Eh+bOQUxn9C8=
X-Received: by 2002:a05:622a:1bac:b0:4a6:f098:f7ab with SMTP id
 d75a77b69052e-4a708cc2becmr58479461cf.4.1749566975456; Tue, 10 Jun 2025
 07:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9da42688-bfaa-4364-8797-e9271f3bdaef@hetzner-cloud.de>
 <87zfemtbah.fsf@toke.dk> <CANn89i+7crgdpf-UXDpTNdWfei95+JHyMD_dBD8efTbLBnvZUQ@mail.gmail.com>
 <CANn89iKpZ5aLNpv66B9M4R1d_Pn5ZX=8-XaiyCLgKRy3marUtQ@mail.gmail.com>
 <5f19b555-b0fa-472a-a5f3-6673c0b69c5c@hetzner-cloud.de> <CANn89iJAR3HvWXNqNSR=y9qYm4W5sD40La+UpRraF4NE8yhfrA@mail.gmail.com>
 <3d520952-c343-4ae5-98c0-c9965dc7e320@hetzner-cloud.de>
In-Reply-To: <3d520952-c343-4ae5-98c0-c9965dc7e320@hetzner-cloud.de>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Jun 2025 07:49:24 -0700
X-Gm-Features: AX0GCFuHGqfCvhwHrIwtC1IRpeotqI5rTZBKXFx--OR6eLkehVlSIUCxLpuqrnY
Message-ID: <CANn89iKFm1ER904sUUh5v_e29QvkFAZXe4yOJfeoo9VLx616iA@mail.gmail.com>
Subject: Re: [BUG] veth: TX drops with NAPI enabled and crash in combination
 with qdisc
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 7:41=E2=80=AFAM Marcus Wichelmann
<marcus.wichelmann@hetzner-cloud.de> wrote:
>
> Am 06.06.25 um 11:06 schrieb Eric Dumazet:
> > On Thu, Jun 5, 2025 at 3:17=E2=80=AFPM Marcus Wichelmann
> > <marcus.wichelmann@hetzner-cloud.de> wrote:
> >>
> >> Am 06.06.25 um 00:11 schrieb Eric Dumazet:
> >>> On Thu, Jun 5, 2025 at 9:46=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> >>>>
> >>>> On Thu, Jun 5, 2025 at 9:15=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgen=
sen <toke@redhat.com> wrote:
> >>>>>
> >>>>> Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de> writes:
> >>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> while experimenting with XDP_REDIRECT from a veth-pair to another =
interface, I
> >>>>>> noticed that the veth-pair looses lots of packets when multiple TC=
P streams go
> >>>>>> through it, resulting in stalling TCP connections and noticeable i=
nstabilities.
> >>>>>>
> >>>>>> This doesn't seem to be an issue with just XDP but rather occurs w=
henever the
> >>>>>> NAPI mode of the veth driver is active.
> >>>>>> I managed to reproduce the same behavior just by bringing the veth=
-pair into
> >>>>>> NAPI mode (see commit d3256efd8e8b ("veth: allow enabling NAPI eve=
n without
> >>>>>> XDP")) and running multiple TCP streams through it using a network=
 namespace.
> >>>>>>
> >>>>>> Here is how I reproduced it:
> >>>>>>
> >>>>>>   ip netns add lb
> >>>>>>   ip link add dev to-lb type veth peer name in-lb netns lb
> >>>>>>
> >>>>>>   # Enable NAPI
> >>>>>>   ethtool -K to-lb gro on
> >>>>>>   ethtool -K to-lb tso off
> >>>>>>   ip netns exec lb ethtool -K in-lb gro on
> >>>>>>   ip netns exec lb ethtool -K in-lb tso off
> >>>>>>
> >>>>>>   ip link set dev to-lb up
> >>>>>>   ip -netns lb link set dev in-lb up
> >>>>>>
> >>>>>> Then run a HTTP server inside the "lb" namespace that serves a lar=
ge file:
> >>>>>>
> >>>>>>   fallocate -l 10G testfiles/10GB.bin
> >>>>>>   caddy file-server --root testfiles/
> >>>>>>
> >>>>>> Download this file from within the root namespace multiple times i=
n parallel:
> >>>>>>
> >>>>>>   curl http://[fe80::...%to-lb]/10GB.bin -o /dev/null
> >>>>>>
> >>>>>> In my tests, I ran four parallel curls at the same time and after =
just a few
> >>>>>> seconds, three of them stalled while the other one "won" over the =
full bandwidth
> >>>>>> and completed the download.
> >>>>>>
> >>>>>> This is probably a result of the veth's ptr_ring running full, cau=
sing many
> >>>>>> packet drops on TX, and the TCP congestion control reacting to tha=
t.
> >>>>>>
> >>>>>> In this context, I also took notice of Jesper's patch which descri=
bes a very
> >>>>>> similar issue and should help to resolve this:
> >>>>>>   commit dc82a33297fc ("veth: apply qdisc backpressure on full ptr=
_ring to
> >>>>>>   reduce TX drops")
> >>>>>>
> >>>>>> But when repeating the above test with latest mainline, which incl=
udes this
> >>>>>> patch, and enabling qdisc via
> >>>>>>   tc qdisc add dev in-lb root sfq perturb 10
> >>>>>> the Kernel crashed just after starting the second TCP stream (see =
output below).
> >>>>>>
> >>>>>> So I have two questions:
> >>>>>> - Is my understanding of the described issue correct and is Jesper=
's patch
> >>>>>>   sufficient to solve this?
> >>>>>
> >>>>> Hmm, yeah, this does sound likely.
> >>>>>
> >>>>>> - Is my qdisc configuration to make use of this patch correct and =
the kernel
> >>>>>>   crash is likely a bug?
> >>>>>>
> >>>>>> ------------[ cut here ]------------
> >>>>>> UBSAN: array-index-out-of-bounds in net/sched/sch_sfq.c:203:12
> >>>>>> index 65535 is out of range for type 'sfq_head [128]'
> >>>>>
> >>>>> This (the 'index 65535') kinda screams "integer underflow". So cert=
ainly
> >>>>> looks like a kernel bug, yeah. Don't see any obvious reason why Jes=
per's
> >>>>> patch would trigger this; maybe Eric has an idea?
> >>>>>
> >>>>> Does this happen with other qdiscs as well, or is it specific to sf=
q?
> >>>>
> >>>> This seems like a bug in sfq, we already had recent fixes in it, and
> >>>> other fixes in net/sched vs qdisc_tree_reduce_backlog()
> >>>>
> >>>> It is possible qdisc_pkt_len() could be wrong in this use case (TSO =
off ?)
> >>>
> >>> This seems to be a very old bug, indeed caused by sch->gso_skb
> >>> contribution to sch->q.qlen
> >>>
> >>> diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
> >>> index b912ad99aa15d95b297fb28d0fd0baa9c21ab5cd..77fa02f2bfcd56a368151=
99aa2e7987943ea226f
> >>> 100644
> >>> --- a/net/sched/sch_sfq.c
> >>> +++ b/net/sched/sch_sfq.c
> >>> @@ -310,7 +310,10 @@ static unsigned int sfq_drop(struct Qdisc *sch,
> >>> struct sk_buff **to_free)
> >>>                 /* It is difficult to believe, but ALL THE SLOTS HAVE
> >>> LENGTH 1. */
> >>>                 x =3D q->tail->next;
> >>>                 slot =3D &q->slots[x];
> >>> -               q->tail->next =3D slot->next;
> >>> +               if (slot->next =3D=3D x)
> >>> +                       q->tail =3D NULL; /* no more active slots */
> >>> +               else
> >>> +                       q->tail->next =3D slot->next;
> >>>                 q->ht[slot->hash] =3D SFQ_EMPTY_SLOT;
> >>>                 goto drop;
> >>>         }
> >>>
> >>
> >> Hi,
> >>
> >> thank you for looking into it.
> >> I'll give your patch a try and will also do tests with other qdiscs as=
 well when I'm back
> >> in office.
> >>
> >
> > I have been using this repro :
> >
> > [...]
>
> Hi,
>
> I can confirm that the sfq qdisc is now stable in this setup, thanks to y=
our fix.
>
> I also experimented with other qdiscs and fq_codel works as well.
>
> The sfq/fq_codel qdisc works hand-in-hand now with Jesper's patch to reso=
lve the original
> issue. Multiple TCP connections run very stable, even when NAPI/XDP is ac=
tive on the veth
> device, and I can see that the packets are being requeued instead of bein=
g dropped in the
> veth driver.
>
> Thank you for your help!

Well, thanks to you for providing a very clean report, including repro
instructions !

