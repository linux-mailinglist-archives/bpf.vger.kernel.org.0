Return-Path: <bpf+bounces-15396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 175787F1D96
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 20:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7051C216C8
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 19:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19C837168;
	Mon, 20 Nov 2023 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="UEZqrGJf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461DFBE
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 11:56:35 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5ca8c606bb7so12584747b3.1
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 11:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700510194; x=1701114994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMp67sisAq0+0rPnl4SRU+Ot9xc2ndLKmSzBryihlAw=;
        b=UEZqrGJfX+0uA3Tcl67X38mHm3GclEl0RXk14TAX/pQmzytUEODsrycsoLRg8kBgCm
         9tR34X9wxkdiL8ec/ezI3tWE4wQyn3FIGCJg0jF7PNPzYSDZzaX9EPFXUsmwQhe/SGe2
         nq6/oOxTGrYpn0IfDYqY84fnS5Gdt0qEGL1YilNs1oWAouCZhOPZp41TL7Z7ry5Ze5sU
         2pvit+Ypp/mZrDcnIyBjGNu0tZ4/8u9OymRnhOFQdtLAZXjzdUAt5BBugEIzBoNKzBue
         VK2t11axRlDeettaA6n2i8TA8FzX3fk7ileXnGqfZxw/TJQUvqQRDde1OPYfwCxzDe21
         QnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700510194; x=1701114994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMp67sisAq0+0rPnl4SRU+Ot9xc2ndLKmSzBryihlAw=;
        b=VkqJygkC1sdN7T49+2DlvBlHxo7gs+ttyP5YVvSER65x2684N5GYtVCL9Ghg/NxTaW
         4XZv/90Uk5utOoeGc2fhAGyXM0hYM9B2MTFAG4u9BtG1+KHzh0wHEh+7+ShHv7FDSpbU
         lABzc0IQsOMSeEJX1o7B6LXGo6rmYfyhZoBMSEYJklI2lms7OzTr/+PxsvASbKLYdrMx
         3yAJ36AhCHXOWLXDPNhXOkM49yCT0cLDowCTXjt2/vHVP8mFn/AyVZiuBgb4QnRy9xW8
         4bJK8Aucpy1jEVmsCu6gnkDRbGXcBc0n9hw6jRUEn0WtPiPU4kMvUghvqE2mCrqi4Zf1
         //nw==
X-Gm-Message-State: AOJu0Yzt0ysoDRuR7PUhvzfPXp54LSugMt8RrT4mVbKeEd5rs3Dqv+Wy
	fAJxiz0qTYhrFjj4ZjcpBX3XrmrO+UTqeTavaWBvjw==
X-Google-Smtp-Source: AGHT+IGZrw+TCCDpBZeNnj/VDKBA3lue4dr2MINa/TWGLbmdUady2zjVbm9ws8IYWkLqhpGBn//+o5qPsor48Wbbq/Q=
X-Received: by 2002:a0d:ce44:0:b0:5b3:21cd:ba76 with SMTP id
 q65-20020a0dce44000000b005b321cdba76mr9110737ywd.4.1700510194480; Mon, 20 Nov
 2023 11:56:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116145948.203001-1-jhs@mojatatu.com> <655707db8d55e_55d7320812@john.notmuch>
 <CAM0EoM=vbyKD9+t=UQ73AyLZtE2xP9i9RKCVMqeXwEh+j-nyjQ@mail.gmail.com>
 <6557b2e5f3489_5ada920871@john.notmuch> <CAM0EoMkrb4kv+bjQqrFKFo9mxGFs6tjQtq4D-FtcemBV_WYNUQ@mail.gmail.com>
 <ZVspOBmzrwm8isiD@nanopsycho> <CAM0EoMm3whh6xaAdKcT=a9FcSE4EMn=xJxkXY5ked=nwGaGFeQ@mail.gmail.com>
 <ZVuhBlYRwi8eGiSF@nanopsycho>
In-Reply-To: <ZVuhBlYRwi8eGiSF@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 20 Nov 2023 14:56:22 -0500
Message-ID: <CAM0EoMknA01gmGX-XLH4fT_yW9H82bN3iNYEvFRypvTwARiNqg@mail.gmail.com>
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

