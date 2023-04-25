Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832AA6ED96A
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 02:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjDYAuV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 20:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjDYAuU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 20:50:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6989D269E
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 17:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04D7362A0B
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 00:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54E1FC4339B;
        Tue, 25 Apr 2023 00:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682383818;
        bh=HHOTooamkD0nzFeqdR3+SwF0K3Ynwkr8vI7wJSCwrb0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uXdnIiW7fRJXylDE+RbKjq/Uf6hFd6u4+WR4D/+VwlLqeeIa6yoB+L3RLjjvlY2X/
         gDiAn2nJlZ4Ul4FHhsajmYLsxgyNx2h1KA4tS3RidGr1l60HJ0JYAECJSHFJV+urun
         lv7ifGI7H/p7SDwFy+5r/4NlvBwkzg8kmNmJHBxFpQSY7OdjnCiWmoxyEtn/8ff1IR
         6dWtx0KPUT1Z08TxpBZIDyuxfiLbpfOn81H7n3IsXWX6enQyquiPRNZhXJghjyayJ5
         JmYiP0gppL4ajt1m09m15+fkRuXfRogHl3XssZXalcfTlgBB/fW9k14VIwR7+dkanl
         hOF5glEN63kzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3888EC395D8;
        Tue, 25 Apr 2023 00:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: avoid mark_all_scalars_precise()
 trigger in one of iter tests
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168238381822.28905.7933562222312721500.git-patchwork-notify@kernel.org>
Date:   Tue, 25 Apr 2023 00:50:18 +0000
References: <20230424235128.1941726-1-andrii@kernel.org>
In-Reply-To: <20230424235128.1941726-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, kernel-team@meta.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 24 Apr 2023 16:51:28 -0700 you wrote:
> iter_pass_iter_ptr_to_subprog subtest is relying on actual array size
> being passed as subprog parameter. This combined with recent fixes to
> precision tracking in conditional jumps ([0]) is now causing verifier to
> backtrack all the way to the point where sum() and fill() subprogs are
> called, at which point precision backtrack bails out and forces all the
> states to have precise SCALAR registers. This in turn causes each
> possible value of i within fill() and sum() subprogs to cause
> a different non-equivalent state, preventing iterator code to converge.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: avoid mark_all_scalars_precise() trigger in one of iter tests
    https://git.kernel.org/bpf/bpf-next/c/be7dbd275dc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


