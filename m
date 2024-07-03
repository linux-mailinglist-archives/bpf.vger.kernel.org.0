Return-Path: <bpf+bounces-33766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 350E3925F5B
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 13:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9FB28D9AA
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 11:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FF8171E5A;
	Wed,  3 Jul 2024 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBFHSoO1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D514C17164D
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720007869; cv=none; b=bjl/VzwU7iEExYtjS1nFMQhYn+B2xHiVeNN/OUupeknWPDtrMrwUptdd/+mNtIjjLL0gVZmsMnfzATS1g2bzGl/TUmXvycc8u4RtXVij6I3EUi3qx0Si8I4HeX4LI4/hOOX1DRzVzP4xfTcrv4vVt93m9/7VKPELEKEAiwDCXLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720007869; c=relaxed/simple;
	bh=27PZ4uyBnSez6KnSD8wFyoSTtumlxIzGHaJJ9IQzgLo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lgbbxoEueP7moqpCEd1cO+FF57LZl6lSgPd2q2xlTeePmvXM1XLUmYWN7d6GyEezcC7X3eTJcOC9t7TWULwKPIxQm3lvkrn47VPc1HJqcmSI94kk/djKF74RpIZk2xX+1qoZ2kDq3WvPdWIaOmuKCYU4SKRtlh+0Paz8tuG9Kdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBFHSoO1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA6AC2BD10;
	Wed,  3 Jul 2024 11:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720007869;
	bh=27PZ4uyBnSez6KnSD8wFyoSTtumlxIzGHaJJ9IQzgLo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KBFHSoO1vVnAa4RUDlJuQ3HF5nvLn2e6zJp1zipR2MCGz6SJJNZp2LO0RaLxsZMkb
	 WbTm0ZkX209TPVNcFeRhTGmq5qnuFj6UrvgAzVq/qiXM0jalbB6w2bzhHdWfjxobl5
	 lRNWdBYVfv0VPLCFi9xrXLAKRBUdg3p564npszxNolkdUKFPUA8KqcVPKThsd9WEVi
	 w+rEAPM6sIeYcQ8fhWB/C63M0vICPlr2kcrADKsXIi8/zanSazLfanAkRtSvcxlPn9
	 XaoPpKLC/GuXHErF4M5L9PQws+P2iYCuLHPWl4c4315aDzXgthYHbXicthJZEsrN6k
	 jbb+3ArsDUeTg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev, jose.marchesi@oracle.com,
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, puranjay12@gmail.com
Subject: Re: [RFC bpf-next v1 2/8] bpf: no_caller_saved_registers attribute
 for helper calls
In-Reply-To: <20240629094733.3863850-3-eddyz87@gmail.com>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
 <20240629094733.3863850-3-eddyz87@gmail.com>
Date: Wed, 03 Jul 2024 11:57:40 +0000
Message-ID: <mb61pbk3ek7rf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Eduard Zingerman <eddyz87@gmail.com> writes:

> GCC and LLVM define a no_caller_saved_registers function attribute.
> This attribute means that function scratches only some of
> the caller saved registers defined by ABI.
> For BPF the set of such registers could be defined as follows:
> - R0 is scratched only if function is non-void;
> - R1-R5 are scratched only if corresponding parameter type is defined
>   in the function prototype.
>
> This commit introduces flag bpf_func_prot->nocsr.
> If this flag is set for some helper function, verifier assumes that
> it follows no_caller_saved_registers calling convention.
>
> The contract between kernel and clang allows to simultaneously use
> such functions and maintain backwards compatibility with old
> kernels that don't understand no_caller_saved_registers calls
> (nocsr for short):
>
> - clang generates a simple pattern for nocsr calls, e.g.:
>
>     r1 = 1;
>     r2 = 2;
>     *(u64 *)(r10 - 8)  = r1;
>     *(u64 *)(r10 - 16) = r2;
>     call %[to_be_inlined_by_jit]

The call can be inlined by the verifier (in do_misc_fixups()) or by the
JIT if bpf_jit_inlines_helper_call() is true for a helper.

>     r2 = *(u64 *)(r10 - 16);
>     r1 = *(u64 *)(r10 - 8);
>     r0 = r1;
>     r0 += r2;
>     exit;
>
> - kernel removes unnecessary spills and fills, if called function is
>   inlined by current JIT (with assumption that patch inserted by JIT
>   honors nocsr contract, e.g. does not scratch r3-r5 for the example
>   above), e.g. the code above would be transformed to:
>
>     r1 = 1;
>     r2 = 2;
>     call %[to_be_inlined_by_jit]

Same as above

>     r0 = r1;
>     r0 += r2;
>     exit;
>

[.....]

