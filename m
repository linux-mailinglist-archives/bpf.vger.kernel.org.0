Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8B752F624
	for <lists+bpf@lfdr.de>; Sat, 21 May 2022 01:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiETXaR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 May 2022 19:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiETXaP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 19:30:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8821A7D01
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 16:30:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D08CB82E8D
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 23:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B65B9C34116;
        Fri, 20 May 2022 23:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653089411;
        bh=dpSle/p/ktP53s2+xFLrzuo1wSp8/4FxFWKHomvfkbg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Qv+mQAe8uQMi1lRHB6VYA5DeeGgUztCDxa3QbYVXZBoECTZGE4NJsqoN1gHLlyYZy
         lFsQuWb9MqlNOXXKw8KAMeQmgGj3G2iDkOz83bi7ZHyGPThAri/GDg4/Qy5bGB1suo
         iJkMrXR5jIJFwAf6wxfvNJTpzo0RcKeRHX7n0UKIltT8Zv1VOKeWj8UrpXcIEECJim
         fB9IVUcn8wHhvsFf84b2p8Kk3FFXpKMa+QbYjxuZQ1YLrvtyZFgX89k3T+rGLvVUxV
         Lo9/a+D/sIsd9scIbOwUJQSEPlupurWr4NfxCsn47ABNuiqO/8VMEpBOlHrLWAZ4sG
         Y2KbsqjjUMUQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B13FF0383D;
        Fri, 20 May 2022 23:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: remove filtered subtests from output
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165308941156.26800.14727064255700118776.git-patchwork-notify@kernel.org>
Date:   Fri, 20 May 2022 23:30:11 +0000
References: <20220520061303.4004808-1-mykolal@fb.com>
In-Reply-To: <20220520061303.4004808-1-mykolal@fb.com>
To:     Mykola Lysenko <mykolal@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 19 May 2022 23:13:03 -0700 you wrote:
> Currently filtered subtests show up in the output as skipped.
> 
> Before:
> $ sudo ./test_progs -t log_fixup/missing_map
>  #94 /1     log_fixup/bad_core_relo_trunc_none:SKIP
>  #94 /2     log_fixup/bad_core_relo_trunc_partial:SKIP
>  #94 /3     log_fixup/bad_core_relo_trunc_full:SKIP
>  #94 /4     log_fixup/bad_core_relo_subprog:SKIP
>  #94 /5     log_fixup/missing_map:OK
>  #94        log_fixup:OK
> Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: remove filtered subtests from output
    https://git.kernel.org/bpf/bpf-next/c/2dc323b1c4cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


