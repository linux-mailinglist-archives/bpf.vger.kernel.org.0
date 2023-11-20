Return-Path: <bpf+bounces-15438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8781C7F20C4
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 23:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C71828284E
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 22:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC583A8FC;
	Mon, 20 Nov 2023 22:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ph86ajjS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D440CD
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 14:57:03 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5cb4b4889e5so5973497b3.2
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 14:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700521022; x=1701125822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A449hwkBWqABH696djWTMwcA7NbA3vRmxfn013PIjRc=;
        b=ph86ajjSOOkvDZTBxjf1JwyqEA5PJMtIKvQYW+4+uyx7LwyU9QCKza90Iykpc/0mWJ
         af/M15Z3kLutw1NZQ47ULCt7rTZEk483Ask30weHbIsGmuc4nanfZya3wzRXuoGMQqfK
         /JS5ch6S21p2wmSu8l2Q8Tvp409l9n04TN1oG2D+xbbNvRA0o9wZVIcbiZ2nguDzK8v9
         fxR8O7Q7SOr8wABHQkptesTknAgZtZ6lV4w+VB9NWh64sndIBMN5GFC9zctyC/uP9XMY
         utn5VXxnSLaomDuznBdswAVs8YtL0x4AixSjNgrEeMSTrzWeOBTevCls1ZiWtlIafX+t
         odxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700521022; x=1701125822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A449hwkBWqABH696djWTMwcA7NbA3vRmxfn013PIjRc=;
        b=wzc8uV4rBAwvv1d3v5trudTmQAh6DTPJr71181PIXVhOMKNAuU14Glz/ZhfkINPq/D
         4viX9igUU+ibxTguiW8vD6cbWMPXqAA4BquG0mHM74V1ehHPdRDQHX67bTPHRqquzXGn
         fqr2LC4v50QTE22vAvvMD0Ue+DsopiKzzTGavTWl8MzkQWfW2XDGTrQadwvrZ7BJ8ZxI
         hUaB0HhiKGbJLUPSareBqCDeaWwZuYIkZ7/AZ5Rnd4IZLPeRAjYCDhRORpzyb4XmxzIJ
         byfEBJ43DNKraXEbCO101CzulgIKlk0L3Rf9pxYLyItBmMondXFgrQlL1pk8ScZtLNYL
         Fnjw==
X-Gm-Message-State: AOJu0Yz68AlSr+mGI6OZOFb69GdGeP4sUfJDr84fthmoj5/cogMcZZYr
	c60gGIq2mBtLsdnLT5gao/h4c5WnTUMubwwM/RfiNQ==
X-Google-Smtp-Source: AGHT+IECduZEyrGiGJ9VzpVsnGQX5l3tIvmP4zR1F0fH4cYbrpbqb1Yf1pwNT0FECIFicm7n3aTPJ00RYSp0ZKrPSw8=
X-Received: by 2002:a0d:ff45:0:b0:577:189b:ad4 with SMTP id
 p66-20020a0dff45000000b00577189b0ad4mr10067936ywf.48.1700521022337; Mon, 20
 Nov 2023 14:57:02 -0800 (PST)
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
 <ZVuhBlYRwi8eGiSF@nanopsycho> <CAM0EoMknA01gmGX-XLH4fT_yW9H82bN3iNYEvFRypvTwARiNqg@mail.gmail.com>
 <2a7d6f27-3464-c57b-b09d-55c03bc5eae6@iogearbox.net>
In-Reply-To: <2a7d6f27-3464-c57b-b09d-55c03bc5eae6@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 20 Nov 2023 17:56:50 -0500
Message-ID: <CAM0EoMkBHqRU9tprJ-SK3tKMfcGsnydp0UA9cH2ALjpSNyJhig@mail.gmail.com>
Subject: Re: [PATCH net-next v8 00/15] Introducing P4TC
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Pirko <jiri@resnulli.us>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	deb.chatterjee@intel.com, anjali.singhai@intel.com, Vipin.Jain@amd.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, bpf@vger.kernel.org, khalidm@nvidia.com, 
	toke@redhat.com, mattyk@nvidia.com, dan.daly@intel.com, 
	chris.sommers@keysight.com, john.andy.fingerhut@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 4:49=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 11/20/23 8:56 PM, Jamal Hadi Salim wrote:
