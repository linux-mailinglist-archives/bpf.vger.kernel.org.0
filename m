Return-Path: <bpf+bounces-13731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 242187DD4C4
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 18:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2E84B20FEA
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 17:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C82208B8;
	Tue, 31 Oct 2023 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUDfqkny"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E651C69D
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 17:36:01 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B7F92
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 10:35:59 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so9734768a12.2
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 10:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698773757; x=1699378557; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8u5fKI2vIRrKkL6s+X+hVFi8/cfi+4ovS5+OP/JiK6Y=;
        b=BUDfqknyuL1Vn9hbRgztAb5ELSNXEzhUyQF3aEqlVehF1yj1NwY2fyMhU5XweGmgGt
         FqN0IxmiFUjkW3H9n5BWC57WWrbVf6TNJFdxuGTfjiDCxrojxTzh8kzLU3mLzpc2uDsu
         5cJEdGq/WHOw9/SvlYGtET9ICetNhMAYHH/s0gEqoZonjfkzAKXf4FehDdSvnouPtxWu
         ZWz3zW1feFAY76WAtHWXiuK4lhjLjALsWiM2VfQZ64YhxqaI6wUGjCZ2dD58502kpxnz
         dUvsIBAiwpiuBFpjMVDO+xoaF8IH1GO/LV+CqwfaX8iiOfZvszlcc2JdvQ8VDiIJ2rmP
         f26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698773757; x=1699378557;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8u5fKI2vIRrKkL6s+X+hVFi8/cfi+4ovS5+OP/JiK6Y=;
        b=s7a93AuURiq3dcOBOXWwqAMCmrrCgoHeyHwfsC7zkh0Zftk0KcoPfwomKP94HYmSSN
         eWTNAGfEN9t8fMXpe9NPozF+V0uxSCUb6nPqG9t9vT9Eg1izm+WVLyaTiqgUbs5F87k3
         WFgrzCX0BRc0MYOc+zEacTZLH9+aALcROQa1TUkc10tX2npCI3ZOEirUmhV9qWwxHv7u
         1BVjsopa4y9zOY26mk18XQDbgnLCD+QknAYky4x0L/tgdyEJ2/FWOuj+1JrAHV2F2VAa
         RJ2r4JMLCpVnLWTx/Km0+8AKRO+Rdtf4JF8n0Bqnv3NtHbm5hhibNDVybJ93fTXn/2F+
         jk+w==
X-Gm-Message-State: AOJu0Yxjyk/sNDGORBVWPGQMUguiGVr+EZgsv9ZCT4ITU9WD6dHFbIzg
	NWsRV4fGvcC1SUpKDJ97Yo4=
X-Google-Smtp-Source: AGHT+IFvIha5cHT92hLTBFMmIi+nAVFlRLzt5Gfysujf8g1bBBAjij80Ge4nUAOxywy8j1byhQ8F1w==
X-Received: by 2002:a17:907:7288:b0:9bd:b8d0:c096 with SMTP id dt8-20020a170907728800b009bdb8d0c096mr24845ejc.21.1698773757172;
        Tue, 31 Oct 2023 10:35:57 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z5-20020a170906714500b009a193a5acffsm1299818ejj.121.2023.10.31.10.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:35:56 -0700 (PDT)
Message-ID: <858e9646b67cb3676a8fdc6f37af5526b26a57aa.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 15/23] bpf: unify 32-bit and 64-bit
 is_branch_taken logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Tue, 31 Oct 2023 19:35:50 +0200
