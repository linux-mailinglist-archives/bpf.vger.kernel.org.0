Return-Path: <bpf+bounces-48870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BFCA1146B
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 23:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ED867A205E
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 22:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623E0213245;
	Tue, 14 Jan 2025 22:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="eEfZgRFb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C/NOlEDr"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FD71D47BD
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 22:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895157; cv=none; b=W06d3PG4lnPDTh+K1P5IK+wu90bRBCXL49rFRYuA9Yrfm85lCwEDmkoJPBK4l3CIbEVy6qdWhRoVW4x+KE3hDbsojPg7q2GOmrnPILjKJAYuHmUpaKWPoemMK+OuWG8Mfl9Sl9XDsevUstcKMkz2vDfYPmj3X/1r9DrbQZ4cf/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895157; c=relaxed/simple;
	bh=z97WtJPdKsYrYADS2aiNI+ztlYqInLjFlEjj62iNl0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQfcWgjBIyrovqbFZmhpiTRdGrEOIxDNBRhKc7y2zi6YPT8b35hYx5HIejLNwFCHhpYzBCCtbXBkd4wMOxTe2EingApbzdLJGwZ3wf+VQ+asQ9zozbtiKM8nlWz9DPvT28h0aKIGhTDml43ZnCAWXehUNRDobGQ7bFHEtR6aFjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=eEfZgRFb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C/NOlEDr; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AEBE525400C3;
	Tue, 14 Jan 2025 17:52:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 14 Jan 2025 17:52:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736895153;
	 x=1736981553; bh=RtM7/GKnpn9TmijFXyF4OZQaPNksGwUvx/+HLuZgK+Q=; b=
	eEfZgRFbBmF9HONrG/+ORz1Wgx0kOLmlcy9jutE8WDGC+TKUNH2GIaHxGJ+qe68S
	s48W2hODmgiLIbbNAa4qcNbZUNxZ6phI+94cFlYTwxwJ+uC0nouU2mcBv+P0wEw0
	oZ2Oi552SGGW6TfHXSCF3wdLAnB6hHXkPqJ9clE9QzTxqHBr0HYc/AVhbw3WI7hN
	Bn0SCHLlxrVBsoLMM1MH3+dWfRuljEjw/vfPnl6WChzsl729xmsTmQsYhkbL9XN+
	JlUBbmG7+o4NA4rCRlt8HNE8qDN5EE5VVRzirglcbF1ojp+AUrmDJAUMU2hofWPa
	818fMVxGffbCvp72LKXUsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736895153; x=
	1736981553; bh=RtM7/GKnpn9TmijFXyF4OZQaPNksGwUvx/+HLuZgK+Q=; b=C
	/NOlEDr357ZCseQvsR/NQPcRLbYiZExA6k9/EkHGzcNJ1SIMTHzUVbmLRW5khF1F
	LZjnCiAHnJvrjrCJIlXAT4Sul8n4kRrg1mSzYbIt/3VqNyv7D8YEh7ALCpP/bCzE
	czYX6Rc2gGzWCrilafbaWyPCyOOrqzOPj00hr6fhtZz0xqXxJZ0HGFPmlJy90eKj
	Xo6puzBe1qr8yRd05cWSDROHHgUAqViGieK7EBA+/FymELGS0Zjvm+Ub9s309U7l
	GCduSJ8htZsKoqr5CkRphSHvI/ULKpTYBHuJ3y/ITJ9vxVjGDX51ngz2x7/R+5DM
	Ia7puOU6nMkxBhs2FUxpQ==
X-ME-Sender: <xms:seqGZ2dk6kGl823sYZO3TvA-v5EVntGxN0DipZrmpaQPqvoTTFUebA>
    <xme:seqGZwNm68_m8B00gwQ1LEo4FUIoxQtQdTnwIRPIgFSFzDtcjHjI2BaoW6ECvbOTZ
    pTpFOIT5aF9YPYMpw>
X-ME-Received: <xmr:seqGZ3h5BaF4mCc3YNXHhLdZ71-13d_VhZzOHf11ocVL3Y0qauiTSV57KnKIpUcsXvrJR_hts2kq2BXlpEJPZNt4838WH4z_olmqWFr44S1Nyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehjedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgestheksfdttddtjeenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihuse
    gugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeffffeggeekjedvjeegheetkedu
    hffgfeegveeklefhgeeuleejhfeljedtkeevffenucffohhmrghinhepghhithhhuhgsrd
    gtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    ugiguhesugiguhhuuhdrgiihiidpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    shhfqdhptgeslhhishhtshdrlhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtg
    hpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:seqGZz_0-cnwVqkF2fmZABAgGDcbrjq_ieJYpN9lGtMnEBEXD6dJ8w>
    <xmx:seqGZytdNZmfW9pDo83zG7H2t6ke4PEQbNF0HLHw3j60tOAk7T5P8g>
    <xmx:seqGZ6Hp99v3Ugy9lvrDoQ-s3-UZPQB8i9KAfI8K-aOcdi4J6za-rg>
    <xmx:seqGZxOxftWzS9667SCCIQfsryPMveCurpx6B3GEgaA6WuHiH9yBFQ>
    <xmx:seqGZ2KC_f0nDfZbzYjeOCNPqAfnFLubo7hxYumm-He_03HCjYHNz4hE>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 17:52:32 -0500 (EST)
