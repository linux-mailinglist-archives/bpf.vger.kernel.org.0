Return-Path: <bpf+bounces-78828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8A3D1C40B
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 04:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5193B3039316
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 03:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FDF31AA90;
	Wed, 14 Jan 2026 03:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjG4WYfF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2168031ED89
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 03:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768361266; cv=none; b=sQb0n82z4FVqOa4y/kg2xGrDR4iLbSOLCF8GDLh3CywTunoAHJSfolZsKpfrKKkOHCBX839Bc1+zkCjxefKVRVYh2DWVrl5aPA/hjHzIRJzvCqtjPY33MaDz1Mx+EtfKWmFwJd04IG7qVh8m+PYP3mxIPA8CnbTUIIPq+fvoljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768361266; c=relaxed/simple;
	bh=8mNY6g9Pk4w0ZE3/wVnCgenXoQzAvY6CzsdoInH/2hs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BDwqM92rVEWR6sZbb8i8hHPCF1rchviuZcnqVkLfNdrJN2GVoH3THevMaZp2mXq5jv5nkGj1jAAJ/0n7w9NEzooufJ75rck48wxocwzBWh3aXT0iPK64Klhtrry4AP2itfOdUiMwhQ13yxf/SnoglCiBu+7KWXTW82W4o57WObU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjG4WYfF; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7f216280242so148967b3a.1
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 19:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768361262; x=1768966062; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0uwrrvcz36A0fx0g1CZ7nBZbIT5tluCTaaTAY3GGdE0=;
        b=WjG4WYfFBjnOQWrhYtiuB3lsBZs8YraErE+mr8dXl6MQc/VBpP7QbFHhAdyxG7t5d4
         aj7cbDz5lgEhdysiK57LUSbryuOcmYcFaV73TwFwO2vYGPIcAMwq8vV7/NfaUebDni7N
         R+4ib6kLWkxJmFm6+6pxzI+oVvQt9rWqumelj87DsPiOXa5+LhxcqcjtnTXmyFWjVG7z
         GEFGs3ogzSBAvgVl+DiBvgNXvGeg/BVaVUIBxTB9N8Zssl2RyP/7pypl469jGWSoYPeL
         rK16ABNWucC/8JtepKzHyoojhh+Tgd6Vh7rMuHufEU1/VyvtSj2lHEv5l62VVL0nVP2G
         tbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768361262; x=1768966062;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0uwrrvcz36A0fx0g1CZ7nBZbIT5tluCTaaTAY3GGdE0=;
        b=Fq0Jswoc6OTWmVvF+IaTS+YEwx8pLTifA1dtOqhbb5tMm2UB/+c8R+JnPnTrtkIuya
         +Iisx2R+unsl5zFk5450Iv6XzSUf1g274uv/jUayIU1/Z85dshakx1JMocvjRlJYAX0v
         x/wqxO9vaG7yYjqQgwtnWTmp4r4HfskpSWfw4xsqGswLKDOQosRLA6dCDrDew1uNNBsX
         BOydavaHhRiYTf7kg+Jp68C1X+C1HSdfTtAHgBO9063Rpgw+Zztdda8hS7/3S6FnJiwV
         aoxrdHO975lu/2TXu1PS2DVtWlLa1oxKh+/+P+7U+JnBhPi8GZKejd0nmFaPqz/I9AKN
         wWxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/fwVwgBfjHHRNoJvFC2V7ycHQ2vJbghZ9R4r/ZQu0I7CCHNLR1HzrO3+1SpdGwdvjJl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtPXNUOUPDYK8PlIhy2+YdoDW1JsrrkxqL1rVgTQLycC9nQZoD
	nf3H74G9uQ8tl4ufzjqKb+H2QIPq7dBZGlUtjBBbKU3vrMQV4T7o0R5f
