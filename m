Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB63031984A
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 03:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhBLCUu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Feb 2021 21:20:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:47318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229662AbhBLCUt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Feb 2021 21:20:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A27DF64E38;
        Fri, 12 Feb 2021 02:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613096407;
        bh=xlMgynX/tXBzPare7r7xKaYZUVtzqnPeQetgZf3z0A4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lwg9ENqFRm/R8B3HWqVefPfT1sR7a5j+S6/7wW1iWh33IxbeJfBxfr4Lk365sbu8H
         /zZupTRXdsfm+gOeICEMgCUDo5l6F7cQWNMYg1zjNxq9YgZ2s4ib+8HHCl+7gIp2a+
         xFw6CXSHPqAe/zPwEoZwc4T5K+bXE+FMAThVMBEMEwsyOPssESCwayncJNaS/iCvKE
         DkasZIVbjiu59q/u0BXDNOoickTTvKTOX/y2IdkE08LEcWE1w/i2ACdq/tTK91Sfiy
         BmsTiSJ3fZ7gwMcuR71rNCYY3TzOM02QmARGfcqlx+5ZVVhYWc2gLNhzRXgcmvneXu
         0uE2ns/6P/lOw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 91B2360A2B;
        Fri, 12 Feb 2021 02:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 1/5] bpf: Be less specific about socket cookies
 guarantees
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161309640759.12988.9852007346010349044.git-patchwork-notify@kernel.org>
Date:   Fri, 12 Feb 2021 02:20:07 +0000
References: <20210210111406.785541-1-revest@chromium.org>
In-Reply-To: <20210210111406.785541-1-revest@chromium.org>
To:     Florent Revest <revest@chromium.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@chromium.org, revest@google.com,
        jackmanb@chromium.org, linux-kernel@vger.kernel.org,
        kpsingh@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Wed, 10 Feb 2021 12:14:02 +0100 you wrote:
> Since "92acdc58ab11 bpf, net: Rework cookie generator as per-cpu one"
> socket cookies are not guaranteed to be non-decreasing. The
> bpf_get_socket_cookie helper descriptions are currently specifying that
> cookies are non-decreasing but we don't want users to rely on that.
> 
> Reported-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Florent Revest <revest@chromium.org>
> Acked-by: KP Singh <kpsingh@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,1/5] bpf: Be less specific about socket cookies guarantees
    https://git.kernel.org/bpf/bpf-next/c/07881ccbf40c
  - [bpf-next,v7,2/5] bpf: Expose bpf_get_socket_cookie to tracing programs
    https://git.kernel.org/bpf/bpf-next/c/c5dbb89fc2ac
  - [bpf-next,v7,3/5] selftests/bpf: Integrate the socket_cookie test to test_progs
    https://git.kernel.org/bpf/bpf-next/c/61f8c9c8f3c8
  - [bpf-next,v7,4/5] selftests/bpf: Use vmlinux.h in socket_cookie_prog.c
    https://git.kernel.org/bpf/bpf-next/c/6cd4dcc3fb81
  - [bpf-next,v7,5/5] selftests/bpf: Add a selftest for the tracing bpf_get_socket_cookie
    https://git.kernel.org/bpf/bpf-next/c/6fdd671baaf5

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


