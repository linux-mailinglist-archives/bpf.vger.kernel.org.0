Return-Path: <bpf+bounces-15361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 320097F159C
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 15:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 115DDB2193B
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 14:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC7F1C6A7;
	Mon, 20 Nov 2023 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="CMy+wbKa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDB3100
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 06:24:12 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5ac376d311aso46955257b3.1
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 06:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700490251; x=1701095051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gEPY1LrqSmpJpaiBqSwRLrjpD0QQobLoZxYD8R11t8=;
        b=CMy+wbKa4VEfIl3m/M9h9ipgnwqgTeRjDHng4c134YI4jiRzA0qngHWj/9iuQIQvUC
         om45wbJqgTqRqvYK7qYisyx1kc8Qq8OuoaFZxdgLxF0nwLSok6eZ/QKMS6UU0JRLYIZu
         P4FwHVDzGd4k39ogmv2g2XORDrF0BXKEli7+BFjcBC67YGSk2bk/QU66+HJV+Tzra0mZ
         rTktotfvK6/kOGHcl3KqMsCpoqzyZdVQfvAs840JADyGJ5ypyVLP8VfOSR0g6P+6U3ec
         0KfrKPFB8p71YBB6LWVEtAlqnroMrX3RdmLWFoc93NYzIdWEK7sufE14TBmEu8YNi+ar
         YeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700490251; x=1701095051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gEPY1LrqSmpJpaiBqSwRLrjpD0QQobLoZxYD8R11t8=;
        b=LUkCdDGK1mEOjQbKqaNIv0rbEoJnAKwfXVXk6YG3MFC3ZZiXhzpEjEqTGsI1GhcPlh
         n/4QqXC2r305nOCAHMt51SN2hTyXpM03qF67LLhYKn920ukIKIwvv72pbQPOvGAGJME0
         UxLkY89uhHs6rHZ3fIbP2nGSTc/gVJfIzmybORvA661thaPO5Tt/TOVvoZrqvJA41IP7
         Cok8u4BXM8JTgHX4BX7uEKIWHFyrAitlKJWZEdlb0R4u0euJfCThxmpbDj/p8QOlZpPc
         j9+woSQ5+S5LnwjxBsKrhck/eA40fCx8rYM6T8YyfIQWaGUmKUXJyUKaRBGFFy7LbSGg
         HZkQ==
X-Gm-Message-State: AOJu0YxmjMY2kH2IHSjgWo0ly2Fm4o+9+so2hXDJ25o9GnHmmtUxWeSF
	d6U6JB91MMZJhzJHUHI2e8IAGhKE9ac2w0uM+jGi3w==
X-Google-Smtp-Source: AGHT+IFeHC4UiMPvP5jBdv2iBd5hnYUbS8LGBIcinijndQSUO2w/jcwpjHm5CaA9CaIcgZsQjXigkctZPJI/ItLcqcs=
X-Received: by 2002:a81:7e50:0:b0:5ca:d5b9:9da3 with SMTP id
 p16-20020a817e50000000b005cad5b99da3mr1608670ywn.41.1700490251213; Mon, 20
 Nov 2023 06:24:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116145948.203001-1-jhs@mojatatu.com> <655707db8d55e_55d7320812@john.notmuch>
 <CAM0EoM=vbyKD9+t=UQ73AyLZtE2xP9i9RKCVMqeXwEh+j-nyjQ@mail.gmail.com>
 <6557b2e5f3489_5ada920871@john.notmuch> <CAM0EoMkrb4kv+bjQqrFKFo9mxGFs6tjQtq4D-FtcemBV_WYNUQ@mail.gmail.com>
 <ZVspOBmzrwm8isiD@nanopsycho>
In-Reply-To: <ZVspOBmzrwm8isiD@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 20 Nov 2023 09:23:59 -0500
Message-ID: <CAM0EoMm3whh6xaAdKcT=a9FcSE4EMn=xJxkXY5ked=nwGaGFeQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 00/15] Introducing P4TC
To: Jiri Pirko <jiri@resnulli.us>
Cc: John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	deb.chatterjee@intel.com, anjali.singhai@intel.com, Vipin.Jain@amd.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, daniel@iogearbox.net, 
	bpf@vger.kernel.org, khalidm@nvidia.com, toke@redhat.com, mattyk@nvidia.com, 
	dan.daly@intel.com, chris.sommers@keysight.com, john.andy.fingerhut@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 4:39=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Fri, Nov 17, 2023 at 09:46:11PM CET, jhs@mojatatu.com wrote:
