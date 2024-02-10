Return-Path: <bpf+bounces-21673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B5185016A
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 02:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A011F26090
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 01:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE39A1FD7;
	Sat, 10 Feb 2024 01:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOVf/HWn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6501FB3
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 01:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707527606; cv=none; b=VtiyWZQfKFu/bBO7HUINE1lNsR8YYSujYqdP4Qshp62gBa9gH6/lckZ6xLzTLUxWwhVnwhGIMKuVCygPuHUDnLf8kVlIFdKD6f0ezIjQC9zU0UK1NjPIfDZMMJEZYja26ppOHU6aZZq2zEM8RrDvGDgp1BCdW79iWaqy7rlj4TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707527606; c=relaxed/simple;
	bh=WzrxGAbpq2U1V8luRoXwz3CFwQRz7m9QG5xoPq98Zi8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OigGfckDktBdm0KCCrXj3TNvG4z9dUkyGJOiwgd6p+AIJT76pRoBqNr2MBOgehEURmaGxWiMIu62FCS0KgRX2t4y/NWC6ZTtHiWtfXtE4o6BYvFC0HRpH86TVioEoMPQx5+FUkKSDjE6Qiu6Z9nsGS57x4PUrZ8hhx6NCu8uAY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOVf/HWn; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3832ef7726so185908966b.0
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 17:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707527603; x=1708132403; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ji1u7BeI14ZwqfT4KGeJL8Zv5/8UnX+AUOOMw1FTRC4=;
        b=VOVf/HWn4lycU6kUG8NoUmQ5uQSo1wq919tomcwL0G95jRyN1DD1W+DPRWH1syXwCZ
         9M44cJl8U4tY1Q0gSlJN6pXJW6hALkuF0gmkuqF8l3IJskwd/J+9S4VtlNY10RraFnjb
         HzmnTnsQov8IRGxD/33tv5NaFmT3hkHLZqnJO+ECs6vjWmg51N2dm7PDXMrbPXyuT/VK
         YTzOsmd4jhWV2ueQEfFw3D19Re4VP5i584kCKqy1ZXlMT+XPn3n5nygdNAfX+C4SOx7F
         l3Sv7BAWjsjQqn2LcBtdTqRkvHSXJunit0OssFLCXgEkKftbj9+JrNXNay2oRPZciL0K
         Ro+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707527603; x=1708132403;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ji1u7BeI14ZwqfT4KGeJL8Zv5/8UnX+AUOOMw1FTRC4=;
        b=iyYbHpcwzErok0/7vycYdzcg1Z/GgnqrB/zkuLgJdINZEZlHslK5q23arasF2En/i9
         iUxebinpUNJs6lXSzkB/873ygqYK+w69TQgPL5/3LHDrREfKbxJu4362EEegN0BItrDZ
         5XxozhXeQYJwB5ASOcQcKcvAlpxpTQN2YKldaRBX/GiYaK2XKntHoYuq+SC7nmhflNqB
         AvfaLJcf9qHt7eo7eYPVJZ+FCAyfHpcXGbvW+STgF8U+rfs2hGChVWzFzLFhPM3VxYyT
         JmHv9y+rFmN7PCiPeJYZ02VEWmiaOfHNqEtLU+tQKqxq7qHZ798jJKS+EJKTGaTGhRLV
         Avcg==
X-Forwarded-Encrypted: i=1; AJvYcCWWIkBoK4zvau6ElsTPnvlW3JyXpFyzAtMyYow+xBzNAAaV9SEKzuEZ+vGnMJbO5KkWxEiTo8sIux6K/oZcI9bwF0aL
X-Gm-Message-State: AOJu0YwkWaf6SKPzOpRoyvXfCT/LhbyiG+W49LZ4PS41mIM7hZGQk2B7
	JE1rDrRv3l/BUEL2FvILMsbDjDfPk1yQ8r7VJ1h8sOoF1U+zPWdNTMxG9YoSZs0=
