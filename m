Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D866E1B10
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 06:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjDNEaV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 00:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDNEaU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 00:30:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D166144B2
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 21:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6197D643AA
        for <bpf@vger.kernel.org>; Fri, 14 Apr 2023 04:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C777C4339B;
        Fri, 14 Apr 2023 04:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681446618;
        bh=j7ALaFeXRvNJJ7+QEOOJUlQnaZFfs0UcvpbZQAiphVk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Sc8GwwGDJRAmsJ+SRjLLxc0HN9/sIY8peQBSkaRB9yKSOf9yVoUkDWmiIuzNffw1c
         QUZCED+JTjt1+SmaOzvHVgZXxn3G9C0bPfqUgdTjU0eL83V8nU8OD38i0ba83Cg52T
         Ey9XU8IXAqFxNes12WQ8rVSc4Fqw36WLOAnCKY+1hOG9laeaopJFdYy19whQcfVF/t
         /2NQp4GGoYRXzHK+3jVSpW0Xgm81aFstx5/JwhxcgBFQXbGoOgqkaIOMMMQ1qQGOBh
         Yt0R7nkYu9X8fI1kVdDvqcz3WndSMQO0GnhWHMcvt4diJAPg/ft4rWk4A37puZIPad
         /3UJ9WUDgp4lg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4FB08E52441;
        Fri, 14 Apr 2023 04:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Add preempt_count_{sub,add} into btf id deny
 list
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168144661832.2372.13040287030746803607.git-patchwork-notify@kernel.org>
Date:   Fri, 14 Apr 2023 04:30:18 +0000
References: <20230413025248.79764-1-laoar.shao@gmail.com>
In-Reply-To: <20230413025248.79764-1-laoar.shao@gmail.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bpf@vger.kernel.org, olsajiri@gmail.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 13 Apr 2023 02:52:48 +0000 you wrote:
> From: Yafang <laoar.shao@gmail.com>
> 
> The recursion check in __bpf_prog_enter* and __bpf_prog_exit*
> leave preempt_count_{sub,add} unprotected. When attaching trampoline to
> them we get panic as follows,
> 
> [  867.843050] BUG: TASK stack guard page was hit at 0000000009d325cf (stack is 0000000046a46a15..00000000537e7b28)
> [  867.843064] stack guard page: 0000 [#1] PREEMPT SMP NOPTI
> [  867.843067] CPU: 8 PID: 11009 Comm: trace Kdump: loaded Not tainted 6.2.0+ #4
> [  867.843100] Call Trace:
> [  867.843101]  <TASK>
> [  867.843104]  asm_exc_int3+0x3a/0x40
> [  867.843108] RIP: 0010:preempt_count_sub+0x1/0xa0
> [  867.843135]  __bpf_prog_enter_recur+0x17/0x90
> [  867.843148]  bpf_trampoline_6442468108_0+0x2e/0x1000
> [  867.843154]  ? preempt_count_sub+0x1/0xa0
> [  867.843157]  preempt_count_sub+0x5/0xa0
> [  867.843159]  ? migrate_enable+0xac/0xf0
> [  867.843164]  __bpf_prog_exit_recur+0x2d/0x40
> [  867.843168]  bpf_trampoline_6442468108_0+0x55/0x1000
> ...
> [  867.843788]  preempt_count_sub+0x5/0xa0
> [  867.843793]  ? migrate_enable+0xac/0xf0
> [  867.843829]  __bpf_prog_exit_recur+0x2d/0x40
> [  867.843837] BUG: IRQ stack guard page was hit at 0000000099bd8228 (stack is 00000000b23e2bc4..000000006d95af35)
> [  867.843841] BUG: IRQ stack guard page was hit at 000000005ae07924 (stack is 00000000ffd69623..0000000014eb594c)
> [  867.843843] BUG: IRQ stack guard page was hit at 00000000028320f0 (stack is 00000000034b6438..0000000078d1bcec)
> [  867.843842]  bpf_trampoline_6442468108_0+0x55/0x1000
> ...
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Add preempt_count_{sub,add} into btf id deny list
    https://git.kernel.org/bpf/bpf-next/c/c11bd046485d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


