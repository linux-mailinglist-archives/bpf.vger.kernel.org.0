Return-Path: <bpf+bounces-23281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBD686F6AA
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 20:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F391C20D3C
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 19:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9735079942;
	Sun,  3 Mar 2024 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="GnPQlLcL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434CC762EC
	for <bpf@vger.kernel.org>; Sun,  3 Mar 2024 19:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709492666; cv=none; b=NLOUIq5b9cNiA6UbEBbqWDArd12FfMu2G/eRcoR20ulOtiEckSsstCTrhzTTmD9zWAoEpIayP+2UW04bMTfySjSM3sCGTpY5aC0zOsmDu0am0DnAnpu5kgk70PAJ9vupkHLw9flEGpzTh2dKbIVrUR7LtxlG5Qc52bncATqcol4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709492666; c=relaxed/simple;
	bh=XqppKbV7x+ci9o0Cub5vVukerfIj86prevOCdxI9aTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEvBOgLbextkNQ7+6+lEEWtX914MOoPyb5AIq4BnDK/M08gFbQWNUIZCKfN6oicDZF2p5Pv8UR9M3XAVf6v4OGLas7ZwO7888MSGrzjTqldo/bBaLGR41e8dNCOfU1ClyL3Vt0mlpUev9iZOhsbd/Humy1tJyVc/bx94pv9Vlcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=GnPQlLcL; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so3261433276.1
        for <bpf@vger.kernel.org>; Sun, 03 Mar 2024 11:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709492663; x=1710097463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqNgFnLKTP93PR6cVdZ6fNlJHYat8XSThRpAWagOMXQ=;
        b=GnPQlLcLfO626b/YaQ+ADbyTziWSljoeBjNu267mTsLq/oGHOHAKhBZHIL/hNHOYSb
         1SRb9ZihpIzq3vnH/jl2EVh3bDPeX+8U/RMBwgd9Lz1aTrleFP4EsqedvbBJEeixJ9yq
         CJpve1Kd96ZEVkqTvJbn5ksa52oK3yV8+K1l9F/uhKndaEO5I77onqW0YIGFWmiiaBN8
         +XMaIVYIsliUy6A7ZaYnICLrtuk4CrURkPhqyZoqMqtMKuqGpWvzyRVKTl5E3K9zSBxS
         UT4AMSI96NjYKg+mz4TO08cf/+1VQDfrl6ORZiuzWF69vyBWbY7yFu3ukymKD9PxEPDV
         iMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709492663; x=1710097463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqNgFnLKTP93PR6cVdZ6fNlJHYat8XSThRpAWagOMXQ=;
        b=XfaQdSZWgNPVBRypGT3T4j4vnO3yCFoenRIZfh+UDB5xG5ZM13Sh7Z3B/cbhs08R8q
         bnHZ54o+HlojlCjarWLQGAcGgWSOiW80dghhT93r/qcR4sMEZ46i//TNVnkHvQ0Q3rZk
         EBbINfPZVSs7zb0UZl/FAY1DewjDursIlCjUPWyGUWl+7kkrItOCpKcSlk89Dq/F8GIA
         9UCl0Gmr3zujx9W4PyglJ+GpmjlglPcY72r1w8bGf7zfASs/kerTwUrL4moNT22QoWbj
         sRTaF6GIWiP3DrH3HHN/kZG0nE8byVk7BrOfiYSDxdFZ5AGmnbq84YWLH27NZuOZkpaj
         LbNg==
X-Forwarded-Encrypted: i=1; AJvYcCWHW6D6Rc5wjcMhOvKLjfQgVv0duNH8ql85XEEGBQpkjfcdeyM/oCh/5oJKeKNyb/mjFoiCQru0OwEmV3YunseQDTjv
X-Gm-Message-State: AOJu0YxLvQsFULR7TZ8pZupQUrNkk5Lv5bgH2nVnug81jKfSg4COWYWl
	Ff++uyw6HNZLdXBIq+mJ7Rplx2OBtnWrqdpQlHZUuBrdV9u5ZIcP6FMi2/VOYDJ/Ky7KJYWvBo9
	CgzRBs9wJ7eAscM1WzjK7l8ENKLha32QyeMLD
