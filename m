Return-Path: <bpf+bounces-65196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F0CB1D8E5
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 15:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F12418C5BE4
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 13:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7DC255F3F;
	Thu,  7 Aug 2025 13:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOUX3uqd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB45A136E
	for <bpf@vger.kernel.org>; Thu,  7 Aug 2025 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754572967; cv=none; b=sZzgFvOMwDqS8qP4gZUr5UplhYnsl+JmiWP1exR4pH4Cb947rm5mF1MoP6Wxlbc8XwlcXgQu0KZWBx3uGwvQZGzeuqVfgrAf0neMcn9MSwsogED3jjpC5lE6pXFnihKSilp+my72p2hnFw5W0viOuk0H4YGAW8GlhcT9LOLl5Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754572967; c=relaxed/simple;
	bh=cyOs0V2AMpn6HW4EPfw3AuKhhAL1ywkVjoYHdfDYUM8=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rQgBGzclF0fm5sWWOhMHMGnk/N3BScogak6Lobebdm1gJCOIa93ZS6z955POrufpGR4ESn2oH3MCdWR9DbtHdG/C44G9oNA+oh0V6tNvxF//T3Avw3KUZUSEsfHV8euRs6QbA0IZS+43ZgZ/36wHPueWV874fZ1itWVKRp5Ttt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOUX3uqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21FFC4CEEB;
	Thu,  7 Aug 2025 13:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754572967;
	bh=cyOs0V2AMpn6HW4EPfw3AuKhhAL1ywkVjoYHdfDYUM8=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=TOUX3uqd7T6WRO4bSGnLNTDg944qI3RSZTxezElSuefwnmOJJ8F+s92FufYeIq2aH
	 uermrDB8q7k2hlMY5MHRI+/ccx1bIfmli3u9t4LGWMKtToEAM1dFQb8mKD4Wsajh7t
	 e0yGPQC5A0s/huWj4l+hF7RDY7xc0MCpkSEXAjS4IOPVx2wT+hTj/Cobg9MqWqn/As
	 YOkRhwxFz+cnGZCp9CL6X+XBqp6mIASFObK9hfgD6i+ir9m3TbR5++F1TClk/QJ2K/
	 UH/lRWFzLewux9uO6kspfkDmAfvIklZx2+qeiSRNcOlSf0qPL0OyYGoqxIYsXAShiy
	 jBPYpV0Bqt4xg==
From: <puranjay@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/3] bpf: Report arena faults to BPF stderr
In-Reply-To: <b34dea3f-33b0-429d-9a64-c6305e2df397@linux.dev>
References: <20250806085847.18633-1-puranjay@kernel.org>
 <20250806085847.18633-3-puranjay@kernel.org>
 <b34dea3f-33b0-429d-9a64-c6305e2df397@linux.dev>
Date: Thu, 07 Aug 2025 13:22:43 +0000
Message-ID: <mb61pjz3fgtb0.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yonghong Song <yonghong.song@linux.dev> writes:

