Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EA6660930
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 23:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbjAFWBU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 17:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236749AbjAFWAz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 17:00:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF324872B0;
        Fri,  6 Jan 2023 14:00:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2247E61F95;
        Fri,  6 Jan 2023 22:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D095C43392;
        Fri,  6 Jan 2023 22:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673042417;
        bh=i7T+6JKz2WTXvDqYqk418QBPETZDvfGBp3oBV0fcCTI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=X2v/+Li3fK8OXsYOhpJOzW9VqLnI51p5GwXqhGUElAmQTuLOIAeQQUZBrYJn5b8WW
         x7AYgfBq0FV06KxqISIUOlVDPJF5BxVD3eycISYsWLEbJtoRYAO654yKGtqxOgofeW
         F85o2RKPtc7T9eKYeWyjfUXnrYSOFAtArAG2gjanx1QicLUxiH5SS/Z4EVOtA5l34A
         wOl32XhF94LSVEsMjobroUMYqTr1tQlbUROnt36xJpTRHQxM7PiF+VV1AoKnwxqoTQ
         q9YxBZDScjr/bRAm8qgEmGNIfVVqit1LnzVzhrKc+kpCicBwn2FouTP+uqy/7ERo6a
         OQ2rQ+ToNoEFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5071BE5724D;
        Fri,  6 Jan 2023 22:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: skip task with pid=1 in send_signal_common()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167304241732.27890.12549455955282879496.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Jan 2023 22:00:17 +0000
References: <20230106084838.12690-1-sunhao.th@gmail.com>
In-Reply-To: <20230106084838.12690-1-sunhao.th@gmail.com>
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri,  6 Jan 2023 16:48:38 +0800 you wrote:
> The following kernel panic can be triggered when a task with pid=1
> attach a prog that attempts to send killing signal to itself, also
> see [1] for more details:
> 
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> CPU: 3 PID: 1 Comm: systemd Not tainted 6.1.0-09652-g59fe41b5255f #148
> Call Trace:
> <TASK>
> __dump_stack lib/dump_stack.c:88 [inline]
> dump_stack_lvl+0x100/0x178 lib/dump_stack.c:106
> panic+0x2c4/0x60f kernel/panic.c:275
> do_exit.cold+0x63/0xe4 kernel/exit.c:789
> do_group_exit+0xd4/0x2a0 kernel/exit.c:950
> get_signal+0x2460/0x2600 kernel/signal.c:2858
> arch_do_signal_or_restart+0x78/0x5d0 arch/x86/kernel/signal.c:306
> exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
> exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:203
> __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
> syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
> do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> [...]

Here is the summary with links:
  - bpf: skip task with pid=1 in send_signal_common()
    https://git.kernel.org/bpf/bpf/c/a3d81bc1eaef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


