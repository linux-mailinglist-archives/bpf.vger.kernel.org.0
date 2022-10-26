Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4962E60DB96
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 08:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiJZGuY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 02:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbiJZGuU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 02:50:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529ED360A2
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 23:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A669B82116
        for <bpf@vger.kernel.org>; Wed, 26 Oct 2022 06:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B06B4C43470;
        Wed, 26 Oct 2022 06:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666767015;
        bh=cHwj0h8A1Iw4v4NvOX96aFMK2xpvEVYrcADWsisD9pg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pJF7Yzy+hVn5/VX9tVZ/Gyi6Td/X+Ww95daG4VA0k/x0mOCR9i/+qEOGbFCYeTkMX
         Yq/bLqr1U3jXd9Wfoii2rtO4BoP4dyB5/UvIod2zMCBqAUBOz5HVmIHSmFw/PoBh+7
         w3nAUHarxO3qGcc3ojrHtbZ2Ayk6WqSszT5Tv+derXf3ZIa42fVyRalTdGbUzpn16T
         xSaH5oKkHcG0gvXUZ9dV0uBUD6ayEGxzpfZvXLbtc5bcjETsP/LhaLkaaAoJFo7/7o
         Q+trendsubhzmJrMH14GcOREvvTeWUWhnDNXElKTpPCtYcZQbesQioJ6YwrBMfFLNm
         ghLpOjSfwf5oQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F7C3E270DB;
        Wed, 26 Oct 2022 06:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Panic on hard/soft lockup
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166676701557.11097.582825976321869971.git-patchwork-notify@kernel.org>
Date:   Wed, 26 Oct 2022 06:50:15 +0000
References: <20221025231546.811766-1-deso@posteo.net>
In-Reply-To: <20221025231546.811766-1-deso@posteo.net>
To:     =?utf-8?q?Daniel_M=C3=BCller_=3Cdeso=40posteo=2Enet=3E?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, kernel-team@fb.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 25 Oct 2022 23:15:46 +0000 you wrote:
> When running tests, we should probably accept any help we can get when
> it comes to detecting issues early or making them more debuggable. We
> have seen a few cases where a test_progs_noalu32 run, for example,
> encountered a soft lockup and stopped making progress. It was only
> interrupted once we hit the overall test timeout [0]. We can not and do
> not want to necessarily rely on test timeouts, because those rely on
> infrastructure provided by the environment we run in (and which is not
> present in tools/testing/selftests/bpf/vmtest.sh, for example).
> To that end, let's enable panics on soft as well as hard lockups to fail
> fast should we encounter one. That's happening in the configuration
> indented to be used for selftests (including when using vmtest.sh or
> when running in BPF CI).
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Panic on hard/soft lockup
    https://git.kernel.org/bpf/bpf-next/c/5ed88f81511c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


