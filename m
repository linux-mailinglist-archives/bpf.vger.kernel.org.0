Return-Path: <bpf+bounces-22905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F28C86B718
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 19:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21791C22350
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 18:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E404085D;
	Wed, 28 Feb 2024 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="iV5oq4gh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA8479B8A
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144595; cv=none; b=uFFd9lDKJ2OIerU+CL1pTqyhyO3YE/PrMVhczWi48NfDUn1IA0I+1aiH2CTJa9JoSlhqP3AJIT9MrAxa7MCa6P7lgG6bQ+RGyTyMkLN94dtDNUumAP4UCe5Y5H5AhhSufMLMuDbjZ8AigOi92VVtOt/AdiJbJ6z66aT7NyA8pLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144595; c=relaxed/simple;
	bh=zsrdCS5y76bwNxLL5UqrwB/EQGALndb7rbLxwWuRF0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/mF+fOe/m/rUBqkOf+ea+Xk7exQ42MXTyudNDkh6RIZGkwQlddiUrZTOJxRR9bmvN/u9veHabAGcThX+SY8fk+fPAiz77lESVwTM46Lbd0/8fsDQmrnD8bhWQ13u1Xoqw1WF0EsA+Ai0klX3RF5P3Cb1SN7bfI3q5S9Ai0erss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=iV5oq4gh; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-607e60d01b2so346847b3.1
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 10:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709144592; x=1709749392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIc191yKzZ9Pu6BA8s2ctP8z+EsNM+wZ8kXhN0UMYeg=;
        b=iV5oq4ghtZXdcOZpHC0jWMXzm3xgES6NVwmi2nmINSuhstkwZAWrTeGZKfEw8IFb7R
         RcD4899eQU/EIZ1CBNxIUgc4gSCU53zfxOqA6Fnt/KLND3ZSDuVlWQHb8BPIF7OzuQEZ
         rquU3DeAmrAlWZGf35/+t689mKDS/wiLK59LqVr77VhnbX8z9OIoxt/q3NJZFfJylKZq
         Ms+sAhHDw6dRdgNA+MoMf2ssDBzMCdlVPPEWk2zGqINf1iTlJqBqnC/QVyfct3DOrrYW
         azii0V8+31O4nyqCWGcCPmC2th1wXHIz9nlhnsG9mkfTmDj88pUKGH+JmfmV29VRU5D2
         pSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709144592; x=1709749392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIc191yKzZ9Pu6BA8s2ctP8z+EsNM+wZ8kXhN0UMYeg=;
        b=nq0tiwaNeaMRezWkegfx+lr2lbHqbeD899zfpuHwecUehxC2Da7ULoDKahYCu4bJ9X
         THKzsUKQdzdSVD1L03esz/a64RGzexDvmha1vRcjOtXLD5zHMzUo4I+9lv1dfz/yRBk2
         REsxI+CJAXWWWBK0IknzAUfrFwbrTXsZBomew9e5saH8FI/4qzRh27uV/EdpXdRbVDQY
         oiPSPwgI9Fit+XPZaf8jlQvo+jSo3wB4RlKwNPHH6RlnECuRS9mFTOLasjih7wlrF/we
         CFtYFwoLT5FuZTmHzyDehcdD2ktnqbzExYqcmmEQo0montgitUFc+UbNQqVG5WL18Hdq
         8X5g==
X-Forwarded-Encrypted: i=1; AJvYcCWEklp0V2HaBgjrgfnHEadGvuvaFWkj5XC8vD8bcShqntWMWDOcBtuU7tyBnnFUVHmiqUuH4mh6x/bWXWJkjFV+yt8f
X-Gm-Message-State: AOJu0Yyt+K1SUjM4JLRF3uvgj+X1W/F9dYMMv1o8EHr9XGUN4ZR7XiyC
	SvKkDfzUC8uqBXTWWbJX5nQ4z4AoSj8SKbYeoQ9WBbAOUEWrcztdWDiDzmI4BiaJLSw0I/GrHKK
	RvsWOY+SOLhL6xHX5i8iNifdxae6nAADMhM6q
