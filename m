Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7B666027B
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 15:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjAFOtK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 09:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjAFOtH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 09:49:07 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA202669;
        Fri,  6 Jan 2023 06:49:05 -0800 (PST)
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pDnzC-000CSH-FZ; Fri, 06 Jan 2023 15:46:22 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pDnzB-000KKs-Uf; Fri, 06 Jan 2023 15:46:21 +0100
Subject: Re: [PATCH bpf-next v4] bpf: Add kernel function call support in
 32-bit ARM for EABI
To:     Yang Jihong <yangjihong1@huawei.com>, ast@kernel.org,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        illusionist.neo@gmail.com, linux@armlinux.org.uk,
        bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221220115313.29949-1-yangjihong1@huawei.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Florent Revest <revest@chromium.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <02a9bfb2-4a75-d56f-4565-6ce5ea5e03c4@iogearbox.net>
Date:   Fri, 6 Jan 2023 15:46:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20221220115313.29949-1-yangjihong1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26773/Fri Jan  6 09:48:44 2023)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/20/22 12:53 PM, Yang Jihong wrote:
> This patch adds kernel function call support to 32-bit ARM bpf jit for
> EABI.
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
> 
> Changes since v3:
>    - Submit patches related to the ARM32 architecture separately.
> 
> Changes since v2:
>    - Remove patches to adjust sk size check for CO_RE in 32-bit arch.
>    - Add check of kfunc's return value in insn_def_regno.
>    - Adjust is_reg64 for insn_def_regno.
>    - The check of CONFIG_AEABI is moved from emit_kfunc_call to
>      bpf_jit_supports_kfunc_call.
>    - Fix a comment error in fixup_kfunc_call.
> 
>   arch/arm/net/bpf_jit_32.c | 137 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 137 insertions(+)
> 
> diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
> index 6a1c9fca5260..ae3a36d909f4 100644
> --- a/arch/arm/net/bpf_jit_32.c
> +++ b/arch/arm/net/bpf_jit_32.c
> @@ -1337,6 +1337,125 @@ static void build_epilogue(struct jit_ctx *ctx)
>   #endif
>   }
>   
> +/*
> + * Input parameters of function in 32-bit ARM architecture:
> + * The first four word-sized parameters passed to a function will be
> + * transferred in registers R0-R3. Sub-word sized arguments, for example,
> + * char, will still use a whole register.
> + * Arguments larger than a word will be passed in multiple registers.
> + * If more arguments are passed, the fifth and subsequent words will be passed
> + * on the stack.
> + *
> + * The first for args of a function will be considered for
> + * putting into the 32bit register R1, R2, R3 and R4.
> + *
> + * Two 32bit registers are used to pass a 64bit arg.
> + *
> + * For example,
> + * void foo(u32 a, u32 b, u32 c, u32 d, u32 e):
> + *      u32 a: R0
> + *      u32 b: R1
> + *      u32 c: R2
> + *      u32 d: R3
> + *      u32 e: stack
> + *
> + * void foo(u64 a, u32 b, u32 c, u32 d):
> + *      u64 a: R0 (lo32) R1 (hi32)
> + *      u32 b: R2
> + *      u32 c: R3
> + *      u32 d: stack
> + *
> + * void foo(u32 a, u64 b, u32 c, u32 d):
> + *       u32 a: R0
> + *       u64 b: R2 (lo32) R3 (hi32)
> + *       u32 c: stack
> + *       u32 d: stack
> + *
> + * void foo(u32 a, u32 b, u64 c, u32 d):
> + *       u32 a: R0
> + *       u32 b: R1
> + *       u64 c: R2 (lo32) R3 (hi32)
> + *       u32 d: stack
> + *
> + * void foo(u64 a, u64 b):
> + *       u64 a: R0 (lo32) R1 (hi32)
> + *       u64 b: R2 (lo32) R3 (hi32)
> + *
> + * The return value will be stored in the R0 (and R1 for 64bit value).
> + *
> + * For example,
> + * u32 foo(u32 a, u32 b, u32 c):
> + *      return value: R0
> + *
> + * u64 foo(u32 a, u32 b, u32 c):
> + *      return value: R0 (lo32) R1 (hi32)
> + *
> + * The above is for AEABI only, OABI does not support this function.
> + */
> +static int emit_kfunc_call(const struct bpf_insn *insn, struct jit_ctx *ctx, const u32 func)
> +{
> +	int i;
> +	const struct btf_func_model *fm;
> +	const s8 *tmp = bpf2a32[TMP_REG_1];
> +	const u8 arg_regs[] = { ARM_R0, ARM_R1, ARM_R2, ARM_R3 };
> +	int nr_arg_regs = ARRAY_SIZE(arg_regs);
> +	int arg_regs_idx = 0, stack_off = 0;
> +	const s8 *rd;
> +	s8 rt;
> +
> +	fm = bpf_jit_find_kfunc_model(ctx->prog, insn);
> +	if (!fm)
> +		return -EINVAL;
> +
> +	for (i = 0; i < fm->nr_args; i++) {
> +		if (fm->arg_size[i] > sizeof(u32)) {
> +			rd = arm_bpf_get_reg64(bpf2a32[BPF_REG_1 + i], tmp, ctx);
> +
> +			if (arg_regs_idx + 1 < nr_arg_regs) {
> +				/*
> +				 * AAPCS states:
> +				 * A double-word sized type is passed in two
> +				 * consecutive registers (e.g., r0 and r1, or
> +				 * r2 and r3). The content of the registers is
> +				 * as if the value had been loaded from memory
> +				 * representation with a single LDM instruction.
> +				 */
> +				if (arg_regs_idx & 1)
> +					arg_regs_idx++;
> +
> +				emit(ARM_MOV_R(arg_regs[arg_regs_idx++], rd[1]), ctx);
> +				emit(ARM_MOV_R(arg_regs[arg_regs_idx++], rd[0]), ctx);
> +			} else {
> +				stack_off = ALIGN(stack_off, STACK_ALIGNMENT);
> +
> +				if (__LINUX_ARM_ARCH__ >= 6 ||
> +				    ctx->cpu_architecture >= CPU_ARCH_ARMv5TE) {
> +					emit(ARM_STRD_I(rd[1], ARM_SP, stack_off), ctx);
> +				} else {
> +					emit(ARM_STR_I(rd[1], ARM_SP, stack_off), ctx);
> +					emit(ARM_STR_I(rd[0], ARM_SP, stack_off), ctx);
> +				}
> +
> +				stack_off += 8;
> +			}
> +		} else {
> +			rt = arm_bpf_get_reg32(bpf2a32[BPF_REG_1 + i][1], tmp[1], ctx);
> +
> +			if (arg_regs_idx  < nr_arg_regs) {
> +				emit(ARM_MOV_R(arg_regs[arg_regs_idx++], rt), ctx);
> +			} else {
> +				emit(ARM_STR_I(rt, ARM_SP, stack_off), ctx);
> +				stack_off += 4;
> +			}
> +		}
> +	}
> +
> +	emit_a32_mov_i(tmp[1], func, ctx);
> +	emit_blx_r(tmp[1], ctx);
> +
> +	return 0;
> +}
> +
>   /*
>    * Convert an eBPF instruction to native instruction, i.e
>    * JITs an eBPF instruction.
> @@ -1603,6 +1722,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
>   	case BPF_LDX | BPF_MEM | BPF_H:
>   	case BPF_LDX | BPF_MEM | BPF_B:
>   	case BPF_LDX | BPF_MEM | BPF_DW:
> +	case BPF_LDX | BPF_PROBE_MEM | BPF_W:
> +	case BPF_LDX | BPF_PROBE_MEM | BPF_H:
> +	case BPF_LDX | BPF_PROBE_MEM | BPF_B:
> +	case BPF_LDX | BPF_PROBE_MEM | BPF_DW:

This doesn't look right, why is this part of the patch? It's not kfunc related
and if you plan to add support for ldx_probe_mem then it should be separated from
this set. Check out 800834285361 ("bpf, arm64: Add BPF exception tables"), why is
this not needed for arm32?

>   		rn = arm_bpf_get_reg32(src_lo, tmp2[1], ctx);
>   		emit_ldx_r(dst, rn, off, ctx, BPF_SIZE(code));
>   		break;
> @@ -1785,6 +1908,16 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
>   		const s8 *r5 = bpf2a32[BPF_REG_5];
>   		const u32 func = (u32)__bpf_call_base + (u32)imm;
>   
> +		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
> +			int err;
> +
> +			err = emit_kfunc_call(insn, ctx, func);
> +
> +			if (err)
> +				return err;
> +			break;
> +		}
> +
>   		emit_a32_mov_r64(true, r0, r1, ctx);
>   		emit_a32_mov_r64(true, r1, r2, ctx);
>   		emit_push_r64(r5, ctx);
> @@ -2022,3 +2155,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>   	return prog;
>   }
>   
> +bool bpf_jit_supports_kfunc_call(void)
> +{
> +	return IS_ENABLED(CONFIG_AEABI);
> +}
> 

