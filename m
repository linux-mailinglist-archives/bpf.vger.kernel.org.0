Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD816A7429
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 20:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjCATUW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 14:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjCATUW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 14:20:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B42D42BCF
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 11:20:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9DB1B81126
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 19:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78909C433EF;
        Wed,  1 Mar 2023 19:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677698418;
        bh=8a2EQgQKmTr3K/fGrJN0hW3nqxZ4kLVO8Gvx7Q5x2M8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IBX302DvEHVdPVM4653a4ZC6hkIvDVxcoaC40BEKk8e70tj4DJGEiqnzmmkXIP3c2
         agJjLJppJVT2vXzqTCyhq+QKESkN4RJFSE0eebc4/Ie2OW62ur9RsaNtGPJuvlbCTI
         xnbUE10uRqP1GqviwZY/XoaxOyiz2ykMIvB9I3UCg0wqz9eemvLEaxXUE4pUapdaRn
         UE89arMxpqoSm2yWUhqjYSHz6BlVtui+OfiMSzIOU+j0H18u9cyIBf7tO9siB8uuAw
         iqgabUWc4NxFoUmNl3auNc0OERI/h38gdpIPY/jxpxZqAiFMj3SffBMC7szpo5K+7M
         qanCiCuQGgXGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5AA10C41676;
        Wed,  1 Mar 2023 19:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/1] selftests/bpf: support custom per-test flags and
 multiple expected messages
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167769841836.22651.2010535238574748988.git-patchwork-notify@kernel.org>
Date:   Wed, 01 Mar 2023 19:20:18 +0000
References: <20230301175417.3146070-1-eddyz87@gmail.com>
In-Reply-To: <20230301175417.3146070-1-eddyz87@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  1 Mar 2023 19:54:16 +0200 you wrote:
> This patch allows to specify program flags and multiple verifier log
> messages for the test_loader kind of tests. For example:
> 
>   tools/testing/selftets/bpf/progs/foobar.c:
> 
>     SEC("tc")
>     __success __log_level(7)
>     __msg("first message")
>     __msg("next message")
>     __flag(BPF_F_ANY_ALIGNMENT)
>     int buz(struct __sk_buff *skb)
>     { ... }
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/1] selftests/bpf: support custom per-test flags and multiple expected messages
    https://git.kernel.org/bpf/bpf-next/c/35cbf7f91568

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


