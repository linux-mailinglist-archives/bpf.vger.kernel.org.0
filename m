Return-Path: <bpf+bounces-79234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EB5D2FB31
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 11:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CEDE305674C
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 10:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33B435FF55;
	Fri, 16 Jan 2026 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kumww058"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715FE3195E8;
	Fri, 16 Jan 2026 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768560010; cv=none; b=q6tXNWf0oUn4cViZdPPouCKzeyBx0tSrq2kDr7E13gmwqykUMXOjKH3OrktrToNPUe3B3YGd5z2KZvl3ugB5DzWb78/PxLn/t7UD3Nk55rdwXS3XHa/MFbq/gr0evrCXN7YpdpoGBZFAVIKfP2hT8h7dreUE0I/42yFQVD9gkqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768560010; c=relaxed/simple;
	bh=/qTy21kwCbBWCmpt/uLJitE4vDc9ItDMqmxOz9/vYMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TyjvhShn2a5nVP7LhYo8xo/Rcd6dPdkUD63Jh+F8uuu9Lcqq/2MoSODSNTaAbfvlKyE2028SwAveHk7r1zIV/DXJ/whg5ewqfiiqiE6Q1QKLvhtOWp6OrddBTaW0QV6iONaNBpVZP18yHbAgV/kL27Wbo0N4XRKFzi+LIGv4wN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kumww058; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524C6C116C6;
	Fri, 16 Jan 2026 10:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768560010;
	bh=/qTy21kwCbBWCmpt/uLJitE4vDc9ItDMqmxOz9/vYMY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kumww058sCRwJ9m0nWFE5uzc86Jl/uwLAObbiEctYkUjccxICQ4GlfcADFW530GCJ
	 RrTu7iGRKzEwoIOFaJ9k3YgjPGjbesU7LBS05J2Jl51iR5isjdwDMoAV1ilaRH5kMq
	 x/xdFGoYTJMKVgGHM257s8o580jJvsZZm1gQ/UFMgYy7ceZL2XSaWg5uwXAdmuPIeB
	 TxR6+2C3gg8SPOX5zlcoygzWxirL+FNwLnNbBqg4QqJhHECPb2aZXwZ5XKGVoTjrBQ
	 UZOGmACe6SbGMe9soqlGBHmq7JmUxhU8LNlHSD6Puqxf6k2UuiKQj/7DfmUr6j8hUK
	 OjS6U0cNRXV5A==
Message-ID: <1bbbb306-d497-4143-a714-b126ecc41a06@kernel.org>
Date: Fri, 16 Jan 2026 11:40:06 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] net: sched: sfq: add detailed drop reasons
 for monitoring
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>, carges@cloudflare.com, kernel-team@cloudflare.com
References: <176847978787.939583.16722243649193888625.stgit@firesoul>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <176847978787.939583.16722243649193888625.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Eric,

I need an opinion on naming for drop_reasons below.

On 15/01/2026 13.23, Jesper Dangaard Brouer wrote:
> Add specific drop reasons to SFQ qdisc to improve packet drop observability
> and monitoring capabilities. This change replaces generic qdisc_drop()
> calls with qdisc_drop_reason() to provide granular metrics about different
> drop scenarios in production environments.
> 
> Two new drop reasons are introduced:
> 
> - SKB_DROP_REASON_QDISC_MAXFLOWS: Used when a new flow cannot be created
>    because the maximum number of flows (flows parameter) has been
>    reached and no free flow slots are available.
> 
> - SKB_DROP_REASON_QDISC_MAXDEPTH: Used when a flow's queue length exceeds
>    the per-flow depth limit (depth parameter), triggering either tail drop
>    or head drop depending on headdrop configuration.

