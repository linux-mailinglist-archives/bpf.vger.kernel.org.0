Return-Path: <bpf+bounces-65001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432D2B1A317
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 15:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E9F3B03E9
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 13:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0050C265637;
	Mon,  4 Aug 2025 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cO/bTQ82"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCCB26136D;
	Mon,  4 Aug 2025 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754313521; cv=none; b=r3qeTLk5xoL7GlAq6WkBAgt4YFvXcfTst06ZOFY+QLyISUDAQ9O31F04ORMb4pj02byqXsCxYgU5V3jwuDR/rIyKKYJjF+cxb/MIOWxvhMVATmtDs7Zs7xe86zXOztydzXULd5lupmZZxTsemZVaFOM8dUr49mKGuJ9M/qS20zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754313521; c=relaxed/simple;
	bh=Tkk4+t+dFqTOZm++s1naWey6M4k5HYMwzIAi/9j7gf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8WSsL/uGCRwYjJwE3a3aqXU/Ny2hi+aEb9U96iUdxPhQ880X7AzEBJ5giaBbI2iCnzW9wP9cmVAOLjTUAqM3QGCIM8JlJ1Csbvus7nGQAC8BCVVWD2/NWQ+EHf3uZu5IKzPOr3QE8DBBGKj7zJQmw4L39C2vJ8Cj7qS0UJuYKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cO/bTQ82; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E68C4CEE7;
	Mon,  4 Aug 2025 13:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754313520;
	bh=Tkk4+t+dFqTOZm++s1naWey6M4k5HYMwzIAi/9j7gf0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cO/bTQ82xs8gpbUVqYV4dsg6q8+tweO2XuaoGVVDRv04gznO58G40gRTpe02ud6da
	 YaKLwBhyNOJC7ccSBuDi92PpdtZIyX8FJ1AXluHXL50HJTccIsESg32lIccEp0ocRW
	 EreleFElajIdHRm73hj/X/Qi2c6MT8SP6PBoKdOwlBHeEluTObp/jEE/3ZY1DwlZn0
	 +3wTKuyJM63RhrZiWPt4h/RTpikIFOND9hQYxK/a1h26bq0mIikmF1L1QTOv9whudt
	 Wci98ZlxRLQuXDOqtWelg+CO4w6ahYNK68ts8lwlu9hbjORfnC5+ZHz6H979W8RUpQ
	 1aTg8qJ4l/f3A==
Message-ID: <de68b1d7-86cd-4280-af6a-13f0751228c4@kernel.org>
Date: Mon, 4 Aug 2025 15:18:35 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next V2 0/7] xdp: Allow BPF to set RX hints for
 XDP_REDIRECTed packets
To: Jakub Kicinski <kuba@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Stanislav Fomichev <stfomichev@gmail.com>, bpf@vger.kernel.org,
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
 <21f4ee22-84f0-4d5e-8630-9a889ca11e31@kernel.org>
 <20250801133803.7570a6fd@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250801133803.7570a6fd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/08/2025 22.38, Jakub Kicinski wrote:
> On Thu, 31 Jul 2025 18:27:07 +0200 Jesper Dangaard Brouer wrote:
>>> iirc, a xdp prog can be attached to a cpumap. The skb can be created by
>>> that xdp prog running on the remote cpu. It should be like a xdp prog
>>> returning a XDP_PASS + an optional skb. The xdp prog can set some fields
>>> in the skb. Other than setting fields in the skb, something else may be
>>> also possible in the future, e.g. look up sk, earlier demux ...etc.
>>
>> I have strong reservations about having the BPF program itself trigger
>> the SKB allocation. I believe this would fundamentally break the
>> performance model that makes cpumap redirect so effective.
> 
> See, I have similar concerns about growing struct xdp_frame.
> 

IMHO there is a huge difference in doing memory allocs+init vs. growing
struct xdp_frame.

It very is important to notice that patchset is actually not growing
xdp_frame, in the traditional sense, instead we are adding an optional
area to xdp_frame (plus some flags to tell if area is in-use).  Remember
the xdp_frame area is not allocated or mem-zeroed (except flags).  If
not used, the members in struct xdp_rx_meta are never touched. Thus,
there is actually no performance impact in growing struct xdp_frame in
this way. Do you still have concerns?


> That's why the guiding principle for me would be to make sure that
> the features we add, beyond "classic XDP" as needed by DDoS, are
> entirely optional. 

Exactly, we agree.  What we do in this patchset is entirely optional.
These changes does not slowdown "classic XDP" and our DDoS use-case.


> And if we include the goal of moving skb allocation
> out of the driver to the xdp_frame growth, the drivers will sooner or
> later unconditionally populate the xdp_frame. Decreasing performance
> of "classic XDP"?
>

No, that is the beauty of this solution, it will not decrease the
performance of "classic XDP".

Do keep-in-mind that "moving skb allocation out of the driver" is not
part of this patchset and a moonshot goal that will take a long time
(but we are already "simulation" this via XDP-redirect for years now).
Drivers should obviously not unconditionally populate the xdp_frame's
rx_meta area.  It is first time to populate rx_meta, once driver reach
XDP_PASS case (normal netstack delivery). Today all drivers will at this
stage populate the SKB metadata (e.g. rx-hash + vlan) from the RX-
descriptor anyway.  Thus, I don't see how replacing those writes will
decrease performance.


>> The key to XDP's high performance lies in processing a bulk of
>> xdp_frames in a tight loop to amortize costs. The existing cpumap code
>> on the remote CPU is already highly optimized for this: it performs bulk
>> allocation of SKBs and uses careful prefetching to hide the memory
>> latency. Allowing a BPF program to sometimes trigger a heavyweight SKB
>> alloc+init (4 cache-line misses) would bypass all these existing
>> optimizations. It would introduce significant jitter into the pipeline
>> and disrupt the entire bulk-processing model we rely on for performance.
>>
>> This performance is not just theoretical;
> 
> Somewhat off-topic for the architecture, I think, but do you happen
> to have any real life data for that? IIRC the "listification" was a
> moderate success for the skb path.. Or am I misreading and you have
> other benefits of a tight processing loop in mind?

Our "tight processing loop" for NAPI (net_rx_action/napi_pool) is not
performing as well as we want. One major reason is that the CPU is being
stalled each time in the loop when the NIC driver needs to clear the 4
cache-lines for the SKB.  XDP have shown us that avoiding these steps is
a huge performance boost.  The "moving skb allocation out of the driver"
is one step towards improving the NAPI loop. As you hint we also need
some bulking or "listification".  I'm not a huge fan of SKB
"listification". XDP-redirect devmap/cpumap uses an array for creating
an RX bulk "stage".  The SKB listification work was never fully
completed IMHO.  Back then, I was working on getting PoC for SKB
forwarding working, but as soon as we reached any of the netfilter hooks
points the SKB list would get split into individual SKBs. IIRC SKB
listification only works for the first part of netstack SKB input code
path. And "late" part of qdisc TX layer, but the netstack code in-
between will always cause the SKB list would get split into individual
SKBs.  IIRC only back-pressure during qdisc TX will cause listification
to be used. It would be great if someone have cycles to work on
completing more of the SKB listification.

--Jesper