> >On Fri, Nov 17, 2023 at 1:37=E2=80=AFPM John Fastabend <john.fastabend@g=
mail.com> wrote:
> >>
> >> Jamal Hadi Salim wrote:
> >> > On Fri, Nov 17, 2023 at 1:27=E2=80=AFAM John Fastabend <john.fastabe=
nd@gmail.com> wrote:
> >> > >
> >> > > Jamal Hadi Salim wrote:
>
> [...]
>
>
> >>
> >> I think I'm judging the technical work here. Bullet points.
> >>
> >> 1. p4c-tc implementation looks like it should be slower than a
> >>    in terms of pkts/sec than a bpf implementation. Meaning
> >>    I suspect pipeline and objects laid out like this will lose
> >>    to a BPF program with an parser and single lookup. The p4c-ebpf
> >>    compiler should look to create optimized EBPF code not some
> >>    emulated switch topology.
> >>
> >
> >The parser is ebpf based. The other objects which require control
> >plane interaction are not - those interact via netlink.
> >We published perf data a while back - presented at the P4 workshop
> >back in April (was in the cover letter)
> >https://github.com/p4tc-dev/docs/blob/main/p4-conference-2023/2023P4Work=
shopP4TC.pdf
> >But do note: the correct abstraction is the first priority.
> >Optimization is something we can teach the compiler over time. But
> >even with the minimalist code generation you can see that our approach
> >always beats ebpf in LPM and ternary. The other ones I am pretty sure
>
> Any idea why? Perhaps the existing eBPF maps are not that suitable for
> this kinds of lookups? I mean in theory, eBPF should be always faster.

We didnt look closely; however, that is not the point - the point is
the perf difference if there is one, is not big with the big win being
proper P4 abstraction. For LPM for sure our algorithmic approach is
better. For ternary the compute intensity in looping is better done in
C. And for exact i believe that ebpf uses better hashing.
Again, that is not the point we were trying to validate in those experiment=
s..

On your point of "maps are not that suitable" P4 tables tend to have
very specific attributes (examples associated meters, counters,
default hit and miss actions, etc).

> >we can optimize over time.
> >Your view of "single lookup" is true for simple programs but if you
> >have 10 tables trying to model a 5G function then it doesnt make sense
> >(and i think the data we published was clear that you gain no
> >advantage using ebpf - as a matter of fact there was no perf
> >difference between XDP and tc in such cases).
> >
> >> 2. p4c-tc control plan looks slower than a directly mmaped bpf
> >>    map. Doing a simple update vs a netlink msg. The argument
> >>    that BPF can't do CRUD (which we had offlist) seems incorrect
> >>    to me. Correct me if I'm wrong with details about why.
> >>
> >
> >So let me see....
> >you want me to replace netlink and all its features and rewrite it
> >using the ebpf system calls? Congestion control, event handling,
> >arbitrary message crafting, etc and the years of work that went into
> >netlink? NO to the HELL.
>
> Wait, I don't think John suggests anything like that. He just suggests
> to have the tables as eBPF maps.

What's the difference? Unless maps can do netlink.

> Honestly, I don't understand the
> fixation on netlink. Its socket messaging, memcpies, processing
> overhead, etc can't keep up with mmaped memory access at scale. Measure
> that and I bet you'll get drastically different results.
>
> I mean, netlink is good for a lot of things, but does not mean it is an
> universal answer to userspace<->kernel data passing.

Here's a small sample of our requirements that are satisfied by
netlink for P4 object hierarchy[1]:
1. Msg construction/parsing
2. Multi-user request/response messaging
3. Multi-user event subscribe/publish messaging

I dont think i need to provide an explanation on the differences here
visavis what ebpf system calls provide vs what netlink provides and
how netlink is a clear fit. If it is not clear i can give more
breakdown. And of course there's more but above is a good sample.

The part that is taken for granted is the control plane code and
interaction which is an extremely important detail. P4 Abstraction
requires hierarchies with different compiler generated encoded path
ids etc. This ID mapping gets exacerbated by having multitudes of  P4
programs which have different requirements. Netlink is a natural fit
for this P4 abstraction. Not to mention the netlink/tc path (and in
particular the ID mapping) provides a conduit for offload when that is
needed.
eBPF is just a tool - and the objects are intended to be generic - and
i dont see how any of this could be achieved without retooling to make
it more specific to P4.

cheers,
jamal



>
> >I should note: that there was an interesting talk at netdevconf 0x17
> >where the speaker showed the challenges of dealing with ebpf on "day
> >two" - slides or videos are not up yet, but link is:
> >https://netdevconf.info/0x17/sessions/talk/is-scaling-ebpf-easy-yet-a-sm=
all-step-to-one-server-but-giant-leap-to-distributed-network.html
> >The point the speaker was making is it's always easy to whip an ebpf
> >program that can slice and dice packets and maybe even flush LEDs but
> >the real work and challenge is in the control plane. I agree with the
> >speaker based on my experiences. This discussion of replacing netlink
> >with ebpf system calls is absolutely a non-starter. Let's just end the
> >discussion and agree to disagree if you are going to keep insisting on
> >that.
>
>
> [...]

