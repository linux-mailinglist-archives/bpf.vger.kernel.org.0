Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1FEA444422
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 16:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhKCPCs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Nov 2021 11:02:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230500AbhKCPCs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Nov 2021 11:02:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8BCDD60EBC;
        Wed,  3 Nov 2021 15:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635951611;
        bh=33b7lEsjBKX7zlGhVCM5u3dB6n6JAXw6hKuBCqWIzWU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=R7sidw6X+HQiqf4Q7XlGE4Z0T84vT6VMJJMZ43Uu1wvA8qjkcJXsp6BWuVjy3a13i
         HoE+C2Z8OSa4HPGdTkdC//2Fk5cXBbLhFStSnmckarjcyLZhLygz/E3K69kERHBQnl
         04/MT1+6m8Dk+KZK+nBivF6mB5JDU4WB4LuMx/NQsMFVzQJyIDs4pVVoiOhRbp5+C9
         BocNrPXqgtGXiK1vjT6fQJi7fikyB4UloRKXR2HcbC9PnVdbAsqiJeaI8JG0PjMLGe
         jFI8UBIld9JofBa9KhK3qVMfK5nwD7dFxvHLRzoLyF/mNzI1gPbtmtOFi9vTDmJxAO
         vY5RH0cEldinA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7CF4560A39;
        Wed,  3 Nov 2021 15:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: make netcnt selftests serial to avoid
 spurious failures
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163595161150.22644.1739857992912896755.git-patchwork-notify@kernel.org>
Date:   Wed, 03 Nov 2021 15:00:11 +0000
References: <20211103054113.2130582-1-andrii@kernel.org>
In-Reply-To: <20211103054113.2130582-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 2 Nov 2021 22:41:13 -0700 you wrote:
> When running `./test_progs -j` test_netcnt fails with a very high
> probability, undercounting number of packets received (9999 vs expected
> 10000). It seems to be conflicting with other cgroup/skb selftests. So
> make it serial for now to make parallel mode more robust.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: make netcnt selftests serial to avoid spurious failures
    https://git.kernel.org/bpf/bpf/c/401a33da3a45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


