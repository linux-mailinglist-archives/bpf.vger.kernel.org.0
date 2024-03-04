Return-Path: <bpf+bounces-23288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E529A8700D5
	for <lists+bpf@lfdr.de>; Mon,  4 Mar 2024 12:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641EA1F22D23
	for <lists+bpf@lfdr.de>; Mon,  4 Mar 2024 11:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841443B297;
	Mon,  4 Mar 2024 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVghlILm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F2D3A1A6
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709553315; cv=none; b=TNf2gdTIssoVrP35397MsSDIvm9ZbnGIRu6bFjEoat/4y67ggfDL/b8jnEQPZ29ZYun2sZZHxXVxSMA5VTleDZB/qJJ9N8K3+9UA4tZ/8VdFTTe6CYsA29zMcP0Fyt4eoarJQCDzzFetKfCBqdfBw/gGO4XM9kEpAOcj3Tdqf+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709553315; c=relaxed/simple;
	bh=X1bZI16rnH7G6bg2Mx5zfafK+51mCKF22nnxPhJSekk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LYGhRcl75tkt1satGLfHF/h6ZOYblf3y60xFRPdzR8rO2Iea0PeorhcBo+4GQCifG2jW95ftxjY5mGfn3c3R2FLfDcRn9XWOTFTWfO6bZ7mxRqhrmFI6AUGAAWGvsAT8j17hWLc3JDkQ/yl0vj9vRonv91DgljLH4MpIoqHaGoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVghlILm; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5640fef9fa6so5458690a12.0
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 03:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709553312; x=1710158112; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XnfTRrtGxb4cAlU8cRTwQSCPOJ1f9CWA2JbjmC30BSA=;
        b=mVghlILmEaT0vt6CuzN2J7gkZRdbsYqHTYsqpcRvI/2s2FFrkN/7g2QwTGL4wyU+x0
         eeOKwvCho56C46Vr3UbrepP5UAEYqU4n5PUpURRl2XnKrMLmd0WiRaj4bTbOTW/vPFkw
         7CVx4gYFY9UkZ0nff2Alg6HS5VJJgx+/m/m3iB2Aqri566+H2N2gLR58CH+MiUZebVBJ
         NSZnmb+45bxoLIvlVNfJ/X1y8R7ECuZDpi/PDk/z14xvag14iEz5wbO2JH2CEZpAPSy7
         nUMTgGhcDTqaQodJQIls9JB9KkXHamhz65gH2hDIIaNfM2pAFZ0OEGtIKl3nCEys+7Ae
         o7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709553312; x=1710158112;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XnfTRrtGxb4cAlU8cRTwQSCPOJ1f9CWA2JbjmC30BSA=;
        b=XtcHskNdDhc9Dv3v0Sg2IgWROv1ZdDCSfePzXEU2FtvCFMqx8TFJ+FnCZcOawQb3vY
         PAOG4muaveRrzk8E+qMcVV2TJrkt+G0/I3cknzPbIK70izWCWMJsmCFJNOss7+h0q3rR
         7UL1ZceI/KLJqwSmUYRh01BxPQ7lPut/rnhgkHXtTGOxCFg91uOyKKwc7nBzddl+hVv3
         LFhE+95EmWrS7h8AO+UgVZs7jxi2ixO/Hy7vqiRvJbxy/Sy3L9xOaoCXAVoWewARtF4L
         dlGh6drqr+yIqUkepQSmfEUOvaHrx4us3I9EU2Bocd2sdl4wOzppxfIkH/Hnm/4stilS
         6vNg==
X-Forwarded-Encrypted: i=1; AJvYcCUDYHTb+6rrDZO3NrGWGskzNS4Bva0fIYdrNEThMbUd55CHyR1byfVfsHQ9S+t7pNPgyrN4k08LGiitrrDND4RFm7XP
X-Gm-Message-State: AOJu0Yx+SNHpX/KTtyYpZCBGcUij71n5FpR60ajqnqDEFyROYLFrzbEv
	Oxo+DKc5CaGQF4OE6Gql2xQ36aOq/Cm85r9WNZtaeZh2UkwqqkWS
X-Google-Smtp-Source: AGHT+IEWEu2w1NRJ2OcMwq/VSZ1IspQZqwHhuxO2nS7uPSjSrlNDqfIRHFLMhZKoz0zg3Axpjn4dmw==
X-Received: by 2002:a17:906:80c5:b0:a45:2090:f8d2 with SMTP id a5-20020a17090680c500b00a452090f8d2mr750000ejx.63.1709553311341;
        Mon, 04 Mar 2024 03:55:11 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id qb33-20020a1709077ea100b00a4410598eebsm4724413ejc.67.2024.03.04.03.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 03:55:10 -0800 (PST)