X-Google-Smtp-Source: AGHT+IEXYHwCWf7tKmk+LIkt9xBmoryKDpFjJ5oxsQxMZt9/0PsKn73bkhvRdIcyYXwMPp+nyv4nWA6GqQISNE/l6mw=
X-Received: by 2002:a25:d892:0:b0:dcc:a446:551 with SMTP id
 p140-20020a25d892000000b00dcca4460551mr4093063ybg.52.1709492663143; Sun, 03
 Mar 2024 11:04:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225165447.156954-1-jhs@mojatatu.com> <b28f2f7900dc7bad129ad67621b2f7746c3b2e18.camel@redhat.com>
 <CO1PR11MB49931E501B20F32681F917CD935F2@CO1PR11MB4993.namprd11.prod.outlook.com>
 <65e106305ad8b_43ad820892@john.notmuch> <CAM0EoM=r1UDnkp-csPdrz6nBt7o3fHUncXKnO7tB_rcZAcbrDg@mail.gmail.com>
 <CAOuuhY8qbsYCjdUYUZv8J3jz8HGXmtxLmTDP6LKgN5uRVZwMnQ@mail.gmail.com>
 <20240301090020.7c9ebc1d@kernel.org> <CAM0EoM=-hzSNxOegHqhAQD7qoAR2CS3Dyh-chRB+H7C7TQzmow@mail.gmail.com>
 <20240301173214.3d95e22b@kernel.org> <CAM0EoM=NEB25naGtz=YaOt6BDoiv4RpDw27Y=btMZAMGeYB5bg@mail.gmail.com>
 <CAM0EoM=8GG-zCaopaUDMkvqemrZQUtaVRTMrWA6z=xrdYxG9+g@mail.gmail.com>
 <20240302192747.371684fb@kernel.org> <CAM0EoMncuPvUsRwE+Ajojgg-8JD+1oJ7j2Rw+7oN60MjjAHV-g@mail.gmail.com>
 <CAOuuhY8pgxqCg5uTXzetTt5sd8RzOfLPYF8ksLjoUhkKyqr56w@mail.gmail.com>
In-Reply-To: <CAOuuhY8pgxqCg5uTXzetTt5sd8RzOfLPYF8ksLjoUhkKyqr56w@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 3 Mar 2024 14:04:11 -0500
Message-ID: <CAM0EoMnpZuC_fdzXj5+seXo3GT9rrf1txc45tB=gie4cf-Zqeg@mail.gmail.com>
Subject: Re: Hardware Offload discussion WAS(Re: [PATCH net-next v12 00/15]
 Introducing P4TC (series 1)
To: Tom Herbert <tom@sipanda.io>
Cc: Jakub Kicinski <kuba@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	"Singhai, Anjali" <anjali.singhai@intel.com>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, "Chatterjee, Deb" <deb.chatterjee@intel.com>, 
	"Limaye, Namrata" <namrata.limaye@intel.com>, Marcelo Ricardo Leitner <mleitner@redhat.com>, 
	"Shirshyad, Mahesh" <Mahesh.Shirshyad@amd.com>, "Jain, Vipin" <Vipin.Jain@amd.com>, 
	"Osinski, Tomasz" <tomasz.osinski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Khalid Manaa <khalidm@nvidia.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Victor Nogueira <victor@mojatatu.com>, 
	"Tammela, Pedro" <pctammela@mojatatu.com>, "Daly, Dan" <dan.daly@intel.com>, 
	Andy Fingerhut <andy.fingerhut@gmail.com>, "Sommers, Chris" <chris.sommers@keysight.com>, 
	Matty Kadosh <mattyk@nvidia.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 1:11=E2=80=AFPM Tom Herbert <tom@sipanda.io> wrote:
>
> On Sun, Mar 3, 2024 at 9:00=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
> >
> > On Sat, Mar 2, 2024 at 10:27=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Sat, 2 Mar 2024 09:36:53 -0500 Jamal Hadi Salim wrote:
> > > > 2) Your point on:  "integrate later", or at least "fill in the gaps=
"
> > > > This part i am probably going to mumble on. I am going to consider
> > > > more than just doing ACLs/MAT via flower/u32 for the sake of
> > > > discussion.
> > > > True, "fill the gaps" has been our model so far. It requires kernel
> > > > changes, user space code changes etc justifiably so because most of
> > > > the time such datapaths are subject to standardization via IETF, IE=
EE,
> > > > etc and new extensions come in on a regular basis.  And sometimes w=
e
> > > > do add features that one or two users or a single vendor has need f=
or
> > > > at the cost of kernel and user/control extension. Given our work
> > > > process, any features added this way take a long time to make it to
> > > > the end user.
> > >
> > > What I had in mind was more of a DDP model. The device loads it binar=
y
> > > blob FW in whatever way it does, then it tells the kernel its parser
> > > graph, and tables. The kernel exposes those tables to user space.
> > > All dynamic, no need to change the kernel for each new protocol.
> > >
> > > But that's different in two ways:
> > >  1. the device tells kernel the tables, no "dynamic reprogramming"
> > >  2. you don't need the SW side, the only use of the API is to interac=
t
> > >     with the device
> > >
> > > User can still do BPF kfuncs to look up in the tables (like in FIB),
> > > but call them from cls_bpf.
> > >
> >
> > This is not far off from what is envisioned today in the discussions.
> > The main issue is who loads the binary? We went from devlink to the
> > filter doing the loading. DDP is ethtool. We still need to tie a PCI
> > device/tc block to the "program" so we can do skip_sw and it works.
> > Meaning a device that is capable of handling multiple programs can
> > have multiple blobs loaded. A "program" is mapped to a tc filter and
> > MAT control works the same way as it does today (netlink/tc ndo).
> >
> > A program in P4 has a name, ID and people have been suggesting a sha1
> > identity (or a signature of some kind should be generated by the
> > compiler). So the upward propagation could be tied to discovering
> > these 3 tuples from the driver. Then the control plane targets a
> > program via those tuples via netlink (as we do currently).
> >
> > I do note, using the DDP sample space, currently whatever gets loaded
> > is "trusted" and really you need to have human knowledge of what the
> > NIC's parsing + MAT is to send the control. With P4 that is all
> > visible/programmable by the end user (i am not a proponent of vendors
> > "shipping" things or calling them for support) - so should be
> > sufficient to just discover what is in the binary and send the correct
> > control messages down.
> >
> > > I think in P4 terms that may be something more akin to only providing
> > > the runtime API? I seem to recall they had some distinction...
> >
> > There are several solutions out there (ex: TDI, P4runtime) - our API
> > is netlink and those could be written on top of netlink, there's no
> > controversy there.
> > So the starting point is defining the datapath using P4, generating
> > the binary blob and whatever constraints needed using the vendor
> > backend and for s/w equivalent generating the eBPF datapath.
> >
> > > > At the cost of this sounding controversial, i am going
> > > > to call things like fdb, fib, etc which have fixed datapaths in the
> > > > kernel "legacy". These "legacy" datapaths almost all the time have
> > >
> > > The cynic in me sometimes thinks that the biggest problem with "legac=
y"
> > > protocols is that it's hard to make money on them :)
> >
> > That's a big motivation without a doubt, but also there are people
> > that want to experiment with things. One of the craziest examples we
> > have is someone who created a P4 program for "in network calculator",
> > essentially a calculator in the datapath. You send it two operands and
> > an operator using custom headers, it does the math and responds with a
> > result in a new header. By itself this program is a toy but it
> > demonstrates that if one wanted to, they could have something custom
> > in hardware and/or kernel datapath.
>
> Jamal,
>
> Given how long P4 has been around it's surprising that the best
> publicly available code example is "the network calculator" toy.

