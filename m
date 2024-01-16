Return-Path: <bpf+bounces-19613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6D282F1D5
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 16:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1091F23CB8
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 15:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD71E1C695;
	Tue, 16 Jan 2024 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O24WnAlG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A2E1C2B3;
	Tue, 16 Jan 2024 15:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3007DC433F1;
	Tue, 16 Jan 2024 15:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705420230;
	bh=ga1BG+TMkJmfQLcIeSqBXVBSKeScehq6FZ56bqEch5g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O24WnAlG/yeYkgPVlYk81haJ3Y0TvJwGLpZqXVWkS+8/orlE+b7asI8JLxN+1fWnX
	 HsWgQM72Gk3sdAqJqgi2EKl1zdX18rjKBueoaGfC3Mq1Da72+Q1DkFfM4XuPk+gsF/
	 5ieJE47iYmmBbEu5uSpLvanKOTtCFTYdCUinYSlxa4a1fCkTw2nt4IshBSoWEs6xnh
	 slk2OKY5UEpoRXAhblVllP0Ynl1EYSiXevjsVC0zKPykdzgeTr2eQKqzsuoJmwMNbe
	 ALM8IjcQwQcUKxH72mhifeROtDJYAeddX7aP8EPMrJSGF1jjEKK7yKh80XXWy1IsHS
	 /9+HzLeCOkHJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A83AD8C96D;
	Tue, 16 Jan 2024 15:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: fix potential premature unload in
 bpf_testmod
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170542023010.19641.12554162884652194073.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jan 2024 15:50:30 +0000
References: <20240110085737.8895-1-asavkov@redhat.com>
In-Reply-To: <20240110085737.8895-1-asavkov@redhat.com>
To: Artem Savkov <asavkov@redhat.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 10 Jan 2024 09:57:37 +0100 you wrote:
> It is possible for bpf_kfunc_call_test_release() to be called from
> bpf_map_free_deferred() when bpf_testmod is already unloaded and
> perf_test_stuct.cnt which it tries to decrease is no longer in memory.
> This patch tries to fix the issue by waiting for all references to be
> dropped in bpf_testmod_exit().
> 
> The issue can be triggered by running 'test_progs -t map_kptr' in 6.5,
> but is obscured in 6.6 by d119357d07435 ("rcu-tasks: Treat only
> synchronous grace periods urgently").
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: fix potential premature unload in bpf_testmod
    https://git.kernel.org/bpf/bpf-next/c/6ad61815babf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



