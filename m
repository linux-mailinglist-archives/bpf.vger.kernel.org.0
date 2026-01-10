Return-Path: <bpf+bounces-78474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE02D0D79C
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 15:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA516300E813
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 14:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E29346AFA;
	Sat, 10 Jan 2026 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtdREh71"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5E217C69;
	Sat, 10 Jan 2026 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768056159; cv=none; b=Q9RJFf+w30JAYMcXKwAg31TEcQcKxbntMfIg7l/QV9+m9k6GjnKfu9x9pRRb8je4VTvyglNK0mvreCW4SwDoHNRHzk9nRN+8B9BtadekwrgRSE6S7WaiwWJuzi+HfgWLb+8LEZvkaBHIlUcZQBkBDfpWy7QbVGrkfT52qHhORA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768056159; c=relaxed/simple;
	bh=iTXDCqANfSeXRv+qSHgCRwDHWMGQZiT7FnsxOdP6i28=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GkXkAgB5rgGz3ZpX1WHjri0Bs1Y4tqanvyPmlzsbP8EfLRSHdhmSwgbuZrtRNLt2FjpQ/XbpOpkqfTWSg4Cme11efH0g//3NdY7eJqCGrBY9KKW5RrIho9u3/dPS+cZwh1599sMMXDYH+42PlgZIb1bWXFthVEGMUFnc717Ixbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtdREh71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90DBC4CEF1;
	Sat, 10 Jan 2026 14:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768056159;
	bh=iTXDCqANfSeXRv+qSHgCRwDHWMGQZiT7FnsxOdP6i28=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=NtdREh71wsjCReGMqegjwvo3CrYAbGq9xCy+sEEYutZZ1N1IESgCjKxAtvxAdm86z
	 4FIP4D2CSJhCHUCU9YlRZG2tFEovrKCt1RHIE45olF4ElnhPTQRbfHr+3RGVOna4B7
	 VuOltbh0LTT37fPLXJ42PQO+ece6SvuQsYt+NawCdtZKIEp4nHVDWIsnRn0+fniWAt
	 Kt/Jf7YtqMVQCf+4e++S7W9JZUUN7k8L9j9f9naLbdV4720o5fdxa0VsUZhpG7LoXa
	 gLquhf7Zn6PdoB40hIK7OHFwch9631emjXQGZuYE8IjQpzuwh0avd2vFVi6rSsEBfr
	 cFuOMqk5NoE9A==
Content-Type: multipart/mixed; boundary="===============6645288537249107646=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <75ddb4013c7de3c454d564f3052afc81a0906226a17d75aa4301f750e3ef7723@mail.kernel.org>
In-Reply-To: <20260110141115.537055-6-dongml2@chinatelecom.cn>
References: <20260110141115.537055-6-dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf-next v9 05/11] bpf: support fsession for bpf_session_cookie
From: bot+bpf-ci@kernel.org
To: menglong8.dong@gmail.com,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,davem@davemloft.net,dsahern@kernel.org,tglx@linutronix.de,mingo@redhat.com,jiang.biao@linux.dev,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 10 Jan 2026 14:42:38 +0000 (UTC)

--===============6645288537249107646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 2640ec2157e1..a416050e0dd2 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1231,6 +1231,7 @@ enum {
>
>  #define BPF_TRAMP_M_NR_ARGS	0
>  #define BPF_TRAMP_M_IS_RETURN	8
> +#define BPF_TRAMP_M_COOKIE	9

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1b0292a03186..b91fd8af2393 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -22571,6 +22575,22 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_M_IS_RETURN);
>  		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
>  		*cnt = 3;
> +	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_cookie] &&
> +		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
> +		/* inline bpf_session_cookie() for fsession:
> +		 *   __u64 *bpf_session_cookie(void *ctx)
> +		 *   {
> +		 *       u64 off = (((u64 *)ctx)[-1] >> BPF_TRAMP_M_COOKIE) & 0xFF;
> +		 *       return &((u64 *)ctx)[-off];
> +		 *   }
> +		 */
> +		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> +		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_M_COOKIE);
> +		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
> +		insn_buf[3] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
> +		insn_buf[4] = BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1);
> +		insn_buf[5] = BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0);
                        ^^^^^^^^

This inline code reads the cookie offset from (ctx[-1] >> 9) & 0xFF, but
does the x86 trampoline actually store the cookie offset at bit position 9?

Looking at arch/x86/net/bpf_jit_comp.c in __arch_prepare_bpf_trampoline(),
the trampoline stores nr_regs to the nregs_off location:

    emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_regs);
    emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -nregs_off);

This sets ctx[-1] to a small value like 0x0000000000000006, with the high
bits all zero. When the inline code executes:

    off = (ctx[-1] >> 9) & 0xFF  --> off = 0

The function then returns &ctx[-0] = ctx itself, which points to the
function arguments instead of the session cookie.

Is there a missing dependency on a later commit in the series? Commit
983968c39241 ("bpf,x86: add fsession support for x86_64") appears to add
the trampoline code that stores the cookie offset, but it comes after this
commit in the patch series.

> +		*cnt = 6;
> +	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20879693280

--===============6645288537249107646==--

