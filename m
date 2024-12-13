Return-Path: <bpf+bounces-46896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 869F79F172F
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 21:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F351623DA
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 20:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0011F03CE;
	Fri, 13 Dec 2024 20:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF20lNY2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6284F19006B
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 20:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120366; cv=none; b=YOX2A26j6Z3nzcNdXnipZZ0F3A3ZG/Jx29Bk33ofwU1IJ4FD5b6xVKnlmLlSyhnzfYGt27eeHQ4qipwS2TFtVzNiPkjib9oyKlRJfU8YlSBf8JJeuzDAuQvBdFh7JdTb/3+eOxHyS16XERJPlZb2dG6/0lrCTBajYCfmFMSOLTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120366; c=relaxed/simple;
	bh=v00/e+MF4lOEqzeHnUOQ7ePE4v7f0uObUXzrnTzAfWs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H+QF78Ncht75Z5qqsoDV9E/L+oP+gAsbu+OPw2AMZR1SRTXBB7WajlM0cPLK+B7Wkas2mhgeiI1PB+WBkth7f0PsLw+V8enJIEaL/dpq/cOryR3/xNAchYjFG3aEuenqhU64+RqlrqmFYzvglMuCM9i7eh4bDTMWZvDmtlppSbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WF20lNY2; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so2683351a91.0
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 12:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734120363; x=1734725163; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eMePhlrFzh/6hbqpw+HZWDfeCdK1IeBeWT3Hl1r/F78=;
        b=WF20lNY2juhZdAeE2ee62nlnbX+701CPsiUW85Xet6lfVnX4Kc2GvGT26eXJnlZ/II
         qOO5KhpeLYMGez0SMz+uJ6FKBRjOHgUq2babQOX6voJipMyF81+mxmwGMxDLv5K3Jo/5
         z0vaM6ZVu4RMRDdrDQ6g8WTkuMRFKlPR3tpGAqV6jgcE2fPW68ogRMYICsbUEkU1TNzI
         ayD9VKuZ8wZE0U9yDgFAMWuDWNA9AuvSpjtJ+48YTrU7xvfSPaWfedIyj8dshnxFGTZs
         +RIq73MT5N3yu4f3CdWLbi9E5AQQFfgD3pKsB7mAa+xd8ao+27lh+391tCHWyPyRBdZE
         XSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734120363; x=1734725163;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eMePhlrFzh/6hbqpw+HZWDfeCdK1IeBeWT3Hl1r/F78=;
        b=SNcAnJjJellKRiOuxIvw+lV79q1YmFxgm7R+Rirzwp0K/NdYK4gtYlqbxHtDzFLDyO
         tn8uDi7VR/opBYu3EyvwCrhZ7sJ6iOApYYYVZD7gAOgEJAgSc/zdXLlhxUQO1CjdL7Fj
         KC6wTtEvjBWxkOq06NQGPaaMp68Ayi3Dj8NjMwKP6zOxxs0jPk8zrS+tSc3xUz3W2quQ
         PooCPKOuOi8JokPpfH223V2jUsc8mDTqCVXvkou6QwQpc80TNq1CEEv7+mVDXmcwRLYK
         0QWGYC0fBqXQ/i6yKqKJlyYDLoC6RQvGoyhvsctOgUmMOQGUKsUcAM0syux+lQo0M2p7
         gnDg==
X-Forwarded-Encrypted: i=1; AJvYcCUu1FIwaGJ3cnfABuKPFXCkA72/XYm/pOe0m0dIT0KDgqnBUSuKkECex+aRRcvBlqqtUkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUN5k8okEGMNqMl/PDd0++F8ZJGZb9+3tRzXPIx50WYx9drvmo
	opkjYCan6McNxFnDICaUnEWVzz/pzdIY4YJPkvs4jIjgg6ZHAdZrXBWaBw==
