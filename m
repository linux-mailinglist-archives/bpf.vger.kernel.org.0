Return-Path: <bpf+bounces-65232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 710DDB1DD04
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 20:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DDED1897E48
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 18:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACA827380E;
	Thu,  7 Aug 2025 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djfWU8sz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A8F27147B;
	Thu,  7 Aug 2025 18:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754591219; cv=none; b=XS2VDA2DuLxhBcaCd1nsz+q2i/qX8x83BtQxwjgsiiD34tT80t8FYYiXWyLLFamti+IdEbCCoVxxqAFZhim1yJkcQl8B3i9Om58477Df7Vj8L6S1KwLXd+3pVmg+fqixlWLHb96ge3/sIAQsLvIrpnxUj/RW485pa0LUlbcrKzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754591219; c=relaxed/simple;
	bh=Ouux2wY7O8BLulvkoxhFQ8eQo7ttiYWTtXZ5SxKgbm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=At6OmTUoL8k6wr8nQQM6jl1H3InZ+rvEQbjFigUuwbi/aUT2WmMIGlq3rR0ZnTnWnIefcX5L4TXby11FdgdtBpxbz4Lp6+aj9kglC1YxIzNoh1JoaZpkuVQ35NIAWqgJHvENAngowKHRqk914zkDjiK55RvglD8x4NKxy4DZqQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djfWU8sz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3786CC4CEEB;
	Thu,  7 Aug 2025 18:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754591219;
	bh=Ouux2wY7O8BLulvkoxhFQ8eQo7ttiYWTtXZ5SxKgbm8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=djfWU8szI6B6tFffWQkhNltE+wo21qSOUZUXo3jdE7xOw02+0xL0pcI99/AI95+EE
	 ikBf3RDWaTnGICnJSC8OzcDyY66ZKGXYVlLN8Oz5zjjB/bgT0GigVmHRDl47/38+1A
	 eGnUJoMfkVZsTtsmATxEWDZ1VgZH69Oig44qtflX9c+VdTiIBxzP1H9vFmWX3I9YuK
	 xvotG5WnDMf0By5yIaXnpP5e8LeXgAzKZgZx3G0hyxqe/NtYzyKGilPSoB51w9kSVW
	 PvIvQHgA5rZsF61RHdHRuR7ujLPpLBuoIwxxYaU+lPK23H5hQ+mA00PZ+PkBkDcTeS
	 uqeB/QTYvcJQg==
Message-ID: <17cfcb03-62bb-40e4-991b-78b743329ca8@kernel.org>
Date: Thu, 7 Aug 2025 20:26:53 +0200
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
 <de68b1d7-86cd-4280-af6a-13f0751228c4@kernel.org>
 <20250805172831.213ddd8d@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250805172831.213ddd8d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/08/2025 02.28, Jakub Kicinski wrote:
> On Mon, 4 Aug 2025 15:18:35 +0200 Jesper Dangaard Brouer wrote:
>> On 01/08/2025 22.38, Jakub Kicinski wrote:
>>> On Thu, 31 Jul 2025 18:27:07 +0200 Jesper Dangaard Brouer wrote:
>>>> I have strong reservations about having the BPF program itself trigger
>>>> the SKB allocation. I believe this would fundamentally break the
>>>> performance model that makes cpumap redirect so effective.
>>>
>>> See, I have similar concerns about growing struct xdp_frame.
>>>    
>>
>> IMHO there is a huge difference in doing memory allocs+init vs. growing
>> struct xdp_frame.
>>
>> It very is important to notice that patchset is actually not growing
>> xdp_frame, in the traditional sense, instead we are adding an optional
>> area to xdp_frame (plus some flags to tell if area is in-use).  Remember
>> the xdp_frame area is not allocated or mem-zeroed (except flags).  If
>> not used, the members in struct xdp_rx_meta are never touched.
> 
> Yes, I get all that.
> 
>> Thus, there is actually no performance impact in growing struct
>> xdp_frame in this way. Do you still have concerns?
> 
> You're adding code in a number of paths, I don't think it's fair to
> claim that there is *no* performance impact. Maybe no impact of
> XDP_DROP from the patches themselves, assuming driver doesn't
> pre-populate.
> 

I feel a need to state this.  The purpose of this patchset is to
increase the performance, by providing access to offload hints.  The
common theme is that these offload hints can help us avoid data cache-
misses and/or avoid some steps in software.  Setting VLAN
(__vlan_hwaccel_put_tag) avoids an extra trip through the RX-handler.
Setting RX-hash avoids this calling into flow_dissector to SW calc. The
RX-hash is an extended type, that already knows the packet type IPv4/
IPv6 and UDP/TCP, thus it can simplify BPF-code needed.  We are missing 
checksum offload, as Lorenzo mentions, but that is the plan, as it has 
the most gain (for TCP csum_partial is in perf top for cpumap).


