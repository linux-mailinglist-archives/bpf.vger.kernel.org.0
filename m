Return-Path: <bpf+bounces-22925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A4F86B9B1
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 22:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755C61F262FB
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 21:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84BA7003A;
	Wed, 28 Feb 2024 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCH830rX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91FC86264;
	Wed, 28 Feb 2024 21:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709154795; cv=none; b=e7VyAF7ywEU5a+smTueFcIzE8/gWe1Ubt8BWfKW8ANm6visRP3Vt7YRVP3N1w0IP47rYFoRkAewbPLQH21Oa11gZF5IZK8aALM269bqjCUR4QaaPc89mof0lVGIrJZd0IG5CFszDQeFiJaJAtAAwtKNBOIns8J6oiOLwLBhDu3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709154795; c=relaxed/simple;
	bh=ZRuRIsMpD/qNiI4RajYL+i1p5TZOP2DQdTRWpedwetE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dydvrZpRTAbjHl0S4NZCHMM0J+LCsfdoS/ucbHIJnIQkaWTt5LtZCsHH91K6GO5DtFWRNnzt/OEFKfdrD+iWQKh4ZJestDxw3+afRqFy4VGlfouyA9Qj2y/xjLIcOco50RuIHjcoFegdWMQnfiAFPdQrce1COaJAATyVjFD+gMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCH830rX; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-299d3b09342so101532a91.2;
        Wed, 28 Feb 2024 13:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709154793; x=1709759593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GY/HrwWaBwZhe3j8OEXaoWSbdjtDuL8LBjhse5O8BB0=;
        b=aCH830rXxGyZDRUCLwZf3/rqQMpRSTq3vYHToFb8qKNTCHgYFBkcDSHDP0uOFM1W7f
         Dw6ziIMlVfM+2JYtMwUyWmUyN7e7FEH0TuBgsoBE6HEoIqXZxuvEScWfb2LZ+Ft0+F59
         j+Y60OrVE8iFKTq0m3zwLnnq/F0x+D/lx4de441NhmYNEEge+ISchkg3JOZ/FIdTqW1B
         pNoSMgHRe2eOOX/eeS9zcW2FGOoKDMD1EzctWuJRXO53ZZ5BT9XojMvFoG8rkaZp5DvJ
         xSu6ildFBkr+P01c0hJIQOrdLIVA3cGBuqy0XDvf6G00t3Vr6MIqJy7jiuJSi0E3cbsa
         GfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709154793; x=1709759593;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GY/HrwWaBwZhe3j8OEXaoWSbdjtDuL8LBjhse5O8BB0=;
        b=V3YWEEZp124LUI000AcnPUF1S3/YFfx4nLNGA5Z8GfRXy/+LkKfsrnDVqG9kEFvXGq
         /5CINyaexTau4DikeOfdiMZJS/WziD3N+wxbKZufx0ei/pGSD0izQ0E8oDfVYXyREOif
         MPHI8kYQvs95F8s2TahomVim68WcnJDKAmGLIfq74mSmcRl5YpenxviitRjp2XDIvNrl
         LgMgEldGmdYGBETGna6Tz3Rtp0OFahyEtsOFmLUiTjcBEYjmrbGPZ+a5nhVYETLtmbQb
         3TUjYK/VXnpFoc4nGtMRuCJ5fMkwpIKpSVv1JZ6ZnOtXe5QoTiQeyrqvYpm8lQWAmaSx
         r1JA==
X-Forwarded-Encrypted: i=1; AJvYcCVL+9Ank4pPSxeldMpcrrL4gzvzVNxEpVUmylgfHGLzs+y0xoLdMfAcgShou9j8sWFGv3Cet9NlZ4TT/4u1mWVJREMi
X-Gm-Message-State: AOJu0YyY6YLeDPxlt8uhrbdvFs8pIiVBPdeQH9mzITJt3Itv06yu215W
	o7u9GYk2XJWvr2ofG+6IhAyRSZUzH9syrBv1bRNAIS+gv4Aad+3g
X-Google-Smtp-Source: AGHT+IFI16FqIxaWxFZ9p9cpjTVJZDX3eJ9SDb+uSqYhBrOJRdqE7pBlVEhW0kgSI5ltMCGUIQYafA==
X-Received: by 2002:a17:90b:795:b0:29a:8b5a:892a with SMTP id l21-20020a17090b079500b0029a8b5a892amr331490pjz.39.1709154792819;
        Wed, 28 Feb 2024 13:13:12 -0800 (PST)
