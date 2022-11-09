Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617B76234BA
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 21:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiKIUkU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 15:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKIUkT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 15:40:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8749417050;
        Wed,  9 Nov 2022 12:40:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B01FB82014;
        Wed,  9 Nov 2022 20:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C06F9C433C1;
        Wed,  9 Nov 2022 20:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668026415;
        bh=gFXaWwnz3S2Q6E6pSl0SQOVhUbhyhH/QZEAB2acSXp0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CaHMOjRh56/L7NNW/2Ivj8mESYwRNhq5HL8/zMaRQLXnY1kwIMNz6rAHV7IcZ4W0M
         AaONCJ3d4FBsGVClC/6UUGZDSb3JNRhsr1fqzsCfAZFhfsICLSrCtwk1FUoz/nkcNP
         2z5rSwGC1WaSDNFKUyPCczztDaOrXq8akcXmYliaQy8vQWS9z4T1wqKpcSYXuGjeLL
         w16Wc8JJiG8huBhkDeH8HdTqX5Zw3g3BEgkLQFd8s4Hgk2ly7rmQ1KTaRcJj6x3TuB
         mZvz6ac8eCez8gk24yQi1P6JQNiccCJCecqJY6zKk0Opbz5+XwHlR+POwsnFBFqCWQ
         zLBbBpoUrc2QQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 973FBC395FE;
        Wed,  9 Nov 2022 20:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: Fix casting error when cross-compiling
 test_verifier for 32-bit platforms
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166802641561.13002.14650540365573417178.git-patchwork-notify@kernel.org>
Date:   Wed, 09 Nov 2022 20:40:15 +0000
References: <20221108121945.4104644-1-pulehui@huaweicloud.com>
In-Reply-To: <20221108121945.4104644-1-pulehui@huaweicloud.com>
To:     Pu Lehui <pulehui@huaweicloud.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, eddyz87@gmail.com, pulehui@huawei.com
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
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue,  8 Nov 2022 20:19:45 +0800 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> When cross-compiling test_verifier for 32-bit platforms, the casting error is shown below:
> 
> test_verifier.c:1263:27: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>  1263 |  info.xlated_prog_insns = (__u64)*buf;
>       |                           ^
> cc1: all warnings being treated as errors
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: Fix casting error when cross-compiling test_verifier for 32-bit platforms
    https://git.kernel.org/bpf/bpf/c/0811664da064

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


