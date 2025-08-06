Return-Path: <bpf+bounces-65166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4517B1CF8E
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 01:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52CD2621B86
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 23:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22668277CAB;
	Wed,  6 Aug 2025 23:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Af2B8AW/"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C91D27470
	for <bpf@vger.kernel.org>; Wed,  6 Aug 2025 23:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754524672; cv=none; b=YLZZIUTePC6Q4xudp+8wsHoUfbNTAHEshap14OIss0I3sHUXiFdGn4hDOi1yNxDmpQ9jhU5yxIzaQc+ZaTPjyBp6RZO2WbtXg4eebcBUhoS7lm3z3LLkvyrVg6l83Hfgw7ir4iC+on3xqix1KDK27YJtTsjuMdIM23lp17RQ01s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754524672; c=relaxed/simple;
	bh=EUqOgeiSsqWTvOA0qd3WbiH2JVpsweRk4A9vh1NJ/6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UWbyAre2nr5jA2DuVbYj+M8bRRCtXzt5SHgeLXL8h/15wL3ojYEYtvYuFERuY0LAa4tmWO6na/tHhBA9RrQSMMdgv8zd0JmdLhM7cHSnVI3a8doYoD7jyBQ2Q+5vhQ2qrdRPjNdMFY2XTqVYII3tvs8SutDiOlXs5+H7YgVYhxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Af2B8AW/; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b34dea3f-33b0-429d-9a64-c6305e2df397@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754524668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1Pgk0MY7Om85mMg+vEHuwwza2h0W0pIThPPnm5lb7U=;
	b=Af2B8AW/S1b0gR5Z7IyucKqYU+OGvt4adTxUEwyXzskYxHhcqr9F1Fgpk++ZPR2qo9DSnr
	6fizzv5W5sw8u2isFmuoZpcXjRpcNMOXMd7r3ZAd7d+1bslttUmjwt/m6mupiovY+t92GG
	3tBO7Ilbo8sgSkK5Ywuv4WyYmxiOoYs=
Date: Wed, 6 Aug 2025 16:57:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/3] bpf: Report arena faults to BPF stderr
Content-Language: en-GB
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Xu Kuohai <xukuohai@huaweicloud.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
References: <20250806085847.18633-1-puranjay@kernel.org>
 <20250806085847.18633-3-puranjay@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250806085847.18633-3-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/6/25 1:58 AM, Puranjay Mohan wrote:
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

