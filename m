Return-Path: <bpf+bounces-21895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7BF853CF9
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 22:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C001C26792
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 21:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D86F61679;
	Tue, 13 Feb 2024 21:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="h/FZeJqm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GysW0BV4"
X-Original-To: bpf@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897A66166D;
	Tue, 13 Feb 2024 21:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858539; cv=none; b=MkdtiivCvl3YLrLqnIbiSzgdoDR3D+kOCZOqfCuNF8fa+n365AlVudbdc4LJlVFcDsRN0v0oqKaX0PcxZfA+LJVkGBxjKKe+bHOuhsK52c2kOZuUZqTTwPSNaA5gbmBVd5TFvHZArjfY6R0ROPPzWYZCLfF6D2rbzoU3vbuXJ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858539; c=relaxed/simple;
	bh=ng462qQizCjYYSN6BAOfse1PoLyEhBQpuqEkECNoHv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjT6QdPJyEgYklMXCgr1zv70mWoL96KfyAOE7CsEOiEwp7zt1xEaFW/WVUadpI4hOatZiI3Hz++VWyiQ018IyqQJrSZq8uap0nrdoXLYucy/aLuTlK8l+mW3gQVB1QGU4/wpI02ezTPtk9l/ZFh+fvCfdTtGBLHE3ERAaKoxhfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=h/FZeJqm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GysW0BV4; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 74ABE5C00E0;
	Tue, 13 Feb 2024 16:08:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 13 Feb 2024 16:08:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1707858536;
	 x=1707944936; bh=+SBciZiT6vEzM12Yvi5B9bmxj/6Jh0lugT098mnxOwU=; b=
	h/FZeJqmk82sHAe/NfujKJf8cE5OCLjqPEx6i7kbDNGDcjBX2a8wf3V+hwAVehzW
	d6BImC3+cjmfJpTMru5MgcNBr0lHpwQ8RFonBaquyTnJ40/IXAmz14Ja6KcTowhd
	/yp0wBuRfyXy6m9JU7PQvVHPCRzVcjwXZ6n0AC3uipFdMFaXlsMycHs6t7GC/Q9q
	t7rxxNfFuML6eFVJociEDDu3cEEQU8YMQx2FfcTc4ACqaClNQnfWk1NGvPFA/Gj+
	eJkPeT9+i5LsHdnJQbqruyKGaj80+UbzEUKOlyYOcizUb0ORgq6wHg9iAUtBnQQo
	VIhr8IJ988A+OQRppTh8Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707858536; x=
	1707944936; bh=+SBciZiT6vEzM12Yvi5B9bmxj/6Jh0lugT098mnxOwU=; b=G
	ysW0BV4R36wOEy3h5UdzylXppNBOo2Bnf/JJTjDIn+h4Kmm66qVL1q+ss4sTTIpa
	X0KIYUpm7fpjT/KVId5HRT05ktCTaQpvyBgVjbtywFS8dPwB1RwRBBjf5d7r/etx
	q+0NxXvFV07d+M/ieTuKqUmoPe9mMPMhd9zp96TGSYl6cLhDVaBIQvza+vokL+Fc
	gkLG6HJA9KYfYi0twsVBhAXrIpTmmEEfUXxfqhkPSQdaWFBv4rqGow1vJB6EnXJu
	NzdgRDJibTGkqJhOJAmGWP/dw/4sSaPRxkjwzPHzU0jkFaCSbnEO1HYT40fvNeAv
	ajbEm2LN9gJWBpPJP6C3w==
X-ME-Sender: <xms:aNrLZVcbFvOitqjgc0kmtC2t-uDJIZ5L3NNignqqb2drxDFeQKllOQ>
    <xme:aNrLZTPqI0v7PnVI_BGrgcL04-41_05rpAJiG51H3_-a2m9gNl8VYqgt0Dym76pjB
    2uRV9tyZ9aUBAQaDw>