X-Google-Smtp-Source: AGHT+IGgslyBRRT930p9yktxdqRF3HXEfgavgTTEfPpVQVQpVNcpsjpWZMAI7rUP9oKoBkRZhxZUskIfmKcQw2yegoA=
X-Received: by 2002:a05:690c:97:b0:608:e2da:30b9 with SMTP id
 be23-20020a05690c009700b00608e2da30b9mr6286839ywb.50.1709144592320; Wed, 28
 Feb 2024 10:23:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225165447.156954-1-jhs@mojatatu.com> <65df6935db67e_2a12e2083b@john.notmuch>
In-Reply-To: <65df6935db67e_2a12e2083b@john.notmuch>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 28 Feb 2024 13:23:00 -0500
Message-ID: <CAM0EoMnMrOAZ1iGocDDhVmoeY33fxZjiUEQc4yp0KJj8nASrAA@mail.gmail.com>
Subject: Re: [PATCH net-next v12 00/15] Introducing P4TC (series 1)
To: John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, tomasz.osinski@intel.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com, 
	horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, daniel@iogearbox.net, 
	victor@mojatatu.com, pctammela@mojatatu.com, dan.daly@intel.com, 
	andy.fingerhut@gmail.com, chris.sommers@keysight.com, mattyk@nvidia.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:11=E2=80=AFPM John Fastabend
<john.fastabend@gmail.com> wrote:
>
> Jamal Hadi Salim wrote:
> > This is the first patchset of two. In this patch we are submitting 15 w=
hich
> > cover the minimal viable P4 PNA architecture.
> >
> > __Description of these Patches__
> >
> > Patch #1 adds infrastructure for per-netns P4 actions that can be creat=
ed on
> > as need basis for the P4 program requirement. This patch makes a small =
incision
> > into act_api. Patches 2-4 are minimalist enablers for P4TC and have no
> > effect the classical tc action (example patch#2 just increases the size=
 of the
> > action names from 16->64B).
> > Patch 5 adds infrastructure support for preallocation of dynamic action=
s.
> >
> > The core P4TC code implements several P4 objects.
> > 1) Patch #6 introduces P4 data types which are consumed by the rest of =
the code
> > 2) Patch #7 introduces the templating API. i.e. CRUD commands for templ=
ates
> > 3) Patch #8 introduces the concept of templating Pipelines. i.e CRUD co=
mmands
> >    for P4 pipelines.
> > 4) Patch #9 introduces the action templates and associated CRUD command=
s.
> > 5) Patch #10 introduce the action runtime infrastructure.
> > 6) Patch #11 introduces the concept of P4 table templates and associate=
d
> >    CRUD commands for tables.
> > 7) Patch #12 introduces runtime table entry infra and associated CU com=
mands.
> > 8) Patch #13 introduces runtime table entry infra and associated RD com=
mands.
> > 9) Patch #14 introduces interaction of eBPF to P4TC tables via kfunc.
> > 10) Patch #15 introduces the TC classifier P4 used at runtime.
> >
> > Daniel, please look again at patch #15.
> >
> > There are a few more patches (5) not in this patchset that deal with te=
st
> > cases, etc.
> >
> > What is P4?
> > -----------
> >
> > The Programming Protocol-independent Packet Processors (P4) is an open =
source,
> > domain-specific programming language for specifying data plane behavior=
.
> >
> > The current P4 landscape includes an extensive range of deployments, pr=
oducts,
> > projects and services, etc[9][12]. Two major NIC vendors, Intel[10] and=
 AMD[11]