Message-ID: <6f76f6661061b091be3798c8e8b8c2f04d529e43.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/4] bpf: Introduce may_goto instruction
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com, john.fastabend@gmail.com, kernel-team@fb.com
Date: Mon, 04 Mar 2024 13:55:09 +0200
In-Reply-To: <20240302020010.95393-2-alexei.starovoitov@gmail.com>
References: <20240302020010.95393-1-alexei.starovoitov@gmail.com>
	 <20240302020010.95393-2-alexei.starovoitov@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-01 at 18:00 -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Introduce may_goto instruction that acts on a hidden bpf_iter_num, so tha=
t
> bpf_iter_num_new(), bpf_iter_num_destroy() don't need to be called explic=
itly.
> It can be used in any normal "for" or "while" loop, like
>=20
>   for (i =3D zero; i < cnt; cond_break, i++) {
>=20
> The verifier recognizes that may_goto is used in the program,
> reserves additional 8 bytes of stack, initializes them in subprog
> prologue, and replaces may_goto instruction with:
> aux_reg =3D *(u64 *)(fp - 40)
> if aux_reg =3D=3D 0 goto pc+off
> aux_reg +=3D 1
> *(u64 *)(fp - 40) =3D aux_reg

[...]

Modulo instruction validation issue you pointed out offlist I don't
see any obvious issues with this patch. Two notes below.

[...]

> @@ -19406,7 +19466,10 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
>  	struct bpf_insn insn_buf[16];
>  	struct bpf_prog *new_prog;
>  	struct bpf_map *map_ptr;
> -	int i, ret, cnt, delta =3D 0;
> +	int i, ret, cnt, delta =3D 0, cur_subprog =3D 0;
> +	struct bpf_subprog_info *subprogs =3D env->subprog_info;
> +	u16 stack_depth =3D subprogs[cur_subprog].stack_depth;
> +	u16 stack_depth_extra =3D 0;

Note: optimize_bpf_loop() has very similar logic,
      but there stack_depth is rounded up:

	u16 stack_depth =3D subprogs[cur_subprog].stack_depth;
	u16 stack_depth_roundup =3D round_up(stack_depth, 8) - stack_depth;
	u16 stack_depth_extra =3D 0;
	...
	stack_depth_extra =3D BPF_REG_SIZE * 3 + stack_depth_roundup;

And stack base for tmp variables is computed as "-(stack_depth + stack_dept=
h_extra)".

> =20
>  	if (env->seen_exception && !env->exception_callback_subprog) {
>  		struct bpf_insn patch[] =3D {
> @@ -19426,7 +19489,7 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
>  		mark_subprog_exc_cb(env, env->exception_callback_subprog);
>  	}
> =20
> -	for (i =3D 0; i < insn_cnt; i++, insn++) {
> +	for (i =3D 0; i < insn_cnt;) {
>  		/* Make divide-by-zero exceptions impossible. */
>  		if (insn->code =3D=3D (BPF_ALU64 | BPF_MOD | BPF_X) ||
>  		    insn->code =3D=3D (BPF_ALU64 | BPF_DIV | BPF_X) ||

[...]

> @@ -19950,6 +20033,39 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
>  			return -EFAULT;
>  		}
>  		insn->imm =3D fn->func - __bpf_call_base;
> +next_insn:
> +		if (subprogs[cur_subprog + 1].start =3D=3D i + delta + 1) {
> +			subprogs[cur_subprog].stack_depth +=3D stack_depth_extra;
> +			subprogs[cur_subprog].stack_extra =3D stack_depth_extra;
> +			cur_subprog++;
> +			stack_depth =3D subprogs[cur_subprog].stack_depth;
> +			stack_depth_extra =3D 0;
> +		}
> +		i++; insn++;
> +	}
> +
> +	env->prog->aux->stack_depth =3D subprogs[0].stack_depth;
> +	for (i =3D 0; i < env->subprog_cnt; i++) {
> +		int subprog_start =3D subprogs[i].start, j;
> +		int stack_slots =3D subprogs[i].stack_extra / 8;
> +
> +		if (stack_slots >=3D ARRAY_SIZE(insn_buf)) {
> +			verbose(env, "verifier bug: stack_extra is too large\n");
> +			return -EFAULT;
> +		}
> +
> +		/* Add insns to subprog prologue to zero init extra stack */
> +		for (j =3D 0; j < stack_slots; j++)
> +			insn_buf[j] =3D BPF_ST_MEM(BPF_DW, BPF_REG_FP,
> +						 -subprogs[i].stack_depth + j * 8, BPF_MAX_LOOPS);

Nit: the comment says that stack is zero initialized,
     while it is actually set to BPF_MAX_LOOPS.

> +		if (j) {
> +			insn_buf[j] =3D env->prog->insnsi[subprog_start];
> +
> +			new_prog =3D bpf_patch_insn_data(env, subprog_start, insn_buf, j + 1)=
;
> +			if (!new_prog)
> +				return -ENOMEM;
> +			env->prog =3D prog =3D new_prog;
> +		}
>  	}
> =20
>  	/* Since poke tab is now finalized, publish aux to tracker. */

