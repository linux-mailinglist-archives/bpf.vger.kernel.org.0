Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405AD62B2E2
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 06:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiKPFlD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 00:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiKPFkt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 00:40:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7B2AE4B
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 21:40:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E11D61A30
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 05:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB87DC43144;
        Wed, 16 Nov 2022 05:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668577215;
        bh=s/P6zToXyKbyY/vOSQGDeHUqxln0EEgtCzhYVtH/88g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=emNzs1UULgTzeJbElBoXTPDiAA8sKQNMbXIS3iKls58zwFygptS/rR0+ZYozmG9x7
         fss4OW/a8oXk2JAHHoA5kdJBw87MM1uXWOY1Ncbn+N1O+7HHMwxJIqfj79X7UWpb8G
         XoCGdyaY91rCxe4R9PTWblm4GOhEY6z65RD3jAeWo2pRYnzUCGeXfm8QY2ckWdbOEt
         n0tlB6/r4BYMn6EiN9gPTiPx49JykTcUioMe9Rxuv5945HzFkSnwUTtopnvW5Rit9f
         PJYiRQ79XrQIqqmpEcpc43u7aUwJFNu3TkUcvTbiCOYLHNNIUt9EIkyrq0/JJC4Koh
         b3GDcB2jX3jLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99065E21EFE;
        Wed, 16 Nov 2022 05:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: allow unpriv bpf for selftests by
 default
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166857721561.26805.12743857880299043782.git-patchwork-notify@kernel.org>
Date:   Wed, 16 Nov 2022 05:40:15 +0000
References: <20221116015456.2461135-1-eddyz87@gmail.com>
In-Reply-To: <20221116015456.2461135-1-eddyz87@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
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

On Wed, 16 Nov 2022 03:54:56 +0200 you wrote:
> Enable unprivileged bpf for selftests kernel by default.
> This forces CI to run test_verifier tests in both privileged
> and unprivileged modes.
> 
> The test_verifier.c:do_test uses sysctl kernel.unprivileged_bpf_disabled
> to decide whether to run or to skip test cases in unprivileged mode.
> The CONFIG_BPF_UNPRIV_DEFAULT_OFF controls the default value of the
> kernel.unprivileged_bpf_disabled.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: allow unpriv bpf for selftests by default
    https://git.kernel.org/bpf/bpf-next/c/5b1d640800de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


