Return-Path: <bpf+bounces-71128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA48BE4E4E
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 19:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BE2F4EBBC8
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 17:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498272206B8;
	Thu, 16 Oct 2025 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucrpIz8S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB36218ADD;
	Thu, 16 Oct 2025 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760636422; cv=none; b=MpTQV7tV9s8Ay8q4woFsHAZNjyf1OKyA8fO8pdzdbG1OKdywQ1dPMJzunSLt7/S99UukZEd6NoB0Auk5yV2y+xLSXrv6L0jQ/3ZcLCaxujfQErR6FNSihswupuELWgUjSm2hJKMC6EcE5DxcCg4ACmQb4uqW5HwcLs0TuCaQGoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760636422; c=relaxed/simple;
	bh=D0pkAW12fRfjruEKsJlsMByMat/kRW0bZvGuEeuU8sw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hqHKE9zbXMkksMOQgSy70sA/QkxqFKUsAMyB2Ax/ZrayubwY04LqrO7F4lVIsC6VlmLr86fl8jvOr1xiqc1+0B08tnbRkXglyT1Br5Bu1gUdYcj2qWi6ArZOXWQgREb9gL98ZhUCsrR8EaTAjJpBwcJ6oZZGibTvr9qT1jBWiO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucrpIz8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8F4C4CEFE;
	Thu, 16 Oct 2025 17:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760636422;
	bh=D0pkAW12fRfjruEKsJlsMByMat/kRW0bZvGuEeuU8sw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ucrpIz8Sn8D9VleUCPluaDE1HS5AAeLFqEmhJSby8Ap/KdUqXy9wZBemj4Asd0f4R
	 Kj4Gc984iIWl003JlzXWz9zrOyPSWx7ysYoEBBUVx+1CZskE3Rvl8irIpPmBC/1Wf2
	 O7uDjSrD2ViLfwISq7exNty22qFiyYem7z3X0aHjAZ3JTPn2Z0YCAS570SN4ltPN9Z
	 CSc/rkCYuVGRLNPXFvnv/uw3s9l0a64SUoU6nz4ojkrj/C1nP2zeUS9r2IiooUqJKB
	 5mq5s8yOpGjlkoWK/p11STmVIuRII8bOcvk4iEzftQGh1KKbyoag858cYlFjfoj9DU
	 xol++YKQA7Rkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0FA383C261;
	Thu, 16 Oct 2025 17:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf] bpf: Fix memory leak in __lookup_instance error
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176063640651.1836402.1494059105577027083.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 17:40:06 +0000
References: <20251016063330.4107547-1-shardulsb08@gmail.com>
In-Reply-To: <20251016063330.4107547-1-shardulsb08@gmail.com>
To: Shardul Bankar <shardulsb08@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 16 Oct 2025 12:03:30 +0530 you wrote:
> When __lookup_instance() allocates a func_instance structure but fails
> to allocate the must_write_set array, it returns an error without freeing
> the previously allocated func_instance. This causes a memory leak of 192
> bytes (sizeof(struct func_instance)) each time this error path is triggered.
> 
> Fix by freeing 'result' on must_write_set allocation failure.
> 
> [...]

Here is the summary with links:
  - [v2,bpf] bpf: Fix memory leak in __lookup_instance error path
    https://git.kernel.org/bpf/bpf/c/8adc4705e46c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



