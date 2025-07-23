Return-Path: <bpf+bounces-64221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A83FB0FC7F
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 00:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB231AA7594
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 22:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911E920A5EB;
	Wed, 23 Jul 2025 22:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LxaPVpdj"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238E02E36FB
	for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 22:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753308104; cv=none; b=gajdqeSngtPbFPaL1EN9GGPVH3qMjzH7sIcwv6ZgnI28XvRIOMKr3IjeukGhj3Hi0mnr7xaUKcXgZv12hixHZdgccT5G1LbB2EZHD2mdHDTJQXuooRdTLbH2BcxRDXZVYkdtsS/BG4tGNp6RyEhUk/aQYMjiKAUO6VOFi4WzzD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753308104; c=relaxed/simple;
	bh=/bnLNs1GyW5BhkyPYDGoV2W0zlrI4m9PtFgLkVQTLeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lq9nLW79ldClqXtUQ5cCaw4P9ltVpcbjEbdaQhzcAzDIVzxNuElCNcqQUM33TVWbEGxa3JPfhTISn8UmyO7jeLcfWM4DVsEalVdA8Y5JAKvr986ILlcgyIy9+SwOtZCOp1HYWgHgrpgXHYS4keqr88SPiy/HPShzp9ydAoWxvOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LxaPVpdj; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <efa522fd-59b6-4cef-b076-64b3e4b2ee94@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753308100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FMneURrFRIPPk3SiivUUTGPLxBoyRRGmOiYPQsN8Wj0=;
	b=LxaPVpdjdcJ/UKeorUi5iO/Ev5wOjK8QPdA/kV8VYvIriHfa2PPQQMLSU/xIwk9Qe7OS+J
	2EuXGqburmcbtChOb8SYQGMMZlMJbBl4vK/yv8eU2d9jzYKPj0Qzfc9UuOAG9AOXYrHM+X
	uR4Kqms+/21DRITx43UJCZBLlm0SSoA=
Date: Wed, 23 Jul 2025 15:01:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf, arm64: JIT support for private stack
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
 Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org
References: <20250722173254.3879-1-puranjay@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250722173254.3879-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/22/25 10:32 AM, Puranjay Mohan wrote:
> The private stack is allocated in bpf_int_jit_compile() with 16-byte
> alignment. It includes additional guard regions to detect stack
> overflows and underflows at runtime.
>
> Memory layout:
>
>                +------------------------------------------------------+
>                |                                                      |
>                |  16 bytes padding (overflow guard - stack top)       |
>                |  [ detects writes beyond top of stack ]              |
>       BPF FP ->+------------------------------------------------------+
>                |                                                      |
>                |  BPF private stack (sized by verifier)               |
>                |  [ 16-byte aligned ]                                 |
>                |                                                      |
> BPF PRIV SP ->+------------------------------------------------------+
>                |                                                      |
>                |  16 bytes padding (underflow guard - stack bottom)   |
>                |  [ detects accesses before start of stack ]          |
>                |                                                      |
>                +------------------------------------------------------+
>
> On detection of an overflow or underflow, the kernel emits messages
> like:
>      BPF private stack overflow/underflow detected for prog <prog_name>
>
> After commit bd737fcb6485 ("bpf, arm64: Get rid of fpb"), Jited BPF
> programs use the stack in two ways:
> 1. Via the BPF frame pointer (top of stack), using negative offsets.
> 2. Via the stack pointer (bottom of stack), using positive offsets in
>     LDR/STR instructions.
>
> When a private stack is used, ARM64 callee-saved register x27 replaces
> the stack pointer. The BPF frame pointer usage remains unchanged; but it
> now points to the top of the private stack.
>
> Relevant tests:
>
>   #415/1   struct_ops_private_stack/private_stack:OK
>   #415/2   struct_ops_private_stack/private_stack_fail:OK
>   #415/3   struct_ops_private_stack/private_stack_recur:OK
>   #415     struct_ops_private_stack:OK
>   #549/1   verifier_private_stack/Private stack, single prog:OK
>   #549/2   verifier_private_stack/Private stack, subtree > MAX_BPF_STACK:OK
>   #549/3   verifier_private_stack/No private stack:OK
>   #549/4   verifier_private_stack/Private stack, callback:OK
>   #549/5   verifier_private_stack/Private stack, exception in main prog:OK
>   #549/6   verifier_private_stack/Private stack, exception in subprog:OK
>   #549/7   verifier_private_stack/Private stack, async callback, not nested:OK
>   #549/8   verifier_private_stack/Private stack, async callback, potential nesting:OK
>   #549     verifier_private_stack:OK
>   Summary: 2/11 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
> Note: This needs the fix in [1] to work properly.
> [1] https://lore.kernel.org/all/20250722133410.54161-2-puranjay@kernel.org/
> ---
>   arch/arm64/net/bpf_jit_comp.c                 | 131 ++++++++++++++++--
>   arch/x86/net/bpf_jit_comp.c                   |   9 +-
>   include/linux/filter.h                        |   2 +
>   kernel/bpf/core.c                             |   7 +
>   .../bpf/progs/struct_ops_private_stack.c      |   2 +-
>   .../bpf/progs/struct_ops_private_stack_fail.c |   2 +-
>   .../progs/struct_ops_private_stack_recur.c    |   2 +-
>   .../bpf/progs/verifier_private_stack.c        |  89 +++++++++++-
>   8 files changed, 221 insertions(+), 23 deletions(-)
>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 89b1b8c248c62..5a0170536c8d4 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -30,6 +30,7 @@
>   #define TMP_REG_2 (MAX_BPF_JIT_REG + 1)
>   #define TCCNT_PTR (MAX_BPF_JIT_REG + 2)
>   #define TMP_REG_3 (MAX_BPF_JIT_REG + 3)
> +#define PRIVATE_SP (MAX_BPF_JIT_REG + 4)
>   #define ARENA_VM_START (MAX_BPF_JIT_REG + 5)
>   
>   #define check_imm(bits, imm) do {				\
> @@ -68,6 +69,8 @@ static const int bpf2a64[] = {
>   	[TCCNT_PTR] = A64_R(26),
>   	/* temporary register for blinding constants */
>   	[BPF_REG_AX] = A64_R(9),
> +	/* callee saved register for private stack pointer */
> +	[PRIVATE_SP] = A64_R(27),
>   	/* callee saved register for kern_vm_start address */
>   	[ARENA_VM_START] = A64_R(28),
>   };
> @@ -86,6 +89,7 @@ struct jit_ctx {
>   	u64 user_vm_start;
>   	u64 arena_vm_start;
>   	bool fp_used;
> +	bool priv_sp_used;
>   	bool write;
>   };
>   
> @@ -98,6 +102,10 @@ struct bpf_plt {
>   #define PLT_TARGET_SIZE   sizeof_field(struct bpf_plt, target)
>   #define PLT_TARGET_OFFSET offsetof(struct bpf_plt, target)
>   
> +/* Memory size/value to protect private stack overflow/underflow */
> +#define PRIV_STACK_GUARD_SZ    16
> +#define PRIV_STACK_GUARD_VAL   0xEB9F12345678eb9fULL
> +
>   static inline void emit(const u32 insn, struct jit_ctx *ctx)
>   {
>   	if (ctx->image != NULL && ctx->write)
> @@ -387,8 +395,11 @@ static void find_used_callee_regs(struct jit_ctx *ctx)
>   	if (reg_used & 8)
>   		ctx->used_callee_reg[i++] = bpf2a64[BPF_REG_9];
>   
> -	if (reg_used & 16)
> +	if (reg_used & 16) {
>   		ctx->used_callee_reg[i++] = bpf2a64[BPF_REG_FP];
> +		if (ctx->priv_sp_used)
> +			ctx->used_callee_reg[i++] = bpf2a64[PRIVATE_SP];
> +	}
>   
>   	if (ctx->arena_vm_start)
>   		ctx->used_callee_reg[i++] = bpf2a64[ARENA_VM_START];
> @@ -461,6 +472,19 @@ static void pop_callee_regs(struct jit_ctx *ctx)
>   	}
>   }
>   

