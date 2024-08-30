Return-Path: <bpf+bounces-38534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76567965C58
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 11:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2851F24E35
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 09:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA70B16EBF7;
	Fri, 30 Aug 2024 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F8/U6Fv3"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D7214BFB4
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 09:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008917; cv=none; b=GmBpBR+qkJFsPygvArtym0kapsVOTT2GcctF9wM/UrwQ8o76gIa0V+JqFrB6RoEtKc91Bn4E9gDtoSa37IE3nF4bepv9zKBnir6++11XWhWo1LoQwRSozw1Un/OGJ5e/O7xC8aTKvc4VhQGu+eZaYlmLPE+DntlAzEwe7Y+1ZIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008917; c=relaxed/simple;
	bh=2RmWszR0Fk857tl6uobsiNKbcYJo41OYe0VnQd53FOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N4tt8vtweDDFkA0usnJeLUrwRrlHaGY8XLYaDPJaQW9x4Ip27SgsFKfJkdq08bMowkfb8x6s0mV9Xp09KSML7x+eaNMy4Ayt9VhnH2/QFUDEk2cIWXZkH8w2j4v2g37rifi/hiTQXS9zT+vBiOYs3dtnmJq1PyiTX2zVtB0BpFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F8/U6Fv3; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9968457f-f4c2-42a1-b45d-44bdf745497e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725008912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rDjx5kr968HurBb7NP8mEtSaK6rAmdEkpQDyViyIuuE=;
	b=F8/U6Fv3suEr7bQuOB7zwCwDmFkXpYe9nG+9ZVqn7Hv1EQ5EmsQP/tcV7BidMajEZLpb6A
	4n8yN6TOF34/mymfcelQv1S+gZysG/jCVPTjkIPJctQqkg5sCo0yRhg6lmha8RgZ5+hZMY
	xYUy9QIN0q80Gh+UgMt0BoRFmW08kv8=
Date: Fri, 30 Aug 2024 17:08:20 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/4] bpf, arm64: Fix tailcall infinite loop
 caused by freplace
Content-Language: en-US
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, puranjay@kernel.org,
 eddyz87@gmail.com, iii@linux.ibm.com, kernel-patches-bot@fb.com
References: <20240825130943.7738-1-leon.hwang@linux.dev>
 <20240825130943.7738-3-leon.hwang@linux.dev>
 <a9ce98d0-adfb-4ed9-8500-f378fe44d634@huaweicloud.com>
 <0900df03-b1cd-41fb-be04-278e135cc730@linux.dev>
 <0f3c9711-3f1c-4678-9e0a-bd825c6fb78f@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <0f3c9711-3f1c-4678-9e0a-bd825c6fb78f@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 30/8/24 15:37, Xu Kuohai wrote:
> On 8/27/2024 10:23 AM, Leon Hwang wrote:
>>

[...]