> > On Mon, Nov 20, 2023 at 1:10=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> w=
rote:
> >> Mon, Nov 20, 2023 at 03:23:59PM CET, jhs@mojatatu.com wrote:
> >>> On Mon, Nov 20, 2023 at 4:39=E2=80=AFAM Jiri Pirko <jiri@resnulli.us>=
 wrote:
> >>>> Fri, Nov 17, 2023 at 09:46:11PM CET, jhs@mojatatu.com wrote:
> >>>>> On Fri, Nov 17, 2023 at 1:37=E2=80=AFPM John Fastabend <john.fastab=
end@gmail.com> wrote:
> >>>>>> Jamal Hadi Salim wrote:
> >>>>>>> On Fri, Nov 17, 2023 at 1:27=E2=80=AFAM John Fastabend <john.fast=
abend@gmail.com> wrote:
> >>>>>>>> Jamal Hadi Salim wrote:
> >>>>
> >>>> [...]
> >>>>
> >>>>>> I think I'm judging the technical work here. Bullet points.
> >>>>>>
> >>>>>> 1. p4c-tc implementation looks like it should be slower than a
> >>>>>>     in terms of pkts/sec than a bpf implementation. Meaning
> >>>>>>     I suspect pipeline and objects laid out like this will lose
> >>>>>>     to a BPF program with an parser and single lookup. The p4c-ebp=
f
> >>>>>>     compiler should look to create optimized EBPF code not some
> >>>>>>     emulated switch topology.
> >>>>>
> >>>>> The parser is ebpf based. The other objects which require control
> >>>>> plane interaction are not - those interact via netlink.
> >>>>> We published perf data a while back - presented at the P4 workshop
> >>>>> back in April (was in the cover letter)
> >>>>> https://github.com/p4tc-dev/docs/blob/main/p4-conference-2023/2023P=
4WorkshopP4TC.pdf
> >>>>> But do note: the correct abstraction is the first priority.
> >>>>> Optimization is something we can teach the compiler over time. But
> >>>>> even with the minimalist code generation you can see that our appro=
ach
> >>>>> always beats ebpf in LPM and ternary. The other ones I am pretty su=
re
> >>>>
> >>>> Any idea why? Perhaps the existing eBPF maps are not that suitable f=
or
> >>>> this kinds of lookups? I mean in theory, eBPF should be always faste=
r.
> >>>
> >>> We didnt look closely; however, that is not the point - the point is
> >>> the perf difference if there is one, is not big with the big win bein=
g
> >>> proper P4 abstraction. For LPM for sure our algorithmic approach is
> >>> better. For ternary the compute intensity in looping is better done i=
n
> >>> C. And for exact i believe that ebpf uses better hashing.
> >>> Again, that is not the point we were trying to validate in those expe=
riments..
> >>>
> >>> On your point of "maps are not that suitable" P4 tables tend to have
> >>> very specific attributes (examples associated meters, counters,
> >>> default hit and miss actions, etc).
> >>>
> >>>>> we can optimize over time.
> >>>>> Your view of "single lookup" is true for simple programs but if you
> >>>>> have 10 tables trying to model a 5G function then it doesnt make se=
nse
> >>>>> (and i think the data we published was clear that you gain no
> >>>>> advantage using ebpf - as a matter of fact there was no perf
> >>>>> difference between XDP and tc in such cases).
> >>>>>
> >>>>>> 2. p4c-tc control plan looks slower than a directly mmaped bpf
> >>>>>>     map. Doing a simple update vs a netlink msg. The argument
> >>>>>>     that BPF can't do CRUD (which we had offlist) seems incorrect
> >>>>>>     to me. Correct me if I'm wrong with details about why.
> >>>>>
> >>>>> So let me see....
> >>>>> you want me to replace netlink and all its features and rewrite it
> >>>>> using the ebpf system calls? Congestion control, event handling,
> >>>>> arbitrary message crafting, etc and the years of work that went int=
o
> >>>>> netlink? NO to the HELL.
> >>>>
> >>>> Wait, I don't think John suggests anything like that. He just sugges=
ts
> >>>> to have the tables as eBPF maps.
> >>>
> >>> What's the difference? Unless maps can do netlink.
> >>>
> >>>> Honestly, I don't understand the
> >>>> fixation on netlink. Its socket messaging, memcpies, processing
> >>>> overhead, etc can't keep up with mmaped memory access at scale. Meas=
ure
> >>>> that and I bet you'll get drastically different results.
> >>>>
> >>>> I mean, netlink is good for a lot of things, but does not mean it is=
 an
