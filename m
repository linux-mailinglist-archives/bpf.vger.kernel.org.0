Return-Path: <bpf+bounces-8077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F255F780F1D
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 17:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208E01C21639
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 15:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F23318C39;
	Fri, 18 Aug 2023 15:26:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101AB182BC
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 15:26:07 +0000 (UTC)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F644233
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 08:25:53 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-565e395e7a6so712834a12.0
        for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 08:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692372353; x=1692977153;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2WQoU+4CByFDA8zzn9kyprCGPUh61gwFElSSl+b2OUM=;
        b=UMh3yrzlerg6Q1UDqQPAjxidatsTau0peWiYlac8x8UcLq3HBf9r2gV6i11wT/43Pe
         Cu9eddOmA9u58SZAjtWiUeAzUur+34jJipSH7XjNos8Y0uvUomn620OnSKvs7pQaS1kG
         Lf8WfAgpp136cfFeIvsISU4nfNG/GH9RNmoEWStwdbO2Zmont1SILyQKcHoUiUBPcIbI
         gyTAD8Udwv68MMxDM9mrVq2PSBLPXfSZu6Pda0JnEE83umC/b1MTmbEQpIyCAC4CtVQr
         Ll2vAyDVEwrfE8IPyM+luBYMzLcQ1tUF10Q/rBc1718apez+eRgdeMyc/BBj7L0cpMHA
         d3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692372353; x=1692977153;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2WQoU+4CByFDA8zzn9kyprCGPUh61gwFElSSl+b2OUM=;
        b=FeA9eOdq9LyW46t2qp1aNJ8BZu8JOlmc3gVBFruSTrr05hWz+Ou/D72sDv/oTc4E0P
         h7GYCgNb1SQMOQ7Z0YiWxwNoH6S1Y53JSgBWvCsYu66oXxmNn3SyuhpSPOXgV4m8UFbl
         4o1JQqWc6LzOKzQBigkHNxbDjqd6GMFDdtq/wcbjvOcojET3xO7UiVVn28RbdIMUI4aL
         KnneAjA6lIuzVTLAqwQgWO6R/bQETqWJzt5jaEqZCEBGIk+GqYnPEEvwjDaJ8WrDJuf8
         qTnWGTl2dV8rK+UAAfVZmKcanE6w9SLc5t8m6/rHQCygo3LKGrWscbL2eacYWFpbV7bA
         YBSA==
X-Gm-Message-State: AOJu0YwnW8CsAW1xud9j+xlZ6YM/2K0Uhu3ZZbntO5snOeJQEfeNw9Oq
	agX/B1T5O0KxLOa6YNYsdbs=
X-Google-Smtp-Source: AGHT+IFVqPTAQvH076Amgg+sB0bgiDLtH8DS00lcy6lHF9agHV+erMe/mgWbXCDtPXwEfwrM7R3zZQ==
X-Received: by 2002:a05:6a20:a10b:b0:13e:6447:ce45 with SMTP id q11-20020a056a20a10b00b0013e6447ce45mr3646311pzk.43.1692372352830;
        Fri, 18 Aug 2023 08:25:52 -0700 (PDT)
Received: from [192.168.1.12] (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id x9-20020a656aa9000000b00563ea47c948sm1544916pgu.53.2023.08.18.08.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 08:25:52 -0700 (PDT)
Message-ID: <496ea544-5d7a-6c32-9295-8a1fe75a8344@gmail.com>
Date: Fri, 18 Aug 2023 23:25:49 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH bpf-next v2 1/2] bpf, x64: Fix tailcall infinite loop
Content-Language: en-US
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 maciej.fijalkowski@intel.com
Cc: song@kernel.org, bpf@vger.kernel.org
References: <20230818151216.7686-1-hffilwlqm@gmail.com>
 <20230818151216.7686-2-hffilwlqm@gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <20230818151216.7686-2-hffilwlqm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/18 23:12, Leon Hwang wrote:
