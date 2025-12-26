Return-Path: <bpf+bounces-77447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8405CDE55B
	for <lists+bpf@lfdr.de>; Fri, 26 Dec 2025 06:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7EAE300C0C5
	for <lists+bpf@lfdr.de>; Fri, 26 Dec 2025 05:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBB523E229;
	Fri, 26 Dec 2025 05:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cqouYhw5"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90246239E9E
	for <bpf@vger.kernel.org>; Fri, 26 Dec 2025 05:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766725826; cv=none; b=tLs8ZwoSX4cWET5fv0Dpl+FJjisgP9cjHa3IaCcYxrmZUiAV1D8D3QciQXleHUbFxylWsv5nG0LVV0RBeHU2QoPrEn6q55jDLD9daQu/8mmVvEZ0hx1JNFocwOzvzvOmBPAzm1a6CzGVZJMdauHZtDz8BYvJ3sPMQaUbQyC8eVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766725826; c=relaxed/simple;
	bh=Hrua9Qt5/xIll4WONeluaiEO2In6q0MxhN9P4/10Woc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gej41rLIrV6+Rel5n6LcVmvgsSACbPW4s6DkAq2r5kfahYyfjSU8SwiFyPNUIcYFYs9wBG3A5tpTouey+SKQOOU5adHD8+0jkqx0kzJpTabixdE/7PHSYonN6vpqKJGxEIhI7RQ2qlAplcEnaKLhY7yq0fIgIeW0PP6wFVPX5GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cqouYhw5; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3a27e25a-7a2d-4adb-8f79-0596987ed302@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766725821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=91WOaf1rl2iBPXwIkmAEbjVo4fBuDTPKJkzhY4wCh5g=;
	b=cqouYhw5GJMW4k87jYi1Atrfo1HjF8hTXXmaccjYTtEbwgemvHMUYvRGyMc4r5K7u3v9Kg
	RrbTKK5icsWdKS/UDrcwvrqgtWogaQr+h23XyG9KHZp8WYhydLSeLd2XTq8b3J/adweekC
	psQeWhgOML8OBB7Nz0eMB2aEAvESGjA=
Date: Thu, 25 Dec 2025 21:10:08 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf: arm64: Fix panic due to missing BTI at
 indirect jump targets
Content-Language: en-GB
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Puranjay Mohan <puranjay@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20251223085447.139301-1-xukuohai@huaweicloud.com>
 <15c26b1f-b78d-45d0-b5d2-e8359ddf5bbc@linux.dev>
 <aU0aW3VE1a8FI0Xm@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <aU0aW3VE1a8FI0Xm@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 12/25/25 3:04 AM, Anton Protopopov wrote:
