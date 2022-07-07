Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B938456A5A9
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 16:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbiGGOkS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 10:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbiGGOkR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 10:40:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734AC3137F;
        Thu,  7 Jul 2022 07:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25F94B8223D;
        Thu,  7 Jul 2022 14:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBFB4C341C8;
        Thu,  7 Jul 2022 14:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657204813;
        bh=34u7DPSKmpE5fX07+/IcUMCSp/wl3YlsOsPTKAV+eWY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=psAHJ2oofxLByDMXZljGLCV7ngRX1rsHcz0fr3J2D8w5iH+i55aWTENQUvgEp1K49
         faFDP5/Tg+ZnGlxT7T2WaTelM9qH1peEKRsEOYvB3Nq3OnyiJ2mnog/43rYpu55D5g
         m8O4CDmD9a6ZoVHgbz1zmxQ84usNm3i1vb8cvrdBtdhLgsbhMDZOJAbKhjxLZ7jLTH
         ZddWnXPk1nPScLeK39EXc5nM50taRQiDca3vTUj/s1aWDQBMoAsv/jLlc1pabvMUJC
         4p2Pkk0TzhNJIwqfhf1ZPKJXFB+2RgNvzdTDsRzlofCinqISNVDqTeU3XUPJTjhloR
         zeHAFDh6cs/dg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95B66E45BDA;
        Thu,  7 Jul 2022 14:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next] selftests/bpf: Add benchmark for local_storage
 RCU Tasks Trace usage
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165720481360.13867.14770965317150614583.git-patchwork-notify@kernel.org>
Date:   Thu, 07 Jul 2022 14:40:13 +0000
References: <20220705190018.3239050-1-davemarchevsky@fb.com>
In-Reply-To: <20220705190018.3239050-1-davemarchevsky@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, rcu@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, paulmck@kernel.org,
        kafai@fb.com, edumazet@google.com, kernel-team@fb.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 5 Jul 2022 12:00:18 -0700 you wrote:
> This benchmark measures grace period latency and kthread cpu usage of
> RCU Tasks Trace when many processes are creating/deleting BPF
> local_storage. Intent here is to quantify improvement on these metrics
> after Paul's recent RCU Tasks patches [0].
> 
> Specifically, fork 15k tasks which call a bpf prog that creates/destroys
> task local_storage and sleep in a loop, resulting in many
> call_rcu_tasks_trace calls.
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next] selftests/bpf: Add benchmark for local_storage RCU Tasks Trace usage
    https://git.kernel.org/bpf/bpf-next/c/2b4b2621fd64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


