Return-Path: <bpf+bounces-48144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4993BA04802
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 18:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83953A47DD
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 17:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC4A1F4E22;
	Tue,  7 Jan 2025 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuPifr2h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1DF1F63C5;
	Tue,  7 Jan 2025 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736270233; cv=none; b=IuNOy0mdI1m5umxs4+etCKODAzfoZZ9TMsveDoUneLuYu8PaPkLZCNPX4L6holbh9FfhyXuDO/dOF/Rvc7x1dVpPGV0KUcSt+QjATJJVLbFRs2YoZVDSUsRU2pdJsHfZS2AEDVead05Gq96iTOcgShPZvJAswnlrAb9u8Xap9/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736270233; c=relaxed/simple;
	bh=JcYsPQnOnlgO+9yf2Fhoi3kdweKCoXAuxTH4OFpUISo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U0LDI3eL/EEqGN9qb+T2jHCUMkJ9f7CY9tZOUhh79kV2giBInY5b/giZHvP2YALd3vbZEQpvQALXwKMvwMNhpwmFx2FvFxjn3NpBZExS8MWfkcS8EFI3N2yLZ1b0Ily4ybMGRqMIf6n5Fr7R55uMM4MwdpKvDQTsZAGz1vB8OC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuPifr2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AF7C4CEDE;
	Tue,  7 Jan 2025 17:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736270233;
	bh=JcYsPQnOnlgO+9yf2Fhoi3kdweKCoXAuxTH4OFpUISo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WuPifr2hEF2567conVGviESfJ9TBd2kPTPXTTGoViuLbItQEeEWHSPLPybvN06tTj
	 4esj16O6oOEqQq0FG+jSZGyQVIwov8GUZ9VkU+88vhOlf7mdv3YruucOEXNtEsy1qj
	 E9LlmvGYvCb0663ivasWXZxpn1OrLb691P0dhl9myfiSUlMQgECG3ZsnSuQMQxclX/
	 /bRsNGKz8iQQ/j3bBM9sgZD+Jv0xonSwNGyWeNY1N0aerNorjjLl2xLLmKNCBX5U2E
	 5bUD5O0hwbzGMAOVtFaZFZjQisofninVl1YuCiehwyB35UMiBBViwOBumpV0I2Kz37
	 lKVdWUaXKcefw==
Message-ID: <5ea87b3d-4fcb-4e20-a348-ff90cd9283d9@kernel.org>
Date: Tue, 7 Jan 2025 18:17:06 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/8] bpf: cpumap: enable GRO for XDP_PASS
 frames
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>,
 kernel-team <kernel-team@cloudflare.com>
References: <20250107152940.26530-1-aleksander.lobakin@intel.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250107152940.26530-1-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Awesome work! - some questions below

On 07/01/2025 16.29, Alexander Lobakin wrote:
> Several months ago, I had been looking through my old XDP hints tree[0]
> to check whether some patches not directly related to hints can be sent
> standalone. Roughly at the same time, Daniel appeared and asked[1] about
> GRO for cpumap from that tree.
> 
> Currently, cpumap uses its own kthread which processes cpumap-redirected
> frames by batches of 8, without any weighting (but with rescheduling
> points). The resulting skbs get passed to the stack via
> netif_receive_skb_list(), which means no GRO happens.
> Even though we can't currently pass checksum status from the drivers,
> in many cases GRO performs better than the listified Rx without the
> aggregation, confirmed by tests.
> 
> In order to enable GRO in cpumap, we need to do the following:
> 
> * patches 1-2: decouple the GRO struct from the NAPI struct and allow
>    using it out of a NAPI entity within the kernel core code;
> * patch 3: switch cpumap from netif_receive_skb_list() to
>    gro_receive_skb().
> 
> Additional improvements:
> 
> * patch 4: optimize XDP_PASS in cpumap by using arrays instead of linked
>    lists;
> * patch 5-6: introduce and use function do get skbs from the NAPI percpu
>    caches by bulks, not one at a time;
> * patch 7-8: use that function in veth as well and remove the one that
>    was now superseded by it.
> 
> My trafficgen UDP GRO tests, small frame sizes:
> 