X-Google-Smtp-Source: AGHT+IG1m0N3Dsd/+4G2398oFE8S7/7iiYkH1N27l+MBlp8C4h1dMOYH0G2gPRAOwtPzOZA3eld7UA==
X-Received: by 2002:a17:907:3354:b0:a3c:809:c10c with SMTP id yr20-20020a170907335400b00a3c0809c10cmr419825ejb.22.1707527602644;
        Fri, 09 Feb 2024 17:13:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWunIhWfgctJLaAuxiAFrSOi7RUwEbF5vIBjYTaKmQufuW88myfeRFsMn2p7krybSrOc7lOGYm7ym6rO45ANoY29ujX29ieCrjCggzoxosQIFfU7av9ABUlLWKisX34wMR8zYQyCowtTKIPJuHaYXlM3D+2v+gfGQUDXzjHsZvHmnTlt575tCVYK3SC3js+5t3HX1LW9Kzz3n3Ji8uqFXn0dxr1kF5ybZ0ogKK+wcxEcsHdi1H9wstVK8UFFNq69uIBCgdYDj8ZJb0vVQ7hJbhxogTyeGl6sF7reFgRLeW5qZjGnuBM/Hh3e+kG9KxgGr7sJOQHeSfD7jWpAC1MuKl3UAKdKrTQGyeJGFDoXoUrXW8UtWIqWqNm
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id cx9-20020a170907168900b00a3bdf8ae86asm1283984ejd.10.2024.02.09.17.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 17:13:22 -0800 (PST)
Message-ID: <ed656ef900c33cb1bf9ffb06d0f4f59d7708e29c.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 09/20] bpf: Recognize cast_kern/user
 instructions in the verifier.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 tj@kernel.org,  brho@google.com, hannes@cmpxchg.org, lstoakes@gmail.com,
 akpm@linux-foundation.org,  urezki@gmail.com, hch@infradead.org,
 linux-mm@kvack.org, kernel-team@fb.com
Date: Sat, 10 Feb 2024 03:13:20 +0200
In-Reply-To: <20240209040608.98927-10-alexei.starovoitov@gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
	 <20240209040608.98927-10-alexei.starovoitov@gmail.com>
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

