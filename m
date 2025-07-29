Return-Path: <bpf+bounces-64622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC320B14CD8
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 13:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E78C718A3726
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 11:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B66728C03C;
	Tue, 29 Jul 2025 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2Jyl0EP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3CA217733;
	Tue, 29 Jul 2025 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753787760; cv=none; b=U0Flsmx4VjeMpIGwqXBgOWuN+IwfsQ+BdEPGDbidn0NXGULq2vAHla9XEQFbvBQHw4FFSfQY1VB20g3H6NBWWjUd5UzB2K6DlJYvrDE4bj+Ux7Ch7PcJQQzMkwFoaDzpiqtfpUyBdnN/TcFwJW9MNFT7OkK4DO6eJqU2CRfGUFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753787760; c=relaxed/simple;
	bh=iZdDKCpOu5Auz9Mj8lNCjgC70aG6mdP9nAdrc+6vxpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+otNvX/l4e3VH/4R3EHDF5dBWJR/oRCuBm/EYJLRNTOV+jXlXstjBz1/E53T+eoiX92VpQtT751R/9fT8CgN8zEg2POJVhqHffUUEqYKTEoCewBfyheDrlv2uli9y2cqacUTHSIIVMU5YiQdOlpiMRdsT7WlsX3Qi5QledDRKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2Jyl0EP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5301C4CEEF;
	Tue, 29 Jul 2025 11:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753787759;
	bh=iZdDKCpOu5Auz9Mj8lNCjgC70aG6mdP9nAdrc+6vxpc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m2Jyl0EPmuefAmLhoaMdXD7OK6YHMhvBbpb8JqPtMykw8aLATEZPpC+Jry2KMyaLY
	 expGWN/4yV0J+D/k1QkbnHD7nwCyTuBSdrDpBokZRIm1vKAQ6mu3wfp2slqHXA6ifa
	 LRn7meNojR0sn3fweI3xyiKWamBUpzY4Xz9CYWHXagl+K2Xl474Wa3h563ibR6Zjvj
	 AxJsVp9m6Cn4RUxM3S6gATaqnZWcTsglSScmJnr3eWccT2uAv4h7WrgCffA27Yd3XP
	 l8EWDQUe700GjNhlH6LL4IhoyspGwAOjaa3dmTQcO7ksDZtMQaHnz6/YUmQiru+QKH
	 bbd3csfbbDBLQ==
Message-ID: <b23ed0e2-05cf-454b-bf7a-a637c9bb48e8@kernel.org>
Date: Tue, 29 Jul 2025 13:15:53 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next V2 0/7] xdp: Allow BPF to set RX hints for
 XDP_REDIRECTed packets
To: Jakub Kicinski <kuba@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
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
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250728092956.24a7d09b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/07/2025 18.29, Jakub Kicinski wrote:
> On Mon, 28 Jul 2025 12:53:01 +0200 Lorenzo Bianconi wrote:
>>>> I can see why you might think that, but from my perspective, the
>>>> xdp_frame *is* the implementation of the mini-SKB concept. We've been
>>>> building it incrementally for years. It started as the most minimal
>>>> structure possible and has gradually gained more context (e.g. dev_rx,
>>>> mem_info/rxq_info, flags, and also uses skb_shared_info with same layout
>>>> as SKB).
>>>
>>> My understanding was that just adding all the fields to xdp_frame was
>>> considered too wasteful. Otherwise we would have done something along
>>> those lines ~10 years ago :S
>>
>> Hi Jakub,
>>
>> sorry for the late reply.

Same, back from vacation.

>> I am completely fine to redesign the solution to overcome the problem but I
>> guess this feature will allow us to improve XDP performance in a common/real
>> use-case. Let's consider we want to redirect a packet into a veth and then into
>> a container. Preserving the hw metadata performing XDP_REDIRECT will allow us
>> to avoid recalculating the checksum creating the skb. This will result in a
>> very nice performance improvement.
>> So I guess we should really come up with some idea to add this missing feature.
> 
> 
> Martin mentioned to me that he had proposed in the past that we allow
> allocating the skb at the XDP level, if the program needs "skb-level
> metadata". That actually seems pretty clean to me.. Was it ever
> explored?

That idea has been considered before, but it unfortunately doesn't work
from a performance angle. The performance model of XDP_REDIRECT into
CPUMAP relies on moving the expensive SKB allocation+init to a remote
CPU. This keeps the ingress CPU free to process packets at near line
rate (our DDoS use-case). If we allocate the SKB on the ingress-CPU
before the redirect, we destroy this load-balancing model and create the
exact bottleneck we designed CPUMAP to avoid.

To bring the focus back to the specific problem this series solves,
let's review the concrete use case. Our IPsec scenario is a key example:
on the ingress CPU, an XDP program calculates a hash from inner packet
headers to load-balance traffic via CPUMAP. When the packet arrives on
the remote CPU, this hash is lost, so the new SKB is created with a hash
of zero. This, in turn, causes poor load-balancing when the packet is
forwarded to a multi-queue device like veth, as traffic often collapses
to a single queue. The purpose of this patchset is simply to provide a
standard way to carry that hash to the remote CPU within the xdp_frame.
(Same goes for a standard way to carry VLAN tags)

Given this specific problem, is there a better approach to solving it
than what this patchset proposes?

--Jesper

