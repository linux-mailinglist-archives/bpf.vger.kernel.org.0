Return-Path: <bpf+bounces-79339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D36D387A8
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 21:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52E2B300E4E0
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 20:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E892F0C49;
	Fri, 16 Jan 2026 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjdX1EaY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65BB23909F;
	Fri, 16 Jan 2026 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768595984; cv=none; b=HedDjZfDTILqtKd9h4pl9i/8dnpWBP72o1fJlv/oQvEf9ZIJEVMslII+QU01sPFS2DbV9bKpH1RngACX9cYnieiXnx6zuVWtaTtiLzd3tZ/fx6e57/a229n9XXe47gWnu/6tn5POeEPfAKBkfKTgsxeVW7on9OYXCCnXT5wcivg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768595984; c=relaxed/simple;
	bh=g0s3NQdiiEPuuibuulDaYJ0ThR/8amV1tDpLPjSVce0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=t3zY+BXdlRJdYvVXoj84tpjUbV5wsykI/H/ShaCbFL5VM6+rrvdQkvm+wgv7AtoH3wEyCawj/3g0/P7TJNL08GP3zLf6JfXFMqkzt4O+AEXDUdwBVjpXpiRuYo76ZUPpKpm4YQxbViWV4koclri800WjxzjtBpawCWEeHaziYW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjdX1EaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E84DC116C6;
	Fri, 16 Jan 2026 20:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768595983;
	bh=g0s3NQdiiEPuuibuulDaYJ0ThR/8amV1tDpLPjSVce0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=HjdX1EaYZQcpf0K/ZdD8/L2WGBNmDkL/y3+XgC6EJX5prq6rmy/gaBqdAW6Ucq0kC
	 ctdhCoOMqmixiRxI91nPZAIfQATgdT/3G0N5qCEDt+kQQJrWPXUK4CFpSaaes4euRi
	 ef+jCWqug4EUUYeUIRSh+L7eOudCH1xe8IZCKyTwuyxZd+nQOaJkFZcAmw3hSp0TQ3
	 LByVFKZT+vDd+Z3w4Tr1gyhr2S0D45sauRFMP89tzwetothTapqCDFrEUNi7A95xzW
	 WKZpfU0y8kg+hKvU3DuT7Pw2yOiCSoKLncwPAZSKJ1Z9dMzaBaKDBKMODOSvHNgSre
	 PAxVqYp7ou7LA==
Content-Type: multipart/mixed; boundary="===============4653148688904203614=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d2f3a4f9eb847c74dbc7e584bfcff55bdde5c4c20382f77339299e1cc95e4102@mail.kernel.org>
In-Reply-To: <20260116201700.864797-6-ihor.solodrai@linux.dev>
References: <20260116201700.864797-6-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v2 05/13] resolve_btfids: Support for KF_IMPLICIT_ARGS
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com
Cc: yatsenko@meta.com,tj@kernel.org,alan.maguire@oracle.com,bentiss@kernel.org,jikos@kernel.org,ameryhung@gmail.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-input@vger.kernel.org,sched-ext@lists.linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 16 Jan 2026 20:39:43 +0000 (UTC)

--===============4653148688904203614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index 1fcf37af6764..b83316359cfd 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c

[ ... ]

> +struct btf2btf_context {
> +	struct btf *btf;
> +	u32 *decl_tags;
> +	u32 nr_decl_tags;
> +	struct kfunc *kfuncs;
> +	u32 nr_kfuncs;
> +};

[ ... ]

> +static int collect_decl_tags(struct btf2btf_context *ctx)
> +{
> +	const u32 type_cnt = btf__type_cnt(ctx->btf);
> +	struct btf *btf = ctx->btf;
> +	const struct btf_type *t;
> +	u32 *tags, *tmp;
> +	u32 nr_tags = 0;
> +
> +	tags = malloc(type_cnt * sizeof(u32));
> +	if (!tags)
> +		return -ENOMEM;

[ ... ]

> +	tmp = realloc(tags, nr_tags * sizeof(u32));
> +	if (!tmp) {
> +		free(tags);
> +		return -ENOMEM;
> +	}
> +
> +	ctx->decl_tags = tmp;
> +	ctx->nr_decl_tags = nr_tags;
> +
> +	return 0;
> +}

[ ... ]

> +static s64 collect_kfuncs(struct object *obj, struct btf2btf_context *ctx)
> +{
> +	struct kfunc *kfunc, *kfuncs, *tmp;

[ ... ]

> +	kfuncs = malloc(ctx->nr_decl_tags * sizeof(*kfuncs));
> +	if (!kfuncs)
> +		return -ENOMEM;

[ ... ]

> +	tmp = realloc(kfuncs, nr_kfuncs * sizeof(*kfuncs));
> +	if (!tmp) {
> +		free(kfuncs);
> +		return -ENOMEM;
> +	}
> +
> +	ctx->kfuncs = tmp;
> +	ctx->nr_kfuncs = nr_kfuncs;
> +
> +	return 0;
> +}
> +
> +static int build_btf2btf_context(struct object *obj, struct btf2btf_context *ctx)
> +{
> +	int err;
> +
> +	ctx->btf = obj->btf;
> +
> +	err = collect_decl_tags(ctx);
> +	if (err) {
> +		pr_err("ERROR: resolve_btfids: failed to collect decl tags from BTF\n");
> +		return err;
> +	}
> +
> +	err = collect_kfuncs(obj, ctx);
> +	if (err) {
> +		pr_err("ERROR: resolve_btfids: failed to collect kfuncs from BTF\n");
> +		return err;
                  ^^^^

When collect_kfuncs() fails here, ctx->decl_tags has already been allocated
by collect_decl_tags() but is not freed before returning. Should this error
path call free(ctx->decl_tags)?

> +	}
> +
> +	return 0;
> +}

[ ... ]

> +static int btf2btf(struct object *obj)
> +{
> +	struct btf2btf_context ctx = {};
> +	int err;
> +
> +	err = build_btf2btf_context(obj, &ctx);
> +	if (err)
> +		return err;
> +
> +	for (u32 i = 0; i < ctx.nr_kfuncs; i++) {
> +		struct kfunc *kfunc = &ctx.kfuncs[i];
> +
> +		if (!(kfunc->flags & KF_IMPLICIT_ARGS))
> +			continue;
> +
> +		err = process_kfunc_with_implicit_args(&ctx, kfunc);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
          ^^^^

ctx.decl_tags and ctx.kfuncs are allocated during build_btf2btf_context()
but are never freed on any return path from btf2btf(). While this may be
acceptable for a short-lived build tool where the OS reclaims memory on
exit, should cleanup be added for consistency with the rest of the code
which carefully frees allocations?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21079944982

--===============4653148688904203614==--

