Return-Path: <bpf+bounces-60365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F91DAD5F26
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 21:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F283A7249
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 19:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2028928853E;
	Wed, 11 Jun 2025 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daA3r2in"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6F52E6102
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 19:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670801; cv=none; b=RnidU9yeaYBU1SUB305VbzB302ndY3jzT+6vNIGjWImTpv/2Cbtj5SBboANjJuFPURNUH87XYSqdz1plbriMeOd6SGwirPXkdXnq0x+JzHiEHpPO7Dp2J+SYt43AvQEnGQsEtoaC3ckwUjsvXWAS+8ClSwcnjTQXvfb7lkqDqm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670801; c=relaxed/simple;
	bh=0tjSDd1IE0GHeLjHSKXv9mL9y4nLBEBolSxcQaqvOvc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JZIAErCg2Sq2zYxfyEmvgHFuSaS5oWZ/pnWnsRz404Qb8Q25N9bKlxiBwpmb4ETlawPU7nMldVsKeFb8hkU0UPEU6m31gVcQUb1t1SflBDTAtqIihBc0qfZ96vVHHKfYPHZcEOBk0lRe1UWLxeVHF5ZR4uPBYqSAbY6ZO2I1G4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daA3r2in; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E52EC4CEE3;
	Wed, 11 Jun 2025 19:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749670801;
	bh=0tjSDd1IE0GHeLjHSKXv9mL9y4nLBEBolSxcQaqvOvc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=daA3r2inEMVyRI3mhZcDyEjLBHmzSplgWLdHQfH8ycywmPNWS7ogSK438YxXnOHTc
	 FdWw19zmovLqSzHfghjYynSL2gOemFj+6v/K50bK9A47B6iMcbRzf52egWKBWB20dd
	 +CTor2t5W5qmac3MtQcrw71U3DUhYaP5fuVPFE2TjVl9NGy1C/xenaYDiIGKJsqg6C
	 5xJZHF5U2lQS2HpvqFGlqbMpNU68r3v0wEVN4N2Wo1OwjOaxyJ1wd90Ae2a79zf5XL
	 sNcSLDzCgw0/XP5phn4oAUc60TaABAMM7CsGOGJkF4kOO289cuCQCirfbgiLRl16TP
	 1edGmytUILMag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C00380DBE9;
	Wed, 11 Jun 2025 19:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix cgroup_mprog_ordering failure
 due
 to uninitialized variable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174967083125.3454768.5575765398979169416.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jun 2025 19:40:31 +0000
References: <20250611162103.1623692-1-yonghong.song@linux.dev>
In-Reply-To: <20250611162103.1623692-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 11 Jun 2025 09:21:03 -0700 you wrote:
> On arm64, the cgroup_mprog_ordering selftest failed with test_progs run
> when building with clang compiler. The reason is due to socklen_t optlen
> not initialized.
> 
> In kernel function do_ip_getsockopt(), we have
> 
>         if (copy_from_sockptr(&len, optlen, sizeof(int)))
>                 return -EFAULT;
>         if (len < 0)
>                 return -EINVAL;
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix cgroup_mprog_ordering failure due to uninitialized variable
    https://git.kernel.org/bpf/bpf-next/c/517b088a846b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



