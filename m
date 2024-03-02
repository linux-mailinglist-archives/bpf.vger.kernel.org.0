Return-Path: <bpf+bounces-23233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0270C86EDE9
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 02:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263C31C2148B
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 01:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD6B6FCB;
	Sat,  2 Mar 2024 01:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMVV56Sh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E82E63AE;
	Sat,  2 Mar 2024 01:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709343136; cv=none; b=rVSrUsWPiPQvxBKZ588WazlN22asbiz6zZxfvE9xtGb3zZCVgwKhpSNZotKbo1ZZxcE/eHibPQDiLO06eHWoSCLkKZQ6eFWCbSOd+OCtRjaUMbI88Z4Qftfk+qyfg4kHO99C5zAHD9xweHBa3yYyk7tDOhQsbDhQnSXGQQZtNwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709343136; c=relaxed/simple;
	bh=8DT8yTWk/ppyGgxALP2H2XyLzwNSINbd/j37JSVCUFM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYoRLWQ9JyX2wmF6BfFYNAE0ZU1OpqqMNeGv/Q+KndAzMOK1tIMki3lLxq0ol70ZNLOPiB4RJs+57YywjtA9TEB7UAo2UsXEBCp3u62RDjr8dZ2FZS1yeFn2OlhJvETwC9wu21HVm9mAY6beq+DkulG5yLuuuyD3kD6Qn94U2t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMVV56Sh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB177C433C7;
	Sat,  2 Mar 2024 01:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709343135;
	bh=8DT8yTWk/ppyGgxALP2H2XyLzwNSINbd/j37JSVCUFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EMVV56ShqKDDetyifaJFJQahFr3C9Ne7rZ2d2pcRWG7R9/RSdtcti0dLkCovzFJFi
	 XAC2sAaqgRwuZzeYOzROx2Jew3NK92xJN8lTnftfLAPfo2BKrkNDGjOcU3JFsZ0q7j
	 dwaTdkXp9l7vv04RTFLTsPQErtVeWNohJextqJQRJ6re9aLfz/vp/q6i+KSSRQAyA3
	 MSIuHkMdodjUPHXvQxwA98DwZZRAopoxd9W+806qNwanp+y5HZXPuIBcM7Mpl6O6Hd
	 PAFmmrHlNhCqgxLeYb4j4C4zsvQWpHXVtIJaRalp82NQ964GGJdma0wopZrDlfZEa8
	 YOoJyxgThzsyw==
Date: Fri, 1 Mar 2024 17:32:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Tom Herbert <tom@sipanda.io>, John Fastabend <john.fastabend@gmail.com>,
 "Singhai, Anjali" <anjali.singhai@intel.com>, Paolo Abeni
 <pabeni@redhat.com>, Linux Kernel Network Developers
 <netdev@vger.kernel.org>, "Chatterjee, Deb" <deb.chatterjee@intel.com>,
 "Limaye, Namrata" <namrata.limaye@intel.com>, mleitner@redhat.com,
 Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, "Osinski, Tomasz"
 <tomasz.osinski@intel.com>, Jiri Pirko <jiri@resnulli.us>, Cong Wang
 <xiyou.wangcong@gmail.com>, "David S . Miller" <davem@davemloft.net>,
 edumazet@google.com, Vlad Buslov <vladbu@nvidia.com>, horms@kernel.org,
 khalidm@nvidia.com, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, Victor Nogueira
 <victor@mojatatu.com>, "Tammela, Pedro" <pctammela@mojatatu.com>, "Daly,
 Dan" <dan.daly@intel.com>, andy.fingerhut@gmail.com, "Sommers, Chris"
 <chris.sommers@keysight.com>, mattyk@nvidia.com, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v12 00/15] Introducing P4TC (series 1)
Message-ID: <20240301173214.3d95e22b@kernel.org>
In-Reply-To: <CAM0EoM=-hzSNxOegHqhAQD7qoAR2CS3Dyh-chRB+H7C7TQzmow@mail.gmail.com>
References: <20240225165447.156954-1-jhs@mojatatu.com>
	<b28f2f7900dc7bad129ad67621b2f7746c3b2e18.camel@redhat.com>
	<CO1PR11MB49931E501B20F32681F917CD935F2@CO1PR11MB4993.namprd11.prod.outlook.com>
	<65e106305ad8b_43ad820892@john.notmuch>
	<CAM0EoM=r1UDnkp-csPdrz6nBt7o3fHUncXKnO7tB_rcZAcbrDg@mail.gmail.com>
	<CAOuuhY8qbsYCjdUYUZv8J3jz8HGXmtxLmTDP6LKgN5uRVZwMnQ@mail.gmail.com>
	<20240301090020.7c9ebc1d@kernel.org>
	<CAM0EoM=-hzSNxOegHqhAQD7qoAR2CS3Dyh-chRB+H7C7TQzmow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 1 Mar 2024 12:39:56 -0500 Jamal Hadi Salim wrote:
