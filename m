Return-Path: <bpf+bounces-64818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFA7B174E5
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 18:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A551C24E93
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 16:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AF523B61D;
	Thu, 31 Jul 2025 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZaMgvHN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5312E4689;
	Thu, 31 Jul 2025 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753979234; cv=none; b=d2sijG5e0W+0Q6UIEmCBhQHcG5phMuaOXApPcAQufknarJF929CixIqO4MhINlLnmHuxpWfEk2wwughiRYsutOtE75piGaa/yTUaecx3E8tiD1ncwsWhh1a9gFSy5NnxzLZ691RuB6fu100X0sBD6LmGnT08I8QqwnFBWbkBf34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753979234; c=relaxed/simple;
	bh=w8zPghMey97QS1cCGTZoq+bYPBtjBu/Irw/E7uwtxjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mX0HkYX2ZQ3ywj1FiSPwx7mijYUkflh/bEvPtqLSbku18kXcwUTqPRzuTTeShPSDAWibC4/I6+whpNlVovSPtYUiu3OY+C/c38C00IEbH93FoONZT9OVnQPJ53UcTxipsz/oqIX997wdRdD2UNC7hgDJVeSFF+4VNf2YpLmx21c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZaMgvHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75F1C4CEEF;
	Thu, 31 Jul 2025 16:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753979233;
	bh=w8zPghMey97QS1cCGTZoq+bYPBtjBu/Irw/E7uwtxjE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AZaMgvHNy8dOaTLmR7dcuJ2FOna+aMEalh6SYCWIfiTL9eEFW7RqfBi59jkDq6fEp
	 ROVt0Cq1TSrd8kHF9tbnBl60WAZv3a7FfqeWME1//swwKlcCKQ8S3IYg3fOg7YV5Sy
	 YisMJiGt7uLWb0cQnyHly2SBZFOADCnCIuFOUs0fh5icablGNdggbJs/gfhbyHx9mb
	 hr8lNvZWwIYic9+cmIh1M/Z+aA09kQquv2ap74zoeWqbqc848/ZFSPyKij/fIFJ1PA
	 ianyPzRXNxYn6eOe4mgowoWngiiDc4BCP5CJybpvuV1p0drt7W3CMvQ7uVB2+3hFS0
	 XvnTItm42vQug==
Message-ID: <21f4ee22-84f0-4d5e-8630-9a889ca11e31@kernel.org>
Date: Thu, 31 Jul 2025 18:27:07 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next V2 0/7] xdp: Allow BPF to set RX hints for
 XDP_REDIRECTed packets
To: Martin KaFai Lau <martin.lau@linux.dev>, Jakub Kicinski
 <kuba@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <borkmann@iogearbox.net>,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
 kernel-team@cloudflare.com, arthur@arthurfabre.com, jakub@cloudflare.com,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>,
 Andrew Rzeznik <arzeznik@cloudflare.com>
References: <b1873a92-747d-4f32-91f8-126779947e42@kernel.org>
 <aGvcb53APFXR8eJb@mini-arch> <aG427EcHHn9yxaDv@lore-desk>
 <aHE2F1FJlYc37eIz@mini-arch> <aHeKYZY7l2i1xwel@lore-desk>
 <20250716142015.0b309c71@kernel.org>
 <fbb026f9-54cf-49ba-b0dc-0df0f54c6961@kernel.org>
 <20250717182534.4f305f8a@kernel.org>
 <ebc18aba-d832-4eb6-b626-4ca3a2f27fe2@kernel.org>
 <20250721181344.24d47fa3@kernel.org> <aIdWjTCM1nOjiWfC@lore-desk>
 <20250728092956.24a7d09b@kernel.org>
 <b23ed0e2-05cf-454b-bf7a-a637c9bb48e8@kernel.org>
 <4eaf6d02-6b4e-4713-a8f8-6b00a031d255@linux.dev>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <4eaf6d02-6b4e-4713-a8f8-6b00a031d255@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/07/2025 21.47, Martin KaFai Lau wrote:
> On 7/29/25 4:15 AM, Jesper Dangaard Brouer wrote:
>> That idea has been considered before, but it unfortunately doesn't work
>> from a performance angle. The performance model of XDP_REDIRECT into
>> CPUMAP relies on moving the expensive SKB allocation+init to a remote
>> CPU. This keeps the ingress CPU free to process packets at near line
>> rate (our DDoS use-case). If we allocate the SKB on the ingress-CPU
>> before the redirect, we destroy this load-balancing model and create the
>> exact bottleneck we designed CPUMAP to avoid.
> 
> iirc, a xdp prog can be attached to a cpumap. The skb can be created by 
> that xdp prog running on the remote cpu. It should be like a xdp prog 
> returning a XDP_PASS + an optional skb. The xdp prog can set some fields 
> in the skb. Other than setting fields in the skb, something else may be 
> also possible in the future, e.g. look up sk, earlier demux ...etc.
> 

I have strong reservations about having the BPF program itself trigger
the SKB allocation. I believe this would fundamentally break the
performance model that makes cpumap redirect so effective.

The key to XDP's high performance lies in processing a bulk of
xdp_frames in a tight loop to amortize costs. The existing cpumap code
on the remote CPU is already highly optimized for this: it performs bulk
allocation of SKBs and uses careful prefetching to hide the memory
latency. Allowing a BPF program to sometimes trigger a heavyweight SKB
alloc+init (4 cache-line misses) would bypass all these existing
optimizations. It would introduce significant jitter into the pipeline
and disrupt the entire bulk-processing model we rely on for performance.

This performance is not just theoretical; we rely on it for DDoS
protection. For example, our plan is to use the XDP program on the
cpumap hook to run secondary DDoS mitigation rules that currently use
iptables (funny, many rules are actually BPF program snippets today).

Architecturally, there is a clean separation today: the BPF program
makes a decision, and the highly-optimized cpumap or core kernel code
acts on it (build_skb, napi_gro_receive, etc). Your proposal blurs this
line significantly. Our patch, in contrast, preserves this model. It
simply provides the necessary data (the hash, vlan and timestamp) to the
existing cpumap/veth skb path via the xdp_frame.

While more advanced capabilities are an interesting topic for the
future, my goal here is to solve the immediate, concrete problem of
transferring metadata cleanly, without disrupting the performance
architecture we rely on for use cases like DDoS mitigation.

--Jesper