> >>>> universal answer to userspace<->kernel data passing.
> >>>
> >>> Here's a small sample of our requirements that are satisfied by
> >>> netlink for P4 object hierarchy[1]:
> >>> 1. Msg construction/parsing
> >>> 2. Multi-user request/response messaging
> >>
> >> What is actually a usecase for having multiple users program p4 pipeli=
ne
> >> in parallel?
> >
> > First of all - this is Linux, multiple users is a way of life, you
> > shouldnt have to ask that question unless you are trying to be
> > socratic. Meaning multiple control plane apps can be allowed to
> > program different parts and even different tables - think multi-tier
> > pipeline.
> >
> >>> 3. Multi-user event subscribe/publish messaging
> >>
> >> Same here. What is the usecase for multiple users receiving p4 events?
> >
> > Same thing.
> > Note: Events are really not part of P4 but we added them for
> > flexibility - and as you well know they are useful.
> >
> >>> I dont think i need to provide an explanation on the differences here
> >>> visavis what ebpf system calls provide vs what netlink provides and
> >>> how netlink is a clear fit. If it is not clear i can give more
> >>
> >> It is not :/
> >
> > I thought it was obvious for someone like you, but fine - here goes for=
 those 3:
> >
> > 1. Msg construction/parsing: A lot of infra for sending attributes
> > back and forth is already built into netlink. I would have to create
> > mine from scratch for ebpf.  This will include not just the
> > construction/parsing but all the detailed attribute content policy
> > validations(even in the presence of hierarchies) that comes with it.
> > And not to forget the state transform between kernel and user space.
> >
> > 2. Multi-user request/response messaging
> > If you can write all the code for #1 above then this should work fine f=
or ebpf
> >
> > 3. Event publish subscribe
> > You would have to create mechanisms for ebpf which either are non
> > trivial or non complete: Example 1: you can put surgeries in the ebpf
> > code to look at map manipulations and then interface it to some event
> > management scheme which checks for subscribed users. Example 2: It may
> > also be feasible to create your own map for subscription vs something
> > like perf ring for event publication(something i have done in the
> > past), but that is also limited in many ways.
>
> I still don't think this answers all the questions on why the netlink
> shim layer. The kfuncs are essentially available to all of tc BPF and
> I don't think there was a discussion why they cannot be done generic
> in a way that they could benefit all tc/XDP BPF users. With the patch
> 14 you are more or less copying what is existing with {cls,act}_bpf
> just that you also allow XDP loading from tc(?). We do have existing
> interfaces for XDP program management.
>

I am not sure i followed - but we are open to suggestions to improve
operation usability.

> tc BPF and XDP already have widely used infrastructure and can be develop=
ed
> against libbpf or other user space libraries for a user space control pla=
ne.
> With 'control plane' you refer here to the tc / netlink shim you've built=
,
> but looking at the tc command line examples, this doesn't really provide =
a
> good user experience (you call it p4 but people load bpf obj files). If t=
he
> expectation is that an operator should run tc commands, then neither it's
> a nice experience for p4 nor for BPF folks. From a BPF PoV, we moved over
> to bpf_mprog and plan to also extend this for XDP to have a common look a=
nd
> feel wrt networking for developers. Why can't this be reused?