[...]

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 40e1b3b9634fe..7e3fca1646203 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3501,13 +3501,6 @@ int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_func
>   	return emit_bpf_dispatcher(&prog, 0, num_funcs - 1, funcs, image, buf);
>   }
>   
> -static const char *bpf_get_prog_name(struct bpf_prog *prog)
> -{
> -	if (prog->aux->ksym.prog)
> -		return prog->aux->ksym.name;
> -	return prog->aux->name;
> -}
> -
>   static void priv_stack_init_guard(void __percpu *priv_stack_ptr, int alloc_size)
>   {
>   	int cpu, underflow_idx = (alloc_size - PRIV_STACK_GUARD_SZ) >> 3;
> @@ -3531,7 +3524,7 @@ static void priv_stack_check_guard(void __percpu *priv_stack_ptr, int alloc_size
>   		if (stack_ptr[0] != PRIV_STACK_GUARD_VAL ||
>   		    stack_ptr[underflow_idx] != PRIV_STACK_GUARD_VAL) {
>   			pr_err("BPF private stack overflow/underflow detected for prog %sx\n",
> -			       bpf_get_prog_name(prog));
> +			       bpf_jit_get_prog_name(prog));
>   			break;
>   		}
>   	}
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index eca229752cbef..5cc7a82ec8322 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1278,6 +1278,8 @@ int bpf_jit_get_func_addr(const struct bpf_prog *prog,
>   			  const struct bpf_insn *insn, bool extra_pass,
>   			  u64 *func_addr, bool *func_addr_fixed);
>   
> +const char *bpf_jit_get_prog_name(struct bpf_prog *prog);
> +
>   struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *fp);
>   void bpf_jit_prog_release_other(struct bpf_prog *fp, struct bpf_prog *fp_other);
>   
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 61613785bdd0f..29c0225c14aa9 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1297,6 +1297,13 @@ int bpf_jit_get_func_addr(const struct bpf_prog *prog,
>   	return 0;
>   }
>   
> +const char *bpf_jit_get_prog_name(struct bpf_prog *prog)
> +{
> +	if (prog->aux->ksym.prog)
> +		return prog->aux->ksym.name;
> +	return prog->aux->name;
> +}

This is a refactoring and should be a separate patch.

> +
>   static int bpf_jit_blind_insn(const struct bpf_insn *from,
>   			      const struct bpf_insn *aux,
>   			      struct bpf_insn *to_buff,
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
> index 0e4d2ff63ab81..dbe646013811a 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c

The selftests should be another separate patch.

> @@ -7,7 +7,7 @@
>   
>   char _license[] SEC("license") = "GPL";
>   
> -#if defined(__TARGET_ARCH_x86)
> +#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
>   bool skip __attribute((__section__(".data"))) = false;
>   #else
>   bool skip = true;
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
> index 58d5d8dc22352..3d89ad7cbe2a9 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
> @@ -7,7 +7,7 @@
>   
>   char _license[] SEC("license") = "GPL";
>   
> -#if defined(__TARGET_ARCH_x86)
> +#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
>   bool skip __attribute((__section__(".data"))) = false;
>   #else
>   bool skip = true;
[...]

