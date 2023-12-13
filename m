Return-Path: <bpf+bounces-17692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CB5811B72
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 18:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C9351C21070
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 17:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC983A287;
	Wed, 13 Dec 2023 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9jnzXGH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F8DCF
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 09:43:20 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c46d6784eso33726185e9.3
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 09:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702489399; x=1703094199; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7C1Brd/3gFyEpEUfYqJPliHvfS5Ix4Jdvg1zmS9xn14=;
        b=E9jnzXGHiLyV+puo7V7nES1ZwU61P7cx6z2HlRx2Cq8ofMcwCu3iK7o02/IvJcMpO5
         YD+wIUA0xezBqiQQ9CVo1X4ohWzzNTkzFUKrcT+PE5k4Fu87P9WZaGDdP2DKHFu7SJ47
         t8WtIPkkTDeZMOyV2fbCcDH5RRN6ZtZa9I8p7UMGIMLf+EFRCyyp2EIBVWqmxOk+q0kJ
         HRbK389dlbZlLfPxTTpumm7gcXVFGuuU2xhjQ9w2dnnTtGHHwFYB8ouEYnNieYACceDC
         Xq+7qrjKm6i/XA6P4yHil5/V8MCx+rZGLwS6Ine4FdL7ebYLy7JMG+oaxMkf7l6Rx88m
         rbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702489399; x=1703094199;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7C1Brd/3gFyEpEUfYqJPliHvfS5Ix4Jdvg1zmS9xn14=;
        b=SEEBV+umSXZw43evuXP622sjjBdBPS2Ri4qrHxtiRg5fx+TqklS/FAxN5bvfDNl6I0
         uPoh613Z6kUFYgR7qiM2xuG50LOAFS97hqUYHDxfLKtGk5JAVTwR0m5xHU7ow1sgJebk
         TmO/M8O7X3F++kxCM1YrPhGU1IlbBwOTFFXf+z2C+DgeOTc8UQXtzs7awEFGGt+Rq+sw
         mCcx06ECAiPLg5rglIQF8KYyK2t7C4sNKp2Nuj1yx4By+/M9BT6KattVHk9PzFPEzgor
         hZizo7JUeTzQo/YazdXbdvWaLkOC1mJv3QSboW+g0JAkRoBkB4FYNfhJS51rUO/t+E+U
         O8Fw==
X-Gm-Message-State: AOJu0YzcMqHLbH2GOiFcZAB8zzImW8W0hH79VXq3e/cdNfFQH9fEMvH/
	l3ckfWnsAHG4/c/6c4RpbJE=
X-Google-Smtp-Source: AGHT+IHSy4jMkpXH+9EfvGg4wxollECjzFKcSnLeGwhw+gVzggk7X6Ew3N9MCDqo+WK1jV3hNJg6cw==
X-Received: by 2002:a05:600c:204b:b0:40b:5e59:e9f3 with SMTP id p11-20020a05600c204b00b0040b5e59e9f3mr4297692wmg.146.1702489398604;
        Wed, 13 Dec 2023 09:43:18 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b0040c1d2c6331sm21418991wms.32.2023.12.13.09.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 09:43:18 -0800 (PST)
Message-ID: <bb0885d8a86c2b03be918ef506466e6a2f90f294.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 06/10] bpf: support 'arg:xxx'
 btf_decl_tag-based hints for global subprog args
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Wed, 13 Dec 2023 19:43:17 +0200
In-Reply-To: <20231212232535.1875938-7-andrii@kernel.org>
References: <20231212232535.1875938-1-andrii@kernel.org>
	 <20231212232535.1875938-7-andrii@kernel.org>
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
> Add support for annotating global BPF subprog arguments to provide more
> information about expected semantics of the argument. Currently,
> verifier relies purely on argument's BTF type information, and supports
> three general use cases: scalar, pointer-to-context, and
> pointer-to-fixed-size-memory.
>=20
> Scalar and pointer-to-fixed-mem work well in practice and are quite
> natural to use. But pointer-to-context is a bit problematic, as typical
> BPF users don't realize that they need to use a special type name to
> signal to verifier that argument is not just some pointer, but actually
> a PTR_TO_CTX. Further, even if users do know which type to use, it is
> limiting in situations where the same BPF program logic is used across
> few different program types. Common case is kprobes, tracepoints, and
> perf_event programs having a helper to send some data over BPF perf
> buffer. bpf_perf_event_output() requires `ctx` argument, and so it's
> quite cumbersome to share such global subprog across few BPF programs of
> different types, necessitating extra static subprog that is context
> type-agnostic.
>=20
> Long story short, there is a need to go beyond types and allow users to
> add hints to global subprog arguments to define expectations.
>=20
> This patch adds such support for two initial special tags:
>   - pointer to context;
>   - non-null qualifier for generic pointer arguments.
>=20
> All of the above came up in practice already and seem generally useful
> additions. Non-null qualifier is an often requested feature, which
> currently has to be worked around by having unnecessary NULL checks
> inside subprogs even if we know that arguments are never NULL. Pointer
> to context was discussed earlier.
>=20
> As for implementation, we utilize btf_decl_tag attribute and set up an
> "arg:xxx" convention to specify argument hint. As such:
>   - btf_decl_tag("arg:ctx") is a PTR_TO_CTX hint;
>   - btf_decl_tag("arg:nonnull") marks pointer argument as not allowed to
>     be NULL, making NULL check inside global subprog unnecessary.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -6846,7 +6846,35 @@ int btf_prepare_func_args(struct bpf_verifier_env =
*env, int subprog)
>  	 * Only PTR_TO_CTX and SCALAR are supported atm.
>  	 */
>  	for (i =3D 0; i < nargs; i++) {
> +		bool is_nonnull =3D false;
> +		const char *tag;
> +
>  		t =3D btf_type_by_id(btf, args[i].type);
> +
> +		tag =3D btf_find_decl_tag_value(btf, fn_t, i, "arg:");
> +		if (IS_ERR(tag) && PTR_ERR(tag) =3D=3D -ENOENT) {
> +			tag =3D NULL;
> +		} else if (IS_ERR(tag)) {
> +			bpf_log(log, "arg#%d type's tag fetching failure: %ld\n", i, PTR_ERR(=
tag));
> +			return PTR_ERR(tag);
> +		}
> +		/* 'arg:<tag>' decl_tag takes precedence over derivation of
> +		 * register type from BTF type itself
> +		 */
> +		if (tag) {
> +			/* disallow arg tags in static subprogs */
> +			if (!is_global) {
> +				bpf_log(log, "arg#%d type tag is not supported in static functions\n=
", i);
> +				return -EOPNOTSUPP;
> +			}
> +			if (strcmp(tag, "ctx") =3D=3D 0) {
> +				sub->args[i].arg_type =3D ARG_PTR_TO_CTX;
> +				continue;

Nit: personally, I'd keep tags parsing and processing logically separate:
     - at this point set a flag 'is_ctx'
     - and modify the check below as follows:
    =20
		if (is_ctx || (btf_type_is_ptr(t) && btf_get_prog_ctx_type(log, btf, t, p=
rog_type, i))) {
			sub->args[i].arg_type =3D ARG_PTR_TO_CTX;
			continue;
		}
   =20
     So that there is only one place where ARG_PTR_TO_CTX is assigned.
     Feel free to ignore.

[...]