I noticed commit 5765c7f6e317 ("net_sched: sch_fq: add three 
drop_reason") (Author: Eric Dumazet).

  SKB_DROP_REASON_FQ_BAND_LIMIT: Per-band packet limit exceeded
  SKB_DROP_REASON_FQ_HORIZON_LIMIT: Packet timestamp too far in future
  SKB_DROP_REASON_FQ_FLOW_LIMIT: Per-flow packet limit exceeded

Should I/we make SKB_DROP_REASON_QDISC_MAXDEPTH specific for SFQ ?
Like naming it = SKB_DROP_REASON_SFQ_MAXDEPTH ?

Currently SKB_DROP_REASON_QDISC_MAXDEPTH is only used in SFQ, but it
might be usable in other qdisc as well.  Except that I noticed the
meaning of SKB_DROP_REASON_FQ_FLOW_LIMIT which is basically the same.
This made me think that perhaps I should also make it qdisc specific.
I'm considering adding a per-flow limit to fq_codel as I'm seeing prod
issues with the global 10240 packet limit. This also need a similar flow
depth limit drop reason. I'm undecided which way to go, please advice.


> The existing SKB_DROP_REASON_QDISC_OVERLIMIT is used in sfq_drop() when
> the overall qdisc limit is exceeded and packets are dropped from the
> longest queue.
> 
> These detailed drop reasons enable production monitoring systems to
> distinguish between different SFQ drop scenarios and generate specific
> metrics for:
> - Flow table exhaustion (flows exceeded)
> - Per-flow congestion (depth limit exceeded)
> - Global qdisc congestion (overall limit exceeded)
> 
> This granular visibility allows operators to identify issues related
> to traffic patterns, and optimize SFQ configuration based on
> real-world drop patterns.
> 
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>   include/net/dropreason-core.h |   12 ++++++++++++
>   net/sched/sch_sfq.c           |    8 ++++----
>   2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> index 58d91ccc56e0..e395d0ff9904 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -69,6 +69,8 @@
>   	FN(QDISC_DROP)			\
>   	FN(QDISC_OVERLIMIT)		\
>   	FN(QDISC_CONGESTED)		\
> +	FN(QDISC_MAXFLOWS)		\
> +	FN(QDISC_MAXDEPTH)		\
>   	FN(CAKE_FLOOD)			\
>   	FN(FQ_BAND_LIMIT)		\
>   	FN(FQ_HORIZON_LIMIT)		\

FQ drop reason names can be seen above.

> @@ -384,6 +386,16 @@ enum skb_drop_reason {
>   	 * due to congestion.
>   	 */
>   	SKB_DROP_REASON_QDISC_CONGESTED,
> +	/**
> +	 * @SKB_DROP_REASON_QDISC_MAXFLOWS: dropped by qdisc when the maximum
> +	 * number of flows is exceeded.
> +	 */
> +	SKB_DROP_REASON_QDISC_MAXFLOWS,
> +	/**
> +	 * @SKB_DROP_REASON_QDISC_MAXDEPTH: dropped by qdisc when a flow
> +	 * exceeds its maximum queue depth limit.
> +	 */
> +	SKB_DROP_REASON_QDISC_MAXDEPTH,
>   	/**
>   	 * @SKB_DROP_REASON_CAKE_FLOOD: dropped by the flood protection part of
>   	 * CAKE qdisc AQM algorithm (BLUE).
> diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
> index 96eb2f122973..e91d74127600 100644
> --- a/net/sched/sch_sfq.c
> +++ b/net/sched/sch_sfq.c
> @@ -302,7 +302,7 @@ static unsigned int sfq_drop(struct Qdisc *sch, struct sk_buff **to_free)
>   		sfq_dec(q, x);
>   		sch->q.qlen--;
>   		qdisc_qstats_backlog_dec(sch, skb);
> -		qdisc_drop(skb, sch, to_free);
> +		qdisc_drop_reason(skb, sch, to_free, SKB_DROP_REASON_QDISC_OVERLIMIT);
>   		return len;
>   	}
>   
> @@ -363,7 +363,7 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
>   	if (x == SFQ_EMPTY_SLOT) {
>   		x = q->dep[0].next; /* get a free slot */
>   		if (x >= SFQ_MAX_FLOWS)
> -			return qdisc_drop(skb, sch, to_free);
> +			return qdisc_drop_reason(skb, sch, to_free, SKB_DROP_REASON_QDISC_MAXFLOWS);
>   		q->ht[hash] = x;
>   		slot = &q->slots[x];
>   		slot->hash = hash;
> @@ -420,14 +420,14 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
>   	if (slot->qlen >= q->maxdepth) {
>   congestion_drop:
>   		if (!sfq_headdrop(q))
> -			return qdisc_drop(skb, sch, to_free);
> +			return qdisc_drop_reason(skb, sch, to_free, SKB_DROP_REASON_QDISC_MAXDEPTH);
>   
>   		/* We know we have at least one packet in queue */
>   		head = slot_dequeue_head(slot);
>   		delta = qdisc_pkt_len(head) - qdisc_pkt_len(skb);
>   		sch->qstats.backlog -= delta;
>   		slot->backlog -= delta;
> -		qdisc_drop(head, sch, to_free);
> +		qdisc_drop_reason(head, sch, to_free, SKB_DROP_REASON_QDISC_MAXDEPTH);
>   
>   		slot_queue_add(slot, skb);
>   		qdisc_tree_reduce_backlog(sch, 0, delta);
> 
> 


