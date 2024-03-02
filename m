Return-Path: <bpf+bounces-23239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4284786EE1B
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 03:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661681C21AF9
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 02:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AD579D0;
	Sat,  2 Mar 2024 02:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipanda-io.20230601.gappssmtp.com header.i=@sipanda-io.20230601.gappssmtp.com header.b="qHJZAlFc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68EB7483
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 02:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709346050; cv=none; b=LFtia1bMjo5skv9ZAEKE5XXefQV76SPgv35vHHYcSvK0CNhcMj8bhj3QiQjJlks6UB49LJB/hSa4k3hMWwJZy+3Fsr7/o/srFzGbpTUSkmFk6MM5/O2TfortekwUZ+UyPMsc9FiZLO9UnFja+1foY1XjI0vc8ME/6XM9BR/zH0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709346050; c=relaxed/simple;
	bh=nNUuC81I50TyEXSlAZ66QYvJm6ui8/+1WLOvBBHhSC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqyz321QHwHIbVV07+y4lN7qeW+CyJ1ZRm6a6W6C8kBCvp87dTZel9cOAfSXDTPZ7UFRiTUvwje1O2dYQFNgPtR89Ga8IvdFY1L3sp23lEdCjn6TPGtloeEmPFxNQHmfPapPBMOoK+9OVGExcFBSmtmpE+yThLYCDkT4M+M2+pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sipanda.io; spf=pass smtp.mailfrom=sipanda.io; dkim=pass (2048-bit key) header.d=sipanda-io.20230601.gappssmtp.com header.i=@sipanda-io.20230601.gappssmtp.com header.b=qHJZAlFc; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sipanda.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipanda.io
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e47a9f4b70so1492354a34.1
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 18:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sipanda-io.20230601.gappssmtp.com; s=20230601; t=1709346048; x=1709950848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i77Xvo6PHlwMh9HzlSvsJgMugVHF6UjPPPjubRdR2b8=;
        b=qHJZAlFchAjA4sH76CiJjA30H/TYsU25FetFheQvek+AGGOhvdMXUjxaZvsMBeFh0l
         wJAHBpXnOJisGiQxg2+PBVhJLGIHkrW5IHePLs+kjdv5Y2W24Q9SE80EeympbbTdeTtx
         BZXjkZFvYJQsl7kV0WYJ0dHFksCnOhISg//aU58Yd1LyziZPKGmnkpULnO+LAZaM4ysn
         wtSFIMb1MtxDs/eofOA0HfC/XMnvwf6OlMZetr+hpvee+VVZ9zqHgpUcxpCq8ZwNWCKP
         MEHbmUXtWGyBya6NmR8RYAx8lrPovSi9QfUtgfxcK9bspj+xHeRuk7V6tYMKC9leAZDS
         0GEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709346048; x=1709950848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i77Xvo6PHlwMh9HzlSvsJgMugVHF6UjPPPjubRdR2b8=;
        b=kVuRiExMXHVrZC7PGxNR1JCuqK0L2ytHNU9OH/OoxtbsuR/FsjU5TqJ9rQ6iDz1czF
         o1c39xZaaWQ/AEKtiGHLnj9DZ4eTdG+jGM9fNLZcA8V6xQzXS4Kxo99FcN8fDI8fsbyc
         ecsH2Tut9aSIXQ9vYn7MpeAL8lfTmd9g3eH3QiNxA1lHUUqNgPMx5MSl/745DDzNYTXc
         IBlt3ZVAXSFydj16iElAdCFBaShzl/YoNzkfRiFbEx/zLSkhWEdXjHGeF8ihBo29w6TX
         hEP9lLa6CM+DdALrZZfrTlaFeDQDpv6pxYUrn7jWFrdNgHxtVpDwpjKGPg0CJjoXgisP
         r2Bw==
