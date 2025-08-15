Return-Path: <bpf+bounces-65780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331C9B2841B
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 18:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2A15A06BC
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 16:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6D831078D;
	Fri, 15 Aug 2025 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCe0WvJb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9510130E82B;
	Fri, 15 Aug 2025 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276028; cv=none; b=ddruB/Z5qYHHCrJ69WCgIYgRtqkLKtsIgjKgU1ByEpZneYMX8/TEO9xY9YniJ3teRe/gK6Di26n/LhKeEbZUMH6b3G8cPhcfoOwgY5+lLSGsjlTdl3fMvspeKF85V/0IDvv4tBJrNkdMwpNLG8ZYOuevFKWv4y19PogJ3oDDmgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276028; c=relaxed/simple;
	bh=5LziujzWacnCbqw+g7qqICqrZy1EOWsUKZ+Tw1dxDmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKL/OTfGq2HNnNRpuIMsKUwQdiWWyrkabPcsmJllYQ4ChFZD6ODKTE/SCTGfBM1P0FgYhVencTwlzSywWTvtGtj8x8Y1eTw58WfW7IiT/ze6V2SBUgTaCHQGotln01115KOhOhWhX0wnzmbdvE/5lAyfvurN6nSV4SWpEmFD120=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCe0WvJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130B3C4CEEB;
	Fri, 15 Aug 2025 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755276028;
	bh=5LziujzWacnCbqw+g7qqICqrZy1EOWsUKZ+Tw1dxDmM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PCe0WvJb8et0r8SjJyXoN4uyqGs2I6eiLOETRhARpLHTgSdoHTY5Qea8Osqs5pMh8
	 i0onemCa+6U22PCjVsctU+K17q2QJjza/oWeer93/GQOkb7yRG2XlI55Y7IgZhHBeo
	 iHm+dm48ZmkzXmYAx8dJiOoWkQ6Sag3oBtdZLbp0ReGldo5eUaD1lRLKpHz1RvpxL6
	 grtJ3F5E5F0lpyKo9z1Lk3q+/l0TK8BVfVeWfyNfvPYCXTtX18+6vaBrRTU0nCh1uE
	 yu4khpHsNFsYZX/CE+hyn/5eIauBe6vJ1fKP6BlrRq5SSFab0htt9Go3UInDKmE8Ai
	 Jo5jG+fDmPl3Q==
Message-ID: <d34bf5f5-9626-442d-bdd2-b3ada51d556e@kernel.org>
Date: Fri, 15 Aug 2025 18:40:21 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] xsk: support generic batch xmit in copy mode
To: Jason Xing <kerneljasonxing@gmail.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, horms@kernel.org,
 andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20250811131236.56206-1-kerneljasonxing@gmail.com>
 <20250811131236.56206-3-kerneljasonxing@gmail.com>
 <b07b8930-e644-45a2-bef8-06f4494e7a39@kernel.org> <aJt+kBqXT/RgLGvR@boxer>
 <CAL+tcoBrT7WnPP9c+fhRxYyqyf0dZsMAP9=ghvcWRc2rTsF3Ag@mail.gmail.com>
 <CAL+tcoAst1xs=xCLykUoj1=Vj-0LtVyK-qrcDyoy4mQrHgW1kg@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAL+tcoAst1xs=xCLykUoj1=Vj-0LtVyK-qrcDyoy4mQrHgW1kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/08/2025 15.06, Jason Xing wrote:
> On Wed, Aug 13, 2025 at 9:02 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
>>
>> On Wed, Aug 13, 2025 at 1:49 AM Maciej Fijalkowski
>> <maciej.fijalkowski@intel.com> wrote:
>>>
>>> On Tue, Aug 12, 2025 at 04:30:03PM +0200, Jesper Dangaard Brouer wrote:
>>>>
>>>>
>>>> On 11/08/2025 15.12, Jason Xing wrote:
>>>>> From: Jason Xing <kernelxing@tencent.com>
>>>>>
>>>>> Zerocopy mode has a good feature named multi buffer while copy mode has
>>>>> to transmit skb one by one like normal flows. The latter might lose the
>>>>> bypass power to some extent because of grabbing/releasing the same tx
>>>>> queue lock and disabling/enabling bh and stuff on a packet basis.
>>>>> Contending the same queue lock will bring a worse result.
>>>>>
>>>>
>>>> I actually think that it is worth optimizing the non-zerocopy mode for
>>>> AF_XDP.  My use-case was virtual net_devices like veth.
>>>>
>>>>
>>>>> This patch supports batch feature by permitting owning the queue lock to
>>>>> send the generic_xmit_batch number of packets at one time. To further
>>>>> achieve a better result, some codes[1] are removed on purpose from
>>>>> xsk_direct_xmit_batch() as referred to __dev_direct_xmit().
>>>>>
>>>>> [1]
>>>>> 1. advance the device check to granularity of sendto syscall.
>>>>> 2. remove validating packets because of its uselessness.
>>>>> 3. remove operation of softnet_data.xmit.recursion because it's not
>>>>>      necessary.
>>>>> 4. remove BQL flow control. We don't need to do BQL control because it
>>>>>      probably limit the speed. An ideal scenario is to use a standalone and
>>>>>      clean tx queue to send packets only for xsk. Less competition shows
>>>>>      better performance results.
>>>>>
>>>>> Experiments:
>>>>> 1) Tested on virtio_net:
>>>>
>>>> If you also want to test on veth, then an optimization is to increase
>>>> dev->needed_headroom to XDP_PACKET_HEADROOM (256), as this avoids non-zc
>>>> AF_XDP packets getting reallocated by veth driver. I never completed
>>>> upstreaming this[1] before I left Red Hat.  (virtio_net might also benefit)
>>>>
>>>>   [1] https://github.com/xdp-project/xdp-project/blob/main/areas/core/veth_benchmark04.org
>>>>
>>>>
>>>> (more below...)
>>>>
>>>>> With this patch series applied, the performance number of xdpsock[2] goes
>>>>> up by 33%. Before, it was 767743 pps; while after it was 1021486 pps.
>>>>> If we test with another thread competing the same queue, a 28% increase
>>>>> (from 405466 pps to 521076 pps) can be observed.
>>>>> 2) Tested on ixgbe:
>>>>> The results of zerocopy and copy mode are respectively 1303277 pps and
>>>>> 1187347 pps. After this socket option took effect, copy mode reaches
>>>>> 1472367 which was higher than zerocopy mode impressively.
>>>>>
>>>>> [2]: ./xdpsock -i eth1 -t  -S -s 64
>>>>>
>>>>> It's worth mentioning batch process might bring high latency in certain
>>>>> cases. The recommended value is 32.
>>>
>>> Given the issue I spotted on your ixgbe batching patch, the comparison
>>> against zc performance is probably not reliable.
>>
>> I have to clarify the thing: zc performance was tested without that
>> series applied. That means without that series, the number is 1303277
>> pps. What I used is './xdpsock -i enp2s0f0np0 -t -q 11  -z -s 64'.
> 

