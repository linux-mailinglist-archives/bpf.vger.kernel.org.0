Return-Path: <bpf+bounces-10547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EF67A99EB
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 20:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1CA1F21306
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 18:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507F717737;
	Thu, 21 Sep 2023 17:28:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072D32032E
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 17:28:28 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9800557B06;
	Thu, 21 Sep 2023 10:27:59 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31dcf18f9e2so1218974f8f.0;
        Thu, 21 Sep 2023 10:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695317275; x=1695922075; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aLOUgBOKWq6NxdLoayq1kH+OHtuiezuR3fsDyRpcAkg=;
        b=BQATa9o9w8G1HdgATZ39j0QSA7ONtwIK7+txsC1lXDeaCsXBSDjcUwa4Vnu/9WZp9r
         K5zBz3IBjTz24RImvghtJtLWDeJwiiNi9mjhh9DbG3x2ErmPgWcZGLee00y8YFOrw5RW
         j4q22WPwuBSi+LtX0QTuhsQnJl1w7IGbc63xmm8XeNg8YxHq/c1SjE+c3+CDNwpNJE0Q
         lKanOhOm9dSLRezciqCiz8bkgbaX0XanpzcLY4gVlDXHm++MJ1J5o9FqnbhgMQ8Woj1S
         aY37FXZXcGTUZFCt2AZSNytMqDcWI7pH3WUAFEuHraqsd6okKZYL/iWoXgK7HvnOgvUT
         4PlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317275; x=1695922075;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLOUgBOKWq6NxdLoayq1kH+OHtuiezuR3fsDyRpcAkg=;
        b=iEzfHCZYZj9OeaPi1P+Z3JvJc4b8YVZkQnANeOv263SgppB4GRFmzE9jQBONPW2Vzd
         3G1qGL8L5JEB7TAfu3deOmiohYpqxIq6zmvdHmHuouiudcCaIejOdbSVneOp7ChUAu/l
         vJ60nK5OF+f7eOcQBVK2yBg5DALGzhQT2Rj/d+qLrIsKlQ6sqNo4+fx5meElXDWNkR6n
         tiAL3smYo7loFpEszJSP5FpbKFl4HJtNSYL2E+pgRcKkwcZbF2NV0EOlZuLa+Oayb0Ow
         u17yW49CnAzS5t4bhYByLDgEm3D3GLJIHUWQYCztz6n0cYqTvNKIT0FIxlcc6MUSmErD
         jSXA==
X-Gm-Message-State: AOJu0YzNJDvGK4zVUIrdh8IALd2FwVesiX2JmNvoru5sDixmzas01zEC
	t32PWV9krE0BvHv3EICOwBUPQwPkgKzPVdS8xIE=
X-Google-Smtp-Source: AGHT+IEUpN0KuvGnoDiMlnRabWMiMnNcX5ax9rogd8GDac7s6BmcAIsrNfcqrWw+ZP+e60CCtjEJxQ==
X-Received: by 2002:a5d:58d6:0:b0:320:4cf:5b50 with SMTP id o22-20020a5d58d6000000b0032004cf5b50mr5202131wrf.5.1695302221075;
        Thu, 21 Sep 2023 06:17:01 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id w12-20020a5d608c000000b003179d5aee67sm1733019wrt.94.2023.09.21.06.16.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Sep 2023 06:16:59 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] bpf, arm64: support exceptions
In-Reply-To: <041d4f6b-1350-105e-6ab0-73980aba26ea@huaweicloud.com>
References: <20230917000045.56377-1-puranjay12@gmail.com>
 <20230917000045.56377-2-puranjay12@gmail.com>
 <041d4f6b-1350-105e-6ab0-73980aba26ea@huaweicloud.com>
Date: Thu, 21 Sep 2023 13:16:56 +0000
Message-ID: <mb61pil83k6nr.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Xu Kuohai <xukuohai@huaweicloud.com> writes:

