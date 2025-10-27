Return-Path: <bpf+bounces-72309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6269C0D377
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 12:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA2384F40A3
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 11:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B148C2FBDE0;
	Mon, 27 Oct 2025 11:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyNmwHfM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D46C2F49E4;
	Mon, 27 Oct 2025 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565301; cv=none; b=WYwQc05lMhCnS9QEo8CtOJrVTubBAhIGZ6j4yDJYDkgqZnz88ItUTGVl625i3Gcc/sqgAIw+VXcQZgzyzTNo0niJLnuSiNPZsGwzWm+tujSELi4C1XOnM4gFEwiYX9Gje4QlGkTTZmi+kA8tX0mpOZgY3PoBoRX71gRPQGccNDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565301; c=relaxed/simple;
	bh=hqOtHiTgvGyahBvfgpDyyjTxNtrg8WZgPXVUnJTBT1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8GAzyJ/U6z0Cm/z0jEAcHc0y2l1TLYlZzH45rgrrMStz1n70/rmr6FtKIaTXGwU2+Wd6sDCxdRh5wUayXKos29sfmlHZVW24JHYV2vtIzSMxCb7/k+5fF1WiLqBrxwbtRL2C0FREL/4TI6VQchy2CxBFRtEr0awfaSmOcNsnBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyNmwHfM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D8DC4CEF1;
	Mon, 27 Oct 2025 11:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761565300;
	bh=hqOtHiTgvGyahBvfgpDyyjTxNtrg8WZgPXVUnJTBT1Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PyNmwHfMZ/HugRAt2N0HGvQ9PTdCqocdLymPmG13jN9ErSVBmFe5Ren9EQDgIPlcg
	 Svqsz6X9CJJTnS59NPHV4UAg35CbxTohCk3zPT241MhxQcCW/9sUtQsY5+ubwWsI36
	 +MjsXNkylvftJ+dxA1ihnVLriMysDPc+Pym+QowDxff0WSifJRKZlCN/ZR74kul87N
	 5rVIjR+bNPlXPCEJHIzLEY5/PSMzF+iJ5cC6Sn5v9dwdV+80nkDNLjU1CRN2/wpsie
	 8mM2bdjF3jS5QLW+S61kQv27K+hjJ3IPBatE49yV9yK4hJy6bx1K7S7KbBCNGGeO4o
	 gIaXjdTld3wCw==
Message-ID: <b6d13746-7921-4825-97cc-7136cdccafde@kernel.org>
Date: Mon, 27 Oct 2025 12:41:36 +0100
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
 <877bwkfmgr.fsf@toke.dk>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <877bwkfmgr.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 24/10/2025 15.39, Toke Høiland-Jørgensen wrote:
> Jesper Dangaard Brouer <hawk@kernel.org> writes:
> 
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
>> cause and add more robust state handling in ndo_open/ndo_stop.
>>
>> Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops")
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> ---
>>   drivers/net/veth.c |   16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>> index a3046142cb8e..7b1a9805b270 100644
>> --- a/drivers/net/veth.c
>> +++ b/drivers/net/veth.c
>> @@ -959,8 +959,10 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>>   	rq->stats.vs.xdp_packets += done;
>>   	u64_stats_update_end(&rq->stats.syncp);
>>   
>> -	if (peer_txq && unlikely(netif_tx_queue_stopped(peer_txq)))
>> +	if (peer_txq && unlikely(netif_tx_queue_stopped(peer_txq))) {
>> +		txq_trans_cond_update(peer_txq);
>>   		netif_tx_wake_queue(peer_txq);
>> +	}
> 
> Hmm, seems a bit weird that this call to txq_trans_cond_update() is only
> in veth_xdp_recv(). Shouldn't there (also?) be one in veth_xmit()?
> 

The veth_xmit() call (indirectly) *do* update the txq_trans start
timestamp, but only for return code NET_RX_SUCCESS / NETDEV_TX_OK.
As .ndo_start_xmit = veth_xmit and netdev_start_xmit[1] will call
txq_trans_update on NETDEV_TX_OK.

This call to txq_trans_cond_update() isn't strictly necessary, as
veth_xmit() call will update it later, and the netif_tx_stop_queue()
call also updates trans_start.

I primarily added it because other drivers that use BQL have their
helper functions update txq_trans.  As I see the veth implementation as
a simplified BQL, that we hopefully can extend to become more dynamic
like BQL.

Do you prefer that I remove this?  (call to txq_trans_cond_update)

--Jesper


[1] 
https://elixir.bootlin.com/linux/v6.17.5/source/include/linux/netdevice.h#L5222-L5233