X-Forwarded-Encrypted: i=1; AJvYcCX+soEqs0kZAOdhU+oW0nkODruk7DP4+lso94Y0arIZfAt5NnXRG8p9+hyXTCYl80pp/IEnRfhwr9wNVqMvnWRXwEYh
X-Gm-Message-State: AOJu0Yxh9afxZIt1hJFoz0hFm+VYEzYr+e2iLM/w4pxeLzheqkUymuTX
	w6419bscU6kaHq0sZ+hkhknwGj5fJO12JZ7/bnrB5wa3/d2Quey6yKd8PYuvqZTVg1P40j5lcY2
	BTLvasQ7SmHwCtBNmaRfXTkd+b29JrfNLlG0H0A==
X-Google-Smtp-Source: AGHT+IGxKAMIM/TGlrxWrh6qd7LCPB1amVq6z9F118r/yOfNVwGlXAZy901Q/U5tvAgPF3AGtRUf5ANUCWJ160rIpPc=
X-Received: by 2002:a05:6871:64f:b0:21e:858f:ec9a with SMTP id
 x15-20020a056871064f00b0021e858fec9amr3255628oan.30.1709346047843; Fri, 01
 Mar 2024 18:20:47 -0800 (PST)
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
 <20240301173214.3d95e22b@kernel.org>
In-Reply-To: <20240301173214.3d95e22b@kernel.org>
From: Tom Herbert <tom@sipanda.io>
Date: Fri, 1 Mar 2024 18:20:36 -0800
Message-ID: <CAOuuhY8fnpEEBb8z-1mQmvHtfZQwgQnXk3=op-Xk108Pts8ohA@mail.gmail.com>
Subject: Re: [PATCH net-next v12 00/15] Introducing P4TC (series 1)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, John Fastabend <john.fastabend@gmail.com>, 
	"Singhai, Anjali" <anjali.singhai@intel.com>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, "Chatterjee, Deb" <deb.chatterjee@intel.com>, 
	"Limaye, Namrata" <namrata.limaye@intel.com>, mleitner@redhat.com, Mahesh.Shirshyad@amd.com, 
	Vipin.Jain@amd.com, "Osinski, Tomasz" <tomasz.osinski@intel.com>, 
	Jiri Pirko <jiri@resnulli.us>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, edumazet@google.com, Vlad Buslov <vladbu@nvidia.com>, 
	horms@kernel.org, khalidm@nvidia.com, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Victor Nogueira <victor@mojatatu.com>, 
	"Tammela, Pedro" <pctammela@mojatatu.com>, "Daly, Dan" <dan.daly@intel.com>, andy.fingerhut@gmail.com, 
	"Sommers, Chris" <chris.sommers@keysight.com>, mattyk@nvidia.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 5:32=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 1 Mar 2024 12:39:56 -0500 Jamal Hadi Salim wrote:
