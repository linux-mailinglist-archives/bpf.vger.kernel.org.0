Return-Path: <bpf+bounces-66971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499B2B3B8BB
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 12:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6173BE53C
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 10:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1386C308F1B;
	Fri, 29 Aug 2025 10:30:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086B01DE8B3
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756463430; cv=none; b=qgoUsoxy8l2qEyM4Q01TrMLUqCGFRQZ3ncyb/oZ1ZObhKOXYzVoN6hiolZC+dmf8MYbfD3mxPLFGFweyFGr1gG2KlDOw5ywiVOFANmm7oiYKSx2CLA+PkMmzpqQbwF3zg0ouVRWDOZRPxtBzUNZzcDlnAYQpxKKKLRoFGx7rZg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756463430; c=relaxed/simple;
	bh=M0CYIANZ9QxzcqfRlPUF6f0UDYWM92Fa6BpJDt10YYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mcdxTv8vWbsace0Q4dlx8R7yt+uxs7WvoXHZc8B9IfdtswvfAhc4s5X0uVeaW44FUe+fP5hZc1jhm1aEqj0eLSXzhWcgDFt5EaE7UOhChdcE7/bKbZcwnmYMYFG8piRkbxjzITV1PJ+sRR+1U+ixxrZeec2UiEAKtelmGIL645M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cCvfn6PSfzYQvp9
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 18:30:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6B4B61A01A0
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 18:30:24 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgCn74s_gbFojvXAAg--.17221S2;
	Fri, 29 Aug 2025 18:30:24 +0800 (CST)
Message-ID: <99bb1aa8-885b-4819-beb3-723a73960f67@huaweicloud.com>
Date: Fri, 29 Aug 2025 18:30:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/3] bpf: Report arena faults to BPF stderr
Content-Language: en-US
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 bpf@vger.kernel.org
References: <20250827153728.28115-1-puranjay@kernel.org>
 <20250827153728.28115-3-puranjay@kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20250827153728.28115-3-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCn74s_gbFojvXAAg--.17221S2
X-Coremail-Antispam: 1UD129KBjvJXoWfJryfZF45XF4UGF1DuF1rZwb_yoWDur1UpF
	yfCF13JrWqqw47ur47WF4UAF1Ygr4fWw18CF43K34fJw12vr1rWa18Ka4rXr98ArW8WF1U
	Za40krZF9rnxZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 8/27/2025 11:37 PM, Puranjay Mohan wrote:
