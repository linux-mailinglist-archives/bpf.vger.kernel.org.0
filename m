Return-Path: <bpf+bounces-38081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EADD95F3EC
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 16:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F24F1F22AC6
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 14:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9477018BBBF;
	Mon, 26 Aug 2024 14:32:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD9217D35B
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724682768; cv=none; b=rTIukRR7KjDaezcN38mjU+iHYqeKngxkkYN10E0cNv54uW2Z4FI0Tz7+WJJkF6xgK3g8m+93A9uygq7HKmKMdi//9eT6jwjOejoog2nUtfoFwBOFXY/DofEpUzuzE1q3p4PlSiblUJkMLdVxFQJLcEax47uTyZFs1TTNE5GI3bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724682768; c=relaxed/simple;
	bh=Zr9WeE0V1P8gxLOm0cZgnNENtXNrgP3Ke7QWEV3vnPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ve8JlZiy40KHQxW5qD7B8N9imp7uGXNUkyqAB91hK3XRbiuP2FiWkpU3mGxBPj0Kz0crJmfVu0pJ2qhhoSU4ACBeUpS5dEFW4PJSdk4ZDmPHssxiUNtOf6MQm3PCiE/1GQwvy4sHee5i/dtuJ1mwG2gNVMtGyGwQj0ATk2ztl0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WstRs4sX3z4f3jMf
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 22:32:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2A5401A15D9
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 22:32:40 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgDnPE8FksxmHDXLCg--.38628S2;
	Mon, 26 Aug 2024 22:32:38 +0800 (CST)
Message-ID: <a9ce98d0-adfb-4ed9-8500-f378fe44d634@huaweicloud.com>
Date: Mon, 26 Aug 2024 22:32:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/4] bpf, arm64: Fix tailcall infinite loop
 caused by freplace
Content-Language: en-US
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, puranjay@kernel.org,
 eddyz87@gmail.com, iii@linux.ibm.com, kernel-patches-bot@fb.com
References: <20240825130943.7738-1-leon.hwang@linux.dev>
 <20240825130943.7738-3-leon.hwang@linux.dev>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20240825130943.7738-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDnPE8FksxmHDXLCg--.38628S2
X-Coremail-Antispam: 1UD129KBjvJXoW3ArW5uFWfuFykJw43Wr17ZFb_yoW3WFWxpF
	95Aws3CF4kXw47XF4xtw4xXFWakws2qr4akry5u345Ar92gr9IgF45KFW5uFW5ury8Ar48
	ZFyjvwnxC3y7Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 8/25/2024 9:09 PM, Leon Hwang wrote:
