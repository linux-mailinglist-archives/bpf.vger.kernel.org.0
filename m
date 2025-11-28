Return-Path: <bpf+bounces-75683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8C0C91037
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 08:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDDD14E2888
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 07:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4E52C2376;
	Fri, 28 Nov 2025 07:16:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AC522759C
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764314181; cv=none; b=KfDYXTiLpCPkb0n+Kl2K/1yc984wYC2StXIdvBvSEHaOZaPnoL8ukhcvcZBBxcrB6pjD2pAeeP5LJoSLaK09ukVLHpynrrFceLxQxePp+3ccTUT3hhd2L1HV4SV6SnrCaLe8gQALxIaq1PI83Li0EvvU2AO0DcLB3muuesolvpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764314181; c=relaxed/simple;
	bh=7giw6CKZKKBmdfMgYV51hu4SF/vWs3jsvLlmh+gimRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I8C/n09Yuulj2/BfMsd9Hk4KVcXFJVywVIlczaEOISrMHWZV+t8k+sznFSJ4/1j9xT3tjCnk7ixD1RdAmcGPAkuP1M/3xRPKB0gVpNVuEwPaMIWUNOWR4R6QVtFFijZ/Pcd3vAubZ8v5LaN2fXOwL36HsmO9UvI0MIXQrq5e0Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dHl1h53tJzYQtpg
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 15:15:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 910661A084D
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 15:16:15 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgCnBHs6TClpKrAlCQ--.35552S2;
	Fri, 28 Nov 2025 15:16:11 +0800 (CST)
Message-ID: <7ba9e3d0-d9ba-41f5-b8e8-4846ea7ae003@huaweicloud.com>
Date: Fri, 28 Nov 2025 15:16:10 +0800
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
 <aSh4QCd27MUHMVdp@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <aSh4QCd27MUHMVdp@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCnBHs6TClpKrAlCQ--.35552S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GrW3GF4fZF1kKrW5ZFy7Wrg_yoW3KrWxpF
	WDJw1akFW8XrW8GFnrXa18Ary3trs5Gr1YkrWft3yIk3Z0vr93KFW5KFsIkFnxCryUCF1x
	ZF4j9r1fu3yUA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 11/28/2025 12:11 AM, Anton Protopopov wrote:
> On 25/11/27 10:03PM, Xu Kuohai wrote:
>> From: Xu Kuohai <xukuohai@huawei.com>
> 
> This patch doesn't apply to bpf-next due to
> https://lore.kernel.org/bpf/20251125145857.98134-2-leon.hwang@linux.dev/T/#u
>

Oops, thanks for the notice. I'll rebase on the latest bpf-next.

