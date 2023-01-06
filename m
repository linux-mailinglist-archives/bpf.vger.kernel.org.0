Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D6D66061F
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 19:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjAFSAU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 13:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235821AbjAFSAT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 13:00:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D697DE19;
        Fri,  6 Jan 2023 10:00:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C21FB81C48;
        Fri,  6 Jan 2023 18:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6D65C433F0;
        Fri,  6 Jan 2023 18:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673028015;
        bh=xAdv+mpIHwbjZ8iMlZjBaAqeepkytaxdVGzBXlEganM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Xw5PuKwZm8WDga9WXbPlT7H0bs1jY1gy9CClNIJdO3eZk9f2O/s9uh47RdHg07tL2
         91q/YZAz/3ULJnG0L0m+2WamSdH24DAgQvOsTKRvvQ+LHZujyU0NM0WH0RG9elZViv
         Tj6yYCH0G8LFMSoNYDYkjdd9XMWzVmCmQ+VGdl6yGyV3xsE/8gAHKLogTw33d+EUwF
         /59fcI0Pbk/pThEtXo2kGGbCGMYhSnsTQND6S4qHJqIzGuWyXiLmOl5WjCpcsi+Ae8
         9ievRTqSjuiaypNDkc7OamNjeVAoWs9yyZrPk+jV/qHElDWMMPBT5xof19FgG4tUpj
         9U0YYy6AWs/Pw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE0E2C395DF;
        Fri,  6 Jan 2023 18:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: skip invalid kfunc call in backtrack_insn
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167302801577.16346.8234283027258741479.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Jan 2023 18:00:15 +0000
References: <20230104014709.9375-1-sunhao.th@gmail.com>
In-Reply-To: <20230104014709.9375-1-sunhao.th@gmail.com>
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

On Wed,  4 Jan 2023 09:47:09 +0800 you wrote:
> The verifier skips invalid kfunc call in check_kfunc_call(), which
> would be captured in fixup_kfunc_call() if such insn is not
> eliminated by dead code elimination. However, this can lead to the
> following warning in backtrack_insn(), alse see [1]:
> 
> ------------[ cut here ]------------
> verifier backtracking bug
> WARNING: CPU: 6 PID: 8646 at kernel/bpf/verifier.c:2756 backtrack_insn
> kernel/bpf/verifier.c:2756
> 	__mark_chain_precision kernel/bpf/verifier.c:3065
> 	mark_chain_precision kernel/bpf/verifier.c:3165
> 	adjust_reg_min_max_vals kernel/bpf/verifier.c:10715
> 	check_alu_op kernel/bpf/verifier.c:10928
> 	do_check kernel/bpf/verifier.c:13821 [inline]
> 	do_check_common kernel/bpf/verifier.c:16289
> ...
> 
> [...]

Here is the summary with links:
  - bpf: skip invalid kfunc call in backtrack_insn
    https://git.kernel.org/bpf/bpf/c/d3178e8a434b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


