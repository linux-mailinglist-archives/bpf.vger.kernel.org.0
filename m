Return-Path: <bpf+bounces-76619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93728CBEF66
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 17:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B438304C28A
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 16:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B55308F3B;
	Mon, 15 Dec 2025 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwXsFZ6N"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F92283FF5
	for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816665; cv=none; b=OuFF85dD6YxaR69bwgTwUPN8smhPcQWAF1fljgO5mcvfT2Al5pFH+3OKGY9COLNQ26R0wfkPFHtimOdeW0ifEcp7/8PyY+jwqfHg5UkgHSZY6pgEFRiL//jTdaJCxh6gQKFbumydq6cDpnjumYMUcwKdsPrAx5bBi5fwAFuYzVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816665; c=relaxed/simple;
	bh=ij0IVXwT0Obe5yj+8iJv3WHf7RlXNPIH/ZsJWYxv0ug=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=G1K/xDC3jie0w8vL4at3r/E4RXCwk4579eMp4qZ3t3GH5dgDc20lYVDHWECULzpP0wUiC9+KvKUVs6T7s8ofYkV2MLTk1yOgLKSwNzXF3df/qsKzu8nl5FNW6GHFnXccSa7Q+hrFYi63HJu2zkW7VC9bvb+Le0TjGefg+4NVS+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwXsFZ6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABB2C4CEF5;
	Mon, 15 Dec 2025 16:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765816664;
	bh=ij0IVXwT0Obe5yj+8iJv3WHf7RlXNPIH/ZsJWYxv0ug=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=VwXsFZ6NXwvv96b1FOzqquY5RD/bxpN/5KXkpkJViLdNl8WKujKxfOBpOLd8AiGmm
	 IEspfoMgx5vsQEwsZer8RPvQhL9DKHivDNCXFAAHOWNslt9Xs31SgL3Gy4PBgCe/kK
	 hxVY+qYky6VL92anWNz64aix5VZikvWDrz42IjwxJ50vIUsSaQCrZf9Nmmdr8YMB4S
	 rmfzcI+4ivmAi+Db+Y/UdvQNJZl2+fZa5oH8WkFleDRIG6qLyD7e1cv/4Y3BKGBjtp
	 hlZ5oezzkDaqtQXVDm4/L4zRv4QW23fAIKV4u1mKmB3zz31IhbmmFut9CstHCSRmlu
	 Q41mGmgjqcpEA==
Content-Type: multipart/mixed; boundary="===============4399289915081923455=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9ddeb4c102ee96af6b969ca2894438e94c20e6ac1781a25928b0a5a76ec8702b@mail.kernel.org>
In-Reply-To: <20251215161313.10120-4-emil@etsalapatis.com>
References: <20251215161313.10120-4-emil@etsalapatis.com>
Subject: Re: [PATCH v3 3/5] libbpf: turn relo_core->sym_off unsigned
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,memxor@gmail.com,yonghong.song@linux.dev,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 15 Dec 2025 16:37:44 +0000 (UTC)

--===============4399289915081923455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index c7c79014d46c..5e66bbc2ab85 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -380,7 +380,7 @@ struct reloc_desc {
>  		const struct bpf_core_relo *core_relo; /* used when type == RELO_CORE */
>  		struct {
>  			int map_idx;
> -			int sym_off;
> +			unsigned int sym_off;
>  			/*
>  			 * The following two fields can be unionized, as the
>  			 * ext_idx field is used for extern symbols, and the
> @@ -763,7 +763,7 @@ struct bpf_object {
>
>  	struct {
>  		struct bpf_program *prog;
> -		int sym_off;
> +		unsigned int sym_off;
>  		int fd;
>  	} *jumptable_maps;
>  	size_t jumptable_map_cnt;

The field type change looks correct, but does create_jt_map() defeat
the purpose of this patch? That function declares a local variable
"int sym_off" that immediately converts the unsigned field back to
signed. When sym_off is >= 2GiB (the exact scenario this patch enables),
the local variable will interpret it as negative, causing incorrect
behavior in the modulo check, bounds check, and pointer arithmetic that
follow.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20239524817

--===============4399289915081923455==--

