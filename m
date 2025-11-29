Return-Path: <bpf+bounces-75760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30809C945EC
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 18:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B26DB3459D1
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 17:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D05230FC2D;
	Sat, 29 Nov 2025 17:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVFLogRu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886E523FC49
	for <bpf@vger.kernel.org>; Sat, 29 Nov 2025 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764438205; cv=none; b=AIVsstJ01rDHRxq5NiBCLxzVA3IlcBd/LGZPDI85QBBS1YxicE5y72LzG2ELzc1Yhy5UYKbw8/2OkKnn6d/WSjQLxLdIW7+CXmbfBXlYq/inqJHo7bYE3gb/6mvLWTWgzPCp4ym5CKjXibyK8oCtEyV4aQpRkPnaFwyO+ONO/aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764438205; c=relaxed/simple;
	bh=JcnwlmTnsS1yB5aZtQ4ptZKTLUwEnxFTflgGb3Gvf+o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=USK1+v28ZwqbCsEL2ti93K7oVkP8VQ9aPjzBYzRP2NazjiSRpxIyEmz93XinsbaSs+qzM7dviG64bQiDliuEVGg8204LctlJLXJPLgFUI4i1dZPKW6Thhzc1BNA3BSH45xviLFEgVK01SYUBRbeGJQSfVbn6ECwPC3HSgYFPydM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVFLogRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FC0C4CEF7;
	Sat, 29 Nov 2025 17:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764438205;
	bh=JcnwlmTnsS1yB5aZtQ4ptZKTLUwEnxFTflgGb3Gvf+o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GVFLogRu/xa5guCaVLILAQzgZZb/OM4KaB7xNiHTpdlxvUt7PqTWPGor4RfXGJ3Sv
	 /pJVORFxrJfMe95ZWfko9zr9eu7JsoT+wEWD2C+txRu9S3rTvSzy476TcgheorYE0W
	 w/rK0zCOwvtpCyPKEj6fmXut1A0qjxoOlmUXMmILqeRpw7++oRqQnlli1UFm5lvo6j
	 wlQJoOQm+cl4NN80qh/M1jbN3L/X0zxEouBsDQuSKI12Cibp11mZensZP0u6Onmza2
	 si9MYj1WbUc4v7SQVYTwNZrsVVpR7DYtN+1r53vpqPbPrJRk1oBwANeI4rUpLr6HLo
	 AAkvcLn128p9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 789D23806934;
	Sat, 29 Nov 2025 17:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/6] Limited queueing in NMI for rqspinlock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176443802605.1058790.42854168580684799.git-patchwork-notify@kernel.org>
Date: Sat, 29 Nov 2025 17:40:26 +0000
References: <20251128232802.1031906-1-memxor@gmail.com>
In-Reply-To: <20251128232802.1031906-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 ritesh@superluminal.eu, jelle@superluminal.eu, kkd@meta.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 28 Nov 2025 23:27:56 +0000 you wrote:
> Ritesh reported that he was frequently seeing timeouts in cases which
> should have been covered by the AA heuristics. This led to the discovery
> of multiple gaps in the current code that could lead to timeouts when
> AA heuristics could work to prevent them. More details and investigation
> is available in the original threads. [0][1]
> 
> This set restores the ability for NMI waiters to queue in the slow path,
> and reduces the cases where they would attempt to trylock. However, such
> queueing must not happen when interrupting waiters which the NMI itself
> depends upon for forward progress; in those cases the trylock fallback
> remains, but with a single attempt to avoid aimless attempts to acquire
> the lock.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/6] rqspinlock: Enclose lock/unlock within lock entry acquisitions
    https://git.kernel.org/bpf/bpf-next/c/beb7021a6003
  - [bpf-next,v2,2/6] rqspinlock: Perform AA checks immediately
    https://git.kernel.org/bpf/bpf-next/c/5860f5ce479f
  - [bpf-next,v2,3/6] rqspinlock: Use trylock fallback when per-CPU rqnode is busy
    https://git.kernel.org/bpf/bpf-next/c/81d5a6a43859
  - [bpf-next,v2,4/6] rqspinlock: Disable spinning for trylock fallback
    https://git.kernel.org/bpf/bpf-next/c/30dc2f7025fe
  - [bpf-next,v2,5/6] rqspinlock: Precede non-head waiter queueing with AA check
    https://git.kernel.org/bpf/bpf-next/c/087849cca31d
  - [bpf-next,v2,6/6] selftests/bpf: Add success stats to rqspinlock stress test
    https://git.kernel.org/bpf/bpf-next/c/3448375e71a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



