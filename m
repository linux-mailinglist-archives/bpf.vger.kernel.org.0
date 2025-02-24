Return-Path: <bpf+bounces-52422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C24A42D87
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 21:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26BFD3B1B18
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 20:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3977206F3E;
	Mon, 24 Feb 2025 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPZj7R0g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0EE19DF8C
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 20:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740428400; cv=none; b=GxheD90ipgeZ3djY0M8JVfJpC6kASLFtmKuRP3N7bqAqyxuLvoU9/1b9pViAgUUibFccaMo9jqo2DUSHHjK48HgkobWLQvKnIl3ooPFvQscIOwZumrKt/jZpHU+ddfPef1IQc7A8o31nBb+VlmDTxY0oU8PSXrt/O+gr7nx2QEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740428400; c=relaxed/simple;
	bh=x/UNAg4fmzgXbmTj7I85Jiu5TZvwExwwZH/y5GeYpxY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WkWYvbDG8taABSH1Lf4qujeGtXTAq8qKof5mD5BMaoy1n1nJAfWEl0geLd8wR8xRCFzMGEEcVipNgNH2lttfOeITV7LbAtsM5zgJ0pa1uLVXAzH5y1cbq9X2r5OT/oUQC4Q+6srBGdDhQfS7gLFW6TejRvZwD8ReHXWSa03hg3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPZj7R0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDB9C4CED6;
	Mon, 24 Feb 2025 20:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740428399;
	bh=x/UNAg4fmzgXbmTj7I85Jiu5TZvwExwwZH/y5GeYpxY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jPZj7R0gffQkQDFx2cvmJbATjfb+eoutcEH3SLFX8/1g/9fuT7Il63aiww8axzhJa
	 Fur3YdIsCahAcp3jqrg7RO7oywgTFX2f5BbTqVQMiZwlUUIClJKnZUBungbuesyBMK
	 /A9zXrO4/cjCTG9nToHk6iAtIs7iELf/GaUqn03qpXSS2hDpDvzI2J2SCmM0e6dmQ7
	 2Ow+K/8pxiA6hd5hd+aluTFftChTagtFBio82Ononwr/P3m/b8OLiHMaOHGIx81mZI
	 4mXD4eKH3yDCQ2mUD/s59ERNzj0T3IVGRFjDjGhddkH4IV3J5/JWjx91rgDagqBJBx
	 lQQj5j73wM44Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DBE380CEFC;
	Mon, 24 Feb 2025 20:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix kmemleak warnings for percpu hashmap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174042843126.3595767.15074738833210480318.git-patchwork-notify@kernel.org>
Date: Mon, 24 Feb 2025 20:20:31 +0000
References: <20250224175514.2207227-1-yonghong.song@linux.dev>
In-Reply-To: <20250224175514.2207227-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 thevlad@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 24 Feb 2025 09:55:14 -0800 you wrote:
> Vlad Poenaru from Meta reported the following kmemleak issues:
> 
>   ...
>   unreferenced object 0x606fd7c44ac8 (size 32):
>     comm "floodgate_agent", pid 5077, jiffies 4294746072
>     hex dump (first 32 bytes on cpu 32):
>       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     backtrace (crc 0):
>       pcpu_alloc_noprof+0x730/0xeb0
>       bpf_map_alloc_percpu+0x69/0xc0
>       prealloc_init+0x9d/0x1b0
>       htab_map_alloc+0x363/0x510
>       map_create+0x215/0x3a0
>       __sys_bpf+0x16b/0x3e0
>       __x64_sys_bpf+0x18/0x20
>       do_syscall_64+0x7b/0x150
>       entry_SYSCALL_64_after_hwframe+0x4b/0x53
>   unreferenced object 0x606fd7c44ae8 (size 32):
>     comm "floodgate_agent", pid 5077, jiffies 4294746072
>     hex dump (first 32 bytes on cpu 32):
>       d3 08 00 00 00 00 00 00 d3 08 00 00 00 00 00 00  ................
>       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     backtrace (crc d197b0fe):
>       pcpu_alloc_noprof+0x730/0xeb0
>       bpf_map_alloc_percpu+0x69/0xc0
>       prealloc_init+0x9d/0x1b0
>       htab_map_alloc+0x363/0x510
>       map_create+0x215/0x3a0
>       __sys_bpf+0x16b/0x3e0
>       __x64_sys_bpf+0x18/0x20
>       do_syscall_64+0x7b/0x150
>       entry_SYSCALL_64_after_hwframe+0x4b/0x53
>   ...
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix kmemleak warnings for percpu hashmap
    https://git.kernel.org/bpf/bpf-next/c/11ba7ce076e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



