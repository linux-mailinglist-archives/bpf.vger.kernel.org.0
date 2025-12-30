Return-Path: <bpf+bounces-77525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8031CCEA1B8
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 16:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4056F302069B
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 15:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB1D28505E;
	Tue, 30 Dec 2025 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3cX7PmS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3573586277
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767109931; cv=none; b=Q+wGs18kggnV8KaUbmxFFeso06ENLjjGfl792BARybBaCOCozd84YXJ1NGY0CwAopQ+yDrRN+eRF8MlHRuqGTh+MGugMeHnG5clsq7HLT4Edd2zoRJYk27PVSiCZvzpYSQ38GbyKFxhBlhGNgdsX8/zYKikuzQOVA9ZdAtw8I1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767109931; c=relaxed/simple;
	bh=jpE3XS7LLVWZl5RB7RTF8tvL118kgiEy2+UIBump8/8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mRYj6XFERPEzVuk/TduHkC6WpxbX8hdmpohx9pQOSOmcizbdLK0QsomWgwEcxQ4FAVr7vcoxJrA19thx9n+bVfqiNsAe5LYY90f6XCESkJpyJejLmWsQcGusnJWrN6bxTG2qxBFqbPHYpnm7jgeKlBGrk+2k1Bq9EkZ30LRLMdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3cX7PmS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF6FC4CEFB;
	Tue, 30 Dec 2025 15:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767109931;
	bh=jpE3XS7LLVWZl5RB7RTF8tvL118kgiEy2+UIBump8/8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=i3cX7PmSXolDOHBPUljlicXkjmk1Dxt237oMLcJF9I/vhLtHdKXopQyqgJ/GHQB26
	 GY62NwqtMQPLUF7qGYaFCQiygJoMJk1taUnYf4FutXb4SQ+kZqGL2G+q75k9AUpqk3
	 Fb/osTHVqahLoVZxfgyX/alsHHWy4UwwiSkFGfK7xXj6/B0Fnz4PaPqtPAtHNLKAPJ
	 CmmChjlhPbwY1cUZRmsEhFCy8r38FsCMi3PdNwxA7B204/RSnsVQBE9fwpW792hJWa
	 qnFOOw1nGDGPip0fG43nxHjcS97GpkOoXv+2/znApoVMDOWZCTrQYO9Wx/ZlB+C6lJ
	 Nr89uEMve4ivw==
Content-Type: multipart/mixed; boundary="===============8276163505264847807=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f29cb38331f26f41672903896d38fb3321a34f2d31f27fbd2b7a34a16a2caac6@mail.kernel.org>
In-Reply-To: <20251230153006.1347742-3-puranjay@kernel.org>
References: <20251230153006.1347742-3-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next 2/2] bpf: arena: Reintroduce memcg accounting
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 30 Dec 2025 15:52:10 +0000 (UTC)

--===============8276163505264847807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
> index 99c63d982c5d..2f28886f3ff7 100644
> --- a/kernel/bpf/range_tree.c
> +++ b/kernel/bpf/range_tree.c

[ ... ]

> @@ -234,7 +235,7 @@ int range_tree_set(struct range_tree *rt, u32 start, u32 len)
>  		right->rn_start = start;
>  		range_it_insert(right, rt);
>  	} else {
> -		left = kmalloc_nolock(sizeof(struct range_node), 0, NUMA_NO_NODE);
> +		left = kmalloc_nolock(sizeof(struct range_node), __GFP_ACCOUNT, NUMA_NO_NODE);
>  		if (!left)
>  			return -ENOMEM;

range_tree_set() is also called from arena_free_worker() at arena.c line 803.
arena_free_worker() runs in workqueue context and does not use
bpf_map_memcg_enter/exit around its range_tree_set() call.

With this change, when range_tree_set() allocates a new range_node in
arena_free_worker(), it will be charged to the kworker's memcg rather
than the map creator's memcg.

Is this consistent with the commit message claim that "All arena related
allocations are accounted into memcg of the process that created
bpf_arena"? Should arena_free_worker() also wrap its range_tree_set()
call with bpf_map_memcg_enter/exit?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20600148215

--===============8276163505264847807==--

