Return-Path: <bpf+bounces-20821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4235D843FBA
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 13:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08A41F2B0C5
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 12:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CF07AE6A;
	Wed, 31 Jan 2024 12:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCGE1xth"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9441E522;
	Wed, 31 Jan 2024 12:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706705493; cv=none; b=jcOpArDI7KFgjYsw5wPJ563wXv6DvLH7HKjFVcj1e7PW3U3o32sbzN2UeuM+kmerVmYPM5lvEFl1BTerAc53I1WPCNYJXMfy+Zead9gfKeiWcduyQ8eYTSpYXBaj+YAwu89ZN84iafyZMtOE+xXonpFq++MBAvcSkPccBmpyxzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706705493; c=relaxed/simple;
	bh=zFi4R+3mcquhXVmCyyI6i9sQRxec6JwZEMr5wMdPo3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBwuN5tPmR2iJJOIu8WlVniilvUw5PVtVztC/hjdBECLdWbw3H4Tk3f5/KexyYaOcQCPuBCBRdpJJujaouoPFkfuv7qlE0PfNYG/uZUS2EcNdhWvXl3mOb59YcyhvOmoinnMK7U4LJh0aUFVXoPt+mwEtxZ+Y833F25st6zzCd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCGE1xth; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF91C43394;
	Wed, 31 Jan 2024 12:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706705492;
	bh=zFi4R+3mcquhXVmCyyI6i9sQRxec6JwZEMr5wMdPo3E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZCGE1xthknSNmiwOozi5a+jQJ5Io63IXI6wUs0ZYYj5h15i7fhvOHs+iGN1OEwcLV
	 6iSzek1yRIfpSW2RZbk3KpwXSPmF1Uwn6ddJ6SfXeaMJOyUgS9LhEBw7IQR8f5NshL
	 +z70ty7IiLzHrYkVVOE/o+B7Y+t6mbvY7vuJM5aqbuBT/n2zrryKJbiHBFInXb+J2H
	 b5CqjxCKPwx2zZbTZ6aiY+y91J4V6rkUEd2m83dbrDvi8YomKGUmjGM2mfYTPhj2RH
	 kLnVNihpRH/yfVbjBaVbk+3sCQMP0Suw0ZieaIYWm4lVoiewTiW+PmKZWTfDoA176L
	 i+PWwyOeFm6yg==
Message-ID: <32f93a3e-5c4f-4f32-8158-4755f08b5ed4@kernel.org>
Date: Wed, 31 Jan 2024 13:51:28 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 1/5] net: add generic per-cpu page_pool
 allocator
Content-Language: en-US
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, bpf@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com, sdf@google.com, ilias.apalodimas@linaro.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <cover.1706451150.git.lorenzo@kernel.org>
 <5b0222d3df382c22fe0fa96154ae7b27189f7ecd.1706451150.git.lorenzo@kernel.org>
 <87jzns1f71.fsf@toke.dk> <ZbefjZvKUMtaCbm1@lore-desk>
 <87bk9416vq.fsf@toke.dk>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <87bk9416vq.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 29/01/2024 16.44, Toke Høiland-Jørgensen wrote:
> Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:
> 
>>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>>>
>>>> Introduce generic percpu page_pools allocator.
>>>> Moreover add page_pool_create_percpu() and cpuid filed in page_pool struct
>>>> in order to recycle the page in the page_pool "hot" cache if
>>>> napi_pp_put_page() is running on the same cpu.
>>>> This is a preliminary patch to add xdp multi-buff support for xdp running
>>>> in generic mode.
>>>>
>>>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>>>> ---
>>>>   include/net/page_pool/types.h |  3 +++
>>>>   net/core/dev.c                | 40 +++++++++++++++++++++++++++++++++++
>>>>   net/core/page_pool.c          | 23 ++++++++++++++++----
>>>>   net/core/skbuff.c             |  5 +++--
>>>>   4 files changed, 65 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
>>>> index 76481c465375..3828396ae60c 100644
>>>> --- a/include/net/page_pool/types.h
>>>> +++ b/include/net/page_pool/types.h
>>>> @@ -128,6 +128,7 @@ struct page_pool_stats {
>>>>   struct page_pool {
>>>>   	struct page_pool_params_fast p;
>>>>   
>>>> +	int cpuid;
>>>>   	bool has_init_callback;
>>>>   
>>>>   	long frag_users;
>>>> @@ -203,6 +204,8 @@ struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
>>>>   struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
>>>>   				  unsigned int size, gfp_t gfp);
>>>>   struct page_pool *page_pool_create(const struct page_pool_params *params);
>>>> +struct page_pool *page_pool_create_percpu(const struct page_pool_params *params,
>>>> +					  int cpuid);
>>>>   
>>>>   struct xdp_mem_info;
>>>>   
>>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>>> index cb2dab0feee0..bf9ec740b09a 100644
>>>> --- a/net/core/dev.c
>>>> +++ b/net/core/dev.c
>>>> @@ -153,6 +153,8 @@
>>>>   #include <linux/prandom.h>
>>>>   #include <linux/once_lite.h>
>>>>   #include <net/netdev_rx_queue.h>
>>>> +#include <net/page_pool/types.h>
>>>> +#include <net/page_pool/helpers.h>
>>>>   
>>>>   #include "dev.h"
>>>>   #include "net-sysfs.h"
>>>> @@ -442,6 +444,8 @@ static RAW_NOTIFIER_HEAD(netdev_chain);
>>>>   DEFINE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
>>>>   EXPORT_PER_CPU_SYMBOL(softnet_data);
>>>>   
>>>> +DEFINE_PER_CPU_ALIGNED(struct page_pool *, page_pool);
>>>
>>> I think we should come up with a better name than just "page_pool" for
>>> this global var. In the code below it looks like it's a local variable
>>> that's being referenced. Maybe "global_page_pool" or "system_page_pool"
>>> or something along those lines?
>>
>> ack, I will fix it. system_page_pool seems better, agree?
> 
> Yeah, agreed :)

Naming it "system_page_pool" is good by me.

Should we add some comments about concurrency expectations when using this?
Or is this implied by "PER_CPU" define?

PP alloc side have a lockless array/stack, and the per_cpu stuff do
already imply only one CPU is accessing this, and implicitly (also) we
cannot handle reentrance cause by preemption.  So, the caller have the
responsibility to call this from appropriate context.

--Jesper

