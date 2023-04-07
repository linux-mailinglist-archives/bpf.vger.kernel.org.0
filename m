Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90366DB679
	for <lists+bpf@lfdr.de>; Sat,  8 Apr 2023 00:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjDGWaV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Apr 2023 18:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDGWaU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Apr 2023 18:30:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B2A93C2
        for <bpf@vger.kernel.org>; Fri,  7 Apr 2023 15:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52239612B7
        for <bpf@vger.kernel.org>; Fri,  7 Apr 2023 22:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9871C4339B;
        Fri,  7 Apr 2023 22:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680906618;
        bh=2uRcEh+dwTrN7t+jcVBRLO5RqQBFkX2bNHWtH7aVVKo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LbzFHR9RlV2moTQpsPnN9TAYC5D5eiljlxYs6+IGpg33liX00dEGnxCrAdkdcZRqd
         2YgIgpa30dgNdTzzsrALw+2HnmZVjBfuo4n1gpnZpik/T6QnLoVfqL2bZB/dYkG9lN
         /JyWsjTjgyOsyinqzxb4F5WLgHXcKytjUqZvnUyH3s+xD6qnQf96VSFfHBDOW3iw2g
         Uh303JNjkCXwxCe7qIVXxyIkmSY7kaZid42beSRtpGRXG4Z52hOOluc9XhYpVab9m2
         +GSRIniBc3dPNIxRd6UefC3b9/CRP48AJ2ekGHWafZyFVNGBULGMl/ZZNkY2p15hro
         UUGU2ojejQhBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D029C4167B;
        Fri,  7 Apr 2023 22:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Use PERF_COUNT_HW_CPU_CYCLES event
 for get_branch_snapshot
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168090661857.32399.12892629908764782223.git-patchwork-notify@kernel.org>
Date:   Fri, 07 Apr 2023 22:30:18 +0000
References: <20230407190130.2093736-1-song@kernel.org>
In-Reply-To: <20230407190130.2093736-1-song@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@meta.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 7 Apr 2023 12:01:30 -0700 you wrote:
> perf_event with type=PERF_TYPE_RAW and config=0x1b00 turned out to be not
> reliable in ensuring LBR is active. Thus, test_progs:get_branch_snapshot is
> not reliable in some systems. Replace it with PERF_COUNT_HW_CPU_CYCLES
> event, which gives more consistent results.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Use PERF_COUNT_HW_CPU_CYCLES event for get_branch_snapshot
    https://git.kernel.org/bpf/bpf-next/c/3ebf5212bf04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


