Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F4B6F4D95
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 01:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjEBXaW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 May 2023 19:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjEBXaV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 May 2023 19:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B401B3591
        for <bpf@vger.kernel.org>; Tue,  2 May 2023 16:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E289629A3
        for <bpf@vger.kernel.org>; Tue,  2 May 2023 23:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F681C433EF;
        Tue,  2 May 2023 23:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683070219;
        bh=mmJoWbB09dPN+c7cmFeZDNJvr0LdadzY/G8hyP1afU4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WBYK66+ZI4N93vAsvXOuwmrnfXOUNHJCeNSgBPwOkvcvGzG4eRWBQpP+5o1bF7JIT
         rVKrOOkEWg/7GaTcKsrbRD3sBXb39rba31Dz5JrZv1zIbRQdG/Oc1UjyC8XU8cTA0t
         XB1Bod5zyvGTJ6oBaMTmZw68iDfPsysP5ktG3BFItg9C4m1Q3+lZSnEI3R2Er+Mfqh
         rFZv++/YS25Vc5e5AKMW+iIAN55mg/rslln7gnfphUj4QXXrwdHA2aU6PVFdYnvqTj
         aaNYNAcz3zCYl0V2UhpTQFtdq4jz28prT91/BYSSEuP6LJtkVbdTow+4NcuqmFhJGm
         EWxrFm/TvQ4WA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F4A1C41677;
        Tue,  2 May 2023 23:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Print a warning only if writing to
 unprivileged_bpf_disabled.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168307021951.25211.7537082231018003804.git-patchwork-notify@kernel.org>
Date:   Tue, 02 May 2023 23:30:19 +0000
References: <20230502181418.308479-1-kuifeng@meta.com>
In-Reply-To: <20230502181418.308479-1-kuifeng@meta.com>
To:     Kui-Feng Lee <thinker.li@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        kuifeng@meta.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  2 May 2023 11:14:18 -0700 you wrote:
> Only print the warning message if you are writing to
> "/proc/sys/kernel/unprivileged_bpf_disabled".
> 
> The kernel may print an annoying warning when you read
> "/proc/sys/kernel/unprivileged_bpf_disabled" saying
> 
>   WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible
>   via Spectre v2 BHB attacks!
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Print a warning only if writing to unprivileged_bpf_disabled.
    https://git.kernel.org/bpf/bpf-next/c/fedf99200ab0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


