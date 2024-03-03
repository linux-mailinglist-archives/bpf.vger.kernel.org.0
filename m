Return-Path: <bpf+bounces-23261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8029886F382
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 04:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 189D1B224CD
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 03:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B8D5684;
	Sun,  3 Mar 2024 03:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d35ulvwe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E217F;
	Sun,  3 Mar 2024 03:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709436470; cv=none; b=cTxmOOBI4/doxvGT2VYQwnKBXz96duC8Cn9o/16piUpvrP7+spXJ9y8iEZ7ChxbqLwjfvz4j6XVljUTgX1H/AN49hlINLZcayT130HZ+6WAPFJdx5rodpz7TdxSNOKVLG+eI55WhfSLr8dOJEwa9nWKZhP23Ek/RFSUcjR9oM+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709436470; c=relaxed/simple;
	bh=qTphyIhgZIX4Zssdwjl0GEGYCI1aF0rm9C9at22wpyo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kt+jW9Xz0kHteeRmcB8pO2vwQh2t3VB4mAMljnwuoxv2sFW1pqQQM5y/gKVCMU/8LQVoWga9JrHaGHGc0Leqt0p3lF4BWww9RhQe0ywZhvwiDP269jr7/f6IFT9ir2vJ9y8JUxnyzeUDX5DCIBMHNn+NF7m2lggI0UUo+BvWGwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d35ulvwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A1EC433F1;
	Sun,  3 Mar 2024 03:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709436469;
	bh=qTphyIhgZIX4Zssdwjl0GEGYCI1aF0rm9C9at22wpyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d35ulvweVWUpQB8JB7v+hjk5qswTruJX7XVkIab5qIGkYbOSn1d74IYzMb/FBOk50
	 OutKylOP/idpnrhT+Tr6jGH7FssAbOdxUb2wOS+LAgwuRtC4iaKtjlLys6UitCzb40
	 JL7xi7T8d/BVYhUETEJhBcEyqYPuUOMf5he7K0tNQQqCyOycBmfZsWRet0c1jFFisT
	 A4CTQshuDuHmTbCt7IBCJQMlYl0BTzAJWPQkCdEDJbgGoZK7KTu/gOVSwVhun9EizF
	 gliwOil3E/ZqSlCNS8fthYHmcqCXJP/OPvzEEimdPkhbmQfUkCE0hUVj3d9deTi4T1
	 yfJZZGTgyZxkw==
Date: Sat, 2 Mar 2024 19:27:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Tom Herbert <tom@sipanda.io>, John Fastabend <john.fastabend@gmail.com>,
 "Singhai, Anjali" <anjali.singhai@intel.com>, Paolo Abeni
 <pabeni@redhat.com>, Linux Kernel Network Developers
 <netdev@vger.kernel.org>, "Chatterjee, Deb" <deb.chatterjee@intel.com>,
 "Limaye, Namrata" <namrata.limaye@intel.com>, Marcelo Ricardo Leitner
 <mleitner@redhat.com>, "Shirshyad, Mahesh" <Mahesh.Shirshyad@amd.com>,
 "Jain, Vipin" <Vipin.Jain@amd.com>, "Osinski, Tomasz"
 <tomasz.osinski@intel.com>, Jiri Pirko <jiri@resnulli.us>, Cong Wang
 <xiyou.wangcong@gmail.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Vlad Buslov <vladbu@nvidia.com>, Simon
 Horman <horms@kernel.org>, Khalid Manaa <khalidm@nvidia.com>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Victor Nogueira <victor@mojatatu.com>, "Tammela,
 Pedro" <pctammela@mojatatu.com>, "Daly, Dan" <dan.daly@intel.com>, Andy
 Fingerhut <andy.fingerhut@gmail.com>, "Sommers, Chris"
 <chris.sommers@keysight.com>, Matty Kadosh <mattyk@nvidia.com>, bpf
 <bpf@vger.kernel.org>
