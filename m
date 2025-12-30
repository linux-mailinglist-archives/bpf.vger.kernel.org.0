Return-Path: <bpf+bounces-77541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF19CEAA20
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 21:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A97183019B72
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 20:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C782DC346;
	Tue, 30 Dec 2025 20:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNSK8hAU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE975A930
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 20:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767127404; cv=none; b=FZR3vAjmQLL9kTWyTdFVKKQXOoWr6PGvtVynogoqGPtkmyHGdZQL7E/g76flWnBDHsQJROb54Dj77zBWs4emktA2OCBY+ATttpr3vT7Cnhms7SVcckGS4eHNufRCFrxoPrUFPJi034pmEPHdmrsUs5xfloa76FNgYLEWeQQArMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767127404; c=relaxed/simple;
	bh=9+Jkz5ALi0/bd+UVmWGEPAyGcOoXMx5AKc70+aoOz8A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WYlwrC8rbz39d3p3KxfRzWRu8B/MakeA3QfxCUiul8oqsx58yYcjnjEjoZFIanUJvvV5MTXIxGpeRyvJUJpJyABkvMV94YIwz5t/fPp7udZh7l1FidQpdq85J4HF6LyYiAXrkfe7TrsdTwbdhoy7r6Gwq1ps2Wn+NXu/9zFZXuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNSK8hAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6091EC4CEFB;
	Tue, 30 Dec 2025 20:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767127404;
	bh=9+Jkz5ALi0/bd+UVmWGEPAyGcOoXMx5AKc70+aoOz8A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dNSK8hAUeH1/GNRbEUDSN2rPPkmmAm1yaMYE+GLSakSeZaRQ7z8J866/3ARIAxiZZ
	 78AOS+rWm5FNHxFdkGjiLC8dsnvaLopdK4RJVjjqRtytUycLCvHFMYFnCY4qFXM1eL
	 Hu4vxJeGH+iLmGKsj1DtOSkDZPSgEGRO4zr1kIJIpz6SY4sz2bQQvOksQWnVqnppMq
	 YOcwsUB4ptIEbRH8eP1Y5ARYVwB6+epxvbuuJRJpW3tw+51xZ7fmX/zuKt5ebRCYZp
	 3FPMHocq9a2wl3pZ6zwa7xk0GcDgzXJU3KDpQs0vl/zxddlzQhDnS9fQJcbWNKYZdy
	 dnzM4vO8WTVxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7897A3809A0D;
	Tue, 30 Dec 2025 20:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests: bpf: fix verifier_arena_large:
 big_alloc3
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176712720629.3349090.16150287089890337072.git-patchwork-notify@kernel.org>
Date: Tue, 30 Dec 2025 20:40:06 +0000
References: <20251230195134.599463-1-puranjay@kernel.org>
In-Reply-To: <20251230195134.599463-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, puranjay12@gmail.com, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 30 Dec 2025 11:51:32 -0800 you wrote:
> The big_alloc3() test tries to allocate 2051 pages at once in
> non-sleepable context and this can fail sporadically on resource
> contrained systems, so skip this test in case of such failures.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  tools/testing/selftests/bpf/progs/verifier_arena_large.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests: bpf: fix verifier_arena_large: big_alloc3
    https://git.kernel.org/bpf/bpf-next/c/317a5df78f24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



