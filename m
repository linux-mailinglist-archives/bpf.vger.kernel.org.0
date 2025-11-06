Return-Path: <bpf+bounces-73758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E38C38B0F
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 02:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852893B4DD7
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 01:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49CC1FCFEF;
	Thu,  6 Nov 2025 01:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aU+6w9wW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F041D516C;
	Thu,  6 Nov 2025 01:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762392052; cv=none; b=UMXiJ5vCuFH6icTA3AaA81O2K+cJMX/ynO9/8PEQEkpaLaFtypr6FQB+8U4of1KR/jzZjg9OkZ2+yuf6g0xmOsfWRNnt+pei7l3S4tBrVc6w+vYnU22IbhrAOxbtOpAUSIC+nQajWLUFXs+aveHnI1vMsEknpfnGRAYWXbHa1pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762392052; c=relaxed/simple;
	bh=fnCJ3fHkf39nF5QDMGMpREHRnkfR2a4jDBxy5ufe7nw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=flfYww3M7pTcEHm7r7V1gNrCHJMz4YW68amwJX97Nl3S65dSc2ZdBuM/HIVG4gprPa4UShXkBLi0SCoN/Xtcmyyw8Rm//pNBWA47bT5SfYAJBBnthx4WmEURXQ+sBtH2ZuARjEufP/m0nqvrALs12VPs1uMhxWasSQ3Ilr2kVAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aU+6w9wW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7D0C4CEF5;
	Thu,  6 Nov 2025 01:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762392051;
	bh=fnCJ3fHkf39nF5QDMGMpREHRnkfR2a4jDBxy5ufe7nw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aU+6w9wWtKBfeaOgn6feoeov7w6UYveEPZVhWb9x3PXuh6RwkTyUU/vud6NYJF68V
	 xOGClbqPB9M+5e8O2fWXf9kxPzimeg2XB9amWEdBYqUEifG1oCTxj485bQRcIxQ7dl
	 KlFkB1qinwRzn9vRziNEQW6BZq4YyHxDr15L+ZhZ3Sxxg+MiMZE8J4bvMwPrB+Hh4t
	 I7KwmPR7pjfsTK9JSPL+knizURIBeGbNyiRWGoAgWPzXOyiC5kKswiZbU+nbznOxLp
	 4QFxBg9PZBGiW5JNtiM8Pc5D43d64XmDEstblqS7KQy2EgXBxFByrYG1B1ANUMbjY9
	 hHgE/EyHkHsAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CEF380AAF5;
	Thu,  6 Nov 2025 01:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 0/4] x86/fgraph,bpf: Fix ORC stack unwind from return
 probe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176239202500.3822711.7940487908688704004.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 01:20:25 +0000
References: <20251104215405.168643-1-jolsa@kernel.org>
In-Reply-To: <20251104215405.168643-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: mhiramat@kernel.org, rostedt@goodmis.org, jpoimboe@kernel.org,
 peterz@infradead.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org, yhs@fb.com,
 songliubraving@fb.com, andrii@kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  4 Nov 2025 22:54:01 +0100 you wrote:
> hi,
> sending fix for ORC stack unwind issue reported in here [1], where
> the ORC unwinder won't go pass the return_to_handler function and
> we get no stacktrace.
> 
> Sending fix for that together with unrelated stacktrace fix (patch 1),
> so the attached test can work properly.
> 
> [...]

Here is the summary with links:
  - [PATCHv3,1/4] Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"
    https://git.kernel.org/bpf/bpf/c/6d08340d1e35
  - [PATCHv3,2/4] x86/fgraph,bpf: Fix stack ORC unwind from kprobe_multi return probe
    https://git.kernel.org/bpf/bpf/c/20a0bc10272f
  - [PATCHv3,3/4] selftests/bpf: Add stacktrace ips test for kprobe_multi/kretprobe_multi
    https://git.kernel.org/bpf/bpf/c/c9e208fa93cd
  - [PATCHv3,4/4] selftests/bpf: Add stacktrace ips test for raw_tp
    https://git.kernel.org/bpf/bpf/c/3490d29964bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



