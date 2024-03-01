Return-Path: <bpf+bounces-23156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A8286E692
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 18:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E1E282F25
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 17:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9D14404;
	Fri,  1 Mar 2024 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTD70NeR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A19259B;
	Fri,  1 Mar 2024 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312422; cv=none; b=C4FQwhBEVfJR26xOJB3+GZKdGbpZKGU5+J7+YZ6U0p1gY+ZBmlXXbT3AK07cfRhJba/Jjt94Ef/hsZ4tFvSvNWvgqmtADEk7Qh7uv0Hz3kcLOsB2BspcKy8f84rSy3Zefuw+f+K1quEcBZo6mperUsv0cRQtL2rNwV+UjdeiwBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312422; c=relaxed/simple;
	bh=WnT23L2kMGF/z8OkyEJRwnkTu72ubHKAZsAR3RXKUF8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bYKaRUxYDpzbdtHSpqEizDnd1yImlYmE5wjgQ6coE0hR2SMXBxJkBt9y2ortfvbdIkUgphhGrwD8KLe4Lm0JCyMe1QqULuBYfGTit1Y35zRfKgmVa7BXtD70HeodLjI0xKOu3qgJQtIrrUJVHTOPm5xAK7lgSApV35hdaIQa01o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTD70NeR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F27C433C7;
	Fri,  1 Mar 2024 17:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709312422;
	bh=WnT23L2kMGF/z8OkyEJRwnkTu72ubHKAZsAR3RXKUF8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PTD70NeRq/X/Xqqg5AIiIc7RIiJWd4zOSIV7okPQgZS4NCmnqRQO4r+BAzdSLGtlm
	 j1rMgc9BaiZuJ5G5an6Fv89Y7kBSbPgvzDYdED8tepiivcFbQDes05828SckLUh+ng
	 uZSsTt0sPa3bLr704bI1lIx05VMT93j9nla9ipoFkSheWjm3RzpZe8JM3NoOzIs3Xw
	 8Z4KRjVUzY9NaYYzHH7VxZcI5qtckSAV9GcrGnJoWGH7VDunDvJ1vdASEVEBSNMaKb
	 jSYm8dMQ96i5sAn+ru1dALx6XWAht/sBo5Y0h1R8ccg9/h+z2xNNdVCA7BW4iNKF6Q
	 uHsU4ylWQpuaw==
Date: Fri, 1 Mar 2024 09:00:20 -0800
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
Message-ID: <20240301090020.7c9ebc1d@kernel.org>
In-Reply-To: <CAOuuhY8qbsYCjdUYUZv8J3jz8HGXmtxLmTDP6LKgN5uRVZwMnQ@mail.gmail.com>
References: <20240225165447.156954-1-jhs@mojatatu.com>
	<b28f2f7900dc7bad129ad67621b2f7746c3b2e18.camel@redhat.com>
	<CO1PR11MB49931E501B20F32681F917CD935F2@CO1PR11MB4993.namprd11.prod.outlook.com>
	<65e106305ad8b_43ad820892@john.notmuch>
	<CAM0EoM=r1UDnkp-csPdrz6nBt7o3fHUncXKnO7tB_rcZAcbrDg@mail.gmail.com>
	<CAOuuhY8qbsYCjdUYUZv8J3jz8HGXmtxLmTDP6LKgN5uRVZwMnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 19:00:50 -0800 Tom Herbert wrote:
> > I want to emphasize again these patches are about the P4 s/w pipeline
> > that is intended to work seamlessly with hw offload. If you are
> > interested in h/w offload and want to contribute just show up at the
> > meetings - they are open to all. The current offloadable piece is the
> > match-action tables. The P4 specs may change to include parsers in the
> > future or other objects etc (but not sure why we should discuss this
> > in the thread).
> 
> Pardon my ignorance, but doesn't P4 want to be compiled to a backend
> target? How does going through TC make this seamless?

+1

My intuition is that for offload the device would be programmed at
start-of-day / probe. By loading the compiled P4 from /lib/firmware.
Then the _device_ tells the kernel what tables and parser graph it's
got.

Plus, if we're talking about offloads, aren't we getting back into
the same controversies we had when merging OvS (not that I was around).
The "standalone stack to the side" problem. Some of the tables in the
pipeline may be for routing, not ACLs. Should they be fed from the
routing stack? How is that integration going to work? The parsing
graph feels a bit like global device configuration, not a piece of
functionality that should sit under sub-sub-system in the corner.