In-Reply-To: <20231027181346.4019398-16-andrii@kernel.org>
References: <20231027181346.4019398-1-andrii@kernel.org>
	 <20231027181346.4019398-16-andrii@kernel.org>
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
> Combine 32-bit and 64-bit is_branch_taken logic for SCALAR_VALUE
> registers. It makes it easier to see parallels between two domains
> (32-bit and 64-bit), and makes subsequent refactoring more
> straightforward.
>=20
> No functional changes.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> ---
>  kernel/bpf/verifier.c | 154 ++++++++++--------------------------------
>  1 file changed, 36 insertions(+), 118 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fedd6d0e76e5..b911d1111fad 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14185,166 +14185,86 @@ static u64 reg_const_value(struct bpf_reg_stat=
e *reg, bool subreg32)
>  /*
>   * <reg1> <op> <reg2>, currently assuming reg2 is a constant
>   */
> -static int is_branch32_taken(struct bpf_reg_state *reg1, struct bpf_reg_=
state *reg2, u8 opcode)
> +static int is_scalar_branch_taken(struct bpf_reg_state *reg1, struct bpf=
_reg_state *reg2,
> +				  u8 opcode, bool is_jmp32)
>  {
> -	struct tnum subreg =3D tnum_subreg(reg1->var_off);
> -	u32 val =3D (u32)tnum_subreg(reg2->var_off).value;
> -	s32 sval =3D (s32)val;
> +	struct tnum t1 =3D is_jmp32 ? tnum_subreg(reg1->var_off) : reg1->var_of=
f;
> +	u64 umin1 =3D is_jmp32 ? (u64)reg1->u32_min_value : reg1->umin_value;
> +	u64 umax1 =3D is_jmp32 ? (u64)reg1->u32_max_value : reg1->umax_value;
> +	s64 smin1 =3D is_jmp32 ? (s64)reg1->s32_min_value : reg1->smin_value;
> +	s64 smax1 =3D is_jmp32 ? (s64)reg1->s32_max_value : reg1->smax_value;
> +	u64 val =3D is_jmp32 ? (u32)tnum_subreg(reg2->var_off).value : reg2->va=
r_off.value;
> +	s64 sval =3D is_jmp32 ? (s32)val : (s64)val;
> =20
>  	switch (opcode) {
>  	case BPF_JEQ:
> -		if (tnum_is_const(subreg))
> -			return !!tnum_equals_const(subreg, val);
> -		else if (val < reg1->u32_min_value || val > reg1->u32_max_value)
> +		if (tnum_is_const(t1))
> +			return !!tnum_equals_const(t1, val);
> +		else if (val < umin1 || val > umax1)
>  			return 0;
> -		else if (sval < reg1->s32_min_value || sval > reg1->s32_max_value)
> +		else if (sval < smin1 || sval > smax1)
>  			return 0;
>  		break;
>  	case BPF_JNE:
> -		if (tnum_is_const(subreg))
> -			return !tnum_equals_const(subreg, val);
> -		else if (val < reg1->u32_min_value || val > reg1->u32_max_value)
> +		if (tnum_is_const(t1))
> +			return !tnum_equals_const(t1, val);
> +		else if (val < umin1 || val > umax1)
>  			return 1;
> -		else if (sval < reg1->s32_min_value || sval > reg1->s32_max_value)
> +		else if (sval < smin1 || sval > smax1)
>  			return 1;
>  		break;
>  	case BPF_JSET:
> -		if ((~subreg.mask & subreg.value) & val)
> +		if ((~t1.mask & t1.value) & val)
>  			return 1;
> -		if (!((subreg.mask | subreg.value) & val))
> +		if (!((t1.mask | t1.value) & val))
>  			return 0;
>  		break;
>  	case BPF_JGT:
> -		if (reg1->u32_min_value > val)
> +		if (umin1 > val )
>  			return 1;
> -		else if (reg1->u32_max_value <=3D val)
> +		else if (umax1 <=3D val)
>  			return 0;
>  		break;
>  	case BPF_JSGT:
> -		if (reg1->s32_min_value > sval)
> +		if (smin1 > sval)
>  			return 1;
> -		else if (reg1->s32_max_value <=3D sval)
> +		else if (smax1 <=3D sval)
>  			return 0;
>  		break;
>  	case BPF_JLT:
> -		if (reg1->u32_max_value < val)
> +		if (umax1 < val)
>  			return 1;
> -		else if (reg1->u32_min_value >=3D val)
> +		else if (umin1 >=3D val)
>  			return 0;
>  		break;
>  	case BPF_JSLT:
> -		if (reg1->s32_max_value < sval)
> +		if (smax1 < sval)
>  			return 1;
> -		else if (reg1->s32_min_value >=3D sval)
> +		else if (smin1 >=3D sval)
>  			return 0;
>  		break;
>  	case BPF_JGE:
> -		if (reg1->u32_min_value >=3D val)
> +		if (umin1 >=3D val)
>  			return 1;
> -		else if (reg1->u32_max_value < val)
> +		else if (umax1 < val)
>  			return 0;
>  		break;
>  	case BPF_JSGE:
> -		if (reg1->s32_min_value >=3D sval)
> +		if (smin1 >=3D sval)
>  			return 1;
> -		else if (reg1->s32_max_value < sval)
> +		else if (smax1 < sval)
>  			return 0;
>  		break;
>  	case BPF_JLE:
> -		if (reg1->u32_max_value <=3D val)
> +		if (umax1 <=3D val)
>  			return 1;
> -		else if (reg1->u32_min_value > val)
> +		else if (umin1 > val)
>  			return 0;
>  		break;
>  	case BPF_JSLE:
> -		if (reg1->s32_max_value <=3D sval)
> +		if (smax1 <=3D sval)
>  			return 1;
> -		else if (reg1->s32_min_value > sval)
> -			return 0;
> -		break;
> -	}
> -
> -	return -1;
> -}
> -
> -
> -/*
> - * <reg1> <op> <reg2>, currently assuming reg2 is a constant
> - */
> -static int is_branch64_taken(struct bpf_reg_state *reg1, struct bpf_reg_=
state *reg2, u8 opcode)
> -{
> -	u64 val =3D reg2->var_off.value;
> -	s64 sval =3D (s64)val;
> -
> -	switch (opcode) {
> -	case BPF_JEQ:
> -		if (tnum_is_const(reg1->var_off))
> -			return !!tnum_equals_const(reg1->var_off, val);
> -		else if (val < reg1->umin_value || val > reg1->umax_value)
> -			return 0;
> -		else if (sval < reg1->smin_value || sval > reg1->smax_value)
> -			return 0;
> -		break;
> -	case BPF_JNE:
> -		if (tnum_is_const(reg1->var_off))
> -			return !tnum_equals_const(reg1->var_off, val);
> -		else if (val < reg1->umin_value || val > reg1->umax_value)
> -			return 1;
> -		else if (sval < reg1->smin_value || sval > reg1->smax_value)
> -			return 1;
> -		break;
> -	case BPF_JSET:
> -		if ((~reg1->var_off.mask & reg1->var_off.value) & val)
> -			return 1;
> -		if (!((reg1->var_off.mask | reg1->var_off.value) & val))
> -			return 0;
> -		break;
> -	case BPF_JGT:
> -		if (reg1->umin_value > val)
> -			return 1;
> -		else if (reg1->umax_value <=3D val)
> -			return 0;
> -		break;
> -	case BPF_JSGT:
> -		if (reg1->smin_value > sval)
> -			return 1;
> -		else if (reg1->smax_value <=3D sval)
> -			return 0;
> -		break;
> -	case BPF_JLT:
> -		if (reg1->umax_value < val)
> -			return 1;
> -		else if (reg1->umin_value >=3D val)
> -			return 0;
> -		break;
> -	case BPF_JSLT:
> -		if (reg1->smax_value < sval)
> -			return 1;
> -		else if (reg1->smin_value >=3D sval)
> -			return 0;
> -		break;
> -	case BPF_JGE:
> -		if (reg1->umin_value >=3D val)
> -			return 1;
> -		else if (reg1->umax_value < val)
> -			return 0;
> -		break;
> -	case BPF_JSGE:
> -		if (reg1->smin_value >=3D sval)
> -			return 1;
> -		else if (reg1->smax_value < sval)
> -			return 0;
> -		break;
> -	case BPF_JLE:
> -		if (reg1->umax_value <=3D val)
> -			return 1;
> -		else if (reg1->umin_value > val)
> -			return 0;
> -		break;
> -	case BPF_JSLE:
> -		if (reg1->smax_value <=3D sval)
> -			return 1;
> -		else if (reg1->smin_value > sval)
> +		else if (smin1 > sval)
>  			return 0;
>  		break;
>  	}
> @@ -14458,9 +14378,7 @@ static int is_branch_taken(struct bpf_reg_state *=
reg1, struct bpf_reg_state *reg
>  		}
>  	}
> =20
> -	if (is_jmp32)
> -		return is_branch32_taken(reg1, reg2, opcode);
> -	return is_branch64_taken(reg1, reg2, opcode);
> +	return is_scalar_branch_taken(reg1, reg2, opcode, is_jmp32);
>  }
> =20
>  /* Adjusts the register min/max values in the case that the dst_reg is t=
he


