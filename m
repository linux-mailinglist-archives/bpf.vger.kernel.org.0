Return-Path: <bpf+bounces-79536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D9840D3BD50
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 02:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46487302C87D
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 01:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395F12571D7;
	Tue, 20 Jan 2026 01:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HIoyYOP2"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280B125CC79
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 01:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768874226; cv=none; b=oeLFN65vr49CPgdPSw/ZIW9aMz5kXMlqvRiN9H5cJrDj7nIeqeDdvjm1lidV3KRU3NBDtOnydPbpOABKKLSOI2GvJrTtkl+znkoWQS9Jlinf8kKfEJM1HXn/wjEKHsElGi8jb5rRUb5IYFkR76PRKkmyk76ojbt5T6QEDA5dlQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768874226; c=relaxed/simple;
	bh=Lj9MR3O//LlHY0CqAzehEsoGpUKTjFkoq4ed0qyGMC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PEn/xfLTuf3mtMNG3aq9qjASg6Xbm5M0yCR11Rpv5bKLZKXu+JroO0y+j829WGCKu2g5FEYO+sAcMeRl1BlkeyLDyynEwpH0+L3Cddb3CEeIZR2vjUiYuDQkytU2eUgvWf1MCz3IwAh64AWjBMJyQa5dbDuwfXGGIsnRSiKZxVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HIoyYOP2; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8ed48af7-8a85-4012-8b86-79e83f0689b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768874212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgLtN+nSGO1qKy5SN0VUE8DA0Ow4W7zLLJj9oRoBaSI=;
	b=HIoyYOP22niNe4BzTeMEkamgrgUgERN6NaHTwVWrYuLs9BrzcI6b3R3vQmr3EqRTODFaxo
	9s7LPO60CETHhMHtnYAOFHe37WrzPqXTXJKVnVPvjdDJHLWkCSKy+K5m/a2Zf+5glRLMXY
	AVv9hpj3o024ZcTS6jF7TXjmj0sTkTI=
Date: Tue, 20 Jan 2026 09:56:42 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/3] bpf: Avoid deadlock using trylock when
 popping LRU free nodes
Content-Language: en-US
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260119142120.28170-3-leon.hwang@linux.dev>
 <a4904d743818169a9a8c1e30dd51ee7a8672bf2b883e973dcca489ff28a3e708@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <a4904d743818169a9a8c1e30dd51ee7a8672bf2b883e973dcca489ff28a3e708@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 20/1/26 02:46, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
>> index c091f3232cc5..03d37f72731a 100644
>> --- a/kernel/bpf/bpf_lru_list.c
>> +++ b/kernel/bpf/bpf_lru_list.c
> 
> [ ... ]
> 
>> @@ -451,13 +455,12 @@ static struct bpf_lru_node *bpf_common_lru_pop_free(struct bpf_lru *lru,
>>
>>  	loc_l = per_cpu_ptr(clru->local_list, cpu);
>>
>> -	raw_spin_lock_irqsave(&loc_l->lock, flags);
>> +	if (!raw_spin_trylock_irqsave(&loc_l->lock, flags))
>> +		return NULL;
>>
>>  	node = __local_list_pop_free(loc_l);
>> -	if (!node) {
>> -		bpf_lru_list_pop_free_to_local(lru, loc_l);
>> +	if (!node && bpf_lru_list_pop_free_to_local(lru, loc_l))
>>  		node = __local_list_pop_free(loc_l);
>> -	}
>>
>>  	if (node)
>>  		__local_list_add_pending(lru, loc_l, cpu, node, hash);
> 
> The trylock conversion here looks correct, but what about the steal path
> that follows later in bpf_common_lru_pop_free()? Looking at the existing
> code (not shown in this diff), the steal loop still uses unconditional
> raw_spin_lock_irqsave():
> 
>     do {
>         steal_loc_l = per_cpu_ptr(clru->local_list, steal);
> 
>         raw_spin_lock_irqsave(&steal_loc_l->lock, flags);
>         ...
>     } while (...);
> 
> If the goal is to avoid NMI-context deadlocks when acquiring LRU locks,
> can the same deadlock scenario occur when NMI interrupts during the steal
> loop and the NMI handler tries to acquire the same steal_loc_l->lock?
> 
> Similarly, after a successful steal, there is another unconditional lock:
> 
>     if (node) {
>         raw_spin_lock_irqsave(&loc_l->lock, flags);
>         __local_list_add_pending(lru, loc_l, cpu, node, hash);
>         raw_spin_unlock_irqrestore(&loc_l->lock, flags);
>     }
> 
> Should these also use trylock to maintain consistency with the stated goal
> of avoiding NMI-context deadlocks?
> 

This patch is not intended to eliminate all possible deadlock scenarios.
Its goal is to avoid deadlocks caused by long-lived critical sections
in the free-node pop paths, where lock contention can persist and lead
to re-entrant lock acquisition from NMI context.

The steal path and the post-steal update are both short-lived critical
sections. They do not exhibit the same contention characteristics and
have not been observed to trigger the reported deadlock scenarios.
Converting these paths to trylock would add complexity without clear
benefit, and is therefore unnecessary for the stated goal of this change.

Thanks,
Leon

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21147913717


