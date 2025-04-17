Return-Path: <bpf+bounces-56116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E4AA917F4
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 11:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552184605C5
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 09:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968DB225A59;
	Thu, 17 Apr 2025 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k29KGtt+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183C71898FB;
	Thu, 17 Apr 2025 09:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744882366; cv=none; b=gvPELEBsoob70y5sa1GVwb9duF7GXV3pAoZjTd9AcHcOTvHDZ56Wli4oN0Mu6JLMRDp2EBKD6iqdao5SF3V0UcggWrTaiimzAGztsLfzLU6Gr31tQnHUzKxZSfzHi7UJzG4IGu+3nIzhy0Uv1aahYpj9rla5noGGi5UH1LxvAFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744882366; c=relaxed/simple;
	bh=Zb/CqSlcOUut/5T3AdDax3Vuf8gXBn3OO7ZVAZMyQUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGZ340gwGbXYgIyVzX4fzNUZcj5wDABVjchbOU7L2h14ZLfJ1jyfpH9xVJ1JmpEsF7oZhr2uTbPwTYPGGnbjIjYA5csHP58D3zaZXbjUxT1QFJevDkjMhH5aSuyzuLvdKrMJnZ1Hd13PFTAahRu8UEQBfgbu93qA+oPN7zA0Qzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k29KGtt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC010C4CEE4;
	Thu, 17 Apr 2025 09:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744882365;
	bh=Zb/CqSlcOUut/5T3AdDax3Vuf8gXBn3OO7ZVAZMyQUg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k29KGtt+P3cNQc+suTL3QSw7NZtlc/D5oV3IOKwvRilKlQuSxtukZgM6qdOn5g/gR
	 2eoWhoA+VMReZUOaT39l2QLQk3UxWwq5ZpB9ZldZrQHV2RZfKEyGoDLHesdcFBvR58
	 CwTeIUrIcyYIQpIWwzo3NnLrb012+WJfp5R1lBvc0xOYrzssrpvgMsGuPTDdkKiTJv
	 bXK3ZzrmnmwC2+o0SYC6nJnOIqeeOxYfJrNloFGKu0uqiVnQORcaxzMwdCqri5rAED
	 DzIE9FHhKYRXzQldjH/VAnrhlw5M3CHapYvwNqNerkdNAVjxszWuTUHdB6PxeER8bk
	 OBK2oji2EyKvQ==
Message-ID: <bb7e20d6-9eb9-4fe0-9a73-565dfbd4ed14@kernel.org>
Date: Thu, 17 Apr 2025 11:32:40 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V4 2/2] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, tom@herbertland.com,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, dsahern@kernel.org,
 makita.toshiaki@lab.ntt.co.jp, kernel-team@cloudflare.com, phil@nwl.cc
References: <174472463778.274639.12670590457453196991.stgit@firesoul>
 <174472470529.274639.17026526070544068280.stgit@firesoul>
 <87tt6oi50h.fsf@toke.dk>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <87tt6oi50h.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/04/2025 15.56, Toke Høiland-Jørgensen wrote:
> Jesper Dangaard Brouer <hawk@kernel.org> writes:
> 
>> In production, we're seeing TX drops on veth devices when the ptr_ring
>> fills up. This can occur when NAPI mode is enabled, though it's
>> relatively rare. However, with threaded NAPI - which we use in
>> production - the drops become significantly more frequent.
>>
>> The underlying issue is that with threaded NAPI, the consumer often runs
>> on a different CPU than the producer. This increases the likelihood of
>> the ring filling up before the consumer gets scheduled, especially under
>> load, leading to drops in veth_xmit() (ndo_start_xmit()).
>>
>> This patch introduces backpressure by returning NETDEV_TX_BUSY when the
>> ring is full, signaling the qdisc layer to requeue the packet. The txq
>> (netdev queue) is stopped in this condition and restarted once
>> veth_poll() drains entries from the ring, ensuring coordination between
>> NAPI and qdisc.
>>
>> Backpressure is only enabled when a qdisc is attached. Without a qdisc,
>> the driver retains its original behavior - dropping packets immediately
>> when the ring is full. This avoids unexpected behavior changes in setups
>> without a configured qdisc.
>>
>> With a qdisc in place (e.g. fq, sfq) this allows Active Queue Management
>> (AQM) to fairly schedule packets across flows and reduce collateral
>> damage from elephant flows.
>>
>> A known limitation of this approach is that the full ring sits in front
>> of the qdisc layer, effectively forming a FIFO buffer that introduces
>> base latency. While AQM still improves fairness and mitigates flow
>> dominance, the latency impact is measurable.
>>
>> In hardware drivers, this issue is typically addressed using BQL (Byte
>> Queue Limits), which tracks in-flight bytes needed based on physical link
>> rate. However, for virtual drivers like veth, there is no fixed bandwidth
>> constraint - the bottleneck is CPU availability and the scheduler's ability
>> to run the NAPI thread. It is unclear how effective BQL would be in this
>> context.
>>
>> This patch serves as a first step toward addressing TX drops. Future work
>> may explore adapting a BQL-like mechanism to better suit virtual devices
>> like veth.
>>
>> Reported-by: Yan Zhai <yan@cloudflare.com>
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> ---
>>   drivers/net/veth.c |   49 +++++++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 41 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>> index 7bb53961c0ea..a419d5e198d8 100644
>> --- a/drivers/net/veth.c
>> +++ b/drivers/net/veth.c
[...]
>> @@ -874,9 +897,16 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>>   			struct veth_xdp_tx_bq *bq,
>>   			struct veth_stats *stats)
>>   {
>> +	struct veth_priv *priv = netdev_priv(rq->dev);
>> +	int queue_idx = rq->xdp_rxq.queue_index;
>> +	struct netdev_queue *peer_txq;
>> +	struct net_device *peer_dev;
>>   	int i, done = 0, n_xdpf = 0;
>>   	void *xdpf[VETH_XDP_BATCH];
>>   
>> +	peer_dev = rcu_dereference(priv->peer);
>> +	peer_txq = netdev_get_tx_queue(peer_dev, queue_idx);
>> +
>>   	for (i = 0; i < budget; i++) {
>>   		void *ptr = __ptr_ring_consume(&rq->xdp_ring);
>>   
>> @@ -925,6 +955,9 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>>   	rq->stats.vs.xdp_packets += done;
>>   	u64_stats_update_end(&rq->stats.syncp);
>>   
>> +	if (unlikely(netif_tx_queue_stopped(peer_txq)))
>> +		netif_tx_wake_queue(peer_txq);
>> +
> 
> netif_tx_wake_queue() does a test_and_clear_bit() and does nothing if
> the bit is not set; so does this optimisation really make any
> difference? :)

Yes, it avoids a function call. As netif_tx_queue_stopped() inlines the
test_bit() here, and netif_tx_wake_queue() is an exported symbol.
I'm being very careful that I'm not slowing down the common veth code
path with this change. Your suggestion is a paper-cut, so I'm not taking
this advice :-P

--Jesper