> +/* True if do_misc_fixups() replaces calls to helper number 'imm',
> + * replacement patch is presumed to follow no_caller_saved_registers contract
> + * (see match_and_mark_nocsr_pattern() below).
> + */
> +static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
> +{
> +	return false;
> +}
> +
> +/* If 'insn' is a call that follows no_caller_saved_registers contract
> + * and called function is inlined by current jit, return a mask with

We should update the comment to: inlined by the verifier or by the
current JIT.

> + * 1s corresponding to registers that are scratched by this call
> + * (depends on return type and number of return parameters).
> + * Otherwise return ALL_CALLER_SAVED_REGS mask.
> + */
> +static u32 call_csr_mask(struct bpf_verifier_env *env, struct bpf_insn *insn)
> +{
> +	const struct bpf_func_proto *fn;
> +
> +	if (bpf_helper_call(insn) &&
> +	    verifier_inlines_helper_call(env, insn->imm) &&

This should also check bpf_jit_inlines_helper_call(insn->imm) as the JIT
can also inline helper calls separately from the verifier.

    if (bpf_helper_call(insn) &&
        (verifier_inlines_helper_call(env, insn->imm) || bpf_jit_inlines_helper_call(insn->imm)) &&

This is currently being done by the arm64 and risc-v JITs and they don't
scratch any register except R0 (The helpers inlined by these JITs are
non-void).

> +	    get_helper_proto(env, insn->imm, &fn) == 0 &&
> +	    fn->nocsr)
> +		return ~get_helper_reg_mask(fn);
> +
> +	return ALL_CALLER_SAVED_REGS;
> +}
> +
> +/* GCC and LLVM define a no_caller_saved_registers function attribute.
> + * This attribute means that function scratches only some of
> + * the caller saved registers defined by ABI.
> + * For BPF the set of such registers could be defined as follows:
> + * - R0 is scratched only if function is non-void;
> + * - R1-R5 are scratched only if corresponding parameter type is defined
> + *   in the function prototype.
> + *
> + * The contract between kernel and clang allows to simultaneously use
> + * such functions and maintain backwards compatibility with old
> + * kernels that don't understand no_caller_saved_registers calls
> + * (nocsr for short):
> + *
> + * - for nocsr calls clang allocates registers as-if relevant r0-r5
> + *   registers are not scratched by the call;
> + *
> + * - as a post-processing step, clang visits each nocsr call and adds
> + *   spill/fill for every live r0-r5;
> + *
> + * - stack offsets used for the spill/fill are allocated as minimal
> + *   stack offsets in whole function and are not used for any other
> + *   purposes;
> + *
> + * - when kernel loads a program, it looks for such patterns
> + *   (nocsr function surrounded by spills/fills) and checks if
> + *   spill/fill stack offsets are used exclusively in nocsr patterns;
> + *
> + * - if so, and if current JIT inlines the call to the nocsr function

We should update the comment to: if the verifier or the current JIT.

> + *   (e.g. a helper call), kernel removes unnecessary spill/fill pairs;
> + *
> + * - when old kernel loads a program, presence of spill/fill pairs
> + *   keeps BPF program valid, albeit slightly less efficient.
> + *
> + * For example:
> + *
> + *   r1 = 1;
> + *   r2 = 2;
> + *   *(u64 *)(r10 - 8)  = r1;            r1 = 1;
> + *   *(u64 *)(r10 - 16) = r2;            r2 = 2;
> + *   call %[to_be_inlined_by_jit]  -->   call %[to_be_inlined_by_jit]

We should update this to say: to_be_inlined_by_verifier_or_jit

> + *   r2 = *(u64 *)(r10 - 16);            r0 = r1;
> + *   r1 = *(u64 *)(r10 - 8);             r0 += r2;
> + *   r0 = r1;                            exit;
> + *   r0 += r2;
> + *   exit;
> + *
> + * The purpose of match_and_mark_nocsr_pattern is to:
> + * - look for such patterns;
> + * - mark spill and fill instructions in env->insn_aux_data[*].nocsr_pattern;
> + * - update env->subprog_info[*]->nocsr_stack_off to find an offset
> + *   at which nocsr spill/fill stack slots start.
> + *
> + * The .nocsr_pattern and .nocsr_stack_off are used by
> + * check_nocsr_stack_contract() to check if every stack access to
> + * nocsr spill/fill stack slot originates from spill/fill
> + * instructions, members of nocsr patterns.
> + *
> + * If such condition holds true for a subprogram, nocsr patterns could
> + * be rewritten by remove_nocsr_spills_fills().
> + * Otherwise nocsr patterns are not changed in the subprogram
> + * (code, presumably, generated by an older clang version).
> + *
> + * For example, it is *not* safe to remove spill/fill below:
> + *
> + *   r1 = 1;
> + *   *(u64 *)(r10 - 8)  = r1;            r1 = 1;
> + *   call %[to_be_inlined_by_jit]  -->   call %[to_be_inlined_by_jit]

Same as above.

Thanks for working on this feature.

Most of my comments except for bpf_jit_inlines_helper_call() are nit
picks regarding the comments or the commit message, but as the verifier
is already complicated, I feel it is useful to have extremely accurate
comments/commit messages for new contributors.

Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZoU8thQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2naV2AQCbPHFvzbH/Qs2MIofrx9AyDomkPmUp
B4rT8RkIJ9GxHAD9EXGLk4kHYpa/t/j+eFqw6xjmTLiEQQKG9ha3Ofh6/gk=
=Os7Q
-----END PGP SIGNATURE-----
--=-=-=--

