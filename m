Return-Path: <bpf+bounces-13743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F287DD5E1
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 19:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E66FFB2105A
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 18:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7912136B;
	Tue, 31 Oct 2023 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J42DZ43S"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7C9208CD
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 18:14:05 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6BBA6
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 11:14:03 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99de884ad25so919019066b.3
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 11:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698776042; x=1699380842; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5D5wO7tVRj9mpVtCY7kwk7R1pw9+ycEuGl2qC5yi4LE=;
        b=J42DZ43Scfljt0f833QkU85QKgegxFL0380/kwiQnzKhFmq0ggbiZWu0noeCs1Kx4t
         ZujCt13JH2MPvhODZPvgY1CCOdMEBlOOepWValssBjO17Y1GtuwyCR+4HnUU8YHVG3cS
         b3H2G2uG/okjADIcDUkvhsC4UWexLt41fhSKnW8JIB5CWfu1q6I0IYOXx0Uzs4s16dRx
         mPD6nxK2//u6JeT96JpXfMQZY0YijR0ZKQIjjp20F+nje8kLsIkkf+FxnHjY5kRnuRQY
         S7dL9m/OHI9n6ef5y4z4FYMyuO2NwoxxJ2/XTpHRRVw6G0+Znb3U4LqzwJnyR/+hd3p9
         zc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698776042; x=1699380842;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5D5wO7tVRj9mpVtCY7kwk7R1pw9+ycEuGl2qC5yi4LE=;
        b=qutMsre9favBeTQMiaUlNiFPKafZQ2ZqqMsX5Ho6SlHKU8heOphFlP8NGstWkrPXwc
         37KFf/rKBooPGZdcaBR2HoSZk+QRiYPxwOeKI3eIYZKt8YH57DH5Utp9o8l8k6LDyzuS
         I473gMRvXxwtguNUndNNRKkBpNqAS/YgabhKy7Z3ZGfulj3k877Zn8/etN4PDEWDzy3y
         XF/6kINiVm1T+ISd6jc+CUcrNHQkdKJ6cAaY4GOrKSZ4bri/lFhheQie0lipSsGVqy5Z
         escyZhCkIMsIKA/P4o+H4cSGi0Nj+xe6pV++NLK3Zc78scn/g3ZKhMGfHylQgIs2URMT
         ANLA==
X-Gm-Message-State: AOJu0YzAqSna50xHwY7V7jYuBNhBJNA7TVK3GC+1WWbXWGVR+9vZkMYg
	tQGQluT96d4/NHiRNyLrs3I=
X-Google-Smtp-Source: AGHT+IHxHL0SHtusFUUyVfSWv+SErKGYi0i+RIji4Fj/B28dcywGjXYKoIijenbtgRM2QXxzFxchaw==
X-Received: by 2002:a17:906:4fc8:b0:9a5:d972:af43 with SMTP id i8-20020a1709064fc800b009a5d972af43mr113656ejw.65.1698776041433;
        Tue, 31 Oct 2023 11:14:01 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id e22-20020a1709067e1600b009b2c9476726sm1335324ejr.21.2023.10.31.11.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 11:14:00 -0700 (PDT)
Message-ID: <1ed9ec950b35d6e53f22e63a21b7d02a8907b4a5.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 17/23] bpf: generalize reg_set_min_max() to
 handle two sets of two registers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Tue, 31 Oct 2023 20:14:00 +0200
