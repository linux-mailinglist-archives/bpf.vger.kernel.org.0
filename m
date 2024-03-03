Return-Path: <bpf+bounces-23260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C22D786F37E
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 04:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597541F21AB1
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 03:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622D1567D;
	Sun,  3 Mar 2024 03:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0oaWZvx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39E17F;
	Sun,  3 Mar 2024 03:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709435732; cv=none; b=LjwCwHilq1UCeJnv13t/L+qy9xfp+6MVl5fQU8p8oskjj+Dx2eomfQLjYIieyjAeSPTuvtoaBfDz3gKhenir94TcUvI7yJDEWdr1OGhwsUYicAgK7BAGfeytWT19r74oEsphWz4nWFBSG3Dc7SCy53YJNUxsG1+4+/d+rlW4hIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709435732; c=relaxed/simple;
	bh=GU8WeJjrtZjIZW4TTHjJruLttKSqUQCHy/41xOR6R9I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbXUVVY/UTRD1M1eRDYl6wclcn3YsZRrBxwcZIeaARkFwTYM0cENxdx+ozWlBRnP8a29uNGPtr8oT6BglVP2aTMuRjnQTk5cKnWPrghL8XZ0NAQOfTOsB2FiZZOtA4p9F0d/MniZ7K/GoZnk0IAeNTnwJSUzNIsLxhg0LCI763Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0oaWZvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316B3C433F1;
	Sun,  3 Mar 2024 03:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709435732;
	bh=GU8WeJjrtZjIZW4TTHjJruLttKSqUQCHy/41xOR6R9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D0oaWZvxBJIo6g9e++yGU50rbdUCAEWyGCvzE8RLbDRug/IU0IFGdON68bjLZtQvM
	 Seq/VLgEfSheGYP+G6K3i1y9oWarmZ/SkR4pzWmWwDduTv6XXeAOk1S1G5CHM+eq/D
	 OSODaqyFjXFQ3VhaJSeayJjqV59QtSBlSLmNCXVa1HKYCDjwg0qMU+s87HcxJ3PFeK
	 Fl1kBAdx+cGk6oTDMSqrQkWu12RdO8BA7yb5GebuiBy8s0Vz4m/xER/uf6ZumASuW5
	 U7IjZCYHPi6Ts0MtdUIAmJLqVpTRNdu/v0oTuVw6QZs0zdytMJg0Xvp9C1e6GuH4Bc
	 MtwqAV7Y8Zolg==
Date: Sat, 2 Mar 2024 19:15:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tom Herbert <tom@sipanda.io>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, John Fastabend
 <john.fastabend@gmail.com>, "Singhai, Anjali" <anjali.singhai@intel.com>,
 Paolo Abeni <pabeni@redhat.com>, Linux Kernel Network Developers
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
Message-ID: <20240302191530.22353670@kernel.org>
In-Reply-To: <CAOuuhY8fnpEEBb8z-1mQmvHtfZQwgQnXk3=op-Xk108Pts8ohA@mail.gmail.com>
References: <20240225165447.156954-1-jhs@mojatatu.com>
	<b28f2f7900dc7bad129ad67621b2f7746c3b2e18.camel@redhat.com>
	<CO1PR11MB49931E501B20F32681F917CD935F2@CO1PR11MB4993.namprd11.prod.outlook.com>
	<65e106305ad8b_43ad820892@john.notmuch>
	<CAM0EoM=r1UDnkp-csPdrz6nBt7o3fHUncXKnO7tB_rcZAcbrDg@mail.gmail.com>
	<CAOuuhY8qbsYCjdUYUZv8J3jz8HGXmtxLmTDP6LKgN5uRVZwMnQ@mail.gmail.com>
	<20240301090020.7c9ebc1d@kernel.org>
	<CAM0EoM=-hzSNxOegHqhAQD7qoAR2CS3Dyh-chRB+H7C7TQzmow@mail.gmail.com>
	<20240301173214.3d95e22b@kernel.org>
	<CAOuuhY8fnpEEBb8z-1mQmvHtfZQwgQnXk3=op-Xk108Pts8ohA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Mar 2024 18:20:36 -0800 Tom Herbert wrote:
> This is configurability versus programmability. The table driven
> approach as input (configurability) might work fine for generic
> match-action tables up to the point that tables are expressive enough
> to satisfy the requirements. But parsing doesn't fall into the table
> driven paradigm: parsers want to be *programmed*. This is why we
> removed kParser from this patch set and fell back to eBPF for parsing.
> But the problem we quickly hit that eBPF is not offloadable to network
> devices, for example when we compile P4 in an eBPF parser we've lost
> the declarative representation that parsers in the devices could
> consume (they're not CPUs running eBPF).
> 
> I think the key here is what we mean by kernel offload. When we do
> kernel offload, is it the kernel implementation or the kernel
> functionality that's being offloaded? If it's the latter then we have
> a lot more flexibility. What we'd need is a safe and secure way to
> synchronize with that offload device that precisely supports the
> kernel functionality we'd like to offload. This can be done if both
> the kernel bits and programmed offload are derived from the same
> source (i.e. tag source code with a sha-1). For example, if someone
> writes a parser in P4, we can compile that into both eBPF and a P4
> backend using independent tool chains and program download. At
> runtime, the kernel can safely offload the functionality of the eBPF
> parser to the device if it matches the hash to that reported by the
> device

Good points. If I understand you correctly you're saying that parsers
are more complex than just a basic parsing tree a'la u32.
Then we can take this argument further. P4 has grown to encompass a lot
of functionality of quite complex devices. How do we square that with 
the kernel functionality offload model. If the entire device is modeled,
including f.e. TSO, an offload would mean that the user has to write
a TSO implementation which they then load into TC? That seems odd.

IOW I don't quite know how to square in my head the "total
functionality" with being a TC-based "plugin".