On Mon, Nov 20, 2023 at 1:10=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Mon, Nov 20, 2023 at 03:23:59PM CET, jhs@mojatatu.com wrote:
> >On Mon, Nov 20, 2023 at 4:39=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wr=
ote:
> >>
> >> Fri, Nov 17, 2023 at 09:46:11PM CET, jhs@mojatatu.com wrote:
> >> >On Fri, Nov 17, 2023 at 1:37=E2=80=AFPM John Fastabend <john.fastaben=
d@gmail.com> wrote:
> >> >>
> >> >> Jamal Hadi Salim wrote:
> >> >> > On Fri, Nov 17, 2023 at 1:27=E2=80=AFAM John Fastabend <john.fast=
abend@gmail.com> wrote:
> >> >> > >
> >> >> > > Jamal Hadi Salim wrote:
> >>
> >> [...]
> >>
> >>
> >> >>
> >> >> I think I'm judging the technical work here. Bullet points.
> >> >>
> >> >> 1. p4c-tc implementation looks like it should be slower than a
> >> >>    in terms of pkts/sec than a bpf implementation. Meaning
> >> >>    I suspect pipeline and objects laid out like this will lose
> >> >>    to a BPF program with an parser and single lookup. The p4c-ebpf
> >> >>    compiler should look to create optimized EBPF code not some
> >> >>    emulated switch topology.
> >> >>
> >> >
> >> >The parser is ebpf based. The other objects which require control
> >> >plane interaction are not - those interact via netlink.
> >> >We published perf data a while back - presented at the P4 workshop
> >> >back in April (was in the cover letter)
> >> >https://github.com/p4tc-dev/docs/blob/main/p4-conference-2023/2023P4W=
orkshopP4TC.pdf
> >> >But do note: the correct abstraction is the first priority.
> >> >Optimization is something we can teach the compiler over time. But
> >> >even with the minimalist code generation you can see that our approac=
h
> >> >always beats ebpf in LPM and ternary. The other ones I am pretty sure
> >>
> >> Any idea why? Perhaps the existing eBPF maps are not that suitable for
> >> this kinds of lookups? I mean in theory, eBPF should be always faster.
> >
> >We didnt look closely; however, that is not the point - the point is
> >the perf difference if there is one, is not big with the big win being
> >proper P4 abstraction. For LPM for sure our algorithmic approach is
> >better. For ternary the compute intensity in looping is better done in
> >C. And for exact i believe that ebpf uses better hashing.
> >Again, that is not the point we were trying to validate in those experim=
ents..
> >
> >On your point of "maps are not that suitable" P4 tables tend to have
> >very specific attributes (examples associated meters, counters,
> >default hit and miss actions, etc).
> >
> >> >we can optimize over time.
> >> >Your view of "single lookup" is true for simple programs but if you
> >> >have 10 tables trying to model a 5G function then it doesnt make sens=
e
> >> >(and i think the data we published was clear that you gain no
> >> >advantage using ebpf - as a matter of fact there was no perf
> >> >difference between XDP and tc in such cases).
> >> >
> >> >> 2. p4c-tc control plan looks slower than a directly mmaped bpf
> >> >>    map. Doing a simple update vs a netlink msg. The argument
> >> >>    that BPF can't do CRUD (which we had offlist) seems incorrect
> >> >>    to me. Correct me if I'm wrong with details about why.
> >> >>
> >> >
> >> >So let me see....
> >> >you want me to replace netlink and all its features and rewrite it
> >> >using the ebpf system calls? Congestion control, event handling,
> >> >arbitrary message crafting, etc and the years of work that went into
> >> >netlink? NO to the HELL.
> >>
> >> Wait, I don't think John suggests anything like that. He just suggests
> >> to have the tables as eBPF maps.
> >
> >What's the difference? Unless maps can do netlink.
> >
> >> Honestly, I don't understand the
> >> fixation on netlink. Its socket messaging, memcpies, processing
> >> overhead, etc can't keep up with mmaped memory access at scale. Measur=
e
> >> that and I bet you'll get drastically different results.
> >>
> >> I mean, netlink is good for a lot of things, but does not mean it is a=
n
> >> universal answer to userspace<->kernel data passing.
> >
> >Here's a small sample of our requirements that are satisfied by
> >netlink for P4 object hierarchy[1]:
> >1. Msg construction/parsing
> >2. Multi-user request/response messaging
>
> What is actually a usecase for having multiple users program p4 pipeline
> in parallel?