X-Gm-Gg: ASbGncskzVucoXtzD+ZCpj/20AWDMNO94uQCYavjnO0spZjemeI7LXS3V4Aoz4qGmaI
	qM+ZRhr4qmoe9YpAwoxTEb1aPvh1fTtSXHm0qht+tJTPk2eLtYny0u4pxHHRt951jb3yyLs4mhG
	x91NFLtRnMRyExjDbwdy/6cH92o0WLxD8ZIyUdpztqod6YFoEGV22CoQ+Zph5e5rToPo0if2Lq/
	znms+mn5Xg3QpfTynLcx4B/ShH03acIptyr5ZqEadIcRusoDnuFFw==
X-Google-Smtp-Source: AGHT+IHJXpKg9sbkBMew/iuWr7hhEusWkUMdUH91SAOcX9Y4BTMEHIvUqF1hkLYqXJNOriPupXoh2w==
X-Received: by 2002:a17:90b:3883:b0:2ef:7be8:e987 with SMTP id 98e67ed59e1d1-2f13ac5477fmr12713181a91.12.1734120363453;
        Fri, 13 Dec 2024 12:06:03 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d93470sm3584402a91.4.2024.12.13.12.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 12:06:02 -0800 (PST)
Message-ID: <7793d86c11139358ea1f1afb0f731d24a30f9d50.camel@gmail.com>
Subject: Re: [PATCH bpf v2 2/3] bpf: Augment raw_tp arguments with
 PTR_MAYBE_NULL
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: kkd@meta.com, Juri Lelli <juri.lelli@redhat.com>, Manu Bretelle
	 <chantra@meta.com>, Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov
	 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
	 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	kernel-team@fb.com
Date: Fri, 13 Dec 2024 12:05:57 -0800
In-Reply-To: <20241213175127.2084759-3-memxor@gmail.com>
References: <20241213175127.2084759-1-memxor@gmail.com>
	 <20241213175127.2084759-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-13 at 09:51 -0800, Kumar Kartikeya Dwivedi wrote:
