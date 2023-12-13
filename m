Return-Path: <bpf+bounces-17691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F1F811B71
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 18:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FD21F21A8A
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 17:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CC639FF9;
	Wed, 13 Dec 2023 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YW97lM9X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D78E8
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 09:43:04 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c39ef63d9so47280595e9.3
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 09:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702489383; x=1703094183; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SVY8IUpXO+kWlj/eUKQnooQ1MCvb6nqXBNRvkHstdjQ=;
        b=YW97lM9XRdH2o45TMvMR59seOHO7e2eYs1ZtkE5CD+7B+/4oVciCi/fdtc5iN3C6Fe
         cmPZcrf33I0FGl8FM8bSoLfWW5Dg8kS9opvvGBRN/z0FHNy/pZjh9o1RvKqsOmI0JtPl
         f+T3ZF/HCA66Axuqt72GeOxL90vt4kRFVugEpKxC0y1DaYrNDmDRyST5tEhkAC8mDSCn
         +5QrTT5ULdrB2/hut8+w6AjPscMHLCPGJeO7HQWZTprLc81tf9h9xnekiRQI5mfXdmZa
         R0W5qT0tusysd+xX/l8hmnf743n67Lg2+/acLvPdGxRzhKl/LWzkUrz0qSZYrU7jeF0u
         B3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702489383; x=1703094183;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVY8IUpXO+kWlj/eUKQnooQ1MCvb6nqXBNRvkHstdjQ=;
        b=flkMO76LROolCmv5SEAccr11AXrofwGFYRpEEZpiVzr6/KNn7rab6CWrnILlZOE8R1
         JomLduyWSEMhkdkCA1MREk+WH24mx6pWc9XhyBmG5RsFKzE3otbLVHjZxvJEBEKn+dlF
         Q72c+EGEmZSWuodDHtmhVbJWojrtEZ3hF3vhC1i0Dn7ZXajhTAdOx5AY27sXdAWRAYeI
         phKviodo63w5Mx7xwmwsttErtWIravFfYOX5yvEXBRm5xJ/Ls3D3zBcnw6MhkGc2YOMd
         lTg8pPwHyLXeuFVQBHmNEkN9FO9cCBo2+0eydFXmTswTj4f0x5sbFCxN1ClkT4jjkcot
         4aPQ==
X-Gm-Message-State: AOJu0YzoLB2Bi9gVXa7RyOf6ARMYmSP7SWidcD5U8S8ygrW0J6iegn2X
	RskNZ/E3EY6dFYVoyfrlDHA=
X-Google-Smtp-Source: AGHT+IFxYo5dmwyarmmf6AjWPH9UD8Z0RnsNbD090PegXWgzN213kg9JoPO7n6TLn13oRPKzFGqWJw==
X-Received: by 2002:a7b:c44b:0:b0:40c:3751:b661 with SMTP id l11-20020a7bc44b000000b0040c3751b661mr4143592wmi.61.1702489382238;
        Wed, 13 Dec 2023 09:43:02 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id k42-20020a05600c1caa00b003fe1fe56202sm21199951wms.33.2023.12.13.09.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 09:43:01 -0800 (PST)
Message-ID: <75137376329b7afe4dae0f3ae8fe0036c790198c.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 02/10] bpf: reuse btf_prepare_func_args()
 check for main program BTF validation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Wed, 13 Dec 2023 19:43:00 +0200
In-Reply-To: <20231212232535.1875938-3-andrii@kernel.org>
References: <20231212232535.1875938-1-andrii@kernel.org>
	 <20231212232535.1875938-3-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-12-12 at 15:25 -0800, Andrii Nakryiko wrote:
> Instead of btf_check_subprog_arg_match(), use btf_prepare_func_args()
> logic to validate "trustworthiness" of main BPF program's BTF information=
,
> if it is present.
>=20
> We ignored results of original BTF check anyway, often times producing
> confusing and ominously-sounding "reg type unsupported for arg#0
> function" message, which has no apparent effect on program correctness
> and verification process.
>=20
> All the -EFAULT returning sanity checks are already performed in
> check_btf_info_early(), so there is zero reason to have this duplication
> of logic between btf_check_subprog_call() and btf_check_subprog_arg_match=
().
> Dropping btf_check_subprog_arg_match() simplifies
> btf_check_func_arg_match() further removing `bool processing_call` flag.
>=20
> One subtle bit that was done by btf_check_subprog_arg_match() was
> potentially marking main program's BTF as unreliable. We do this
> explicitly now with a dedicated simple check, preserving the original
> behavior, but now based on well factored btf_prepare_func_args() logic.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -19944,21 +19945,19 @@ static int do_check_common(struct bpf_verifier_=
env *env, int subprog)
>  			}
>  		}
>  	} else {
> +		/* if main BPF program has associated BTF info, validate that
> +		 * it's matching expected signature, and otherwise mark BTF
> +		 * info for main program as unreliable
> +		 */
> +		if (env->prog->aux->func_info_aux) {
> +			ret =3D btf_prepare_func_args(env, 0);
> +			if (ret || sub->arg_cnt !=3D 1 || sub->args[0].arg_type !=3D ARG_PTR_=
TO_CTX)
> +				env->prog->aux->func_info_aux[0].unreliable =3D true;
> +		}

Nit: should this return if ret =3D=3D -EFAULT?



