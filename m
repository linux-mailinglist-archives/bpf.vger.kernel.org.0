Return-Path: <bpf+bounces-79248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AE2D31E8C
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA98330F8205
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 13:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3028A283CA3;
	Fri, 16 Jan 2026 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r37QUx9F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B334A57C9F;
	Fri, 16 Jan 2026 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768570293; cv=none; b=sumtetMWXh+V2M4v6aIsNqMQKIgoa/sYmKSJJewC9uE5vi1uQS4Jh4WvCIuN5VCRynIjahfaOoHnVMNDkVsaAd51AvvpF8qcUzsyiGJqzqZ1PqQRnav2zsIRPrD56O4xCBOTON9wFJqmr+QjLtYI4TCjq//RvjqtCAXdw6OAVKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768570293; c=relaxed/simple;
	bh=9Vy/jPify/JousrrmqrdrEGMFOwlyNupmvH1uKH7x20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OGMUIBmcze8lavX46wiJFOtFtbaukhU6nwJREJeel6nRhpahpmul8dM4VKU0SVw9D7ZL+gqVMSie2VdSZswATPtIczL1j+E6fF8i6k/ua7AsiZ5DWjsSyXmb6N0IusG+1gCYVwxLm6BWLXkkkFuDpQN1oB5/GNhkkonbqajPCjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r37QUx9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE2CC116C6;
	Fri, 16 Jan 2026 13:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768570293;
	bh=9Vy/jPify/JousrrmqrdrEGMFOwlyNupmvH1uKH7x20=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r37QUx9FydQpZGmr1SBo+hN2UscCAB22c2CbRhVkD8Q/S01Ze4u+bNlNEHvH0yY6f
	 76T0kKuHPIwp8xYXhE1rG/4+xDdGeVPRvf2phvneAbvPfmn9ZsOrBjctW3X5g8Y8Tg
	 eqiuv9XTLK1u3Cr3m7QMMHws5CJnLik88V0qK1rLi+vSGWFpKgkbQjar943mAdTaog
	 DZiOUPtmBDzRVIidGFgnGW9B3Ctgj1iQs4/FmTzc43bGy5f0bUHx5TvuT3C5C60qA+
	 Rv8wuvvsuRyJYHk991ElBLoGVEvele/TSnCkTHFDzC3yOD81515qDchRzem36Sbbqu
	 ywaaYwuvW01VA==
Message-ID: <878bf70f-a5d5-4120-ad0a-9282478ffaeb@kernel.org>
Date: Fri, 16 Jan 2026 14:31:29 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] net: sched: sfq: add detailed drop reasons
 for monitoring
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, carges@cloudflare.com,
 kernel-team@cloudflare.com, Alexei Starovoitov <ast@kernel.org>,
 Yan Zhai <yan@cloudflare.com>
References: <176847978787.939583.16722243649193888625.stgit@firesoul>
 <1bbbb306-d497-4143-a714-b126ecc41a06@kernel.org> <87ms2dzutr.fsf@toke.dk>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <87ms2dzutr.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/01/2026 12.00, Toke Høiland-Jørgensen wrote:
> Jesper Dangaard Brouer <hawk@kernel.org> writes:
> 
>> Hi Eric,
>>
>> I need an opinion on naming for drop_reasons below.
>>
>> On 15/01/2026 13.23, Jesper Dangaard Brouer wrote:
>>> Add specific drop reasons to SFQ qdisc to improve packet drop observability
>>> and monitoring capabilities. This change replaces generic qdisc_drop()
>>> calls with qdisc_drop_reason() to provide granular metrics about different
>>> drop scenarios in production environments.
>>>
>>> Two new drop reasons are introduced:
>>>
>>> - SKB_DROP_REASON_QDISC_MAXFLOWS: Used when a new flow cannot be created
>>>     because the maximum number of flows (flows parameter) has been
>>>     reached and no free flow slots are available.
>>>
>>> - SKB_DROP_REASON_QDISC_MAXDEPTH: Used when a flow's queue length exceeds
>>>     the per-flow depth limit (depth parameter), triggering either tail drop
>>>     or head drop depending on headdrop configuration.
>>
>> I noticed commit 5765c7f6e317 ("net_sched: sch_fq: add three
>> drop_reason") (Author: Eric Dumazet).
>>
>>    SKB_DROP_REASON_FQ_BAND_LIMIT: Per-band packet limit exceeded
>>    SKB_DROP_REASON_FQ_HORIZON_LIMIT: Packet timestamp too far in future
>>    SKB_DROP_REASON_FQ_FLOW_LIMIT: Per-flow packet limit exceeded
>>
>> Should I/we make SKB_DROP_REASON_QDISC_MAXDEPTH specific for SFQ ?
>> Like naming it = SKB_DROP_REASON_SFQ_MAXDEPTH ?
>>
>> Currently SKB_DROP_REASON_QDISC_MAXDEPTH is only used in SFQ, but it
>> might be usable in other qdisc as well.  Except that I noticed the
>> meaning of SKB_DROP_REASON_FQ_FLOW_LIMIT which is basically the same.
>> This made me think that perhaps I should also make it qdisc specific.
>> I'm considering adding a per-flow limit to fq_codel as I'm seeing prod
>> issues with the global 10240 packet limit. This also need a similar flow
>> depth limit drop reason. I'm undecided which way to go, please advice.
> 
> IMO, we should be reusing drop reasons where it makes sense (so
> s/FQ/QDISC/ SKB_DROP_REASON_FQ_FLOW_LIMIT), but not sure if these are
> considered UAPI (i.e., can we change the name of the existing one)?
> 

The UAPI definition for SKB_DROP_REASON's is interesting. In this patch
(and Eric's commit) we insert in the middle of enum skb_drop_reason (on
purpose), this shows the enum numbers are not UAPI.  This is because we
want to force users to use BTF info in running kernel to resolve these IDs.
The resolved name are IMHO UAPI as e.g. our Rust code (Cc Yan) match on
these names and configures different sampling rates. So, changing name
SKB_DROP_REASON_FQ_FLOW_LIMIT have the change of breaking some userspace
tool consuming these.

Production wise, it would be easier to have SKB_DROP_REASON_SFQ_MAXDEPTH
and SKB_DROP_REASON_FQ_FLOW_LIMIT separate as the qdisc is part of the
name.  Then our Rust code don't have to also decode the net_device to
identify the qdisc involved.

--Jesper

