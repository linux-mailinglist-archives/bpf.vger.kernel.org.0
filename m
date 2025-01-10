Return-Path: <bpf+bounces-48591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4371A09D34
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 22:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF03A16ACE4
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 21:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383FC20897D;
	Fri, 10 Jan 2025 21:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y10fasD6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9168A1ADFE4
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 21:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736544617; cv=none; b=LRS1Kcd4NqP7N7WaxAbLvOzFiQwxAy7SpE+NlXF8bT9BxuCoGMLO0Xh3N0aMj884RuOW0Am7lWx3Dootb7EMjPEkl4q7OfWN4SK4i5apn3trS4cwctWkhTfrSRQYT4gfm06R0x3+Z19CMFvZ4IEtPXtBg4yMC75H5Q3i4qAUCPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736544617; c=relaxed/simple;
	bh=t/ZtytAQQcolNYsA3jAhx7yq6dBJW8YdvwlwWy9wODM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q6CQsoTFIovn/y2b4JpHEu2j/GdTU+tkOp+5JuWUXKSjZ67MkPnktZbt0bczGJ34lFlmXuJGAKJMZa+gzPtlP+QsqBuVSWNixTiyR4qAn02SXmOGmYv1WUFhZSMGOSKnzpHS2zmF6Vsy8HmBM/jnVCPt0nT5kevXjc6P9DsiCeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y10fasD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0996AC4CED6;
	Fri, 10 Jan 2025 21:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736544616;
	bh=t/ZtytAQQcolNYsA3jAhx7yq6dBJW8YdvwlwWy9wODM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y10fasD66/M5wsl7A3cvS5dvHNe3ynjAi6xDKJnZK74y5pjuCTIkfr8boAtI2N1/5
	 mexmn5YKKelAAIKnwAdc5/qVFqGoQgrBAt+nUQ7tdMRkmQlIssxqpwkhXS0NbGDumy
	 s618zy2Xl1oAakuGN1KvtKebztWAeDNf4Mu3pr5NO6ThJnzRWCDRWj/Ta3TKErjG6S
	 ikISyb+MZCy4NuHkfRAKU+oifYL1MZUnHCSjpOhJdpBWv6ruSWQviyHDyeQ79mMING
	 VIbr6SiOpwdWzdzl2gfuFq7NJ7PzPVAQUiwQbwtVa/XFSq9rZDc1vZH61RAQwvZ3XF
	 vaOSZcCWuM9FA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34075380AA57;
	Fri, 10 Jan 2025 21:30:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: Add unique_match option for multi
 kprobe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173654463802.2209933.16405023988196154444.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jan 2025 21:30:38 +0000
References: <20250109174023.3368432-1-yonghong.song@linux.dev>
In-Reply-To: <20250109174023.3368432-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 linux@jordanrome.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  9 Jan 2025 09:40:23 -0800 you wrote:
> Jordan reported an issue in Meta production environment where func
> try_to_wake_up() is renamed to try_to_wake_up.llvm.<hash>() by clang
> compiler at lto mode. The original 'kprobe/try_to_wake_up' does not
> work any more since try_to_wake_up() does not match the actual func
> name in /proc/kallsyms.
> 
> There are a couple of ways to resolve this issue. For example, in
> attach_kprobe(), we could do lookup in /proc/kallsyms so try_to_wake_up()
> can be replaced by try_to_wake_up.llvm.<hach>(). Or we can force users
> to use bpf_program__attach_kprobe() where they need to lookup
> /proc/kallsyms to find out try_to_wake_up.llvm.<hach>(). But these two
> approaches requires extra work by either libbpf or user.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] libbpf: Add unique_match option for multi kprobe
    https://git.kernel.org/bpf/bpf-next/c/e2b0bda62d54
  - [bpf-next,v2,2/2] selftests/bpf: Add a test for kprobe multi with unique_match
    https://git.kernel.org/bpf/bpf-next/c/a43796b52012

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



