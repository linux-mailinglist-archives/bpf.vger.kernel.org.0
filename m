Return-Path: <bpf+bounces-48854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5F6A112B5
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 22:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67EBC3A045E
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 21:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BCA20F090;
	Tue, 14 Jan 2025 21:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="WRGJIZKn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="igdiQqub"
X-Original-To: bpf@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911DE1CDFCC
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 21:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736888520; cv=none; b=gfdr+wnVOpoAnHKNE5MOk3XLGGc+L2gbpOZuCuf2izvhIQXk5zvwBQ3nvbXqwS5Bm/EWMVjFEsgpOXEgOEcjuys+SzLH7qv2gAGF4ECTFutBDVFETsDiL0fwYi6NtH6pKc9I5NpksYkwHPirG8KDiQhlFeObvG6ZXy44Y2NfhR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736888520; c=relaxed/simple;
	bh=snqIui/NwDtfbsolGVJxjMYGF93yhdk/kqVA02luVsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNX9VbzklYXphxMxa91eOdRVdtK85s+69F6VA0nRcgGM9kpFwfGBqZmB5T78Kazmu4qniRZkEshxLc23oZWnPLvz6FX8Ya9Oevb4MO8pmp+yZZvqE3DbaBsfKoirmhes5wrDJHhyvWj2jSCjjUV5vOrNUZekvwWa72S64DC9Z2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=WRGJIZKn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=igdiQqub; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 8CAED1140081;
	Tue, 14 Jan 2025 16:01:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 14 Jan 2025 16:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736888517;
	 x=1736974917; bh=buJ0zveaL6uGmmbT6GwtV2U7xr4PQJvlhIX4JdwqZkI=; b=
	WRGJIZKnnsO5aHczp7NoI3joemFaoFB/ik25aMJIFyL0FvpYtM4VbmBKUMbuMmMC
	2DRiYYpM+xKnOZ1oVgrfpIafZbKbGXjQsQdvr5C2f6bz3o90kOKyto31BDXJdgab
	6TCGrMDvqlMHdf7KK1Jsq6TjGCj2bVViqfJrxMSUhHhfncOvBcTlZzpwgexaJVJV
	dylcQscwSN9/RyvEP2VuNt/FdtvKW4PHZWFBdNo6w6O7yQBNdRfuGUIz7YtZcSTG
	tXFDJRyCJ2tHxYHVdVj3zF2Lyy4n6uBY3+cyHWYy3q0femmQg6nRREImL7GWwiXM
	LQkl90NfDxTrqJqxMpgBoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736888517; x=
	1736974917; bh=buJ0zveaL6uGmmbT6GwtV2U7xr4PQJvlhIX4JdwqZkI=; b=i
	gdiQqub8o0XvT+EfttbM8zU7JrE4qvgAT9gMhgmWiFTNi3ieS9sGPO7eXBZ3Iozw
	BJDrGPmnsnRDT6hMHEDJrGiyDVRxaOSUceO4C3+qlWRgcUarhqBkqJ5l0FaTSKVL
	vNOwmXB+8RbRrkeC5nk/IFyTEse/nltsYT/5/jFRthS6GVCnnNy1/kx17wbb5GPR
	KbKeRIwERA/YCVJIxY22f2E5m03cKUz523CNV85ujNYGJtsHXbRbZT9uyKXigj7h
	t88TMlJ3quUSQsbSJuXUmpBBJ58Xt0QiORj2KgVcxDUxDY18HeeZwVQ4ciYplOaO
	6ArMBuz6U+3k2ZLJOvyTw==
X-ME-Sender: <xms:xdCGZ_FAAY4VVbavtr28gi0YTYHou7YLzi1gcEImH87sy79HuqRG4A>
    <xme:xdCGZ8VIA7ueucB5NUGXrK5_EtjhT4h0W0zXkpCmXq_CB-L3VoCrZtt04Qv38_BgK
    i0CHD1rkbGkM9Go2g>