> On Fri, Mar 1, 2024 at 12:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > > Pardon my ignorance, but doesn't P4 want to be compiled to a backend
> > > target? How does going through TC make this seamless? =20
> >
> > +1
>=20
> I should clarify what i meant by "seamless". It means the same control
> API is used for s/w or h/w. This is a feature of tc, and is not being
> introduced by P4TC. P4 control only deals with Match-action tables -
> just as TC does.

Right, and the compiled P4 pipeline is tacked onto that API.
Loading that presumably implies a pipeline reset. There's=20
no precedent for loading things into TC resulting a device
datapath reset.

> > My intuition is that for offload the device would be programmed at
> > start-of-day / probe. By loading the compiled P4 from /lib/firmware.
> > Then the _device_ tells the kernel what tables and parser graph it's
> > got.
>=20
> BTW: I just want to say that these patches are about s/w - not
> offload. Someone asked about offload so as in normal discussions we
> steered in that direction. The hardware piece will require additional
> patchsets which still require discussions. I hope we dont steer off
> too much, otherwise i can start a new thread just to discuss current
> view of the h/w.
>=20
> Its not the device telling the kernel what it has. Its the other way arou=
nd.

Yes, I'm describing how I'd have designed it :) If it was the same
as what you've already implemented - why would I be typing it into
an email.. ? :)

> From the P4 program you generate the s/w (the ebpf code and other
> auxillary stuff) and h/w pieces using a compiler.
> You compile ebpf, etc, then load.

That part is fine.

> The current point of discussion is the hw binary is to be "activated"
> through the same tc filter that does the s/w. So one could say:
>=20
> tc filter add block 22 ingress protocol all prio 1 p4 pname simple_l3
> \
>    prog type hw filename "simple_l3.o" ... \
>    action bpf obj $PARSER.o section p4tc/parser \
>    action bpf obj $PROGNAME.o section p4tc/main
>=20
> And that would through tc driver callbacks signal to the driver to
> find the binary possibly via  /lib/firmware
> Some of the original discussion was to use devlink for loading the
> binary - but that went nowhere.

Back to the device reset, unless the load has no impact on inflight
traffic the loading doesn't belong in TC, IMO. Plus you're going to
run into (what IIRC was Jiri's complaint) that you're loading arbitrary
binary blobs, opaque to the kernel.

> Once you have this in place then netlink with tc skip_sw/hw. This is
> what i meant by "seamless"
>=20
> > Plus, if we're talking about offloads, aren't we getting back into
> > the same controversies we had when merging OvS (not that I was around).
> > The "standalone stack to the side" problem. Some of the tables in the
> > pipeline may be for routing, not ACLs. Should they be fed from the
> > routing stack? How is that integration going to work? The parsing
> > graph feels a bit like global device configuration, not a piece of
> > functionality that should sit under sub-sub-system in the corner. =20
>=20
> The current (maybe i should say initial) thought is the P4 program
> does not touch the existing kernel infra such as fdb etc.

It's off to the side thing. Ignoring the fact that *all*, networking
devices already have parsers which would benefit from being accurately
described.

> Of course we can model the kernel datapath using P4 but you wont be
> using "ip route add..." or "bridge fdb...".
> In the future, P4 extern could be used to model existing infra and we
> should be able to use the same tooling. That is a discussion that
> comes on/off (i think it did in the last meeting).

Maybe, IDK. I thought prevailing wisdom, at least for offloads,
is to offload the existing networking stack, and fill in the gaps.
Not build a completely new implementation from scratch, and "integrate
later". Or at least "fill in the gaps" is how I like to think.

I can't quite fit together in my head how this is okay, but OvS
was not allowed to add their offload API. And what's supposed to
be part of TC and what isn't, where you only expect to have one=20
filter here, and create a whole new object universe inside TC.

But that's just my opinions. The way things work we may wake up one=20
day and find out that Dave has applied this :)

