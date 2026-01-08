Return-Path: <bpf+bounces-78169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB56D00882
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 02:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5274430464CF
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 01:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79700213254;
	Thu,  8 Jan 2026 01:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H92wDbYH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F901A9FAF
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 01:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767834230; cv=none; b=VSysI1WsbP9Z9UQsRM8qX7eMSpZXPRKtEz+t9wYRFClqE7GHeYXpPANlNzOtFXVQ39Qu/A7kEl6v6JWRD1Q/4wnJ36n3HR4TTvpOsLmHvilaaZBhcSbm6+FGnv0C7CmkvIu0afC65vZ5iDjOZBZmMj/Nwq0Krut0ijmGDbXAWEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767834230; c=relaxed/simple;
	bh=2iBJguY2WoEd8en/tYPEXmQH3sNADTenM7t4uupqiAA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bZPJHaIAypvjkt7Wei8sLK6EpuldxqcooYeXnuJHxHg0B6VlgFJhjmComWrf9zURIULqb8xL67QQZWYRxyXnqILvM8FvPI5QpZx5j/ciKQwByBsLjxFQGCFYW3bMBrqz4Cegxkg8EAQghxA5rlIjXrRhSOYYHJBiu0EZs06RMCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H92wDbYH; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-121b14efeb8so4583644c88.1
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 17:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767834227; x=1768439027; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O6IKOzSqn89RSe1boGWY2tzaWTk26dWYckshPbCi6zk=;
        b=H92wDbYHrcytaH+MZjG5/xVvS2LC8tKo/tot/NLuax0rkrIDnYxssc1EF5ZJe1zVOP
         Fqx6yvVkWyC9/1RHiMyADuyueLm1P7afdKU7IA1UnER206UcTh/AvMxih5f6Xqzflc46
         6U5osyMGX5yfFAhZlOjuCUsP3oQ+Ja1BqaPf8dX/+6uZ6QF8qCgJ4Pm5Xgb51WiIMGNX
         rRmg5gr5eSCtfS6z+725tx8U0Y4DOFfmgjMh72nE02Fs499CnaorTWg6rg0KLrMPsvQm
         /3gfRi3qUXaE+IocjtVgphtAhLQU9GABL8oaKtTjZlj7L2mKXmI17+rWCA/p35vSFJNZ
         AAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767834227; x=1768439027;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O6IKOzSqn89RSe1boGWY2tzaWTk26dWYckshPbCi6zk=;
        b=GlXqRYI2aNG211Maz2KX+qSLAXl10t5+dGY2En7wslouShGz1tTlLeNBgRyC/B6Dvl
         HxIc3sxwEkGskd7QAHkQbeWYi5cqfssh8z+OS9LRBl/R1452iZEaBJIURlBERRisXAYg
         blxl0a4uumv8g3CFt1mdc5BgCldqJPVaku3Z8+vTuXIXwe/a5NGHejdEN4XfHSkY8CdQ
         Uzcz7s6G6wId5s57C+1wjrhN1l8e7ZYABH4g0LLNp7tvoyyrPrY3likPWqGJ5d/JaoXz
         7tpeK3F4bsIyVQtrsctmBD0haHxtNNzOMrvjrovxUCRPJ6mY/lV5LAftq6PubiehYvz6
         hFcw==
X-Forwarded-Encrypted: i=1; AJvYcCUkjU+Ph4GbydnLBqXAAcvjzb3Z5+Ylzmw+VuXGHQnS20vWGRN5uEcM7fzbMYkNsQtNs1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc2zkcH6FXoJS/nMcP/e1HgoDoKk18ts/PyZ2GejXE1c/SMHUj
	dbHRtpYT7Cf4ajKljK0ozp6HToS1A0qqFlc74EHH9IRtCXLwihGZ7S/H
X-Gm-Gg: AY/fxX7FiMwVYX6tohMFibywNQARUTnRBzXhpOtvtHk/EVxxxSz4G9cabG4gZGgtMyY
	3qUNJR+LAN4jNHBt+GEExU4FFwIXqV5eYbUHrQ2ln5YGsBc2oxSpVfpB7I1DzElpMRqL1dhHBEE
	Yqf5G5JLq840vCcrzfvt216/wj2QITEv+kXjFhUpQ7UANPxIHkDErKDRbvFdStBjidVqv8DbtNY
	Wj0DmDuvWiD4liROtj6lE3Wa+Tx6qYljGKz40mRBen+V+bEXiOqUC8hCpYFkGL7oihO/4XWjo1n
	EZapD8Jc4svSwCLWjHvr7yh3o3v03WmhEgLG9T0q2zQZfXFQ5QOgYzeYX3tJ2JX8rPome+AM0GL
	qIpaKd/71fWHmdCGRbsc6Pty8jhWvZYgsGlA8bzkUfXAiyvMcgkCSaElFt4+hTTh7Rh70ot3pd1
	5c6zwIuGX4Msy+egWcRuBz0Ert+12MTjq85Mq/
