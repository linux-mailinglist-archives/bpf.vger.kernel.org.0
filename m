Return-Path: <bpf+bounces-78982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3B2D224F7
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 04:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 564AE305A2F1
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 03:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047BB283FD4;
	Thu, 15 Jan 2026 03:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vKTNtO3e"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC8D2989B5
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 03:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768448013; cv=none; b=LR9q1DFTAxWGwIiV61rDx3jpF0pbbd/A1iWXCz1Ifx4mEqwohFAcu6KgWzIioLm9T+3MgFgCs1LDS1PR+yk0mbvSKe3LkP6aE5pUIxMnkW9xGwnn1fmzxfZbDhw3t4QOZd6UaVk+am3jzS3IammEaVmT9Pl1zqAtVNZFq7C4ciI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768448013; c=relaxed/simple;
	bh=SwifmEH36vgZHkEL9Wh5thbrRhr2OxX/OtKyeNOkcWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qh4qgKRFZTo/DwOSYTcz0dC8LNPCoa51+ZD1q5MdYyvVZ589WgZ6G3FRFY6iNW6u/Q84aCslmuy6i/p4vyosgzO17fgK4Ln+dkgLqyI5tBrBNZ0orvPZUzdd1jXdKWWPaFt7rp2nKBy1V1XHAZw6Hp3BuBo+IK7T7ApC1FUiFe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vKTNtO3e; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <48965a3c-011f-49b2-abda-38e2fa1a0ee1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768448009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C6Fh+tPbjQgnUthuSHBuKi8PwjE1LerN8unJAOqdNX4=;
	b=vKTNtO3eKCWKRMMUxpldbAvhX/pVBoG2KvylSmq0zuPfBgShbLaoBhIGZ3QdXGKlPFGA5C
	lAhJu6pkxtAQQ3N+d8bDqkfNgqDuVje3e2Ud3NzU0Dera5BwHovmQB7i3J0JyKXK0QCVnl
	uI0uopGUa1E86ByCkF0sbaGK/DUtY/E=
Date: Thu, 15 Jan 2026 11:33:14 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/5] bpf: lru: Tidy hash handling in LRU code
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Saket Kumar Bhaskar <skb99@linux.ibm.com>,
 "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com,
 bpf@vger.kernel.org
References: <20260107151456.72539-1-leon.hwang@linux.dev>
 <20260107151456.72539-2-leon.hwang@linux.dev>
 <b20c1231-c8ef-4d66-97a9-120f2d77738e@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <b20c1231-c8ef-4d66-97a9-120f2d77738e@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 15/1/26 02:44, Martin KaFai Lau wrote:
> 
> 
> On 1/7/26 7:14 AM, Leon Hwang wrote:
>> The hash field is not used by the LRU list itself.
>>
>> Setting hash while manipulating the LRU list also obscures the intent
>> of the code and makes it harder to follow.
>>
>> Tidy this up by moving the hash assignment to prealloc_lru_pop(),
>> where the element is prepared for insertion into the hash table.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>   kernel/bpf/bpf_lru_list.c | 24 +++++++++---------------
>>   kernel/bpf/bpf_lru_list.h |  5 ++---
>>   kernel/bpf/hashtab.c      |  5 ++---
>>   3 files changed, 13 insertions(+), 21 deletions(-)
>>
>> diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
>> index e7a2fc60523f..f4e183a9c28f 100644
>> --- a/kernel/bpf/bpf_lru_list.c
>> +++ b/kernel/bpf/bpf_lru_list.c
>> @@ -344,10 +344,8 @@ static void bpf_lru_list_pop_free_to_local(struct
>> bpf_lru *lru,
>>   static void __local_list_add_pending(struct bpf_lru *lru,
>>                        struct bpf_lru_locallist *loc_l,
>>                        int cpu,
>> -                     struct bpf_lru_node *node,
>> -                     u32 hash)
>> +                     struct bpf_lru_node *node)
>>   {
>> -    *(u32 *)((void *)node + lru->hash_offset) = hash;
>>       node->cpu = cpu;
>>       node->type = BPF_LRU_LOCAL_LIST_T_PENDING;
>>       bpf_lru_node_clear_ref(node);
>> @@ -393,8 +391,7 @@ __local_list_pop_pending(struct bpf_lru *lru,
>> struct bpf_lru_locallist *loc_l)
>>       return NULL;
>>   }
>>   -static struct bpf_lru_node *bpf_percpu_lru_pop_free(struct bpf_lru
>> *lru,
>> -                            u32 hash)
>> +static struct bpf_lru_node *bpf_percpu_lru_pop_free(struct bpf_lru *lru)
>>   {
>>       struct list_head *free_list;
>>       struct bpf_lru_node *node = NULL;
>> @@ -415,7 +412,6 @@ static struct bpf_lru_node
>> *bpf_percpu_lru_pop_free(struct bpf_lru *lru,
>>         if (!list_empty(free_list)) {
>>           node = list_first_entry(free_list, struct bpf_lru_node, list);
>> -        *(u32 *)((void *)node + lru->hash_offset) = hash;
>>           bpf_lru_node_clear_ref(node);
>>           __bpf_lru_node_move(l, node, BPF_LRU_LIST_T_INACTIVE);
> 
> init the hash value later (after releasing l->lock) is not correct. The
> node is in the inactive list. The inactive list is one of the rotate and
> _evict_ candidates, meaning tgt_l->hash will be used in
> htab_lru_map_delete_node(). In practice, it does not matter if
> htab_lru_map_delete_node() cannot find the node in an incorrect bucket.
> However, it still should not use an uninitialized value to begin with.
> 

Thanks for the explanation — this is the part I missed earlier.

Without additional context or comments in the code, it was not obvious
why the hash needs to be set at that point.

I’ll drop this change as-is. If you have suggestions for a clearer or
better way to handle the hash assignment while preserving the required
ordering, I’d appreciate your guidance.

Thanks,
Leon


