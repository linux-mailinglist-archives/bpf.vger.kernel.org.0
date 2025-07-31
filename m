Return-Path: <bpf+bounces-64820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF500B17509
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 18:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F3417EE74
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 16:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAAE23D2BD;
	Thu, 31 Jul 2025 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxd4EsMD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14507BA33;
	Thu, 31 Jul 2025 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753979782; cv=none; b=ag7h5K/y87NrTNdh/zPz8yGxV0TKS+Rl0zmbJz0JQiXS+lChSPgD5fP1x/Y0xRHaOH6c55Tz6PGiY1znDluScydt/embvimHqxAFqHtqU9JvRem1+uoh99peMfsJexB/CjQNpJkwvk+kE3R8uZ9JgKl1vvClDLeGzF7SS6+g4dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753979782; c=relaxed/simple;
	bh=qKFf5+2hfKxNT4Eb5ZEf5XOsgGj5gNPOaqPmRXy42VY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=um0pzvvz4q/iuTRbYIJoIQPFekXR+Dcs/v8JOu9BACKFh237qIMz2WSBWhrluhOW2oZd5HLQ4xQCu5DHE2mzj1xuObLZ5U+OcUM50f+AqwV2WZ3PZN6+Z1uttXU3zKK1XVjNDqC+3Jx/JLK/1de35ICuFlnKkDlEwU6pzN+WF0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxd4EsMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A06EC4CEEF;
	Thu, 31 Jul 2025 16:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753979780;
	bh=qKFf5+2hfKxNT4Eb5ZEf5XOsgGj5gNPOaqPmRXy42VY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sxd4EsMDqnU2bvLSbW+BpwloOtQPP6fzTXv61Wri/xhJvXH5I8EgOG7Xm+TwDTT+y
	 rAzGCsroB6tjTg6Bnr0P9MKB7vukziqS4p7JnPGEmCRC9CjLjfllhG97nKzXVZ19gu
	 6/W5ZfSfGIqz9keIjnSBJ2+/UAdC0+8Sno6Rk9ptuviRhR7hKujE44BAqQwDxE8B8F
	 atveE2SvOOjASYKPceDvkBvdilfAQIJLZh4AHN8dBS0bevxS6pfn+N0m9bg4emfl1N
	 Fe9DLe8yz4rbR2KaVZC5wBb8a4I4Adk5qtMpcNx+S+iRtvhpuAQFtQFCMybd7fn/lN
	 yfANoDibolWeA==
Message-ID: <01c9284d-58c2-4a90-8833-67439a28e541@kernel.org>
Date: Thu, 31 Jul 2025 18:36:04 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: mana: Use page pool fragments for RX buffers
 instead of full pages to improve memory efficiency.
To: Dragos Tatulea <dtatulea@nvidia.com>,
 Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: horms@kernel.org, kuba@kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, longli@microsoft.com, kotaranov@microsoft.com,
 ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 sdf@fomichev.me, lorenzo@kernel.org, michal.kubiak@intel.com,
 ernis@linux.microsoft.com, shradhagupta@linux.microsoft.com,
 shirazsaleem@microsoft.com, rosenp@gmail.com, netdev@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 ssengar@linux.microsoft.com, dipayanroy@microsoft.com,
 Chris Arges <carges@cloudflare.com>, kernel-team
 <kernel-team@cloudflare.com>, Tariq Toukan <tariqt@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Yunsheng Lin <linyunsheng@huawei.com>
References: <20250723190706.GA5291@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <73add9b2-2155-4c4f-92bb-8166138b226b@kernel.org>
 <20250729202007.GA6615@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <i5o2nzwpd5ommosp4ci5edrozci34v6lfljteldyilsfe463xd@6qts2hifezz3>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <i5o2nzwpd5ommosp4ci5edrozci34v6lfljteldyilsfe463xd@6qts2hifezz3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/07/2025 09.31, Dragos Tatulea wrote:
> On Tue, Jul 29, 2025 at 01:20:07PM -0700, Dipayaan Roy wrote:
>> On Tue, Jul 29, 2025 at 12:15:23PM +0200, Jesper Dangaard Brouer wrote:
>>>
>>>
>>> On 23/07/2025 21.07, Dipayaan Roy wrote:
>>>> This patch enhances RX buffer handling in the mana driver by allocating
>>>> pages from a page pool and slicing them into MTU-sized fragments, rather
>>>> than dedicating a full page per packet. This approach is especially
>>>> beneficial on systems with large page sizes like 64KB.
>>>>
>>>> Key improvements:
>>>>
>>>> - Proper integration of page pool for RX buffer allocations.
>>>> - MTU-sized buffer slicing to improve memory utilization.
>>>> - Reduce overall per Rx queue memory footprint.
>>>> - Automatic fallback to full-page buffers when:
>>>>     * Jumbo frames are enabled (MTU > PAGE_SIZE / 2).
>>>>     * The XDP path is active, to avoid complexities with fragment reuse.
>>>> - Removal of redundant pre-allocated RX buffers used in scenarios like MTU
>>>>    changes, ensuring consistency in RX buffer allocation.
>>>>
>>>> Testing on VMs with 64KB pages shows around 200% throughput improvement.
>>>> Memory efficiency is significantly improved due to reduced wastage in page
>>>> allocations. Example: We are now able to fit 35 rx buffers in a single 64kb
>>>> page for MTU size of 1500, instead of 1 rx buffer per page previously.
>>>>
>>>> Tested:
>>>>
>>>> - iperf3, iperf2, and nttcp benchmarks.
>>>> - Jumbo frames with MTU 9000.
>>>> - Native XDP programs (XDP_PASS, XDP_DROP, XDP_TX, XDP_REDIRECT) for
>>>>    testing the XDP path in driver.
>>>> - Page leak detection (kmemleak).
>>>> - Driver load/unload, reboot, and stress scenarios.
>>>
>>> Chris (Cc) discovered a crash/bug[1] with page pool fragments used
>>> from the mlx5 driver.
>>> He put together a BPF program that reproduces the issue here:
>>> - [2] https://github.com/arges/xdp-redirector
>>>
>>> Can I ask you to test that your driver against this reproducer?
>>>
>>>
>>> [1] https://lore.kernel.org/all/aIEuZy6fUj_4wtQ6@861G6M3/
>>>
>>> --Jesper
>>>
>>
>> Hi Jesper,
>>
>> I was unable to reproduce this issue on mana driver.
>>
> Please note that I had to make a few adjustments to get reprodduction on
> mlx5:
> 
> - Make sure that the veth MACs are recognized by the device. Otherwise
>    traffic might be dropped by the device.
> 
> - Enable GRO on the veth device. Otherwise packets get dropped before
>    they reach the devmap BPF program.
> 
> Try starting the test program with one thread and see if you see packets
> coming through veth1-ns1 end of the veth pair.
> 

Hi Dipayaan,

Enabling GRO on the veth device is quite important for the test to be valid.

I've asked Chris to fix this in the reproducer. He can report back when
he have done this, so you can re-run the test.  It is also good advice
from Dragos that you should check packets are coming through the veth
pair, to make sure the test is working.

The setup.sh script also need to be modified, as it is loading xdp on a
net_device called "ext0" [0], which is specific to our systems (which
default also have GRO enabled for veth).

[0] https://github.com/arges/xdp-redirector/blob/main/setup.sh#L28

--Jesper

