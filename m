Return-Path: <bpf+bounces-71287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63264BEDDB2
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 04:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D054718A1E68
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 02:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323D21DE8AD;
	Sun, 19 Oct 2025 02:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MSZ/LYOY"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AEA1369B4
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 02:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760839427; cv=none; b=taLiDXgojGEo9Za7fI+DUfED2tDNXHowzOXDNi4zhC8sc7B+hG3jL96oOPqiDjOifBAKIdl2J1i6IqIqXAOZcLKOdEVrqJ2F0ExXFhGius3HKuthJjN0u9alDI+huhvUZVvNo54waxN8NTDeCm6VROffJf6lYe/rhtkHm4VuJm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760839427; c=relaxed/simple;
	bh=DnvOKalVAVTmP151v/ZOmkEW3cLfcyqfzYbgYMRFUtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gY8REETm1jojNo4XJQLR6pB1eGuzgg6ytc0RSg3C9dRqg3EZ9mEyh0o8t3pB12EDADo+KHdykrI1+A1RgOn93IYPxUgZOq3DAtaStcEQFXCy44jJ7f+wEpDT5eFfDsLfsl/RPNIhpiZSBX4wxKWmponDnTo9NImqGi0Wnhpp4a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MSZ/LYOY; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760839422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZyruvAclY3XxcYUgR0c6gPD3I5WTfaEJbImoUXKt9o=;
	b=MSZ/LYOYqKz/xl0FKiuovLN+VhzedBMrN8knRkbEugO2Nq4D2r6rWq0ofe+lAvhLCUnWCj
	47GCtPelO7PehfBd7dDS3i5+C5yC64hyicB6GQVWJPVSesHi5NYp3L6ImUvz8q9s9sMhcV
	TeM6rxCe7UhUIQT4OepNoO64XC7vIAs=
From: Menglong Dong <menglong.dong@linux.dev>
To: ast@kernel.org, jolsa@kernel.org, Menglong Dong <menglong8.dong@gmail.com>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, mattbobrowski@google.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, leon.hwang@linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject:
 Re: [PATCH RFC bpf-next 3/5] bpf,x86: add tracing session supporting for
 x86_64
Date: Sun, 19 Oct 2025 10:03:31 +0800
Message-ID: <12764740.O9o76ZdvQC@7950hx>
In-Reply-To: <20251018142124.783206-4-dongml2@chinatelecom.cn>
References:
 <20251018142124.783206-1-dongml2@chinatelecom.cn>
 <20251018142124.783206-4-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/10/18 22:21, Menglong Dong wrote:
