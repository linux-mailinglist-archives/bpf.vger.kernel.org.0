Return-Path: <bpf+bounces-14080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9237E06F8
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 17:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D517281EF7
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 16:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B728E1D52A;
	Fri,  3 Nov 2023 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9v2z+ld"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6153318626
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 16:47:37 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CAB191
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 09:47:33 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so3846625a12.0
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 09:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699030052; x=1699634852; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BUkCHpSCoZsWvUc2JnwHfBwoEYEsmRGaKupWn4UeViA=;
        b=Y9v2z+ldDQbIrSRBQUk0z3Jbm+Kk+uPW+rsyas0J/qKdJV0O4zTIr7ubuoELGkkTnh
         qWOnPtbGJEJVhZyw5EsEvcXKBe5ol6qTyEPGLLAMWTWYdFGQRXYoBUQacqVEu6m7x254
         MtBINxreM9Gp0Ol5Pc5FQV/SzXMMpPzSp+5f1yygMOqOAng7/FMsNTG/ndYmNFrrkLni
         puw8IsbtNm34GAz24j/Au7P9PtRMNsO2SEfLqB1HCahkUcUQclSygUoccC4YEsorjR9f
         K9iITecwB75HP33s9mj/9jLAU7C0YGUG3x8LFHKxSz0prgkp5slmqPtnY1slrFaQg4Y6
         RMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699030052; x=1699634852;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BUkCHpSCoZsWvUc2JnwHfBwoEYEsmRGaKupWn4UeViA=;
        b=bX+MWpdtZOqwz5yimOtfbR+f5GVGF23mUeD/h9mUN02utvb8Vguh5NenCHPxpY1/fh
         Tlp9qu4MnmmspxwqfH6da9okNAClPEiH2nPiKCh+BV/dEKmbYp5tytubF/K8JUhkoLFk
         9pAQL+N1wmiZ6cI9rNbhUvtLML4mzKteDVlZ8hZpXhn1vaWujsXIyuCbtfGzfKPY2td9
         0xDduzrbQObjOOczO4TLeT7PLyzFVAn1yOXTzbgMU1dgd9OCOoBE7aaFQkd2rJ4XYf3r
         VzzmLniSTCkLx1Gkjb7lYm8OhF9hpPTY0JhfuzeoVk1I1Hcoel7SFzq8XIryyA4uk8SM
         BUHA==
X-Gm-Message-State: AOJu0YwseG0l52S2/udopELlX7UqVrsnb7V6sOYXFimPD2WRmAIy4FyJ
	L3bx+HloU3MCrKQB0BipzOI=
X-Google-Smtp-Source: AGHT+IHlm36KP4CiH1wnj8CCJ+OUF1vZR+u+GlDvpv5S/IgLXdYxcN/BUVS2MWvKNPCCSoc/TGlY7w==
X-Received: by 2002:a17:907:7b9d:b0:9ae:82b4:e306 with SMTP id ne29-20020a1709077b9d00b009ae82b4e306mr7859063ejc.62.1699030051990;
        Fri, 03 Nov 2023 09:47:31 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id cm7-20020a170907938700b009ddf38056f8sm16965ejc.118.2023.11.03.09.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 09:47:31 -0700 (PDT)
Message-ID: <a8b287efb678249f0dff828a724385b36923144f.camel@gmail.com>
Subject: Re: [PATCH bpf-next 02/13] bpf: generalize is_scalar_branch_taken()
 logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Fri, 03 Nov 2023 18:47:29 +0200
In-Reply-To: <20231103000822.2509815-3-andrii@kernel.org>
References: <20231103000822.2509815-1-andrii@kernel.org>
	 <20231103000822.2509815-3-andrii@kernel.org>
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

On Thu, 2023-11-02 at 17:08 -0700, Andrii Nakryiko wrote:
> Generalize is_branch_taken logic for SCALAR_VALUE register to handle
> cases when both registers are not constants. Previously supported
> <range> vs <scalar> cases are a natural subset of more generic <range>
> vs <range> set of cases.
>=20
> Generalized logic relies on straightforward segment intersection checks.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

(With the same nitpick that '<' cases could be converted to '>' cases).