> Like "bpf, x64: Fix tailcall infinite loop caused by freplace", the same
> issue happens on arm64, too.
> 
> For example:
> 
> tc_bpf2bpf.c:
> 
> // SPDX-License-Identifier: GPL-2.0
> \#include <linux/bpf.h>
> \#include <bpf/bpf_helpers.h>
> 
> __noinline
> int subprog_tc(struct __sk_buff *skb)
> {
> 	return skb->len * 2;
> }
> 
> SEC("tc")
> int entry_tc(struct __sk_buff *skb)
> {
> 	return subprog(skb);
> }
> 
> char __license[] SEC("license") = "GPL";
> 
> tailcall_bpf2bpf_hierarchy_freplace.c:
> 
> // SPDX-License-Identifier: GPL-2.0
> \#include <linux/bpf.h>
> \#include <bpf/bpf_helpers.h>
> 
> struct {
> 	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> 	__uint(max_entries, 1);
> 	__uint(key_size, sizeof(__u32));
> 	__uint(value_size, sizeof(__u32));
> } jmp_table SEC(".maps");
> 
> int count = 0;
> 
> static __noinline
> int subprog_tail(struct __sk_buff *skb)
> {
> 	bpf_tail_call_static(skb, &jmp_table, 0);
> 	return 0;
> }
> 
> SEC("freplace")
> int entry_freplace(struct __sk_buff *skb)
> {
> 	count++;
> 	subprog_tail(skb);
> 	subprog_tail(skb);
> 	return count;
> }
> 
> char __license[] SEC("license") = "GPL";
> 
> The attach target of entry_freplace is subprog_tc, and the tail callee
> in subprog_tail is entry_tc.
> 
> Then, the infinite loop will be entry_tc -> entry_tc -> entry_freplace ->
> subprog_tail --tailcall-> entry_tc, because tail_call_cnt in
> entry_freplace will count from zero for every time of entry_freplace
> execution.
> 
> This patch fixes the issue by avoiding touching tail_call_cnt at
> prologue when it's subprog or freplace prog.
> 
> Then, when freplace prog attaches to entry_tc, it has to initialize
> tail_call_cnt and tail_call_cnt_ptr, because its target is main prog and
> its target's prologue hasn't initialize them before the attach hook.
> 
> So, this patch uses x7 register to tell freplace prog that its target
> prog is main prog or not.
> 
> Meanwhile, while tail calling to a freplace prog, it is required to
> reset x7 register to prevent re-initializing tail_call_cnt at freplace
> prog's prologue.
> 
> Fixes: 1c123c567fb1 ("bpf: Resolve fext program type when checking map compatibility")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>   arch/arm64/net/bpf_jit_comp.c | 39 +++++++++++++++++++++++++++++++----
>   1 file changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 59e05a7aea56a..4f8189824973f 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -276,6 +276,7 @@ static bool is_lsi_offset(int offset, int scale)
>   /* generated prologue:
>    *      bti c // if CONFIG_ARM64_BTI_KERNEL
>    *      mov x9, lr
> + *      mov x7, 1 // if not-freplace main prog
>    *      nop  // POKE_OFFSET
>    *      paciasp // if CONFIG_ARM64_PTR_AUTH_KERNEL
>    *      stp x29, lr, [sp, #-16]!
> @@ -293,13 +294,14 @@ static bool is_lsi_offset(int offset, int scale)
>   static void prepare_bpf_tail_call_cnt(struct jit_ctx *ctx)
>   {
>   	const struct bpf_prog *prog = ctx->prog;
> +	const bool is_ext = prog->type == BPF_PROG_TYPE_EXT;
>   	const bool is_main_prog = !bpf_is_subprog(prog);
>   	const u8 ptr = bpf2a64[TCCNT_PTR];
>   	const u8 fp = bpf2a64[BPF_REG_FP];
>   	const u8 tcc = ptr;
>   
>   	emit(A64_PUSH(ptr, fp, A64_SP), ctx);
> -	if (is_main_prog) {
> +	if (is_main_prog && !is_ext) {
>   		/* Initialize tail_call_cnt. */
>   		emit(A64_MOVZ(1, tcc, 0, 0), ctx);
>   		emit(A64_PUSH(tcc, fp, A64_SP), ctx);
> @@ -315,22 +317,26 @@ static void prepare_bpf_tail_call_cnt(struct jit_ctx *ctx)
>   #define PAC_INSNS (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL) ? 1 : 0)
>   
>   /* Offset of nop instruction in bpf prog entry to be poked */
> -#define POKE_OFFSET (BTI_INSNS + 1)
> +#define POKE_OFFSET (BTI_INSNS + 2)
>   
>   /* Tail call offset to jump into */
> -#define PROLOGUE_OFFSET (BTI_INSNS + 2 + PAC_INSNS + 10)
> +#define PROLOGUE_OFFSET (BTI_INSNS + 3 + PAC_INSNS + 10)
>   
>   static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
>   			  bool is_exception_cb, u64 arena_vm_start)
>   {
>   	const struct bpf_prog *prog = ctx->prog;
> +	const bool is_ext = prog->type == BPF_PROG_TYPE_EXT;
>   	const bool is_main_prog = !bpf_is_subprog(prog);
> +	const u8 r0 = bpf2a64[BPF_REG_0];
>   	const u8 r6 = bpf2a64[BPF_REG_6];
>   	const u8 r7 = bpf2a64[BPF_REG_7];
>   	const u8 r8 = bpf2a64[BPF_REG_8];
>   	const u8 r9 = bpf2a64[BPF_REG_9];
>   	const u8 fp = bpf2a64[BPF_REG_FP];
>   	const u8 fpb = bpf2a64[FP_BOTTOM];
> +	const u8 ptr = bpf2a64[TCCNT_PTR];
> +	const u8 tmp = bpf2a64[TMP_REG_1];
>   	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
>   	const int idx0 = ctx->idx;
>   	int cur_offset;
> @@ -367,6 +373,10 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
>   	emit_bti(A64_BTI_JC, ctx);
>   
>   	emit(A64_MOV(1, A64_R(9), A64_LR), ctx);
> +	if (!is_ext)
> +		emit(A64_MOVZ(1, r0, is_main_prog, 0), ctx);
> +	else
> +		emit(A64_NOP, ctx);
>   	emit(A64_NOP, ctx);
>   
>   	if (!is_exception_cb) {
> @@ -413,6 +423,19 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
>   		emit_bti(A64_BTI_J, ctx);
>   	}
>   
> +	/* If freplace's target prog is main prog, it has to make x26 as
> +	 * tail_call_cnt_ptr, and then initialize tail_call_cnt via the
> +	 * tail_call_cnt_ptr.
> +	 */
> +	if (is_main_prog && is_ext) {
> +		emit(A64_MOVZ(1, tmp, 1, 0), ctx);
> +		emit(A64_CMP(1, r0, tmp), ctx);
> +		emit(A64_B_(A64_COND_NE, 4), ctx);
> +		emit(A64_ADD_I(1, ptr, A64_SP, 16), ctx);
> +		emit(A64_MOVZ(1, r0, 0, 0), ctx);
> +		emit(A64_STR64I(r0, ptr, 0), ctx);
> +	}
> +
>   	/*
>   	 * Program acting as exception boundary should save all ARM64
>   	 * Callee-saved registers as the exception callback needs to recover
> @@ -444,6 +467,7 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
>   static int out_offset = -1; /* initialized on the first pass of build_body() */
>   static int emit_bpf_tail_call(struct jit_ctx *ctx)
>   {
> +	const u8 r0 = bpf2a64[BPF_REG_0];
>   	/* bpf_tail_call(void *prog_ctx, struct bpf_array *array, u64 index) */
>   	const u8 r2 = bpf2a64[BPF_REG_2];
>   	const u8 r3 = bpf2a64[BPF_REG_3];
> @@ -491,6 +515,11 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
>   
>   	/* Update tail_call_cnt if the slot is populated. */
>   	emit(A64_STR64I(tcc, ptr, 0), ctx);
> +	/* When freplace prog tail calls freplace prog, setting r0 as 0 is to
> +	 * prevent re-initializing tail_call_cnt at the prologue of target
> +	 * freplace prog.
> +	 */
> +	emit(A64_MOVZ(1, r0, 0, 0), ctx);
>   
>   	/* goto *(prog->bpf_func + prologue_offset); */
>   	off = offsetof(struct bpf_prog, bpf_func);
> @@ -2199,9 +2228,10 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   		emit(A64_RET(A64_R(10)), ctx);
>   		/* store return value */
>   		emit(A64_STR64I(A64_R(0), A64_SP, retval_off), ctx);
> -		/* reserve a nop for bpf_tramp_image_put */
> +		/* reserve two nops for bpf_tramp_image_put */
>   		im->ip_after_call = ctx->ro_image + ctx->idx;
>   		emit(A64_NOP, ctx);
> +		emit(A64_NOP, ctx);
>   	}
>   
>   	/* update the branches saved in invoke_bpf_mod_ret with cbnz */
> @@ -2484,6 +2514,7 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
>   		/* skip to the nop instruction in bpf prog entry:
>   		 * bti c // if BTI enabled
>   		 * mov x9, x30
> +		 * mov x7, 1 // if not-freplace main prog
>   		 * nop
>   		 */
>   		ip = image + POKE_OFFSET * AARCH64_INSN_SIZE;

This patch makes arm64 jited prologue even more complex. I've posted a series [1]
to simplify the arm64 jited prologue/epilogue. I think we can fix this issue based
on [1]. I'll give it a try.

[1] https://lore.kernel.org/bpf/20240826071624.350108-1-xukuohai@huaweicloud.com/


