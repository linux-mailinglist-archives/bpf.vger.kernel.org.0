Return-Path: <bpf+bounces-19507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 568DA82CE48
	for <lists+bpf@lfdr.de>; Sat, 13 Jan 2024 20:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D423E1F22252
	for <lists+bpf@lfdr.de>; Sat, 13 Jan 2024 19:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F6C63CC;
	Sat, 13 Jan 2024 19:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0wAltPC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A3763A7;
	Sat, 13 Jan 2024 19:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E35DDC433F1;
	Sat, 13 Jan 2024 19:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705173626;
	bh=WbWG2IiZZYGplfQqyzGwNMVETfJ4+WScuj2euCEwZL0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R0wAltPCLv3ywoSnmFJ7VL/I67zA2t2dc05mFqRKn37/9x9xL49E/ll5ldo1hQJc/
	 ors5aNYRSYp+toXSzT37jFzZ1vBV22RYCF4w8xZyed2cZEOzK52QeTVrt0ZVpl3Phy
	 RjXP6YzVUqsacxO+x0OzQo6G2qUCNk+t9711sGkA53ZwAIVU5H5UD5Ety99V7haCDG
	 CROcKn06T+Tkfp2rrCIAyGW/DBKyGz+CS8Nnz8wdnuaQL7aI5CmTDzNiMnIZOXsbtF
	 KwifzFaszdF/2K6akPJS0zRF14DKAvap5grPcfHGCpnir3YIvXhBgDRpRE4P1hzul0
	 ufqTSOmxHs6lw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7B83DFC697;
	Sat, 13 Jan 2024 19:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf 0/3] bpf: Fix backward progress bug in bpf_iter_udp
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170517362581.27258.5049998565327508436.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jan 2024 19:20:25 +0000
References: <20240112190530.3751661-1-martin.lau@linux.dev>
In-Reply-To: <20240112190530.3751661-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, netdev@vger.kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 12 Jan 2024 11:05:27 -0800 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> This patch set fixes an issue in bpf_iter_udp that makes backward
> progress and prevents the user space process from finishing. There is
> a test at the end to reproduce the bug.
> 
> Please see individual patches for details.
> 
> [...]

Here is the summary with links:
  - [v3,bpf,1/3] bpf: iter_udp: Retry with a larger batch size without going back to the previous bucket
    https://git.kernel.org/bpf/bpf/c/19ca0823f6ea
  - [v3,bpf,2/3] bpf: Avoid iter->offset making backward progress in bpf_iter_udp
    https://git.kernel.org/bpf/bpf/c/2242fd537fab
  - [v3,bpf,3/3] selftests/bpf: Test udp and tcp iter batching
    https://git.kernel.org/bpf/bpf/c/dbd7db7787ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



