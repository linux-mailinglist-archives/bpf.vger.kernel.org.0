Return-Path: <bpf+bounces-16821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EFD8062DC
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 00:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E6D4B210C8
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 23:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45574120D;
	Tue,  5 Dec 2023 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCcUK0zA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EBDAC
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 15:21:37 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c9ef682264so49636281fa.3
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 15:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701818496; x=1702423296; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z0O+ItMeI2z+ukv4UmC9KrTHTOZmWlK9YUX6TCmv7/4=;
        b=hCcUK0zAcEXiMuzkPhfMj6wTHCn65uVsNZtQSRwWMUsZR8JLgGX0pgBPYJrv5eEdJ3
         1D8PFf2r6Mg8dQ4hWrw9pfKGX3GmYV6QMnU1ugZtkUdVCMXaZDzi3YKi436ODH9SEMjV
         hiI6jV9hl/CBVSEanpK9IWd+S1akLk1PyHJMog4oJXwI4Cue3uCC0Tt+Sbf7xYnUZcuQ
         PEMaidNGVJapsgRvZbYxRRAwLk/C/STjLaBjNGSh9bCCn7Jy1lcdspD16p5Mx2i8Oc/7
         ochydYQ5zbkhBKYanj0XwH5D0IQphLT+7umz0wXdv8PCUXBtz2mZ6ZQ55SErKNQiM5VC
         /WDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701818496; x=1702423296;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0O+ItMeI2z+ukv4UmC9KrTHTOZmWlK9YUX6TCmv7/4=;
        b=HK5/v9JzV6mUw17Du9MauITV38duuE1oIFMMJe8nvQkrytvzy+cmxYxJZDjANvvuZC
         zjK23BT383wJ78aqVzFRRH69mDxEtQ8pO2yYjKwphn6Ti426wpo81l7uA779BdElu8Aa
         wQPMvIjpb+fJbb2NkZVhTKhv9OxHxH+kox2hGZptBT5pVn8T+ok7p/jjLnzzxRLmTCDo
         fq+JZUUj2/6NsF7GjEvpKckhpO9OdMKIs5igCrgE3u5NWWi3lvy65r9P0/KyjIiYFk7v
         7PIi3BoALVugU6s/GtRF8IPzOttJOBB80KsdyllSoRzgTM6aJMYEPBKRK0qvWNagm7t2
         B3BA==
X-Gm-Message-State: AOJu0YwcAL0ZhvqpibRThIfm4lk6tyL153wbxGKcGFC8uw1eHG70Cnwd
	N8KoPWYZrnZBtKuK9M87pAagtQEESOQ=
X-Google-Smtp-Source: AGHT+IGIPTqneYg02Q0+uK4Ffk+kt2QnMOn3/on3uuoMfkxKTCg/lHEo4OPge6+wQ5uHxw60Pa11Rw==
X-Received: by 2002:a2e:a7cf:0:b0:2ca:227a:ebb2 with SMTP id x15-20020a2ea7cf000000b002ca227aebb2mr2136ljp.0.1701818495883;
        Tue, 05 Dec 2023 15:21:35 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id g18-20020a2eb5d2000000b002ca013cb05csm922433ljn.79.2023.12.05.15.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 15:21:35 -0800 (PST)
Message-ID: <cfea7e70b26e7b11c989d162c2217f5fb3e13b0b.camel@gmail.com>
Subject: Re: [PATCH bpf-next 05/13] bpf: abstract away global subprog arg
 preparation logic from reg state setup
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Wed, 06 Dec 2023 01:21:34 +0200
In-Reply-To: <20231204233931.49758-6-andrii@kernel.org>
References: <20231204233931.49758-1-andrii@kernel.org>
	 <20231204233931.49758-6-andrii@kernel.org>
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

On Mon, 2023-12-04 at 15:39 -0800, Andrii Nakryiko wrote:

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 379ac0a28405..c3a5d0fe3cdf 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -704,6 +704,7 @@ enum bpf_arg_type {
> =20
>  	ARG_PTR_TO_CTX,		/* pointer to context */
>  	ARG_ANYTHING,		/* any (initialized) argument is ok */
> +	ARG_SCALAR =3D ARG_ANYTHING, /* scalar value */

Nit: I agree that use of ARG_ANYTHING to denote scalars is confusing,
     but having two names for the same thing seems even more confusing.

[...]

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index d56433bf8aba..33a62df9c5a8 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6955,9 +6955,9 @@ int btf_check_subprog_call(struct bpf_verifier_env =
*env, int subprog,
>   * 0 - Successfully converted BTF into bpf_reg_state
>   * (either PTR_TO_CTX or SCALAR_VALUE).
>   */
> -int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
> -			  struct bpf_reg_state *regs, u32 *arg_cnt)
> +int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)

Could you please also update the comment above this function?
It currently says: "Convert BTF of a function into bpf_reg_state if possibl=
e".

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ee707736ce6b..16d5550eda4d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[...]
> @@ -19860,33 +19855,44 @@ static int do_check_common(struct bpf_verifier_=
env *env, int subprog)
[...]
>  		for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++) {
> -			if (regs[i].type =3D=3D PTR_TO_CTX)
> +			arg =3D &sub->args[i - BPF_REG_1];
> +			reg =3D &regs[i];
> +
> +			if (arg->arg_type =3D=3D ARG_PTR_TO_CTX) {
> +				reg->type =3D PTR_TO_CTX;
>  				mark_reg_known_zero(env, regs, i);
> -			else if (regs[i].type =3D=3D SCALAR_VALUE)
> +			} else if (arg->arg_type =3D=3D ARG_SCALAR) {
> +				reg->type =3D SCALAR_VALUE;
>  				mark_reg_unknown(env, regs, i);
> -			else if (base_type(regs[i].type) =3D=3D PTR_TO_MEM) {
> -				const u32 mem_size =3D regs[i].mem_size;
> -
> +			} else if (base_type(arg->arg_type) =3D=3D ARG_PTR_TO_MEM) {
> +				reg->type =3D PTR_TO_MEM;
> +				if (arg->arg_type & PTR_MAYBE_NULL)
> +					reg->type |=3D PTR_MAYBE_NULL;
>  				mark_reg_known_zero(env, regs, i);
> -				regs[i].mem_size =3D mem_size;
> -				regs[i].id =3D ++env->id_gen;
> +				reg->mem_size =3D arg->mem_size;
> +				reg->id =3D ++env->id_gen;
>  			}

Nit: maybe add an else branch here and report an error if unexpected
     argument type is returned by btf_prepare_func_args()?