> Add BPF_TRACE_SESSION supporting to x86_64. invoke_bpf_session_entry and
> invoke_bpf_session_exit is introduced for this purpose.
> 
> In invoke_bpf_session_entry(), we will check if the return value of the
> fentry is 0, and clear the corresponding flag if not. And in
> invoke_bpf_session_exit(), we will check if the corresponding flag is
> set. If not set, the fexit will be skipped.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  arch/x86/net/bpf_jit_comp.c | 115 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 114 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index d4c93d9e73e4..0586b96ed529 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3108,6 +3108,97 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
>  	return 0;
>  }
>  
> +static int invoke_bpf_session_entry(const struct btf_func_model *m, u8 **pprog,
> +				    struct bpf_tramp_links *tl, int stack_size,
> +				    int run_ctx_off, int session_off,
> +				    void *image, void *rw_image)
> +{
> +	u64 session_flags;
> +	u8 *prog = *pprog;
> +	u8 *jmp_insn;
> +	int i;
> +
> +	/* clear the session flags:
> +	 *
> +	 *   xor rax, rax
> +	 *   mov QWORD PTR [rbp - session_off], rax
> +	 */
> +	EMIT3(0x48, 0x31, 0xC0);
> +	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -session_off);
> +
> +	for (i = 0; i < tl->nr_links; i++) {
> +		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size, run_ctx_off, true,
> +				    image, rw_image))
> +			return -EINVAL;
> +
> +		/* fentry prog stored return value into [rbp - 8]. Emit:
> +		 * if (*(u64 *)(rbp - 8) !=  0)
> +		 *	*(u64 *)(rbp - session_off) |= (1 << (i + 1));
> +		 */
> +		/* cmp QWORD PTR [rbp - 0x8], 0x0 */
> +		EMIT4(0x48, 0x83, 0x7d, 0xf8); EMIT1(0x00);
> +		/* emit 2 nops that will be replaced with JE insn */
> +		jmp_insn = prog;
> +		emit_nops(&prog, 2);
> +
> +		session_flags = (1ULL << (i + 1));
> +		/* mov rax, $session_flags */
> +		emit_mov_imm64(&prog, BPF_REG_0, session_flags >> 32, (u32) session_flags);
> +		/* or QWORD PTR [rbp - session_off], rax */
> +		EMIT2(0x48, 0x09);
> +		emit_insn_suffix(&prog, BPF_REG_FP, BPF_REG_0, -session_off);
> +
> +		jmp_insn[0] = X86_JE;
> +		jmp_insn[1] = prog - jmp_insn - 2;
> +	}
> +
> +	*pprog = prog;
> +	return 0;
> +}
> +
> +static int invoke_bpf_session_exit(const struct btf_func_model *m, u8 **pprog,
> +				   struct bpf_tramp_links *tl, int stack_size,
> +				   int run_ctx_off, int session_off,
> +				   void *image, void *rw_image)
> +{
> +	u64 session_flags;
> +	u8 *prog = *pprog;
> +	u8 *jmp_insn;
> +	int i;
> +
> +	/* set the bpf_trace_is_exit flag to the session flags */
> +	/* mov rax, 1 */
> +	emit_mov_imm32(&prog, false, BPF_REG_0, 1);
> +	/* or QWORD PTR [rbp - session_off], rax */
> +	EMIT2(0x48, 0x09);
> +	emit_insn_suffix(&prog, BPF_REG_FP, BPF_REG_0, -session_off);
> +
> +	for (i = 0; i < tl->nr_links; i++) {
> +		/* check if (1 << (i+1)) is set in the session flags, and
> +		 * skip the execution of the fexit program if it is.
> +		 */
> +		session_flags = 1ULL << (i + 1);
> +		/* mov rax, $session_flags */
> +		emit_mov_imm64(&prog, BPF_REG_1, session_flags >> 32, (u32) session_flags);
> +		/* test QWORD PTR [rbp - session_off], rax */
> +		EMIT2(0x48, 0x85);
> +		emit_insn_suffix(&prog, BPF_REG_FP, BPF_REG_1, -session_off);
> +		/* emit 2 nops that will be replaced with JE insn */
> +		jmp_insn = prog;
> +		emit_nops(&prog, 2);
> +
> +		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size, run_ctx_off, false,
> +				    image, rw_image))
> +			return -EINVAL;
> +
> +		jmp_insn[0] = X86_JNE;
> +		jmp_insn[1] = prog - jmp_insn - 2;
> +	}
> +
> +	*pprog = prog;
> +	return 0;
> +}
> +
>  /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
>  #define LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack)	\
>  	__LOAD_TCC_PTR(-round_up(stack, 8) - 8)
> @@ -3179,8 +3270,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>  					 void *func_addr)
>  {
>  	int i, ret, nr_regs = m->nr_args, stack_size = 0;
> -	int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_off;
> +	int regs_off, nregs_off, session_off, ip_off, run_ctx_off,
> +	    arg_stack_off, rbx_off;
>  	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
> +	struct bpf_tramp_links *session = &tlinks[BPF_TRAMP_SESSION];
>  	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
>  	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
>  	void *orig_call = func_addr;
> @@ -3222,6 +3315,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>  	 *
>  	 * RBP - nregs_off [ regs count	     ]  always
>  	 *
> +	 * RBP - session_off [ session flags ] tracing session
> +	 *
>  	 * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
>  	 *
>  	 * RBP - rbx_off   [ rbx value       ]  always
> @@ -3246,6 +3341,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>  	/* regs count  */
>  	stack_size += 8;
>  	nregs_off = stack_size;
> +	stack_size += 8;
> +	session_off = stack_size;

Oops, this break bpf_get_func_ip(), which will get the ip with ctx[-2].
I'll introduce a "bpf_get_func_ip_proto_tracing_session" to fix it.

>  
>  	if (flags & BPF_TRAMP_F_IP_ARG)
>  		stack_size += 8; /* room for IP address argument */
> @@ -3345,6 +3442,13 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>  			return -EINVAL;
>  	}
>  
> +	if (session->nr_links) {
> +		if (invoke_bpf_session_entry(m, &prog, session, regs_off,
> +					     run_ctx_off, session_off,
> +					     image, rw_image))
> +			return -EINVAL;
> +	}
> +
>  	if (fmod_ret->nr_links) {
>  		branches = kcalloc(fmod_ret->nr_links, sizeof(u8 *),
>  				   GFP_KERNEL);
> @@ -3409,6 +3513,15 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>  		}
>  	}
>  
> +	if (session->nr_links) {
> +		if (invoke_bpf_session_exit(m, &prog, session, regs_off,
> +					    run_ctx_off, session_off,
> +					    image, rw_image)) {
> +			ret = -EINVAL;
> +			goto cleanup;
> +		}
> +	}
> +
>  	if (flags & BPF_TRAMP_F_RESTORE_REGS)
>  		restore_regs(m, &prog, regs_off);
>  
> 





