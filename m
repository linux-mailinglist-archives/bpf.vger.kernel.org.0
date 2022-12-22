Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A106539F8
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 01:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiLVAAU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 19:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLVAAT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 19:00:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8EFE0D0
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 16:00:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9661C61998
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 00:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E692EC433F0;
        Thu, 22 Dec 2022 00:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671667217;
        bh=QyLTmrdzor+sum89YAYvYD3taOJxlXC9e917RqJMtfw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=q7hPnQBi53bZfFhHY6yAFIM5KQVkYDG4zW++ftyT+GdmudKrogdFPKJYZHA20PrRB
         ODW4pNohHa6wNCg0RyZG+N9yoqYPUjSDW8ZJnk31jxxm7vDz8IoIOFeYXgqzaKZQAe
         r1ooRWwFwQnKjh2ZHnGoGK7pf1Wtoy5FQrWXM23fWXhV68dLkCqm2imAKOPBrJ2mdy
         OkqDdbxEgnOt+xsQO4imA1nnc89QFnLuJw1itPKlknLQZDCCEwPmrDkoH9JEh/uqYp
         gsDj+20N7ab/euI8q/NjQQZ/luJ1WTWBLnhZR3qsT1g6Fhmf9eWX8DjP4zOqaG5Guh
         N4g3FD7sDdhAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA3A6C395DF;
        Thu, 22 Dec 2022 00:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf] selftests/bpf: Test bpf_skb_adjust_room on
 CHECKSUM_PARTIAL
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167166721682.20308.9807013166354194832.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Dec 2022 00:00:16 +0000
References: <20221221185653.1589961-1-martin.lau@linux.dev>
In-Reply-To: <20221221185653.1589961-1-martin.lau@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@meta.com, kuba@kernel.org
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

On Wed, 21 Dec 2022 10:56:53 -0800 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> When the bpf_skb_adjust_room() shrinks the skb such that
> its csum_start is invalid, the skb->ip_summed should
> be reset from CHECKSUM_PARTIAL to CHECKSUM_NONE.
> 
> The commit 54c3f1a81421 ("bpf: pull before calling skb_postpull_rcsum()")
> fixed it.
> 
> [...]

Here is the summary with links:
  - [v4,bpf] selftests/bpf: Test bpf_skb_adjust_room on CHECKSUM_PARTIAL
    https://git.kernel.org/bpf/bpf/c/70a00e2f1dba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