> From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailcall
> handling in JIT"), the tailcall on x64 works better than before.
> 
> From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF subprograms
> for x64 JIT"), tailcall is able to run in BPF subprograms on x64.
> 
> From commit 5b92a28aae4dd0f8 ("bpf: Support attaching tracing BPF program
> to other BPF programs"), BPF program is able to trace other BPF programs.
> 
> How about combining them all together?
> 
> 1. FENTRY/FEXIT on a BPF subprogram.
> 2. A tailcall runs in the BPF subprogram.
> 3. The tailcall calls itself.
> 
> As a result, a tailcall infinite loop comes up. And the loop would halt
> the machine.
> 
> As we know, in tail call context, the tail_call_cnt propagates by stack
> and RAX register between BPF subprograms. So do it in trampolines.
> 
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 40 +++++++++++++++++++++++++++++--------
>  include/linux/bpf.h         |  5 +++++
>  kernel/bpf/trampoline.c     |  4 ++--
>  kernel/bpf/verifier.c       | 31 +++++++++++++++++++++-------
>  4 files changed, 63 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index a5930042139d3..1ad17d7de5eee 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -303,8 +303,12 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>  	prog += X86_PATCH_SIZE;
>  	if (!ebpf_from_cbpf) {
>  		if (tail_call_reachable && !is_subprog)
> +			/* When it's the entry of the whole tailcall context,
> +			 * zeroing rax means initialising tail_call_cnt.
> +			 */
>  			EMIT2(0x31, 0xC0); /* xor eax, eax */
>  		else
> +			// Keep the same instruction layout.
>  			EMIT2(0x66, 0x90); /* nop2 */
>  	}
>  	EMIT1(0x55);             /* push rbp */
> @@ -1018,6 +1022,10 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
>  
>  #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
>  
> +/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
> +#define RESTORE_TAIL_CALL_CNT(stack)				\
> +	EMIT3_off32(0x48, 0x8B, 0x85, -round_up(stack, 8) - 8)
> +
>  static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
>  		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
>  {
> @@ -1623,9 +1631,7 @@ st:			if (is_imm8(insn->off))
>  
>  			func = (u8 *) __bpf_call_base + imm32;
>  			if (tail_call_reachable) {
> -				/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
> -				EMIT3_off32(0x48, 0x8B, 0x85,
> -					    -round_up(bpf_prog->aux->stack_depth, 8) - 8);
> +				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
>  				if (!imm32)
>  					return -EINVAL;
>  				offs = 7 + x86_call_depth_emit_accounting(&prog, func);
> @@ -2298,7 +2304,9 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
>   * push rbp
>   * mov rbp, rsp
>   * sub rsp, 16                     // space for skb and dev
> - * push rbx                        // temp regs to pass start time
> + * mov qword ptr [rbp - 40], rbx   // temp regs to pass start time
> + * mov rax, 2                      // cache number of argument to rax
> + * mov qword ptr [rbp - 32], rax   // save number of argument to stack
>   * mov qword ptr [rbp - 16], rdi   // save skb pointer to stack
>   * mov qword ptr [rbp - 8], rsi    // save dev pointer to stack
>   * call __bpf_prog_enter           // rcu_read_lock and preempt_disable
> @@ -2323,7 +2331,9 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
>   * push rbp
>   * mov rbp, rsp
>   * sub rsp, 24                     // space for skb, dev, return value
> - * push rbx                        // temp regs to pass start time
> + * mov qword ptr [rbp - 40], rbx   // temp regs to pass start time
> + * mov rax, 2                      // cache number of argument to rax
> + * mov qword ptr [rbp - 32], rax   // save number of argument to stack
>   * mov qword ptr [rbp - 24], rdi   // save skb pointer to stack
>   * mov qword ptr [rbp - 16], rsi   // save dev pointer to stack
>   * call __bpf_prog_enter           // rcu_read_lock and preempt_disable
> @@ -2400,6 +2410,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>  	 *                     [ ...        ]
>  	 *                     [ stack_arg2 ]
>  	 * RBP - arg_stack_off [ stack_arg1 ]
> +	 * RSP                 [ tail_call_cnt ] BPF_TRAMP_F_TAIL_CALL_CTX
>  	 */
>  
>  	/* room for return value of orig_call or fentry prog */
> @@ -2464,6 +2475,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>  	else
>  		/* sub rsp, stack_size */
>  		EMIT4(0x48, 0x83, 0xEC, stack_size);
> +	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
> +		EMIT1(0x50);		/* push rax */
>  	/* mov QWORD PTR [rbp - rbx_off], rbx */
>  	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
>  
> @@ -2516,9 +2529,15 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>  		restore_regs(m, &prog, regs_off);
>  		save_args(m, &prog, arg_stack_off, true);
>  
> +		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
> +			/* Before calling the original function, restore the
> +			 * tail_call_cnt from stack to rax.
> +			 */
> +			RESTORE_TAIL_CALL_CNT(stack_size);
> +
>  		if (flags & BPF_TRAMP_F_ORIG_STACK) {
> -			emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
> -			EMIT2(0xff, 0xd0); /* call *rax */
> +			emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, 8);
> +			EMIT2(0xff, 0xd3); /* call *rbx */ // FIXME: Confirm 0xd3?

To avoiding rax conflict with tail call, change the calling register
from rax to rbx

But, I'm unable to confirm the opcode.

Then, I asked chatGPT to list `call` and corresponding opcode:

Certainly! Here's a table that provides `call` instructions along with
their corresponding opcodes in x86-64 assembly:

| `call` Register | Opcode (Hex) | Opcode (Binary) |
|-----------------|--------------|-----------------|
| `rax`           | `FF D0`      | `11111111 11010000` |
| `rcx`           | `FF D1`      | `11111111 11010001` |
| `rdx`           | `FF D2`      | `11111111 11010010` |
| `rbx`           | `FF D3`      | `11111111 11010011` |
| `rsp`           | `FF D4`      | `11111111 11010100` |
| `rbp`           | `FF D5`      | `11111111 11010101` |
| `rsi`           | `FF D6`      | `11111111 11010110` |
| `rdi`           | `FF D7`      | `11111111 11010111` |
| `r8`            | `41 FF D0`   | `01000001 11111111 11010000` |
| `r9`            | `41 FF D1`   | `01000001 11111111 11010001` |
| `r10`           | `41 FF D2`   | `01000001 11111111 11010010` |
| `r11`           | `41 FF D3`   | `01000001 11111111 11010011` |
| `r12`           | `41 FF D4`   | `01000001 11111111 11010100` |
| `r13`           | `41 FF D5`   | `01000001 11111111 11010101` |
| `r14`           | `41 FF D6`   | `01000001 11111111 11010110` |
| `r15`           | `41 FF D7`   | `01000001 11111111 11010111` |

EMIT2(0xff, 0xd3); /* call *rbx */, is it right?

Thanks,
Leon

[...]