In-Reply-To: <20231027181346.4019398-18-andrii@kernel.org>
References: <20231027181346.4019398-1-andrii@kernel.org>
	 <20231027181346.4019398-18-andrii@kernel.org>
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
> Change reg_set_min_max() to take FALSE/TRUE sets of two registers each,
> instead of assuming that we are always comparing to a constant. For now
> we still assume that right-hand side registers are constants (and make
> sure that's the case by swapping src/dst regs, if necessary), but
> subsequent patches will remove this limitation.
>=20
> Taking two by two registers allows to further unify and simplify
> check_cond_jmp_op() logic. We utilize fake register for BPF_K
> conditional jump case, just like with is_branch_taken() part.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> ---
>  kernel/bpf/verifier.c | 112 ++++++++++++++++++------------------------
>  1 file changed, 49 insertions(+), 63 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index dde04b17c3a3..522566699fbe 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14387,26 +14387,43 @@ static int is_branch_taken(struct bpf_reg_state=
 *reg1, struct bpf_reg_state *reg
>   * In JEQ/JNE cases we also adjust the var_off values.
>   */
>  static void reg_set_min_max(struct bpf_reg_state *true_reg1,
> +			    struct bpf_reg_state *true_reg2,
>  			    struct bpf_reg_state *false_reg1,
> -			    u64 val, u32 val32,
> +			    struct bpf_reg_state *false_reg2,
>  			    u8 opcode, bool is_jmp32)
>  {
> -	struct tnum false_32off =3D tnum_subreg(false_reg1->var_off);
> -	struct tnum false_64off =3D false_reg1->var_off;
> -	struct tnum true_32off =3D tnum_subreg(true_reg1->var_off);
> -	struct tnum true_64off =3D true_reg1->var_off;
> -	s64 sval =3D (s64)val;
> -	s32 sval32 =3D (s32)val32;
> -
> -	/* If the dst_reg is a pointer, we can't learn anything about its
> -	 * variable offset from the compare (unless src_reg were a pointer into
> -	 * the same object, but we don't bother with that.
> -	 * Since false_reg1 and true_reg1 have the same type by construction, w=
e
> -	 * only need to check one of them for pointerness.
> +	struct tnum false_32off, false_64off;
> +	struct tnum true_32off, true_64off;
> +	u64 val;
> +	u32 val32;
> +	s64 sval;
> +	s32 sval32;
> +
> +	/* If either register is a pointer, we can't learn anything about its
> +	 * variable offset from the compare (unless they were a pointer into
> +	 * the same object, but we don't bother with that).
>  	 */
> -	if (__is_pointer_value(false, false_reg1))
> +	if (false_reg1->type !=3D SCALAR_VALUE || false_reg2->type !=3D SCALAR_=
VALUE)
> +		return;
> +
> +	/* we expect right-hand registers (src ones) to be constants, for now *=
/
> +	if (!is_reg_const(false_reg2, is_jmp32)) {
> +		opcode =3D flip_opcode(opcode);
> +		swap(true_reg1, true_reg2);
> +		swap(false_reg1, false_reg2);
> +	}
> +	if (!is_reg_const(false_reg2, is_jmp32))
>  		return;
> =20
> +	false_32off =3D tnum_subreg(false_reg1->var_off);
> +	false_64off =3D false_reg1->var_off;
> +	true_32off =3D tnum_subreg(true_reg1->var_off);
> +	true_64off =3D true_reg1->var_off;
> +	val =3D false_reg2->var_off.value;
> +	val32 =3D (u32)tnum_subreg(false_reg2->var_off).value;
> +	sval =3D (s64)val;
> +	sval32 =3D (s32)val32;
> +
>  	switch (opcode) {
>  	/* JEQ/JNE comparison doesn't change the register equivalence.
>  	 *
> @@ -14543,22 +14560,6 @@ static void reg_set_min_max(struct bpf_reg_state=
 *true_reg1,
>  	}
>  }
> =20
> -/* Same as above, but for the case that dst_reg holds a constant and src=
_reg is
> - * the variable reg.
> - */
> -static void reg_set_min_max_inv(struct bpf_reg_state *true_reg,
> -				struct bpf_reg_state *false_reg,
> -				u64 val, u32 val32,
> -				u8 opcode, bool is_jmp32)
> -{
> -	opcode =3D flip_opcode(opcode);
> -	/* This uses zero as "not present in table"; luckily the zero opcode,
> -	 * BPF_JA, can't get here.
> -	 */
> -	if (opcode)
> -		reg_set_min_max(true_reg, false_reg, val, val32, opcode, is_jmp32);
> -}
> -
>  /* Regs are known to be equal, so intersect their min/max/var_off */
>  static void __reg_combine_min_max(struct bpf_reg_state *src_reg,
>  				  struct bpf_reg_state *dst_reg)
> @@ -14891,45 +14892,30 @@ static int check_cond_jmp_op(struct bpf_verifie=
r_env *env,
>  	 * comparable.
>  	 */
>  	if (BPF_SRC(insn->code) =3D=3D BPF_X) {
> -		struct bpf_reg_state *src_reg =3D &regs[insn->src_reg];
> +		reg_set_min_max(&other_branch_regs[insn->dst_reg],
> +				&other_branch_regs[insn->src_reg],
> +				dst_reg, src_reg, opcode, is_jmp32);
> =20
>  		if (dst_reg->type =3D=3D SCALAR_VALUE &&
> -		    src_reg->type =3D=3D SCALAR_VALUE) {
> -			if (tnum_is_const(src_reg->var_off) ||
> -			    (is_jmp32 &&
> -			     tnum_is_const(tnum_subreg(src_reg->var_off))))
> -				reg_set_min_max(&other_branch_regs[insn->dst_reg],
> -						dst_reg,
> -						src_reg->var_off.value,
> -						tnum_subreg(src_reg->var_off).value,
> -						opcode, is_jmp32);
> -			else if (tnum_is_const(dst_reg->var_off) ||
> -				 (is_jmp32 &&
> -				  tnum_is_const(tnum_subreg(dst_reg->var_off))))
> -				reg_set_min_max_inv(&other_branch_regs[insn->src_reg],
> -						    src_reg,
> -						    dst_reg->var_off.value,
> -						    tnum_subreg(dst_reg->var_off).value,
> -						    opcode, is_jmp32);
> -			else if (!is_jmp32 &&
> -				 (opcode =3D=3D BPF_JEQ || opcode =3D=3D BPF_JNE))
> -				/* Comparing for equality, we can combine knowledge */
> -				reg_combine_min_max(&other_branch_regs[insn->src_reg],
> -						    &other_branch_regs[insn->dst_reg],
> -						    src_reg, dst_reg, opcode);
> -			if (src_reg->id &&
> -			    !WARN_ON_ONCE(src_reg->id !=3D other_branch_regs[insn->src_reg].i=
d)) {
> -				find_equal_scalars(this_branch, src_reg);
> -				find_equal_scalars(other_branch, &other_branch_regs[insn->src_reg]);
> -			}
> -
> +		    src_reg->type =3D=3D SCALAR_VALUE &&
> +		    !is_jmp32 && (opcode =3D=3D BPF_JEQ || opcode =3D=3D BPF_JNE)) {
> +			/* Comparing for equality, we can combine knowledge */
> +			reg_combine_min_max(&other_branch_regs[insn->src_reg],
> +					    &other_branch_regs[insn->dst_reg],
> +					    src_reg, dst_reg, opcode);
>  		}
>  	} else if (dst_reg->type =3D=3D SCALAR_VALUE) {
> -		reg_set_min_max(&other_branch_regs[insn->dst_reg],
> -					dst_reg, insn->imm, (u32)insn->imm,
> -					opcode, is_jmp32);
> +		reg_set_min_max(&other_branch_regs[insn->dst_reg], src_reg, /* fake on=
e */
> +				dst_reg, src_reg /* same fake one */,
> +				opcode, is_jmp32);
>  	}
> =20
> +	if (BPF_SRC(insn->code) =3D=3D BPF_X &&
> +	    src_reg->type =3D=3D SCALAR_VALUE && src_reg->id &&
> +	    !WARN_ON_ONCE(src_reg->id !=3D other_branch_regs[insn->src_reg].id)=
) {
> +		find_equal_scalars(this_branch, src_reg);
> +		find_equal_scalars(other_branch, &other_branch_regs[insn->src_reg]);
> +	}
>  	if (dst_reg->type =3D=3D SCALAR_VALUE && dst_reg->id &&
>  	    !WARN_ON_ONCE(dst_reg->id !=3D other_branch_regs[insn->dst_reg].id)=
) {
>  		find_equal_scalars(this_branch, dst_reg);