X-Google-Smtp-Source: AGHT+IEHYCHFSNQtZV4tUB6bkRMtW7tr8RlzYRYFESqger7miR/FLTDaD8fHXFhP9vv7cS9SPbJ6Sg==
X-Received: by 2002:a05:7022:b889:b0:11d:e2a3:2070 with SMTP id a92af1059eb24-121f8b7b2a3mr2434256c88.44.1767834227372;
        Wed, 07 Jan 2026 17:03:47 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:6741:9f57:1ccc:45f2? ([2620:10d:c090:500::2:4706])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f249894fsm9219917c88.15.2026.01.07.17.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 17:03:46 -0800 (PST)
Message-ID: <39509bf2976a9812e89e5d1259fcaf1692b97fe3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Recognize special arithmetic shift
 in the verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com, sunhao.th@gmail.com
Date: Wed, 07 Jan 2026 17:03:44 -0800
In-Reply-To: <20260103022310.935686-2-puranjay@kernel.org>
References: <20260103022310.935686-1-puranjay@kernel.org>
	 <20260103022310.935686-2-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-01-02 at 18:23 -0800, Puranjay Mohan wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> cilium bpf_wiregard.bpf.c when compiled with -O1 fails to load
> with the following verifier log:
>=20
> 192: (79) r2 =3D *(u64 *)(r10 -304)     ; R2=3Dpkt(r=3D40) R10=3Dfp0 fp-3=
04=3Dpkt(r=3D40)
> ...
> 227: (85) call bpf_skb_store_bytes#9          ; R0=3Dscalar()
> 228: (bc) w2 =3D w0                     ; R0=3Dscalar() R2=3Dscalar(smin=
=3D0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff))
> 229: (c4) w2 s>>=3D 31                  ; R2=3Dscalar(smin=3D0,smax=3Duma=
x=3D0xffffffff,smin32=3D-1,smax32=3D0,var_off=3D(0x0; 0xffffffff))
> 230: (54) w2 &=3D -134                  ; R2=3Dscalar(smin=3D0,smax=3Duma=
x=3Dumax32=3D0xffffff7a,smax32=3D0x7fffff7a,var_off=3D(0x0; 0xffffff7a))
> ...
> 232: (66) if w2 s> 0xffffffff goto pc+125     ; R2=3Dscalar(smin=3Dumin=
=3Dumin32=3D0x80000000,smax=3Dumax=3Dumax32=3D0xffffff7a,smax32=3D-134,var_=
off=3D(0x80000000; 0x7fffff7a))
> ...
> 238: (79) r4 =3D *(u64 *)(r10 -304)     ; R4=3Dscalar() R10=3Dfp0 fp-304=
=3Dscalar()
> 239: (56) if w2 !=3D 0xffffff78 goto pc+210     ; R2=3D0xffffff78 // -136
> ...
> 258: (71) r1 =3D *(u8 *)(r4 +0)
> R4 invalid mem access 'scalar'
>=20
> The error might confuse most bpf authors, since fp-304 slot had 'pkt'
> pointer at insn 192 and became 'scalar' at 238. That happened because
> bpf_skb_store_bytes() clears all packet pointers including those in
> the stack. On the first glance it might look like a bug in the source
> code, since ctx->data pointer should have been reloaded after the call
> to bpf_skb_store_bytes().
>=20
> The relevant part of cilium source code looks like this:
>=20
> // bpf/lib/nodeport.h
> int dsr_set_ipip6()
> {
> 	if (ctx_adjust_hroom(...))
> 		return DROP_INVALID; // -134
> 	if (ctx_store_bytes(...))
> 		return DROP_WRITE_ERROR; // -141
> 	return 0;
> }
>=20
> bool dsr_fail_needs_reply(int code)
> {
> 	if (code =3D=3D DROP_FRAG_NEEDED) // -136
> 		return true;
> 	return false;
> }
>=20
> tail_nodeport_ipv6_dsr()
> {
> 	ret =3D dsr_set_ipip6(...);
> 	if (!IS_ERR(ret)) {
> 		...
> 	} else {
> 		if (dsr_fail_needs_reply(ret))
> 			return dsr_reply_icmp6(...);
> 	}
> }
>=20
> The code doesn't have arithmetic shift by 31 and it reloads ctx->data
> every time it needs to access it. So it's not a bug in the source code.
>=20
> The reason is DAGCombiner::foldSelectCCToShiftAnd() LLVM transformation:
>=20
>   // If this is a select where the false operand is zero and the compare =
is a
>   // check of the sign bit, see if we can perform the "gzip trick":
>   // select_cc setlt X, 0, A, 0 -> and (sra X, size(X)-1), A
>   // select_cc setgt X, 0, A, 0 -> and (not (sra X, size(X)-1)), A
>=20
> The conditional branch in dsr_set_ipip6() and its return values
> are optimized into BPF_ARSH plus BPF_AND:
>=20
> 227: (85) call bpf_skb_store_bytes#9
> 228: (bc) w2 =3D w0
> 229: (c4) w2 s>>=3D 31   ; R2=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,=
smin32=3D-1,smax32=3D0,var_off=3D(0x0; 0xffffffff))
> 230: (54) w2 &=3D -134   ; R2=3Dscalar(smin=3D0,smax=3Dumax=3Dumax32=3D0x=
ffffff7a,smax32=3D0x7fffff7a,var_off=3D(0x0; 0xffffff7a))
>=20
> after insn 230 the register w2 can only be 0 or -134,
> but the verifier approximates it, since there is no way to
> represent two scalars in bpf_reg_state.
> After fallthough at insn 232 the w2 can only be -134,
> hence the branch at insn
> 239: (56) if w2 !=3D -136 goto pc+210
> should be always taken, and trapping insn 258 should never execute.
> LLVM generated correct code, but the verifier follows impossible
> path and rejects valid program. To fix this issue recognize this
> special LLVM optimization and fork the verifier state.
> So after insn 229: (c4) w2 s>>=3D 31
> the verifier has two states to explore:
> one with w2 =3D 0 and another with w2 =3D 0xffffffff
> which makes the verifier accept bpf_wiregard.c
>=20
> Note there are 20+ such patterns in bpf_wiregard.o compiled
> with -O1 and -O2, but they're rarely seen in other production
> bpf programs, so push_stack() approach is not a concern.
>=20
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Hi Puranjay,

