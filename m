Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE7136FFF0
	for <lists+bpf@lfdr.de>; Fri, 30 Apr 2021 19:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhD3Ru7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Apr 2021 13:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229954AbhD3Ru6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Apr 2021 13:50:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1AD5B61469;
        Fri, 30 Apr 2021 17:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619805010;
        bh=AdWLSndMqQFHqoM9FWpxZlFSvWn281z5vS6Un2mfVg8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bU7tIYfTNI8XVUpj2IEmxFRIeeHWVDaaczWEUQ8QoG3YRUuHumKMqNyyjjsyJrUNf
         RldO/5uhhHTckztAb5sAhI7FeciItrh6PMA6gxCRlZJSirhya0vR5v3rFwMcU4cXuD
         DRGuhZUsZFUpNW8ES+05/lOynzQDDQrnlfPG/pIK/T9F1k8bdBu9ONmygwx5ZtxebR
         0lWSXOAim7vHhR5/qwxkH2+M1F1pKa58Uc7SPX+JrkH8/sXK5m86UM/wlf5HuJjSx1
         I8qHt8qKkRX3suTriD8quQWN8qnl7Le5NNxAvhsVkQF1p9UaCbD4r/jEJQ7RMBxwZ8
         XLrckqISionnw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0AE4360A72;
        Fri, 30 Apr 2021 17:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix the snprintf test
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161980501003.20779.4607601411037423780.git-patchwork-notify@kernel.org>
Date:   Fri, 30 Apr 2021 17:50:10 +0000
References: <20210428152501.1024509-1-revest@chromium.org>
In-Reply-To: <20210428152501.1024509-1-revest@chromium.org>
To:     Florent Revest <revest@chromium.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jackmanb@google.com,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Wed, 28 Apr 2021 17:25:01 +0200 you wrote:
> The BPF program for the snprintf selftest runs on all syscall entries.
> On busy multicore systems this can cause concurrency issues.
> 
> For example it was observed that sometimes the userspace part of the
> test reads "    4 0000" instead of "    4 000" (extra '0' at the end)
> which seems to happen just before snprintf on another core sets
> end[-1] = '\0'.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix the snprintf test
    https://git.kernel.org/bpf/bpf/c/f80f88f0e2f2

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


