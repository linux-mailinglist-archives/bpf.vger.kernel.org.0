Return-Path: <bpf+bounces-76513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36152CB7E62
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 06:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2666300A25B
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 05:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0526330BBA9;
	Fri, 12 Dec 2025 05:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeJow2aN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C36121CC79
	for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 05:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765515853; cv=none; b=a5jyLt5a7YBxdVIYWNRec+Vzg9UDoDROnOV6WqqjKQlpjL9cqQEdO4KPSsX7mqTwmnzigh9+fbd/EkbWmvRxbNfJ64lga/LA2xtv/dFRl5R+XIWPYr1P89V46LVEAVcnZK0xojNaf7fw4ANIbTeXTCkyd+t5WK4mmc3Ax5MrjP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765515853; c=relaxed/simple;
	bh=1UkaImbhHXuj0tpYmrzsDw5fDC9ZZo5SWnppD+DmuUI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=E8j+tCpZd5Se0KF+YITGGMZ4WNYhgzuSXtxgMBrtwin9wBWkZnXCQKUloDoLcq/1i7p+YTycXvGXKFF4FVmY12xqEAH5IJLPbQamiaRPILJ2aXieiR7dGXijn774H5HAy/OUaZa99Wghv+us/hb4c5OlWGMpCQPOXw8helV6oGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeJow2aN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A491CC4CEF1;
	Fri, 12 Dec 2025 05:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765515852;
	bh=1UkaImbhHXuj0tpYmrzsDw5fDC9ZZo5SWnppD+DmuUI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=PeJow2aN9LbN/U4CWa94yn9HYhHkGVYxY0+Xc1N0agZx71IpWJTIcWwSU10ngwNj4
	 uZOxOkaGu3NnTHuxsPmv0rWvqDKeL8rR4qZmtN/gCTHmMbGWLWsoAlMcNv+Q1HykMs
	 wpgxRwtgUQf1a/8qhjh9y6GYYaKByPr5qbklXY27CV91xUZpgX+cwzM3oNh8plTyn7
	 dcEyu5uIiDyBg99hy2xzgeZRZMhSrUpLNLMZt8gTyuaXmQLQsxc5mVzbP9b+xxGgWN
	 wDKHUEWZORrKUf+4HXK+UOl74EAHMO+6/Vm119CFAL5kzBlaLRynOiB8oJ/2gmPkhK
	 JkMfaIo7nzDrw==
Content-Type: multipart/mixed; boundary="===============5980040323488217749=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <af86aa9e3f81872ae3f623614440c73448d2f5feb4bbaa9ad5942369681351d3@mail.kernel.org>
In-Reply-To: <20251212044516.37513-2-puranjay@kernel.org>
References: <20251212044516.37513-2-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v5 1/4] bpf: arena: populate vm_area without allocating memory
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 12 Dec 2025 05:04:11 +0000 (UTC)

--===============5980040323488217749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 1074ac4459f2..dd07268b67d4 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -477,17 +544,20 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
>  	 * kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE - 1 can overflow
>  	 * lower 32-bit and it's ok.
>  	 */
> -	ret = vm_area_map_pages(arena->kern_vm, kern_vm_start + uaddr32,
> -				kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE, pages);
> +	ret = apply_to_page_range(&init_mm, kern_vm_start + uaddr32,
> +				  page_cnt << PAGE_SHIFT, apply_range_set_cb, &data);
>  	if (ret) {
> -		for (i = 0; i < page_cnt; i++)
> +		mapped = data.i
                         ^^^^^^^^^

Is the missing semicolon here intentional? This causes a compilation
error in arena_alloc_pages().

> +		for (i = mapped; i < page_cnt; i++)
>  			__free_page(pages[i]);
>  		goto out;
>  	}
>  	kvfree(pages);
>  	return clear_lo32(arena->user_vm_start) + uaddr32;
>  out:
> -	range_tree_set(&arena->rt, pgoff, page_cnt);
> +	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
> +	if (mapped)
> +		arena_free_pages(arena, uaddr32, mapped);
>  out_free_pages:
>  	kvfree(pages);
>  	return 0;

[ ... ]

The commit message states the goal is to make bpf_arena_alloc_pages()
non-sleepable, but the KF_SLEEPABLE flag is not removed from the kfunc
registration. Without removing this flag, the BPF verifier still treats
the function as requiring sleepable context. Should the following change
be included to remove the flag from the kfunc definitions:

BTF_ID_FLAGS(func, bpf_arena_alloc_pages, KF_TRUSTED_ARGS | KF_ARENA_RET | KF_ARENA_ARG2)
BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_TRUSTED_ARGS | KF_ARENA_ARG2)
BTF_ID_FLAGS(func, bpf_arena_reserve_pages, KF_TRUSTED_ARGS | KF_ARENA_ARG2)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20156688454

--===============5980040323488217749==--

