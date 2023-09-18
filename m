Return-Path: <bpf+bounces-10314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD337A4F64
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 18:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9CBE2814D7
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 16:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1644120B21;
	Mon, 18 Sep 2023 16:41:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD1410E5
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 16:41:19 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC755FDC;
	Mon, 18 Sep 2023 09:41:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rq6KB3WSpz4f3n6X;
	Mon, 18 Sep 2023 22:15:58 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgBHUwieWwhli80bAw--.34921S2;
	Mon, 18 Sep 2023 22:16:00 +0800 (CST)
Message-ID: <041d4f6b-1350-105e-6ab0-73980aba26ea@huaweicloud.com>
Date: Mon, 18 Sep 2023 22:15:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v2 1/1] bpf, arm64: support exceptions
Content-Language: en-US
To: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20230917000045.56377-1-puranjay12@gmail.com>
 <20230917000045.56377-2-puranjay12@gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20230917000045.56377-2-puranjay12@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBHUwieWwhli80bAw--.34921S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XrWDJr4kuryfKw15WF13XFb_yoWfKr4xpF
	Z5C3y3Grs7XF45WF18tr18XFy5Krs2gF47tr15C34rJFsa9ryUKF1FkFWjkF9xCr95Jw4r
	ZFWjkrn3C3yjv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU13rcDUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/17/2023 8:00 AM, Puranjay Mohan wrote:
> Implement arch_bpf_stack_walk() for the ARM64 JIT. This will be used
> by bpf_throw() to unwind till the program marked as exception boundary and
> run the callback with the stack of the main program.
> 
> The prologue generation code has been modified to make the callback
> program use the stack of the program marked as exception boundary where
> callee-saved registers are already pushed.
> 
> As the bpf_throw function never returns, if it clobbers any callee-saved
> registers, they would remain clobbered. So, the prologue of the
> exception-boundary program is modified to push R23 and R24 as well,
> which the callback will then recover in its epilogue.
> 
> The Procedure Call Standard for the Arm 64-bit Architecture[1] states
> that registers r19 to r28 should be saved by the callee. BPF programs on
> ARM64 already save all callee-saved registers except r23 and r24. This
> patch adds an instruction in prologue of the  program to save these
> two registers and another instruction in the epilogue to recover them.
> 
> These extra instructions are only added if bpf_throw() used. Otherwise
> the emitted prologue/epilogue remains unchanged.
> 
> [1] https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>   arch/arm64/net/bpf_jit_comp.c                | 98 ++++++++++++++++----
>   tools/testing/selftests/bpf/DENYLIST.aarch64 |  1 -
>   2 files changed, 79 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 7d4af64e3982..fcc55e558863 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -21,6 +21,7 @@
>   #include <asm/insn.h>
>   #include <asm/patching.h>
>   #include <asm/set_memory.h>
> +#include <asm/stacktrace.h>
>   
>   #include "bpf_jit.h"
>   
> @@ -285,7 +286,7 @@ static bool is_lsi_offset(int offset, int scale)
>   /* Tail call offset to jump into */
>   #define PROLOGUE_OFFSET (BTI_INSNS + 2 + PAC_INSNS + 8)
>   
> -static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
> +static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf, bool is_exception_cb)
>   {
>   	const struct bpf_prog *prog = ctx->prog;
>   	const bool is_main_prog = !bpf_is_subprog(prog);
> @@ -333,19 +334,28 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
>   	emit(A64_MOV(1, A64_R(9), A64_LR), ctx);
>   	emit(A64_NOP, ctx);
>   
> -	/* Sign lr */
> -	if (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL))
> -		emit(A64_PACIASP, ctx);
> -
> -	/* Save FP and LR registers to stay align with ARM64 AAPCS */
> -	emit(A64_PUSH(A64_FP, A64_LR, A64_SP), ctx);
> -	emit(A64_MOV(1, A64_FP, A64_SP), ctx);
> -
> -	/* Save callee-saved registers */
> -	emit(A64_PUSH(r6, r7, A64_SP), ctx);
> -	emit(A64_PUSH(r8, r9, A64_SP), ctx);
> -	emit(A64_PUSH(fp, tcc, A64_SP), ctx);
> -	emit(A64_PUSH(fpb, A64_R(28), A64_SP), ctx);
> +	if (!is_exception_cb) {
> +		/* Sign lr */
> +		if (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL))
> +			emit(A64_PACIASP, ctx);
> +		/* Save FP and LR registers to stay align with ARM64 AAPCS */
> +		emit(A64_PUSH(A64_FP, A64_LR, A64_SP), ctx);
> +		emit(A64_MOV(1, A64_FP, A64_SP), ctx);
> +
> +		/* Save callee-saved registers */
> +		emit(A64_PUSH(r6, r7, A64_SP), ctx);
> +		emit(A64_PUSH(r8, r9, A64_SP), ctx);
> +		emit(A64_PUSH(fp, tcc, A64_SP), ctx);
> +		emit(A64_PUSH(fpb, A64_R(28), A64_SP), ctx);
> +	} else {
> +		/* Exception callback receives FP of Main Program as third parameter */
> +		emit(A64_MOV(1, A64_FP, A64_R(2)), ctx);
> +		/*
> +		 * Main Program already pushed the frame record and the callee-saved registers. The
> +		 * exception callback will not push anything and re-use the main program's stack.
> +		 */
> +		emit(A64_SUB_I(1, A64_SP, A64_FP, 80), ctx); /* 10 registers are on the stack */

To ensure th calculated A6_SP is always correct, add an assertion
to ensure the distance between A64_FP and A64_SP is 80 after all
callee-registers are pushed to the stack?

> +	}
>   
>   	/* Set up BPF prog stack base register */
>   	emit(A64_MOV(1, fp, A64_SP), ctx);
> @@ -365,6 +375,13 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
>   		emit_bti(A64_BTI_J, ctx);
>   	}
>   
> +	/*
> +	 * Program acting as exception boundary should save all ARM64 Callee-saved registers as the
> +	 * exception callback needs to recover all ARM64 Callee-saved registers in its epilogue.
> +	 */
> +	if (prog->aux->exception_boundary)
> +		emit(A64_PUSH(A64_R(23), A64_R(24), A64_SP), ctx);

