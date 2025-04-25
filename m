Return-Path: <bpf+bounces-56695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00E6A9CAE7
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 15:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87DD71771AC
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 13:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FA72512FC;
	Fri, 25 Apr 2025 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJoIfGIG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527B424A064;
	Fri, 25 Apr 2025 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745589358; cv=none; b=PZ4CX0TNqx+i91LCPOvptfeGfIaE8kdqu8i/3YI35cmZNMxtQK7puxctoRlZZRgv8bd50MHub7Ps5gV30Sw8lr5g+jJdkB4NptMzrKGNi0Wr4UH0tdEp8JkONknqBqyD/ZKLLViFujttPE0zBv2R/QG7YxF9rbgxQ7oU7PXCBHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745589358; c=relaxed/simple;
	bh=YokcS2D2iQiKHDReHt9kQSlK8t5kwna9CdetyF0P2Ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYunq6CjpGJhl02rcxoDv6TbP34HR6yy/H2g4CF2UdUrL5mtU2YQKTFhQFXYcqmXWbiJQkHF9P0OyETe8zuQD7sU8de+dXEzpFOPWH684NsX3LN8p3yBE7fINWP2dnpWgahwAxMXAnHkNTh0ghGPz3BpcnhGCPKjtYzwihCyADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJoIfGIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2C5C4CEE4;
	Fri, 25 Apr 2025 13:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745589357;
	bh=YokcS2D2iQiKHDReHt9kQSlK8t5kwna9CdetyF0P2Ac=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tJoIfGIGMrHqV1pNdWoAsGy4BopgWNY2ZGOyoCtZx2+vezGAmp+ecFOeVoK83JTJV
	 m5GdjO7HOKNzBDaG5r7Dow9KaLcfbPn/mIqN4vQULgeBJOadkRqGcqajGSnnn+aWwq
	 XECyYzMFsV9QiYvaRBxMHm637guqB1cXFnJIE0mU3n4Yx9EM7ZDdfJNyNcJ2jI946D
	 ZIvp97vhrWvok6rrWJ6qRV+nwZIqLGoMpUN1NEkqLcN4+2F1023RzJ7RI2PsvNRTYQ
	 VXdKNjPKR2GG5aOd3ZFpWj72Z3LLw+86qBEHUYQHvAtenJtuOOAoGvMIikz/qihGk+
	 jiP5AtWux5FVw==
Message-ID: <d36cb5a0-902c-4de5-bdd2-cbf9e1b1c7b1@kernel.org>
Date: Fri, 25 Apr 2025 15:55:52 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V6 2/2] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, tom@herbertland.com,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp,
 kernel-team@cloudflare.com, phil@nwl.cc
References: <174549933665.608169.392044991754158047.stgit@firesoul>
 <174549940981.608169.4363875844729313831.stgit@firesoul>
 <20250424072352.18aa0df1@kernel.org>
 <c6abaa9f-cd3e-4259-bed6-5e795ff58ecd@kernel.org>
 <20250424085358.75d817ae@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250424085358.75d817ae@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/04/2025 17.53, Jakub Kicinski wrote:
> On Thu, 24 Apr 2025 17:24:51 +0200 Jesper Dangaard Brouer wrote:
>>> Looks like I wrote a reply to v5 but didn't hit send. But I may have
>>> set v5 to Changes Requested because of it :S Here is my comment:
>>>
>>>    I think this is missing a memory barrier. When drivers do this dance
>>>    there's usually a barrier between stop and recheck, to make sure the
>>>    stop is visible before we check. And vice versa veth_xdp_rcv() needs
>>>    to make sure other side sees the "empty" indication before it checks
>>>    if the queue is stopped.
>>
>> The call netif_tx_stop_queue(txq); already contains a memory barrier
>> smp_mb__before_atomic() plus an atomic set_bit operation.  That should
>> be sufficient.
> 
> That barrier is _before_ stopping the queue. I'm saying we need a
> barrier between stop and emptiness re-check. Note that:
>   - smp_mb__after_atomic() is enough, and it 'compiles' to nothing
>     on x86

I see, I will add a smp_mb__after_atomic() after netif_tx_stop_queue()
and send a V7.  I considered an atomic operation a full memory-barrier,
which I guess is correct for x86 (as you say this compiled to nothing),
but I guess other archs need this, so lets add it.

>   - all of this is the unlikely path :) You restart the qdisc
>     when the ptr ring is completely full so the stopping in absolute
>     worst case will happen once or twice per full ptr_ring ?
> 

Yes, basically. It should only happen once per full ptr_ring event.
As soon as TXQ is stopped, the driver code is no-longer called.
Do remember that remote CPU running veth_poll call, will (re)start the
TXQ again via qdisc layer, which call veth driver code again, e.g. race
to fill ptr_ring again and that will stop TXQ again. (Sysadm help: These
full/TXQ-stop events will be recorded in "requeues" counter by qdisc
stats).  The remote CPU running NAPI is in a fairly tight loop, so it
will do it's best to empty the queue, and have a total budget of 300.
The race is still very unlikely, but it is a race, that would stop the
TXQ forever for the veth device (we don't recover).


>> And the other side veth_poll(), have a smp_store_mb() before reading
>> ptr_ring.
>>
>> --Jesper
>>
>> p.s.
>> I actually had an alternative implementation of this, that only calls
>> stop when it is needed.  See below, it kind of looks prettier, but it
>> adds an extra memory barrier in the likely path. (And I'm not sure if
>> read memory barrier is strong enough).
> 
> Not sure that works either :S


