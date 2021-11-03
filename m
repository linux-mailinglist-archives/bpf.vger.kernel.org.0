Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624C2444420
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 16:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhKCPCs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Nov 2021 11:02:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231441AbhKCPCs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Nov 2021 11:02:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 94080610E8;
        Wed,  3 Nov 2021 15:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635951611;
        bh=AmH1lUcquZ/7tPRdAzSR1hBvSo9cYeGErGG5dSXtHWo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MVvXgh+Fd9ykethFx1oLFEpv/4d7JVKd1WAPZiGkZM2RNwGZWK7mdTDOio6/XVnsT
         6Bo9jew9NyIf2QSZU9S3e6O4hV5j5jdzUeVpu9DG5WqAit0CVKYEUrz1IewpyHMZQX
         H1jerJyaWDOzLgrX1IGguTETXnIRov9McX1SFPxn62mcXvmKZ0eYgWmi1zuIwrTr5r
         V5pyrLkjoTutbE0thyGLwrRNaq11zxuJLgMZ8N46ch9Xph+UsPoyH912tp7aXJgJ4h
         RJxEwrnjtYM4Phvoyno72qq9oexI8L5pGsIxBpM4uPfaQNuZATpDyGGNqrMp9/enD6
         2rNdpYurAb+XA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 84EFB60A2E;
        Wed,  3 Nov 2021 15:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpf: Allow doing stack read with size larger
 than the earlier spilled reg
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163595161153.22644.6536061698592430689.git-patchwork-notify@kernel.org>
Date:   Wed, 03 Nov 2021 15:00:11 +0000
References: <20211102064528.315637-1-kafai@fb.com>
In-Reply-To: <20211102064528.315637-1-kafai@fb.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 1 Nov 2021 23:45:28 -0700 you wrote:
> This set fixes an issue that the verifier rejects a u64 stack read
> after an earlier u32 scalar spill.  It is caused by the earlier commit
> that allows tracking the spilled u32 scalar reg.
> 
> Martin KaFai Lau (2):
>   bpf: Do not reject when the stack read size is different from the
>     tracked scalar size
>   bpf: selftest: verifier test on refill from a smaller spill
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Do not reject when the stack read size is different from the tracked scalar size
    https://git.kernel.org/bpf/bpf/c/f30d4968e9ae
  - [bpf-next,2/2] bpf: selftest: verifier test on refill from a smaller spill
    https://git.kernel.org/bpf/bpf/c/c08455dec5ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


