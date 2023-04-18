Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A4A6E6D33
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 22:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjDRUAX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 16:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDRUAW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 16:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83AD44A6
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 13:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 429E96331B
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 20:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98D76C4339B;
        Tue, 18 Apr 2023 20:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681848020;
        bh=nTjS4wKgcy7e0JrABXZyNljfwsAKMTwxxZx0MzYth6M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rXN1r3AkEFlJMX3LprvpiXJEdUK+hTQeAhJ3c7hETBJTuyRu5wlWQInDPqpBuKDrM
         JAq2AmmvYeZyZN+tWrQym9jUjVkn+/uDNYgjo1f9NpvuHqpSQSN7cLBZVDyoaFvgw3
         jHBIAG16ONjyS8AZeme2rq5rDMzsofnTvdJVheV5ZmenzqskObBtuE6bYmz2J0OVkG
         LrLBkvB3KFEURiR+Iq3sBZfnYZInVulOnusmvoWc4e/+XWpCed2538Z0/zxqukrXiZ
         Qz2aT53xgTvheKXX7EKOxYXfnK6jGgX9nk8IKSg+oeNj7egfs7gnewAnO6C7MGfhHf
         UH1kanEYUZFpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 743D1E270E4;
        Tue, 18 Apr 2023 20:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/6] Provide bpf_for() and bpf_for_each() by libbpf
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168184802046.10886.237770748508440656.git-patchwork-notify@kernel.org>
Date:   Tue, 18 Apr 2023 20:00:20 +0000
References: <20230418002148.3255690-1-andrii@kernel.org>
In-Reply-To: <20230418002148.3255690-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, kernel-team@meta.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 17 Apr 2023 17:21:42 -0700 you wrote:
> This patch set moves bpf_for(), bpf_for_each(), and bpf_repeat() macros from
> selftests-internal bpf_misc.h header to libbpf-provided bpf_helpers.h header.
> To do this in a way to allow users to feature-detect and guard such
> bpf_for()/bpf_for_each() uses on old kernels we also extend libbpf to improve
> unresolved kfunc calls handling and reporting. This lets us mark
> bpf_iter_num_{new,next,destroy}() declarations as __weak, and thus not fail
> program loading outright if such kfuncs are missing on the host kernel.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/6] libbpf: misc internal libbpf clean ups around log fixup
    https://git.kernel.org/bpf/bpf-next/c/3055ddd654f6
  - [bpf-next,2/6] libbpf: report vmlinux vs module name when dealing with ksyms
    https://git.kernel.org/bpf/bpf-next/c/f709160d1724
  - [bpf-next,3/6] libbpf: improve handling of unresolved kfuncs
    https://git.kernel.org/bpf/bpf-next/c/05b6f766b25c
  - [bpf-next,4/6] selftests/bpf: add missing __weak kfunc log fixup test
    https://git.kernel.org/bpf/bpf-next/c/30bbfe3236b0
  - [bpf-next,5/6] libbpf: move bpf_for(), bpf_for_each(), and bpf_repeat() into bpf_helpers.h
    https://git.kernel.org/bpf/bpf-next/c/c5e647416708
  - [bpf-next,6/6] libbpf: mark bpf_iter_num_{new,next,destroy} as __weak
    https://git.kernel.org/bpf/bpf-next/c/94dccba79520

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


