Return-Path: <bpf+bounces-277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FA16FD7D2
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 09:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB36281344
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 07:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308E1569D;
	Wed, 10 May 2023 07:07:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB8F19937
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 07:07:06 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18D0618E;
	Wed, 10 May 2023 00:07:03 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QGQvL6p9yzTkQY;
	Wed, 10 May 2023 15:02:22 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 10 May 2023 15:06:59 +0800
Message-ID: <11481869-52a9-037a-c7a4-ebbc7d426229@huawei.com>
Date: Wed, 10 May 2023 15:06:59 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next] arm64,bpf: Support struct arguments in the BPF
 trampoline
Content-Language: en-US
To: Florent Revest <revest@chromium.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<kpsingh@kernel.org>, <mark.rutland@arm.com>, <xukuohai@huaweicloud.com>,
	<zlim.lnx@gmail.com>
References: <20230508164650.3217164-1-revest@chromium.org>
From: Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <20230508164650.3217164-1-revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/9/2023 12:46 AM, Florent Revest wrote:
> This extends the BPF trampoline JIT to support attachment to functions
> that take small structures (up to 128bit) as argument. This is trivially
> achieved by saving/restoring a number of "argument registers" rather
> than a number of arguments.
> 
> The AAPCS64 section 6.8.2 describes the parameter passing ABI.
> "Composite types" (like C structs) below 16 bytes (as enforced by the
> BPF verifier) are provided as part of the 8 argument registers as
> explained in the section C.12.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>   arch/arm64/net/bpf_jit_comp.c                | 51 ++++++++++----------
>   tools/testing/selftests/bpf/DENYLIST.aarch64 |  1 -
>   2 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index b26da8efa616..22e3c456554f 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1731,21 +1731,21 @@ static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
>   	}
>   }
>   
> -static void save_args(struct jit_ctx *ctx, int args_off, int nargs)
> +static void save_args(struct jit_ctx *ctx, int args_off, int nregs)
>   {
>   	int i;
>   
> -	for (i = 0; i < nargs; i++) {
> +	for (i = 0; i < nregs; i++) {
>   		emit(A64_STR64I(i, A64_SP, args_off), ctx);
>   		args_off += 8;
>   	}
>   }
>   
> -static void restore_args(struct jit_ctx *ctx, int args_off, int nargs)
> +static void restore_args(struct jit_ctx *ctx, int args_off, int nregs)
>   {
>   	int i;
>   
> -	for (i = 0; i < nargs; i++) {
> +	for (i = 0; i < nregs; i++) {
>   		emit(A64_LDR64I(i, A64_SP, args_off), ctx);
>   		args_off += 8;
>   	}
> @@ -1764,7 +1764,7 @@ static void restore_args(struct jit_ctx *ctx, int args_off, int nargs)
>    */
>   static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   			      struct bpf_tramp_links *tlinks, void *orig_call,
> -			      int nargs, u32 flags)
> +			      int nregs, u32 flags)
>   {
>   	int i;
>   	int stack_size;
> @@ -1772,7 +1772,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   	int regs_off;
>   	int retval_off;
>   	int args_off;
> -	int nargs_off;
> +	int nregs_off;
>   	int ip_off;
>   	int run_ctx_off;
>   	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
> @@ -1799,7 +1799,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   	 *                  [ ...               ]
>   	 * SP + args_off    [ arg1              ]
>   	 *
> -	 * SP + nargs_off   [ args count        ]
> +	 * SP + nregs_off   [ arg regs count    ]

For description consistency, should arg1 ... argN in the previous
lines also be changed to arg reg 1 ... arg reg N?

>   	 *
>   	 * SP + ip_off      [ traced function   ] BPF_TRAMP_F_IP_ARG flag
>   	 *
> @@ -1816,13 +1816,13 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   	if (flags & BPF_TRAMP_F_IP_ARG)
>   		stack_size += 8;
>   
> -	nargs_off = stack_size;
> +	nregs_off = stack_size;
>   	/* room for args count */
>   	stack_size += 8;
>   
>   	args_off = stack_size;
>   	/* room for args */
> -	stack_size += nargs * 8;
> +	stack_size += nregs * 8;
>   
>   	/* room for return value */
>   	retval_off = stack_size;
> @@ -1865,12 +1865,12 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   		emit(A64_STR64I(A64_R(10), A64_SP, ip_off), ctx);
>   	}
>   
> -	/* save args count*/
> -	emit(A64_MOVZ(1, A64_R(10), nargs, 0), ctx);
> -	emit(A64_STR64I(A64_R(10), A64_SP, nargs_off), ctx);
> +	/* save arg regs count*/
> +	emit(A64_MOVZ(1, A64_R(10), nregs, 0), ctx);
> +	emit(A64_STR64I(A64_R(10), A64_SP, nregs_off), ctx);
>   
> -	/* save args */
> -	save_args(ctx, args_off, nargs);
> +	/* save arg regs */
> +	save_args(ctx, args_off, nregs);
>   
>   	/* save callee saved registers */
>   	emit(A64_STR64I(A64_R(19), A64_SP, regs_off), ctx);
> @@ -1897,7 +1897,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   	}
>   
>   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
> -		restore_args(ctx, args_off, nargs);
> +		restore_args(ctx, args_off, nregs);
>   		/* call original func */
>   		emit(A64_LDR64I(A64_R(10), A64_SP, retaddr_off), ctx);
>   		emit(A64_ADR(A64_LR, AARCH64_INSN_SIZE * 2), ctx);
> @@ -1926,7 +1926,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   	}
>   
>   	if (flags & BPF_TRAMP_F_RESTORE_REGS)
> -		restore_args(ctx, args_off, nargs);
> +		restore_args(ctx, args_off, nregs);
>   
>   	/* restore callee saved register x19 and x20 */
>   	emit(A64_LDR64I(A64_R(19), A64_SP, regs_off), ctx);
> @@ -1967,24 +1967,25 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
>   				void *orig_call)
>   {
>   	int i, ret;
> -	int nargs = m->nr_args;
> +	int nregs = m->nr_args;
>   	int max_insns = ((long)image_end - (long)image) / AARCH64_INSN_SIZE;
>   	struct jit_ctx ctx = {
>   		.image = NULL,
>   		.idx = 0,
>   	};
>   
> -	/* the first 8 arguments are passed by registers */
> -	if (nargs > 8)
> -		return -ENOTSUPP;
> -
> -	/* don't support struct argument */
> +	/* extra registers needed for struct argument */
>   	for (i = 0; i < MAX_BPF_FUNC_ARGS; i++) {
> +		/* The arg_size is at most 16 bytes, enforced by the verifier. */
>   		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
> -			return -ENOTSUPP;
> +			nregs += (m->arg_size[i] + 7) / 8 - 1;
>   	}
>   
> -	ret = prepare_trampoline(&ctx, im, tlinks, orig_call, nargs, flags);
> +	/* the first 8 registers are used for arguments */
> +	if (nregs > 8)
> +		return -ENOTSUPP;
> +
> +	ret = prepare_trampoline(&ctx, im, tlinks, orig_call, nregs, flags);
>   	if (ret < 0)
>   		return ret;
>   
> @@ -1995,7 +1996,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
>   	ctx.idx = 0;
>   
>   	jit_fill_hole(image, (unsigned int)(image_end - image));
> -	ret = prepare_trampoline(&ctx, im, tlinks, orig_call, nargs, flags);
> +	ret = prepare_trampoline(&ctx, im, tlinks, orig_call, nregs, flags);
>   
>   	if (ret > 0 && validate_code(&ctx) < 0)
>   		ret = -EINVAL;
> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
> index cd42e2825bd2..08adc805878b 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> @@ -10,4 +10,3 @@ kprobe_multi_test/link_api_addrs                 # link_fd unexpected link_fd: a
>   kprobe_multi_test/link_api_syms                  # link_fd unexpected link_fd: actual -95 < expected 0
>   kprobe_multi_test/skel_api                       # libbpf: failed to load BPF skeleton 'kprobe_multi': -3
>   module_attach                                    # prog 'kprobe_multi': failed to auto-attach: -95
> -tracing_struct                                   # tracing_struct__attach unexpected error: -524 (errno 524)


