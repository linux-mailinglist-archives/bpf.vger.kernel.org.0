Return-Path: <bpf+bounces-78061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA876CFC4A9
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 08:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E2823027CC5
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 07:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CCD27702E;
	Wed,  7 Jan 2026 07:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JG7GdLiD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1468074BE1;
	Wed,  7 Jan 2026 07:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767769874; cv=none; b=pMsnRBBW93azSpNaNextEjVZJCYB4Upuxk9kPAphjhrgKCdmdxkF9B6uy/uOCykDps/EanImeq3WNdnSV5oPv0VZtJj22VUG8aJhVT7au/F5kp6spgWnzflqTvJcIrsBzhAYyVqr6BoTW7CN43muABgfZTts1Y9r2U1FF+od2jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767769874; c=relaxed/simple;
	bh=YEXSgOITxIN6mJF/xx/h3Pi2AK3vEPMqUsJYnrw5Cok=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=McGp0qehxZNhIYP/ivuhkqIDk0bCcIVqJvveWVoq4jS/T7tiHyeS6gazOp25n8/AWt67ZSvHMjvg2tDP92XLjmuKBoXBD9+aeb+vclQqYPQjNPu63Oa1PgilRn8JBEhBtEubcabX8AOMp5lFuzf1o40FPFv0o8rDsl1G8rm2Lcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JG7GdLiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA788C4CEF7;
	Wed,  7 Jan 2026 07:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767769873;
	bh=YEXSgOITxIN6mJF/xx/h3Pi2AK3vEPMqUsJYnrw5Cok=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=JG7GdLiDYDOcUauN/qejiUdmZUAuJzFanrurRV7iIMIeMblIKMcWOF6me9O+EWGeq
	 7kCiA6d7qiTQqYVAvn7hdLKZqhWUk1CGWYFJ8ELxmr/pGL/Uzj516M39ZH0IUqft3q
	 DcGLH9djYxFM3eRUW5LHfoFHi2kMCTO3aDX5uw9fXeaRXCBxtJvEAVm4h948SpqLwX
	 MB0jP8X5ZvIAgO0ZWDAGpmKF+OSUJbkC5wPD9KvTcf8Fq5hDv8ywYBZ6e3qF21Cw39
	 SPf7DjIYNO5qsAE0vrdIP2saWUsKdOiaziciPH7wpwrXepiendj5DRaCSqECMwDic0
	 iio60+S2dhxbg==
Content-Type: multipart/mixed; boundary="===============5457345692534689078=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7b965f06828236a16f0146550e01a581b1c202c427584a894d5a70a42ff06435@mail.kernel.org>
In-Reply-To: <20260107064352.291069-5-dongml2@chinatelecom.cn>
References: <20260107064352.291069-5-dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf-next v7 04/11] bpf: support fsession for bpf_session_is_return
From: bot+bpf-ci@kernel.org
To: menglong8.dong@gmail.com,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,davem@davemloft.net,dsahern@kernel.org,tglx@linutronix.de,mingo@redhat.com,jiang.biao@linux.dev,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  7 Jan 2026 07:11:12 +0000 (UTC)

--===============5457345692534689078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 41228b0add52..95248b0d28ab 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1229,6 +1229,9 @@ enum {
>  #endif
>  };
>
> +#define BPF_TRAMP_M_NR_ARGS	0
> +#define BPF_TRAMP_M_IS_RETURN	8

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index bfff3f84fd91..d3709edd0e51 100644

[ ... ]

> @@ -22558,6 +22564,13 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
>  		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
>  		*cnt = 1;
> +	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_is_return] &&
> +		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
> +		/* Load nr_args from ctx - 8 */
> +		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> +		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_M_IS_RETURN);
> +		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
> +		*cnt = 3;
                ^^^^

This inlined code reads the BPF_TRAMP_M_IS_RETURN bit (bit 8) from ctx[-1]
to determine if the program is running at function exit. However, looking
at arch/x86/net/bpf_jit_comp.c, the trampoline only stores nr_regs to
ctx[-8] at this point in the series:

    emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_regs);
    emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -nregs_off);

The BPF_TRAMP_M_IS_RETURN flag is not being set by the trampoline code.
Is this intentional? The arch code that sets this bit appears to be added
in a later commit in the series (93d4641b9513 "bpf,x86: add fsession
support for x86_64").

At this commit, bpf_session_is_return() for fsession programs will always
return false, even during fexit execution, because bit 8 is never set.

> +	}
>
>  	if (env->insn_aux_data[insn_idx].arg_prog) {

[ ... ]

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 736b32cf2195..9d3bf3bbe8f6 100644

[ ... ]

> @@ -3314,6 +3314,12 @@ static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
>  }
>  #endif /* CONFIG_UPROBES */
>
> +bool bpf_fsession_is_return(void *ctx)
> +{
> +	/* This helper call is inlined by verifier. */
> +	return !!(((u64 *)ctx)[-1] & (1 << BPF_TRAMP_M_IS_RETURN));
> +}

The same issue exists here in bpf_fsession_is_return() - it reads bit 8
which is not set by the trampoline at this point in the series. The
comment indicates this is inlined by the verifier, but both code paths
have the same problem.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20773233136

--===============5457345692534689078==--

