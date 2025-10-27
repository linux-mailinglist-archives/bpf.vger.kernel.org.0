Return-Path: <bpf+bounces-72349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 604A5C0F3E6
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 17:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 604CA4EC5F8
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 16:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EABF311C2E;
	Mon, 27 Oct 2025 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIOT8hYQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A67C305943;
	Mon, 27 Oct 2025 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581928; cv=none; b=l1pKKo/oCSOO3WMgkl71MZqCOpqlgdur4z0aIRSrq3DDG+MHUFraBHz0TNyWiKG8k8gl3zGRWsusFnqeGb1QvYGo/9QZX5fMYb7/Zvx5aQy4BmjofGC8eG+1l57Q7lsfZCQs0ghnH+Xuh6n2vcK4yjKqYOZFFtD+NxXOWTOoTGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581928; c=relaxed/simple;
	bh=tzRQhQnGp/ULOZcZf2fXRW+FzJisJmo8dgomx7BetHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GEEYhbqL+CHSj2NHLcLjzOeiZzzTkhrKuMn+5eEbEqKMQEUbqbkzF8lU0JmTNxluPmhexMHYUtaB7vO2vY7fH1VQvmp1HUtwO1Jg+bEW+KUIroAZlJn/+KfWEmbIL8wqPaa/W+EIpS6nvl6icQxo2JyFppQd4vKT+i4TDPGJn5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIOT8hYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47711C4CEF1;
	Mon, 27 Oct 2025 16:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761581928;
	bh=tzRQhQnGp/ULOZcZf2fXRW+FzJisJmo8dgomx7BetHk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mIOT8hYQYy5X2pmcEPtNXr5zley3DAxly8rODs402eZ4Yy7WlLToQpvtUZ3scafYn
	 pAw9mrHwheRCbMWoBqSIilxGYa2ZtVTDlshMzPUbdyK2fk3szN/UC9f95YRI168N/z
	 FEf6dHMAGvKQz/cJRCa57F7AO+le9+wwvsTzaRzaj0K+319G3QyZ687iW7C2G1HZ48
	 h3239A/IGNNQrQVkfBBo0+0uWrHa0i4tV1U9TBnSLcANI+F47HOofOAX8HeUh9306W
	 PQYMbVpNVhAlglL+5+fwgcCCmkqJjiVU//iAIU9RyRKCXYZL3XGYE2/J8HigkTnAU8
	 7B90R7zbih9GQ==
Message-ID: <c8ea44e0-e8f5-4356-af80-efa7f56921df@kernel.org>
Date: Mon, 27 Oct 2025 17:18:43 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V1 1/3] veth: enable dev_watchdog for detecting
 stalled TXQs
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 netdev@vger.kernel.org, makita.toshiaki@lab.ntt.co.jp
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, ihor.solodrai@linux.dev,
 toshiaki.makita1@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
References: <176123150256.2281302.7000617032469740443.stgit@firesoul>
 <176123157173.2281302.7040578942230212638.stgit@firesoul>
 <877bwkfmgr.fsf@toke.dk> <b6d13746-7921-4825-97cc-7136cdccafde@kernel.org>
 <87v7k0e8qz.fsf@toke.dk>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <87v7k0e8qz.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 27/10/2025 15.09, Toke Høiland-Jørgensen wrote:
