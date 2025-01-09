Return-Path: <bpf+bounces-48325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D7CA06A2C
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 02:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17A03A4F80
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 01:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9514CBA50;
	Thu,  9 Jan 2025 01:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="sKX3UTZE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MnQGTqY7"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947034A2D;
	Thu,  9 Jan 2025 01:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736385999; cv=none; b=VgWa/+xVC64ETHlAtrOmkGXMwa745p+/5ahyYcmnYMILMXNC0ibBCbtxQFpcvFSqNNc42FiFryULrnny3NGeikVsmpYQTjhMbZ7UOpx1mU32OtsfqqIlNZTtB0nVVGNQs6mp6DYdUOHNOLA4YQFp7MHu4vhOGbObrujPQvxi5Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736385999; c=relaxed/simple;
	bh=Qa94rIxRNr87wG4lDeE7S2MvSEdx7oqC5lfhCUDKcTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrEH+H/kgPg0FK/OBVIgllVWiGJ634IqcY1bpDQg5fOq5NF18SV5dXVoaJKJCdse6gDiDBOuwhtRwpKGdsdXXERLhufu7rDHRST0469u3U++f6G93f5BAJe3Fd0tCydDggeveTIupL/lVKyv4sS/0/fUEe1HpAixht+mpEWgDW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=sKX3UTZE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MnQGTqY7; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1225225400FB;
	Wed,  8 Jan 2025 20:26:35 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 08 Jan 2025 20:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736385994; x=1736472394; bh=I+++ok79gq
	//q32XDGa1devMJNN0I5EysJnhvNYULcA=; b=sKX3UTZEOxr+bedrUonnOmaUyw
	qZ2T+WwPvAd75Mj2PNYFyDf4ezEJzevYSeKQPitvejcPkdqcY50k/0uEJZzax3pA
	aHdtyIkOfs3diJSERICl11g9oiBdA1BP5F4mO9/VpaLQTDSqaT3bmeoWamw/pjQ/
	LwXUe1sgyQSQItV4u94NcUl5BrbLUyCc1x6OAIZAP0F4qDAbWonWKZFrs+YhKlV7
	5+yYBNhp+wplBvnD/jnA6HqlSIQXaVNkxMeWIupK3auA9zp7BryfSYK3GlFl2hO9
	OnNH0Uq8SOeXmgzMl/1KPdqupQD9nbZSOMSWp4qLQWhWUZP5w1Vdul38rZtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736385994; x=1736472394; bh=I+++ok79gq//q32XDGa1devMJNN0I5EysJn
	hvNYULcA=; b=MnQGTqY7pDVM0V0hGnCMMeIOXCqw4M3NlyJR49SQVWI5VbEnQhD
	Dgph3oRZ47q+s0X2FTgAlnTNKGJyBLPeF9vycCkJMtIJmaHU85iFpZ34qvgoPuvk
	vgiecr9wSD5CHbWkfoAkt9/RYx5BOrKkIEVg9WxJWz1NgwBVRAYYgnRHkZtUSvHG
	T7wKfRLkKnS6KF8pfsF/VkozQ4OCRiJU4VatoB5vLoszrw7PfmjXIdf19kKDpINj
	rS/QAKss0/PJGOS4sxxbz/iApmRbSF8e9hWkw+pdP3dm9MDi9CYiYdGJXOkQnurK
	Oemw88vSnExKhYVnO58KU8W1PugCCGc5dYA==
X-ME-Sender: <xms:yiV_Z2NuYtpkqU6LsPkJ7k-EOGj5877nc42xECVqmT3MpWPy1FfQGg>
    <xme:yiV_Z08OUFBQRlIxI74qcKZIiPHgRc2EbVODdiLx3TYrq7D8WGgC0e2fl2dnGeYmA
    LGP1llo0BvEJ3AZOw>
X-ME-Received: <xmr:yiV_Z9RpJckJbLgkiWPBhMxtFRrk-Owio2lzhM_h82O6h33NrI6V5TZ0uOkQQ7pNHbZcGXRFGphkONKoN8pBFE4RBG46W7AL7J4hKBxLJMTFTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeghedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdfstddttddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesug
    iguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffek
    uedukeehudffudfffffggeeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghrtghp
    thhtohepudelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhrgifkheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprghlvghkshgrnhguvghrrdhlohgsrghkihhnsehi
    nhhtvghlrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrd
    gthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthht
    ohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopehlohhrvghniihosehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrsh
    htsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yiV_Z2vzVe6AHwxtMUAQ2zXM7hDQMgRRCj45LXmsOW_9tjzbhZj0kw>
    <xmx:yiV_Z-eKMiAW-jC-l31LxawmdKfp4FZPsP1gze5FV1m5B1Yhynofkg>
    <xmx:yiV_Z61KK_61twDcCnkWEZ-NDn0L8W7lNIMlqvc3EIAjW_KfUzzTkA>
    <xmx:yiV_Zy_Ln20E3KivjxjQI0qsCHw10OPpOwImobMy800oMKwOxVjC-w>
    <xmx:yiV_Z7D83PtSNFITI12mHzIRRde0cN0_-qzl1-au6Ow0BLUfK1HFsgZ0>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 20:26:32 -0500 (EST)