> On 8/6/25 1:58 AM, Puranjay Mohan wrote:
>> Begin reporting arena page faults and the faulting address to BPF
>> program's stderr, this patch adds support in the arm64 and x86-64 JITs,
>> support for other archs can be added later.
>>
>> The fault handlers receive the 32 bit address in the arena region so
>> the upper 32 bits of user_vm_start is added to it before printing the
>> address. This is what the user would expect to see as this is what is
>> printed by bpf_printk() is you pass it an address returned by
>> bpf_arena_alloc_pages();
>>
>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>
> LGTM with some nits below.
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>
>> ---
>>   arch/arm64/net/bpf_jit_comp.c | 31 ++++++++++++++
>>   arch/x86/net/bpf_jit_comp.c   | 80 +++++++++++++++++++++++++++++++++--
>>   include/linux/bpf.h           |  1 +
>>   kernel/bpf/arena.c            | 20 +++++++++
>>   4 files changed, 128 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>> index 42643fd9168fc..5680c7cd8932f 100644
>> --- a/arch/arm64/net/bpf_jit_comp.c
>> +++ b/arch/arm64/net/bpf_jit_comp.c
>> @@ -1066,6 +1066,9 @@ static void build_epilogue(struct jit_ctx *ctx, bool was_classic)
>>   	emit(A64_RET(A64_LR), ctx);
>>   }
>>   
>> +#define BPF_FIXUP_LOAD_OFFSET_MASK GENMASK(15, 0)
>> +#define BPF_FIXUP_ARENA_REG_MASK   GENMASK(20, 16)
>> +#define BPF_ARENA_ACCESS	   BIT(21)
>>   #define BPF_FIXUP_REG_MASK	GENMASK(31, 27)
>>   #define DONT_CLEAR 5 /* Unused ARM64 register from BPF's POV */
>>   
>> @@ -1073,11 +1076,22 @@ bool ex_handler_bpf(const struct exception_table_entry *ex,
>>   		    struct pt_regs *regs)
>>   {
>>   	int dst_reg = FIELD_GET(BPF_FIXUP_REG_MASK, ex->fixup);
>> +	s16 off = FIELD_GET(BPF_FIXUP_LOAD_OFFSET_MASK, ex->fixup);
>> +	int arena_reg = FIELD_GET(BPF_FIXUP_ARENA_REG_MASK, ex->fixup);
>> +	bool is_arena = !!(ex->fixup & BPF_ARENA_ACCESS);
>> +	bool is_write = (dst_reg == DONT_CLEAR);
>> +	unsigned long addr;
>>   
>>   	if (dst_reg != DONT_CLEAR)
>>   		regs->regs[dst_reg] = 0;
>>   	/* Skip the faulting instruction */
>>   	regs->pc += AARCH64_INSN_SIZE;
>> +
>> +	if (is_arena) {
>> +		addr = regs->regs[arena_reg] + off;
>> +		bpf_prog_report_arena_violation(is_write, addr);
>> +	}
>> +
>>   	return true;
>>   }
>>   
>> @@ -1087,6 +1101,9 @@ static int add_exception_handler(const struct bpf_insn *insn,
>>   				 int dst_reg)
>>   {
>>   	off_t ins_offset;
>> +	s16 load_off = insn->off;
>
> Change 'load_off' to 'off' so it matches the usage in ex_handler_bpf().
> Also 'off' could mean the off for a store insn, right?

Yes, this is for both load and store, I will fix it in next version.

>> +	bool is_arena;
>> +	int arena_reg;
>>   	unsigned long pc;
>>   	struct exception_table_entry *ex;
>>   
>> @@ -1100,6 +1117,9 @@ static int add_exception_handler(const struct bpf_insn *insn,
>>   				BPF_MODE(insn->code) != BPF_PROBE_ATOMIC)
>>   		return 0;
>>   
>> +	is_arena = (BPF_MODE(insn->code) == BPF_PROBE_MEM32) ||
>> +		   (BPF_MODE(insn->code) == BPF_PROBE_ATOMIC);
>> +
>>   	if (!ctx->prog->aux->extable ||
>>   	    WARN_ON_ONCE(ctx->exentry_idx >= ctx->prog->aux->num_exentries))
>>   		return -EINVAL;
>> @@ -1131,6 +1151,17 @@ static int add_exception_handler(const struct bpf_insn *insn,
>>   
>>   	ex->fixup = FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
>>   
>> +	if (is_arena) {
>> +		ex->fixup |= BPF_ARENA_ACCESS;
>> +		if (BPF_CLASS(insn->code) == BPF_LDX)
>> +			arena_reg = bpf2a64[insn->src_reg];
>> +		else
>> +			arena_reg = bpf2a64[insn->dst_reg];
>> +
>> +		ex->fixup |=  FIELD_PREP(BPF_FIXUP_LOAD_OFFSET_MASK, load_off) |
>> +			      FIELD_PREP(BPF_FIXUP_ARENA_REG_MASK, arena_reg);
>> +	}
>> +
>>   	ex->type = EX_TYPE_BPF;
>>   
>>   	ctx->exentry_idx++;
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 7e3fca1646203..c8d99375e6de7 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -8,6 +8,7 @@
>>   #include <linux/netdevice.h>
>>   #include <linux/filter.h>
>>   #include <linux/if_vlan.h>
>> +#include <linux/bitfield.h>
>>   #include <linux/bpf.h>
>>   #include <linux/memory.h>
>>   #include <linux/sort.h>
>> @@ -1388,16 +1389,67 @@ static int emit_atomic_ld_st_index(u8 **pprog, u32 atomic_op, u32 size,
>>   	return 0;
>>   }
>>   
>> +/*
>> + * Metadata encoding for exception handling in JITed code.
>> + *
>> + * Format of `fixup` and `data` fields in `struct exception_table_entry`:
>> + *
>> + * Bit layout of `fixup` (32-bit):
>> + *
>> + * +-----------+--------+-----------+---------+----------+
>> + * | 31        | 30-24  |   23-16   |   15-8  |    7-0   |
>> + * |           |        |           |         |          |
>> + * | ARENA_ACC | Unused | ARENA_REG | DST_REG | INSN_LEN |
>> + * +-----------+--------+-----------+---------+----------+
>> + *
>> + * - INSN_LEN (8 bits): Length of faulting insn (max x86 insn = 15 bytes (fits in 8 bits)).
>> + * - DST_REG  (8 bits): Offset of dst_reg from reg2pt_regs[] (max offset = 112 (fits in 8 bits)).
>> + *                      This is set to DONT_CLEAR if the insn is a store.
>> + * - ARENA_REG (8 bits): Offset of the register that is used to calculate the
>> + *                       address for load/store when accessing the arena region.
>> + * - ARENA_ACCESS (1 bit): This bit is set when the faulting instruction accessed the arena region.
>> + *
>> + * Bit layout of `data` (32-bit):
>> + *
>> + * +--------------+--------+--------------+
>> + * |	31-16	  |  15-8  |     7-0      |
>> + * |              |	   |              |
>> + * | ARENA_OFFSET | Unused |  EX_TYPE_BPF |
>> + * +--------------+--------+--------------+
>> + *
>> + * - ARENA_OFFSET (16 bits): Offset used to calculate the address for load/store when
>> + *                           accessing the arena region.
>> + */
>> +
>>   #define DONT_CLEAR 1
>> +#define FIXUP_OFFSET_MASK	GENMASK(7, 0)
>
> Maybe FIXUP_INSN_LEN_MASK?

Will change in next version.

>> +#define FIXUP_REG_MASK		GENMASK(15, 8)
>> +#define FIXUP_ARENA_REG_MASK	GENMASK(23, 16)
>> +#define FIXUP_ARENA_ACCESS	BIT(31)
>> +#define DATA_ARENA_OFFSET_MASK	GENMASK(31, 16)
>>   
>>   bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
>>   {
>> -	u32 reg = x->fixup >> 8;
>> +	u32 reg = FIELD_GET(FIXUP_REG_MASK, x->fixup);
>> +	off_t offset = FIELD_GET(FIXUP_OFFSET_MASK, x->fixup);
>
> insn_len = ...
>
>> +	bool is_arena = !!(x->fixup & FIXUP_ARENA_ACCESS);
>> +	bool is_write = (reg == DONT_CLEAR);
>> +	unsigned long addr;
>> +	s16 arena_offset;
>
> This should be just 'off', right? It would be good if the terminology is consistent
> between different architectures.

Yes,

>
>> +	u32 arena_reg;
>>   
>>   	/* jump over faulting load and clear dest register */
>>   	if (reg != DONT_CLEAR)
>>   		*(unsigned long *)((void *)regs + reg) = 0;
>> -	regs->ip += x->fixup & 0xff;
>> +	regs->ip += offset;
>> +
>> +	if (is_arena) {
>> +		arena_reg = FIELD_GET(FIXUP_ARENA_REG_MASK, x->data);
>> +		arena_offset = FIELD_GET(DATA_ARENA_OFFSET_MASK, x->data);
>> +		addr = *(unsigned long *)((void *)regs + arena_reg) + arena_offset;
>> +		bpf_prog_report_arena_violation(is_write, addr);
>> +	}
>> +
>>   	return true;
>>   }
>>   
>> @@ -2070,6 +2122,9 @@ st:			if (is_imm8(insn->off))
>>   			{
>>   				struct exception_table_entry *ex;
>>   				u8 *_insn = image + proglen + (start_of_ldx - temp);
>> +				bool is_arena;
>> +				u32 fixup_reg;
>> +				u32 arena_reg;
>
> the above two variables can be in the same line and can before 'is_arena'.
>

Will change in next version.

Thanks,
Puranjay

