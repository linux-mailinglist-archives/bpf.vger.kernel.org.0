Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886F76033B1
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 22:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiJRUAV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 16:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJRUAU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 16:00:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273842317D
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 13:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D511CB82105
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 20:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BF82C433D7;
        Tue, 18 Oct 2022 20:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666123216;
        bh=jiXUmB8bimx6P9FWuOEeCzN3nVZK/IR2+JX9yIq72uc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tdDfTBkd0QJ1rPio+G1CWT5iQILcJs7R3US7B0ZZmLFIR14Cv5H9oFjbxjdAoBlAD
         krzo7Rt4GOGFJkb/Px8wKmQG/w60qKgvwAhj8FyZLr9kPzZDyexm/yIyH8KkNDSlzn
         u5STipSwzrnuTQ3iGxiFl9ahQabdfvmpmSq8l8atB3exNLWQHe+93ESdQLg5B4XlQN
         JyALVlFP4I9I77oZkERztOYphIjs62UH7C+JYieIi+ihORlzExhX+qpeXspbsaP4Nr
         ydPPyNTuFqqkJtnb7yZO6tp5dL3RCmueAry7ffRAG9d6oncs7roE8ogdHFXkjO7UYr
         B/Mhm2LToLLYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5DEDAE4D008;
        Tue, 18 Oct 2022 20:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf/docs: Update README for most recent vmtest.sh
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166612321637.1440.16860756884519945212.git-patchwork-notify@kernel.org>
Date:   Tue, 18 Oct 2022 20:00:16 +0000
References: <20221017232458.1272762-1-deso@posteo.net>
In-Reply-To: <20221017232458.1272762-1-deso@posteo.net>
To:     =?utf-8?q?Daniel_M=C3=BCller_=3Cdeso=40posteo=2Enet=3E?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, kernel-team@fb.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 17 Oct 2022 23:24:58 +0000 you wrote:
> Since commit 40b09653b197 ("selftests/bpf: Adjust vmtest.sh to use local
> kernel configuration") the vmtest.sh script no longer downloads a kernel
> configuration but uses the local, in-repository one.
> This change updates the README, which still mentions the old behavior.
> 
> Signed-off-by: Daniel Müller <deso@posteo.net>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf/docs: Update README for most recent vmtest.sh
    https://git.kernel.org/bpf/bpf-next/c/6c4e777fbba6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