First of all - this is Linux, multiple users is a way of life, you
shouldnt have to ask that question unless you are trying to be
socratic. Meaning multiple control plane apps can be allowed to
program different parts and even different tables - think multi-tier
pipeline.

> >3. Multi-user event subscribe/publish messaging
>
> Same here. What is the usecase for multiple users receiving p4 events?

Same thing.
Note: Events are really not part of P4 but we added them for
flexibility - and as you well know they are useful.

>
> >
> >I dont think i need to provide an explanation on the differences here
> >visavis what ebpf system calls provide vs what netlink provides and
> >how netlink is a clear fit. If it is not clear i can give more
>
> It is not :/

I thought it was obvious for someone like you, but fine - here goes for tho=
se 3:

1. Msg construction/parsing: A lot of infra for sending attributes
back and forth is already built into netlink. I would have to create
mine from scratch for ebpf.  This will include not just the
construction/parsing but all the detailed attribute content policy
validations(even in the presence of hierarchies) that comes with it.
And not to forget the state transform between kernel and user space.

2. Multi-user request/response messaging
If you can write all the code for #1 above then this should work fine for e=
bpf

3. Event publish subscribe
You would have to create mechanisms for ebpf which either are non
trivial or non complete: Example 1: you can put surgeries in the ebpf
code to look at map manipulations and then interface it to some event
management scheme which checks for subscribed users. Example 2: It may
also be feasible to create your own map for subscription vs something
like perf ring for event publication(something i have done in the
past), but that is also limited in many ways.

>
> >breakdown. And of course there's more but above is a good sample.
> >
> >The part that is taken for granted is the control plane code and
> >interaction which is an extremely important detail. P4 Abstraction
> >requires hierarchies with different compiler generated encoded path
> >ids etc. This ID mapping gets exacerbated by having multitudes of  P4
>
> Why the actual eBFP mapping does not serve the same purpose as ID?
> ID:mapping 1 :1

An identification of an object requires hierarchical IDs: A
pipeline/program ID, A table id, a table entry Identification, an
action identification and for each individual action content
parameter, an ID etc. These same IDs would be what hardware would
recognize as well (in case of offload).  Given the dynamic nature of
these IDs it is essentially up to the compiler to define them. These
hierarchies  are much easier to validate in netlink.

We dont want to be constrained to a generic infra like eBPF for these
objects. Again eBPF is a means to an end (and not the goal here!).

cheers,
jamal
>
>
> >programs which have different requirements. Netlink is a natural fit
> >for this P4 abstraction. Not to mention the netlink/tc path (and in
> >particular the ID mapping) provides a conduit for offload when that is
> >needed.
> >eBPF is just a tool - and the objects are intended to be generic - and
> >i dont see how any of this could be achieved without retooling to make
> >it more specific to P4.
> >
> >cheers,
> >jamal
> >
> >
> >
> >>
> >> >I should note: that there was an interesting talk at netdevconf 0x17
> >> >where the speaker showed the challenges of dealing with ebpf on "day
> >> >two" - slides or videos are not up yet, but link is:
> >> >https://netdevconf.info/0x17/sessions/talk/is-scaling-ebpf-easy-yet-a=
-small-step-to-one-server-but-giant-leap-to-distributed-network.html
> >> >The point the speaker was making is it's always easy to whip an ebpf
> >> >program that can slice and dice packets and maybe even flush LEDs but
> >> >the real work and challenge is in the control plane. I agree with the
> >> >speaker based on my experiences. This discussion of replacing netlink
> >> >with ebpf system calls is absolutely a non-starter. Let's just end th=
e
> >> >discussion and agree to disagree if you are going to keep insisting o=
n
> >> >that.
> >>
> >>
> >> [...]