Date: Tue, 14 Jan 2025 15:52:30 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Song Liu <song@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Modular BPF verifier
Message-ID: <map7vxw2arz2k6tkdvmklojr3nvqjw7hodar2fgqs4ik6ee5k5@phw476yjpjjn>
References: <nahst74z46ov7ii3vmriyhk25zo6tkf2f3hsulzjzselvobbbu@pqn6wfdibwqb>
 <CAPhsuW5cLXSjQetTrcEFMAwnjjd1pGR3rLwVBuHkHMuK6xqwMA@mail.gmail.com>
 <az6mn2geqofoma4yzioyd5cvarb57mxatm2izupvq3bn4f5wbf@bv7au62xzv4l>
 <CAPhsuW6Dm0zLzaa+yx_cC2tWy8M-jv0=VpdZWY=oh=MVV+z1hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6Dm0zLzaa+yx_cC2tWy8M-jv0=VpdZWY=oh=MVV+z1hw@mail.gmail.com>

On Tue, Jan 14, 2025 at 01:29:11PM -0800, Song Liu wrote:
> Hi Daniel,
> 
> On Tue, Jan 14, 2025 at 1:02 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > Hi Song,
> >
> > On Mon, Jan 13, 2025 at 03:32:59PM -0800, Song Liu wrote:
> > > On Fri, Jan 10, 2025 at 1:23 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> [...]
> > >
> > > Maintaining out-of-tree kernel modules is a lot of work. I wonder whether
> > > the benefit would justify this extra work. There are other ways to make
> > > small changes to the built-in verifier, i.e. kernel live patch.
> >
> > The goal (in my mind) is not to maintain a full out-of-tree module.
> > Rather, it'd be to do a 1-way sync out of the kernel and potentially
> > apply some out-of-tree compatability patches. Same idea as libbpf:
> > https://github.com/libbpf/libbpf.
> 
> The idea can be practical if we can support the verifier with the same
> model as libbpf. But I am not sure whether this is possible.

Based on the research I've done, I believe it should be possible. I have
some notes laying around but my plan is to start prototyping soon to
prove this to myself. If there are specific concerns about why it'd be
impossible, I'd appreciate hearing about it - better to find out early :)

A separate point to consider would be if modular verifier can be done in
a clean way. That would be on me to prove.

> 
> > Verifier development should still happen in kernel tree. For folks who
> > do not care about modular verifier, life should go on same as before.
> >
> > w.r.t. KLP, I'm not sure KLP satisfies the use case. For example, it
> > seems unwieldy to potentially live-patch hundreds to thousands of
> > patches. And since verifier is an algorithm heavy construct, we cannot
> > get away from data structure changes -- IIUC something KLP is not good
> > at.
> 
> It is correct that it is only practical to make small changes with KLPs. But I
> wonder how often we do need major changes to the verifier.

The overarching goal is to deploy as many upstream changes as possible
to older installed kernels. So I'd say there are a lot of major changes
we'd way to deploy. For example, it would be reasonable (at this point
in time) to want to deploy something like this diff stat:

$ git --no-pager diff v6.6..HEAD --stat -- kernel/bpf/verifier.c
 kernel/bpf/verifier.c | 8907 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 6142 insertions(+), 2765 deletions(-)

Wouldn't it also be problematic to have two changes modifying the same
function? Seems like operational hassle to start merging patches.

> 
> > >
> > > >
> > > > On top of delivering newer verifiers to older kernels, the facade opens the
> > > > door to running the verifier in userspace. If the verifier becomes sufficiently
> > > > portable, we can implement a userspace facade and plug the verifier in. A
> > > > possible use case could be integrating the verifier into Clang [3] for tightly
> > > > integrated verifier feedback. This would address a long running pain point with
> > > > BPF development. This is a lot easier said than done, so consider this highly
> > > > speculative.
> > >
> > > I think we don't need the verifier to be a LKM to do verification in user
> > > space. Instead, we just need a mechanism to bypass (some logic of)
> > > the verifier. Would this work?
> >
> > It's the other way around. The goal is not to _move_ verification into
> > userspace but rather pre-verify. That way when the kernel verifies it
> > you have a lot more confidence it will succeed.
> 
> I think we had the pre-verify idea for quite some time. It will be
> valuable if we can manage it without much extra effort. (Development
> happens in the kernel, etc.)

Agreed.