> Do you have any idea how well this approach will scale to all the fields
> people will need in the future to xdp_frame? The nice thing about the
> SET ops is that the driver can define whatever ops it supports,
> including things not supported by skb (or supported thru skb_ext),
> at zero cost to the common stack. If we define the fields in the core
> we're back to the inflexibility of the skb world..
> 

This is where traits come in. For now the struct has static members, but
we want to convert this to a dynamic struct based on traits, if demand
for more members is proposed. The patchset API allows us to change to
this approach later.

The SET ops API requires two XDP program, one at physical NIC, and one 
at veth, and agreement for side-band layout for transferring e.g RX-hash 
and timestamp.  The veth XDP-prog need to run on the peer-device, for 
containers this is the veth device inside the container. If veth 
XDP-prog doesn't clear data_meta area, then GRO aggregation breaks (e.g 
for timestamp usage).
Good luck getting this to work for containers.

Our solution works out-of-the-box for containers. We only need one 
XDP-prog on at physical NIC, that will supply missing hardware offload 
for XDP-redirect into the veth device.


>>> That's why the guiding principle for me would be to make sure that
>>> the features we add, beyond "classic XDP" as needed by DDoS, are
>>> entirely optional.
>>
>> Exactly, we agree.  What we do in this patchset is entirely optional.
>> These changes does not slowdown "classic XDP" and our DDoS use-case.
>>
>>> And if we include the goal of moving skb allocation
>>> out of the driver to the xdp_frame growth, the drivers will sooner or
>>> later unconditionally populate the xdp_frame. Decreasing performance
>>> of "classic XDP"?
>>
>> No, that is the beauty of this solution, it will not decrease the
>> performance of "classic XDP".
>>
>> Do keep-in-mind that "moving skb allocation out of the driver" is not
>> part of this patchset and a moonshot goal that will take a long time
>> (but we are already "simulation" this via XDP-redirect for years now).
>> Drivers should obviously not unconditionally populate the xdp_frame's
>> rx_meta area.  It is first time to populate rx_meta, once driver reach
>> XDP_PASS case (normal netstack delivery). Today all drivers will at this
>> stage populate the SKB metadata (e.g. rx-hash + vlan) from the RX-
>> descriptor anyway.  Thus, I don't see how replacing those writes will
>> decrease performance.
> 
> I don't think it's at all obvious that the driver should not
> unconditionally populate the xdp_frame.It seems like the logical
> direction to me, TBH. Driver pre-populates, then the conversion
> and GET callbacks become trivial and generic..
> 

This is related to when cache-lines are ready.  All XDP drivers
prefetchw the xdp_frame area before starting XDP-prog.  Thus, driver
want to delay writing until this cache-line is ready.

> Perhaps we should try to convert a real driver in this series.
> 

What do you mean?
This series is about the XDP_REDIRECT case, so we don't need to modify
any physical NIC driver.

Do you want this series to include the ability to XDP-override the
hardware offloads for RX-hash and VLAN for the XDP_PASS case for a real
physical NIC driver?


>>>> The key to XDP's high performance lies in processing a bulk of
>>>> xdp_frames in a tight loop to amortize costs. The existing cpumap code
>>>> on the remote CPU is already highly optimized for this: it performs bulk
>>>> allocation of SKBs and uses careful prefetching to hide the memory
>>>> latency. Allowing a BPF program to sometimes trigger a heavyweight SKB
>>>> alloc+init (4 cache-line misses) would bypass all these existing
>>>> optimizations. It would introduce significant jitter into the pipeline
>>>> and disrupt the entire bulk-processing model we rely on for performance.
>>>>
>>>> This performance is not just theoretical;
>>>
>>> Somewhat off-topic for the architecture, I think, but do you happen
>>> to have any real life data for that? IIRC the "listification" was a
>>> moderate success for the skb path.. Or am I misreading and you have
>>> other benefits of a tight processing loop in mind?
>>
>> Our "tight processing loop" for NAPI (net_rx_action/napi_pool) is not
>> performing as well as we want. One major reason is that the CPU is being
>> stalled each time in the loop when the NIC driver needs to clear the 4
>> cache-lines for the SKB.  XDP have shown us that avoiding these steps is
>> a huge performance boost.
> 
> Do you know what uarch resource it's stalling on?
> It's been on my minder whether in the attempts to zero out as
> little as possible we didn't defeat CPU optimization for clearing
> full cache lines.
>

The main performance stall problem with zeroing is the 'rep
stos' (repeated string store) operation.
See comments in this memset micro benchmark [1]
  [1] 
https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/lib/time_bench_memset.c

Memset of 32 bytes (or less) will result in MOVQ instructions, which is
really fast. Large sizes the compiler usually creates 'rep stos'
instructions, which have high "startup" cost.

--Jesper


