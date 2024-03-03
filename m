Return-Path: <bpf+bounces-23280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF31286F689
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 19:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D27628184B
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 18:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8B1768E7;
	Sun,  3 Mar 2024 18:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipanda-io.20230601.gappssmtp.com header.i=@sipanda-io.20230601.gappssmtp.com header.b="g2Dv1F21"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FAB76402
	for <bpf@vger.kernel.org>; Sun,  3 Mar 2024 18:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709489467; cv=none; b=P/+YqhG3BROra1EA+2oPvJ1Q4XMjXGbvDwdEnqRMZl34dLQMzyf0JvfvdinhIYaHBbnO9y5cT6eBVgtWVlFlLjNJQ1HV0znfhT1lJxav635HIE8mVNN+ky0/mf4wM3xS5q/+8aG/XwoWRJM8gXkR29QXiOlqB9hb1FwH3ktqLEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709489467; c=relaxed/simple;
	bh=d3ilUZHVXqccTa4nuolP8oFgdKje9LdymyI05oYzUoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMtrrCPM+sVKoE0urWlBEZhInuwdYXjB7zuqdZTZigFbdxb7jP7R4/t1dpxnMXwGGdt2sRuy2LBpvf6nSACDQ6pI3cudVwqC/6Kr055NEbR6hmWcgsoCZET2fWZ0ZQRX2OkphDO1tCWIC9ZlX3GqtnP4QdA6+UiWlY9Iv9x33ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sipanda.io; spf=pass smtp.mailfrom=sipanda.io; dkim=pass (2048-bit key) header.d=sipanda-io.20230601.gappssmtp.com header.i=@sipanda-io.20230601.gappssmtp.com header.b=g2Dv1F21; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sipanda.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipanda.io
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e4d2ba940dso766059a34.3
        for <bpf@vger.kernel.org>; Sun, 03 Mar 2024 10:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sipanda-io.20230601.gappssmtp.com; s=20230601; t=1709489463; x=1710094263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0h1sFuFMOTp+w/vSJygUlgoMZyE2IQrnfWCMK6O9dBA=;
        b=g2Dv1F21lPyphezsXwVzFlzGf4sjF3zp0z27lZxPPTz6IqQKETxaHPfqvP0ccU06ZP
         /5qzLIQn0zoNC+UwktUot43No58gtxpkCoJI5yCt20bWiS2RzG61Lulu8U3WoF+RYVxp
         kP7cPQcMsWqj3saC6iG9szImDeY+VLMl9XuESID8aw50YRBu6b89AU+ei5lZJLbLLNSB
         wIGY63VhE8qwnPv3czsZSZU2L+bK464c5C+H9uPTnuR0v2blArK6F6Yz1jjSEdPMoERj
         FfKzTFvrxZFjROd+NOiT9ib0RvofTZvMhV0MMGtynSnUqj/n38ku3BRicvJofh+iTNbD
         zEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709489463; x=1710094263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0h1sFuFMOTp+w/vSJygUlgoMZyE2IQrnfWCMK6O9dBA=;
        b=vqMrOD+a+yYI9373IdyF2fOnznrBMxHabwCu66Qe3+H63mFISFS7IqtV4uh09ILtif
         Suk+B9dK7vU6i3fZoFRR2j/8LrqKVJWcFIrwHiVp49yfDyDdbm6L/uapNoF16i36ky8E
         mP77z/rYTlYsmGYXAqrdXtYb3PlZmuqaPR1hIrxdEHaZiLObERXrFQbGjG8UE0VcUCp3
         I4+B5PtGKvpQHCvyHg9ruS7hZOTTDB+rij9dOwzNVreyL6eDkRfoopE1G+tjIkB+apox
         vYRbZdOYXvT48OkCgjuOg9M1jW0iogD5oRrIGbpAMo8H6sq8cirnDSbHh0M5VqmV4MqX
         lRUA==
X-Forwarded-Encrypted: i=1; AJvYcCVYmaNVw9zeuwwf+ZEYn2i4t9tn86Xsvapt2vh5gwNne52Kj0B4i+OLau7qm4E3p5RyJFR1rHSRe6eic8L/p7iNxMzH
X-Gm-Message-State: AOJu0YzTAYStMTNmT7VEEw95msW2y5wOakBhrglUHjo5XKSX65klOeno
	9CLPNjtNRB+5KLbvrPsPT6UazG0jr70Gz6JbDVTor6nOLqFkiRYoUNPOjmH9E803kD9gM91fTO0
	QbzdwWBLj14MiNzevWTtUi2ydogjy/TWVUIAB1A==