> ---
>  kernel/bpf/verifier.c | 103 ++++++++++++++++++++++++++----------------
>  1 file changed, 63 insertions(+), 40 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 52934080042c..2627461164ed 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14187,82 +14187,104 @@ static int is_scalar_branch_taken(struct bpf_r=
eg_state *reg1, struct bpf_reg_sta
>  				  u8 opcode, bool is_jmp32)
>  {
>  	struct tnum t1 =3D is_jmp32 ? tnum_subreg(reg1->var_off) : reg1->var_of=
f;
> +	struct tnum t2 =3D is_jmp32 ? tnum_subreg(reg2->var_off) : reg2->var_of=
f;
>  	u64 umin1 =3D is_jmp32 ? (u64)reg1->u32_min_value : reg1->umin_value;
>  	u64 umax1 =3D is_jmp32 ? (u64)reg1->u32_max_value : reg1->umax_value;
>  	s64 smin1 =3D is_jmp32 ? (s64)reg1->s32_min_value : reg1->smin_value;
>  	s64 smax1 =3D is_jmp32 ? (s64)reg1->s32_max_value : reg1->smax_value;
> -	u64 uval =3D is_jmp32 ? (u32)tnum_subreg(reg2->var_off).value : reg2->v=
ar_off.value;
> -	s64 sval =3D is_jmp32 ? (s32)uval : (s64)uval;
> +	u64 umin2 =3D is_jmp32 ? (u64)reg2->u32_min_value : reg2->umin_value;
> +	u64 umax2 =3D is_jmp32 ? (u64)reg2->u32_max_value : reg2->umax_value;
> +	s64 smin2 =3D is_jmp32 ? (s64)reg2->s32_min_value : reg2->smin_value;
> +	s64 smax2 =3D is_jmp32 ? (s64)reg2->s32_max_value : reg2->smax_value;
> =20
>  	switch (opcode) {
>  	case BPF_JEQ:
> -		if (tnum_is_const(t1))
> -			return !!tnum_equals_const(t1, uval);
> -		else if (uval < umin1 || uval > umax1)
> +		/* constants, umin/umax and smin/smax checks would be
> +		 * redundant in this case because they all should match
> +		 */
> +		if (tnum_is_const(t1) && tnum_is_const(t2))
> +			return t1.value =3D=3D t2.value;
> +		/* const ranges */
> +		if (umin1 =3D=3D umax1 && umin2 =3D=3D umax2)
> +			return umin1 =3D=3D umin2;
> +		if (smin1 =3D=3D smax1 && smin2 =3D=3D smax2)
> +			return smin1 =3D=3D smin2;
> +		/* non-overlapping ranges */
> +		if (umin1 > umax2 || umax1 < umin2)
>  			return 0;
> -		else if (sval < smin1 || sval > smax1)
> +		if (smin1 > smax2 || smax1 < smin2)
>  			return 0;
>  		break;
>  	case BPF_JNE:
> -		if (tnum_is_const(t1))
> -			return !tnum_equals_const(t1, uval);
> -		else if (uval < umin1 || uval > umax1)
> +		/* constants, umin/umax and smin/smax checks would be
> +		 * redundant in this case because they all should match
> +		 */
> +		if (tnum_is_const(t1) && tnum_is_const(t2))
> +			return t1.value !=3D t2.value;
> +		/* non-overlapping ranges */
> +		if (umin1 > umax2 || umax1 < umin2)
>  			return 1;
> -		else if (sval < smin1 || sval > smax1)
> +		if (smin1 > smax2 || smax1 < smin2)
>  			return 1;
>  		break;
>  	case BPF_JSET:
> -		if ((~t1.mask & t1.value) & uval)
> +		if (!is_reg_const(reg2, is_jmp32)) {
> +			swap(reg1, reg2);
> +			swap(t1, t2);
> +		}
> +		if (!is_reg_const(reg2, is_jmp32))
> +			return -1;
> +		if ((~t1.mask & t1.value) & t2.value)
>  			return 1;
> -		if (!((t1.mask | t1.value) & uval))
> +		if (!((t1.mask | t1.value) & t2.value))
>  			return 0;
>  		break;
>  	case BPF_JGT:
> -		if (umin1 > uval )
> +		if (umin1 > umax2)
>  			return 1;
> -		else if (umax1 <=3D uval)
> +		else if (umax1 <=3D umin2)
>  			return 0;
>  		break;
>  	case BPF_JSGT:
> -		if (smin1 > sval)
> +		if (smin1 > smax2)
>  			return 1;
> -		else if (smax1 <=3D sval)
> +		else if (smax1 <=3D smin2)
>  			return 0;
>  		break;
>  	case BPF_JLT:
> -		if (umax1 < uval)
> +		if (umax1 < umin2)
>  			return 1;
> -		else if (umin1 >=3D uval)
> +		else if (umin1 >=3D umax2)
>  			return 0;
>  		break;
>  	case BPF_JSLT:
> -		if (smax1 < sval)
> +		if (smax1 < smin2)
>  			return 1;
> -		else if (smin1 >=3D sval)
> +		else if (smin1 >=3D smax2)
>  			return 0;
>  		break;
>  	case BPF_JGE:
> -		if (umin1 >=3D uval)
> +		if (umin1 >=3D umax2)
>  			return 1;
> -		else if (umax1 < uval)
> +		else if (umax1 < umin2)
>  			return 0;
>  		break;
>  	case BPF_JSGE:
> -		if (smin1 >=3D sval)
> +		if (smin1 >=3D smax2)
>  			return 1;
> -		else if (smax1 < sval)
> +		else if (smax1 < smin2)
>  			return 0;
>  		break;
>  	case BPF_JLE:
> -		if (umax1 <=3D uval)
> +		if (umax1 <=3D umin2)
>  			return 1;
> -		else if (umin1 > uval)
> +		else if (umin1 > umax2)
>  			return 0;
>  		break;
>  	case BPF_JSLE:
> -		if (smax1 <=3D sval)
> +		if (smax1 <=3D smin2)
>  			return 1;
> -		else if (smin1 > sval)
> +		else if (smin1 > smax2)
>  			return 0;
>  		break;
>  	}
> @@ -14341,28 +14363,28 @@ static int is_pkt_ptr_branch_taken(struct bpf_r=
eg_state *dst_reg,
>  static int is_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_st=
ate *reg2,
>  			   u8 opcode, bool is_jmp32)
>  {
> -	u64 val;
> -
>  	if (reg_is_pkt_pointer_any(reg1) && reg_is_pkt_pointer_any(reg2) && !is=
_jmp32)
>  		return is_pkt_ptr_branch_taken(reg1, reg2, opcode);
> =20
> -	/* try to make sure reg2 is a constant SCALAR_VALUE */
> -	if (!is_reg_const(reg2, is_jmp32)) {
> -		opcode =3D flip_opcode(opcode);
> -		swap(reg1, reg2);
> -	}
> -	/* for now we expect reg2 to be a constant to make any useful decisions=
 */
> -	if (!is_reg_const(reg2, is_jmp32))
> -		return -1;
> -	val =3D reg_const_value(reg2, is_jmp32);
> +	if (__is_pointer_value(false, reg1) || __is_pointer_value(false, reg2))=
 {
> +		u64 val;
> +
> +		/* arrange that reg2 is a scalar, and reg1 is a pointer */
> +		if (!is_reg_const(reg2, is_jmp32)) {
> +			opcode =3D flip_opcode(opcode);
> +			swap(reg1, reg2);
> +		}
> +		/* and ensure that reg2 is a constant */
> +		if (!is_reg_const(reg2, is_jmp32))
> +			return -1;
> =20
> -	if (__is_pointer_value(false, reg1)) {
>  		if (!reg_not_null(reg1))
>  			return -1;
> =20
>  		/* If pointer is valid tests against zero will fail so we can
>  		 * use this to direct branch taken.
>  		 */
> +		val =3D reg_const_value(reg2, is_jmp32);
>  		if (val !=3D 0)
>  			return -1;
> =20
> @@ -14376,6 +14398,7 @@ static int is_branch_taken(struct bpf_reg_state *=
reg1, struct bpf_reg_state *reg
>  		}
>  	}
> =20
> +	/* now deal with two scalars, but not necessarily constants */
>  	return is_scalar_branch_taken(reg1, reg2, opcode, is_jmp32);
>  }
> =20


