Return-Path: <bpf+bounces-11722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4258D7BE325
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 16:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72CB81C20B6E
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 14:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8171A261;
	Mon,  9 Oct 2023 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pM7oO7mw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31143589E
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 14:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5923EC433CA;
	Mon,  9 Oct 2023 14:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696862423;
	bh=Qi8x1VMzL9xY8Ggs+lCxTdXpkKrxNatc88uic+xNA0c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pM7oO7mwOvaqH+hHooZ9UcwrUtxALjCYc/GKb6Cn+njhtUCBJeFyU3y8KOaskiYjB
	 DQ6PTB3xDjNvDjureoSXN8aLI2pLqoqx1oL72m0/N0uOECa0BpHKRCoVT1ppYrNazN
	 OwulwYbeJTDDVkBd6zMlaM1HME6ESZObVRbFoBJEL8AsBr8vMYVJtyHESD04Prh1Aj
	 +SzQFvCgGqpGymE36VHIKwbKbFfADGMg6VCaiQquPUHLT10EOkNVRtdmRq9d2mwB4o
	 Hb5uaCm4pZW02MjUM3bxh0bGGO99cDIKSYJMd/7sBESb4Nm0tm63KAKClrymDsmvCF
	 5OLJQ/96lirQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41FDEE11F46;
	Mon,  9 Oct 2023 14:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Add ability to pin bpf timer to calling
 CPU
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169686242326.26391.4445179958402601494.git-patchwork-notify@kernel.org>
Date: Mon, 09 Oct 2023 14:40:23 +0000
References: <20231004162339.200702-1-void@manifault.com>
In-Reply-To: <20231004162339.200702-1-void@manifault.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed,  4 Oct 2023 11:23:37 -0500 you wrote:
> BPF supports creating high resolution timers using bpf_timer_* helper
> functions. Currently, only the BPF_F_TIMER_ABS flag is supported, which
> specifies that the timeout should be interpreted as absolute time. It
> would also be useful to be able to pin that timer to a core. For
> example, if you wanted to make a subset of cores run without timer
> interrupts, and only have the timer be invoked on a single core.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Add ability to pin bpf timer to calling CPU
    https://git.kernel.org/bpf/bpf-next/c/d6247ecb6c1e
  - [bpf-next,v2,2/2] bpf/selftests: Test pinning bpf timer to a core
    https://git.kernel.org/bpf/bpf-next/c/0d7ae0686075

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



