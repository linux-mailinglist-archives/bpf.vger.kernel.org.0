Return-Path: <bpf+bounces-72678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91386C1827D
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 04:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0BDCC349F2D
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 03:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B62A25C838;
	Wed, 29 Oct 2025 03:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gs/C1oZG"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2CD2459ED
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 03:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761707979; cv=none; b=DfjYjFY9jmNZikncMQKsAnltc8KY/rm2g5GCmuDTUI9u/rFBby90Cq9Cktp6fclg0XV0Ub1YIsHbyWcRnRfItXgsbmUCPKD/yaE9FYj0QJar4wSGHN/Yq2Z9ijiQGWkBkyrFnWo8vY6Yv8ENtpjs6gF8zVUJGx+weF/OAzlRICQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761707979; c=relaxed/simple;
	bh=0PRWH/GQgvBBBu7pJ7EPjhdZn104jvDMEheJUwE7VHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BiO6Xb3N7OrNVWxZqAYYa/kNuBu6QGkWz0KIIsxSy6+08KSoEqMvabsd8t8qUmEODuj7J1s9J7rN1Inm0gVN/DIX2xxiHEAcnaQNcELwLrPjEy9Bdhya4GNvNKVgOeRMDGaAUjOfm83npClwS4h2v2+79ExRLlsaq+QWJNZG5Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gs/C1oZG; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761707975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZG8xGN9GM2OCe3daOwLQpn81CHk+U/Z6iL92uNTt34=;
	b=gs/C1oZG49teJBl4+VrIFIrXBpSIMiWSzuSb9FAXs8dKxGFmKI7mJvvuTyfzCtZODedgG2
	CkYsjSJQ4mNd1W8utTfOPeAmwGnTGMAuWmYAjW66U4iylcc6YzFmN4ZxLdaAq+bfcaf9uS
	DsEXsVMlaidZMow7x5qzrf7/xr5oQFE=
From: Menglong Dong <menglong.dong@linux.dev>
To: ast@kernel.org, jolsa@kernel.org, Menglong Dong <menglong8.dong@gmail.com>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, mattbobrowski@google.com, rostedt@goodmis.org,
 mhiramat@kernel.org, leon.hwang@linux.dev, jiang.biao@linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 2/7] bpf: add two kfunc for TRACE_SESSION
Date: Wed, 29 Oct 2025 10:54:02 +0800
Message-ID: <5049886.31r3eYUQgx@7950hx>
In-Reply-To: <20251026030143.23807-3-dongml2@chinatelecom.cn>
References:
 <20251026030143.23807-1-dongml2@chinatelecom.cn>
 <20251026030143.23807-3-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/10/26 11:01, Menglong Dong wrote:
