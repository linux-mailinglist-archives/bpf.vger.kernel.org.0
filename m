Return-Path: <bpf+bounces-76029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EC9CA28FD
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 07:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBF973020371
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 06:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4571EB5DB;
	Thu,  4 Dec 2025 06:47:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DFE2459C6
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 06:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764830843; cv=none; b=t6slXEmAbQTSP0VHo981haIg3yUCuJd5hY+HCsofsylqJPoDXe6vwOulm72bUC0fP5ZvBYzkTlatte6Ih+Ptnnt/dnJ+FH9b4blgOs3biHzI7DRf3zNh2VYONdlfru8F4WC8aB/bwT+t7OB53lewLU9VYDR6u6WR/t9Vm5FahU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764830843; c=relaxed/simple;
	bh=+MrY9PfBo/48ZQmxXga5s5rQEwV4NlWGH/QKgO2NbOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=isvHxwoOkVllKdVAA+1EraRpBJJxw01Lsxnw603/ljac+nyi7/CDzUqx21ZVTioV5lm6w8zFbwKadk2k7/S6EIRFwy3C1TP2hfpD3hHNGtGsEnD1mTr6FHewXzPwLJ6rMg1wKJI9Z1xlg5rVqNXth2vtm878PbKKM5XEkyW0pEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dMQ5b4132zKHMSG
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 14:46:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1EB6B1A0E99
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 14:47:18 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgCHZ1F0LjFpigEuAg--.42794S2;
	Thu, 04 Dec 2025 14:47:17 +0800 (CST)
Message-ID: <3fd352f0-2445-4fee-8c0a-8fb24efc2dc8@huaweicloud.com>
Date: Thu, 4 Dec 2025 14:47:16 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: arm64: Fix panic due to missing BTI at
 indirect jump targets
Content-Language: en-US
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>,
 Puranjay Mohan <puranjay@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20251127140318.3944249-1-xukuohai@huaweicloud.com>
 <aSh4QCd27MUHMVdp@mail.gmail.com> <aSiAeTnrh9JQ0EGh@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <aSiAeTnrh9JQ0EGh@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCHZ1F0LjFpigEuAg--.42794S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4xGFW7AF47Gry7JF4fZrb_yoW5KFW3pa
	ykJa4IkF48tF4Ik347Aa18Cryaqr4rG39xCas8J3y0yFyjgrnYgFWUKFnIkFnxtr4Fvw1I
	vF4293yF93yUZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 11/28/2025 12:46 AM, Anton Protopopov wrote:

[...]

>>> diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
>>> index 61ce52882632..ed20b186a1f5 100644
>>> --- a/kernel/bpf/bpf_insn_array.c
>>> +++ b/kernel/bpf/bpf_insn_array.c
>>> @@ -299,3 +299,46 @@ void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
>>>   		}
>>>   	}
>>>   }
>>> +
>>> +bool bpf_prog_has_insn_array(const struct bpf_prog *prog)
>>> +{
>>> +	int i;
>>> +
>>> +	for (i = 0; i < prog->aux->used_map_cnt; i++) {
>>> +		if (is_insn_array(prog->aux->used_maps[i]))
>>> +			return true;
>>> +	}
>>> +	return false;
>>> +}
>>
>> I think a different check is needed here (and a different function
>> name, smth like "bpf_prog_has_indirect_jumps"), and a different
>> algorithm to collect jump targets in the chunk below. A program can
>> have instruction arrays not related to indirect jumps (see, e.g.,
>> bpf_insn_array selftests + in future insns arrays will be used to
>> also support other functionality). As an extreme case, an insn array
>> can point to every instruction in a prog, thus a BTI will be
>> generated for every instruction.
>>
>> In verifier it is used a bit differently, namely, all insn arrays for
>> a given subprog are collected when an indirect jump is encountered
>> (and non-deterministic only in check_cfg). Later in verification, an
>> exact map is used, so this is not a problem.
>>
>> Initially I wanted to have a map flag (in map_extra) to distingiush between
>> different types of instruction arrays ("plane ones", "jump targets",
>> "call targets", "static keys"), but Andrii wasn't happy with it,
>> so eventually I've dropped it. Maybe it is worth adding it until
>> the code is merged to upstream? Eduard, Alexei, wdyt?
> 
> Actually, this is even better to mark a map as containing indirect
> jump targets in check_indirect_jump(). This will be the most precise
> set of targets, and won't require any userspace-visible changes/flags.
> 
> Something like this:
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 6498be4c44f8..c2d708213330 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -292,6 +292,10 @@ struct bpf_map_owner {
>   	enum bpf_attach_type expected_attach_type;
>   };
>   
> +/* map_subtype values for map_type BPF_MAP_TYPE_INSN_ARRAY */
> +#define BPF_INSN_ARRAY_VOID		0
> +#define BPF_INSN_ARRAY_JUMP_TABLE	1
> +
>   struct bpf_map {
>   	u8 sha[SHA256_DIGEST_SIZE];
>   	const struct bpf_map_ops *ops;
> @@ -331,6 +335,7 @@ struct bpf_map {
>   	bool frozen; /* write-once; write-protected by freeze_mutex */
>   	bool free_after_mult_rcu_gp;
>   	bool free_after_rcu_gp;
> +	u32 map_subtype; /* defined per map type */
>   	atomic64_t sleepable_refcnt;
>   	s64 __percpu *elem_count;
>   	u64 cookie; /* write-once */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 766695491bc5..60bbd32e793a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20293,6 +20293,12 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
>   		return -EINVAL;
>   	}
>   
> +	/*
> +	 * Explicitly mark this map as a jump table such that it can be
> +	 * distinguished later from other instruction arrays
> +	 */
> +	map->map_subtype = BPF_INSN_ARRAY_JUMP_TABLE;
> +
>   	for (i = 0; i < n - 1; i++) {
>   		other_branch = push_stack(env, env->gotox_tmp_buf->items[i],
>   					  env->insn_idx, env->cur_state->speculative);
> 

Looks good to me. Would you like to submit it as a separate patch, or
shall I include it in my patch with your SOB?


