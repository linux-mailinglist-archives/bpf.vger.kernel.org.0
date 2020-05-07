Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B1E1C9BE4
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 22:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgEGUPa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 16:15:30 -0400
Received: from www62.your-server.de ([213.133.104.62]:33352 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgEGUP3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 May 2020 16:15:29 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jWmvV-0008H6-73; Thu, 07 May 2020 22:15:25 +0200
Received: from [178.195.186.98] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jWmvU-0008Ko-RK; Thu, 07 May 2020 22:15:24 +0200
Subject: Re: [PATCH v3 05/11] arm64: bpf: Annotate JITed code for BTI
To:     Mark Brown <broonie@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Amit Kachhap <amit.kachhap@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        bpf@vger.kernel.org
References: <20200506195138.22086-1-broonie@kernel.org>
 <20200506195138.22086-6-broonie@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4da1f963-87ef-990e-00aa-d6de9c44207c@iogearbox.net>
Date:   Thu, 7 May 2020 22:15:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200506195138.22086-6-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25805/Thu May  7 14:14:46 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[ Cc +bpf ]

On 5/6/20 9:51 PM, Mark Brown wrote:
> In order to extend the protection offered by BTI to all code executing in
> kernel mode we need to annotate JITed BPF code appropriately for BTI. To
> do this we need to add a landing pad to the start of each BPF function and
> also immediately after the function prologue if we are emitting a function
> which can be tail called. Jumps within BPF functions are all to immediate
> offsets and therefore do not require landing pads.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

> ---
>   arch/arm64/net/bpf_jit.h      |  8 ++++++++
>   arch/arm64/net/bpf_jit_comp.c | 12 ++++++++++++
>   2 files changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
> index eb73f9f72c46..05b477709b5f 100644
> --- a/arch/arm64/net/bpf_jit.h
> +++ b/arch/arm64/net/bpf_jit.h
> @@ -189,4 +189,12 @@
>   /* Rn & Rm; set condition flags */
>   #define A64_TST(sf, Rn, Rm) A64_ANDS(sf, A64_ZR, Rn, Rm)
>   
> +/* HINTs */
> +#define A64_HINT(x) aarch64_insn_gen_hint(x)
> +
> +/* BTI */
> +#define A64_BTI_C  A64_HINT(AARCH64_INSN_HINT_BTIC)
> +#define A64_BTI_J  A64_HINT(AARCH64_INSN_HINT_BTIJ)
> +#define A64_BTI_JC A64_HINT(AARCH64_INSN_HINT_BTIJC)
> +
>   #endif /* _BPF_JIT_H */
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index cdc79de0c794..83fa475c6b42 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -171,7 +171,11 @@ static inline int epilogue_offset(const struct jit_ctx *ctx)
>   #define STACK_ALIGN(sz) (((sz) + 15) & ~15)
>   
>   /* Tail call offset to jump into */
> +#if IS_ENABLED(CONFIG_ARM64_BTI_KERNEL)
> +#define PROLOGUE_OFFSET 8
> +#else
>   #define PROLOGUE_OFFSET 7
> +#endif
>   
>   static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
>   {
> @@ -208,6 +212,10 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
>   	 *
>   	 */
>   
> +	/* BTI landing pad */
> +	if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL))
> +		emit(A64_BTI_C, ctx);
> +
>   	/* Save FP and LR registers to stay align with ARM64 AAPCS */
>   	emit(A64_PUSH(A64_FP, A64_LR, A64_SP), ctx);
>   	emit(A64_MOV(1, A64_FP, A64_SP), ctx);
> @@ -230,6 +238,10 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
>   				    cur_offset, PROLOGUE_OFFSET);
>   			return -1;
>   		}
> +
> +		/* BTI landing pad for the tail call, done with a BR */
> +		if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL))
> +			emit(A64_BTI_J, ctx);
>   	}
>   
>   	ctx->stack_size = STACK_ALIGN(prog->aux->stack_depth);
> 