> 
> I think the complexity arises from having to decide whether
> to initialize or keep the tail counter value in the prologue.
> 
> To get rid of this complexity, a straightforward idea is to
> move the tail call counter initialization to the entry of
> bpf world, and in the bpf world, we only increase and check
> the tail call counter, never save/restore or set it. The
> "entry of the bpf world" here refers to mechanisms like
> bpf_prog_run, bpf dispatcher, or bpf trampoline that
> allows bpf prog to be invoked from C function.
> 
> Below is a rough POC diff for arm64 that could pass all
> of your tests. The tail call counter is held in callee-saved
> register x26, and is set to 0 by arch_run_bpf.
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 8aa32cb140b9..2c0f7daf1655 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -26,7 +26,7 @@
> 
>  #define TMP_REG_1 (MAX_BPF_JIT_REG + 0)
>  #define TMP_REG_2 (MAX_BPF_JIT_REG + 1)
> -#define TCCNT_PTR (MAX_BPF_JIT_REG + 2)
> +#define TCALL_CNT (MAX_BPF_JIT_REG + 2)
>  #define TMP_REG_3 (MAX_BPF_JIT_REG + 3)
>  #define ARENA_VM_START (MAX_BPF_JIT_REG + 5)
> 
> @@ -63,7 +63,7 @@ static const int bpf2a64[] = {
>      [TMP_REG_2] = A64_R(11),
>      [TMP_REG_3] = A64_R(12),
>      /* tail_call_cnt_ptr */
> -    [TCCNT_PTR] = A64_R(26),
> +    [TCALL_CNT] = A64_R(26), // x26 is used to hold tail call counter
>      /* temporary register for blinding constants */
>      [BPF_REG_AX] = A64_R(9),
>      /* callee saved register for kern_vm_start address */
> @@ -286,19 +286,6 @@ static bool is_lsi_offset(int offset, int scale)
>   *      // PROLOGUE_OFFSET
>   *    // save callee-saved registers
>   */
> -static void prepare_bpf_tail_call_cnt(struct jit_ctx *ctx)
> -{
> -    const bool is_main_prog = !bpf_is_subprog(ctx->prog);
> -    const u8 ptr = bpf2a64[TCCNT_PTR];
> -
> -    if (is_main_prog) {
> -        /* Initialize tail_call_cnt. */
> -        emit(A64_PUSH(A64_ZR, ptr, A64_SP), ctx);
> -        emit(A64_MOV(1, ptr, A64_SP), ctx);
> -    } else
> -        emit(A64_PUSH(ptr, ptr, A64_SP), ctx);
> -}
> -
>  static void find_used_callee_regs(struct jit_ctx *ctx)
>  {
>      int i;
> @@ -419,7 +406,7 @@ static void pop_callee_regs(struct jit_ctx *ctx)
>  #define POKE_OFFSET (BTI_INSNS + 1)
> 
>  /* Tail call offset to jump into */
> -#define PROLOGUE_OFFSET (BTI_INSNS + 2 + PAC_INSNS + 4)
> +#define PROLOGUE_OFFSET (BTI_INSNS + 2 + PAC_INSNS + 2)
> 
>  static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
>  {
> @@ -473,8 +460,6 @@ static int build_prologue(struct jit_ctx *ctx, bool
> ebpf_from_cbpf)
>          emit(A64_PUSH(A64_FP, A64_LR, A64_SP), ctx);
>          emit(A64_MOV(1, A64_FP, A64_SP), ctx);
> 
> -        prepare_bpf_tail_call_cnt(ctx);
> -
>          if (!ebpf_from_cbpf && is_main_prog) {
>              cur_offset = ctx->idx - idx0;
>              if (cur_offset != PROLOGUE_OFFSET) {
> @@ -499,7 +484,7 @@ static int build_prologue(struct jit_ctx *ctx, bool
> ebpf_from_cbpf)
>           *
>           * 12 registers are on the stack
>           */
> -        emit(A64_SUB_I(1, A64_SP, A64_FP, 96), ctx);
> +        emit(A64_SUB_I(1, A64_SP, A64_FP, 80), ctx);
>      }
> 
>      if (ctx->fp_used)
> @@ -527,8 +512,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
> 
>      const u8 tmp = bpf2a64[TMP_REG_1];
>      const u8 prg = bpf2a64[TMP_REG_2];
> -    const u8 tcc = bpf2a64[TMP_REG_3];
> -    const u8 ptr = bpf2a64[TCCNT_PTR];
> +    const u8 tcc = bpf2a64[TCALL_CNT];
>      size_t off;
>      __le32 *branch1 = NULL;
>      __le32 *branch2 = NULL;
> @@ -546,16 +530,15 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
>      emit(A64_NOP, ctx);
> 
>      /*
> -     * if ((*tail_call_cnt_ptr) >= MAX_TAIL_CALL_CNT)
> +     * if (tail_call_cnt >= MAX_TAIL_CALL_CNT)
>       *     goto out;
>       */
>      emit_a64_mov_i64(tmp, MAX_TAIL_CALL_CNT, ctx);
> -    emit(A64_LDR64I(tcc, ptr, 0), ctx);
>      emit(A64_CMP(1, tcc, tmp), ctx);
>      branch2 = ctx->image + ctx->idx;
>      emit(A64_NOP, ctx);
> 
> -    /* (*tail_call_cnt_ptr)++; */
> +    /* tail_call_cnt++; */
>      emit(A64_ADD_I(1, tcc, tcc, 1), ctx);
> 
>      /* prog = array->ptrs[index];
> @@ -570,9 +553,6 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
>      branch3 = ctx->image + ctx->idx;
>      emit(A64_NOP, ctx);
> 
> -    /* Update tail_call_cnt if the slot is populated. */
> -    emit(A64_STR64I(tcc, ptr, 0), ctx);
> -
>      /* restore SP */
>      if (ctx->stack_size)
>          emit(A64_ADD_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
> @@ -793,6 +773,27 @@ asm (
>  "    .popsection\n"
>  );
> 
> +unsigned int arch_run_bpf(const void *ctx, const struct bpf_insn
> *insnsi, bpf_func_t bpf_func);
> +asm (
> +"    .pushsection .text, \"ax\", @progbits\n"
> +"    .global arch_run_bpf\n"
> +"    .type arch_run_bpf, %function\n"
> +"arch_run_bpf:\n"
> +#if IS_ENABLED(CONFIG_ARM64_BTI_KERNEL)
> +"    bti j\n"
> +#endif
> +"    stp x29, x30, [sp, #-16]!\n"
> +"    stp xzr, x26, [sp, #-16]!\n"
> +"    mov x26, #0\n"
> +"    blr x2\n"
> +"    ldp xzr, x26, [sp], #16\n"
> +"    ldp x29, x30, [sp], #16\n"
> +"    ret x30\n"
> +"    .size arch_run_bpf, . - arch_run_bpf\n"
> +"    .popsection\n"
> +);
> +EXPORT_SYMBOL_GPL(arch_run_bpf);
> +
>  /* build a plt initialized like this:
>   *
>   * plt:
> @@ -826,7 +827,6 @@ static void build_plt(struct jit_ctx *ctx)
>  static void build_epilogue(struct jit_ctx *ctx)
>  {
>      const u8 r0 = bpf2a64[BPF_REG_0];
> -    const u8 ptr = bpf2a64[TCCNT_PTR];
> 
>      /* We're done with BPF stack */
>      if (ctx->stack_size)
> @@ -834,8 +834,6 @@ static void build_epilogue(struct jit_ctx *ctx)
> 
>      pop_callee_regs(ctx);
> 
> -    emit(A64_POP(A64_ZR, ptr, A64_SP), ctx);
> -
>      /* Restore FP/LR registers */
>      emit(A64_POP(A64_FP, A64_LR, A64_SP), ctx);
> 
> @@ -2066,6 +2064,8 @@ static int prepare_trampoline(struct jit_ctx *ctx,
> struct bpf_tramp_image *im,
>      bool save_ret;
>      __le32 **branches = NULL;
> 
> +    bool target_is_bpf = is_bpf_text_address((unsigned long)func_addr);
> +
>      /* trampoline stack layout:
>       *                  [ parent ip         ]
>       *                  [ FP                ]
> @@ -2133,6 +2133,11 @@ static int prepare_trampoline(struct jit_ctx
> *ctx, struct bpf_tramp_image *im,
>       */
>      emit_bti(A64_BTI_JC, ctx);
> 
> +    if (!target_is_bpf) {
> +        emit(A64_PUSH(A64_ZR, A64_R(26), A64_SP), ctx);
> +        emit(A64_MOVZ(1, A64_R(26), 0, 0), ctx);
> +    }
> +
>      /* frame for parent function */
>      emit(A64_PUSH(A64_FP, A64_R(9), A64_SP), ctx);
>      emit(A64_MOV(1, A64_FP, A64_SP), ctx);
> @@ -2226,6 +2231,8 @@ static int prepare_trampoline(struct jit_ctx *ctx,
> struct bpf_tramp_image *im,
>      /* pop frames  */
>      emit(A64_POP(A64_FP, A64_LR, A64_SP), ctx);
>      emit(A64_POP(A64_FP, A64_R(9), A64_SP), ctx);
> +    if (!target_is_bpf)
> +        emit(A64_POP(A64_ZR, A64_R(26), A64_SP), ctx);
> 
>      if (flags & BPF_TRAMP_F_SKIP_FRAME) {
>          /* skip patched function, return to parent */
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index dc63083f76b7..8660d15dd50c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1244,12 +1244,14 @@ struct bpf_dispatcher {
>  #define __bpfcall __nocfi
>  #endif
> 
> +unsigned int arch_run_bpf(const void *ctx, const struct bpf_insn
> *insnsi, bpf_func_t bpf_func);
> +
>  static __always_inline __bpfcall unsigned int bpf_dispatcher_nop_func(
>      const void *ctx,
>      const struct bpf_insn *insnsi,
>      bpf_func_t bpf_func)
>  {
> -    return bpf_func(ctx, insnsi);
> +    return arch_run_bpf(ctx, insnsi, bpf_func);
>  }
> 
>  /* the implementation of the opaque uapi struct bpf_dynptr */
> @@ -1317,7 +1319,7 @@ int arch_prepare_bpf_dispatcher(void *image, void
> *buf, s64 *funcs, int num_func
>  #else
>  #define __BPF_DISPATCHER_SC_INIT(name)
>  #define __BPF_DISPATCHER_SC(name)
> -#define __BPF_DISPATCHER_CALL(name)        bpf_func(ctx, insnsi)
> +#define __BPF_DISPATCHER_CALL(name)        arch_run_bpf(ctx, insnsi,
> bpf_func);
>  #define __BPF_DISPATCHER_UPDATE(_d, _new)
>  #endif
> 

This approach is really cool!

I want an alike approach on x86. But I failed. Because, on x86, it's an
indirect call to "call *rdx", aka "bpf_func(ctx, insnsi)".

Let us imagine the arch_run_bpf() on x86:

unsigned int __naked arch_run_bpf(const void *ctx, const struct bpf_insn
*insnsi, bpf_func_t bpf_func)
{
	asm (
		"pushq %rbp\n\t"
		"movq %rsp, %rbp\n\t"
		"xor %rax, %rax\n\t"
		"pushq %rax\n\t"
		"movq %rsp, %rax\n\t"
		"callq *%rdx\n\t"
		"leave\n\t"
		"ret\n\t"
	);
}

If we can change "callq *%rdx" to a direct call, it'll be really
wonderful to resolve this tailcall issue on x86.

How to introduce arch_bpf_run() for all JIT backends?

Thanks,
Leon