X-ME-Received: <xmr:xdCGZxJSw3aq0WgJLo00oYc7BytkAzO5H2Sh4kZqZqco2Qa0yOyO8bu3kTIkigqFFXsqwTS00UHRv5NvKgo1PNomzmBrPgXMfyyAWC5FmLWm6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenfghrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffk
    fhggtggugfgjsehtkefstddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguh
    esugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepffffgeegkeejvdejgeehteek
    udfhgfefgeevkeelhfegueeljefhleejtdekveffnecuffhomhgrihhnpehgihhthhhusg
    drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegugihusegugihuuhhurdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhsfhdqphgtsehlihhsthhsrdhlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprh
    gtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xdCGZ9GJYZbFNrNLIR4gW2ZcRuckmax_QMCOoKaLr2XNEStYnLQUmg>
    <xmx:xdCGZ1U4STCuNt82BSrxsoYfHT-ekal_ZHmfdlXTynxjVGo9HqvO4A>
    <xmx:xdCGZ4P2C31xwtsocOxVDneHLVOuYAoUmjKyI4QVZ1t3rX07sNMVkA>
    <xmx:xdCGZ00580pxs39hzZwtqdzx4eqriz43s-Nk_Foq_s7wYRDmwtytTg>
    <xmx:xdCGZ4SJPXDR7RyR8LkqliWYIgWUpC4H7p7NnG_GH7VozNSQ1UwGGUhH>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 16:01:56 -0500 (EST)
Date: Tue, 14 Jan 2025 14:01:55 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Song Liu <song@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Modular BPF verifier
Message-ID: <az6mn2geqofoma4yzioyd5cvarb57mxatm2izupvq3bn4f5wbf@bv7au62xzv4l>
References: <nahst74z46ov7ii3vmriyhk25zo6tkf2f3hsulzjzselvobbbu@pqn6wfdibwqb>
 <CAPhsuW5cLXSjQetTrcEFMAwnjjd1pGR3rLwVBuHkHMuK6xqwMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5cLXSjQetTrcEFMAwnjjd1pGR3rLwVBuHkHMuK6xqwMA@mail.gmail.com>

Hi Song,

On Mon, Jan 13, 2025 at 03:32:59PM -0800, Song Liu wrote:
> On Fri, Jan 10, 2025 at 1:23 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > Hi folks,
> >
> > I'd like to propose modular BPF verifier as a discussion topic.
> 
> Interesting idea!
> 
> I was thinking about "modular verifier" these days, but in a different
> way, i.e., how to divide the verifier into smaller modules (logical
> modules, not necessarily kernel modules). We currently support
> loading kfuncs in kernel modules, so it is natural to put the checks
> of kfuncs into modules (via btf_kfunc_id_set.filter function).
> 
> > === Motivation ===
> >
> > A decade of production experience with BPF has shown that the desire for
> > feature availability outpaces the ability to deliver new kernels into the field
> > [0]. Therefore, the idea of modularizing the BPF subsystem into a loadable
> > kernel module (LKM) has started to look appealing, as this would allow loading
> > newer versions of the BPF subsystem onto older versions of the kernel without a
> > reboot.
> >
> 
> [...]
> 
> >
> > For forward compatibility, the idea is to implement a facade built into each
> > kernel that exposes a stable-enough (non-UAPI) interface such that the verifier
> > can remain portable and “plug in” to the running kernel. While I expect the
> > facade to be necessary, it will not be sufficient. There will eventually be
> > details the facade cannot hide, for example an unavoidable ABI break. To solve
> > for this, I/we [2] will maintain a continuously exported copy of the verifier
> > code in a separate repository. From there we can develop branching, patching,
> > or backport strategies to mitigate breaks. The exact details are TBD and will
> > become more clear as work progresses.
> 
> Maintaining out-of-tree kernel modules is a lot of work. I wonder whether
> the benefit would justify this extra work. There are other ways to make
> small changes to the built-in verifier, i.e. kernel live patch.

The goal (in my mind) is not to maintain a full out-of-tree module.
Rather, it'd be to do a 1-way sync out of the kernel and potentially
apply some out-of-tree compatability patches. Same idea as libbpf:
https://github.com/libbpf/libbpf.

Verifier development should still happen in kernel tree. For folks who
do not care about modular verifier, life should go on same as before.

w.r.t. KLP, I'm not sure KLP satisfies the use case. For example, it
seems unwieldy to potentially live-patch hundreds to thousands of
patches. And since verifier is an algorithm heavy construct, we cannot
get away from data structure changes -- IIUC something KLP is not good
at.

> 
> >
> > On top of delivering newer verifiers to older kernels, the facade opens the
> > door to running the verifier in userspace. If the verifier becomes sufficiently
> > portable, we can implement a userspace facade and plug the verifier in. A
> > possible use case could be integrating the verifier into Clang [3] for tightly
> > integrated verifier feedback. This would address a long running pain point with
> > BPF development. This is a lot easier said than done, so consider this highly
> > speculative.
> 
> I think we don't need the verifier to be a LKM to do verification in user
> space. Instead, we just need a mechanism to bypass (some logic of)
> the verifier. Would this work?

It's the other way around. The goal is not to _move_ verification into
userspace but rather pre-verify. That way when the kernel verifies it
you have a lot more confidence it will succeed.

Thanks,
Daniel

