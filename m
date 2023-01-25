Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E070267B69E
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 17:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbjAYQKY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 11:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbjAYQKV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 11:10:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDEE269D;
        Wed, 25 Jan 2023 08:10:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A6FFB81AC7;
        Wed, 25 Jan 2023 16:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4F9FC4339B;
        Wed, 25 Jan 2023 16:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674663017;
        bh=9nVgA44bWgMKV5OW6zijYVeOEm7u43KjiZYBbydbJuU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CQsCyizpHP20tT4kdl4E42YiQp982+Gq48LivJXNqPLML4XPqjRiRg4oynOa0sMmO
         bvwouH3BXsm9FxkpIGCChGLxP4s1BUwaPsa7Y3DLTuBs19FC3TU6IrMykGk7R0nCmX
         ADswAS9DAWvDk+43eiYzeowOoFr3MUT3xGhHypdgziBavOKBYHh/kTgQmaqrlV+ps6
         Un8m1ME2cVQNrfvjhgCZioyHyCQgsndD0RGVUQruQIyXEBYp5swjrqjy7/8Gd3KDFL
         TEQ3fZkTiPZ5olytJp5wCNRZPNUP1plNP+dgsOctnJ0P68+CejRwg8R7nlLyuZ85C1
         UfxfivliBM9fw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9961AF83ED0;
        Wed, 25 Jan 2023 16:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/7] Enable cpumasks to be used as kptrs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167466301762.32537.3494037602376161495.git-patchwork-notify@kernel.org>
Date:   Wed, 25 Jan 2023 16:10:17 +0000
References: <20230125143816.721952-1-void@manifault.com>
In-Reply-To: <20230125143816.721952-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org,
        memxor@gmail.com
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

On Wed, 25 Jan 2023 08:38:09 -0600 you wrote:
> This is part 3 of https://lore.kernel.org/all/20230119235833.2948341-1-void@manifault.com/
> 
> Part 2: https://lore.kernel.org/bpf/20230120192523.3650503-1-void@manifault.com/
> 
> This series is based off of commit b613d335a743 ("bpf: Allow trusted
> args to walk struct when checking BTF IDs").
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/7] bpf: Disallow NULLable pointers for trusted kfuncs
    https://git.kernel.org/bpf/bpf-next/c/caf713c338bd
  - [bpf-next,v3,2/7] bpf: Enable cpumasks to be queried and used as kptrs
    https://git.kernel.org/bpf/bpf-next/c/516f4d3397c9
  - [bpf-next,v3,3/7] selftests/bpf: Add nested trust selftests suite
    https://git.kernel.org/bpf/bpf-next/c/a6541f4d2804
  - [bpf-next,v3,4/7] selftests/bpf: Add selftest suite for cpumask kfuncs
    https://git.kernel.org/bpf/bpf-next/c/7b6abcfa15cd
  - [bpf-next,v3,5/7] bpf/docs: Document cpumask kfuncs in a new file
    https://git.kernel.org/bpf/bpf-next/c/bdbda395845e
  - [bpf-next,v3,6/7] bpf/docs: Document how nested trusted fields may be defined
    https://git.kernel.org/bpf/bpf-next/c/d94cbde2183f
  - [bpf-next,v3,7/7] bpf/docs: Document the nocast aliasing behavior of ___init
    https://git.kernel.org/bpf/bpf-next/c/027bdec89364

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


