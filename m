Return-Path: <bpf+bounces-78371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAD1D0C098
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 20:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9865730D8FEA
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 19:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881412E8DE3;
	Fri,  9 Jan 2026 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxZvkyBl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1521D618A;
	Fri,  9 Jan 2026 19:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767986151; cv=none; b=jbKWavlowT2Ql/62zW8njnJijxgQP6n312BJLTuRvrO1aj2DRFxqgZ/Os0GstxGYErHdKF6fJIYJKi+460mnZVLvhUvu8xXdIwRlH6V6sG4447fNBxNvwOa+sc/4gCS/mf6aXw6BvBAg5fbCtpv2ajoR6RWiptsxt4Q8Rbi/cHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767986151; c=relaxed/simple;
	bh=jjYlMgeOb7iZKTx6uD7Orq9iSBiO6P8v8IczmbWjp2A=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=oe/27JiLF4x3GWFpmIKBtNq9tjD8OqdUEGvqWQPA0kOBnajd5OD6MdH5KhGP50MV5t8oTwlbPt//H7kHffrrEg3bzzNI5ZQ1CYi6l0WBivq9+vS/fB5EvllmcrvlsK4r4MCZYtv57pH9SugugT6RReJTBhSV/YavPRILAp5CaTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxZvkyBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE86C4CEF1;
	Fri,  9 Jan 2026 19:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767986150;
	bh=jjYlMgeOb7iZKTx6uD7Orq9iSBiO6P8v8IczmbWjp2A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=XxZvkyBl68y/CkL/OQhuUpUHHg8ja7SnGl5z9p6ZEo3gTKpv1B0O1yNbjSjY1TDTb
	 /+OtFOde3/qwV+5Nd+7addATX5zOU+1cU0PIxc6QYjvr689owdXzTOnncxp8VkcGQe
	 9JDO3TqSHiMW1B66xx+inEvdLnFWChtK6Gvb7BaZF/7gPV0yfTG2zDrkTVolfT7C2M
	 +mFsy1D2uMGyD0hbaZ8fC071bQQgzaQNqP13KIwPXLTMxPUBeTrQTbItrt9iOW0iHM
	 IItfpqm3BTxKFwgv1p+ZY84zoieJD4gFKFLuY/wLF23YJT/VBnR5qJcMfu3Nf+ksEH
	 I+yFaKrBjW1Ig==
Content-Type: multipart/mixed; boundary="===============1158628782040348513=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <614a1ac62ade1a2c93f3669dea78d37d1fba159f1f00e79c5e8047047a772d75@mail.kernel.org>
In-Reply-To: <20260109184852.1089786-5-ihor.solodrai@linux.dev>
References: <20260109184852.1089786-5-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v1 04/10] resolve_btfids: Support for KF_IMPLICIT_ARGS
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com
Cc: yatsenko@meta.com,tj@kernel.org,alan.maguire@oracle.com,bentiss@kernel.org,jikos@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-input@vger.kernel.org,sched-ext@lists.linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  9 Jan 2026 19:15:50 +0000 (UTC)

--===============1158628782040348513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index df39982f51df..b361e726fa36 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c

[ ... ]

> +static s64 btf__collect_decl_tags(const struct btf *btf, s32 *decl_tags, u32 decl_tags_sz)
> +{
> +	const u32 type_cnt = btf__type_cnt(btf);
> +	const struct btf_type *t;
> +	s64 nr_decl_tags = 0;
> +
> +	for (u32 id = 1; id < type_cnt; id++) {
> +		t = btf__type_by_id(btf, id);
> +		if (!btf_is_decl_tag(t))
> +			continue;
> +		if (nr_decl_tags >= decl_tags_sz) {
> +			pr_err("ERROR: resolve_btfids: too many decl tags in BTF - limit %s\n",
> +				decl_tags_sz);
                                ^^^^^^^^^^^^^^^^^

Should this be %u instead of %s? The decl_tags_sz parameter is a u32, but
the format specifier %s expects a string pointer. When the error path is
triggered (more than MAX_DECL_TAGS decl tags in BTF), this will cause
undefined behavior as printf tries to interpret the integer value as a
memory address to read a string from.

> +			return -E2BIG;
> +		}
> +		decl_tags[nr_decl_tags++] = id;
> +	}
> +
> +	return nr_decl_tags;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20862592244

--===============1158628782040348513==--