> > On Fri, Mar 1, 2024 at 12:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > > > Pardon my ignorance, but doesn't P4 want to be compiled to a backen=
d
> > > > target? How does going through TC make this seamless?
> > >
> > > +1
> >
> > I should clarify what i meant by "seamless". It means the same control
> > API is used for s/w or h/w. This is a feature of tc, and is not being
> > introduced by P4TC. P4 control only deals with Match-action tables -
> > just as TC does.
>
> Right, and the compiled P4 pipeline is tacked onto that API.
> Loading that presumably implies a pipeline reset. There's
> no precedent for loading things into TC resulting a device
> datapath reset.
>
> > > My intuition is that for offload the device would be programmed at
> > > start-of-day / probe. By loading the compiled P4 from /lib/firmware.
> > > Then the _device_ tells the kernel what tables and parser graph it's
> > > got.
> >
> > BTW: I just want to say that these patches are about s/w - not
> > offload. Someone asked about offload so as in normal discussions we
> > steered in that direction. The hardware piece will require additional
> > patchsets which still require discussions. I hope we dont steer off
> > too much, otherwise i can start a new thread just to discuss current
> > view of the h/w.
> >
> > Its not the device telling the kernel what it has. Its the other way ar=
ound.
>
> Yes, I'm describing how I'd have designed it :) If it was the same
> as what you've already implemented - why would I be typing it into
> an email.. ? :)
>
> > From the P4 program you generate the s/w (the ebpf code and other
> > auxillary stuff) and h/w pieces using a compiler.
> > You compile ebpf, etc, then load.
>
> That part is fine.
>
> > The current point of discussion is the hw binary is to be "activated"
> > through the same tc filter that does the s/w. So one could say:
> >
> > tc filter add block 22 ingress protocol all prio 1 p4 pname simple_l3
> > \
> >    prog type hw filename "simple_l3.o" ... \
> >    action bpf obj $PARSER.o section p4tc/parser \
> >    action bpf obj $PROGNAME.o section p4tc/main
> >
> > And that would through tc driver callbacks signal to the driver to
> > find the binary possibly via  /lib/firmware
> > Some of the original discussion was to use devlink for loading the
> > binary - but that went nowhere.
>
> Back to the device reset, unless the load has no impact on inflight
> traffic the loading doesn't belong in TC, IMO. Plus you're going to
> run into (what IIRC was Jiri's complaint) that you're loading arbitrary
> binary blobs, opaque to the kernel.
>
> > Once you have this in place then netlink with tc skip_sw/hw. This is
> > what i meant by "seamless"
> >
> > > Plus, if we're talking about offloads, aren't we getting back into
> > > the same controversies we had when merging OvS (not that I was around=
).
> > > The "standalone stack to the side" problem. Some of the tables in the
> > > pipeline may be for routing, not ACLs. Should they be fed from the
> > > routing stack? How is that integration going to work? The parsing
> > > graph feels a bit like global device configuration, not a piece of
> > > functionality that should sit under sub-sub-system in the corner.
> >
> > The current (maybe i should say initial) thought is the P4 program
> > does not touch the existing kernel infra such as fdb etc.
>
> It's off to the side thing. Ignoring the fact that *all*, networking
> devices already have parsers which would benefit from being accurately
> described.

Jakub,

This is configurability versus programmability. The table driven
approach as input (configurability) might work fine for generic
match-action tables up to the point that tables are expressive enough
to satisfy the requirements. But parsing doesn't fall into the table
driven paradigm: parsers want to be *programmed*. This is why we
removed kParser from this patch set and fell back to eBPF for parsing.
But the problem we quickly hit that eBPF is not offloadable to network
devices, for example when we compile P4 in an eBPF parser we've lost
the declarative representation that parsers in the devices could
consume (they're not CPUs running eBPF).

I think the key here is what we mean by kernel offload. When we do
kernel offload, is it the kernel implementation or the kernel
functionality that's being offloaded? If it's the latter then we have
a lot more flexibility. What we'd need is a safe and secure way to
synchronize with that offload device that precisely supports the
kernel functionality we'd like to offload. This can be done if both
the kernel bits and programmed offload are derived from the same
source (i.e. tag source code with a sha-1). For example, if someone
writes a parser in P4, we can compile that into both eBPF and a P4
backend using independent tool chains and program download. At
runtime, the kernel can safely offload the functionality of the eBPF
parser to the device if it matches the hash to that reported by the
device

Tom

>
> > Of course we can model the kernel datapath using P4 but you wont be
> > using "ip route add..." or "bridge fdb...".
> > In the future, P4 extern could be used to model existing infra and we
> > should be able to use the same tooling. That is a discussion that
> > comes on/off (i think it did in the last meeting).
>
> Maybe, IDK. I thought prevailing wisdom, at least for offloads,
> is to offload the existing networking stack, and fill in the gaps.
> Not build a completely new implementation from scratch, and "integrate
> later". Or at least "fill in the gaps" is how I like to think.
>
> I can't quite fit together in my head how this is okay, but OvS
> was not allowed to add their offload API. And what's supposed to
> be part of TC and what isn't, where you only expect to have one
> filter here, and create a whole new object universe inside TC.
>
> But that's just my opinions. The way things work we may wake up one
> day and find out that Dave has applied this :)