> On 25/12/23 10:32AM, Yonghong Song wrote:
>>
>> On 12/23/25 12:54 AM, Xu Kuohai wrote:
>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>
>>> When BTI is enabled, the indirect jump selftest triggers BTI exception:
>>>
>>> Internal error: Oops - BTI: 0000000036000003 [#1]  SMP
>>> ...
>>> Call trace:
>>>    bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x54/0xf8 (P)
>>>    bpf_prog_run_pin_on_cpu+0x140/0x464
>>>    bpf_prog_test_run_syscall+0x274/0x3ac
>>>    bpf_prog_test_run+0x224/0x2b0
>>>    __sys_bpf+0x4cc/0x5c8
>>>    __arm64_sys_bpf+0x7c/0x94
>>>    invoke_syscall+0x78/0x20c
>>>    el0_svc_common+0x11c/0x1c0
>>>    do_el0_svc+0x48/0x58
>>>    el0_svc+0x54/0x19c
>>>    el0t_64_sync_handler+0x84/0x12c
>>>    el0t_64_sync+0x198/0x19c
>>>
>>> This happens because no BTI instruction is generated by the JIT for
>>> indirect jump targets.
>>>
>>> Fix it by emitting BTI instruction for every possible indirect jump
>>> targets when BTI is enabled. The targets are identified by traversing
>>> all instruction arrays of jump table type used by the BPF program,
>>> since indirect jump targets can only be read from instruction arrays
>>> of jump table type.
>>>
>>> Fixes: f4a66cf1cb14 ("bpf: arm64: Add support for indirect jumps")
>>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>>> ---
>>> v2:
>>> - Exclude instruction arrays not used for indirect jumps (Anton Protopopov)
>>>
>>> v1: https://lore.kernel.org/bpf/20251127140318.3944249-1-xukuohai@huaweicloud.com/
>>> ---
>>>    arch/arm64/net/bpf_jit_comp.c | 20 +++++++++++
>>>    include/linux/bpf.h           | 19 +++++++++++
>>>    kernel/bpf/bpf_insn_array.c   | 63 +++++++++++++++++++++++++++++++++++
>>>    kernel/bpf/verifier.c         |  6 ++++
>>>    4 files changed, 108 insertions(+)
>>>
>>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>>> index 0c4d44bcfbf4..f08f0f9fa04e 100644
>>> --- a/arch/arm64/net/bpf_jit_comp.c
>>> +++ b/arch/arm64/net/bpf_jit_comp.c
>>> @@ -78,6 +78,7 @@ static const int bpf2a64[] = {
>>>    struct jit_ctx {
>>>    	const struct bpf_prog *prog;
>>> +	unsigned long *indirect_targets;
>>>    	int idx;
>>>    	int epilogue_offset;
>>>    	int *offset;
>>> @@ -1199,6 +1200,11 @@ static int add_exception_handler(const struct bpf_insn *insn,
>>>    	return 0;
>>>    }
>>> +static bool is_indirect_target(int insn_off, unsigned long *targets_bitmap)
>>> +{
>>> +	return targets_bitmap && test_bit(insn_off, targets_bitmap);
>>> +}
>>> +
>>>    /* JITs an eBPF instruction.
>>>     * Returns:
>>>     * 0  - successfully JITed an 8-byte eBPF instruction.
>>> @@ -1231,6 +1237,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>>>    	int ret;
>>>    	bool sign_extend;
>>> +	if (is_indirect_target(i, ctx->indirect_targets))
>>> +		emit_bti(A64_BTI_J, ctx);
>>> +
>>>    	switch (code) {
>>>    	/* dst = src */
>>>    	case BPF_ALU | BPF_MOV | BPF_X:
>>> @@ -2085,6 +2094,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>>    	memset(&ctx, 0, sizeof(ctx));
>>>    	ctx.prog = prog;
>>> +	if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL) && bpf_prog_has_jump_table(prog)) {
>>> +		ctx.indirect_targets = kvcalloc(BITS_TO_LONGS(prog->len), sizeof(unsigned long),
>>> +						GFP_KERNEL);
>>> +		if (ctx.indirect_targets == NULL) {
>>> +			prog = orig_prog;
>>> +			goto out_off;
>>> +		}
>>> +		bpf_prog_collect_indirect_targets(prog, ctx.indirect_targets);
>>> +	}
>>> +
>>>    	ctx.offset = kvcalloc(prog->len + 1, sizeof(int), GFP_KERNEL);
>>>    	if (ctx.offset == NULL) {
>>>    		prog = orig_prog;
>>> @@ -2248,6 +2267,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>>    			prog->aux->priv_stack_ptr = NULL;
>>>    		}
>>>    		kvfree(ctx.offset);
>>> +		kvfree(ctx.indirect_targets);
>>>    out_priv_stack:
>>>    		kfree(jit_data);
>>>    		prog->aux->jit_data = NULL;
>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>> index da6a00dd313f..a3a89d4b4dae 100644
>>> --- a/include/linux/bpf.h
>>> +++ b/include/linux/bpf.h
>>> @@ -3875,13 +3875,32 @@ void bpf_insn_array_release(struct bpf_map *map);
>>>    void bpf_insn_array_adjust(struct bpf_map *map, u32 off, u32 len);
>>>    void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
>>> +enum bpf_insn_array_type {
>>> +	BPF_INSN_ARRAY_VOID,
>> What is the purpose for BPF_INSN_ARRAY_VOID? Do we really need it?
> There seems to be no need for a name for the default case,
> but BPF_INSN_ARRAY_JUMP_TABLE should be != 0, so can be just
>
> enum bpf_insn_array_type {
> 	BPF_INSN_ARRAY_JUMP_TABLE = 1,
> };
>
>>> +	BPF_INSN_ARRAY_JUMP_TABLE,
>>> +};
>>> +
>>>    #ifdef CONFIG_BPF_SYSCALL
>>>    void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image);
>>> +void bpf_prog_collect_indirect_targets(const struct bpf_prog *prog, unsigned long *bitmap);
>>> +void bpf_prog_set_insn_array_type(struct bpf_map *map, int type);
>>> +bool bpf_prog_has_jump_table(const struct bpf_prog *prog);
>>>    #else
>>>    static inline void
>>>    bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
>>>    {
>>>    }
>>> +static inline void
>>> +bpf_prog_collect_indirect_targets(const struct bpf_prog *prog, unsigned long *bitmap)
>>> +{
>>> +}
>>> +static inline void bpf_prog_set_insn_array_type(struct bpf_map *map, int type)
>>> +{
>>> +}
>>> +static inline bool bpf_prog_has_jump_table(const struct bpf_prog *prog)
>>> +{
>>> +	return false;
>>> +}
>>>    #endif
>>>    static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 allowed_flags)
>>> diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
>>> index c96630cb75bf..fbffc865feab 100644
>>> --- a/kernel/bpf/bpf_insn_array.c
>>> +++ b/kernel/bpf/bpf_insn_array.c
>>> @@ -5,6 +5,7 @@
>>>    struct bpf_insn_array {
>>>    	struct bpf_map map;
>>> +	int type;
>>>    	atomic_t used;
>>>    	long *ips;
>>>    	DECLARE_FLEX_ARRAY(struct bpf_insn_array_value, values);
>>> @@ -159,6 +160,17 @@ static bool is_insn_array(const struct bpf_map *map)
>>>    	return map->map_type == BPF_MAP_TYPE_INSN_ARRAY;
>>>    }
>>> +static bool is_jump_table(const struct bpf_map *map)
>>> +{
>>> +	struct bpf_insn_array *insn_array;
>>> +
>>> +	if (!is_insn_array(map))
>>> +		return false;
>>> +
>>> +	insn_array = cast_insn_array(map);
>>> +	return insn_array->type == BPF_INSN_ARRAY_JUMP_TABLE;
>>> +}
>>> +
>>>    static inline bool valid_offsets(const struct bpf_insn_array *insn_array,
>>>    				 const struct bpf_prog *prog)
>>>    {
>>> @@ -302,3 +314,54 @@ void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
>>>    		}
>>>    	}
>>>    }
>>> +
>>> +bool bpf_prog_has_jump_table(const struct bpf_prog *prog)
>>> +{
>>> +	int i;
>>> +
>>> +	for (i = 0; i < prog->aux->used_map_cnt; i++) {
>>> +		if (is_jump_table(prog->aux->used_maps[i]))
>>> +			return true;
>>> +	}
>>> +	return false;
>>> +}
>>> +
>>> +/*
>>> + * This function collects possible indirect jump targets in a BPF program. Since indirect jump
>>> + * targets can only be read from indirect arrays used as jump table, it traverses all jump
>>> + * tables used by @prog. For each instruction found in the jump tables, it sets the corresponding
>>> + * bit in @bitmap.
>>> + */
>>> +void bpf_prog_collect_indirect_targets(const struct bpf_prog *prog, unsigned long *bitmap)
>>> +{
>>> +	struct bpf_insn_array *insn_array;
>>> +	struct bpf_map *map;
>>> +	u32 xlated_off;
>>> +	int i, j;
>>> +
>>> +	for (i = 0; i < prog->aux->used_map_cnt; i++) {
>>> +		map = prog->aux->used_maps[i];
>>> +		if (!is_jump_table(map))
>>> +			continue;
>>> +
>>> +		insn_array = cast_insn_array(map);
>>> +		for (j = 0; j < map->max_entries; j++) {
>>> +			xlated_off = insn_array->values[j].xlated_off;
>>> +			if (xlated_off == INSN_DELETED)
>>> +				continue;
>>> +			if (xlated_off < prog->aux->subprog_start)
>>> +				continue;
>>> +			xlated_off -= prog->aux->subprog_start;
>>> +			if (xlated_off >= prog->len)
>>> +				continue;
>> The above codes are duplicated with bpf_prog_update_insn_ptrs().
>> Maybe we can have a helper for the above?
>>
>>> +			__set_bit(xlated_off, bitmap);
>>> +		}
>>> +	}
>>> +}
>>> +
>>> +void bpf_prog_set_insn_array_type(struct bpf_map *map, int type)
>>> +{
>>> +	struct bpf_insn_array *insn_array = cast_insn_array(map);
>>> +
>>> +	insn_array->type = type;
>>> +}
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index d6b8a77fbe3b..ee6f4ddfbb79 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -20288,6 +20288,12 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
>>>    		return -EINVAL;
>>>    	}
>>> +	/*
>>> +	 * Explicitly mark this map as a jump table such that it can be
>>> +	 * distinguished later from other instruction arrays
>>> +	 */
>>> +	bpf_prog_set_insn_array_type(map, BPF_INSN_ARRAY_JUMP_TABLE);
>> I think we do not need this for now. If a new indirect_jump type is introduced,
>> verifier/jit can be adjusted that time if necessary.
> See the v1 thread. In brief, a user can already create an instruction array
> which is not used as a jump table, say, pointing to every instruction (see
> selftests for insn array). And if not distinguished from a jump table, this
> will force arm jit into emitting BTI for every instruction listed inside it.

I missed this. Thanks for explanation!

>
>>> +
>>>    	for (i = 0; i < n - 1; i++) {
>>>    		other_branch = push_stack(env, env->gotox_tmp_buf->items[i],
>>>    					  env->insn_idx, env->cur_state->speculative);


