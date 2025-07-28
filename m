Return-Path: <bpf+bounces-64540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE6AB1404B
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 18:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC09B7A41C3
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 16:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7812127465C;
	Mon, 28 Jul 2025 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuNSdIFE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE74288A8;
	Mon, 28 Jul 2025 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753720198; cv=none; b=rlnaBizstGwbarZL0IcCmWqYodqOJXVl5jOxBwPupvjIUSFtNZQ3qAnOVMja74FG+WoJakRtMUFF7DnGZ1rCQfy7BiDdpHAnGDIMJJzFsdxJUh0Q8Q0kyIyylUpyvYZ4zwzovPY6jH/vCEY2kBxAKUEPqWFwczoeRULNtz6H43E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753720198; c=relaxed/simple;
	bh=hTgIClXCO8dhqDTT7ZlkH+dwL+Yk0C5vu+lwUpFYhfY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LyVivLRGXJIN0x1QRPJ0u7e8fcYIMgZio9LaNTpvKlxhy/LxPssBoWb8IcgD4GSW9GihYP3olc4cIQhbbrHcl2VVAqxEMZYCoLecyBzFh2HHP3I0vXrkmdM66bGbVBg+2VWwrElAgWRpYiIBVHWXOHMj3L1lH1FVrKaUW7kbrqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuNSdIFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04738C4CEE7;
	Mon, 28 Jul 2025 16:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753720197;
	bh=hTgIClXCO8dhqDTT7ZlkH+dwL+Yk0C5vu+lwUpFYhfY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tuNSdIFET1U2kT2pVmIwojDTtndStKas+1v3EUsZypzK8+wtaIdO1gOm5MC4TmNk5
	 6Q2SGM0r1m+1csYCNsKyeuLrYEX1Ym/QYxTz+Ry/NhfNoByInxHoD7D9/YjERGtMww
	 qmZoP1sIIVku0Twmj9GNH/4wonZjAbWm6pVcJ1vIsmzl6drFoiwBEWdypflhvrF05m
	 fPTEnD7PbEizf6clsR4/2s+sFDuL+bQNFYkq+Vpl2fXSasdr6kO4dlv00wyiaoh3UK
	 sFhmZIHYtjnfw5M18kdqJ4vdUIInNDSPHNji1ytP8hxX9vqTrcMA9LWjIKIoVgTNUh
	 wozlAuVoFhX8A==
Date: Mon, 28 Jul 2025 09:29:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Stanislav Fomichev
 <stfomichev@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <borkmann@iogearbox.net>,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
 kernel-team@cloudflare.com, arthur@arthurfabre.com, jakub@cloudflare.com,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>
Subject: Re: [PATCH bpf-next V2 0/7] xdp: Allow BPF to set RX hints for
 XDP_REDIRECTed packets
Message-ID: <20250728092956.24a7d09b@kernel.org>
In-Reply-To: <aIdWjTCM1nOjiWfC@lore-desk>
References: <b1873a92-747d-4f32-91f8-126779947e42@kernel.org>
	<aGvcb53APFXR8eJb@mini-arch>
	<aG427EcHHn9yxaDv@lore-desk>
	<aHE2F1FJlYc37eIz@mini-arch>
	<aHeKYZY7l2i1xwel@lore-desk>
	<20250716142015.0b309c71@kernel.org>
	<fbb026f9-54cf-49ba-b0dc-0df0f54c6961@kernel.org>
	<20250717182534.4f305f8a@kernel.org>
	<ebc18aba-d832-4eb6-b626-4ca3a2f27fe2@kernel.org>
	<20250721181344.24d47fa3@kernel.org>
	<aIdWjTCM1nOjiWfC@lore-desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Jul 2025 12:53:01 +0200 Lorenzo Bianconi wrote:
> > > I can see why you might think that, but from my perspective, the
> > > xdp_frame *is* the implementation of the mini-SKB concept. We've been
> > > building it incrementally for years. It started as the most minimal
> > > structure possible and has gradually gained more context (e.g. dev_rx,
> > > mem_info/rxq_info, flags, and also uses skb_shared_info with same layout
> > > as SKB).  
> > 
> > My understanding was that just adding all the fields to xdp_frame was
> > considered too wasteful. Otherwise we would have done something along
> > those lines ~10 years ago :S  
> 
> Hi Jakub,
> 
> sorry for the late reply.
> I am completely fine to redesign the solution to overcome the problem but I
> guess this feature will allow us to improve XDP performance in a common/real
> use-case. Let's consider we want to redirect a packet into a veth and then into
> a container. Preserving the hw metadata performing XDP_REDIRECT will allow us
> to avoid recalculating the checksum creating the skb. This will result in a
> very nice performance improvement.
> So I guess we should really come up with some idea to add this missing feature.

I don't think the counter-proposal prevents that. As long as veth
supports "set" callbacks the program can transfer the metadata over
to the veth and the second program at veth can communicate them to 
the driver.

Martin mentioned to me that he had proposed in the past that we allow
allocating the skb at the XDP level, if the program needs "skb-level
metadata". That actually seems pretty clean to me.. Was it ever
explored?