> Begin reporting arena page faults and the faulting address to BPF
> program's stderr, this patch adds support in the arm64 and x86-64 JITs,
> support for other archs can be added later.
> 
> The fault handlers receive the 32 bit address in the arena region so
> the upper 32 bits of user_vm_start is added to it before printing the
> address. This is what the user would expect to see as this is what is
> printed by bpf_printk() is you pass it an address returned by
> bpf_arena_alloc_pages();
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>   arch/arm64/net/bpf_jit_comp.c | 52 +++++++++++++++++++++++
>   arch/x86/net/bpf_jit_comp.c   | 79 +++++++++++++++++++++++++++++++++--
>   include/linux/bpf.h           |  5 +++
>   kernel/bpf/arena.c            | 20 +++++++++
>   4 files changed, 152 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 42643fd9168fc..5083886d6e66b 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1066,6 +1066,30 @@ static void build_epilogue(struct jit_ctx *ctx, bool was_classic)
>   	emit(A64_RET(A64_LR), ctx);
>   }
>   
> +/*
> + * Metadata encoding for exception handling in JITed code.
> + *
> + * Format of `fixup` field in `struct exception_table_entry`:
> + *
> + * Bit layout of `fixup` (32-bit):
> + *
> + * +-----------+--------+-----------+-----------+----------+
> + * |   31-27   | 26-22  |     21    |   20-16   |   15-0   |
> + * |           |        |           |           |          |
> + * | FIXUP_REG | Unused | ARENA_ACC | ARENA_REG |  OFFSET  |
> + * +-----------+--------+-----------+-----------+----------+
> + *
> + * - OFFSET (16 bits): Offset used to compute address for Load/Store instruction.
> + * - ARENA_REG (5 bits): Register that is used to calculate the address for load/store when
> + *                       accessing the arena region.
> + * - ARENA_ACCESS (1 bit): This bit is set when the faulting instruction accessed the arena region.
> + * - FIXUP_REG (5 bits): Destination register for the load instruction (cleared on fault) or set to
> + *                       DONT_CLEAR if it is a store instruction.
> + */
> +
> +#define BPF_FIXUP_OFFSET_MASK      GENMASK(15, 0)
> +#define BPF_FIXUP_ARENA_REG_MASK   GENMASK(20, 16)
> +#define BPF_ARENA_ACCESS           BIT(21)
>   #define BPF_FIXUP_REG_MASK	GENMASK(31, 27)
>   #define DONT_CLEAR 5 /* Unused ARM64 register from BPF's POV */
>   
> @@ -1073,11 +1097,22 @@ bool ex_handler_bpf(const struct exception_table_entry *ex,
>   		    struct pt_regs *regs)
>   {
>   	int dst_reg = FIELD_GET(BPF_FIXUP_REG_MASK, ex->fixup);
> +	s16 off = FIELD_GET(BPF_FIXUP_OFFSET_MASK, ex->fixup);
> +	int arena_reg = FIELD_GET(BPF_FIXUP_ARENA_REG_MASK, ex->fixup);
> +	bool is_arena = !!(ex->fixup & BPF_ARENA_ACCESS);
> +	bool is_write = (dst_reg == DONT_CLEAR);
> +	unsigned long addr;
>   
>   	if (dst_reg != DONT_CLEAR)
>   		regs->regs[dst_reg] = 0;
>   	/* Skip the faulting instruction */
>   	regs->pc += AARCH64_INSN_SIZE;
> +
> +	if (is_arena) {
> +		addr = regs->regs[arena_reg] + off;
> +		bpf_prog_report_arena_violation(is_write, addr);
> +	}
> +
>   	return true;
>   }
>   
> @@ -1087,6 +1122,9 @@ static int add_exception_handler(const struct bpf_insn *insn,
>   				 int dst_reg)
>   {
>   	off_t ins_offset;
> +	s16 off = insn->off;
> +	bool is_arena;
> +	int arena_reg;
>   	unsigned long pc;
>   	struct exception_table_entry *ex;
>   
> @@ -1100,6 +1138,9 @@ static int add_exception_handler(const struct bpf_insn *insn,
>   				BPF_MODE(insn->code) != BPF_PROBE_ATOMIC)
>   		return 0;
>   
> +	is_arena = (BPF_MODE(insn->code) == BPF_PROBE_MEM32) ||
> +		   (BPF_MODE(insn->code) == BPF_PROBE_ATOMIC);
> +
>   	if (!ctx->prog->aux->extable ||
>   	    WARN_ON_ONCE(ctx->exentry_idx >= ctx->prog->aux->num_exentries))
>   		return -EINVAL;
> @@ -1131,6 +1172,17 @@ static int add_exception_handler(const struct bpf_insn *insn,
>   
>   	ex->fixup = FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
>   
> +	if (is_arena) {
> +		ex->fixup |= BPF_ARENA_ACCESS;
> +		if (BPF_CLASS(insn->code) == BPF_LDX)
> +			arena_reg = bpf2a64[insn->src_reg];
> +		else
> +			arena_reg = bpf2a64[insn->dst_reg];
> +
> +		ex->fixup |=  FIELD_PREP(BPF_FIXUP_OFFSET_MASK, off) |
> +			      FIELD_PREP(BPF_FIXUP_ARENA_REG_MASK, arena_reg);
> +	}
> +
>   	ex->type = EX_TYPE_BPF;
>   
>   	ctx->exentry_idx++;
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 7e3fca1646203..b75dea55df5a2 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -8,6 +8,7 @@
>   #include <linux/netdevice.h>
>   #include <linux/filter.h>
>   #include <linux/if_vlan.h>
> +#include <linux/bitfield.h>
>   #include <linux/bpf.h>
>   #include <linux/memory.h>
>   #include <linux/sort.h>
> @@ -1388,16 +1389,67 @@ static int emit_atomic_ld_st_index(u8 **pprog, u32 atomic_op, u32 size,
>   	return 0;
>   }
>   
> +/*
> + * Metadata encoding for exception handling in JITed code.
> + *
> + * Format of `fixup` and `data` fields in `struct exception_table_entry`:
> + *
> + * Bit layout of `fixup` (32-bit):
> + *
> + * +-----------+--------+-----------+---------+----------+
> + * | 31        | 30-24  |   23-16   |   15-8  |    7-0   |
> + * |           |        |           |         |          |
> + * | ARENA_ACC | Unused | ARENA_REG | DST_REG | INSN_LEN |
> + * +-----------+--------+-----------+---------+----------+
> + *
> + * - INSN_LEN (8 bits): Length of faulting insn (max x86 insn = 15 bytes (fits in 8 bits)).
> + * - DST_REG  (8 bits): Offset of dst_reg from reg2pt_regs[] (max offset = 112 (fits in 8 bits)).
> + *                      This is set to DONT_CLEAR if the insn is a store.
> + * - ARENA_REG (8 bits): Offset of the register that is used to calculate the
> + *                       address for load/store when accessing the arena region.
> + * - ARENA_ACCESS (1 bit): This bit is set when the faulting instruction accessed the arena region.
> + *
> + * Bit layout of `data` (32-bit):
> + *
> + * +--------------+--------+--------------+
> + * |	31-16	  |  15-8  |     7-0      |
> + * |              |	   |              |
> + * | ARENA_OFFSET | Unused |  EX_TYPE_BPF |
> + * +--------------+--------+--------------+
> + *
> + * - ARENA_OFFSET (16 bits): Offset used to calculate the address for load/store when
> + *                           accessing the arena region.
> + */
> +
>   #define DONT_CLEAR 1
> +#define FIXUP_INSN_LEN_MASK	GENMASK(7, 0)
> +#define FIXUP_REG_MASK		GENMASK(15, 8)
> +#define FIXUP_ARENA_REG_MASK	GENMASK(23, 16)
> +#define FIXUP_ARENA_ACCESS	BIT(31)
> +#define DATA_ARENA_OFFSET_MASK	GENMASK(31, 16)
>   
>   bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
>   {
> -	u32 reg = x->fixup >> 8;
> +	u32 reg = FIELD_GET(FIXUP_REG_MASK, x->fixup);
> +	u32 insn_len = FIELD_GET(FIXUP_INSN_LEN_MASK, x->fixup);
> +	bool is_arena = !!(x->fixup & FIXUP_ARENA_ACCESS);
> +	bool is_write = (reg == DONT_CLEAR);
> +	unsigned long addr;
> +	s16 off;
> +	u32 arena_reg;
>   
>   	/* jump over faulting load and clear dest register */
>   	if (reg != DONT_CLEAR)
>   		*(unsigned long *)((void *)regs + reg) = 0;
> -	regs->ip += x->fixup & 0xff;
> +	regs->ip += insn_len;
> +
> +	if (is_arena) {
> +		arena_reg = FIELD_GET(FIXUP_ARENA_REG_MASK, x->fixup);
> +		off = FIELD_GET(DATA_ARENA_OFFSET_MASK, x->data);
> +		addr = *(unsigned long *)((void *)regs + arena_reg) + off;
> +		bpf_prog_report_arena_violation(is_write, addr);
> +	}
> +
>   	return true;
>   }
>   
> @@ -2070,6 +2122,8 @@ st:			if (is_imm8(insn->off))
>   			{
>   				struct exception_table_entry *ex;
>   				u8 *_insn = image + proglen + (start_of_ldx - temp);
> +				u32 arena_reg, fixup_reg;
> +				bool is_arena;
>   				s64 delta;
>   
>   				if (!bpf_prog->aux->extable)
> @@ -2089,8 +2143,25 @@ st:			if (is_imm8(insn->off))
>   
>   				ex->data = EX_TYPE_BPF;
>   
> -				ex->fixup = (prog - start_of_ldx) |
> -					((BPF_CLASS(insn->code) == BPF_LDX ? reg2pt_regs[dst_reg] : DONT_CLEAR) << 8);
> +				is_arena = (BPF_MODE(insn->code) == BPF_PROBE_MEM32) ||
> +					   (BPF_MODE(insn->code) == BPF_PROBE_ATOMIC);
> +
> +				fixup_reg = (BPF_CLASS(insn->code) == BPF_LDX) ?
> +					    reg2pt_regs[dst_reg] : DONT_CLEAR;
> +
> +				ex->fixup = FIELD_PREP(FIXUP_INSN_LEN_MASK, prog - start_of_ldx) |
> +					    FIELD_PREP(FIXUP_REG_MASK, fixup_reg);
> +
> +				if (is_arena) {
> +					ex->fixup |= FIXUP_ARENA_ACCESS;
> +					if (BPF_CLASS(insn->code) == BPF_LDX)
> +						arena_reg = reg2pt_regs[src_reg];
> +					else
> +						arena_reg = reg2pt_regs[dst_reg];
> +
> +					ex->fixup |= FIELD_PREP(FIXUP_ARENA_REG_MASK, arena_reg);
> +					ex->data |= FIELD_PREP(DATA_ARENA_OFFSET_MASK, insn->off);
> +				}
>   			}
>   			break;
>   
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 8f6e87f0f3a89..9959e30f805b2 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2013,6 +2013,7 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>   			     struct bpf_verifier_log *log);
>   void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map);
>   void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc);
> +void bpf_prog_report_arena_violation(bool write, unsigned long addr);
>   #else
>   #define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
>   static inline bool bpf_try_module_get(const void *data, struct module *owner)
> @@ -2045,6 +2046,10 @@ static inline void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_op
>   {
>   }
>   
> +static inline void bpf_prog_report_arena_violation(bool write, unsigned long addr)
> +{
> +}
> +
>   #endif
>   
>   int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 5b37753799d20..a1653d1c04ca5 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -633,3 +633,23 @@ static int __init kfunc_init(void)
>   	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &common_kfunc_set);
>   }
>   late_initcall(kfunc_init);
> +
> +void bpf_prog_report_arena_violation(bool write, unsigned long addr)
> +{
> +	struct bpf_stream_stage ss;
> +	struct bpf_prog *prog;
> +	u64 user_vm_start;
> +
> +	prog = bpf_prog_find_from_stack();

bpf_prog_find_from_stack depends on arch_bpf_stack_walk, which isn't available
on all archs. How about switching to bpf_prog_ksym_find with the fault pc?

> +	if (!prog)
> +		return;
> +
> +	user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
> +	addr += (user_vm_start >> 32) << 32;
> +
> +	bpf_stream_stage(ss, prog, BPF_STDERR, ({
> +		bpf_stream_printk(ss, "ERROR: Arena %s access at unmapped address 0x%lx\n",
> +				  write ? "WRITE" : "READ", addr);
> +		bpf_stream_dump_stack(ss);
> +	}));
> +}