Received: from localhost ([98.97.43.160])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090ad48c00b0029aac9c523fsm2131pju.47.2024.02.28.13.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 13:13:12 -0800 (PST)
Date: Wed, 28 Feb 2024 13:13:08 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, 
 deb.chatterjee@intel.com, 
 anjali.singhai@intel.com, 
 namrata.limaye@intel.com, 
 tom@sipanda.io, 
 mleitner@redhat.com, 
 Mahesh.Shirshyad@amd.com, 
 Vipin.Jain@amd.com, 
 tomasz.osinski@intel.com, 
 jiri@resnulli.us, 
 xiyou.wangcong@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 vladbu@nvidia.com, 
 horms@kernel.org, 
 khalidm@nvidia.com, 
 toke@redhat.com, 
 daniel@iogearbox.net, 
 victor@mojatatu.com, 
 pctammela@mojatatu.com, 
 dan.daly@intel.com, 
 andy.fingerhut@gmail.com, 
 chris.sommers@keysight.com, 
 mattyk@nvidia.com, 
 bpf@vger.kernel.org
Message-ID: <65dfa1e4aee1b_2beb32081c@john.notmuch>
In-Reply-To: <CAM0EoMnMrOAZ1iGocDDhVmoeY33fxZjiUEQc4yp0KJj8nASrAA@mail.gmail.com>
References: <20240225165447.156954-1-jhs@mojatatu.com>
 <65df6935db67e_2a12e2083b@john.notmuch>
 <CAM0EoMnMrOAZ1iGocDDhVmoeY33fxZjiUEQc4yp0KJj8nASrAA@mail.gmail.com>
Subject: Re: [PATCH net-next v12 00/15] Introducing P4TC (series 1)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jamal Hadi Salim wrote:
> On Wed, Feb 28, 2024 at 12:11=E2=80=AFPM John Fastabend
> <john.fastabend@gmail.com> wrote:
> >
> > Jamal Hadi Salim wrote:
> > > This is the first patchset of two. In this patch we are submitting =
15 which
> > > cover the minimal viable P4 PNA architecture.
> > >
> > > __Description of these Patches__
> > >
> > > Patch #1 adds infrastructure for per-netns P4 actions that can be c=
reated on
> > > as need basis for the P4 program requirement. This patch makes a sm=
all incision
> > > into act_api. Patches 2-4 are minimalist enablers for P4TC and have=
 no
> > > effect the classical tc action (example patch#2 just increases the =
size of the
> > > action names from 16->64B).
> > > Patch 5 adds infrastructure support for preallocation of dynamic ac=
tions.
> > >
> > > The core P4TC code implements several P4 objects.
> > > 1) Patch #6 introduces P4 data types which are consumed by the rest=
 of the code
> > > 2) Patch #7 introduces the templating API. i.e. CRUD commands for t=
emplates
> > > 3) Patch #8 introduces the concept of templating Pipelines. i.e CRU=
D commands
> > >    for P4 pipelines.
> > > 4) Patch #9 introduces the action templates and associated CRUD com=
mands.
> > > 5) Patch #10 introduce the action runtime infrastructure.
> > > 6) Patch #11 introduces the concept of P4 table templates and assoc=
iated
> > >    CRUD commands for tables.
> > > 7) Patch #12 introduces runtime table entry infra and associated CU=
 commands.
> > > 8) Patch #13 introduces runtime table entry infra and associated RD=
 commands.
> > > 9) Patch #14 introduces interaction of eBPF to P4TC tables via kfun=
c.
> > > 10) Patch #15 introduces the TC classifier P4 used at runtime.
> > >
> > > Daniel, please look again at patch #15.
> > >
> > > There are a few more patches (5) not in this patchset that deal wit=
h test
> > > cases, etc.
> > >
> > > What is P4?
> > > -----------
> > >
> > > The Programming Protocol-independent Packet Processors (P4) is an o=
pen source,
> > > domain-specific programming language for specifying data plane beha=
vior.
> > >
> > > The current P4 landscape includes an extensive range of deployments=
, products,
> > > projects and services, etc[9][12]. Two major NIC vendors, Intel[10]=
 and AMD[11]
> > > currently offer P4-native NICs. P4 is currently curated by the Linu=
x
> > > Foundation[9].
> > >
> > > On why P4 - see small treatise here:[4].
> > >
> > > What is P4TC?
> > > -------------
> > >
> > > P4TC is a net-namespace aware P4 implementation over TC; meaning, a=
 P4 program
> > > and its associated objects and state are attachend to a kernel _net=
ns_ structure.
> > > IOW, if we had two programs across netns' or within a netns they ha=
ve no
> > > visibility to each others objects (unlike for example TC actions wh=
ose kinds are
> > > "global" in nature or eBPF maps visavis bpftool).
> >
> > [...]
> >
> > Although I appreciate a good amount of work went into building above =
I'll
> > add my concerns here so they are not lost. These are architecture con=
cerns
> > not this line of code needs some tweak.
> >
> >  - It encodes a DSL into the kernel. Its unclear how we pick which DS=
L gets
> >    pushed into the kernel and which do not. Do we take any DSL folks =
can code
> >    up?
> >    I would prefer a lower level  intermediate langauge. My view is th=
is is
> >    a lesson we should have learned from OVS. OVS had wider adoption a=
nd
> >    still struggled in some ways my belief is this is very similar to =
OVS.
> >    (Also OVS was novel/great at a lot of things fwiw.)
> >
> >  - We have a general purpose language in BPF that can implement the P=
4 DSL
> >    already. I don't see any need for another set of code when the end=
 goal