> Arguments to a raw tracepoint are tagged as trusted, which carries the
> semantics that the pointer will be non-NULL.  However, in certain cases,
> a raw tracepoint argument may end up being NULL. More context about this
> issue is available in [0].
>=20
> Thus, there is a discrepancy between the reality, that raw_tp arguments c=
an
> actually be NULL, and the verifier's knowledge, that they are never NULL,
> causing explicit NULL check branch to be dead code eliminated.
>=20
> A previous attempt [1], i.e. the second fixed commit, was made to
> simulate symbolic execution as if in most accesses, the argument is a
> non-NULL raw_tp, except for conditional jumps.  This tried to suppress
> branch prediction while preserving compatibility, but surfaced issues
> with production programs that were difficult to solve without increasing
> verifier complexity. A more complete discussion of issues and fixes is
> available at [2].
>=20
> Fix this by maintaining an explicit list of tracepoints where the
> arguments are known to be NULL, and mark the positional arguments as
> PTR_MAYBE_NULL. Additionally, capture the tracepoints where arguments
> are known to be ERR_PTR, and mark these arguments as scalar values to
> prevent potential dereference.
>=20
> Each hex digit is used to encode NULL-ness (0x1) or ERR_PTR-ness (0x2),
> shifted by the zero-indexed argument number x 4. This can be represented
> as follows:
> 1st arg: 0x1
> 2nd arg: 0x10
> 3rd arg: 0x100
> ... and so on (likewise for ERR_PTR case).
>=20
> In the future, an automated pass will be used to produce such a list, or
> insert __nullable annotations automatically for tracepoints. Each
> compilation unit will be analyzed and results will be collated to find
> whether a tracepoint pointer is definitely not null, maybe null, or an
> unknown state where verifier conservatively marks it PTR_MAYBE_NULL.
> A proof of concept of this tool from Eduard is available at [3].
>=20
> Note that in case we don't find a specification in the raw_tp_null_args
> array and the tracepoint belongs to a kernel module, we will
> conservatively mark the arguments as PTR_MAYBE_NULL. This is because
> unlike for in-tree modules, out-of-tree module tracepoints may pass NULL
> freely to the tracepoint. We don't protect against such tracepoints
> passing ERR_PTR (which is uncommon anyway), lest we mark all such
> arguments as SCALAR_VALUE.
>=20
> While we are it, let's adjust the test raw_tp_null to not perform
> dereference of the skb->mark, as that won't be allowed anymore, and make
> it more robust by using inline assembly to test the dead code
> elimination behavior, which should still stay the same.
>=20
>   [0]: https://lore.kernel.org/bpf/ZrCZS6nisraEqehw@jlelli-thinkpadt14gen=
4.remote.csb
>   [1]: https://lore.kernel.org/all/20241104171959.2938862-1-memxor@gmail.=
com
>   [2]: https://lore.kernel.org/bpf/20241206161053.809580-1-memxor@gmail.c=
om
>   [3]: https://github.com/eddyz87/llvm-project/tree/nullness-for-tracepoi=
nt-params
>=20
> Reported-by: Juri Lelli <juri.lelli@redhat.com> # original bug
> Reported-by: Manu Bretelle <chantra@meta.com> # bugs in masking fix
> Fixes: 3f00c5239344 ("bpf: Allow trusted pointers to be passed to KF_TRUS=
TED_ARGS kfuncs")
> Fixes: cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")
> Co-developed-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Tbh, I think we should have fixed the bug in what is currently in the
tree and avoid revert. Anyways, the code looks good to me.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -6597,6 +6693,39 @@ bool btf_ctx_access(int off, int size, enum bpf_ac=
cess_type type,
>  	if (btf_param_match_suffix(btf, &args[arg], "__nullable"))
>  		info->reg_type |=3D PTR_MAYBE_NULL;
> =20
> +	if (prog->expected_attach_type =3D=3D BPF_TRACE_RAW_TP) {
> +		struct btf *btf =3D prog->aux->attach_btf;
> +		const struct btf_type *t;
> +		const char *tname;
> +
> +		/* BTF lookups cannot fail, return false on error */
> +		t =3D btf_type_by_id(btf, prog->aux->attach_btf_id);
> +		if (!t)
> +			return false;
> +		tname =3D btf_name_by_offset(btf, t->name_off);
> +		if (!tname)
> +			return false;
> +		/* Checked by bpf_check_attach_target */
> +		tname +=3D sizeof("bpf_trace_") - 1;

Nit: bpf_check_attach_target uses "btf_trace_" prefix.

> +		for (i =3D 0; i < ARRAY_SIZE(raw_tp_null_args); i++) {
> +			/* Is this a func with potential NULL args? */
> +			if (strcmp(tname, raw_tp_null_args[i].func))
> +				continue;
> +			if (raw_tp_null_args[i].mask & (0x1 << (arg * 4)))
> +				info->reg_type |=3D PTR_MAYBE_NULL;
> +			/* Is the current arg IS_ERR? */
> +			if (raw_tp_null_args[i].mask & (0x2 << (arg * 4)))
> +				ptr_err_raw_tp =3D true;
> +			break;
> +		}
> +		/* If we don't know NULL-ness specification and the tracepoint
> +		 * is coming from a loadable module, be conservative and mark
> +		 * argument as PTR_MAYBE_NULL.
> +		 */
> +		if (i =3D=3D ARRAY_SIZE(raw_tp_null_args) && btf_is_module(btf))
> +			info->reg_type |=3D PTR_MAYBE_NULL;
> +	}
> +
>  	if (tgt_prog) {
>  		enum bpf_prog_type tgt_type;
> =20
> @@ -6641,6 +6770,13 @@ bool btf_ctx_access(int off, int size, enum bpf_ac=
cess_type type,
>  	bpf_log(log, "func '%s' arg%d has btf_id %d type %s '%s'\n",
>  		tname, arg, info->btf_id, btf_type_str(t),
>  		__btf_name_by_offset(btf, t->name_off));
> +
> +	/* Perform all checks on the validity of type for this argument, but if
> +	 * we know it can be IS_ERR at runtime, scrub pointer type and mark as
> +	 * scalar.
> +	 */
> +	if (ptr_err_raw_tp)
> +		info->reg_type =3D SCALAR_VALUE;

Nit: the log line above would be a bit confusing if 'ptr_err_raw_tp' would =
be true.
     maybe add an additional line here, saying that verifier overrides BTF =
type?

>  	return true;
>  }
>  EXPORT_SYMBOL_GPL(btf_ctx_access);

[...]


