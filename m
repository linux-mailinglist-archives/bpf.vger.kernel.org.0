Return-Path: <bpf+bounces-77439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C67CDDB99
	for <lists+bpf@lfdr.de>; Thu, 25 Dec 2025 12:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67D54301CE91
	for <lists+bpf@lfdr.de>; Thu, 25 Dec 2025 11:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265B830BF79;
	Thu, 25 Dec 2025 11:59:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24559223708;
	Thu, 25 Dec 2025 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766663960; cv=none; b=DIbX5w2qMq9UWs1WOAdERJjvrmXfTpnuG8C3a6OSffKGYo8LoXenx6r7SnuYvFToIB2kUVbIv5XT2DssTW6D6an/mJp0rxqBwn7/zoECLbGX3h1zmXcrrNbZhCHZAkjNB91xKlYSEew3gnn7K9qkhuCCtJp5zrz4v0ilbFx/sxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766663960; c=relaxed/simple;
	bh=JWcpqYZQ1oBLVm9foQ6v2v+7QcB7V021wkwTPC8mNTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghNcIL0DIg3DQl7fO9bRc8p+5635G1umDe/Qz+YDSmw2pcrPgBJ2FnqoUNgEqy/zQKA7+Zlcwwe9sNYtt7+2+12clJmF058vhg7BP7uJV7nV2UWki0sIqizyURZHJIG/n9rr599LHPcZyjnyp40uJ7UE+DRO1wTLX6heUKovi70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dcS2P26tXzKHMVT;
	Thu, 25 Dec 2025 19:58:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 931F94056D;
	Thu, 25 Dec 2025 19:59:14 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgB3xhQRJ01pceGcBQ--.48044S2;
	Thu, 25 Dec 2025 19:59:14 +0800 (CST)
Message-ID: <c099f784-f1bc-4a77-b93e-adf79faca065@huaweicloud.com>
Date: Thu, 25 Dec 2025 19:59:13 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf: arm64: Fix panic due to missing BTI at
 indirect jump targets
Content-Language: en-US
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Puranjay Mohan <puranjay@kernel.org>,
 Anton Protopopov <a.s.protopopov@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20251223085447.139301-1-xukuohai@huaweicloud.com>
 <15c26b1f-b78d-45d0-b5d2-e8359ddf5bbc@linux.dev>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <15c26b1f-b78d-45d0-b5d2-e8359ddf5bbc@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3xhQRJ01pceGcBQ--.48044S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCw4kXw17uFyUKFWkGr4xCrg_yoW5ur18pF
	1kJryUArWUJrs3Jr1UJw1UCFy3Zr4DJ3WDGF1rXa4UJr4UArn0gFWUWrsIgr15tF48Jr18
	Zr1UXr9rZ34UJrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 12/24/2025 2:32 AM, Yonghong Song wrote:

[...]

>> +
>> +/*
>> + * This function collects possible indirect jump targets in a BPF program. Since indirect jump
>> + * targets can only be read from indirect arrays used as jump table, it traverses all jump
>> + * tables used by @prog. For each instruction found in the jump tables, it sets the corresponding
>> + * bit in @bitmap.
>> + */
>> +void bpf_prog_collect_indirect_targets(const struct bpf_prog *prog, unsigned long *bitmap)
>> +{
>> +    struct bpf_insn_array *insn_array;
>> +    struct bpf_map *map;
>> +    u32 xlated_off;
>> +    int i, j;
>> +
>> +    for (i = 0; i < prog->aux->used_map_cnt; i++) {
>> +        map = prog->aux->used_maps[i];
>> +        if (!is_jump_table(map))
>> +            continue;
>> +
>> +        insn_array = cast_insn_array(map);
>> +        for (j = 0; j < map->max_entries; j++) {
>> +            xlated_off = insn_array->values[j].xlated_off;
>> +            if (xlated_off == INSN_DELETED)
>> +                continue;
>> +            if (xlated_off < prog->aux->subprog_start)
>> +                continue;
>> +            xlated_off -= prog->aux->subprog_start;
>> +            if (xlated_off >= prog->len)
>> +                continue;
> 
> The above codes are duplicated with bpf_prog_update_insn_ptrs().
> Maybe we can have a helper for the above?
>

I tried using function callbacks to factor out the duplicated code,
but the result felt a bit over-engineered. For these two functions,
simple duplication seems clearer and simpler.

>> +            __set_bit(xlated_off, bitmap);
>> +        }
>> +    }
>> +}
>> +
>> +void bpf_prog_set_insn_array_type(struct bpf_map *map, int type)
>> +{
>> +    struct bpf_insn_array *insn_array = cast_insn_array(map);
>> +
>> +    insn_array->type = type;
>> +}
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index d6b8a77fbe3b..ee6f4ddfbb79 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -20288,6 +20288,12 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
>>           return -EINVAL;
>>       }
>> +    /*
>> +     * Explicitly mark this map as a jump table such that it can be
>> +     * distinguished later from other instruction arrays
>> +     */
>> +    bpf_prog_set_insn_array_type(map, BPF_INSN_ARRAY_JUMP_TABLE);
> 
> I think we do not need this for now. If a new indirect_jump type is introduced,
> verifier/jit can be adjusted that time if necessary.
>

As Anton noted, even though jump tables are currently the only type
of instruction array, users may still create insn_arrays that are not
used as jump tables. In such cases, there is no need to emit BTIs.

>> +
>>       for (i = 0; i < n - 1; i++) {
>>           other_branch = push_stack(env, env->gotox_tmp_buf->items[i],
>>                         env->insn_idx, env->cur_state->speculative);
> 
> 
> 