My i40e device is running at 40Gbit/s.
I see significantly higher packet per sec (pps) that you are reporting:

$ sudo ./xdpsock -i i40e2 --txonly -q 2 -z -s 64

  sock0@i40e2:2 txonly xdp-drv
                    pps            pkts           1.00
rx                 0              0
tx                 21,546,859     21,552,896


The "copy" mode (-c/--copy) looks like this:

$ sudo ./xdpsock -i i40e2 --txonly -q 2 --copy -s 64

  sock0@i40e2:2 txonly xdp-drv
                    pps            pkts           1.00
rx                 0              0
tx                 2,135,424      2,136,192


The skb-mode (-S, --xdp-skb) looks like this:

$ sudo ./xdpsock -i i40e2 --txonly -q 2 --xdp-skb -s 64

  sock0@i40e2:2 txonly xdp-skb
                    pps            pkts           1.00
rx                 0              0
tx                 2,187,992      2,188,800


The HUGE performance gap to "xdp-drv" zero-copy mode, tells me that
there is a huge potential for improving the performance for the copy
mode, both "native" xdp-drv and xdp-skb, cases.
Thus, the work your are doing here is important.


> ------
> @Maciej Fijalkowski
> Interesting thing is that copy mode is way worse than zerocopy if the
> nic is _i40e_.
> 
> With ixgbe, even copy mode reaches nearly 50-60% of the full speed
> (which is only 1Gb/sec) while either zc or batch version copy mode
> reaches 70%.
> With i40e, copy mode only reaches nearly 9% while zc mode 70%. i40e
> has a much faster speed (10Gb/sec) comparatively.
> 
> Here are some summaries (budget 32, batch 32):
>                 copy       batch         zc
> i40e       1,777,859   2,102,579   14,880,643
> ixgbe      1,187,347   1,472,367    1,303,277
> 
(added thousands separators to make above readable)

Those number only make sense if
  i40e runs at link speed 10Git/s and
  ixgbe runs at link speed 1Gbit/s


> For i40e, here are numbers around the batch copy mode (budget is 128):
> no batch       batch 64
> 1825027      2228328.
> Side note: 2228328 seems to be the max limit in copy mode with this
> series applied after testing with different settings.
> 
> It turns out that testing on i40e is definitely needed because the
> xdpsock test hits the bottleneck on ixgbe.
> 
> -----
> @Jesper Dangaard Brouer
> In terms of the 'more' boolean as Jesper said, related drivers might
> need changes like this because in the 'for' loop of the batch process
> in xsk_direct_xmit_batch(), drivers may fail to send and then break
> the 'for' loop, which leads to no chance to kick the hardware.

If sending with 'more' indicator and driver fail to send, then it is the
responsibility of the driver to update the tail-ptr/doorbell.
Example for ixgbe driver:
  https://elixir.bootlin.com/linux/v6.16/source/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c#L8879-L8880

> Or we
> can keep trying to send in xsk_direct_xmit_batch() instead of breaking
> immediately even if the driver becomes busy right now.
> 
> As to ixgbe, the performance doesn't improve as I analyzed (because it
> already reaches 70% of full speed).
> 

If ixgbe runs at 1Gbit/s then remember Ethernet wire-speed is 1.488
Mpps. Thus, you are much closer than 70% to wire-speed.


> As to i40e, only adding 'more' logic, the number goes from 2102579 to
> 2585224 with the 32 batch and 32 budget settings. The number goes from
> 2200013 to 2697313 with the  batch and 64 budget settings. See! 22+%
> improvement!

That is a very big performance gain IMHO. Shows that avoiding the tail-
ptr/doorbell between each packet have a huge benefit.

> As to virtio_net, no obvious change here probably because the hardirq
> logic doesn't have a huge effect.
> 

Perhaps virtio_net doesn't implement the SKB 'more' feature?

--Jesper