Nit: please drop acks if patch logic changes significantly
     (e.g. in this case the maybe_fork_scalars() call was moved).

I second Andrii's question and am also curious if there is a
verification performance difference between v2 (fork at arsh) and v3
(fork at and)?

>  kernel/bpf/verifier.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c9da70dd3e72..6dbcfae5615b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15490,6 +15490,35 @@ static bool is_safe_to_compute_dst_reg_range(str=
uct bpf_insn *insn,
>  	}
>  }
> =20
> +static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_i=
nsn *insn,
> +			      struct bpf_reg_state *dst_reg)
> +{
> +	struct bpf_verifier_state *branch;
> +	struct bpf_reg_state *regs;
> +	bool alu32;
> +
> +	if (dst_reg->smin_value =3D=3D -1 && dst_reg->smax_value =3D=3D 0)
> +		alu32 =3D false;
> +	else if (dst_reg->s32_min_value =3D=3D -1 && dst_reg->s32_max_value =3D=
=3D 0)
> +		alu32 =3D true;
> +	else

If we rely on specific dst_reg range, do we need to mark it as precise?

> +		return 0;
> +
> +	branch =3D push_stack(env, env->insn_idx + 1, env->insn_idx, false);
> +	if (IS_ERR(branch))
> +		return PTR_ERR(branch);
> +
> +	regs =3D branch->frame[branch->curframe]->regs;
> +	if (alu32) {
> +		__mark_reg32_known(&regs[insn->dst_reg], 0);
> +		__mark_reg32_known(dst_reg, -1ull);
> +	} else {
> +		__mark_reg_known(&regs[insn->dst_reg], 0);
> +		__mark_reg_known(dst_reg, -1ull);
> +	}
> +	return 0;
> +}
> +
>  /* WARNING: This function does calculations on 64-bit values, but the ac=
tual
>   * execution may occur on 32-bit values. Therefore, things like bitshift=
s
>   * need extra checks in the 32-bit case.
> @@ -15552,6 +15581,11 @@ static int adjust_scalar_min_max_vals(struct bpf=
_verifier_env *env,
>  		scalar_min_max_mul(dst_reg, &src_reg);
>  		break;
>  	case BPF_AND:
> +		if (tnum_is_const(src_reg.var_off)) {
> +			ret =3D maybe_fork_scalars(env, insn, dst_reg);
> +			if (ret)
> +				return ret;
> +		}
>  		dst_reg->var_off =3D tnum_and(dst_reg->var_off, src_reg.var_off);
>  		scalar32_min_max_and(dst_reg, &src_reg);
>  		scalar_min_max_and(dst_reg, &src_reg);

