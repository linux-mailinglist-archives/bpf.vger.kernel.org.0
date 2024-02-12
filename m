Return-Path: <bpf+bounces-21760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4564B851DF9
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 20:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0E1BB21E58
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 19:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C17B4776F;
	Mon, 12 Feb 2024 19:35:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5131D47F4D
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707766553; cv=none; b=u60xXlMYywyzy1+oC/9QhdpH19kydR4S+xw/EhsUdc4BvSxvhIuv7ul4dRdX906av32xFXataxy1KfzK+ix6iNwPb2dIqueYMA5FC5JJWNPvbSTrcT2lJMqVvGCcx4CN3dHqN5CcpbpakYN/kNcibSJUh2gso3F+7S1Wkgu9R8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707766553; c=relaxed/simple;
	bh=khZcDx6Y/u6OqN2nWGM1PtLDA9YA5xxN0vyCr7Rxtnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yix2EYEk0rz0h0QwPbJEo6l8pEdVP7yyMPh+t43V4TqBKOH9wCRhrAvhXBr0k1hDCRit/G0jmNc6UUW+yDVOa8APVszpxcS7anKLzMXqN7bYD3bYA578P/PXaZI7QVRYJReduLOSAm91zQYaJAaOYv/9CvNlVOeJxgys03tIIAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d5c7443956so1471718241.0
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 11:35:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707766550; x=1708371350;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fztpe03dVkVcCQmrGHusoNM5MsdU0jKdKqzYW/vhrvs=;
        b=hNPMrbzXhbjNXqCO1sRdZDoSp+xtLrcAWs7o6uWX2hMVWVVxBh8jp4DoYNxyx6d5Dv
         UwhnXAbPaPWI8Gigb42GXYAYbpGPaoZexakO9e1kTKyAtoqHmBICAYQdlvKLGQTeXm50
         PXUiIKKtkwIZN8BlXpT0Rm897u+QbVsEpjUSU4ZC7BuGCb+WE1wUMnkaHyRrfeekL78L
         mmu8zRCNg6XSkXvgUog71T8lNmjlAGgDzw4SUKj/HWfLuH/2kP5tPfVi1Eep5SKGlTu9
         G+7VbcCUlY01k2Yox7iFa1kIuNcnwuyYSp9PwUAHmVIUYK3kkEJ5KIYkNjwOwjuVYFoG
         U0yw==
X-Gm-Message-State: AOJu0YzANuhnnFZJwQCTYYvFFQsut6qJV4WzzliwTxLCDL+VXGO4yxLG
	UvwCvjmc3H0o5QXs6TYvDCAFtpi7ihaPqlH+4abxJWmSYroDZL84
X-Google-Smtp-Source: AGHT+IHsddAZdKa3NiDy61NemGzNQVo3vqOhtPHHG2fEwCl7H6kgs8n8t569MZm3uYkP1m3Jeg93Uw==
X-Received: by 2002:a67:ead3:0:b0:46d:6beb:377 with SMTP id s19-20020a67ead3000000b0046d6beb0377mr5853289vso.34.1707766550086;
        Mon, 12 Feb 2024 11:35:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUuVgA+qL54Q4y29AGJg1xuurhbQdhgdb4GwZqXvYwsszdSDSBfwpyJ/9B60NFuuHt0DtHQJ7Rud1jUGVC27se3SQfhTCkwONBvo79/iE9kAxF3+eYZBffg4JpAvg32rjlbNOkb+GNl77Z+ePhxY9eCxR8YFBx2nyGeJihMrdVO1mTt8ky2jXXsdMUI5YNU7Ind061tbULQjI1RHJlWw4x0X0Yr9LaBx8Sylikr8SOcGsdNP4Ewhcwlcly+ucKAAY5adCjBTBZfuyNea0CtLJRpupletCrMETKb1PswgQ==
