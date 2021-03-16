Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF5F33CD0C
	for <lists+bpf@lfdr.de>; Tue, 16 Mar 2021 06:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbhCPFUi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Mar 2021 01:20:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231996AbhCPFUI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Mar 2021 01:20:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2613265142;
        Tue, 16 Mar 2021 05:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615872008;
        bh=JQGbv2BBOZ4RVyZtOK9goL4KQNcS66qOfA0n64oowK4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lc+gCnW/pmeXAW1yFqQxxkttydWMhQl31yRNlxT23cb+wJRJbgxFVQN5wUCGalEI1
         S7gJassm09Hi9qAbIi62PpMEBw+GZJ/y1mKHJjUk9ovihhSXdrbtABp60EtdZ/zqj5
         1e8KgyAyLuHzbA1Hbu9rGZh6L/Oy2pbJqKEOqbxYj55WuJXk5zfToL49+yNhKRrPDe
         Czh3eTiM+A0TBw/h+ZTDeTer3R6AcHr6wgrgP8ikysyuVVbiWYLVvBGvA0P+sm8ZDL
         krtm0Zbjb+E7IF/HnTjcWmfDAfipDbp/YV0r+cNjBxrEx50iMpYQjLwa2ZVf7YtwGV
         ZD0918Mnf/JAw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 149B460A45;
        Tue, 16 Mar 2021 05:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] samples: bpf: Fix a spelling typo in do_hbm_test.sh
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161587200807.23555.1560644203529610959.git-patchwork-notify@kernel.org>
Date:   Tue, 16 Mar 2021 05:20:08 +0000
References: <20210315124454.1744594-1-standby24x7@gmail.com>
In-Reply-To: <20210315124454.1744594-1-standby24x7@gmail.com>
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     linux-kernel@vger.kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Mon, 15 Mar 2021 21:44:54 +0900 you wrote:
> This patch fixes a spelling typo in do_hbm_test.sh
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
>  samples/bpf/do_hbm_test.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - samples: bpf: Fix a spelling typo in do_hbm_test.sh
    https://git.kernel.org/bpf/bpf-next/c/d94436a5d1a0

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


