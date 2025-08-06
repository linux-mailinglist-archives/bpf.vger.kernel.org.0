Return-Path: <bpf+bounces-65096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3B7B1BDE5
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 02:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9145B18C02C0
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 00:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14F36A33B;
	Wed,  6 Aug 2025 00:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLSW0fER"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463A02E36EC;
	Wed,  6 Aug 2025 00:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754440113; cv=none; b=s7y2Usg3ZWP786vrKT9lxEATPrf4+TCzg9DxivWEUoKlV7zGUbV8EQ8TOJ5NL+Q+QRKMeIKvQrPB6zEx7M5aLi75Wpt7PYZKw6kyO040yB9QSkdfsHcgvqfzF1Zia9X3pL/2mLyEjemQchrxdspA0Ikl9aIfFuRvzORchLJaCHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754440113; c=relaxed/simple;
	bh=T1l5rFs8J1rsPA2S6K42eTqv7IjgzvrpjJ3DY/nJQw4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDQsR9rreKe1yZ5s62pEj6JvgDMfhPo0HvHGC31jv8TZdKdF8x4huqvc5tMdIPvDCe5RUN0B6kMvElVMHFHltU8A4ExU3y6cjFZeAhKkrYPE/dRnJbZRm07jMZgd4nFGm8I1y/sgTnrT80sM3p5PBSUYRl+urmko6+Pas4S6HPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLSW0fER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C0DC4CEF0;
	Wed,  6 Aug 2025 00:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754440112;
	bh=T1l5rFs8J1rsPA2S6K42eTqv7IjgzvrpjJ3DY/nJQw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bLSW0fER6LZAIK8b3v5h7nJuSgEFCHwbztxcYf120NHv4XXqXMLjNDAa6F/wbFWqz
	 Ljm+x9cJ0LX1Y+Nd21UzcSI0WY/ipbAiF0okWt0FNakuAGmv9T2KWbzh+2dHRWslnU
	 NlmkhQDQzkHVXeIpGNSBex7mTV3JkGFxBQ3sROBqWT4yUNP3Yt+G2oGDBhnX+WF+7G
	 WMAZiKh4fKMOSi8B+Ws0ps859tBb0YR6VhzDBKRm9Km6It8DtVxLtaW/NmGms0Cv2k
	 hfamRZmpEVMKCMKpPyuVTWLZ8jevXubx+tCc8joJWFDVAMVco1CiOc7pvIJ9MqqPdd
	 yAQDD7mJViFZA==
Date: Tue, 5 Aug 2025 17:28:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Stanislav Fomichev <stfomichev@gmail.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <borkmann@iogearbox.net>, Eric Dumazet
 <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, sdf@fomichev.me, kernel-team@cloudflare.com,
 arthur@arthurfabre.com, jakub@cloudflare.com, Jesse Brandeburg
 <jbrandeburg@cloudflare.com>, Andrew Rzeznik <arzeznik@cloudflare.com>
Subject: Re: [PATCH bpf-next V2 0/7] xdp: Allow BPF to set RX hints for
 XDP_REDIRECTed packets
Message-ID: <20250805172831.213ddd8d@kernel.org>
In-Reply-To: <de68b1d7-86cd-4280-af6a-13f0751228c4@kernel.org>
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
	<20250728092956.24a7d09b@kernel.org>
	<b23ed0e2-05cf-454b-bf7a-a637c9bb48e8@kernel.org>
	<4eaf6d02-6b4e-4713-a8f8-6b00a031d255@linux.dev>
	<21f4ee22-84f0-4d5e-8630-9a889ca11e31@kernel.org>
	<20250801133803.7570a6fd@kernel.org>
	<de68b1d7-86cd-4280-af6a-13f0751228c4@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Aug 2025 15:18:35 +0200 Jesper Dangaard Brouer wrote:
> On 01/08/2025 22.38, Jakub Kicinski wrote:
> > On Thu, 31 Jul 2025 18:27:07 +0200 Jesper Dangaard Brouer wrote:  
> >> I have strong reservations about having the BPF program itself trigger
> >> the SKB allocation. I believe this would fundamentally break the
> >> performance model that makes cpumap redirect so effective.  
> > 
> > See, I have similar concerns about growing struct xdp_frame.
> >   
> 
> IMHO there is a huge difference in doing memory allocs+init vs. growing
> struct xdp_frame.
> 
> It very is important to notice that patchset is actually not growing
> xdp_frame, in the traditional sense, instead we are adding an optional
> area to xdp_frame (plus some flags to tell if area is in-use).  Remember
> the xdp_frame area is not allocated or mem-zeroed (except flags).  If
> not used, the members in struct xdp_rx_meta are never touched.