Date: Wed, 8 Jan 2025 18:26:30 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesse Brandeburg <jbrandeburg@cloudflare.com>, kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH net-next v2 0/8] bpf: cpumap: enable GRO for XDP_PASS
 frames
Message-ID: <f7jrsvdauqebendldnyvjjsjypyxoqozwr3awtvo2bjv5t7xzm@p3owykvczayu>
References: <20250107152940.26530-1-aleksander.lobakin@intel.com>
 <5ea87b3d-4fcb-4e20-a348-ff90cd9283d9@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ea87b3d-4fcb-4e20-a348-ff90cd9283d9@kernel.org>

On Tue, Jan 07, 2025 at 06:17:06PM +0100, Jesper Dangaard Brouer wrote:
> Awesome work! - some questions below
> 
> On 07/01/2025 16.29, Alexander Lobakin wrote:
> > Several months ago, I had been looking through my old XDP hints tree[0]
> > to check whether some patches not directly related to hints can be sent
> > standalone. Roughly at the same time, Daniel appeared and asked[1] about
> > GRO for cpumap from that tree.
> > 
> > Currently, cpumap uses its own kthread which processes cpumap-redirected
> > frames by batches of 8, without any weighting (but with rescheduling
> > points). The resulting skbs get passed to the stack via
> > netif_receive_skb_list(), which means no GRO happens.
> > Even though we can't currently pass checksum status from the drivers,
> > in many cases GRO performs better than the listified Rx without the
> > aggregation, confirmed by tests.
> > 
> > In order to enable GRO in cpumap, we need to do the following:
> > 
> > * patches 1-2: decouple the GRO struct from the NAPI struct and allow
> >    using it out of a NAPI entity within the kernel core code;
> > * patch 3: switch cpumap from netif_receive_skb_list() to
> >    gro_receive_skb().
> > 
> > Additional improvements:
> > 
> > * patch 4: optimize XDP_PASS in cpumap by using arrays instead of linked
> >    lists;
> > * patch 5-6: introduce and use function do get skbs from the NAPI percpu
> >    caches by bulks, not one at a time;
> > * patch 7-8: use that function in veth as well and remove the one that
> >    was now superseded by it.
> > 
> > My trafficgen UDP GRO tests, small frame sizes:
> > 
> 
> How does your trafficgen UDP test manage to get UDP GRO working?
> (Perhaps you can share test?)
> 
> What is the "small frame" size being used?
> 
> Is the UDP benchmark avoiding (re)calculating the RX checksum?
> (via setting UDP csum to zero)
> 
> >                  GRO off    GRO on
> > baseline        2.7        N/A       Mpps
> > patch 3         2.3        4         Mpps
> > patch 8         2.4        4.7       Mpps
> > 
> > 1...3 diff      -17        +48       %
> > 1...8 diff      -11        +74       %
> > 
> > Daniel reported from +14%[2] to +18%[3] of throughput in neper's TCP RR
> > tests. On my system however, the same test gave me up to +100%.
> > 
> 
> I can imagine that the TCP throughput tests will yield a huge
> performance boost.
> 
> > Note that there's a series from Lorenzo[4] which achieves the same, but
> > in a different way. During the discussions, the approach using a
> > standalone GRO instance was preferred over the threaded NAPI.
> > 
> 
> It looks like you are keeping the "remote" CPUMAP kthread process design
> intact in this series, right?
> 
> I think this design works for our use-case. For our use-case, we want to
> give "remote" CPU-thread higher scheduling priority.  It doesn't matter
> if this is a kthread or threaded-NAPI thread, as long as we can see this
> as a PID from userspace (by which we adjust the sched priority).
> 

Similiar for us as well - having a schedulable entity helps. I might
have mentioned it on an earlier thread, but with sched-ext, I think
things could get interesting for dynamically tuning the system. We've
got some vague ideas. Probably not this upcoming one, but maybe if any
of the ideas work we'll share them at netdev or something.

> Great to see this work progressing again :-)))

Agreed, thanks for continuing!

Daniel

