Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE4869FD34
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 21:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBVUuW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 15:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjBVUuV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 15:50:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7A44109B
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 12:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DA89B8159B
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 20:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3E7FC4339C;
        Wed, 22 Feb 2023 20:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677099017;
        bh=aW8DAwMC6PvEzaZDHKr+vgpjMXacJzpGhgyUIVUB+eE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qbLcllgYbBtbr2L1MQAHVpu0jFo73j1v93aDTDKNZUpYvntXstYHNTZqYEmFRcjcp
         Hgspg+xql7PZfAfqs74mpsmEbwuYFb/mntJIPH5wqkC/7ynK0vwosX/sGdx9gI2GmF
         ANKhASqAnFRkAueTlPXEH0v3aRV4hZM8TcRDdbsOALKgU3cnyUR5wknTktqul3sVL+
         Fx2EClhFzFA+M9ivmkYzQPJ5K/NuK0lE4Ojbj2Kn7xYIik7Y+kBkTZjsL5g68CGXPC
         B4LQNoSy34DPO3iuqLf/hFXYxvvAMBsSxqwuz3hApeiZ95vXhb6SyUlr/zUSMwcOgb
         5BDLYO9Y6JL9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CDF43C395DF;
        Wed, 22 Feb 2023 20:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Allow reads from uninit stack
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167709901684.29904.12690598164971386254.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Feb 2023 20:50:16 +0000
References: <20230219200427.606541-1-eddyz87@gmail.com>
In-Reply-To: <20230219200427.606541-1-eddyz87@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 19 Feb 2023 22:04:25 +0200 you wrote:
> This patch-set modifies BPF verifier to accept programs that read from
> uninitialized stack locations, but only if executed in privileged mode.
> This provides significant verification performance gains: 30% to 70% less
> processed states for big number of test programs.
> 
> The reason for performance gains comes from treating STACK_MISC and
> STACK_INVALID as compatible, when cached state is compared to current state
> in verifier.c:stacksafe().
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Allow reads from uninit stack
    https://git.kernel.org/bpf/bpf-next/c/6715df8d5d24
  - [bpf-next,v2,2/2] selftests/bpf: Tests for uninitialized stack reads
    https://git.kernel.org/bpf/bpf-next/c/6338a94d5ab4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


