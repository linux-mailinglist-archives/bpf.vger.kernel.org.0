Return-Path: <bpf+bounces-37559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42980957813
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 00:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC31D1F21DBE
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 22:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4331DF668;
	Mon, 19 Aug 2024 22:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKGR5r9o"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C56C159565;
	Mon, 19 Aug 2024 22:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724107833; cv=none; b=WiyuhkLZDzGlx87e1UzgKtAmCAsWGJeYJthQ2/0P/JUw04O33Lr+lZr9sTbiWdcpb/D9NJHwSQgXhWBxvTacHHqL+chBMBFmKXH4MYiwc0amEaEmA5LpesFIUb2TEwdpFDfSr5h/FTdds4aYxj2VzQdSsrsSmyubeMolIgSEOYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724107833; c=relaxed/simple;
	bh=9q6ObvN1GVz8kWo7AMGxLBtDDqun6t1WntSnsOHdJzM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uEZQy77Jr/0i9v7lCRe1b3pRnRtTT+W3+Z8oR0IZaqNXHbG8+qQr6HMPsugGkFFeuVb+1awQCTw2Bmm0wq45zlxOnxvIFngxYezahoFxDQ2+nQPuB9aYouN/XEhzLFMh7p5oZlvZUgwdzg8mo9KkseZ5DsOHx5ajKd90kyHDMTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKGR5r9o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6764C32782;
	Mon, 19 Aug 2024 22:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724107832;
	bh=9q6ObvN1GVz8kWo7AMGxLBtDDqun6t1WntSnsOHdJzM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LKGR5r9oy+GuUjBMBotYr/o25yO4ecTNEtKrEXY7Mh/XhC1BAYp/wmlXIykGpIEBn
	 KaNPwqjVaJPt3qnKJaCV2ORJkqHRbC/LGO/c5b6wRWbi05rznd3S22ymQikbk5ALTe
	 fOoHaQAMerPlxNdY2YJz1lCa5dfr2vynkAd//r0uTBvj/8+cSlayx0im58faPIRjeF
	 jZuE+qBoUF30cWWeno/rKps+J2Ostp490RVijvPmWe/GjQ+Ls6WvNib6m8AN40ZHmd
	 P+yKNdhbNOCKvfpbgOOIClfjDkn4xYTWL3hMSulbKNa5Iie+DaP8tWKUbRCPoX2Q+V
	 qbmTZr/if+GeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7129B3823271;
	Mon, 19 Aug 2024 22:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/2] bpf: enable some functions in cgroup programs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172410783198.676416.16139699146556980950.git-patchwork-notify@kernel.org>
Date: Mon, 19 Aug 2024 22:50:31 +0000
References: <20240819162805.78235-1-technoboy85@gmail.com>
In-Reply-To: <20240819162805.78235-1-technoboy85@gmail.com>
To: Matteo Croce <technoboy85@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 teknoraver@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 19 Aug 2024 18:28:03 +0200 you wrote:
> From: Matteo Croce <teknoraver@meta.com>
> 
> Enable some BPF kfuncs and the helper bpf_current_task_under_cgroup()
> for program types BPF_CGROUP_*.
> These will be used by systemd-networkd:
> https://github.com/systemd/systemd/pull/32212
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/2] bpf: enable generic kfuncs for BPF_CGROUP_* programs
    https://git.kernel.org/bpf/bpf-next/c/67666479edf1
  - [bpf-next,v6,2/2] bpf: allow bpf_current_task_under_cgroup() with BPF_CGROUP_*
    https://git.kernel.org/bpf/bpf-next/c/7f6287417baf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



