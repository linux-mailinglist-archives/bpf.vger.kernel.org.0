Return-Path: <bpf+bounces-22317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FAE85BCAF
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 13:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BDE8285878
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 12:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD46B69E09;
	Tue, 20 Feb 2024 12:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHi/uIdD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533BB433CB;
	Tue, 20 Feb 2024 12:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708433847; cv=none; b=ZPI5dxly4ELtVtxF+efMCVZna0+bfrAWqNcs6OaENzQMjapMKATshDkVGzsPng6JN7jdwHKPjRud/QLBz81g7zEcGpdpzNbnv0nftHovc5T0CF16qyNSmAUB/PCeZqa5uF5hv+CxQivpaiA7/e3YDoeu0O/TMtjwDra4rshHBuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708433847; c=relaxed/simple;
	bh=Aylt2HMUIRu9SENrr44UxuHWTJuCgWFIjcaLzz4UPZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZqjcPZPJ4ALVWDrHJHeHg0kPk+5EA0nJ49tYoCqtrekp6nipaGXIgRXHhY6GYS8MQl145I++bPY7GunPDSv/A47PI7NJAH3bshmDo/kUC5Ezh0lyKzgYchwTkRh35lBnH2SyVkapYawu6dbW9WCqORjUj2XPCNohnzjweAcSOO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHi/uIdD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20E5C433F1;
	Tue, 20 Feb 2024 12:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708433847;
	bh=Aylt2HMUIRu9SENrr44UxuHWTJuCgWFIjcaLzz4UPZY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NHi/uIdDXX6yQnMstGcidaReoZeGBEx58jsGv7A6bOC9/lUVdK1l1uscrRHwiNag0
	 QKcekgP2/yNrBbf5DV4M37/gw2jWd38oxfE8dvKghbZLLrLjWK6vxVIlP6kDmyZxUc
	 x1Z5Qf+Nf/4mXt3ZoUS23AaiiDjnjRE6HxI/3cg3WZGWkTk0ByiziUHkeDXXQVS2+M
	 +an8lxIoRKRgIeEDhfDNfEhfKckNYnMLCzC3l/h3rMwGvjmImO3Y3nAkLd4ugaDHoE
	 4G2hvKaETWLC8sbJagvQz7R7Q4enJihDURNn3zBYgbQW5ck8x4h2nvmrwSGIF61UHo
	 daZygsUs3F60A==
Message-ID: <07620deb-2b96-4bcc-a045-480568a27c58@kernel.org>
Date: Tue, 20 Feb 2024 13:57:24 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 1/2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <87y1bndvsx.fsf@toke.dk> <20240214142827.3vV2WhIA@linutronix.de>
 <87le7ndo4z.fsf@toke.dk> <20240214163607.RjjT5bO_@linutronix.de>
 <87jzn5cw90.fsf@toke.dk> <20240216165737.oIFG5g-U@linutronix.de>
 <87ttm4b7mh.fsf@toke.dk> <04d72b93-a423-4574-a98e-f8915a949415@kernel.org>
 <20240220101741.PZwhANsA@linutronix.de>
 <0b1c8247-ccfb-4228-bd64-53583329aaa7@kernel.org>
 <20240220120821.1Tbz6IeI@linutronix.de>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20240220120821.1Tbz6IeI@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 20/02/2024 13.08, Sebastian Andrzej Siewior wrote:
> On 2024-02-20 11:42:57 [+0100], Jesper Dangaard Brouer wrote:
>> This seems low...
>> Have you remembered to disable Ethernet flow-control?
> 
> No but one side says:
> | i40e 0000:3d:00.1 eno2np1: NIC Link is Up, 10 Gbps Full Duplex, Flow Control: None
> 
> but I did this
> 
>>   # ethtool -A ixgbe1 rx off tx off
>>   # ethtool -A i40e2 rx off tx off
> 
> and it didn't change much.
> 
>>
>>> | Summary                 8,436,294 rx/s                  0 err/s
>>
>> You want to see the "extended" info via cmdline (or Ctrl+\)
>>
>>   # xdp-bench drop -e eth1
>>
>>
>>>
>>> with "-t 8 -b 64". I started with 2 and then increased until rx/s was
>>> falling again. I have ixgbe on the sending side and i40e on the
>>
>> With ixgbe on the sending side, my testlab shows I need -t 2.
>>
>> With -t 2 :
>> Summary                14,678,170 rx/s                  0 err/s
>>    receive total        14,678,170 pkt/s        14,678,170 drop/s         0
>> error/s
>>      cpu:1              14,678,170 pkt/s        14,678,170 drop/s         0
>> error/s
>>    xdp_exception                 0 hit/s
>>
>> with -t 4:
>>
>> Summary                10,255,385 rx/s                  0 err/s
>>    receive total        10,255,385 pkt/s        10,255,385 drop/s         0
>> error/s
>>      cpu:1              10,255,385 pkt/s        10,255,385 drop/s         0
>> error/s
>>    xdp_exception                 0 hit/s
>>
>>> receiving side. I tried to receive on ixgbe but this ended with -ENOMEM
>>> | # xdp-bench drop eth1
>>> | Failed to attach XDP program: Cannot allocate memory
>>>
>>> This is v6.8-rc5 on both sides. Let me see where this is coming from…
>>>
>>
>> Another pitfall with ixgbe is that it does a full link reset when
>> adding/removing XDP prog on device.  This can be annoying if connected
>> back-to-back, because "remote" pktgen will stop on link reset.
> 
> so I replaced nr_cpu_ids with 64 and bootet maxcpus=64 so that I can run
> xdp-bench on the ixgbe.
> 

