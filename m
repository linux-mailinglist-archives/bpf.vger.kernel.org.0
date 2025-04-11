Return-Path: <bpf+bounces-55738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC36A85FC0
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 15:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B2D1B863DD
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 13:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7038E1E5B78;
	Fri, 11 Apr 2025 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0ztdXrg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E566D27450;
	Fri, 11 Apr 2025 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744379768; cv=none; b=NhqHf6mqx9f+bdjaFwN7ztlLQOrER/LfUIMJiiPWP5p0a+PVTd+1pcf/Aap9VaM0mLw6525VK+uM5iGxaj3cARC024Up3IuKVea/gC+y+/rwvZRNXjqESfdahZGCbDCOFgvplAa+kLuPQfZQv3PZnm2QmfnDiw73bS+2OgWebT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744379768; c=relaxed/simple;
	bh=inwvGyrmwNfdaC2wcLr+MuXx7P3IP3jwjTpSVV/B//c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frrB24ugUygNAJzBayMn4Uh57tsvUk0fzgdqvdxHhi7m9IGS7+ZjzdU9zpu7VoKl5BNt0Y3VCXJUWv7K63jL8nEYz5S1Y7twpSrJcbVtxrEN6ERHvj9ptIfftZRCwaLKUx9xWRBvf+ZxOQcvbq/RvUYmEocQP9IelfnuwpLIxdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0ztdXrg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4DEC4CEE2;
	Fri, 11 Apr 2025 13:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744379767;
	bh=inwvGyrmwNfdaC2wcLr+MuXx7P3IP3jwjTpSVV/B//c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K0ztdXrgFR21LrIFCy0jZAxrlwOxCEYWkgGgj+98Go1/BDdoveogWRGdenEIRjip2
	 uITk+Xs9QkojzWNJ0bUnWtK5NLh9W8w/TXKcWZGIpAwQZ6WszNAtEu9mr/SLQnJlfN
	 YUaMTy6oCsAoWOkhtnKWCed+zQkhVaHN1+oPx5b9AVqjr3qKewJU4uCVtbqam0ZGQA
	 e/J2Orv/AZK3BxWLZoLp3W/qhU2UuRHCJ10j+NwiZ1yv7DFeYYD4KYDO5M4ya2NjFX
	 UTG7VkPnuYi8S7dDhVUx2gMB18GdZAwpOs0e9+3fUO5ZhIiZaPnz1G4thn+KDa9RnJ
	 sRH3514UnCCbg==
Message-ID: <ff5e6185-0dcb-4879-8031-bdb0b0edcec6@kernel.org>
Date: Fri, 11 Apr 2025 15:56:02 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 1/2] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, tom@herbertland.com,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp, kernel-team@cloudflare.com
References: <174412623473.3702169.4235683143719614624.stgit@firesoul>
 <174412627898.3702169.3326405632519084427.stgit@firesoul>
 <20250411124553.GD395307@horms.kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250411124553.GD395307@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/04/2025 14.45, Simon Horman wrote:
> On Tue, Apr 08, 2025 at 05:31:19PM +0200, Jesper Dangaard Brouer wrote:
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
> 
> Thanks Jesper,
> 
> It's very nice to see backpressure support being added here.
> 
> ...
> 
>> @@ -874,9 +909,16 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
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
>> +	peer_dev = priv->peer;
> 
> I think you need to take into account RCU here.
> 
> Sparse says:
> 
>    .../veth.c:919:18: warning: incorrect type in assignment (different address spaces)
>    .../veth.c:919:18:    expected struct net_device *peer_dev
>    .../veth.c:919:18:    got struct net_device [noderef] __rcu *peer
> 

Is it correctly understood that I need an:

   peer_dev = rcu_dereference(priv->peer);

And also wrap this in a RCU section (rcu_read_lock()) ?

> 
>> +	peer_txq = netdev_get_tx_queue(peer_dev, queue_idx);
>> +
>>   	for (i = 0; i < budget; i++) {
>>   		void *ptr = __ptr_ring_consume(&rq->xdp_ring);
>>   
> 
> ...