Blindly storing x23/x24 to BPF_FP -8/16 is incorrect, as the stack
space below BPF_FP might be written with other values by the bpf
prog.

> +
>   	emit(A64_SUB_I(1, fpb, fp, ctx->fpb_offset), ctx);
>   
>   	/* Stack must be multiples of 16B */
> @@ -653,7 +670,7 @@ static void build_plt(struct jit_ctx *ctx)
>   		plt->target = (u64)&dummy_tramp;
>   }
>   
> -static void build_epilogue(struct jit_ctx *ctx)
> +static void build_epilogue(struct jit_ctx *ctx, bool is_exception_cb)
>   {
>   	const u8 r0 = bpf2a64[BPF_REG_0];
>   	const u8 r6 = bpf2a64[BPF_REG_6];
> @@ -666,6 +683,14 @@ static void build_epilogue(struct jit_ctx *ctx)
>   	/* We're done with BPF stack */
>   	emit(A64_ADD_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
>   
> +	/*
> +	 * Program acting as exception boundary pushes R23 and R24 in addition to BPF callee-saved
> +	 * registers. Exception callback uses the boundary program's stack frame, so recover these

Keep the line width within 80 characters?

> +	 * extra registers in the above two cases.
> +	 */
> +	if (ctx->prog->aux->exception_boundary || is_exception_cb)
> +		emit(A64_POP(A64_R(23), A64_R(24), A64_SP), ctx);
> +
>   	/* Restore x27 and x28 */
>   	emit(A64_POP(fpb, A64_R(28), A64_SP), ctx);
>   	/* Restore fs (x25) and x26 */
> @@ -1575,7 +1600,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>   	 * BPF line info needs ctx->offset[i] to be the offset of
>   	 * instruction[i] in jited image, so build prologue first.
>   	 */
> -	if (build_prologue(&ctx, was_classic)) {
> +	if (build_prologue(&ctx, was_classic, prog->aux->exception_cb)) {
>   		prog = orig_prog;
>   		goto out_off;
>   	}
> @@ -1586,7 +1611,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>   	}
>   
>   	ctx.epilogue_offset = ctx.idx;
> -	build_epilogue(&ctx);
> +	build_epilogue(&ctx, prog->aux->exception_cb);
>   	build_plt(&ctx);
>   
>   	extable_align = __alignof__(struct exception_table_entry);
> @@ -1614,7 +1639,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>   	ctx.idx = 0;
>   	ctx.exentry_idx = 0;
>   
> -	build_prologue(&ctx, was_classic);
> +	build_prologue(&ctx, was_classic, prog->aux->exception_cb);
>   
>   	if (build_body(&ctx, extra_pass)) {
>   		bpf_jit_binary_free(header);
> @@ -1622,7 +1647,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>   		goto out_off;
>   	}
>   
> -	build_epilogue(&ctx);
> +	build_epilogue(&ctx, prog->aux->exception_cb);
>   	build_plt(&ctx);
>   
>   	/* 3. Extra pass to validate JITed code. */
> @@ -2286,3 +2311,38 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
>   
>   	return ret;
>   }
> +
> +bool bpf_jit_supports_exceptions(void)
> +{
> +	/* We unwind through both kernel frames (starting from within bpf_throw call) and
> +	 * BPF frames. Therefore we require FP unwinder to be enabled to walk kernel frames and
> +	 * reach BPF frames in the stack trace.
> +	 * ARM64 kernel is aways compiled with CONFIG_FRAME_POINTER=y
> +	 */
> +	return true;
> +}
> +
> +void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie)
> +{
> +	struct stack_info stacks[] = {
> +		stackinfo_get_task(current),
> +	};
> +

Seems there is no need to define "stacks" as an array

> +	struct unwind_state state = {
> +		.stacks = stacks,
> +		.nr_stacks = ARRAY_SIZE(stacks),
> +	};
> +	unwind_init_common(&state, current);
> +	state.fp = (unsigned long)__builtin_frame_address(1);
> +	state.pc = (unsigned long)__builtin_return_address(0);
> +
> +	if (unwind_next_frame_record(&state))
> +		return;
> +	while (1) {
> +		/* We only use the fp in the exception callback. Pass 0 for sp as it's unavailable*/
> +		if (!consume_fn(cookie, (u64)state.pc, 0, (u64)state.fp))
> +			break;
> +		if (unwind_next_frame_record(&state))

When PTR_AUTH is implemented, lr is encoded before being pushed to
the stack, but unwind_next_frame_record() does not decode state.pc
when fetching it from the stack.

> +			break;
> +	}

And it's better to simplify the if-while(1)-if to:

while (!unwind_next_frame_record(&state)) {
     ...
}

> +}
> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
> index f5065576cae9..7f768d335698 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> @@ -1,6 +1,5 @@
>   bpf_cookie/multi_kprobe_attach_api               # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
>   bpf_cookie/multi_kprobe_link_api                 # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
> -exceptions					 # JIT does not support calling kfunc bpf_throw: -524
>   fexit_sleep                                      # The test never returns. The remaining tests cannot start.
>   kprobe_multi_bench_attach                        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
>   kprobe_multi_test/attach_api_addrs               # bpf_program__attach_kprobe_multi_opts unexpected error: -95