X-Gm-Gg: AY/fxX6QxtLAiV9/XMA+PsxK5iFN1h60HIDX2KJz5K1a3HxsL2bnOosuGoEf/PCRW4w
	59cStQmSofNlr1yzknC/EN03SPuiRg9Blyp7mXB/9YbcQNpwOpR66jKPVDLzv0beuxgJmn+BHFJ
	cujKjZR4U5hG2IpTEkdy5BoMHhzXSWu88zCFhhWU9Uc4eq4vnESlTq0TbiC76PDAze2ErfMEzon
	ulb/38HvEFbyD7mO+fmz+4BvQDezyzsa6o1VwyuchTY7ZzrOOX9jpw/ZEJym5p/zNSpOBaAa+W4
	Cs2ZssNoDJJ7deh0AohV0mMyoByYSkZH7NnDUuH9hm85glK0dvYcvwVkMrElGZAsblcPmGs2yfR
	9qTaQh/pOj/VY36iipn2h6hsAGxeifuWBBK9EfbO8TFZPmohH/83/sLJkFKHjteMDhzg42JCerv
	GWabR99Z/8/Ne5HwC2q+CERdwqDVZmVUNt+LYJx7m9
X-Received: by 2002:a05:6a20:6a0e:b0:35f:5896:859b with SMTP id adf61e73a8af0-38bed2cc54bmr1334041637.4.1768361262379;
        Tue, 13 Jan 2026 19:27:42 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc02ecfccsm20995773a12.13.2026.01.13.19.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 19:27:41 -0800 (PST)
Message-ID: <0f112826107932ab0a6c897505e9e4c13c999527.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Support negative offsets, BPF_SUB,
 and alu32 for linked register tracking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Date: Tue, 13 Jan 2026 19:27:39 -0800
