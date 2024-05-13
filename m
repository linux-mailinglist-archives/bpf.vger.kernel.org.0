Return-Path: <bpf+bounces-29610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADB58C397C
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 02:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AEA21F2135C
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 00:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEFA5915C;
	Mon, 13 May 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6zZX02F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1542AD11;
	Mon, 13 May 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715558430; cv=none; b=FMYTLMkHTbAOyyl+5ztbW2DL0Jnj+HqP0+988EdQoskkwjjldjY/+2LatDGS6sRf7MG8amdzvfNWvVO+Seju2fKjE2DHP0Vzu/dJEyIpAaoc/u81GbrhtNo1idQDi/QMdWXDJScSVmma4qPSpMOYQq3c2rFTxrnQc/+wEpdpNNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715558430; c=relaxed/simple;
	bh=eO6sFEl5M7WFZuUj5gBLKwD35udWKP6eAoJ2iuvpeOg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TCk3teBTKjQJNO8mnxhehrP18ZSk68rwnxueuCnJebddqUqj+oYPzWht4Qix6/V0OZC23wDets5F7cp0YtFRASw0IfRJMtTYG7eeYv+wM2XlKdicWHXW03Bzw7dGAkTXpSJ6KmOwjsuVvzGW9AlInOTXcZ5D0rBAkGUGUbPxuXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6zZX02F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C25A7C32782;
	Mon, 13 May 2024 00:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715558429;
	bh=eO6sFEl5M7WFZuUj5gBLKwD35udWKP6eAoJ2iuvpeOg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F6zZX02FcPQotnOy85Fv/Y+zJ69/PF0J/2LyjADRYsLH7KtiYm9YF32v0uuQCYJWK
	 xykadcmOrjnUMs0Nsdgf3hLws4jmQzG74s7D4ilvW4UcLF1WYtOaSx08JI+/DEJhcv
	 S7qgk5YhSOqieH3OHu/WCOypGZ5JWQL79lNuZkuBGOZ3uKJWB83Md+B2BZtotGSQd/
	 pRW2SdQCwR3klmjohMtKYIt/79L7Z2ruSarP/l8iUdXqv53t/4Oj0WT0vKdGnc5X5E
	 yYuUjda8a7XRxYBdrhNZZrilh5HO78Kq22OLtjme/tXPrIwJ5RsfDLgv1QWZnP4SmT
	 qHM597QbUh7Og==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B03C3C43336;
	Mon, 13 May 2024 00:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/4] bpf: Inline helpers in arm64 and riscv JITs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171555842971.18024.5994245773855857236.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 00:00:29 +0000
References: <20240502151854.9810-1-puranjay@kernel.org>
In-Reply-To: <20240502151854.9810-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: catalin.marinas@arm.com, will@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, zlim.lnx@gmail.com, xukuohai@huawei.com,
 revest@chromium.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, memxor@gmail.com,
 bjorn@kernel.org, puranjay12@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  2 May 2024 15:18:50 +0000 you wrote:
> Changes in v5 -> v6:
> arm64 v5: https://lore.kernel.org/all/20240430234739.79185-1-puranjay@kernel.org/
> riscv v2: https://lore.kernel.org/all/20240430175834.33152-1-puranjay@kernel.org/
> - Combine riscv and arm64 changes in single series
> - Some coding style fixes
> 
> Changes in v4 -> v5:
> v4: https://lore.kernel.org/all/20240429131647.50165-1-puranjay@kernel.org/
> - Implement the inlining of the bpf_get_smp_processor_id() in the JIT.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/4] riscv, bpf: add internal-only MOV instruction to resolve per-CPU addrs
    https://git.kernel.org/bpf/bpf-next/c/19c56d4e5be1
  - [bpf-next,v6,2/4] riscv, bpf: inline bpf_get_smp_processor_id()
    https://git.kernel.org/bpf/bpf-next/c/2ddec2c80b44
  - [bpf-next,v6,3/4] arm64, bpf: add internal-only MOV instruction to resolve per-CPU addrs
    https://git.kernel.org/bpf/bpf-next/c/7a4c32222b0e
  - [bpf-next,v6,4/4] bpf, arm64: inline bpf_get_smp_processor_id() helper
    https://git.kernel.org/bpf/bpf-next/c/75fe4c0b3e18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



