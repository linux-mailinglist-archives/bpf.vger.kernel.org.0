Return-Path: <bpf+bounces-13766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 185727DD941
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 00:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34490B20F74
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 23:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE492747A;
	Tue, 31 Oct 2023 23:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKMViH4O"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AFD62F
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 23:25:50 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87264FE
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 16:25:47 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507ad511315so9030023e87.0
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 16:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698794746; x=1699399546; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9+8J9VN8rhHMStgTUabzOeM46uxyG95dyuKrqAApfAw=;
        b=RKMViH4O8r6X94Kkk50zZOEGONPqq8ZIvCznHVp3TMhMC6h1PdqJ2nobLq82eVhzlT
         Dqp1QVBhel6D2irkF+j9Ud89PgVk0jefQLeHWggRimPknCYz3BLXQMcgXJ2U7vLY7KVd
         xnXBxXeKvklT4gZAMx9gZ16BDFllhcZdRWXPE8amFJu2TwqX5lVW1gFxClnfyCZMX0jN
         E3Bnlef4sfp6R6GzWlMLV8uP7D34ODkAeEMJYrqcwH/slHulkUkv/9B31RDuvCL2jyTj
         KgXrA3WxDuHzrFivJqm58zGQa4ZH9U3fyjKtI1m5ihpTlYr/qcJwtf2vhznD0aUu6rdm
         A/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698794746; x=1699399546;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+8J9VN8rhHMStgTUabzOeM46uxyG95dyuKrqAApfAw=;
        b=Aw6g43OIBX1ip4xc40TLlUJtuXjI0nfWAI661NqADn33QvCrelU+3R1/hEfm8/+ZFo
         W3wehjqwuMBqAKpkqcmPpVnT0McD4xuYIlhAGMEK/Xuc4Fgpl3XmkODzShZhZjM8KOYd
         41B7jnBODsEVNviFz3mXCdlGbqX5bzmyzNmfxAx3KKFP+SWJL9GvyTBC+3N6L57es/1v
         fYDZRwFQjBcu7dtSSH5wMYQyW9yUzR2Sw0q/ngJyUZwze0M5YcijtD1xBaGviDQ2NAF4
         N8kE+3SYgu0h3vFVQWsHsqt8QARH7rcmQQe74tgwFhTm7wIbouyJUXgrCB7zayRNVCVE
         MhjQ==
X-Gm-Message-State: AOJu0YwZsMei2PJej9FzVVhr9pNiMDy3VpiE5HuXW++tIoT9ehTDR5RU
	vok5nxrwCtBUV8rVPk+2xgIhDPy7HLQ=
X-Google-Smtp-Source: AGHT+IHgQsDBaHPhr7dM19qDghqQ5vST52akz/FdCuwelYd+So/3sn/J1+kkYUxDKk85ppBl/2tA7g==
X-Received: by 2002:ac2:58ea:0:b0:507:b9db:61dc with SMTP id v10-20020ac258ea000000b00507b9db61dcmr9466491lfo.48.1698794745321;
        Tue, 31 Oct 2023 16:25:45 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id t7-20020ac243a7000000b00501ce0cacb6sm43374lfl.188.2023.10.31.16.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 16:25:44 -0700 (PDT)
Message-ID: <2b4d9d4728b77bd5781cd1bd7110c12af2aefc35.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 18/23] bpf: generalize reg_set_min_max() to
 handle non-const register comparisons
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Wed, 01 Nov 2023 01:25:43 +0200
In-Reply-To: <20231027181346.4019398-19-andrii@kernel.org>
References: <20231027181346.4019398-1-andrii@kernel.org>
	 <20231027181346.4019398-19-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-10-27 at 11:13 -0700, Andrii Nakryiko wrote:
