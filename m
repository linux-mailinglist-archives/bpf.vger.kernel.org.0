Return-Path: <bpf+bounces-14814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4688A7E86FF
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 01:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28912812D3
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 00:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B60C15D2;
	Sat, 11 Nov 2023 00:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pf++lSTI"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CF715AD
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 00:51:48 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873D63C14
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 16:51:46 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9e62f903e88so180176266b.2
        for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 16:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699663905; x=1700268705; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pGJP0IaLOZJxO8/gPtvCXJhNiT67XiLOqcp5JutMCQk=;
        b=Pf++lSTIABGFK4pnMsQC1Q1bSKSAHkErBXTkSXVRBXwcSzqIyDspSIUPx5HLlpNM0u
         WVxY2TStLVeUHJmIWLC+ZylEz01k8dsj4vOEI6MQuplE5zVzKOWNr7PR5edIqikEzYS+
         Hc0CwQPyQW1w2o9J6naBuvTme2w7WsnDTIlbqJ/13zJaka0rEHbEkobn87gPeL1UXnh7
         bk6sV+5Bg9ESHgJuERR/KYq6uxAne0My8XeVkeyvXgpMWy9L76h2cPT2XaLHxhe4y3xk
         Wkz81XhaggQS0w/eYxZDAb7dpmhG8x+4ad8UfC8hyijf/Flfo3WYmR9C1nC3KeYyBhRv
         HpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699663905; x=1700268705;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pGJP0IaLOZJxO8/gPtvCXJhNiT67XiLOqcp5JutMCQk=;
        b=IRK1jVOhJSnub6gQX8SXBbpSC969sBYJD1XZ7jtQwGmBg+j9FPydL8sQjDP0ZhpY8e
         Fxa7ZtNPuRV51DsqwmaQrvrUZH70q3M8mFGjgDDOfXB0fBnGd7btIdcZcSNbcyI4b0fh
         hMeLHk3RFEl1duJ9hkhaQO3yzN5FucAOyo6PnEsYfKSzk2ocl/sw+aql4wbAO6Yr4xRp
         8yRjojUQqhEfaetmHiwpK52WdauzBQazOMvj+Ow4yi5XiHDHQ289FIXJzKcLPFMfSvHe
         zBl4gIdBWM/6MahJGpZ7/qxoKmkUQEhoXeNLxSrzBPr42aq3gvjhJUMXpms0d9YSLNi2
         91pg==
X-Gm-Message-State: AOJu0YxOdTD4wDeFL0IUaHeAiiaZ0ZTu2z5hvcTLHY5nzL9SbdDQq4cN
	cDiuyi5xJWIEQQUwpgnWQi4=
X-Google-Smtp-Source: AGHT+IGx2WS2iC3BcsY5L0esGro1cXAbHVCkj/O7getCWs69Uvand7ruTx7xILQpezjQcEvRUEdY7Q==
X-Received: by 2002:a17:907:9848:b0:9dd:5adc:b1d2 with SMTP id jj8-20020a170907984800b009dd5adcb1d2mr335988ejc.38.1699663904905;
        Fri, 10 Nov 2023 16:51:44 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id lr18-20020a170906fb9200b009b2ca104988sm269287ejb.98.2023.11.10.16.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 16:51:44 -0800 (PST)
Message-ID: <8506722472c49aafc5842ee3d39ddae3230882b7.camel@gmail.com>
Subject: Re: [PATCH bpf-next 7/8] bpf: smarter verifier log number printing
 logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Sat, 11 Nov 2023 02:51:43 +0200
In-Reply-To: <20231110161057.1943534-8-andrii@kernel.org>
References: <20231110161057.1943534-1-andrii@kernel.org>
	 <20231110161057.1943534-8-andrii@kernel.org>
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

On Fri, 2023-11-10 at 08:10 -0800, Andrii Nakryiko wrote:
> Instead of always printing numbers as either decimals (and in some
> cases, like for "imm=3D%llx", in hexadecimals), decide the form based on
> actual values. For numbers in a reasonably small range (currently,
> [0, U16_MAX] for unsigned values, and [S16_MIN, S16_MAX] for signed ones)=
,
> emit them as decimals. In all other cases, even for signed values,
> emit them in hexadecimals.
>=20
> For large values hex form is often times way more useful: it's easier to
> see an exact difference between 0xffffffff80000000 and 0xffffffff7fffffff=
,
> than between 18446744071562067966 and 18446744071562067967, as one
> particular example.
>=20
> Small values representing small pointer offsets or application
> constants, on the other hand, are way more useful to be represented in
> decimal notation.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
> @@ -576,14 +627,14 @@ static void print_reg_state(struct bpf_verifier_env=
 *env, const struct bpf_reg_s
>  	    tnum_is_const(reg->var_off)) {
>  		/* reg->off should be 0 for SCALAR_VALUE */
>  		verbose(env, "%s", t =3D=3D SCALAR_VALUE ? "" : reg_type_str(env, t));
> -		verbose(env, "%lld", reg->var_off.value + reg->off);
> +		verbose_snum(env, reg->var_off.value + reg->off);
>  		return;
>  	}
>  /*
>   * _a stands for append, was shortened to avoid multiline statements bel=
ow.
>   * This macro is used to output a comma separated list of attributes.
>   */
> -#define verbose_a(fmt, ...) ({ verbose(env, "%s" fmt, sep, __VA_ARGS__);=
 sep =3D ","; })
> +#define verbose_a(fmt, ...) ({ verbose(env, "%s" fmt, sep, ##__VA_ARGS__=
); sep =3D ","; })
> =20
>  	verbose(env, "%s", reg_type_str(env, t));
>  	if (base_type(t) =3D=3D PTR_TO_BTF_ID)
> @@ -608,8 +659,10 @@ static void print_reg_state(struct bpf_verifier_env =
*env, const struct bpf_reg_s
>  		verbose_a("r=3D%d", reg->range);
>  	if (tnum_is_const(reg->var_off)) {
>  		/* a pointer register with fixed offset */
> -		if (reg->var_off.value)
> -			verbose_a("imm=3D%llx", reg->var_off.value);
> +		if (reg->var_off.value) {
> +			verbose_a("imm=3D");
> +			verbose_snum(env, reg->var_off.value);
> +		}

Maybe use same verbose_{u,s}num() for reg->off and reg->range in this
function?