>> When BTI is enabled, the indirect jump selftest triggers BTI exception:
>>
>> Internal error: Oops - BTI: 0000000036000003 [#1]  SMP
>> ...
>> Call trace:
>>   bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x54/0xf8 (P)
>>   bpf_prog_run_pin_on_cpu+0x140/0x468
>>   bpf_prog_test_run_syscall+0x280/0x3b8
>>   bpf_prog_test_run+0x22c/0x2c0
>>   __sys_bpf+0x4d8/0x5c8
>>   __arm64_sys_bpf+0x88/0xa8
>>   invoke_syscall+0x80/0x220
>>   el0_svc_common+0x160/0x1d0
>>   do_el0_svc+0x54/0x70
>>   el0_svc+0x54/0x188
>>   el0t_64_sync_handler+0x84/0x130
>>   el0t_64_sync+0x198/0x1a0
>>
>> This happens because no BTI instruction is generated by the JIT for
>> indirect jump targets.
>>
>> Fix it by emitting BTI instruction for every possible indirect jump
>> targets when BTI is enabled. The targets are identified by traversing
>> all instruction arrays used by the BPF program, since indirect jump
>> targets can only be read from instruction arrays.
>>
>> Fixes: f4a66cf1cb14 ("bpf: arm64: Add support for indirect jumps")
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> ---
>>   arch/arm64/net/bpf_jit_comp.c | 20 ++++++++++++++++
>>   include/linux/bpf.h           | 12 ++++++++++
>>   kernel/bpf/bpf_insn_array.c   | 43 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 75 insertions(+)
>>
>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>> index 929123a5431a..f546df886049 100644
>> --- a/arch/arm64/net/bpf_jit_comp.c
>> +++ b/arch/arm64/net/bpf_jit_comp.c
>> @@ -78,6 +78,7 @@ static const int bpf2a64[] = {
>>   
>>   struct jit_ctx {
>>   	const struct bpf_prog *prog;
>> +	unsigned long *indirect_targets;
>>   	int idx;
>>   	int epilogue_offset;
>>   	int *offset;
>> @@ -1199,6 +1200,11 @@ static int add_exception_handler(const struct bpf_insn *insn,
>>   	return 0;
>>   }
>>   
>> +static bool maybe_indirect_target(int insn_off, unsigned long *targets_bitmap)
> 
> Why "maybe"? (But also see below.)
>

IIUC, although indirect jump targets are loaded from instruction arrays,
not all instructions pointed to by an instruction array are actually used
as indirect jump targets. It is legal for indirect jumps to target only
some of the instructions.

>> +{
>> +	return targets_bitmap && test_bit(insn_off, targets_bitmap);
>> +}
>> +
>>   /* JITs an eBPF instruction.
>>    * Returns:
>>    * 0  - successfully JITed an 8-byte eBPF instruction.
>> @@ -1231,6 +1237,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>>   	int ret;
>>   	bool sign_extend;
>>   
>> +	if (maybe_indirect_target(i, ctx->indirect_targets))
>> +		emit_bti(A64_BTI_J, ctx);
>> +
>>   	switch (code) {
>>   	/* dst = src */
>>   	case BPF_ALU | BPF_MOV | BPF_X:
>> @@ -2085,6 +2094,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>   	memset(&ctx, 0, sizeof(ctx));
>>   	ctx.prog = prog;
>>   
>> +	if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL) && bpf_prog_has_insn_array(prog)) {
>> +		ctx.indirect_targets = kvcalloc(BITS_TO_LONGS(prog->len), sizeof(unsigned long),
>> +						GFP_KERNEL);
> 
> It's allocated here on every run, but freed below only when
> !prog->is_func || extra_pass.
>

Well, actually, the bitmap is allocated in the first pass of the JIT
and freed in the last pass. For passes other than the first, this code
is skipped via the statement goto skip_init_ctx, which is unaffected
by this patch.

Indeed, there are quite a few gotos in bpf_int_jit_compile, which makes
the code somewhat hard to follow. It seems like it’s time for some
cleanup, and I’ll try to work on that.

>> +		if (ctx.indirect_targets == NULL) {
>> +			prog = orig_prog;
>> +			goto out_off;
>> +		}
>> +		bpf_prog_collect_indirect_targets(prog, ctx.indirect_targets);
>> +	}
>> +
>>   	ctx.offset = kvcalloc(prog->len + 1, sizeof(int), GFP_KERNEL);
>>   	if (ctx.offset == NULL) {
>>   		prog = orig_prog;
>> @@ -2248,6 +2267,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>   			prog->aux->priv_stack_ptr = NULL;
>>   		}
>>   		kvfree(ctx.offset);
>> +		kvfree(ctx.indirect_targets);
>>   out_priv_stack:
>>   		kfree(jit_data);
>>   		prog->aux->jit_data = NULL;
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index a9b788c7b4aa..c81eb54f7b26 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -3822,11 +3822,23 @@ void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
>>   
>>   #ifdef CONFIG_BPF_SYSCALL
>>   void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image);
>> +void bpf_prog_collect_indirect_targets(const struct bpf_prog *prog, unsigned long *bitmap);
>> +bool bpf_prog_has_insn_array(const struct bpf_prog *prog);
>>   #else
>>   static inline void
>>   bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
>>   {
>>   }
>> +
>> +static inline bool bpf_prog_has_insn_array(const struct bpf_prog *prog)
>> +{
>> +	return false;
>> +}
>> +
>> +static inline void
>> +bpf_prog_collect_indirect_targets(const struct bpf_prog *prog, unsigned long *bitmap)
>> +{
>> +}
>>   #endif
>>   
>>   #endif /* _LINUX_BPF_H */
>> diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
>> index 61ce52882632..ed20b186a1f5 100644
>> --- a/kernel/bpf/bpf_insn_array.c
>> +++ b/kernel/bpf/bpf_insn_array.c
>> @@ -299,3 +299,46 @@ void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
>>   		}
>>   	}
>>   }
>> +
>> +bool bpf_prog_has_insn_array(const struct bpf_prog *prog)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < prog->aux->used_map_cnt; i++) {
>> +		if (is_insn_array(prog->aux->used_maps[i]))
>> +			return true;
>> +	}
>> +	return false;
>> +}
> 
> I think a different check is needed here (and a different function
> name, smth like "bpf_prog_has_indirect_jumps"),and a different
> algorithm to collect jump targets in the chunk below. A program can
> have instruction arrays not related to indirect jumps (see, e.g.,
> bpf_insn_array selftests + in future insns arrays will be used to
> also support other functionality). As an extreme case, an insn array
> can point to every instruction in a prog, thus a BTI will be
> generated for every instruction.
> 
> In verifier it is used a bit differently, namely, all insn arrays for
> a given subprog are collected when an indirect jump is encountered
> (and non-deterministic only in check_cfg). Later in verification, an
> exact map is used, so this is not a problem.
>

ACK, we should leverage the information derived by the verifier to exclude
instruction arrays that are not used for indirect jumps.

> Initially I wanted to have a map flag (in map_extra) to distingiush between
> different types of instruction arrays ("plane ones", "jump targets",
> "call targets", "static keys"), but Andrii wasn't happy with it,
> so eventually I've dropped it. Maybe it is worth adding it until
> the code is merged to upstream? Eduard, Alexei, wdyt?
> 
>> +
>> +/*
>> + * This function collects possible indirect jump targets in a BPF program. Since indirect jump
>> + * targets can only be read from instruction arrays, it traverses all instruction arrays used
>> + * by @prog. For each instruction in the arrays, it sets the corresponding bit in @bitmap.
>> + */
>> +void bpf_prog_collect_indirect_targets(const struct bpf_prog *prog, unsigned long *bitmap)
>> +{
>> +	struct bpf_insn_array *insn_array;
>> +	struct bpf_map *map;
>> +	u32 xlated_off;
>> +	int i, j;
>> +
>> +	for (i = 0; i < prog->aux->used_map_cnt; i++) {
>> +		map = prog->aux->used_maps[i];
>> +		if (!is_insn_array(map))
>> +			continue;
>> +
>> +		insn_array = cast_insn_array(map);
>> +		for (j = 0; j < map->max_entries; j++) {
>> +			xlated_off = insn_array->values[j].xlated_off;
>> +			if (xlated_off == INSN_DELETED)
>> +				continue;
>> +			if (xlated_off < prog->aux->subprog_start)
>> +				continue;
>> +			xlated_off -= prog->aux->subprog_start;
>> +			if (xlated_off >= prog->len)
>> +				continue;
>> +			__set_bit(xlated_off, bitmap);
>> +		}
>> +	}
>> +}
>> -- 
>> 2.47.3
>>


