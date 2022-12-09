Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3376C64811F
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 11:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiLIKuT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 05:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLIKuS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 05:50:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9301326D0;
        Fri,  9 Dec 2022 02:50:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FD636220F;
        Fri,  9 Dec 2022 10:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA3ADC43396;
        Fri,  9 Dec 2022 10:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670583016;
        bh=Mk5kGnqo42SNHR6sGONiYrfz//LqmSMoH+ldcjIbhMI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uTIVI1O7NgF6g9N6u3+CFCh1fHVfo8qyGEvRTvZEbbwiQjGj0pNrwoVx4kaPGIlqB
         73opABP6MZuBFsD9b20kXXpQaqSEdkjOxPfcz2NULJDqDyVUFGSDAr1T4J0nq4FNnz
         lob9X5e8dxdgocQGynx5W6g+zmo+gBDcgwNXbF3p8O4c4LNpcfJUZBr3kG0CqjwVIz
         8x4doSZIXcIzqJAerEY3BbV/NjnCHQ1b4iShk8GRcgVBeK9hatKCmulQNi5H3r40O/
         5GJxUyYscZM4LbyKsgCESJekm7v/Fe6dbqTozxIXi+7UJIEwgJFbQjqAqFpNXHZTKi
         JHkOvFS/aiZ8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94261E1B4D9;
        Fri,  9 Dec 2022 10:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 01/31] rhashtable: Allow rhashtable to be used from
 irq-safe contexts
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167058301660.16848.3282482071239074275.git-patchwork-notify@kernel.org>
Date:   Fri, 09 Dec 2022 10:50:16 +0000
References: <Y4+14IFcWXNcLBE7@slm.duckdns.org>
In-Reply-To: <Y4+14IFcWXNcLBE7@slm.duckdns.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Tue, 6 Dec 2022 11:36:32 -1000 you wrote:
> rhashtable currently only does bh-safe synchronization making it impossible
> to use from irq-safe contexts. Switch it to use irq-safe synchronization to
> remove the restriction.
> 
> v2: Update the lock functions to return the ulong flags value and unlock
>     functions to take the value directly instead of passing around the
>     pointer. Suggested by Linus.
> 
> [...]

Here is the summary with links:
  - [v2,01/31] rhashtable: Allow rhashtable to be used from irq-safe contexts
    https://git.kernel.org/netdev/net-next/c/e47877c7aa82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


