Return-Path: <bpf+bounces-79340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE91D387DE
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 21:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C72BA3022386
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 20:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495F72FD1CF;
	Fri, 16 Jan 2026 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FwGLoQIr"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6632EFD8C
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 20:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768596288; cv=none; b=lOBofO+buDDdhyh+r484ny1Qt4Sb6JRKy7OukIfeG3YKI6cT3VIQM88a7ufNKgPkOx1CeYzo46ehS8VvdgumnglzuBcmTE/xRV9ObD5yQYhGkvDGlB9UV4kOsA+sdx1c/JJ9Pqnxy0puoyblPtg0jbdEIQoy+xrJLRGTsjtOadY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768596288; c=relaxed/simple;
	bh=/lcqHc3KHybP6LTdRTheMtS4AFNq+ytXLhoE56x3fyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sp0cYAsFAEP0bxBOEyleSkLtWfw6DDCGBgWW1/2RXgcdUsA1tCriDaVhEKkKooqkuNcbGrw2LhphDrryCLu2uYxF3XGdObGdKA2CFuWp3xRlxcObRKXO76A/wJoHhuaFfCJxn4+LneDFiUXo/KVzs1Bf8iHpnfU8fvj6y5f2hwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FwGLoQIr; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b15c25ab-2475-4129-bebe-db0c2f3a6aa8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768596283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9PkUvpmRHaWd+YzzirJU4VKyg/9aK2LBtcrvwyRV/NU=;
	b=FwGLoQIrAFb5qFF5BQ9Y3nUULGnh6IDxkHak4mVRZg/Po6WjghaP2nheonCmORb2UxlQP8
	8r0AG1T7+0aAvRJ+iBfS8+hbyFESlN+knpIcTAL5NVzuLhrSioSXmfTcsDL5OwcLDWS2mX
	mvGLqJPZvsgqQvWP4oZYoAON/ooKEBY=
Date: Fri, 16 Jan 2026 12:44:34 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 05/13] resolve_btfids: Support for
 KF_IMPLICIT_ARGS
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com
Cc: yatsenko@meta.com, tj@kernel.org, alan.maguire@oracle.com,
 bentiss@kernel.org, jikos@kernel.org, ameryhung@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, sched-ext@lists.linux.dev,
 martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com
References: <20260116201700.864797-6-ihor.solodrai@linux.dev>
 <d2f3a4f9eb847c74dbc7e584bfcff55bdde5c4c20382f77339299e1cc95e4102@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <d2f3a4f9eb847c74dbc7e584bfcff55bdde5c4c20382f77339299e1cc95e4102@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/16/26 12:39 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>> index 1fcf37af6764..b83316359cfd 100644
>> --- a/tools/bpf/resolve_btfids/main.c
>> +++ b/tools/bpf/resolve_btfids/main.c
> 
> [ ... ]
> 
>> +struct btf2btf_context {
>> +	struct btf *btf;
>> +	u32 *decl_tags;
>> +	u32 nr_decl_tags;
>> +	struct kfunc *kfuncs;
>> +	u32 nr_kfuncs;
>> +};
> 
> [ ... ]
> 
>> +static int collect_decl_tags(struct btf2btf_context *ctx)
>> +{
>> +	const u32 type_cnt = btf__type_cnt(ctx->btf);
>> +	struct btf *btf = ctx->btf;
>> +	const struct btf_type *t;
>> +	u32 *tags, *tmp;
>> +	u32 nr_tags = 0;
>> +
>> +	tags = malloc(type_cnt * sizeof(u32));
>> +	if (!tags)
>> +		return -ENOMEM;
> 
> [ ... ]
> 
>> +	tmp = realloc(tags, nr_tags * sizeof(u32));
>> +	if (!tmp) {
>> +		free(tags);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	ctx->decl_tags = tmp;
>> +	ctx->nr_decl_tags = nr_tags;
>> +
>> +	return 0;
>> +}
> 
> [ ... ]
> 
>> +static s64 collect_kfuncs(struct object *obj, struct btf2btf_context *ctx)
>> +{
>> +	struct kfunc *kfunc, *kfuncs, *tmp;
> 
> [ ... ]
> 
>> +	kfuncs = malloc(ctx->nr_decl_tags * sizeof(*kfuncs));
>> +	if (!kfuncs)
>> +		return -ENOMEM;
> 
> [ ... ]
> 
>> +	tmp = realloc(kfuncs, nr_kfuncs * sizeof(*kfuncs));
>> +	if (!tmp) {
>> +		free(kfuncs);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	ctx->kfuncs = tmp;
>> +	ctx->nr_kfuncs = nr_kfuncs;
>> +
>> +	return 0;
>> +}
>> +
>> +static int build_btf2btf_context(struct object *obj, struct btf2btf_context *ctx)
>> +{
>> +	int err;
>> +
>> +	ctx->btf = obj->btf;
>> +
>> +	err = collect_decl_tags(ctx);
>> +	if (err) {
>> +		pr_err("ERROR: resolve_btfids: failed to collect decl tags from BTF\n");
>> +		return err;
>> +	}
>> +
>> +	err = collect_kfuncs(obj, ctx);
>> +	if (err) {
>> +		pr_err("ERROR: resolve_btfids: failed to collect kfuncs from BTF\n");
>> +		return err;
>                   ^^^^
> 
> When collect_kfuncs() fails here, ctx->decl_tags has already been allocated
> by collect_decl_tags() but is not freed before returning. Should this error
> path call free(ctx->decl_tags)?
> 
>> +	}
>> +
>> +	return 0;
>> +}
> 
> [ ... ]
> 
>> +static int btf2btf(struct object *obj)
>> +{
>> +	struct btf2btf_context ctx = {};
>> +	int err;
>> +
>> +	err = build_btf2btf_context(obj, &ctx);
>> +	if (err)
>> +		return err;
>> +
>> +	for (u32 i = 0; i < ctx.nr_kfuncs; i++) {
>> +		struct kfunc *kfunc = &ctx.kfuncs[i];
>> +
>> +		if (!(kfunc->flags & KF_IMPLICIT_ARGS))
>> +			continue;
>> +
>> +		err = process_kfunc_with_implicit_args(&ctx, kfunc);
>> +		if (err)
>> +			return err;
>> +	}
>> +
>> +	return 0;
>> +}
>           ^^^^
> 
> ctx.decl_tags and ctx.kfuncs are allocated during build_btf2btf_context()
> but are never freed on any return path from btf2btf(). While this may be
> acceptable for a short-lived build tool where the OS reclaims memory on
> exit, should cleanup be added for consistency with the rest of the code
> which carefully frees allocations?

Right. I just noticed this after sending.

As AI mentioned, it's not a sever issue, but we should free everything
properly to be consistent.


> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21079944982