> If TRACE_SESSION exists, we will use extra 8-bytes in the stack of the
> trampoline to store the flags that we needed, and the 8-bytes lie after
> the return value, which means ctx[nr_args + 1]. And we will store the
> flag "is_exit" to the first bit of it.
> 
> Introduce the kfunc bpf_tracing_is_exit(), which is used to tell if it
> is fexit currently. Meanwhile, inline it in the verifier.
> 
> Add the kfunc bpf_fsession_cookie(), which is similar to
> bpf_session_cookie() and return the address of the session cookie. The
> address of the session cookie is stored after session flags, which means
> ctx[nr_args + 2]. Inline this kfunc in the verifier too.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
> v3:
> - merge the bpf_tracing_is_exit and bpf_fsession_cookie into a single
>   patch
> 
> v2:
> - store the session flags after return value, instead of before nr_args
> - inline the bpf_tracing_is_exit, as Jiri suggested
> ---
>  include/linux/bpf.h      |  1 +
>  kernel/bpf/verifier.c    | 33 ++++++++++++++++++++--
>  kernel/trace/bpf_trace.c | 59 ++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 88 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 6b5855c80fa6..ce55d3881c0d 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1736,6 +1736,7 @@ struct bpf_prog {
>  				enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
>  				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
>  				call_get_func_ip:1, /* Do we call get_func_ip() */
> +				call_session_cookie:1, /* Do we call bpf_fsession_cookie() */
>  				tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
>  				sleepable:1;	/* BPF program is sleepable */
>  	enum bpf_prog_type	type;		/* Type of BPF program */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 818deb6a06e4..6f8aa4718d6f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12293,6 +12293,8 @@ enum special_kfunc_type {
>  	KF___bpf_trap,
>  	KF_bpf_task_work_schedule_signal,
>  	KF_bpf_task_work_schedule_resume,
> +	KF_bpf_tracing_is_exit,
> +	KF_bpf_fsession_cookie,
>  };
>  
>  BTF_ID_LIST(special_kfunc_list)
> @@ -12365,6 +12367,8 @@ BTF_ID(func, bpf_res_spin_unlock_irqrestore)
>  BTF_ID(func, __bpf_trap)
>  BTF_ID(func, bpf_task_work_schedule_signal)
>  BTF_ID(func, bpf_task_work_schedule_resume)
> +BTF_ID(func, bpf_tracing_is_exit)
> +BTF_ID(func, bpf_fsession_cookie)
>  
>  static bool is_task_work_add_kfunc(u32 func_id)
>  {
> @@ -12419,7 +12423,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
>  	struct bpf_reg_state *reg = &regs[regno];
>  	bool arg_mem_size = false;
>  
> -	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx])
> +	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
> +	    meta->func_id == special_kfunc_list[KF_bpf_tracing_is_exit] ||
> +	    meta->func_id == special_kfunc_list[KF_bpf_fsession_cookie])
>  		return KF_ARG_PTR_TO_CTX;
>  
>  	/* In this function, we verify the kfunc's BTF as per the argument type,
> @@ -13912,7 +13918,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		}
>  	}
>  
> -	if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie]) {
> +	if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie] ||
> +	    meta.func_id == special_kfunc_list[KF_bpf_fsession_cookie]) {
>  		meta.r0_size = sizeof(u64);
>  		meta.r0_rdonly = false;
>  	}
> @@ -14193,6 +14200,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			return err;
>  	}
>  
> +	if (meta.func_id == special_kfunc_list[KF_bpf_fsession_cookie])
> +		env->prog->call_session_cookie = true;
> +
>  	return 0;
>  }
>  
> @@ -22012,6 +22022,25 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
>  		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
>  		*cnt = 1;
> +	} else if (desc->func_id == special_kfunc_list[KF_bpf_tracing_is_exit]) {
> +		/* Load nr_args from ctx - 8 */
> +		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> +		/* add rax, 1 */
> +		insn_buf[1] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1);
> +		insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
> +		insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1);
> +		insn_buf[4] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
> +		insn_buf[5] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
> +		*cnt = 6;
> +	} else if (desc->func_id == special_kfunc_list[KF_bpf_fsession_cookie]) {
> +		/* Load nr_args from ctx - 8 */
> +		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> +		/* add rax, 2 */
> +		insn_buf[1] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 2);
> +		insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
> +		insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1);
> +		insn_buf[4] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
> +		*cnt = 5;
>  	}
>  
>  	if (env->insn_aux_data[insn_idx].arg_prog) {
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 4f87c16d915a..4a8568bd654d 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3356,12 +3356,65 @@ static const struct btf_kfunc_id_set bpf_kprobe_multi_kfunc_set = {
>  	.filter = bpf_kprobe_multi_filter,
>  };
>  
> -static int __init bpf_kprobe_multi_kfuncs_init(void)
> +__bpf_kfunc_start_defs();
> +
> +__bpf_kfunc bool bpf_tracing_is_exit(void *ctx)
>  {
> -	return register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_kprobe_multi_kfunc_set);
> +	/* This helper call is inlined by verifier. */
> +	u64 nr_args = ((u64 *)ctx)[-1];
> +
> +	/*
> +	 * ctx[nr_args + 1] is the session flags, and the last bit is
> +	 * is_exit.
> +	 */
> +	return ((u64 *)ctx)[nr_args + 1] & 1;
> +}
> +
> +__bpf_kfunc u64 *bpf_fsession_cookie(void *ctx)
> +{
> +	/* This helper call is inlined by verifier. */
> +	u64 nr_args = ((u64 *)ctx)[-1];
> +
> +	/* ctx[nr_args + 2] is the session cookie address */
> +	return (u64 *)((u64 *)ctx)[nr_args + 2];

This casting cause build warning in 32-bits arch. I'll make it
like this in the next version after more human comments
on this series:

    return (u64 *)(long)((u64 *)ctx)[nr_args + 2];

> +}
> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(tracing_kfunc_set_ids)
> +BTF_ID_FLAGS(func, bpf_tracing_is_exit, KF_FASTCALL)
> +BTF_ID_FLAGS(func, bpf_fsession_cookie, KF_FASTCALL)
> +BTF_KFUNCS_END(tracing_kfunc_set_ids)
> +
> +static int bpf_tracing_filter(const struct bpf_prog *prog, u32 kfunc_id)
> +{
> +	if (!btf_id_set8_contains(&tracing_kfunc_set_ids, kfunc_id))
> +		return 0;
> +
> +	if (prog->type != BPF_PROG_TYPE_TRACING ||
> +	    prog->expected_attach_type != BPF_TRACE_SESSION)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static const struct btf_kfunc_id_set bpf_tracing_kfunc_set = {
> +	.owner = THIS_MODULE,
> +	.set = &tracing_kfunc_set_ids,
> +	.filter = bpf_tracing_filter,
> +};
> +
> +static int __init bpf_trace_kfuncs_init(void)
> +{
> +	int err = 0;
> +
> +	err = err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_kprobe_multi_kfunc_set);
> +	err = err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_tracing_kfunc_set);
> +
> +	return err;
>  }
>  
> -late_initcall(bpf_kprobe_multi_kfuncs_init);
> +late_initcall(bpf_trace_kfuncs_init);
>  
>  typedef int (*copy_fn_t)(void *dst, const void *src, u32 size, struct task_struct *tsk);
>  
> 





