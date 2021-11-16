Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD1445333D
	for <lists+bpf@lfdr.de>; Tue, 16 Nov 2021 14:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236836AbhKPNxF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Nov 2021 08:53:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236779AbhKPNxF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Nov 2021 08:53:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id BA86961ABD;
        Tue, 16 Nov 2021 13:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637070608;
        bh=aF/BqQUxDi8A7FTpUpNbiWfMGJlwwY07BXEZWMowr/Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lVX96Lzgw2EJuGnVrkImC8cMLA9XtCVOsh/+pbt9hzY5kOcbx+jDr67/ppjfiNBgN
         O1NNghbJ74wIKNqIM7+dglgtwofH0sxMrRvNwr5q0p+bTcFdV7yIKoYa2e48KwFA4m
         J+uuu6zzVQR8A0jIo389ZmQM3gznfWKTkMHyy1cyKVlsevhU+oo6ikufm8bKHoiK11
         LwcMif388FgWjEsMURSwbGG2nNQ66XTcK+EtzoToV4BCbM5pGyF1Xolryuxq1eUZzu
         tNEJHKy9fwxPy+EPaXqwNWkVtZWtTtmYZhiQ9U2nWuT7WYICNNjgZAsrXA4ZeplsFP
         QY93+dZWw3P1Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AC8E060A54;
        Tue, 16 Nov 2021 13:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: add uprobe triggering overhead
 benchmarks
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163707060870.2250.10772692033233073847.git-patchwork-notify@kernel.org>
Date:   Tue, 16 Nov 2021 13:50:08 +0000
References: <20211116013041.4072571-1-andrii@kernel.org>
In-Reply-To: <20211116013041.4072571-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 15 Nov 2021 17:30:41 -0800 you wrote:
> Add benchmark to measure overhead of uprobes and uretprobes. Also have
> a baseline (no uprobe attached) benchmark.
> 
> On my dev machine, baseline benchmark can trigger 130M user_target()
> invocations. When uprobe is attached, this falls to just 700K. With
> uretprobe, we get down to 520K:
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] selftests/bpf: add uprobe triggering overhead benchmarks
    https://git.kernel.org/bpf/bpf-next/c/d41bc48bfab2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


