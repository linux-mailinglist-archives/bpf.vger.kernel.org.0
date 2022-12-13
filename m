Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BD464C0EA
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 00:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbiLMXuY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 18:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237129AbiLMXuT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 18:50:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C745F66
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 15:50:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 429DAB81613
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 23:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4907C433F0;
        Tue, 13 Dec 2022 23:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670975416;
        bh=5xegMJ+i1udpa3p06ImM1/5BGyt2pm0Mboaa2//1Fsw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=B5yx8rOwx7dP6WARjHAXAsATkuEdIaW6VFG2tk6iVEnhaf+PUotQPm38r3xBDUwjf
         lZkfR9JY+uHVmRnO7lz4U/xqKly73NBlVfhCfl3M0igo6EPVQ3na9TnKivxqHuI/qt
         KhedUfX7OffJB6vOpIXgV9Lzc9M1hn0P04sxa1IYexbatkbJQi60T/1XzXRQxIZ5wZ
         V2LEcD4ybfkcpDPN7JGrEHADV6w5HYrJS0ULflWjVfwIeSLLOUPu+muUIKMvLVc6xn
         2z1o5EEKgoSJDVsJ44xWomrtmAl586tFS6LchMtYefk7mlGqjpefXUhKGOSx/9C2ST
         fBebCryAbIjiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7900E4D00F;
        Tue, 13 Dec 2022 23:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: select
 CONFIG_FUNCTION_ERROR_INJECTION
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167097541581.12895.7593065956133799058.git-patchwork-notify@kernel.org>
Date:   Tue, 13 Dec 2022 23:50:15 +0000
References: <20221213220500.3427947-1-song@kernel.org>
In-Reply-To: <20221213220500.3427947-1-song@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, kernel-team@meta.com,
        deso@posteo.net
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
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 13 Dec 2022 14:05:00 -0800 you wrote:
> BPF selftests require CONFIG_FUNCTION_ERROR_INJECTION to work. However,
> CONFIG_FUNCTION_ERROR_INJECTION is no longer 'y' by default after [1].
> As a result, we are seeing errors like the following from BPF CI:
> 
>    bpf_testmod_test_read() is not modifiable
>    __x64_sys_setdomainname is not sleepable
>    __x64_sys_getpgid is not sleepable
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: select CONFIG_FUNCTION_ERROR_INJECTION
    https://git.kernel.org/bpf/bpf-next/c/e561fc8365da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