> >    is running P4 in Linux network stack is doable. Typically we rejec=
t
> >    duplicate things when they don't have concrete benefits.
> >
> >  - P4 as a DSL is not optimized for general purpose CPUs, but
> >    rather hardware pipelines. Although it can be optimized for CPUs i=
ts
> >    a harder problem. A review of some of the VPP/DPDK work here is us=
eful.
> >
> >  - P4 infrastructure already has a p4c backend this is adding another=
 P4
> >    backend instead of getting the rather small group of people to wor=
k on
> >    a single backend we are now creating another one.
> >
> >  - Common reasons I think would justify a new P4 backend and implemen=
tation
> >    would be: speed efficiency, or expressiveness. I think this
> >    implementation is neither more efficient nor more expressive. Conc=
rete
> >    examples on expressiveness would be interesting, but I don't see a=
ny.
> >    Loops were mentioned once but latest kernels have loop support.
> >
> >  - The main talking point for many slide decks about p4tc is hardware=

> >    offload. This seems like the main benefit of pushing the P4 DSL in=
to the
> >    kernel. But, we have no hw implementation, not even a vendor stepp=
ing up
> >    to comment on this implementation and how it will work for them. H=
W
> >    introduces all sorts of interesting problems that I don't see how =
we
> >    solve in this framework. For example a few off the top of my head:=

> >    syncing current state into tc, how does operator program tc inside=

> >    constraints, who writes the p4 models for these hardware devices, =
do
> >    they fit into this 'tc' infrastructure, partial updates into hardw=
are
> >    seems unlikely to work for most hardware, ...
> >
> >  - The kfuncs are mostly duplicates of map ops we already have in BPF=
 API.
> >    The motivation by my read is to use netlink instead of bpf command=
s. I
> >    don't agree with this, optimizing for some low level debug a devel=
oper
> >    uses is the wrong design space. Actual users should not be deployi=
ng
> >    this via ssh into boxes. The workflow will not scale and really we=
 need
> >    tooling and infra to land P4 programs across the network. This is =
orders
> >    of more pain if its an endpoint solution and not a middlebox/switc=
h
> >    solution. As a switch solution I don't see how p4tc sw scales to e=
ven TOR
> >    packet rates. So you need tooling on top and user interact with th=
e
> >    tooling not the Linux widget/debugger at the bottom.
> >
> >  - There is no performance analysis: The comment was functionality be=
fore
> >    performance which I disagree with. If it was a first implementatio=
n and
> >    we didn't have a way to do P4 DSL already than I might agree, but =
here
> >    we have an existing solution so it should be at least as good and =
should
> >    be better than existing backend. A software datapath adoption is g=
oing
> >    to be critically based on performance. I don't see taking even a 5=
% hit
> >    when porting over to P4 from existing datapath.
> >
> > Commentary: I think its 100% correct to debate how the P4 DSL is
> > implemented in the kernel. I can't see why this is off limits somehow=
 this
> > patch set proposes an approach there could be many approaches. BPF co=
mes up
> > not because I'm some BPF zealot that needs P4 DSL in BPF, but because=
 it
> > exists today there is even a P4 backend. Fundamentally I don't see th=
e
> > value add we get by creating two P4 pipelines this is going to create=

> > duplication all the way up to the P4 tooling/infra through to the ker=
nel.
> > From your side you keep saying I'm bike shedding and demanding BPF, b=
ut
> > from my perspective your introducing another entire toolchain simply
> > because you want some low level debug commands that 99% of P4 users s=
hould
> > not be using or caring about.
> >
> > To try and be constructive some things that would change my mind woul=
d
> > be a vendor showing how hardware can be used. This would be compellin=
g.
> > Or performance showing its somehow gets a more performant implementat=
ion.
> > Or lastly if the current p4c implementation is fundamentally broken
> > somehow.
> >
> =

> John,
> With all due respect we are going back again over the same points,
> recycled many times over to which i have responded to you many times.
> It's gettting tiring.  This is exactly why i called it bikeshedding.
> Let's just agree to disagree.

Yep we agree to disagree and I put them them as a summary so others
can see them and think it over/decide where they stand on it. In the
end you don't need my ACK here, but I wanted my opinion summarized.

> =

> cheers,
> jamal
> =

> > Thanks
> > John



