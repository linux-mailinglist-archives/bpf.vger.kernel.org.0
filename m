Return-Path: <bpf+bounces-42711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0661E9A9470
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 02:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A177C1F23134
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 00:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E05B1FF617;
	Tue, 22 Oct 2024 00:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDEoCgaD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F6412C526
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 00:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729555225; cv=none; b=lDlf31APupHa69jnDG/bGwcpydlMvloGeWl1G4EuHatdaIbhgxoyqQ4Luz9bW7r0dQWUtuuwvlNWWNi9p6xFElJVlqxuN1/lcjthPJ4Y/WdW0sTKHUn6F01XiOJ9Z6VsLkLT9CJJF0OPppDZVCOuw+HSsHxkQBpxSmS7ZsJczRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729555225; c=relaxed/simple;
	bh=DbTcVzOjsClpB033q8tfFxsvqOlRt9nJOpt4d7ywp/Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gaTn9ijEjOUqUEKx7FMVp5sPGMjNWitvDawkR/0PrBfQCfxQTHW9F7RCRRgpsHInQshvR2cj6IpHor4VzfUBn771H3TuBxiuhmaI4TW0tkFh+5UjtR4gTOOZSXRlsmD3U56RB1P8Q7b+L51wqsRg/5cnqUNGW8RxHGg9MdXY1ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDEoCgaD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37D6C4CEC3;
	Tue, 22 Oct 2024 00:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729555225;
	bh=DbTcVzOjsClpB033q8tfFxsvqOlRt9nJOpt4d7ywp/Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FDEoCgaDg8oVzjX+Da71S6ZZGOQ+xBMCdPvmGfkWf5j0DlLb7LftpwwcjG5waTcBf
	 zAygDhDfMj5qHHUKJwmWEhY/O09U7mGrqTADM3nXL454m+XaE3YFHRlMl1Ctc7yiiB
	 LTDdqKKviiW6MOtunTHKlLiXY8QjjyqyZ3chdfjZ9zKrgBFNJkmDERtmgEmHLPhI4W
	 n08qNdvpAelAUovnLYKj4oQKZucostW84bEgTSRLYwjRV3MX2Bd/OCeWutEQ9FhNz8
	 eDOMkUvNCvf1fD4SzNzjaele5SKMldcBl5QzmkEqc+EcjpZG9HEnIVbH8e0j3Q9OUC
	 +Tvwf+O3SsWXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D5D3809A8A;
	Tue, 22 Oct 2024 00:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] selftests/bpf: Improve building with extra
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172955523104.481500.2189353533292208619.git-patchwork-notify@kernel.org>
Date: Tue, 22 Oct 2024 00:00:31 +0000
References: <cover.1729233447.git.vmalik@redhat.com>
In-Reply-To: <cover.1729233447.git.vmalik@redhat.com>
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 18 Oct 2024 08:48:58 +0200 you wrote:
> When trying to build BPF selftests with additional compiler and linker
> flags, we're running into multiple problems. This series addresses all
> of them:
> 
> - CFLAGS are not passed to sub-makes of bpftool and libbpf. This is a
>   problem when compiling with PIE as libbpf.a ends up being non-PIE and
>   cannot be linked with other binaries (patch #1).
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] selftests/bpf: Allow building with extra flags
    https://git.kernel.org/bpf/bpf-next/c/7b164c648ee2
  - [bpf-next,v2,2/3] bpftool: Prevent setting duplicate _GNU_SOURCE in Makefile
    https://git.kernel.org/bpf/bpf-next/c/a89cf33e4e30
  - [bpf-next,v2,3/3] selftests/bpf: Disable warnings on unused flags for Clang builds
    https://git.kernel.org/bpf/bpf-next/c/832c03d644ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