Come on Tom ;-> That was just an example of something "crazy" to
demonstrate freedom. I can run that in any of the P4 friendly NICs
today. You are probably being facetious - There are some serious
publicly available projects out there, some of which I quote on the
cover letter (like DASH).

> At
> this point in its lifetime, eBPF had far more examples of real world
> use cases publically available. That being said, there's nothing
> unique about P4 supporting the network calculator. We could just as
> easily write this in eBPF (either plain C or P4)  and "offload" it to
> an ARM core on a SmartNIC.

With current port speeds hitting 800gbps you want to use Arm cores as
your offload engine?;-> Running the generated ebpf on the arm core is
a valid P4 target.  i.e there is no contradiction.
Note: P4 is a DSL specialized for datapath definition; it is not a
competition to ebpf, two different worlds. I see ebpf as an
infrastructure tool, nothing more.

> If we are going to support programmable device offload in the Linux
> kernel then I maintain it should be a generic mechanism that's
> agnostic to *both* the frontend programming language as well as the
> backend target. For frontend languages we want to let the user program
> in a language that's convenient for *them*, which honestly in most
> cases isn't going to be a narrow use case DSL (i.e. typically users
> want to code in C/C++, Python, Rust, etc.).

You and I have never agreed philosophically on this point, ever.
Developers are expensive and not economically scalable. IOW, In the
era of automation (generative AI, etc) tooling is king. Let's build
the right tooling. Whenever you make this statement  i get the vision
of Steve Balmer ranting on the stage with "developers! developers!
developers!" but that was eons ago. To use your strong view: Learn
compilers! And the future is probably to replace compilers with AI.

> For the backend it's the
> same story, maybe we're compiling to run in host, maybe we're
> offloading to P4 runtime, maybe we're offloading to another CPU, maybe
> we're offloading some other programmable NPU. The only real
> requirement is a compiler that can take the frontend code and compile
> for the desired backend target, but above all we want this to be easy
> for the programmer, the compiler needs to do the heavy lifting and we
> should never require the user to understand the nuances of a target.
>

Agreed, it is possible to use other languages in the frontend. It is
also possible to extend P4.

> IMO, the model we want for programmable kernel offload is "write once,
> run anywhere, run well". Which is the Java tagline amended with "run
> well". Users write one program for their datapath processing, it runs
> on various targets, for any given target we run to run at the highest
> performance levels possible given the target's capabilities.
>

I would like to emphasize: Our target is P4 - vendors have put out
hardware, people are deploying and evolving things. It is real today
with deployments, not some science project. I am not arguing you cant
do what you suggested but we want to initially focus on P4. Neither am
i saying we cant influence P4 to be more Linux friendly. But none of
that matters. We are only concerned about P4.

cheers,
jamal



> Tom
>
> >
> > cheers,
> > jamal

