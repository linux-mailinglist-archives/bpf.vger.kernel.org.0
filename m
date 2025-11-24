Return-Path: <bpf+bounces-75348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38422C815B6
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 16:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35F154E75E8
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 15:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A7A313E0A;
	Mon, 24 Nov 2025 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuZeIxdH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8465D30146C
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763998259; cv=none; b=So6eQBtFAaCgqmgBPLH4GpfBsqU+1FixVKsAv29FXGKTJseaZom2o7inWAUd56cborPynPT6ouY3tYYNNn4Mr3ihXUTdxWBpxhnz0eos6OHDTQKxkxThILAJAYBXDB85nqma+1B4rI7nR2QmFnhUdA24impX6pIpyOLCHWhKPag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763998259; c=relaxed/simple;
	bh=so++bDFHaONpjw+/cCTk7fSIGS/8OasnhehdKygj1Ok=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=KmVsq4/8mB/aOJbwlqpo9FXs1C63e/DJnM1hkYWMKuJReUYPx6ESMR3lPxbGLqzID/6w227UFnKkGOOaryuuCD9jmJ5gZqYHrOmS5ZSaRsMaKK3Xx+bVEbEM9x/1NBeXfIOWcc8Er6AKIJ+3SbrIDU/zS4+Nzl3e5UIs8GAO2lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuZeIxdH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C667CC4CEF1;
	Mon, 24 Nov 2025 15:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763998259;
	bh=so++bDFHaONpjw+/cCTk7fSIGS/8OasnhehdKygj1Ok=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=IuZeIxdHooHF1JHo4HkmYFUV3Z/dy0TEIJ+7lFmavZn5yQ1MIj0f2HAGit07PLawJ
	 P6lChfvx3TyzuC2qDw8B586KdxYkaj5ZVfoMnYUkq1T87nx5lCcagc5zcfVeX26rOg
	 uvMx9VH/rlLUU2oUkgl4L13qY7GmPNaKbOGhoGxRlO2m/vnsnFR+BHP1+pVoPlfhNm
	 89aLrUC93Bo6aaUlTbpb4iISnmk/Hu4RAituRxe07WHmtfefYLOBtzaqIJxSEBs7FQ
	 51FOxeMVb45dT9tFM4Ry7PL432/poq8M8BdZZ/AYnunYiBaBMnPg57jiyeJF1KczMy
	 hOTHOW72BpO8A==
Content-Type: multipart/mixed; boundary="===============2946030574216318029=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <02181509c0573bc63b5c111cb1dadb0e9d1577ff5465dcaaa902181a0fdedc3c@mail.kernel.org>
In-Reply-To: <20251124151515.2543403-1-a.s.protopopov@gmail.com>
References: <20251124151515.2543403-1-a.s.protopopov@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: cleanup aux->used_maps after jit
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,bpf@vger.kernel.org
Cc: a.s.protopopov@gmail.com,ast@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Nov 2025 15:30:58 +0000 (UTC)

--===============2946030574216318029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2e170be64..766695491 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -22266,6 +22266,15 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>  		cond_resched();
>  	}
>
> +	/*
> +	 * Cleanup func[i]->aux fields which aren't required
> +	 * or can become invalid in future
> +	 */
> +	for (i = 0; i < env->subprog_cnt; i++) {
> +		func[i]->aux->used_maps = NULL;
> +		func[i]->aux->used_map_cnt = 0;
> +	}
> +

The patch correctly fixes the use-after-free issue. However, this isn't a
bug, but should this have a Cc: stable@vger.kernel.org tag? The bug being
fixed affects released kernels where bpf_prog_free_deferred() will call
bpf_free_used_maps() on the dangling func[i]->aux->used_maps pointer,
potentially causing kfree() to be called on already-freed or invalid memory.

>  	/* finally lock prog and jit images for all functions and
>  	 * populate kallsysm. Begin at the first subprogram, since
>  	 * bpf_prog_load will add the kallsyms for the main program.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19639286497

--===============2946030574216318029==--

