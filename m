Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6D26D1083
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 23:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjC3VKU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 17:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjC3VKT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 17:10:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D152ADBE6
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 14:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E752621B2
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 21:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7BAEC4339B;
        Thu, 30 Mar 2023 21:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680210617;
        bh=kIUFJFTP2VZlv0n3uLhLbKvAZ4nTfcuJfX/bo6ZfTJ4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PIyCcNvMZMeesRKEkZJ2zDN5GLQaW8z8D+ywKFvRGmj3Vx3IOEi+UCFj9/Jal6WUN
         cqQR68CxDjYJlVz1U6F07+pErmaXZI0A1BNA10NRKOU9hALY3SEo5Q7YI7pH9k7GqL
         IWaQnjQBz0Aqf6awZmXYQma+fBf4B88iLxnXrzm4ipuyrjeOAz/ndoXCcgwywg1Ycg
         bEvsRjEEJZMMg2WNDla9b4pOpMQ73vHQqQwrE7hWEsiH/J765zkwJT8R5rBrX1BaLE
         lSU6udSdevMcgG/jMKP9Ug32WHJBKxApKFAb7fl+aX4Pc2idAal/bJMcyx/30pTrVZ
         c0kqmpz0FsaAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9188BE49FA7;
        Thu, 30 Mar 2023 21:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] veristat: change guess for __sk_buff from CGROUP_SKB
 to SCHED_CLS
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168021061759.10339.14532292031080629968.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Mar 2023 21:10:17 +0000
References: <20230330190115.3942962-1-andrii@kernel.org>
In-Reply-To: <20230330190115.3942962-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, kernel-team@meta.com, eddyz87@gmail.com
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
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 30 Mar 2023 12:01:15 -0700 you wrote:
> SCHED_CLS seems to be a better option as a default guess for freplace
> programs that have __sk_buff as a context type.
> 
> Reported-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/testing/selftests/bpf/veristat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] veristat: change guess for __sk_buff from CGROUP_SKB to SCHED_CLS
    https://git.kernel.org/bpf/bpf-next/c/d816129530e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