Subject: Re: Hardware Offload discussion WAS(Re: [PATCH net-next v12 00/15]
 Introducing P4TC (series 1)
Message-ID: <20240302192747.371684fb@kernel.org>
In-Reply-To: <CAM0EoM=8GG-zCaopaUDMkvqemrZQUtaVRTMrWA6z=xrdYxG9+g@mail.gmail.com>
References: <20240225165447.156954-1-jhs@mojatatu.com>
	<b28f2f7900dc7bad129ad67621b2f7746c3b2e18.camel@redhat.com>
	<CO1PR11MB49931E501B20F32681F917CD935F2@CO1PR11MB4993.namprd11.prod.outlook.com>
	<65e106305ad8b_43ad820892@john.notmuch>
	<CAM0EoM=r1UDnkp-csPdrz6nBt7o3fHUncXKnO7tB_rcZAcbrDg@mail.gmail.com>
	<CAOuuhY8qbsYCjdUYUZv8J3jz8HGXmtxLmTDP6LKgN5uRVZwMnQ@mail.gmail.com>
	<20240301090020.7c9ebc1d@kernel.org>
	<CAM0EoM=-hzSNxOegHqhAQD7qoAR2CS3Dyh-chRB+H7C7TQzmow@mail.gmail.com>
	<20240301173214.3d95e22b@kernel.org>
	<CAM0EoM=NEB25naGtz=YaOt6BDoiv4RpDw27Y=btMZAMGeYB5bg@mail.gmail.com>
	<CAM0EoM=8GG-zCaopaUDMkvqemrZQUtaVRTMrWA6z=xrdYxG9+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 2 Mar 2024 09:36:53 -0500 Jamal Hadi Salim wrote:
> 2) Your point on:  "integrate later", or at least "fill in the gaps"
> This part i am probably going to mumble on. I am going to consider
> more than just doing ACLs/MAT via flower/u32 for the sake of
> discussion.
> True, "fill the gaps" has been our model so far. It requires kernel
> changes, user space code changes etc justifiably so because most of
> the time such datapaths are subject to standardization via IETF, IEEE,
> etc and new extensions come in on a regular basis.  And sometimes we
> do add features that one or two users or a single vendor has need for
> at the cost of kernel and user/control extension. Given our work
> process, any features added this way take a long time to make it to
> the end user.

What I had in mind was more of a DDP model. The device loads it binary
blob FW in whatever way it does, then it tells the kernel its parser
graph, and tables. The kernel exposes those tables to user space.
All dynamic, no need to change the kernel for each new protocol.

But that's different in two ways:
 1. the device tells kernel the tables, no "dynamic reprogramming"
 2. you don't need the SW side, the only use of the API is to interact
    with the device

User can still do BPF kfuncs to look up in the tables (like in FIB), 
but call them from cls_bpf.

I think in P4 terms that may be something more akin to only providing
the runtime API? I seem to recall they had some distinction...

> At the cost of this sounding controversial, i am going
> to call things like fdb, fib, etc which have fixed datapaths in the
> kernel "legacy". These "legacy" datapaths almost all the time have

The cynic in me sometimes thinks that the biggest problem with "legacy"
protocols is that it's hard to make money on them :)

> very strong user bases with strong infra tooling which took years to
> get in shape. So they must be supported. I see two approaches:
> -  you can leave those "legacy" ndo ops alone and not go via the tc
> ndo ops used by P4TC.
> -  or write a P4 program that looks _exactly_ like what current
> bridging looks like and add helpers to allow existing tools to
> continue to work via tc ndo and then phase out the "fixed datapath"
> ndos. This will take a long long time but it could be a goal.
> 
> There is another caveat: Often different vendor hardware has slightly
> different features which cant be exposed because either they are very
> specific to the vendor or it's just very hard to express with existing
> "legacy" without making intrusive changes. So we are going to be able
> to allow these vendors/users to expose as much or as little as is
> needed for a specific deployment without affecting anyone else with
> new kernel/user code.
> 
> On the "integrate later" aspect: That is probably because most of the
> times we want to avoid doing intrusive niche changes (which is
> resolvable with the above).