> On 9/17/2023 8:00 AM, Puranjay Mohan wrote:
>> Implement arch_bpf_stack_walk() for the ARM64 JIT. This will be used
>> by bpf_throw() to unwind till the program marked as exception boundary and
>> run the callback with the stack of the main program.
>> 
>> The prologue generation code has been modified to make the callback
>> program use the stack of the program marked as exception boundary where
>> callee-saved registers are already pushed.
>> 
>> As the bpf_throw function never returns, if it clobbers any callee-saved
>> registers, they would remain clobbered. So, the prologue of the
>> exception-boundary program is modified to push R23 and R24 as well,
>> which the callback will then recover in its epilogue.
>> 
>> The Procedure Call Standard for the Arm 64-bit Architecture[1] states
>> that registers r19 to r28 should be saved by the callee. BPF programs on
>> ARM64 already save all callee-saved registers except r23 and r24. This
>> patch adds an instruction in prologue of the  program to save these
>> two registers and another instruction in the epilogue to recover them.
>> 
>> These extra instructions are only added if bpf_throw() used. Otherwise
>> the emitted prologue/epilogue remains unchanged.
>> 
>> [1] https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst
>> 
>> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>> ---
>>   arch/arm64/net/bpf_jit_comp.c                | 98 ++++++++++++++++----
>>   tools/testing/selftests/bpf/DENYLIST.aarch64 |  1 -
>>   2 files changed, 79 insertions(+), 20 deletions(-)
>> 
>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>> index 7d4af64e3982..fcc55e558863 100644
>> --- a/arch/arm64/net/bpf_jit_comp.c
>> +++ b/arch/arm64/net/bpf_jit_comp.c
>> @@ -21,6 +21,7 @@
>>   #include <asm/insn.h>
>>   #include <asm/patching.h>
>>   #include <asm/set_memory.h>
>> +#include <asm/stacktrace.h>
>>   
>>   #include "bpf_jit.h"
>>   
>> @@ -285,7 +286,7 @@ static bool is_lsi_offset(int offset, int scale)
>>   /* Tail call offset to jump into */
>>   #define PROLOGUE_OFFSET (BTI_INSNS + 2 + PAC_INSNS + 8)
>>   
>> -static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
>> +static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf, bool is_exception_cb)
>>   {
>>   	const struct bpf_prog *prog = ctx->prog;
>>   	const bool is_main_prog = !bpf_is_subprog(prog);
>> @@ -333,19 +334,28 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
>>   	emit(A64_MOV(1, A64_R(9), A64_LR), ctx);
>>   	emit(A64_NOP, ctx);
>>   
>> -	/* Sign lr */
>> -	if (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL))
>> -		emit(A64_PACIASP, ctx);
>> -
>> -	/* Save FP and LR registers to stay align with ARM64 AAPCS */
>> -	emit(A64_PUSH(A64_FP, A64_LR, A64_SP), ctx);
>> -	emit(A64_MOV(1, A64_FP, A64_SP), ctx);
>> -
>> -	/* Save callee-saved registers */
>> -	emit(A64_PUSH(r6, r7, A64_SP), ctx);
>> -	emit(A64_PUSH(r8, r9, A64_SP), ctx);
>> -	emit(A64_PUSH(fp, tcc, A64_SP), ctx);
>> -	emit(A64_PUSH(fpb, A64_R(28), A64_SP), ctx);
>> +	if (!is_exception_cb) {
>> +		/* Sign lr */
>> +		if (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL))
>> +			emit(A64_PACIASP, ctx);
>> +		/* Save FP and LR registers to stay align with ARM64 AAPCS */
>> +		emit(A64_PUSH(A64_FP, A64_LR, A64_SP), ctx);
>> +		emit(A64_MOV(1, A64_FP, A64_SP), ctx);
>> +
>> +		/* Save callee-saved registers */
>> +		emit(A64_PUSH(r6, r7, A64_SP), ctx);
>> +		emit(A64_PUSH(r8, r9, A64_SP), ctx);
>> +		emit(A64_PUSH(fp, tcc, A64_SP), ctx);
>> +		emit(A64_PUSH(fpb, A64_R(28), A64_SP), ctx);
>> +	} else {
>> +		/* Exception callback receives FP of Main Program as third parameter */
>> +		emit(A64_MOV(1, A64_FP, A64_R(2)), ctx);
>> +		/*
>> +		 * Main Program already pushed the frame record and the callee-saved registers. The
>> +		 * exception callback will not push anything and re-use the main program's stack.
>> +		 */
>> +		emit(A64_SUB_I(1, A64_SP, A64_FP, 80), ctx); /* 10 registers are on the stack */
>
> To ensure th calculated A6_SP is always correct, add an assertion
> to ensure the distance between A64_FP and A64_SP is 80 after all
> callee-registers are pushed to the stack?
>

I agree that this should be done. Can you give an example how this
should be implemented? 

>> +	}
>>   
>>   	/* Set up BPF prog stack base register */
>>   	emit(A64_MOV(1, fp, A64_SP), ctx);
>> @@ -365,6 +375,13 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
>>   		emit_bti(A64_BTI_J, ctx);
>>   	}
>>   
>> +	/*
>> +	 * Program acting as exception boundary should save all ARM64 Callee-saved registers as the
>> +	 * exception callback needs to recover all ARM64 Callee-saved registers in its epilogue.
>> +	 */
>> +	if (prog->aux->exception_boundary)
>> +		emit(A64_PUSH(A64_R(23), A64_R(24), A64_SP), ctx);
>
> Blindly storing x23/x24 to BPF_FP -8/16 is incorrect, as the stack
> space below BPF_FP might be written with other values by the bpf
> prog.
>

Thanks for pointing this out. I will set fp = A64_SP - 16 so to allocate
space for saving x23/x24. And I will take care while poping back in the epilogue.