X-ME-Received: <xmr:aNrLZejhGFvXsvWRL-HTBRl_xdZTL8CY0wIwgNb-1LncnbOpT4tWr-Dqbsa7Zz8XmidH7m_vqElwfzaRv57CPa5c6MJRbw-NLkK3Np0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgddugeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhfgggtugfgjgestheksfdt
    tddtjeenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpedvuddvudeiteefjeegheeuudfhgefhkeekteeulefggeev
    heevieekffffiedvtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdr
    giihii
X-ME-Proxy: <xmx:aNrLZe8LUtuSFzqFgweHVSe9hQ14dMYAzUIDz6g3tCN_M__wMvIhWQ>
    <xmx:aNrLZRuTP5coCsNyzv4Ls9LzZTlm1OgKgRtWEYYAiSt85tVrAhi3rA>
    <xmx:aNrLZdGABgyE2v2Qm4gfgver3oR_cxXvcitXOvnYL84idHWZ3IXT5A>
    <xmx:aNrLZfXpRYIL7WUy5bB3hZUgbqB3l6SapHWhGP6Lh4-g4dqH6AAZ0A>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Feb 2024 16:08:55 -0500 (EST)
Date: Tue, 13 Feb 2024 14:08:54 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, andrii@kernel.org, 
	olsajiri@gmail.com, quentin@isovalent.com, alan.maguire@oracle.com
Subject: Re: [PATCH bpf-next v2 0/2] bpf, bpftool: Support dumping kfunc
 prototypes from BTF
Message-ID: <ogy7lbgnlvpmgfpd5ag4la6qsroddrvl4t6uxojr4faexsl7qb@ltrvn7kku5v4>
References: <cover.1707080349.git.dxu@dxuuu.xyz>
 <CAEf4Bzb8dvboBVe-qN4+KEG_=phcMxCL25dr0ysjdVx5-MentQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb8dvboBVe-qN4+KEG_=phcMxCL25dr0ysjdVx5-MentQ@mail.gmail.com>

On Tue, Feb 13, 2024 at 11:09:29AM -0800, Andrii Nakryiko wrote:
> On Sun, Feb 4, 2024 at 1:06 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > This patchset enables dumping kfunc prototypes from bpftool. This is
> > useful b/c with this patchset, end users will no longer have to manually
> > define kfunc prototypes. For the kernel tree, this also means we can
> > drop kfunc prototypes from:
> >
> >         tools/testing/selftests/bpf/bpf_kfuncs.h
> >         tools/testing/selftests/bpf/bpf_experimental.h
> >
> > Example usage:
> >
> >         $ make PAHOLE=/home/dxu/dev/pahole/build/pahole -j30 vmlinux
> >
> >         $ ./tools/bpf/bpftool/bpftool btf dump file ./vmlinux format c | rg "__ksym;" | head -3
> >         extern void cgroup_rstat_updated(struct cgroup *cgrp, int cpu) __weak __ksym;
> >         extern void cgroup_rstat_flush(struct cgroup *cgrp) __weak __ksym;
> >         extern struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags) __weak __ksym;
> >
> > Note that this patchset is only effective after the enabling pahole [0]
> > change is merged and the resulting feature enabled with
> > --btf_features=decl_tag_kfuncs.
> >
> > [0]: https://lore.kernel.org/bpf/cover.1707071969.git.dxu@dxuuu.xyz/
> >
> > === Changelog ===
> >
> > From v1:
> > * Add __weak annotation
> > * Use btf_dump for kfunc prototypes
> > * Update kernel bpf_rdonly_cast() signature
> >
> > Daniel Xu (2):
> >   bpf: Have bpf_rdonly_cast() take a const pointer
> >   bpftool: Support dumping kfunc prototypes from BTF
> 
> I've applied patch #1 as it's a good change regardless. Please send v2
> for patch #2.

Ack. Been a bit busy recently - will probably have time to work on this
again next weekend.