> > currently offer P4-native NICs. P4 is currently curated by the Linux
> > Foundation[9].
> >
> > On why P4 - see small treatise here:[4].
> >
> > What is P4TC?
> > -------------
> >
> > P4TC is a net-namespace aware P4 implementation over TC; meaning, a P4 =
program
> > and its associated objects and state are attachend to a kernel _netns_ =
structure.
> > IOW, if we had two programs across netns' or within a netns they have n=
o
> > visibility to each others objects (unlike for example TC actions whose =
kinds are
> > "global" in nature or eBPF maps visavis bpftool).
>
> [...]
>
> Although I appreciate a good amount of work went into building above I'll
> add my concerns here so they are not lost. These are architecture concern=
s
> not this line of code needs some tweak.
>
>  - It encodes a DSL into the kernel. Its unclear how we pick which DSL ge=
ts
>    pushed into the kernel and which do not. Do we take any DSL folks can =
code
>    up?
>    I would prefer a lower level  intermediate langauge. My view is this i=
s
>    a lesson we should have learned from OVS. OVS had wider adoption and
>    still struggled in some ways my belief is this is very similar to OVS.
>    (Also OVS was novel/great at a lot of things fwiw.)
>
>  - We have a general purpose language in BPF that can implement the P4 DS=
L
>    already. I don't see any need for another set of code when the end goa=
l
>    is running P4 in Linux network stack is doable. Typically we reject
>    duplicate things when they don't have concrete benefits.
>
>  - P4 as a DSL is not optimized for general purpose CPUs, but
>    rather hardware pipelines. Although it can be optimized for CPUs its
>    a harder problem. A review of some of the VPP/DPDK work here is useful=
.
>
>  - P4 infrastructure already has a p4c backend this is adding another P4
>    backend instead of getting the rather small group of people to work on
>    a single backend we are now creating another one.
>
>  - Common reasons I think would justify a new P4 backend and implementati=
on
>    would be: speed efficiency, or expressiveness. I think this
>    implementation is neither more efficient nor more expressive. Concrete
>    examples on expressiveness would be interesting, but I don't see any.
>    Loops were mentioned once but latest kernels have loop support.
>
>  - The main talking point for many slide decks about p4tc is hardware
>    offload. This seems like the main benefit of pushing the P4 DSL into t=
he
>    kernel. But, we have no hw implementation, not even a vendor stepping =
up
>    to comment on this implementation and how it will work for them. HW
>    introduces all sorts of interesting problems that I don't see how we
>    solve in this framework. For example a few off the top of my head:
>    syncing current state into tc, how does operator program tc inside
>    constraints, who writes the p4 models for these hardware devices, do
>    they fit into this 'tc' infrastructure, partial updates into hardware
>    seems unlikely to work for most hardware, ...
>
>  - The kfuncs are mostly duplicates of map ops we already have in BPF API=
.
>    The motivation by my read is to use netlink instead of bpf commands. I
>    don't agree with this, optimizing for some low level debug a developer
>    uses is the wrong design space. Actual users should not be deploying
>    this via ssh into boxes. The workflow will not scale and really we nee=
d
>    tooling and infra to land P4 programs across the network. This is orde=
rs
>    of more pain if its an endpoint solution and not a middlebox/switch
>    solution. As a switch solution I don't see how p4tc sw scales to even =
TOR
>    packet rates. So you need tooling on top and user interact with the
>    tooling not the Linux widget/debugger at the bottom.
>
>  - There is no performance analysis: The comment was functionality before
>    performance which I disagree with. If it was a first implementation an=
d
>    we didn't have a way to do P4 DSL already than I might agree, but here
>    we have an existing solution so it should be at least as good and shou=
ld
>    be better than existing backend. A software datapath adoption is going
>    to be critically based on performance. I don't see taking even a 5% hi=
t
>    when porting over to P4 from existing datapath.
>
> Commentary: I think its 100% correct to debate how the P4 DSL is
> implemented in the kernel. I can't see why this is off limits somehow thi=
s
> patch set proposes an approach there could be many approaches. BPF comes =
up
> not because I'm some BPF zealot that needs P4 DSL in BPF, but because it
> exists today there is even a P4 backend. Fundamentally I don't see the
> value add we get by creating two P4 pipelines this is going to create
> duplication all the way up to the P4 tooling/infra through to the kernel.
> From your side you keep saying I'm bike shedding and demanding BPF, but
> from my perspective your introducing another entire toolchain simply
> because you want some low level debug commands that 99% of P4 users shoul=
d
> not be using or caring about.
>
> To try and be constructive some things that would change my mind would
> be a vendor showing how hardware can be used. This would be compelling.
> Or performance showing its somehow gets a more performant implementation.
> Or lastly if the current p4c implementation is fundamentally broken
> somehow.
>

John,
With all due respect we are going back again over the same points,
recycled many times over to which i have responded to you many times.
It's gettting tiring.  This is exactly why i called it bikeshedding.
Let's just agree to disagree.

cheers,
jamal

> Thanks
> John