> Generalize bounds adjustment logic of reg_set_min_max() to handle not
> just register vs constant case, but in general any register vs any
> register cases. For most of the operations it's trivial extension based
> on range vs range comparison logic, we just need to properly pick
> min/max of a range to compare against min/max of the other range.
>=20
> For BPF_JSET we keep the original capabilities, just make sure JSET is
> integrated in the common framework. This is manifested in the
> internal-only BPF_KSET + BPF_X "opcode" to allow for simpler and more
> uniform rev_opcode() handling. See the code for details. This allows to
> reuse the same code exactly both for TRUE and FALSE branches without
> explicitly handling both conditions with custom code.
>=20
> Note also that now we don't need a special handling of BPF_JEQ/BPF_JNE
> case none of the registers are constants. This is now just a normal
> generic case handled by reg_set_min_max().
>=20
> To make tnum handling cleaner, tnum_with_subreg() helper is added, as
> that's a common operator when dealing with 32-bit subregister bounds.
> This keeps the overall logic much less noisy when it comes to tnums.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/tnum.h  |   4 +
>  kernel/bpf/tnum.c     |   7 +-
>  kernel/bpf/verifier.c | 321 +++++++++++++++++++-----------------------
>  3 files changed, 157 insertions(+), 175 deletions(-)
>=20
> diff --git a/include/linux/tnum.h b/include/linux/tnum.h
> index 1c3948a1d6ad..3c13240077b8 100644
> --- a/include/linux/tnum.h
> +++ b/include/linux/tnum.h
> @@ -106,6 +106,10 @@ int tnum_sbin(char *str, size_t size, struct tnum a)=
;
>  struct tnum tnum_subreg(struct tnum a);
>  /* Returns the tnum with the lower 32-bit subreg cleared */
>  struct tnum tnum_clear_subreg(struct tnum a);
> +/* Returns the tnum with the lower 32-bit subreg in *reg* set to the low=
er
> + * 32-bit subreg in *subreg*
> + */
> +struct tnum tnum_with_subreg(struct tnum reg, struct tnum subreg);
>  /* Returns the tnum with the lower 32-bit subreg set to value */
>  struct tnum tnum_const_subreg(struct tnum a, u32 value);
>  /* Returns true if 32-bit subreg @a is a known constant*/
> diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> index 3d7127f439a1..f4c91c9b27d7 100644
> --- a/kernel/bpf/tnum.c
> +++ b/kernel/bpf/tnum.c
> @@ -208,7 +208,12 @@ struct tnum tnum_clear_subreg(struct tnum a)
>  	return tnum_lshift(tnum_rshift(a, 32), 32);
>  }
> =20
> +struct tnum tnum_with_subreg(struct tnum reg, struct tnum subreg)
> +{
> +	return tnum_or(tnum_clear_subreg(reg), tnum_subreg(subreg));
> +}
> +
>  struct tnum tnum_const_subreg(struct tnum a, u32 value)
>  {
> -	return tnum_or(tnum_clear_subreg(a), tnum_const(value));
> +	return tnum_with_subreg(a, tnum_const(value));
>  }
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 522566699fbe..4c974296127b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14381,217 +14381,201 @@ static int is_branch_taken(struct bpf_reg_sta=
te *reg1, struct bpf_reg_state *reg
>  	return is_scalar_branch_taken(reg1, reg2, opcode, is_jmp32);
>  }
> =20
> -/* Adjusts the register min/max values in the case that the dst_reg is t=
he
> - * variable register that we are working on, and src_reg is a constant o=
r we're
> - * simply doing a BPF_K check.
> - * In JEQ/JNE cases we also adjust the var_off values.
> +/* Opcode that corresponds to a *false* branch condition.
> + * E.g., if r1 < r2, then reverse (false) condition is r1 >=3D r2
>   */
> -static void reg_set_min_max(struct bpf_reg_state *true_reg1,
> -			    struct bpf_reg_state *true_reg2,
> -			    struct bpf_reg_state *false_reg1,
> -			    struct bpf_reg_state *false_reg2,
> -			    u8 opcode, bool is_jmp32)
> +static u8 rev_opcode(u8 opcode)

Note: this duplicates flip_opcode() (modulo BPF_JSET).

