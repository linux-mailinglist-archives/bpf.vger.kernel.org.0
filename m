Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D785C282087
	for <lists+bpf@lfdr.de>; Sat,  3 Oct 2020 04:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgJCCaE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Oct 2020 22:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgJCCaD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Oct 2020 22:30:03 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601692203;
        bh=/GdVGcCMMFuMnUAyvKz2m/dBmsQWXPWaq1KqnZFaiLI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Uhw9P3SqmnhHNNIeD4siivfccdTH8W2G0DGDjHs03q/ZZQ6zgDji1K5B8C+Vd5g9g
         R6nRGo470KwtwiPvEQuX+RdnG+bLU6wsS/JG1MTL+szT571NJA8XHJSblGQWGpWLVs
         R4HqWRf1lEHDz2uGX7snaMAFY6haRdM+QW/1Aftk=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: deref map in BPF_PROG_BIND_MAP when it's
 already used
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160169220350.9428.1442474322300183574.git-patchwork-notify@kernel.org>
Date:   Sat, 03 Oct 2020 02:30:03 +0000
References: <20201003002544.3601440-1-sdf@google.com>
In-Reply-To: <20201003002544.3601440-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Fri,  2 Oct 2020 17:25:44 -0700 you wrote:
> We are missing a deref for the case when we are doing BPF_PROG_BIND_MAP
> on a map that's being already held by the program.
> There is 'if (ret) bpf_map_put(map)' below which doesn't trigger
> because we don't consider this an error.
> Let's add missing bpf_map_put() for this specific condition.
> 
> Fixes: ef15314aa5de ("bpf: Add BPF_PROG_BIND_MAP syscall")
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: deref map in BPF_PROG_BIND_MAP when it's already used
    https://git.kernel.org/bpf/bpf-next/c/1028ae406999

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


