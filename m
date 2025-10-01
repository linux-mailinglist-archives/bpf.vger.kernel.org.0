Return-Path: <bpf+bounces-70083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A29DCBB0970
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 16:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3D827ACA8D
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 13:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945CF2FDC29;
	Wed,  1 Oct 2025 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAiDYkC6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CDD2FE067;
	Wed,  1 Oct 2025 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327218; cv=none; b=YaNr00X7m5elw0pNLAa74jszR0ekJvOFb/37QlyEUtMFZbteNU9V1LrR6OI199PA90WJ/tIfLvpcgqxm+M4Wz4yzDpt5ONiUtaqPZw2kS7CYQCRs4NsCXApyFetY3e9FrhubIiv9fBBbrRxxlM9g8rYl7CQvxdVw2vGfFFBx/eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327218; c=relaxed/simple;
	bh=9Fk2G3dXNc7b5tIOstpb+yaXYYWCerj2u8XlV/CFSX0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FAso7vX98z/U+WC+ayTwK6BZ1ijrRmORTyvotynjbm5tLOu8PBkCKwguxJjaCGousWezLmmAIkPbA4uJBK0xy/r0utv/vFPz46egrZKodwvfdE6fUYC0353IDa40mOVDeDwyzg+gf9WX+2GYusajydzMCFuiwDQOQwsusCcmSvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAiDYkC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AD7C4CEF1;
	Wed,  1 Oct 2025 14:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759327216;
	bh=9Fk2G3dXNc7b5tIOstpb+yaXYYWCerj2u8XlV/CFSX0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EAiDYkC6A0VHA27pNATOTdfTesR/mSNPVzTK1a3RaLQjLNVsFxip66ePNl5FFLYk3
	 XyhKCga4FqiwLkuY+95iIXDFftmS+Fr7Zx/Voz+Y1H062SOmNeeU/IeQ4hYNB2urV6
	 08HX7hAS6VYbecakTFyne5/q5lQHvs7fJtnOxvM9Gpnh4ilGWc9rfEVsQ824Mfja4F
	 kIJvMUhXnbd3XzMv5le3jhoW+FHas3YG7CSaddcpwf1GI2iKh7CfaiW0CYPFZ+eoHD
	 Qt7kJRQF+dseO7hzU+wKNz5ljWXWVy9CqH6g5cToB66v9xSgSKBS4udEbCrTNfUJRM
	 VblGx5TFmFi1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E1139D0C3F;
	Wed,  1 Oct 2025 14:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/3] selftests/bpf: Fix open-coded gettid syscall in
 uprobe syscall tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175932720902.2480904.3873827864966013132.git-patchwork-notify@kernel.org>
Date: Wed, 01 Oct 2025 14:00:09 +0000
References: <20251001122223.170830-1-jolsa@kernel.org>
In-Reply-To: <20251001122223.170830-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, kafai@fb.com,
 eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
 john.fastabend@gmail.com, haoluo@google.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  1 Oct 2025 14:22:21 +0200 you wrote:
> Commit 0e2fb011a0ba ("selftests/bpf: Clean up open-coded gettid syscall
> invocations") addressed the issue that older libc may not have a gettid()
> function call wrapper for the associated syscall.
> 
> The uprobe syscall tests got in from tip tree, using sys_gettid in there.
> 
> Fixes: 0e2fb011a0ba ("selftests/bpf: Clean up open-coded gettid syscall invocations")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf,1/3] selftests/bpf: Fix open-coded gettid syscall in uprobe syscall tests
    https://git.kernel.org/bpf/bpf/c/716d7388d3e7
  - [bpf,2/3] selftests/bpf: Fix typo in subtest_basic_usdt after merge conflict
    https://git.kernel.org/bpf/bpf/c/a5f5869dc234
  - [bpf,3/3] selftests/bpf: Fix realloc size in bpf_get_addrs
    https://git.kernel.org/bpf/bpf/c/4b946f6bb7d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