>  {
> -	struct tnum false_32off, false_64off;
> -	struct tnum true_32off, true_64off;
> -	u64 val;
> -	u32 val32;
> -	s64 sval;
> -	s32 sval32;
> -
> -	/* If either register is a pointer, we can't learn anything about its
> -	 * variable offset from the compare (unless they were a pointer into
> -	 * the same object, but we don't bother with that).
> +	switch (opcode) {
> +	case BPF_JEQ:		return BPF_JNE;
> +	case BPF_JNE:		return BPF_JEQ;
> +	/* JSET doesn't have it's reverse opcode in BPF, so add
> +	 * BPF_X flag to denote the reverse of that operation
>  	 */
> -	if (false_reg1->type !=3D SCALAR_VALUE || false_reg2->type !=3D SCALAR_=
VALUE)
> -		return;
> -
> -	/* we expect right-hand registers (src ones) to be constants, for now *=
/
> -	if (!is_reg_const(false_reg2, is_jmp32)) {
> -		opcode =3D flip_opcode(opcode);
> -		swap(true_reg1, true_reg2);
> -		swap(false_reg1, false_reg2);
> +	case BPF_JSET:		return BPF_JSET | BPF_X;
> +	case BPF_JSET | BPF_X:	return BPF_JSET;
> +	case BPF_JGE:		return BPF_JLT;
> +	case BPF_JGT:		return BPF_JLE;
> +	case BPF_JLE:		return BPF_JGT;
> +	case BPF_JLT:		return BPF_JGE;
> +	case BPF_JSGE:		return BPF_JSLT;
> +	case BPF_JSGT:		return BPF_JSLE;
> +	case BPF_JSLE:		return BPF_JSGT;
> +	case BPF_JSLT:		return BPF_JSGE;
> +	default:		return 0;
>  	}
> -	if (!is_reg_const(false_reg2, is_jmp32))
> -		return;
> +}
> =20
> -	false_32off =3D tnum_subreg(false_reg1->var_off);
> -	false_64off =3D false_reg1->var_off;
> -	true_32off =3D tnum_subreg(true_reg1->var_off);
> -	true_64off =3D true_reg1->var_off;
> -	val =3D false_reg2->var_off.value;
> -	val32 =3D (u32)tnum_subreg(false_reg2->var_off).value;
> -	sval =3D (s64)val;
> -	sval32 =3D (s32)val32;
> +/* Refine range knowledge for <reg1> <op> <reg>2 conditional operation. =
*/
> +static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_r=
eg_state *reg2,
> +				u8 opcode, bool is_jmp32)
> +{
> +	struct tnum t;
> =20
>  	switch (opcode) {
> -	/* JEQ/JNE comparison doesn't change the register equivalence.
> -	 *
> -	 * r1 =3D r2;
> -	 * if (r1 =3D=3D 42) goto label;
> -	 * ...
> -	 * label: // here both r1 and r2 are known to be 42.
> -	 *
> -	 * Hence when marking register as known preserve it's ID.
> -	 */
>  	case BPF_JEQ:
>  		if (is_jmp32) {
> -			__mark_reg32_known(true_reg1, val32);
> -			true_32off =3D tnum_subreg(true_reg1->var_off);
> +			reg1->u32_min_value =3D max(reg1->u32_min_value, reg2->u32_min_value)=
;
> +			reg1->u32_max_value =3D min(reg1->u32_max_value, reg2->u32_max_value)=
;
> +			reg1->s32_min_value =3D max(reg1->s32_min_value, reg2->s32_min_value)=
;
> +			reg1->s32_max_value =3D min(reg1->s32_max_value, reg2->s32_max_value)=
;
> +			reg2->u32_min_value =3D reg1->u32_min_value;
> +			reg2->u32_max_value =3D reg1->u32_max_value;
> +			reg2->s32_min_value =3D reg1->s32_min_value;
> +			reg2->s32_max_value =3D reg1->s32_max_value;
> +
> +			t =3D tnum_intersect(tnum_subreg(reg1->var_off), tnum_subreg(reg2->va=
r_off));
> +			reg1->var_off =3D tnum_with_subreg(reg1->var_off, t);
> +			reg2->var_off =3D tnum_with_subreg(reg2->var_off, t);
>  		} else {
> -			___mark_reg_known(true_reg1, val);
> -			true_64off =3D true_reg1->var_off;
> +			reg1->umin_value =3D max(reg1->umin_value, reg2->umin_value);
> +			reg1->umax_value =3D min(reg1->umax_value, reg2->umax_value);
> +			reg1->smin_value =3D max(reg1->smin_value, reg2->smin_value);
> +			reg1->smax_value =3D min(reg1->smax_value, reg2->smax_value);
> +			reg2->umin_value =3D reg1->umin_value;
> +			reg2->umax_value =3D reg1->umax_value;
> +			reg2->smin_value =3D reg1->smin_value;
> +			reg2->smax_value =3D reg1->smax_value;
> +
> +			reg1->var_off =3D tnum_intersect(reg1->var_off, reg2->var_off);
> +			reg2->var_off =3D reg1->var_off;
>  		}
>  		break;
>  	case BPF_JNE:
> +		/* we don't derive any new information for inequality yet */
> +		break;
> +	case BPF_JSET:
> +	case BPF_JSET | BPF_X: { /* BPF_JSET and its reverse, see rev_opcode() =
*/
> +		u64 val;
> +
> +		if (!is_reg_const(reg2, is_jmp32))
> +			swap(reg1, reg2);
> +		if (!is_reg_const(reg2, is_jmp32))
> +			break;
> +
> +		val =3D reg_const_value(reg2, is_jmp32);
> +		/* BPF_JSET requires single bit to learn something useful */
> +		if (!(opcode & BPF_X) && !is_power_of_2(val))

Could you please extend comment a bit, e.g. as follows:

		/* For BPF_JSET true branch (!(opcode & BPF_X)) a single bit
         * is needed to learn something useful.
         */

For some reason it took me a while to understand this condition :(

> +			break;
> +
>  		if (is_jmp32) {
> -			__mark_reg32_known(false_reg1, val32);
> -			false_32off =3D tnum_subreg(false_reg1->var_off);
> +			if (opcode & BPF_X)
> +				t =3D tnum_and(tnum_subreg(reg1->var_off), tnum_const(~val));
> +			else
> +				t =3D tnum_or(tnum_subreg(reg1->var_off), tnum_const(val));
> +			reg1->var_off =3D tnum_with_subreg(reg1->var_off, t);
>  		} else {
> -			___mark_reg_known(false_reg1, val);
> -			false_64off =3D false_reg1->var_off;
> +			if (opcode & BPF_X)
> +				reg1->var_off =3D tnum_and(reg1->var_off, tnum_const(~val));
> +			else
> +				reg1->var_off =3D tnum_or(reg1->var_off, tnum_const(val));
>  		}
>  		break;
> -	case BPF_JSET:
> +	}
> +	case BPF_JGE:
>  		if (is_jmp32) {
> -			false_32off =3D tnum_and(false_32off, tnum_const(~val32));
> -			if (is_power_of_2(val32))
> -				true_32off =3D tnum_or(true_32off,
> -						     tnum_const(val32));
> +			reg1->u32_min_value =3D max(reg1->u32_min_value, reg2->u32_min_value)=
;
> +			reg2->u32_max_value =3D min(reg1->u32_max_value, reg2->u32_max_value)=
;
>  		} else {
> -			false_64off =3D tnum_and(false_64off, tnum_const(~val));
> -			if (is_power_of_2(val))
> -				true_64off =3D tnum_or(true_64off,
> -						     tnum_const(val));
> +			reg1->umin_value =3D max(reg1->umin_value, reg2->umin_value);
> +			reg2->umax_value =3D min(reg1->umax_value, reg2->umax_value);
>  		}
>  		break;
> -	case BPF_JGE:
>  	case BPF_JGT:
> -	{
>  		if (is_jmp32) {
> -			u32 false_umax =3D opcode =3D=3D BPF_JGT ? val32  : val32 - 1;
> -			u32 true_umin =3D opcode =3D=3D BPF_JGT ? val32 + 1 : val32;
> -
> -			false_reg1->u32_max_value =3D min(false_reg1->u32_max_value,
> -						       false_umax);
> -			true_reg1->u32_min_value =3D max(true_reg1->u32_min_value,
> -						      true_umin);
> +			reg1->u32_min_value =3D max(reg1->u32_min_value, reg2->u32_min_value =
+ 1);

Question: This branch means that reg1 > reg2, right?
          If so, why not use reg2->u32_MAX_value, e.g.:

			reg1->u32_min_value =3D max(reg1->u32_min_value, reg2->u32_max_value + 1=
);

          Do I miss something?

> +			reg2->u32_max_value =3D min(reg1->u32_max_value - 1, reg2->u32_max_va=
lue);
>  		} else {
> -			u64 false_umax =3D opcode =3D=3D BPF_JGT ? val    : val - 1;
> -			u64 true_umin =3D opcode =3D=3D BPF_JGT ? val + 1 : val;
> -
> -			false_reg1->umax_value =3D min(false_reg1->umax_value, false_umax);
> -			true_reg1->umin_value =3D max(true_reg1->umin_value, true_umin);
> +			reg1->umin_value =3D max(reg1->umin_value, reg2->umin_value + 1);
> +			reg2->umax_value =3D min(reg1->umax_value - 1, reg2->umax_value);
>  		}
>  		break;
> -	}
>  	case BPF_JSGE:
> +		if (is_jmp32) {
> +			reg1->s32_min_value =3D max(reg1->s32_min_value, reg2->s32_min_value)=
;
> +			reg2->s32_max_value =3D min(reg1->s32_max_value, reg2->s32_max_value)=
;
> +		} else {
> +			reg1->smin_value =3D max(reg1->smin_value, reg2->smin_value);
> +			reg2->smax_value =3D min(reg1->smax_value, reg2->smax_value);
> +		}
> +		break;
>  	case BPF_JSGT:
> -	{
>  		if (is_jmp32) {
> -			s32 false_smax =3D opcode =3D=3D BPF_JSGT ? sval32    : sval32 - 1;
> -			s32 true_smin =3D opcode =3D=3D BPF_JSGT ? sval32 + 1 : sval32;
> -
> -			false_reg1->s32_max_value =3D min(false_reg1->s32_max_value, false_sm=
ax);
> -			true_reg1->s32_min_value =3D max(true_reg1->s32_min_value, true_smin)=
;
> +			reg1->s32_min_value =3D max(reg1->s32_min_value, reg2->s32_min_value =
+ 1);
> +			reg2->s32_max_value =3D min(reg1->s32_max_value - 1, reg2->s32_max_va=
lue);
>  		} else {
> -			s64 false_smax =3D opcode =3D=3D BPF_JSGT ? sval    : sval - 1;
> -			s64 true_smin =3D opcode =3D=3D BPF_JSGT ? sval + 1 : sval;
> -
> -			false_reg1->smax_value =3D min(false_reg1->smax_value, false_smax);
> -			true_reg1->smin_value =3D max(true_reg1->smin_value, true_smin);
> +			reg1->smin_value =3D max(reg1->smin_value, reg2->smin_value + 1);
> +			reg2->smax_value =3D min(reg1->smax_value - 1, reg2->smax_value);
>  		}
>  		break;
> -	}
>  	case BPF_JLE:
> +		if (is_jmp32) {
> +			reg1->u32_max_value =3D min(reg1->u32_max_value, reg2->u32_max_value)=
;
> +			reg2->u32_min_value =3D max(reg1->u32_min_value, reg2->u32_min_value)=
;
> +		} else {
> +			reg1->umax_value =3D min(reg1->umax_value, reg2->umax_value);
> +			reg2->umin_value =3D max(reg1->umin_value, reg2->umin_value);
> +		}
> +		break;
>  	case BPF_JLT:
> -	{
>  		if (is_jmp32) {
> -			u32 false_umin =3D opcode =3D=3D BPF_JLT ? val32  : val32 + 1;
> -			u32 true_umax =3D opcode =3D=3D BPF_JLT ? val32 - 1 : val32;
> -
> -			false_reg1->u32_min_value =3D max(false_reg1->u32_min_value,
> -						       false_umin);
> -			true_reg1->u32_max_value =3D min(true_reg1->u32_max_value,
> -						      true_umax);
> +			reg1->u32_max_value =3D min(reg1->u32_max_value, reg2->u32_max_value =
- 1);
> +			reg2->u32_min_value =3D max(reg1->u32_min_value + 1, reg2->u32_min_va=
lue);
>  		} else {
> -			u64 false_umin =3D opcode =3D=3D BPF_JLT ? val    : val + 1;
> -			u64 true_umax =3D opcode =3D=3D BPF_JLT ? val - 1 : val;
> -
> -			false_reg1->umin_value =3D max(false_reg1->umin_value, false_umin);
> -			true_reg1->umax_value =3D min(true_reg1->umax_value, true_umax);
> +			reg1->umax_value =3D min(reg1->umax_value, reg2->umax_value - 1);
> +			reg2->umin_value =3D max(reg1->umin_value + 1, reg2->umin_value);
>  		}
>  		break;
> -	}
>  	case BPF_JSLE:
> +		if (is_jmp32) {
> +			reg1->s32_max_value =3D min(reg1->s32_max_value, reg2->s32_max_value)=
;
> +			reg2->s32_min_value =3D max(reg1->s32_min_value, reg2->s32_min_value)=
;
> +		} else {
> +			reg1->smax_value =3D min(reg1->smax_value, reg2->smax_value);
> +			reg2->smin_value =3D max(reg1->smin_value, reg2->smin_value);
> +		}
> +		break;
>  	case BPF_JSLT:
> -	{
>  		if (is_jmp32) {
> -			s32 false_smin =3D opcode =3D=3D BPF_JSLT ? sval32    : sval32 + 1;
> -			s32 true_smax =3D opcode =3D=3D BPF_JSLT ? sval32 - 1 : sval32;
> -
> -			false_reg1->s32_min_value =3D max(false_reg1->s32_min_value, false_sm=
in);
> -			true_reg1->s32_max_value =3D min(true_reg1->s32_max_value, true_smax)=
;
> +			reg1->s32_max_value =3D min(reg1->s32_max_value, reg2->s32_max_value =
- 1);
> +			reg2->s32_min_value =3D max(reg1->s32_min_value + 1, reg2->s32_min_va=
lue);
>  		} else {
> -			s64 false_smin =3D opcode =3D=3D BPF_JSLT ? sval    : sval + 1;
> -			s64 true_smax =3D opcode =3D=3D BPF_JSLT ? sval - 1 : sval;
> -
> -			false_reg1->smin_value =3D max(false_reg1->smin_value, false_smin);
> -			true_reg1->smax_value =3D min(true_reg1->smax_value, true_smax);
> +			reg1->smax_value =3D min(reg1->smax_value, reg2->smax_value - 1);
> +			reg2->smin_value =3D max(reg1->smin_value + 1, reg2->smin_value);
>  		}
>  		break;
> -	}
>  	default:
>  		return;
>  	}
> -
> -	if (is_jmp32) {
> -		false_reg1->var_off =3D tnum_or(tnum_clear_subreg(false_64off),
> -					     tnum_subreg(false_32off));
> -		true_reg1->var_off =3D tnum_or(tnum_clear_subreg(true_64off),
> -					    tnum_subreg(true_32off));
> -		reg_bounds_sync(false_reg1);
> -		reg_bounds_sync(true_reg1);
> -	} else {
> -		false_reg1->var_off =3D false_64off;
> -		true_reg1->var_off =3D true_64off;
> -		reg_bounds_sync(false_reg1);
> -		reg_bounds_sync(true_reg1);
> -	}
> -}
> -
> -/* Regs are known to be equal, so intersect their min/max/var_off */
> -static void __reg_combine_min_max(struct bpf_reg_state *src_reg,
> -				  struct bpf_reg_state *dst_reg)
> -{
> -	src_reg->umin_value =3D dst_reg->umin_value =3D max(src_reg->umin_value=
,
> -							dst_reg->umin_value);
> -	src_reg->umax_value =3D dst_reg->umax_value =3D min(src_reg->umax_value=
,
> -							dst_reg->umax_value);
> -	src_reg->smin_value =3D dst_reg->smin_value =3D max(src_reg->smin_value=
,
> -							dst_reg->smin_value);
> -	src_reg->smax_value =3D dst_reg->smax_value =3D min(src_reg->smax_value=
,
> -							dst_reg->smax_value);
> -	src_reg->var_off =3D dst_reg->var_off =3D tnum_intersect(src_reg->var_o=
ff,
> -							     dst_reg->var_off);
> -	reg_bounds_sync(src_reg);
> -	reg_bounds_sync(dst_reg);
>  }
> =20
> -static void reg_combine_min_max(struct bpf_reg_state *true_src,
> -				struct bpf_reg_state *true_dst,
> -				struct bpf_reg_state *false_src,
> -				struct bpf_reg_state *false_dst,
> -				u8 opcode)
> +/* Adjusts the register min/max values in the case that the dst_reg is t=
he
> + * variable register that we are working on, and src_reg is a constant o=
r we're
> + * simply doing a BPF_K check.
> + * In JEQ/JNE cases we also adjust the var_off values.
> + */
> +static void reg_set_min_max(struct bpf_reg_state *true_reg1,
> +			    struct bpf_reg_state *true_reg2,
> +			    struct bpf_reg_state *false_reg1,
> +			    struct bpf_reg_state *false_reg2,
> +			    u8 opcode, bool is_jmp32)
>  {
> -	switch (opcode) {
> -	case BPF_JEQ:
> -		__reg_combine_min_max(true_src, true_dst);
> -		break;
> -	case BPF_JNE:
> -		__reg_combine_min_max(false_src, false_dst);
> -		break;
> -	}
> +	/* If either register is a pointer, we can't learn anything about its
> +	 * variable offset from the compare (unless they were a pointer into
> +	 * the same object, but we don't bother with that).
> +	 */
> +	if (false_reg1->type !=3D SCALAR_VALUE || false_reg2->type !=3D SCALAR_=
VALUE)
> +		return;
> +
> +	/* fallthrough (FALSE) branch */
> +	regs_refine_cond_op(false_reg1, false_reg2, rev_opcode(opcode), is_jmp3=
2);
> +	reg_bounds_sync(false_reg1);
> +	reg_bounds_sync(false_reg2);
> +
> +	/* jump (TRUE) branch */
> +	regs_refine_cond_op(true_reg1, true_reg2, opcode, is_jmp32);
> +	reg_bounds_sync(true_reg1);
> +	reg_bounds_sync(true_reg2);
>  }
> =20
>  static void mark_ptr_or_null_reg(struct bpf_func_state *state,
> @@ -14895,21 +14879,10 @@ static int check_cond_jmp_op(struct bpf_verifie=
r_env *env,
>  		reg_set_min_max(&other_branch_regs[insn->dst_reg],
>  				&other_branch_regs[insn->src_reg],
>  				dst_reg, src_reg, opcode, is_jmp32);
> -
> -		if (dst_reg->type =3D=3D SCALAR_VALUE &&
> -		    src_reg->type =3D=3D SCALAR_VALUE &&
> -		    !is_jmp32 && (opcode =3D=3D BPF_JEQ || opcode =3D=3D BPF_JNE)) {
> -			/* Comparing for equality, we can combine knowledge */
> -			reg_combine_min_max(&other_branch_regs[insn->src_reg],
> -					    &other_branch_regs[insn->dst_reg],
> -					    src_reg, dst_reg, opcode);
> -		}
>  	} else if (dst_reg->type =3D=3D SCALAR_VALUE) {
> -		reg_set_min_max(&other_branch_regs[insn->dst_reg], src_reg, /* fake on=
e */
> -				dst_reg, src_reg /* same fake one */,
> -				opcode, is_jmp32);
> +		reg_set_min_max(&other_branch_regs[insn->dst_reg], src_reg /* fake*/,
> +				dst_reg, src_reg, opcode, is_jmp32);
>  	}
> -
>  	if (BPF_SRC(insn->code) =3D=3D BPF_X &&
>  	    src_reg->type =3D=3D SCALAR_VALUE && src_reg->id &&
>  	    !WARN_ON_ONCE(src_reg->id !=3D other_branch_regs[insn->src_reg].id)=
) {