The filter loading which loads the program is considered pipeline
instantiation - consider it as "provisioning" more than "control"
which runs at runtime. "control" is purely netlink based. The iproute2
code we use links libbpf for example for the filter. If we can achieve
the same with bpf_mprog then sure - we just dont want to loose
functionality though.  off top of my head, some sample space:
- we could have multiple pipelines with different priorities (which tc
provides to us) - and each pipeline may have its own logic with many
tables etc (and the choice to iterate the next one is essentially
encoded in the tc action codes)
- we use tc block to map groups of ports (which i dont think bpf has
internal access of)

In regards to usability: no i dont expect someone doing things at
scale to use command line tc. The APIs are via netlink. But the tc cli
is must for the rest of the masses per our traditions. Also i really
didnt even want to use ebpf at all for operator experience reasons -
it requires a compilation of the code and an extra loading compared to
what our original u32/pedit code offered.

> I don't quite follow why not most of this could be implemented entirely i=
n
> user space without the detour of this and you would provide a developer
> library which could then be integrated into a p4 runtime/frontend? This
> way users never interface with ebpf parts nor tc given they also shouldn'=
t
> have to - it's an implementation detail. This is what John was also point=
ing
> out earlier.
>

Netlink is the API. We will provide a library for object manipulation
which abstracts away the need to know netlink. Someone who for their
own reasons wants to use p4runtime or TDI could write on top of this.
I would not design a kernel interface to just meet p4runtime (we
already have TDI which came later which does things differently). So i
expect us to support both those two. And if i was to do something on
SDN that was more robust i would write my own that still uses these
netlink interfaces.

> If you need notifications/subscribe mechanism for map updates, then this
> could be extended.. same way like BPF internals got extended along with t=
he
> sched_ext work, making the core pieces more useful also outside of the la=
tter.
>

Why? I already have this working great right now with netlink.

> The link to below slides are not public, so it's hard to see what is real=
ly
> meant here, but I have also never seen an email from the speaker on the B=
PF
> mailing list providing concrete feedback(?). People do build control plan=
es
> around BPF in the wild, I'm not sure where you take 'flush LEDs' from, to
> me this all sounds rather hand-wavy and trying to brute-force the fixatio=
n
> on netlink you went with that is raising questions. I don't think there w=
as
> objection on going with eBPF but rather all this infra for the former for
> a SW-only extension.

There are a handful of people who are holding the slides being
released (will go and chase them after this).

BTW, our experience in regards to usability for eBPF control plane is
the same as Ivan. I was listening to the talk and just nodding along.
You focused too much on the datapath and did a good job there but i am
afraid not so much on usability of the control path. My view is: to
create a back and forth with the kernel for something as complex as we
have using the ebpf system calls vs netlink, you would need to spend a
lot more developer resources in the ebpf case.  If you want to call
what i have a "the fixation on netlink" maybe you are fixated on ebpf
syscall?;->

cheers,
jamal


> [...]
> >>>>> I should note: that there was an interesting talk at netdevconf 0x1=
7
> >>>>> where the speaker showed the challenges of dealing with ebpf on "da=
y
> >>>>> two" - slides or videos are not up yet, but link is:
> >>>>> https://netdevconf.info/0x17/sessions/talk/is-scaling-ebpf-easy-yet=
-a-small-step-to-one-server-but-giant-leap-to-distributed-network.html
> >>>>> The point the speaker was making is it's always easy to whip an ebp=
f
> >>>>> program that can slice and dice packets and maybe even flush LEDs b=
ut
> >>>>> the real work and challenge is in the control plane. I agree with t=
he
> >>>>> speaker based on my experiences. This discussion of replacing netli=
nk
> >>>>> with ebpf system calls is absolutely a non-starter. Let's just end =
the
> >>>>> discussion and agree to disagree if you are going to keep insisting=
 on
> >>>>> that.

