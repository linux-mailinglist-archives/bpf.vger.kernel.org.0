Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90A9474513
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 15:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbhLNOaN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Dec 2021 09:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbhLNOaM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Dec 2021 09:30:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A2DC061401
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 06:30:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC455B819DC
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 14:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F007C34608;
        Tue, 14 Dec 2021 14:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639492209;
        bh=Wvye4D15r4YjNeYcjS6imPspuK/33M5hwCNFQUnHW8I=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QJscw5mPdAGFNtVJ74MMFkf7VLJfkJSqdKKEzoCIPnoI2bUxJqrXGCwfnBFcm7IkZ
         BFNQ6HlTM++IuQp/DXAXNWzv1f5n0qiixpDNbr9Kqtji2+yv2TGo4kJCqp+K3yHBM0
         FyAwr8XwTLdhLHvuDrCn1H6Hl6mLq3WCF/lcGjMuj2MK6oBCIglD4NWt+L3/O+Eq87
         jodIZfKeTObxWZrijc2dqsJKfcfJr6Q+Mi75+M9mYKIPghZZDwkC6fHYzU6UnF6Evc
         o6OfJbaIXHZ89mnmnCQ3tVG3lbF802yJCZwFFeMbIJ8B4J2Unyrty9fm/EUZe8NV7I
         INkCwvcA3fUwQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4705B609F5;
        Tue, 14 Dec 2021 14:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix OOB write in test_verifier
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163949220928.29681.1035152099323425730.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Dec 2021 14:30:09 +0000
References: <20211214014800.78762-1-memxor@gmail.com>
In-Reply-To: <20211214014800.78762-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 14 Dec 2021 07:18:00 +0530 you wrote:
> The commit referenced below added fixup_map_timer support (to create a
> BPF map containing timers), but failed to increase the size of the
> map_fds array, leading to out of bounds write. Fix this by changing
> MAX_NR_MAPS to 22.
> 
> Fixes: e60e6962c503 ("selftests/bpf: Add tests for restricted helpers")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix OOB write in test_verifier
    https://git.kernel.org/bpf/bpf/c/f7abc4c8df8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