X-Google-Smtp-Source: AGHT+IHHpzcVEcNhspYRl8UdSexWw2zFjflLUoB7Hhl7y4gOEyKCmAHeZwv+F0ItAN4TwM029MAFbVo8mzYup8wNxoE=
X-Received: by 2002:a9d:3e11:0:b0:6e4:dbb4:8f49 with SMTP id
 a17-20020a9d3e11000000b006e4dbb48f49mr3365305otd.9.1709489463495; Sun, 03 Mar
 2024 10:11:03 -0800 (PST)
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
In-Reply-To: <CAM0EoMncuPvUsRwE+Ajojgg-8JD+1oJ7j2Rw+7oN60MjjAHV-g@mail.gmail.com>
From: Tom Herbert <tom@sipanda.io>
Date: Sun, 3 Mar 2024 10:10:52 -0800
Message-ID: <CAOuuhY8pgxqCg5uTXzetTt5sd8RzOfLPYF8ksLjoUhkKyqr56w@mail.gmail.com>
Subject: Re: Hardware Offload discussion WAS(Re: [PATCH net-next v12 00/15]
 Introducing P4TC (series 1)
To: Jamal Hadi Salim <jhs@mojatatu.com>
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

On Sun, Mar 3, 2024 at 9:00=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> On Sat, Mar 2, 2024 at 10:27=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Sat, 2 Mar 2024 09:36:53 -0500 Jamal Hadi Salim wrote:
> > > 2) Your point on:  "integrate later", or at least "fill in the gaps"
> > > This part i am probably going to mumble on. I am going to consider
> > > more than just doing ACLs/MAT via flower/u32 for the sake of
> > > discussion.
> > > True, "fill the gaps" has been our model so far. It requires kernel
> > > changes, user space code changes etc justifiably so because most of
> > > the time such datapaths are subject to standardization via IETF, IEEE=
,
> > > etc and new extensions come in on a regular basis.  And sometimes we
> > > do add features that one or two users or a single vendor has need for
> > > at the cost of kernel and user/control extension. Given our work
> > > process, any features added this way take a long time to make it to
> > > the end user.
> >
> > What I had in mind was more of a DDP model. The device loads it binary
> > blob FW in whatever way it does, then it tells the kernel its parser
> > graph, and tables. The kernel exposes those tables to user space.
> > All dynamic, no need to change the kernel for each new protocol.
> >
> > But that's different in two ways:
> >  1. the device tells kernel the tables, no "dynamic reprogramming"
> >  2. you don't need the SW side, the only use of the API is to interact
> >     with the device
> >
> > User can still do BPF kfuncs to look up in the tables (like in FIB),
> > but call them from cls_bpf.
> >
>
> This is not far off from what is envisioned today in the discussions.
> The main issue is who loads the binary? We went from devlink to the
> filter doing the loading. DDP is ethtool. We still need to tie a PCI
> device/tc block to the "program" so we can do skip_sw and it works.
> Meaning a device that is capable of handling multiple programs can
> have multiple blobs loaded. A "program" is mapped to a tc filter and
> MAT control works the same way as it does today (netlink/tc ndo).
>
> A program in P4 has a name, ID and people have been suggesting a sha1
> identity (or a signature of some kind should be generated by the
> compiler). So the upward propagation could be tied to discovering
> these 3 tuples from the driver. Then the control plane targets a
> program via those tuples via netlink (as we do currently).
>
> I do note, using the DDP sample space, currently whatever gets loaded
> is "trusted" and really you need to have human knowledge of what the
> NIC's parsing + MAT is to send the control. With P4 that is all
> visible/programmable by the end user (i am not a proponent of vendors
> "shipping" things or calling them for support) - so should be
> sufficient to just discover what is in the binary and send the correct
> control messages down.
>
> > I think in P4 terms that may be something more akin to only providing
> > the runtime API? I seem to recall they had some distinction...
>
> There are several solutions out there (ex: TDI, P4runtime) - our API
> is netlink and those could be written on top of netlink, there's no
> controversy there.
> So the starting point is defining the datapath using P4, generating
> the binary blob and whatever constraints needed using the vendor
> backend and for s/w equivalent generating the eBPF datapath.
>
> > > At the cost of this sounding controversial, i am going
> > > to call things like fdb, fib, etc which have fixed datapaths in the
> > > kernel "legacy". These "legacy" datapaths almost all the time have
> >
> > The cynic in me sometimes thinks that the biggest problem with "legacy"
> > protocols is that it's hard to make money on them :)
>
> That's a big motivation without a doubt, but also there are people
> that want to experiment with things. One of the craziest examples we
> have is someone who created a P4 program for "in network calculator",
> essentially a calculator in the datapath. You send it two operands and
> an operator using custom headers, it does the math and responds with a
> result in a new header. By itself this program is a toy but it
> demonstrates that if one wanted to, they could have something custom
> in hardware and/or kernel datapath.

Jamal,

Given how long P4 has been around it's surprising that the best
publicly available code example is "the network calculator" toy. At
this point in its lifetime, eBPF had far more examples of real world
use cases publically available. That being said, there's nothing
unique about P4 supporting the network calculator. We could just as
easily write this in eBPF (either plain C or P4)  and "offload" it to
an ARM core on a SmartNIC.

If we are going to support programmable device offload in the Linux
kernel then I maintain it should be a generic mechanism that's
agnostic to *both* the frontend programming language as well as the
backend target. For frontend languages we want to let the user program
in a language that's convenient for *them*, which honestly in most
cases isn't going to be a narrow use case DSL (i.e. typically users
want to code in C/C++, Python, Rust, etc.). For the backend it's the
same story, maybe we're compiling to run in host, maybe we're
offloading to P4 runtime, maybe we're offloading to another CPU, maybe
we're offloading some other programmable NPU. The only real
requirement is a compiler that can take the frontend code and compile
for the desired backend target, but above all we want this to be easy
for the programmer, the compiler needs to do the heavy lifting and we
should never require the user to understand the nuances of a target.

IMO, the model we want for programmable kernel offload is "write once,
run anywhere, run well". Which is the Java tagline amended with "run
well". Users write one program for their datapath processing, it runs
on various targets, for any given target we run to run at the highest
performance levels possible given the target's capabilities.

Tom

>
> cheers,
> jamal

