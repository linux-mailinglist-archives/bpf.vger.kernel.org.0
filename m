Return-Path: <bpf+bounces-63975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E05D3B0CF03
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 03:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB67542F38
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 01:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E5B19C546;
	Tue, 22 Jul 2025 01:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tj3iW3d8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355D6156677;
	Tue, 22 Jul 2025 01:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753146827; cv=none; b=D2DyCjpfhNmYvTvLnDRe2OoR+bZBE/jiGux/S6jb/dio8nzrxxsaW1x7al3WHjUvXEg9QomXpimuqEkJi0izZeCpsjoIZvOO0ehd2GmM+WleP9WlU/Gs77WRMZO/vNRjR80TGzaOEOH4x7DmsMp1sQtUxNsdPuG8Zy6rFJshKaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753146827; c=relaxed/simple;
	bh=IomN0U2iNd6WXxaGDGSojq3NGe3wnNTxSPa5F+b6tOI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZlVqBEYx4Qg1GGUC59IRjwLt56+8kMfgghx8DHxV7j/AHVwAxnzuSzAEqDuVPsibJmqDPWp01GNFavO8RYBJ0Ea3rXPEdfrzkFySoEdcaedJni5gpk3HWuTLBhRD351vwdDgjCT90AtXEJz6Vr3fJIssxKP+VJ18B6DN2mfLKXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tj3iW3d8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3086EC4CEED;
	Tue, 22 Jul 2025 01:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753146825;
	bh=IomN0U2iNd6WXxaGDGSojq3NGe3wnNTxSPa5F+b6tOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tj3iW3d84vaWooxanhe3gZe4OhbeAC4pXf7FX9oQoarMNgB/Yux+mLxmTvu+d1I3d
	 1AsFWfUgbnDWRNXBXxlLrK6ZMwdN/w/jXQi0a/ShdC5Od/+PSUYAxJnC+KCF7M74UM
	 qtYLzvbCIaMi9pjoUw4j+Ib+cN2qamBPTY3GsxdD57r3AbZokbNHrDDXcCpPqMaicJ
	 UWGyqpA1xfnYihhD+BuMGnA6a9IsCkkiGXp0gP+wNzNOwn64Cx9BrNM5WnJGW9RpGg
	 5HH9gm5Fss2tHHwq/9zzhEBvC2dFZ2coFQtau7pKJpI51iybWXHXoCkAyeW1dqlZlw
	 H/ObSTHSVjpzw==
Date: Mon, 21 Jul 2025 18:13:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Stanislav Fomichev
 <stfomichev@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <borkmann@iogearbox.net>,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
 kernel-team@cloudflare.com, arthur@arthurfabre.com, jakub@cloudflare.com,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>
Subject: Re: [PATCH bpf-next V2 0/7] xdp: Allow BPF to set RX hints for
 XDP_REDIRECTed packets
Message-ID: <20250721181344.24d47fa3@kernel.org>
In-Reply-To: <ebc18aba-d832-4eb6-b626-4ca3a2f27fe2@kernel.org>
References: <175146824674.1421237.18351246421763677468.stgit@firesoul>
	<aGVY2MQ18BWOisWa@mini-arch>
	<b1873a92-747d-4f32-91f8-126779947e42@kernel.org>
	<aGvcb53APFXR8eJb@mini-arch>
	<aG427EcHHn9yxaDv@lore-desk>
	<aHE2F1FJlYc37eIz@mini-arch>
	<aHeKYZY7l2i1xwel@lore-desk>
	<20250716142015.0b309c71@kernel.org>
	<fbb026f9-54cf-49ba-b0dc-0df0f54c6961@kernel.org>
	<20250717182534.4f305f8a@kernel.org>
	<ebc18aba-d832-4eb6-b626-4ca3a2f27fe2@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Jul 2025 12:56:46 +0200 Jesper Dangaard Brouer wrote:
> >> Thanks for the feedback. I can see why you'd be concerned about adding
> >> another adhoc scheme or making xdp_frame grow into a "para-skb".
> >>
> >> However, I'd like to frame this as part of a long-term plan we've been
> >> calling the "mini-SKB" concept. This isn't a new idea, but a
> >> continuation of architectural discussions from as far back as [2016].  
> > 
> > My understanding is that while this was floated as a plan by some,
> > nobody came up with a clean way of implementing it.  
> 
> I can see why you might think that, but from my perspective, the
> xdp_frame *is* the implementation of the mini-SKB concept. We've been
> building it incrementally for years. It started as the most minimal
> structure possible and has gradually gained more context (e.g. dev_rx,
> mem_info/rxq_info, flags, and also uses skb_shared_info with same layout
> as SKB).

My understanding was that just adding all the fields to xdp_frame was
considered too wasteful. Otherwise we would have done something along
those lines ~10 years ago :S

> This patch is simply the next logical step in that existing evolution:
> adding hardware metadata to make it more capable, starting with enabling
> XDP_REDIRECT offloads. The xdp_frame is our mini-SKB, and this patchset
> continues its evolution.

I thought one of the goals for mini-skb was to move the skb allocation
out of the drivers. The patches as posted seem to make it the
responsibility of the XDP program to save the metadata. If you're
planning to make drivers populate this metadata by default - why add
the helpers.

Again, I just don't understand how these logically fit into place
vis-a-vis the existing metadata "get" callbacks.

