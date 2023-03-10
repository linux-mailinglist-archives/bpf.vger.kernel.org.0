Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854C46B4FF8
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 19:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjCJSUu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 13:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjCJSUf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 13:20:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF723137898
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 10:20:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 374CB61C1D
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 18:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83A38C4339B;
        Fri, 10 Mar 2023 18:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678472419;
        bh=8xB0PTnQ5oWIRU/qePzBnIZfgK0tNLDZdw3SRJKuTvQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YlPRCiIKTe3gS2pEY+a8DZ9Vmhl9QPuT98RL/vAB/kMCaSr1B3b9xB97mZmiQtKjX
         pUxGgVKV4qkc16HCZuqptd7G39Ek/ajt4XW4Bhfc0J5qLsjoaoo9ac7uEoPiwdeKLd
         +IuvIVcUjxV1ETRVONjAzZg+phCZM8AgLmkJ5C2YNrmkpJ3v6K/u/BJ4/DtjotYPNM
         WnHSXukfvkKT9zFyNvWOP2QKdD9HnBmk46bUZYXN0Mk2FAH/fTuerOEvTM/JJM2KHi
         RBuDSvCGAKNHuI1f5qZstVobCK6kbwdK7ciFZ8357B4q3gbh41Q0mEvMLChUwpR7JN
         bWa946jBeWrFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68621E61B66;
        Fri, 10 Mar 2023 18:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: take into account liveness when propagating
 precision
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167847241942.709.16256872568533003476.git-patchwork-notify@kernel.org>
Date:   Fri, 10 Mar 2023 18:20:19 +0000
References: <20230309224131.57449-1-andrii@kernel.org>
In-Reply-To: <20230309224131.57449-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
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

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 9 Mar 2023 14:41:31 -0800 you wrote:
> When doing state comparison, if old state has register that is not
> marked as REG_LIVE_READ, then we just skip comparison, regardless what's
> the state of corresponing register in current state. This is because not
> REG_LIVE_READ register is irrelevant for further program execution and
> correctness. All good here.
> 
> But when we get to precision propagation, after two states were declared
> equivalent, we don't take into account old register's liveness, and thus
> attempt to propagate precision for register in current state even if
> that register in old state was not REG_LIVE_READ anymore. This is bad,
> because register in current state could be anything at all and this
> could cause -EFAULT due to internal logic bugs.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: take into account liveness when propagating precision
    https://git.kernel.org/bpf/bpf-next/c/52c2b005a3c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