Yes, ixgbe HW have limited TX queues, and XDP tries to allocate a
hardware TX queue for every CPU in the system.  So, I guess you have too
many CPUs in your system - lol.

Other drivers have a fallback to a locked XDP TX path, so this is also
something to lookout for in the machine with i40e.

> so. i40 send, ixgbe receive.
> 
> -t 2
> 
> | Summary                 2,348,800 rx/s                  0 err/s
> |   receive total         2,348,800 pkt/s         2,348,800 drop/s                0 error/s
> |     cpu:0               2,348,800 pkt/s         2,348,800 drop/s                0 error/s
> |   xdp_exception                 0 hit/s
>

This is way too low, with i40e sending.

On my system with only -t 1 my i40e driver can send with approx 15Mpps:

  Ethtool(i40e2) stat:  15028585 (  15,028,585) <= tx-0.packets /sec
  Ethtool(i40e2) stat:  15028589 (  15,028,589) <= tx_packets /sec


> -t 4
> | Summary                 4,158,199 rx/s                  0 err/s
> |   receive total         4,158,199 pkt/s         4,158,199 drop/s                0 error/s
> |     cpu:0               4,158,199 pkt/s         4,158,199 drop/s                0 error/s
> |   xdp_exception                 0 hit/s
> 

Do notice that this is all hitting CPU:0
(this is by design from pktgen_sample03_burst_single_flow.sh)


> -t 8
> | Summary                 5,612,861 rx/s                  0 err/s
> |   receive total         5,612,861 pkt/s         5,612,861 drop/s                0 error/s
> |     cpu:0               5,612,861 pkt/s         5,612,861 drop/s                0 error/s
> |   xdp_exception                 0 hit/s
> 
> going higher makes the rate drop. With 8 it floats between 5,5… 5,7…
> 

At -t 8 we seem to have hit limit on RX side, which also seems too low.

I recommend checking what speeds packet generator is sending with.
I use this tool: ethtool_stats.pl
 
https://github.com/netoptimizer/network-testing/blob/master/bin/ethtool_stats.pl

What we are basically asking: Make sure packet generator is not the
limiting factor in your tests.
As we need to make sure DUT (Device Under Test) is being overloaded
100%.  I often also check (via per record) that DUT don't have idle CPU
cycles (yes, this can easily happen... and happens when we hit a limit
in hardware either NIC or PCIe slot)


> Doing "ethtool -G eno2np1 tx 4096 rx 4096" on the i40 makes it worse,
> using the default 512/512 gets the numbers from above, going below 256
> makes it worse.
> 
> receiving on i40, sending on ixgbe:
> 
> -t 2
> |Summary                 3,042,957 rx/s                  0 err/s
> |  receive total         3,042,957 pkt/s         3,042,957 drop/s                0 error/s
> |    cpu:60              3,042,957 pkt/s         3,042,957 drop/s                0 error/s
> |  xdp_exception                 0 hit/s
> 
> -t 4
> |Summary                 5,442,166 rx/s                  0 err/s
> |  receive total         5,442,166 pkt/s         5,442,166 drop/s                0 error/s
> |    cpu:60              5,442,166 pkt/s         5,442,166 drop/s                0 error/s
> |  xdp_exception                 0 hit/s
> 
> 
> -t 6
> | Summary                 7,023,406 rx/s                  0 err/s
> |   receive total         7,023,406 pkt/s         7,023,406 drop/s                0 error/s
> |     cpu:60              7,023,406 pkt/s         7,023,406 drop/s                0 error/s
> |   xdp_exception                 0 hit/s
> 
> 
> -t 8
> | Summary                 7,540,915 rx/s                  0 err/s
> |   receive total         7,540,915 pkt/s         7,540,915 drop/s                0 error/s
> |     cpu:60              7,540,915 pkt/s         7,540,915 drop/s                0 error/s
> |   xdp_exception                 0 hit/s
> 
> -t 10
> |Summary                 7,699,143 rx/s                  0 err/s
> |  receive total         7,699,143 pkt/s         7,699,143 drop/s                0 error/s
> |    cpu:60              7,699,143 pkt/s         7,699,143 drop/s                0 error/s
> |  xdp_exception                 0 hit/s
> 

At this level, if you can verify that CPU:60 is 100% loaded, and packet
generator is sending more than rx number, then it could work as a valid
experiment.

> -t 18
> | Summary                 7,784,946 rx/s                  0 err/s
> |   receive total         7,784,946 pkt/s         7,784,946 drop/s                0 error/s
> |     cpu:60              7,784,946 pkt/s         7,784,946 drop/s                0 error/s
> |   xdp_exception                 0 hit/s
> 
> after t18 it drop down to 2,…
> Now I got worse than before since -t8 says 7,5… and it did 8,4 in the
> morning. Do you have maybe a .config for me in case I did not enable the
> performance switch?
> 

I would look for root-cause with perf record +
  perf report --sort cpu,comm,dso,symbol --no-children


--Jesper