Yes, I get all that.

> Thus, there is actually no performance impact in growing struct
> xdp_frame in this way. Do you still have concerns?

You're adding code in a number of paths, I don't think it's fair to
claim that there is *no* performance impact. Maybe no impact of
XDP_DROP from the patches themselves, assuming driver doesn't
pre-populate.

Do you have any idea how well this approach will scale to all the fields
people will need in the future to xdp_frame? The nice thing about the
SET ops is that the driver can define whatever ops it supports,
including things not supported by skb (or supported thru skb_ext),
at zero cost to the common stack. If we define the fields in the core
we're back to the inflexibility of the skb world..

> > That's why the guiding principle for me would be to make sure that
> > the features we add, beyond "classic XDP" as needed by DDoS, are
> > entirely optional.   
> 
> Exactly, we agree.  What we do in this patchset is entirely optional.
> These changes does not slowdown "classic XDP" and our DDoS use-case.
> 
> > And if we include the goal of moving skb allocation
> > out of the driver to the xdp_frame growth, the drivers will sooner or
> > later unconditionally populate the xdp_frame. Decreasing performance
> > of "classic XDP"?
> 
> No, that is the beauty of this solution, it will not decrease the
> performance of "classic XDP".
> 
> Do keep-in-mind that "moving skb allocation out of the driver" is not
> part of this patchset and a moonshot goal that will take a long time
> (but we are already "simulation" this via XDP-redirect for years now).
> Drivers should obviously not unconditionally populate the xdp_frame's
> rx_meta area.  It is first time to populate rx_meta, once driver reach
> XDP_PASS case (normal netstack delivery). Today all drivers will at this
> stage populate the SKB metadata (e.g. rx-hash + vlan) from the RX-
> descriptor anyway.  Thus, I don't see how replacing those writes will
> decrease performance.

I don't think it's at all obvious that the driver should not
unconditionally populate the xdp_frame.It seems like the logical
direction to me, TBH. Driver pre-populates, then the conversion
and GET callbacks become trivial and generic..

Perhaps we should try to convert a real driver in this series.

> >> The key to XDP's high performance lies in processing a bulk of
> >> xdp_frames in a tight loop to amortize costs. The existing cpumap code
> >> on the remote CPU is already highly optimized for this: it performs bulk
> >> allocation of SKBs and uses careful prefetching to hide the memory
> >> latency. Allowing a BPF program to sometimes trigger a heavyweight SKB
> >> alloc+init (4 cache-line misses) would bypass all these existing
> >> optimizations. It would introduce significant jitter into the pipeline
> >> and disrupt the entire bulk-processing model we rely on for performance.
> >>
> >> This performance is not just theoretical;  
> > 
> > Somewhat off-topic for the architecture, I think, but do you happen
> > to have any real life data for that? IIRC the "listification" was a
> > moderate success for the skb path.. Or am I misreading and you have
> > other benefits of a tight processing loop in mind?  
> 
> Our "tight processing loop" for NAPI (net_rx_action/napi_pool) is not
> performing as well as we want. One major reason is that the CPU is being
> stalled each time in the loop when the NIC driver needs to clear the 4
> cache-lines for the SKB.  XDP have shown us that avoiding these steps is
> a huge performance boost.

Do you know what uarch resource it's stalling on?
It's been on my minder whether in the attempts to zero out as
little as possible we didn't defeat CPU optimization for clearing
full cache lines.

> The "moving skb allocation out of the driver"
> is one step towards improving the NAPI loop. As you hint we also need
> some bulking or "listification".  I'm not a huge fan of SKB
> "listification". XDP-redirect devmap/cpumap uses an array for creating
> an RX bulk "stage".  The SKB listification work was never fully
> completed IMHO.  Back then, I was working on getting PoC for SKB
> forwarding working, but as soon as we reached any of the netfilter hooks
> points the SKB list would get split into individual SKBs. IIRC SKB
> listification only works for the first part of netstack SKB input code
> path. And "late" part of qdisc TX layer, but the netstack code in-
> between will always cause the SKB list would get split into individual
> SKBs.  IIRC only back-pressure during qdisc TX will cause listification
> to be used. It would be great if someone have cycles to work on
> completing more of the SKB listification.