How does your trafficgen UDP test manage to get UDP GRO working?
(Perhaps you can share test?)

What is the "small frame" size being used?

Is the UDP benchmark avoiding (re)calculating the RX checksum?
(via setting UDP csum to zero)

>                  GRO off    GRO on
> baseline        2.7        N/A       Mpps
> patch 3         2.3        4         Mpps
> patch 8         2.4        4.7       Mpps
> 
> 1...3 diff      -17        +48       %
> 1...8 diff      -11        +74       %
> 
> Daniel reported from +14%[2] to +18%[3] of throughput in neper's TCP RR
> tests. On my system however, the same test gave me up to +100%.
> 

I can imagine that the TCP throughput tests will yield a huge
performance boost.

> Note that there's a series from Lorenzo[4] which achieves the same, but
> in a different way. During the discussions, the approach using a
> standalone GRO instance was preferred over the threaded NAPI.
> 

It looks like you are keeping the "remote" CPUMAP kthread process design
intact in this series, right?

I think this design works for our use-case. For our use-case, we want to
give "remote" CPU-thread higher scheduling priority.  It doesn't matter
if this is a kthread or threaded-NAPI thread, as long as we can see this
as a PID from userspace (by which we adjust the sched priority).

Great to see this work progressing again :-)))
--Jesper

> [0] https://github.com/alobakin/linux/tree/xdp_hints
> [1] https://lore.kernel.org/bpf/cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com
> [2] https://lore.kernel.org/bpf/merfatcdvwpx2lj4j2pahhwp4vihstpidws3jwljwazhh76xkd@t5vsh4gvk4mh
> [3] https://lore.kernel.org/bpf/yzda66wro5twmzpmjoxvy4si5zvkehlmgtpi6brheek3sj73tj@o7kd6nurr3o6
> [4] https://lore.kernel.org/bpf/20241130-cpumap-gro-v1-0-c1180b1b5758@kernel.org
> 
> Alexander Lobakin (8):
>    net: gro: decouple GRO from the NAPI layer
>    net: gro: expose GRO init/cleanup to use outside of NAPI
>    bpf: cpumap: switch to GRO from netif_receive_skb_list()
>    bpf: cpumap: reuse skb array instead of a linked list to chain skbs
>    net: skbuff: introduce napi_skb_cache_get_bulk()
>    bpf: cpumap: switch to napi_skb_cache_get_bulk()
>    veth: use napi_skb_cache_get_bulk() instead of xdp_alloc_skb_bulk()
>    xdp: remove xdp_alloc_skb_bulk()
> 
>   include/linux/netdevice.h                  |  35 ++++--
>   include/linux/skbuff.h                     |   1 +
>   include/net/busy_poll.h                    |  11 +-
>   include/net/gro.h                          |  38 ++++--
>   include/net/xdp.h                          |   1 -
>   drivers/net/ethernet/brocade/bna/bnad.c    |   1 +
>   drivers/net/ethernet/cortina/gemini.c      |   1 +
>   drivers/net/veth.c                         |   3 +-
>   drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c |   1 +
>   kernel/bpf/cpumap.c                        | 131 ++++++++++++++-------
>   net/core/dev.c                             |  79 ++++---------
>   net/core/gro.c                             | 103 ++++++++++------
>   net/core/skbuff.c                          |  62 ++++++++++
>   net/core/xdp.c                             |  10 --
>   14 files changed, 306 insertions(+), 171 deletions(-)
> 
> ---
>  From v1[5]:
> * use a standalone GRO instance instead of the threaded NAPI (Jakub);
> * rebase and send to net-next as it's now more networking than BPF.
> 
> [5] https://lore.kernel.org/bpf/20240830162508.1009458-1-aleksander.lobakin@intel.com

