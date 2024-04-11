Return-Path: <bpf+bounces-26585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 879048A21A3
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 00:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D63D2B23132
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 22:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A1F405E5;
	Thu, 11 Apr 2024 22:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YO3ZYexq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AB83FE4E
	for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 22:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712873593; cv=none; b=Ew9XmuNq86fwuicoiEp8QINjpqag2U7TWrcP7wZoh+/caP/DQYBHt5t1qk9srxH1mXqrSN+WGUGItVyX/VI+gHjQfzOAc8yQvrhuyNQEyEjbpDaTMEIhvPDb2BvCnDdDu+B2dhpVB0f1jVnHkHKf2k6APGHmiPid6ibajIu0OC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712873593; c=relaxed/simple;
	bh=4TUK1yCZGxXU028CSOEOXhnw4IdyjcDd/131JT5UrPs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MHLZeC/wZjr8hphOhqSIvKdK4awMrhgO6BloZxfbj6xLBN9WVOnbtmqGYL1m9h5g9Ikwq8LWO3xgxj4tMwR0EEsO99aMNNp5j3cp8ge+pOPrVVnDXEOv51rqxdbJnXdjvGH/BkcPdCHngoyVytY584JTPzGEe+FXLsDkrhVjqHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YO3ZYexq; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a52176b2cb6so30288166b.2
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 15:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712873590; x=1713478390; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZgPlifsFsynXRPKgrpLLYAbYnDRUO8w4yWAU5XANAAs=;
        b=YO3ZYexq7C5vRkGD4o69/mlvG5Zqz+i9VD971lwlmc0Mj8hjvBFXplYps00LYEyHNh
         j5//Vvdrokgr4Bslz2gKMXln1HMN54OocDHwIwGEs8Z9wcUhwkrn80Teo6qXLmseGdRo
         v3Ddssm0zrpZTcc5kFOiOjn4cNMxshDD0q9hLbrAhgbY0i1CW5sRDWCGl678ShMZ6Gh7
         zrEbVJBiBGHA58e2s9vvnXvuyBLbiARbevFakaAk5g50DeBT/eGPPqK/c1siR+7l2rvx
         Fkn7weSwTZ3MMvvPm97uwtQiJGXg8vYkOZA4jCGgY9yxc5wb2S7dDJNxnRR1y2pAv5wN
         OtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712873590; x=1713478390;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZgPlifsFsynXRPKgrpLLYAbYnDRUO8w4yWAU5XANAAs=;
        b=feeenfxfQK8V1zyxmhGuvYVaAavrUuNZLWAcFETazaZkjdDdAvwWyialn/yopC5Q1q
         W4GDYRezanb2WArrDn0AVDnaVtKk/hZf1tVWviDmDtzTYVwj1DiYV3M5GumRUtoRlixQ
         0dW/TiJ2xVTublVFC02SDiFbvbUPAHbo5qQpjz567Nqci2gBJEu3XscgZjvw/EUH3oJH
         KGLZxtK8kBfLbqRL3JKOtwrNhmsORUnN4Qrgqh25/lJVDWgwCWVPVXA2T08WRYcdGK0x
         jL5wakGg9fKIDxFgjZtMvUgWXG/+9nQXS5BL5usYvi8QZFhigsAEfyGtoOyOqctBQFGr
         VgsA==
X-Forwarded-Encrypted: i=1; AJvYcCVrSjwN5nlf329dTarYV47947pH7uRoEjYtS7Hh0uLMGxRsS1LaqFg7/wJYwDvHQxjd/MUNQbKara8xju4H++JX5exj
X-Gm-Message-State: AOJu0Yzfv38mxg6LAMHb7pJ/Uq/4OgsZgf28HjnEMsK04pY35r7Tchdj
	XBRK0DFesOBt4bCE4XzXGJY6+hJz3jiweEnrflRfqVIUzVSuvCvj
X-Google-Smtp-Source: AGHT+IEEwVVHJEQG9smbzGwgQYcn4YgL4RRcNVFD6yYCDXMPiFU6XuYenhtrhyrcEPpFhhn6Fd14dw==
X-Received: by 2002:a17:907:78ce:b0:a4e:8e96:d43e with SMTP id kv14-20020a17090778ce00b00a4e8e96d43emr462680ejc.67.1712873590304;
        Thu, 11 Apr 2024 15:13:10 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id qw17-20020a1709066a1100b00a473774b027sm1122370ejc.207.2024.04.11.15.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 15:13:09 -0700 (PDT)
Message-ID: <51436d219e351558fdb6b57641280039540754ee.camel@gmail.com>
Subject: Re: [PATCH bpf-next 04/11] bpf: check_map_kptr_access() compute the
 offset from the reg state.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org,  martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com
Date: Fri, 12 Apr 2024 01:13:08 +0300
In-Reply-To: <20240410004150.2917641-5-thinker.li@gmail.com>
References: <20240410004150.2917641-1-thinker.li@gmail.com>
	 <20240410004150.2917641-5-thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-09 at 17:41 -0700, Kui-Feng Lee wrote:
> Previously, check_map_kptr_access() assumed that the accessed offset was
> identical to the offset in the btf_field. However, once field array is
> supported, the accessed offset no longer matches the offset in the
> bpf_field. It may refer to an element in an array while the offset in the
> bpf_field refers to the beginning of the array.
>=20
> To handle arrays, it computes the offset from the reg state instead.
>=20
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  kernel/bpf/verifier.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 86adacc5f76c..34e43220c6f0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5349,18 +5349,19 @@ static u32 btf_ld_kptr_type(struct bpf_verifier_e=
nv *env, struct btf_field *kptr
>  }
> =20
>  static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno=
,
> -				 int value_regno, int insn_idx,
> +				 u32 offset, int value_regno, int insn_idx,
>  				 struct btf_field *kptr_field)
>  {
>  	struct bpf_insn *insn =3D &env->prog->insnsi[insn_idx];
>  	int class =3D BPF_CLASS(insn->code);
> -	struct bpf_reg_state *val_reg;
> +	struct bpf_reg_state *val_reg, *reg;
> =20
>  	/* Things we already checked for in check_map_access and caller:

Nit: at the moment when this patch is applied check_map_access is not
     yet modified.

>  	 *  - Reject cases where variable offset may touch kptr
>  	 *  - size of access (must be BPF_DW)
>  	 *  - tnum_is_const(reg->var_off)
> -	 *  - kptr_field->offset =3D=3D off + reg->var_off.value
> +	 *  - kptr_field->offset + kptr_field->size * i / kptr_field->nelems
> +	 *    =3D=3D off + reg->var_off.value where n is an index into the arra=
y
                                           ^^^ nit: this should be 'i'

>  	 */
>  	/* Only BPF_[LDX,STX,ST] | BPF_MEM | BPF_DW is supported */
>  	if (BPF_MODE(insn->code) !=3D BPF_MEM) {

[...]


