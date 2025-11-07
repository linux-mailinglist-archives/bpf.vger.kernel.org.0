Return-Path: <bpf+bounces-73956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F53C402AD
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 14:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 52EC834DE7A
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 13:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618B52F7AAD;
	Fri,  7 Nov 2025 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APmylv60"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2912F2605;
	Fri,  7 Nov 2025 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522982; cv=none; b=Qrg0H+lEzTTE82i9gyB8PX2AG0/fp0gtUmB1C35IgesyVJn6zHqbv/swYidEQT06LfNsFXr8PX6wpaim0wQmzd30JS2w0XribjNzKhJnJydQx2m/StT5hgUUvoC5yU83Ej8kX3AkkRgTVCysehR6n9rLAfZf0GVSuGl95BjQ0jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522982; c=relaxed/simple;
	bh=mVhNPlLjxSXohTIokzVQKOtrdJswU2kcvPbGFxRD4Ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=msLXmBcTpDeqfXBrzPADj1Umj4W+b+0F2eGlo0fzKE2+o+M8pKOG3pH/xIblL3XyW/yvGd3KNeaofp3aUBhhENAFkgsqfYR+R1eD7e6zUFG4erdbICBh1QFGcGvxDOuEhyKZ7GeKFf4mldQW3Ucun0mCVKH5/oGjTkFqpzKQmDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APmylv60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDA4C4CEF8;
	Fri,  7 Nov 2025 13:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762522982;
	bh=mVhNPlLjxSXohTIokzVQKOtrdJswU2kcvPbGFxRD4Ig=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=APmylv60JbvoLid/67a1Lg2RUqkHsQeS27fqWkrDCeavaJYQCdjXy8wY6ud5MU+6+
	 a1aOqgDi7sMGJMx9JkECexe3NyIeh1RM4BxFwBCaxosUXz6bpOByK3siWzcuOVTztW
	 7MiCzKQ5fV3SvixxCCqyDpaaOC2Yri/TI0XQ4fkRq0h6YTdNDoY7/7VyS2IIuGpJm6
	 AbjVvRQRI3Q5QG//gwAo8ec5jyhpXynjXbvjOqZQbRjJx4sGfBy8R41S4vu6Wm7Dx9
	 sbhf1TTMAl+05Vs1ITmxlat8ACZXKISQxktdnP9GlRl/PeqDiZMYPsOK/0IKKAS2tY
	 S1CgLdwCgUkVw==
Message-ID: <b9f01e64-f7cc-4f5a-9716-5767b37e2245@kernel.org>
Date: Fri, 7 Nov 2025 14:42:58 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V3 1/2] veth: enable dev_watchdog for detecting
 stalled TXQs
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 ihor.solodrai@linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 makita.toshiaki@lab.ntt.co.jp, toshiaki.makita1@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-team@cloudflare.com
References: <176236363962.30034.10275956147958212569.stgit@firesoul>
 <176236369293.30034.1875162194564877560.stgit@firesoul>
 <20251106172919.24540443@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20251106172919.24540443@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/11/2025 02.29, Jakub Kicinski wrote:
> On Wed, 05 Nov 2025 18:28:12 +0100 Jesper Dangaard Brouer wrote:
>> The changes introduced in commit dc82a33297fc ("veth: apply qdisc
>> backpressure on full ptr_ring to reduce TX drops") have been found to cause
>> a race condition in production environments.
>>
>> Under specific circumstances, observed exclusively on ARM64 (aarch64)
>> systems with Ampere Altra Max CPUs, a transmit queue (TXQ) can become
>> permanently stalled. This happens when the race condition leads to the TXQ
>> entering the QUEUE_STATE_DRV_XOFF state without a corresponding queue wake-up,
>> preventing the attached qdisc from dequeueing packets and causing the
>> network link to halt.
>>
>> As a first step towards resolving this issue, this patch introduces a
>> failsafe mechanism. It enables the net device watchdog by setting a timeout
>> value and implements the .ndo_tx_timeout callback.
>>
>> If a TXQ stalls, the watchdog will trigger the veth_tx_timeout() function,
>> which logs a warning and calls netif_tx_wake_queue() to unstall the queue
>> and allow traffic to resume.
>>
>> The log message will look like this:
>>
>>   veth42: NETDEV WATCHDOG: CPU: 34: transmit queue 0 timed out 5393 ms
>>   veth42: veth backpressure stalled(n:1) TXQ(0) re-enable
>>
>> This provides a necessary recovery mechanism while the underlying race
>> condition is investigated further. Subsequent patches will address the root
>> cause and add more robust state handling.
>>
>> Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops")
>> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> 
> I think this belongs in net-next.. Fail safe is not really a bug fix.
> I'm slightly worried we're missing a corner case and will cause
> timeouts to get printed for someone's config.
> 

This is a recovery fix.  If the race condition fix isn't 100% then this
patch will allow veth to recover.  Thus, to me it makes sense to group
these two patches together.

I'm more worried that we we're missing a corner case that we cannot
recover from. Than triggering timeouts to get printed, for a config
where NAPI consumer veth_poll() takes more that 5 seconds to run (budget
max 64 packets this needs to consume packets at a rate less than 12.8
pps). It might be good to get some warnings if the system is operating
this slow.

Also remember this is not the default config that most people use.
The code is only activated if attaching a qdisc to veth, which isn't
default. Plus, NAPI mode need to be activated, where in normal NAPI mode
the producer and consumer usually runs on the same CPU, which makes it
impossible to overflow the ptr_ring.  The veth backpressure is primarily
needed when running with threaded-NAPI, where it is natural that
producer and consumer runs on different CPUs. In our production setup
the consumer is always slower than the producer (as the product inside
the namespace have installed too many nftables rules).


>> +static void veth_tx_timeout(struct net_device *dev, unsigned int txqueue)
>> +{
>> +	struct netdev_queue *txq = netdev_get_tx_queue(dev, txqueue);
>> +
>> +	netdev_err(dev, "veth backpressure stalled(n:%ld) TXQ(%u) re-enable\n",
>> +		   atomic_long_read(&txq->trans_timeout), txqueue);
> 
> If you think the trans_timeout is useful, let's add it to the message
> core prints? And then we can make this msg just veth specific, I don't
> think we should be repeating what core already printed.

The trans_timeout is a counter for how many times this TXQ have seen a
timeout.  It is practical as it directly tell us if this a frequent
event (without having to search log files for similar events).

It does make sense to add this to the core message ("NETDEV WATCHDOG")
with the same argument.  For physical NICs these logs are present in
production. Looking at logs through Kibana (right now) and it would make
my life easier to see the number of times the individual queues have
experienced timeouts.  The logs naturally gets spaced in time by the
timeout, making it harder to tell the even frequency. Such a patch would
naturally go though net-next.

Do you still want me to remove the frequency counter from this message?
By the same argument it is practical for me to have as a single log line
when troubleshooting this in practice.  BTW, I've already backported
this watchdog patch to prod kernel (without race fix) and I'll try to
reproduce the race in staging/lab on some ARM64 servers.  If I reproduce
it will be practical to have this counter.

--Jesper

