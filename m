Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C3969FD4E
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 22:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjBVVAe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 16:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjBVVAb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 16:00:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AE34344D
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 13:00:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24C91B81888
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 21:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC745C4339B;
        Wed, 22 Feb 2023 21:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677099617;
        bh=rj/r+EbL+hC+GOZM7TRiDHX2rPyGDnL1OQM1HYB2B4U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZH/9GbdGYswnlFXCJfZSmPnfaaiJP9nzEDjgxEaoUU5OV8Eeg9p3QKISZAwxKNLSH
         WiSIGu2EQAuXyBOZ5ByO3jIwdYB3Q3UrZMxeAlXZfI3twOlnk6olDNOz+QG3DdDD0h
         8ijeyt71uqnem4PCPimiYKnBw4Th2p1HTEfn1jxGcYTyobm3WoL7vgFtSR2xVSzOKk
         lr8tbjX9mA7bAQnfUTYpUcH6SyTSTMQMMl8iXuu8BGz82GFMsp7U2KXIKpJ8MUupAZ
         h4ckm2U2UtM2KINn0e8/Hv0Nx1xRE2KjG7QSm3FP1oT1O4mbAq/oaOq4LKeAH+xwVG
         iEmV6s6L93Dvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8EF06C395DF;
        Wed, 22 Feb 2023 21:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/7] Add support for kptrs in more BPF maps
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167709961758.3498.16748455993991035012.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Feb 2023 21:00:17 +0000
References: <20230221200646.2500777-1-memxor@gmail.com>
In-Reply-To: <20230221200646.2500777-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org, kpsingh@kernel.org,
        davemarchevsky@meta.com, void@manifault.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 21 Feb 2023 21:06:39 +0100 you wrote:
> This set adds support for kptrs in percpu hashmaps, percpu LRU hashmaps,
> and local storage maps (covering sk, cgrp, task, inode). There are also
> minor miscellaneous cleanups rolled in, unrelated to the set, that I
> collected over time. Feel free to drop them, they have been
> intentionally placed after the kptr support to ease partial application
> of the series.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/7] bpf: Support kptrs in percpu hashmap and percpu LRU hashmap
    (no matching commit)
  - [bpf-next,v2,2/7] bpf: Support kptrs in local storage maps
    (no matching commit)
  - [bpf-next,v2,3/7] bpf: Annotate data races in bpf_local_storage
    https://git.kernel.org/bpf/bpf-next/c/0a09a2f933c7
  - [bpf-next,v2,4/7] bpf: Remove unused MEM_ALLOC | PTR_TRUSTED checks
    https://git.kernel.org/bpf/bpf-next/c/521d3c0a1730
  - [bpf-next,v2,5/7] bpf: Fix check_reg_type for PTR_TO_BTF_ID
    https://git.kernel.org/bpf/bpf-next/c/da03e43a8c50
  - [bpf-next,v2,6/7] bpf: Wrap register invalidation with a helper
    https://git.kernel.org/bpf/bpf-next/c/dbd8d22863e8
  - [bpf-next,v2,7/7] selftests/bpf: Add more tests for kptrs in maps
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