Received: from maniforge.lan (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id oo12-20020a056214450c00b0068cbacf7327sm459033qvb.107.2024.02.12.11.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 11:35:49 -0800 (PST)
Date: Mon, 12 Feb 2024 13:35:47 -0600
From: David Vernet <void@manifault.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>,
	Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>,
	Rishabh Iyer <rishabh.iyer@epfl.ch>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: Re: [RFC PATCH v1 01/14] bpf: Mark subprogs as throw reachable
 before do_check pass
Message-ID: <20240212193547.GB2200361@maniforge.lan>
References: <20240201042109.1150490-1-memxor@gmail.com>
 <20240201042109.1150490-2-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9hdgenn3+7v8sF4h"
Content-Disposition: inline
In-Reply-To: <20240201042109.1150490-2-memxor@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--9hdgenn3+7v8sF4h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 04:20:56AM +0000, Kumar Kartikeya Dwivedi wrote:
> The motivation of this patch is to figure out which subprogs participate
> in exception propagation. In other words, whichever subprog's execution
> can lead to an exception being thrown either directly or indirectly (by
> way of calling other subprogs).
>=20
> With the current exceptions support, the runtime performs stack
> unwinding when bpf_throw is called. For now, any resources acquired by
> the program cannot be released, therefore bpf_throw calls made with
> non-zero acquired references must be rejected during verification.
>=20
> However, there currently exists a loophole in this restriction due to
> the way the verification procedure is structured. The verifier will
> first walk over the main subprog's instructions, but not descend into
> subprog calls to ones with global linkage. These global subprogs will
> then be independently verified instead. Therefore, in a situation where
> a global subprog ends up throwing an exception (either directly by
> calling bpf_throw, or indirectly by way of calling another subprog that
> does so), the verifier will fail to notice this fact and may permit
> throwing BPF exceptions with non-zero acquired references.
>=20
> Therefore, to fix this, we add a summarization pass before the do_check
> stage which walks all call chains of the program and marks all of the
> subprogs that are reachable from a bpf_throw call which unwinds the
> program stack.
>=20
> We only do so if we actually see a bpf_throw call in the program though,
> since we do not want to walk all instructions unless we need to.  One we

s/Once/once

> analyze all possible call chains of the program, we will be able to mark
> them as 'is_throw_reachable' in their subprog_info.
>=20
> After performing this step, we need to make another change as to how
> subprog call verification occurs. In case of global subprog, we will
> need to explore an alternate program path where the call instruction
> processing of a global subprog's call will immediately throw an
> exception. We will thus simulate a normal path without any exceptions,
> and one where the exception is thrown and the program proceeds no
> further. In this way, the verifier will be able to detect the whether
> any acquired references or locks exist in the verifier state and thus
> reject the program if needed.
>=20
> Fixes: f18b03fabaa9 ("bpf: Implement BPF exceptions")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Just had a few nits and one question. Looks reasonable to me overall.

> ---
>  include/linux/bpf_verifier.h |  2 +
>  kernel/bpf/verifier.c        | 86 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+)
>=20
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 0dcde339dc7e..1d666b6c21e6 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -626,6 +626,7 @@ struct bpf_subprog_info {
>  	bool is_async_cb: 1;
>  	bool is_exception_cb: 1;
>  	bool args_cached: 1;
> +	bool is_throw_reachable: 1;
> =20
>  	u8 arg_cnt;
>  	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
> @@ -691,6 +692,7 @@ struct bpf_verifier_env {
>  	bool bypass_spec_v4;
>  	bool seen_direct_write;
>  	bool seen_exception;
> +	bool seen_throw_insn;
>  	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
>  	const struct bpf_line_info *prev_linfo;
>  	struct bpf_verifier_log log;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index cd4d780e5400..bba53c4e3a0c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2941,6 +2941,8 @@ static int check_subprogs(struct bpf_verifier_env *=
env)
>  		    insn[i].src_reg =3D=3D 0 &&
>  		    insn[i].imm =3D=3D BPF_FUNC_tail_call)
>  			subprog[cur_subprog].has_tail_call =3D true;
> +		if (!env->seen_throw_insn && is_bpf_throw_kfunc(&insn[i]))
> +			env->seen_throw_insn =3D true;
>  		if (BPF_CLASS(code) =3D=3D BPF_LD &&
>  		    (BPF_MODE(code) =3D=3D BPF_ABS || BPF_MODE(code) =3D=3D BPF_IND))
>  			subprog[cur_subprog].has_ld_abs =3D true;
> @@ -5866,6 +5868,9 @@ static int check_max_stack_depth_subprog(struct bpf=
_verifier_env *env, int idx)
> =20
>  			if (!is_bpf_throw_kfunc(insn + i))
>  				continue;
> +			/* When this is allowed, don't forget to update logic for sync and
> +			 * async callbacks in mark_exception_reachable_subprogs.
> +			 */
>  			if (subprog[idx].is_cb)
>  				err =3D true;
>  			for (int c =3D 0; c < frame && !err; c++) {
> @@ -16205,6 +16210,83 @@ static int check_btf_info(struct bpf_verifier_en=
v *env,
>  	return 0;
>  }
> =20
> +/* We walk the call graph of the program in this function, and mark ever=
ything in
> + * the call chain as 'is_throw_reachable'. This allows us to know which =
subprog
> + * calls may propagate an exception and generate exception frame descrip=
tors for
> + * those call instructions. We already do that for bpf_throw calls made =
directly,
> + * but we need to mark the subprogs as we won't be able to see the call =
chains
> + * during symbolic execution in do_check_common due to global subprogs.
> + *
> + * Note that unlike check_max_stack_depth, we don't explore the async ca=
llbacks
> + * apart from main subprogs, as we don't support throwing from them for =
now, but

Comment ending prematurely

> + */
> +static int mark_exception_reachable_subprogs(struct bpf_verifier_env *en=
v)
> +{
> +	struct bpf_subprog_info *subprog =3D env->subprog_info;
> +	struct bpf_insn *insn =3D env->prog->insnsi;
> +	int idx =3D 0, frame =3D 0, i, subprog_end;
> +	int ret_insn[MAX_CALL_FRAMES];
> +	int ret_prog[MAX_CALL_FRAMES];
> +
> +	/* No need if we never saw any bpf_throw() call in the program. */
> +	if (!env->seen_throw_insn)
> +		return 0;
> +
> +	i =3D subprog[idx].start;
> +restart:
> +	subprog_end =3D subprog[idx + 1].start;
> +	for (; i < subprog_end; i++) {
> +		int next_insn, sidx;
> +
> +		if (bpf_pseudo_kfunc_call(insn + i) && !insn[i].off) {

When should a kfunc call ever have a nonzero offset? We use the
immediate for the BTF ID, don't we?

> +			if (!is_bpf_throw_kfunc(insn + i))
> +				continue;
> +			subprog[idx].is_throw_reachable =3D true;
> +			for (int j =3D 0; j < frame; j++)
> +				subprog[ret_prog[j]].is_throw_reachable =3D true;
> +		}
> +
> +		if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
> +			continue;
> +		/* remember insn and function to return to */
> +		ret_insn[frame] =3D i + 1;
> +		ret_prog[frame] =3D idx;
> +
> +		/* find the callee */
> +		next_insn =3D i + insn[i].imm + 1;
> +		sidx =3D find_subprog(env, next_insn);
> +		if (sidx < 0) {
> +			WARN_ONCE(1, "verifier bug. No program starts at insn %d\n", next_ins=
n);
> +			return -EFAULT;
> +		}
> +		/* We cannot distinguish between sync or async cb, so we need to follow
> +		 * both.  Async callbacks don't really propagate exceptions but calling
> +		 * bpf_throw from them is not allowed anyway, so there is no harm in
> +		 * exploring them.
> +		 * TODO: To address this properly, we will have to move is_cb,
> +		 * is_async_cb markings to the stage before do_check.
> +		 */
> +		i =3D next_insn;
> +		idx =3D sidx;
> +
> +		frame++;
> +		if (frame >=3D MAX_CALL_FRAMES) {
> +			verbose(env, "the call stack of %d frames is too deep !\n", frame);
> +			return -E2BIG;
> +		}
> +		goto restart;
> +	}
> +	/* end of for() loop means the last insn of the 'subprog'
> +	 * was reached. Doesn't matter whether it was JA or EXIT
> +	 */
> +	if (frame =3D=3D 0)
> +		return 0;
> +	frame--;
> +	i =3D ret_insn[frame];
> +	idx =3D ret_prog[frame];
> +	goto restart;
> +}

If you squint youre eyes there's a non-trivial amount of duplicated
intent / logic here compared to check_max_stack_depth_subprog(). Do you
think it would be possible to combine them somehow?

> +
>  /* check %cur's range satisfies %old's */
>  static bool range_within(struct bpf_reg_state *old,
>  			 struct bpf_reg_state *cur)
> @@ -20939,6 +21021,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr, __u3
>  	if (ret < 0)
>  		goto skip_full_check;
> =20
> +	ret =3D mark_exception_reachable_subprogs(env);
> +	if (ret < 0)
> +		goto skip_full_check;
> +
>  	ret =3D do_check_main(env);
>  	ret =3D ret ?: do_check_subprogs(env);
> =20
> --=20
> 2.40.1
>=20

--9hdgenn3+7v8sF4h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcpzEwAKCRBZ5LhpZcTz
ZCVRAP9IL5lXRTgS9lDHusQ6eYGybfikU8ZmgUvb9f5NMbX4wwD+N8G0yxCFjndh
pIrv4nj3zIvWIP9sm8VI352HXbknfwo=
=7N0W
-----END PGP SIGNATURE-----

--9hdgenn3+7v8sF4h--