In-Reply-To: <20260113152529.3217648-2-puranjay@kernel.org>
References: <20260113152529.3217648-1-puranjay@kernel.org>
	 <20260113152529.3217648-2-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-01-13 at 07:25 -0800, Puranjay Mohan wrote:

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 53635ea2e41b..8a4f00d237ee 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15706,26 +15706,41 @@ static int adjust_reg_min_max_vals(struct bpf_v=
erifier_env *env,
>  	 * r1 +=3D 0x1
>  	 * if r2 < 1000 goto ...
>  	 * use r1 in memory access
> -	 * So for 64-bit alu remember constant delta between r2 and r1 and
> -	 * update r1 after 'if' condition.
> +	 * So remember constant delta between r2 and r1 and update r1 after
> +	 * 'if' condition.
>  	 */
>  	if (env->bpf_capable &&
> -	    BPF_OP(insn->code) =3D=3D BPF_ADD && !alu32 &&
> -	    dst_reg->id && is_reg_const(src_reg, false)) {
> -		u64 val =3D reg_const_value(src_reg, false);
> +	    (BPF_OP(insn->code) =3D=3D BPF_ADD || BPF_OP(insn->code) =3D=3D BPF=
_SUB) &&
> +	    dst_reg->id && is_reg_const(src_reg, alu32)) {
> +		u64 val =3D reg_const_value(src_reg, alu32);
> +		s32 off;
>
> -		if ((dst_reg->id & BPF_ADD_CONST) ||
> -		    /* prevent overflow in sync_linked_regs() later */
> -		    val > (u32)S32_MAX) {
> +		if (!alu32 && ((s64)val < S32_MIN || (s64)val > S32_MAX))
> +			goto clear_id;
> +
> +		off =3D (s32)val;
> +
> +		if (BPF_OP(insn->code) =3D=3D BPF_SUB) {
> +			/* Negating S32_MIN would overflow */
> +			if (off =3D=3D S32_MIN)
> +				goto clear_id;
> +			off =3D -off;
> +		}
> +
> +		if (dst_reg->id & BPF_ADD_CONST) {

This logic is not correct, consider the following example:

    SEC("socket")
    __success
    __naked void bug1(void)
    {
            asm volatile ("                                 \
            call %[bpf_get_prandom_u32];                    \
            r1 =3D r0;                                        \
            w1 +=3D 1;                                        \
            if r1 > 10 goto 1f;                             \
            r0 >>=3D 32;                                      \
            if r0 =3D=3D 0 goto 1f;                             \
            r0 /=3D 0;                                        \
    1:                                                      \
            r0 =3D 0;                                         \
            exit;                                           \
    "       :
            : __imm(bpf_get_prandom_u32)
            : __clobber_all);
    }

It is verified as follows:

    Global function bug1() doesn't return scalar. Only those are supported.
    0: R1=3Dctx() R10=3Dfp0
    ; asm volatile ("                                       \ @ verifier_li=
nked_scalars.c:266
    0: (85) call bpf_get_prandom_u32#7    ; R0=3Dscalar()
    1: (bf) r1 =3D r0                       ; R0=3Dscalar(id=3D1) R1=3Dscal=
ar(id=3D1)
    2: (04) w1 +=3D 1                       ; R1=3Dscalar(id=3D1+1,smin=3D0=
,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff))
    3: (25) if r1 > 0xa goto pc+3         ; R1=3Dscalar(id=3D1+1,smin=3Dsmi=
n32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D10,var_off=3D(0x0; 0xf))
    4: (77) r0 >>=3D 32                     ; R0=3D0
    5: (15) if r0 =3D=3D 0x0 goto pc+1
    mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1
    mark_precise: frame0: regs=3Dr0 stack=3D before 4: (77) r0 >>=3D 32
    mark_precise: frame0: regs=3Dr0 stack=3D before 3: (25) if r1 > 0xa got=
o pc+3
    mark_precise: frame0: regs=3Dr0,r1 stack=3D before 2: (04) w1 +=3D 1
    mark_precise: frame0: regs=3Dr0,r1 stack=3D before 1: (bf) r1 =3D r0
    mark_precise: frame0: regs=3Dr0 stack=3D before 0: (85) call bpf_get_pr=
andom_u32#7
    5: R0=3D0
    7: (b7) r0 =3D 0                        ; R0=3D0
    8: (95) exit

    from 3 to 7: R0=3Dscalar(id=3D1+0,smin=3D0,smax=3D0xffffffff,umin=3Dumi=
n32=3D10,umax=3Dumax32=3D0xfffffffe,var_off=3D(0x0; 0xffffffff)) R1=3Dscala=
r(id=3D1+1,smin=3Dumin=3Dumin32=3D11,smax=3Dumax=3D0xffffffff,var_off=3D(0x=
0; 0xffffffff)) R10=3Dfp0
    7: R0=3Dscalar(id=3D1+0,smin=3D0,smax=3D0xffffffff,umin=3Dumin32=3D10,u=
max=3Dumax32=3D0xfffffffe,var_off=3D(0x0; 0xffffffff)) R1=3Dscalar(id=3D1+1=
,smin=3Dumin=3Dumin32=3D11,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xfffff=
fff)) R10=3Dfp0
    7: (b7) r0 =3D 0                        ; R0=3D0
    8: (95) exit
    processed 10 insns (limit 1000000) max_states_per_insn 0 total_states 1=
 peak_states 1 mark_read 0

The problem here is that at instruction `2: w1 +=3D 1` id of the
register is preserved, while this instruction destructs higher bits of
the register.

After each instruction you must maintain that for a set of linked registers=
 R
=E2=88=80 r =E2=88=88 R: value(r) - off(r) =3D=3D C, where C is some consta=
nt representing the id.
This is not the case for operation `w1 +=3D 1` if you don't make sure
prior to the operation that upper bits of `r1` are zero.

>  			/*
>  			 * If the register already went through rX +=3D val
>  			 * we cannot accumulate another val into rx->off.
>  			 */
> +clear_id:
>  			dst_reg->off =3D 0;
>  			dst_reg->id =3D 0;
>  		} else {
> -			dst_reg->id |=3D BPF_ADD_CONST;
> -			dst_reg->off =3D val;
> +			if (alu32)
> +				dst_reg->id |=3D BPF_ADD_CONST32;
> +			else
> +				dst_reg->id |=3D BPF_ADD_CONST64;
> +			dst_reg->off =3D off;
>  		}
>  	} else {
>  		/*

[...]