> Jesper Dangaard Brouer <hawk@kernel.org> writes:
> 
>> On 24/10/2025 15.39, Toke Høiland-Jørgensen wrote:
>>> Jesper Dangaard Brouer <hawk@kernel.org> writes:
>>>
>>>> The changes introduced in commit dc82a33297fc ("veth: apply qdisc
>>>> backpressure on full ptr_ring to reduce TX drops") have been found to cause
>>>> a race condition in production environments.
>>>>
>>>> Under specific circumstances, observed exclusively on ARM64 (aarch64)
>>>> systems with Ampere Altra Max CPUs, a transmit queue (TXQ) can become
>>>> permanently stalled. This happens when the race condition leads to the TXQ
>>>> entering the QUEUE_STATE_DRV_XOFF state without a corresponding queue wake-up,
>>>> preventing the attached qdisc from dequeueing packets and causing the
>>>> network link to halt.
>>>>
>>>> As a first step towards resolving this issue, this patch introduces a
>>>> failsafe mechanism. It enables the net device watchdog by setting a timeout
>>>> value and implements the .ndo_tx_timeout callback.
>>>>
>>>> If a TXQ stalls, the watchdog will trigger the veth_tx_timeout() function,
>>>> which logs a warning and calls netif_tx_wake_queue() to unstall the queue
>>>> and allow traffic to resume.
>>>>
>>>> The log message will look like this:
>>>>
>>>>    veth42: NETDEV WATCHDOG: CPU: 34: transmit queue 0 timed out 5393 ms
>>>>    veth42: veth backpressure stalled(n:1) TXQ(0) re-enable
>>>>
>>>> This provides a necessary recovery mechanism while the underlying race
>>>> condition is investigated further. Subsequent patches will address the root
>>>> cause and add more robust state handling in ndo_open/ndo_stop.
>>>>
>>>> Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops")
>>>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>>> ---
>>>>    drivers/net/veth.c |   16 +++++++++++++++-
>>>>    1 file changed, 15 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>>>> index a3046142cb8e..7b1a9805b270 100644
>>>> --- a/drivers/net/veth.c
>>>> +++ b/drivers/net/veth.c
>>>> @@ -959,8 +959,10 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>>>>    	rq->stats.vs.xdp_packets += done;
>>>>    	u64_stats_update_end(&rq->stats.syncp);
>>>>    
>>>> -	if (peer_txq && unlikely(netif_tx_queue_stopped(peer_txq)))
>>>> +	if (peer_txq && unlikely(netif_tx_queue_stopped(peer_txq))) {
>>>> +		txq_trans_cond_update(peer_txq);
>>>>    		netif_tx_wake_queue(peer_txq);
>>>> +	}
>>>
>>> Hmm, seems a bit weird that this call to txq_trans_cond_update() is only
>>> in veth_xdp_recv(). Shouldn't there (also?) be one in veth_xmit()?
>>>
>>
>> The veth_xmit() call (indirectly) *do* update the txq_trans start
>> timestamp, but only for return code NET_RX_SUCCESS / NETDEV_TX_OK.
>> As .ndo_start_xmit = veth_xmit and netdev_start_xmit[1] will call
>> txq_trans_update on NETDEV_TX_OK.
> 
> Ah, right; didn't think of checking the caller, thanks for the pointer :)
> 
>> This call to txq_trans_cond_update() isn't strictly necessary, as
>> veth_xmit() call will update it later, and the netif_tx_stop_queue()
>> call also updates trans_start.
>>
>> I primarily added it because other drivers that use BQL have their
>> helper functions update txq_trans.  As I see the veth implementation as
>> a simplified BQL, that we hopefully can extend to become more dynamic
>> like BQL.
>>
>> Do you prefer that I remove this?  (call to txq_trans_cond_update)
> 
> Hmm, don't we need it for the XDP path? I.e., if there's no traffic
> other than XDP_REDIRECT traffic, ndo_start_xmit() will not get called,
> so we need some way other to keep the watchdog from firing, I think?
> 

Yes, perhaps you are right.  Even-though the stop call
netif_tx_stop_queue() also updates the txq_trans start, then with XDP
redirect something else can keep the ptr_ring full.  The
netif_tx_wake_queue() call doesn't update txq_trans itself (it depend on
a successful netstack packet).  So, without this txq_trans update it can
get very old (out-of-date) if we starve normal network stack packets.
  I'm not 100% sure this will trigger a watchdog even, as the queue
stopped bit should have been cleared.  It is might worth keeping to
avoid it gets too much out-of-date due to XDP traffic.

--Jesper