>> +
>>   	emit(A64_SUB_I(1, fpb, fp, ctx->fpb_offset), ctx);
>>   
>>   	/* Stack must be multiples of 16B */
>> @@ -653,7 +670,7 @@ static void build_plt(struct jit_ctx *ctx)
>>   		plt->target = (u64)&dummy_tramp;
>>   }
>>   
>> -static void build_epilogue(struct jit_ctx *ctx)
>> +static void build_epilogue(struct jit_ctx *ctx, bool is_exception_cb)
>>   {
>>   	const u8 r0 = bpf2a64[BPF_REG_0];
>>   	const u8 r6 = bpf2a64[BPF_REG_6];
>> @@ -666,6 +683,14 @@ static void build_epilogue(struct jit_ctx *ctx)
>>   	/* We're done with BPF stack */
>>   	emit(A64_ADD_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
>>   
>> +	/*
>> +	 * Program acting as exception boundary pushes R23 and R24 in addition to BPF callee-saved
>> +	 * registers. Exception callback uses the boundary program's stack frame, so recover these
>
> Keep the line width within 80 characters?

bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column warning")
removed the warning so I started using 100 character lines.

>
>> +	 * extra registers in the above two cases.
>> +	 */
>> +	if (ctx->prog->aux->exception_boundary || is_exception_cb)
>> +		emit(A64_POP(A64_R(23), A64_R(24), A64_SP), ctx);
>> +
>>   	/* Restore x27 and x28 */
>>   	emit(A64_POP(fpb, A64_R(28), A64_SP), ctx);
>>   	/* Restore fs (x25) and x26 */
>> @@ -1575,7 +1600,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>   	 * BPF line info needs ctx->offset[i] to be the offset of
>>   	 * instruction[i] in jited image, so build prologue first.
>>   	 */
>> -	if (build_prologue(&ctx, was_classic)) {
>> +	if (build_prologue(&ctx, was_classic, prog->aux->exception_cb)) {
>>   		prog = orig_prog;
>>   		goto out_off;
>>   	}
>> @@ -1586,7 +1611,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>   	}
>>   
>>   	ctx.epilogue_offset = ctx.idx;
>> -	build_epilogue(&ctx);
>> +	build_epilogue(&ctx, prog->aux->exception_cb);
>>   	build_plt(&ctx);
>>   
>>   	extable_align = __alignof__(struct exception_table_entry);
>> @@ -1614,7 +1639,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>   	ctx.idx = 0;
>>   	ctx.exentry_idx = 0;
>>   
>> -	build_prologue(&ctx, was_classic);
>> +	build_prologue(&ctx, was_classic, prog->aux->exception_cb);
>>   
>>   	if (build_body(&ctx, extra_pass)) {
>>   		bpf_jit_binary_free(header);
>> @@ -1622,7 +1647,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>   		goto out_off;
>>   	}
>>   
>> -	build_epilogue(&ctx);
>> +	build_epilogue(&ctx, prog->aux->exception_cb);
>>   	build_plt(&ctx);
>>   
>>   	/* 3. Extra pass to validate JITed code. */
>> @@ -2286,3 +2311,38 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
>>   
>>   	return ret;
>>   }
>> +
>> +bool bpf_jit_supports_exceptions(void)
>> +{
>> +	/* We unwind through both kernel frames (starting from within bpf_throw call) and
>> +	 * BPF frames. Therefore we require FP unwinder to be enabled to walk kernel frames and
>> +	 * reach BPF frames in the stack trace.
>> +	 * ARM64 kernel is aways compiled with CONFIG_FRAME_POINTER=y
>> +	 */
>> +	return true;
>> +}
>> +
>> +void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie)
>> +{
>> +	struct stack_info stacks[] = {
>> +		stackinfo_get_task(current),
>> +	};
>> +
>
> Seems there is no need to define "stacks" as an array

Sure, will change in next version.

>
>> +	struct unwind_state state = {
>> +		.stacks = stacks,
>> +		.nr_stacks = ARRAY_SIZE(stacks),
>> +	};
>> +	unwind_init_common(&state, current);
>> +	state.fp = (unsigned long)__builtin_frame_address(1);
>> +	state.pc = (unsigned long)__builtin_return_address(0);
>> +
>> +	if (unwind_next_frame_record(&state))
>> +		return;
>> +	while (1) {
>> +		/* We only use the fp in the exception callback. Pass 0 for sp as it's unavailable*/
>> +		if (!consume_fn(cookie, (u64)state.pc, 0, (u64)state.fp))
>> +			break;
>> +		if (unwind_next_frame_record(&state))
>
> When PTR_AUTH is implemented, lr is encoded before being pushed to
> the stack, but unwind_next_frame_record() does not decode state.pc
> when fetching it from the stack.

Thanks for pointing this out. I will fix this in the next version.

>> +			break;
>> +	}
>
> And it's better to simplify the if-while(1)-if to:
>
> while (!unwind_next_frame_record(&state)) {
>      ...
> }

Sure,
Will use this method in the next version.

>
>> +}
>> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
>> index f5065576cae9..7f768d335698 100644
>> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
>> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
>> @@ -1,6 +1,5 @@
>>   bpf_cookie/multi_kprobe_attach_api               # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
>>   bpf_cookie/multi_kprobe_link_api                 # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
>> -exceptions					 # JIT does not support calling kfunc bpf_throw: -524
>>   fexit_sleep                                      # The test never returns. The remaining tests cannot start.
>>   kprobe_multi_bench_attach                        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
>>   kprobe_multi_test/attach_api_addrs               # bpf_program__attach_kprobe_multi_opts unexpected error: -95


Thanks,
Puranjay

