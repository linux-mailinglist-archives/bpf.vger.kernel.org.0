Return-Path: <bpf+bounces-62250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 162B3AF71EE
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 13:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176DB1C4757A
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 11:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AC129827E;
	Thu,  3 Jul 2025 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJzd3D2M"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A293B676;
	Thu,  3 Jul 2025 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751541438; cv=none; b=PDVrf7PEI9NV7wmsHlLnLAav47sDl7u2NOb5KgGiUl+Jum3GBgEd3fLEVCEQCzVHZUWCF3JgGdHM4DftTG19/jJaCAn5mbnq9fxqOXcsJVsp08TIXgxik6e6+1SC2Gavvh7PzCDjK+TPydvmcP9KD63V4Fs1rKKdMVTN6Nk3bSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751541438; c=relaxed/simple;
	bh=y4UWQSSEHzDgqrKigOY/0qL0DrZ0LBfqAvqAWDm0rg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tRc6aV/y5OmuWZURxBL6eUZZdOgoXomxSBys2Mo8QiIR53Cz8/YSXomv6NQiI6GfkTcLmn5jbvpeahKwLXqg03KBYscCNTdLOHwTo7S4ZWPdv3jd4gdE0mAYndbTZEARFb2953q5TZUFeN0CSFupenGV5TSFaYtIfrny3yPEwak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJzd3D2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5C1C4CEE3;
	Thu,  3 Jul 2025 11:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751541437;
	bh=y4UWQSSEHzDgqrKigOY/0qL0DrZ0LBfqAvqAWDm0rg8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HJzd3D2MDDqwuGR1ukWT+gHG5RgUxbAAKDlexpO/rQ0a0yaUU215P+Jg3lzsmCcth
	 e3M7jp811b/fTh9xA8JzuPZUsvhliLxcwu4I64xmVwccqyqVvRB/TdxxYRpqKyn4/N
	 jNea05H60exM/zwUvzO5jS6w+kC/lwIaqlN4rTU8FTfMOm16v39sKEumtZ5/q5LRcU
	 lblpSKhLbelFMYJ5R6OZAuwRUigT76dncdSZC/kjCQVp9WwN8DN2i3ffOSXsajpuES
	 JGJ1R3DtffVY2OMMBArB/CdfSr+Srom1abB8KciEiUUkdQAzDBw9K8HQgNJcIOZ+AC
	 HqiPLbZv6amfA==
Message-ID: <b1873a92-747d-4f32-91f8-126779947e42@kernel.org>
Date: Thu, 3 Jul 2025 13:17:13 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next V2 0/7] xdp: Allow BPF to set RX hints for
 XDP_REDIRECTed packets
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, lorenzo@kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <borkmann@iogearbox.net>, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 sdf@fomichev.me, kernel-team@cloudflare.com, arthur@arthurfabre.com,
 jakub@cloudflare.com
References: <175146824674.1421237.18351246421763677468.stgit@firesoul>
 <aGVY2MQ18BWOisWa@mini-arch>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <aGVY2MQ18BWOisWa@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/07/2025 18.05, Stanislav Fomichev wrote:
> On 07/02, Jesper Dangaard Brouer wrote:
>> This patch series introduces a mechanism for an XDP program to store RX
>> metadata hints - specifically rx_hash, rx_vlan_tag, and rx_timestamp -
>> into the xdp_frame. These stored hints are then used to populate the
>> corresponding fields in the SKB that is created from the xdp_frame
>> following an XDP_REDIRECT.
>>
>> The chosen RX metadata hints intentionally map to the existing NIC
>> hardware metadata that can be read via kfuncs [1]. While this design
>> allows a BPF program to read and propagate existing hardware hints, our
>> primary motivation is to enable setting custom values. This is important
>> for use cases where the hardware-provided information is insufficient or
>> needs to be calculated based on packet contents unavailable to the
>> hardware.
>>
>> The primary motivation for this feature is to enable scalable load
>> balancing of encapsulated tunnel traffic at the XDP layer. When tunnelled
>> packets (e.g., IPsec, GRE) are redirected via cpumap or to a veth device,
>> the networking stack later calculates a software hash based on the outer
>> headers. For a single tunnel, these outer headers are often identical,
>> causing all packets to be assigned the same hash. This collapses all
>> traffic onto a single RX queue, creating a performance bottleneck and
>> defeating receive-side scaling (RSS).
>>
>> Our immediate use case involves load balancing IPsec traffic. For such
>> tunnelled traffic, any hardware-provided RX hash is calculated on the
>> outer headers and is therefore incorrect for distributing inner flows.
>> There is no reason to read the existing value, as it must be recalculated.
>> In our XDP program, we perform a partial decryption to access the inner
>> headers and calculate a new load-balancing hash, which provides better
>> flow distribution. However, without this patch set, there is no way to
>> persist this new hash for the network stack to use post-redirect.
>>
>> This series solves the problem by introducing new BPF kfuncs that allow an
>> XDP program to write e.g. the hash value into the xdp_frame. The
>> __xdp_build_skb_from_frame() function is modified to use this stored value
>> to set skb->hash on the newly created SKB. As a result, the veth driver's
>> queue selection logic uses the BPF-supplied hash, achieving proper
>> traffic distribution across multiple CPU cores. This also ensures that
>> consumers, like the GRO engine, can operate effectively.
>>
>> We considered XDP traits as an alternative to adding static members to
>> struct xdp_frame. Given the immediate need for this functionality and the
>> current development status of traits, we believe this approach is a
>> pragmatic solution. We are open to migrating to a traits-based
>> implementation if and when they become a generally accepted mechanism for
>> such extensions.
>>
>> [1] https://docs.kernel.org/networking/xdp-rx-metadata.html
>> ---
>> V1: https://lore.kernel.org/all/174897271826.1677018.9096866882347745168.stgit@firesoul/
> 
> No change log?

We have fixed selftest as requested by Alexie.
And we have updated cover-letter and doc as you Stanislav requested.

> 
> Btw, any feedback on the following from v1?
> - https://lore.kernel.org/netdev/aFHUd98juIU4Rr9J@mini-arch/

Addressed as updated cover-letter and documentation. I hope this helps 
reviewers understand the use-case, as the discussion turn into "how do 
we transfer all HW metadata", which is NOT what we want (and a waste of 
precious cycles).

For our use-case, it doesn't make sense to "transfer all HW metadata".
In fact we don't even want to read the hardware RH-hash, because we 
already know it is wrong (for tunnels), we just want to override the 
RX-hash used at SKB creation.  We do want the BPF programmers 
flexibility to call these kfuncs individually (when relevant).

> - https://lore.kernel.org/netdev/20250616145523.63bd2577@kernel.org/

I feel pressured into critiquing Jakub's suggestion, hope this is not 
too harsh.  First of all it is not relevant to our this patchset 
use-case, as it focus on all HW metadata.

Second, I disagree with the idea/mental model of storing in a 
"driver-specific format". The current implementation of driver-specific 
kfunc helpers that "get the metadata" is already doing a conversion to a 
common format, because the BPF-programmer naturally needs this to be the 
same across drivers.  Thus, it doesn't make sense to store it back in a 
"driver-specific format", as that just complicate things.  My mental 
model is thus, that after the driver-specific "get" operation to result 
is in a common format, that is simply defined by the struct type of the 
kfunc, which is both known by the kernel and BPF-prog.

--Jesper

