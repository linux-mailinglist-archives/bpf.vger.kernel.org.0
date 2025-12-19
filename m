Return-Path: <bpf+bounces-77202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6F9CD1B8F
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 21:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 859DF3001BC9
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 20:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC5E34107D;
	Fri, 19 Dec 2025 20:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeZLOZhP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E985D340A4D;
	Fri, 19 Dec 2025 20:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766175213; cv=none; b=bML1ko9NI6gEwD86KeW1BzfF2Yhk6J+U9ygdb4e2jb0C0NtRymy8USehuSlDEFnQHAghZV6OsdgXFQG1j2KgfLe0+yrQqwLlrc4e8E/g9bJ9v0Ew2151ZrklQAlAEeEnpqCyJVY4MHIt3xOYcgltQKgK8XjAuMQnv8xI06mMukk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766175213; c=relaxed/simple;
	bh=sE0c0GGQsA1YI5deNqRs6714o7gIOr/u/TiO5P7G4Fo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M09QPfePCPyjWvCGADZW2Y4X9ECX9bkKCA6QNVZpHu8sXKe6dwylcGLuUQ91M6gLDyp5/HPR31vZYKaxXb/I0hQpqwgovMR9EQDr+VnZQAZk4lO4sG66ScwrsNLL9KEWE6e69YkfND9TrSBeL12p8J1zQhe3PqdzdMeoE/4ocFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeZLOZhP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51041C4CEF1;
	Fri, 19 Dec 2025 20:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766175212;
	bh=sE0c0GGQsA1YI5deNqRs6714o7gIOr/u/TiO5P7G4Fo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SeZLOZhPnZ9HHpGeBzhICjgByevTRmO0lIdvPTOkLcWummJjZXak2euFmB4jU9x/S
	 835+5wxqBm486Ux+ISQyx/nE5FzHnh/3QSOKSjpFtcgF2IW+nkyFRQJrEhaMcRewY2
	 acS4IM7SZjz/YmGs41Oy8WlwIgN1dZkwszQvYGQRzrkM2boEsG2DaXub1/otRM4q8X
	 fnFQOVkc/bbbpr6ybW0FN4SLquxc1oFIwM/m/BiyblmOxbYEiNBigTiDOF0H4Ajnqo
	 mbHYST3nBAq9Jjy+YJp9Flzj6JQ+yHnU97VKjGGnUi9RVfoafTfo9fbyvVcuM+wbAO
	 L8Epai+k/NxMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3C7BF380AAF2;
	Fri, 19 Dec 2025 20:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 0/8] resolve_btfids: Support for BTF
 modifications
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176617502078.3992426.17457796078611623356.git-patchwork-notify@kernel.org>
Date: Fri, 19 Dec 2025 20:10:20 +0000
References: <20251219181321.1283664-1-ihor.solodrai@linux.dev>
In-Reply-To: <20251219181321.1283664-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 akpm@linux-foundation.org, nathan@kernel.org, nsc@kernel.org, corbet@lwn.net,
 tj@kernel.org, void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 shuah@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, alan.maguire@oracle.com, dolinux.peng@gmail.com,
 bpf@vger.kernel.org, dwarves@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, sched-ext@lists.linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 19 Dec 2025 10:13:13 -0800 you wrote:
> This series changes resolve_btfids and kernel build scripts to enable
> BTF transformations in resolve_btfids. Main motivation for enhancing
> resolve_btfids is to reduce dependency of the kernel build on pahole
> capabilities [1] and enable BTF features and optimizations [2][3]
> particular to the kernel.
> 
> Patches #1-#4 in the series are non-functional changes in
> resolve_btfids.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,1/8] resolve_btfids: Rename object btf field to btf_path
    https://git.kernel.org/bpf/bpf-next/c/c1c7d61746f4
  - [bpf-next,v7,2/8] resolve_btfids: Factor out load_btf()
    https://git.kernel.org/bpf/bpf-next/c/5f347a0f781a
  - [bpf-next,v7,3/8] resolve_btfids: Introduce enum btf_id_kind
    https://git.kernel.org/bpf/bpf-next/c/a4fa885bd52d
  - [bpf-next,v7,4/8] resolve_btfids: Always build with -Wall -Werror
    https://git.kernel.org/bpf/bpf-next/c/fb348d4fdf5e
  - [bpf-next,v7,5/8] kbuild: Sync kconfig when PAHOLE_VERSION changes
    https://git.kernel.org/bpf/bpf-next/c/90e5b38a2652
  - [bpf-next,v7,6/8] lib/Kconfig.debug: Set the minimum required pahole version to v1.22
    https://git.kernel.org/bpf/bpf-next/c/903922cfa0e6
  - [bpf-next,v7,7/8] selftests/bpf: Run resolve_btfids only for relevant .test.o objects
    https://git.kernel.org/bpf/bpf-next/c/014e1cdb5fad
  - [bpf-next,v7,8/8] resolve_btfids: Change in-place update with raw binary output
    https://git.kernel.org/bpf/bpf-next/c/522397d05e7d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