LGTM with some nits below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   arch/arm64/net/bpf_jit_comp.c | 31 ++++++++++++++
>   arch/x86/net/bpf_jit_comp.c   | 80 +++++++++++++++++++++++++++++++++--
>   include/linux/bpf.h           |  1 +
>   kernel/bpf/arena.c            | 20 +++++++++
>   4 files changed, 128 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 42643fd9168fc..5680c7cd8932f 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1066,6 +1066,9 @@ static void build_epilogue(struct jit_ctx *ctx, bool was_classic)
>   	emit(A64_RET(A64_LR), ctx);
>   }
>   
> +#define BPF_FIXUP_LOAD_OFFSET_MASK GENMASK(15, 0)
> +#define BPF_FIXUP_ARENA_REG_MASK   GENMASK(20, 16)
> +#define BPF_ARENA_ACCESS	   BIT(21)
>   #define BPF_FIXUP_REG_MASK	GENMASK(31, 27)
>   #define DONT_CLEAR 5 /* Unused ARM64 register from BPF's POV */
>   
> @@ -1073,11 +1076,22 @@ bool ex_handler_bpf(const struct exception_table_entry *ex,
>   		    struct pt_regs *regs)
>   {
>   	int dst_reg = FIELD_GET(BPF_FIXUP_REG_MASK, ex->fixup);
> +	s16 off = FIELD_GET(BPF_FIXUP_LOAD_OFFSET_MASK, ex->fixup);
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
> @@ -1087,6 +1101,9 @@ static int add_exception_handler(const struct bpf_insn *insn,
>   				 int dst_reg)
>   {
>   	off_t ins_offset;
> +	s16 load_off = insn->off;

Change 'load_off' to 'off' so it matches the usage in ex_handler_bpf().
Also 'off' could mean the off for a store insn, right?

> +	bool is_arena;
> +	int arena_reg;
>   	unsigned long pc;
>   	struct exception_table_entry *ex;
>   
> @@ -1100,6 +1117,9 @@ static int add_exception_handler(const struct bpf_insn *insn,
>   				BPF_MODE(insn->code) != BPF_PROBE_ATOMIC)
>   		return 0;
>   
> +	is_arena = (BPF_MODE(insn->code) == BPF_PROBE_MEM32) ||
> +		   (BPF_MODE(insn->code) == BPF_PROBE_ATOMIC);
> +
>   	if (!ctx->prog->aux->extable ||
>   	    WARN_ON_ONCE(ctx->exentry_idx >= ctx->prog->aux->num_exentries))
>   		return -EINVAL;
> @@ -1131,6 +1151,17 @@ static int add_exception_handler(const struct bpf_insn *insn,
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
> +		ex->fixup |=  FIELD_PREP(BPF_FIXUP_LOAD_OFFSET_MASK, load_off) |
> +			      FIELD_PREP(BPF_FIXUP_ARENA_REG_MASK, arena_reg);
> +	}
> +
>   	ex->type = EX_TYPE_BPF;
>   
>   	ctx->exentry_idx++;
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 7e3fca1646203..c8d99375e6de7 100644
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
> +#define FIXUP_OFFSET_MASK	GENMASK(7, 0)

Maybe FIXUP_INSN_LEN_MASK?

> +#define FIXUP_REG_MASK		GENMASK(15, 8)
> +#define FIXUP_ARENA_REG_MASK	GENMASK(23, 16)
> +#define FIXUP_ARENA_ACCESS	BIT(31)
> +#define DATA_ARENA_OFFSET_MASK	GENMASK(31, 16)
>   
>   bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
>   {
> -	u32 reg = x->fixup >> 8;
> +	u32 reg = FIELD_GET(FIXUP_REG_MASK, x->fixup);
> +	off_t offset = FIELD_GET(FIXUP_OFFSET_MASK, x->fixup);

insn_len = ...

> +	bool is_arena = !!(x->fixup & FIXUP_ARENA_ACCESS);
> +	bool is_write = (reg == DONT_CLEAR);
> +	unsigned long addr;
> +	s16 arena_offset;

This should be just 'off', right? It would be good if the terminology is consistent
between different architectures.

> +	u32 arena_reg;
>   
>   	/* jump over faulting load and clear dest register */
>   	if (reg != DONT_CLEAR)
>   		*(unsigned long *)((void *)regs + reg) = 0;
> -	regs->ip += x->fixup & 0xff;
> +	regs->ip += offset;
> +
> +	if (is_arena) {
> +		arena_reg = FIELD_GET(FIXUP_ARENA_REG_MASK, x->data);
> +		arena_offset = FIELD_GET(DATA_ARENA_OFFSET_MASK, x->data);
> +		addr = *(unsigned long *)((void *)regs + arena_reg) + arena_offset;
> +		bpf_prog_report_arena_violation(is_write, addr);
> +	}
> +
>   	return true;
>   }
>   
> @@ -2070,6 +2122,9 @@ st:			if (is_imm8(insn->off))
>   			{
>   				struct exception_table_entry *ex;
>   				u8 *_insn = image + proglen + (start_of_ldx - temp);
> +				bool is_arena;
> +				u32 fixup_reg;
> +				u32 arena_reg;

the above two variables can be in the same line and can before 'is_arena'.

>   				s64 delta;
>   
>   				if (!bpf_prog->aux->extable)
> @@ -2089,8 +2144,25 @@ st:			if (is_imm8(insn->off))
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
> +				ex->fixup = FIELD_PREP(FIXUP_OFFSET_MASK, prog - start_of_ldx) |
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
> index cc700925b802f..3e62834726a97 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3653,6 +3653,7 @@ int bpf_stream_stage_printk(struct bpf_stream_stage *ss, const char *fmt, ...);
>   int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
>   			    enum bpf_stream_id stream_id);
>   int bpf_stream_stage_dump_stack(struct bpf_stream_stage *ss);
> +void bpf_prog_report_arena_violation(bool write, unsigned long addr);
>   
>   #define bpf_stream_printk(ss, ...) bpf_stream_stage_printk(&ss, __VA_ARGS__)
>   #define bpf_stream_dump_stack(ss) bpf_stream_stage_dump_stack(&ss)
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


