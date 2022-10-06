Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D9D5F5D86
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 02:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJFAKU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 20:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJFAKS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 20:10:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5311A05C
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 17:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 399CF617F1
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 00:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D4CFC433D7;
        Thu,  6 Oct 2022 00:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665015015;
        bh=Sp92HPsWhyPd/R8zJiJhCqV51Frii15m6O7ZQCfdd4A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cGu3JBOLGB+HJk7ho5D6Uh8F6RPT0ezJ4pTkJQq+jGVmVttqxZuuBhSzOnNVwK4fa
         NGKUU08lBrkzdts0GdkJ8z5A8QdgzoPNdHUaPAQ4Ft6SOo8R0X/mptP0L7hnYXpR9i
         LGUUfBpoOv0qY959DwPTwrhuHH5kjk+HABekkPAzw/pv9xBFw6TtR+eJdWyy/seN/o
         StJf5GqekwpMXqUrSdJfzRtpzgKshJUTy9vX0Lm946Cm40TuxQCjUKlVpBBGX7/lSA
         uHUzVKN7atlvgbY81ri/7Im6hbT5MnUr9s29LNAn2mO4SdIJiPA2fu8k07kU5hEaxn
         MyhWe5uJvEFig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7251AE49FA7;
        Thu,  6 Oct 2022 00:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: allow requesting log level 2 in
 test_verifier
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166501501546.16568.14333185487521752791.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Oct 2022 00:10:15 +0000
References: <20221005161450.1064469-1-andrii@kernel.org>
In-Reply-To: <20221005161450.1064469-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
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

On Wed, 5 Oct 2022 09:14:48 -0700 you wrote:
> Log level 1 on successfully verified programs are basically equivalent
> to log level 4 (stats-only), so it's useful to be able to request more
> verbose logs at log level 2. Teach test_verifier to recognize -vv as
> "very verbose" mode switch and use log level 2 in such mode.
> 
> Also force verifier stats regradless of -v or -vv, they are very minimal
> and useful to be always emitted in verbose mode.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] selftests/bpf: allow requesting log level 2 in test_verifier
    https://git.kernel.org/bpf/bpf-next/c/2a72f5951ac6
  - [bpf-next,2/3] selftests/bpf: avoid reporting +100% difference in veristat for actual 0%
    https://git.kernel.org/bpf/bpf-next/c/6df2eb45e378
  - [bpf-next,3/3] selftests/bpf: add BPF object fixup step to veristat
    https://git.kernel.org/bpf/bpf-next/c/60df8c4d32d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