On Thu, 2024-02-08 at 20:05 -0800, Alexei Starovoitov wrote:
[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3c77a3ab1192..5eeb9bf7e324 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[...]

> @@ -13837,6 +13844,21 @@ static int adjust_reg_min_max_vals(struct bpf_ve=
rifier_env *env,
> =20
>  	dst_reg =3D &regs[insn->dst_reg];
>  	src_reg =3D NULL;
> +
> +	if (dst_reg->type =3D=3D PTR_TO_ARENA) {
> +		struct bpf_insn_aux_data *aux =3D cur_aux(env);
> +
> +		if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64)
> +			/*
> +			 * 32-bit operations zero upper bits automatically.
> +			 * 64-bit operations need to be converted to 32.
> +			 */
> +			aux->needs_zext =3D true;

It should be possible to write an example, when the same insn is
visited with both PTR_TO_ARENA and some other PTR type.
Such examples should be rejected as is currently done in do_check()
for BPF_{ST,STX} using save_aux_ptr_type().

[...]

> @@ -13954,16 +13976,17 @@ static int check_alu_op(struct bpf_verifier_env=
 *env, struct bpf_insn *insn)
>  	} else if (opcode =3D=3D BPF_MOV) {
> =20
>  		if (BPF_SRC(insn->code) =3D=3D BPF_X) {
> -			if (insn->imm !=3D 0) {
> -				verbose(env, "BPF_MOV uses reserved fields\n");
> -				return -EINVAL;
> -			}
> -
>  			if (BPF_CLASS(insn->code) =3D=3D BPF_ALU) {
> -				if (insn->off !=3D 0 && insn->off !=3D 8 && insn->off !=3D 16) {
> +				if ((insn->off !=3D 0 && insn->off !=3D 8 && insn->off !=3D 16) ||
> +				    insn->imm) {
>  					verbose(env, "BPF_MOV uses reserved fields\n");
>  					return -EINVAL;
>  				}
> +			} else if (insn->off =3D=3D BPF_ARENA_CAST_KERN || insn->off =3D=3D B=
PF_ARENA_CAST_USER) {
> +				if (!insn->imm) {
> +					verbose(env, "cast_kern/user insn must have non zero imm32\n");
> +					return -EINVAL;
> +				}
>  			} else {
>  				if (insn->off !=3D 0 && insn->off !=3D 8 && insn->off !=3D 16 &&
>  				    insn->off !=3D 32) {

I think it is now necessary to check insn->imm here,
as is it allows ALU64 move with non-zero imm.

> @@ -13993,7 +14016,12 @@ static int check_alu_op(struct bpf_verifier_env =
*env, struct bpf_insn *insn)
>  			struct bpf_reg_state *dst_reg =3D regs + insn->dst_reg;
> =20
>  			if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64) {
> -				if (insn->off =3D=3D 0) {
> +				if (insn->imm) {
> +					/* off =3D=3D BPF_ARENA_CAST_KERN || off =3D=3D BPF_ARENA_CAST_USER=
 */
> +					mark_reg_unknown(env, regs, insn->dst_reg);
> +					if (insn->off =3D=3D BPF_ARENA_CAST_KERN)
> +						dst_reg->type =3D PTR_TO_ARENA;

This effectively allows casting anything to PTR_TO_ARENA.
Do we want to check that src_reg somehow originates from arena?
Might be tricky, a new type modifier bit or something like that.

> +				} else if (insn->off =3D=3D 0) {
>  					/* case: R1 =3D R2
>  					 * copy register state to dest reg
>  					 */
> @@ -14059,6 +14087,9 @@ static int check_alu_op(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
>  						dst_reg->subreg_def =3D env->insn_idx + 1;
>  						coerce_subreg_to_size_sx(dst_reg, insn->off >> 3);
>  					}
> +				} else if (src_reg->type =3D=3D PTR_TO_ARENA) {
> +					mark_reg_unknown(env, regs, insn->dst_reg);
> +					dst_reg->type =3D PTR_TO_ARENA;

This describes a case wX =3D wY, where rY is PTR_TO_ARENA,
should rX be marked as SCALAR instead of PTR_TO_ARENA?

[...]

> @@ -18235,6 +18272,31 @@ static int resolve_pseudo_ldimm64(struct bpf_ver=
ifier_env *env)
>  				fdput(f);
>  				return -EBUSY;
>  			}
> +			if (map->map_type =3D=3D BPF_MAP_TYPE_ARENA) {
> +				if (env->prog->aux->arena) {

Does this have to be (env->prog->aux->arena && env->prog->aux->arena !=3D m=
ap) ?

> +					verbose(env, "Only one arena per program\n");
> +					fdput(f);
> +					return -EBUSY;
> +				}

[...]

> @@ -18799,6 +18861,18 @@ static int convert_ctx_accesses(struct bpf_verif=
ier_env *env)
>  			   insn->code =3D=3D (BPF_ST | BPF_MEM | BPF_W) ||
>  			   insn->code =3D=3D (BPF_ST | BPF_MEM | BPF_DW)) {
>  			type =3D BPF_WRITE;
> +		} else if (insn->code =3D=3D (BPF_ALU64 | BPF_MOV | BPF_X) && insn->im=
m) {
> +			if (insn->off =3D=3D BPF_ARENA_CAST_KERN ||
> +			    (((struct bpf_map *)env->prog->aux->arena)->map_flags & BPF_F_NO_=
USER_CONV)) {
> +				/* convert to 32-bit mov that clears upper 32-bit */
> +				insn->code =3D BPF_ALU | BPF_MOV | BPF_X;
> +				/* clear off, so it's a normal 'wX =3D wY' from JIT pov */
> +				insn->off =3D 0;
> +			} /* else insn->off =3D=3D BPF_ARENA_CAST_USER should be handled by J=
IT */
> +			continue;
> +		} else if (env->insn_aux_data[i + delta].needs_zext) {
> +			/* Convert BPF_CLASS(insn->code) =3D=3D BPF_ALU64 to 32-bit ALU */
> +			insn->code =3D BPF_ALU | BPF_OP(insn->code) | BPF_SRC(insn->code);

Tbh, I think this should be done in do_misc_fixups(),
mixing it with context handling in convert_ctx_accesses()
seems a bit confusing.

