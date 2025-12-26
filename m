Return-Path: <bpf+bounces-77448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C01A6CDE561
	for <lists+bpf@lfdr.de>; Fri, 26 Dec 2025 06:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47938300C0CF
	for <lists+bpf@lfdr.de>; Fri, 26 Dec 2025 05:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD23241691;
	Fri, 26 Dec 2025 05:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VrBbr/wq"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D641DD877
	for <bpf@vger.kernel.org>; Fri, 26 Dec 2025 05:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766725975; cv=none; b=N5gNAC8UHivz7GgdGZyQLkEwIS0Mgp+kk/PBqpoZmgFc6bF+vXpTYT7m+cEogmnJoocgOmCpYNvYFkTusntAEEjIU+/8Lk+r9F0mHQMtFMp37ZxPxstB0z24+GwYVnBPffZvwj2xLrjCU0pe85jl1FF5/+7LD8uXbta7mJhmdxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766725975; c=relaxed/simple;
	bh=/HaNqVbV2X/7uzIsrFCf4APURB58liJ1LS97XUXmRwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0VxF1EeMtyxNA3kVW9sVDq9rGsV5YIBeVPN+QQ8at27I/OBIabJAPIq0/aEgJXTKCOIfNGXAzbhvPtQnB/nMsgms6iJyRDscF5Elq/NFGEPv8oK+GFgNcEpE/dk+4ktphFgtD6KmFVZ4l/kI3+AKGxH+u89q+zSWS6LMy2PfbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VrBbr/wq; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <350280f2-275d-42a4-85a8-58156207201c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766725972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZafFnWuN8zpp6ru39R1BBGDhQxMTMzhU4IAASI+GzY=;
	b=VrBbr/wq/YEOAUggD9d1PBW7JkIn34fGDY5oPd5WvFyYkowxHX6RpMwoNXWY9YMwNYQ4xM
	75r/Qchi7FIxxLndtGkS0hdIoslKDScL8ZuKMne+cRhClb5xul5qv/Vzk61XAnrBq0kfEx
	0tw9SOW73JSa9Y2CCR9fwKsBHHjSCxM=
Date: Thu, 25 Dec 2025 21:12:43 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf: arm64: Fix panic due to missing BTI at
 indirect jump targets
Content-Language: en-GB
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Puranjay Mohan <puranjay@kernel.org>,
 Anton Protopopov <a.s.protopopov@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20251223085447.139301-1-xukuohai@huaweicloud.com>
 <15c26b1f-b78d-45d0-b5d2-e8359ddf5bbc@linux.dev>
 <c099f784-f1bc-4a77-b93e-adf79faca065@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <c099f784-f1bc-4a77-b93e-adf79faca065@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 12/25/25 3:59 AM, Xu Kuohai wrote:
> On 12/24/2025 2:32 AM, Yonghong Song wrote:
>
> [...]
>
>>> +
>>> +/*
>>> + * This function collects possible indirect jump targets in a BPF 
>>> program. Since indirect jump
>>> + * targets can only be read from indirect arrays used as jump 
>>> table, it traverses all jump
>>> + * tables used by @prog. For each instruction found in the jump 
>>> tables, it sets the corresponding
>>> + * bit in @bitmap.
>>> + */
>>> +void bpf_prog_collect_indirect_targets(const struct bpf_prog *prog, 
>>> unsigned long *bitmap)
>>> +{
>>> +    struct bpf_insn_array *insn_array;
>>> +    struct bpf_map *map;
>>> +    u32 xlated_off;
>>> +    int i, j;
>>> +
>>> +    for (i = 0; i < prog->aux->used_map_cnt; i++) {
>>> +        map = prog->aux->used_maps[i];
>>> +        if (!is_jump_table(map))
>>> +            continue;
>>> +
>>> +        insn_array = cast_insn_array(map);
>>> +        for (j = 0; j < map->max_entries; j++) {
>>> +            xlated_off = insn_array->values[j].xlated_off;
>>> +            if (xlated_off == INSN_DELETED)
>>> +                continue;
>>> +            if (xlated_off < prog->aux->subprog_start)
>>> +                continue;
>>> +            xlated_off -= prog->aux->subprog_start;
>>> +            if (xlated_off >= prog->len)
>>> +                continue;
>>
>> The above codes are duplicated with bpf_prog_update_insn_ptrs().
>> Maybe we can have a helper for the above?
>>
>
> I tried using function callbacks to factor out the duplicated code,
> but the result felt a bit over-engineered. For these two functions,
> simple duplication seems clearer and simpler.

I am okay with this then.

>
>>> +            __set_bit(xlated_off, bitmap);
>>> +        }
>>> +    }
>>> +}
>>> +
>>> +void bpf_prog_set_insn_array_type(struct bpf_map *map, int type)
>>> +{
>>> +    struct bpf_insn_array *insn_array = cast_insn_array(map);
>>> +
>>> +    insn_array->type = type;
>>> +}
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index d6b8a77fbe3b..ee6f4ddfbb79 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -20288,6 +20288,12 @@ static int check_indirect_jump(struct 
>>> bpf_verifier_env *env, struct bpf_insn *in
>>>           return -EINVAL;
>>>       }
>>> +    /*
>>> +     * Explicitly mark this map as a jump table such that it can be
>>> +     * distinguished later from other instruction arrays
>>> +     */
>>> +    bpf_prog_set_insn_array_type(map, BPF_INSN_ARRAY_JUMP_TABLE);
>>
>> I think we do not need this for now. If a new indirect_jump type is 
>> introduced,
>> verifier/jit can be adjusted that time if necessary.
>>
>
> As Anton noted, even though jump tables are currently the only type
> of instruction array, users may still create insn_arrays that are not
> used as jump tables. In such cases, there is no need to emit BTIs.

Okay. Thanks for explanation.

>
>>> +
>>>       for (i = 0; i < n - 1; i++) {
>>>           other_branch = push_stack(env, env->gotox_tmp_buf->items[i],
>>>                         env->insn_idx, env->cur_state->speculative);
>>
>>
>>
>


