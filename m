Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384F8688EA8
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 05:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjBCEuU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 23:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBCEuT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 23:50:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACC470987;
        Thu,  2 Feb 2023 20:50:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDDB261D85;
        Fri,  3 Feb 2023 04:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36B3BC433EF;
        Fri,  3 Feb 2023 04:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675399817;
        bh=yEBHazE09WVz9ga/0Zxt2EVoRpcCqPQt7YDFz0YYbSY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sOC7kZnyKfYK6ypmLbUK3dqTi754rkq915UqZ6lC7wbz7EJfmPDEIQthcB09FGrJa
         N+1OB7GhKR6mH1cClkUOZRLQRmxhYLpnE6WuO3OX7Jpcj2+PJGMGQ8/dPBfg7gTwhn
         qWDxuDZ/QPc0idwV89UGjJNafW2KZXe1NGDGzT+Y6t+PJ2DJCBHHBVQpZ58Y8JtB1O
         wf3DEh46xc3JymE7CyrS6kHs2ozgsDHTPiIxSc/Nns4SEM2Qd6XQYCT7AWiG9uBYuk
         E2SMBqcKp16JzLJwr86fzXWxdwAPWzDGiieFKCxkBh+Qni59Q3V2xCq7YsZe4a+SI+
         vVfDvunT9FGww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17B6FE270C4;
        Fri,  3 Feb 2023 04:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpf: Two small cleanups
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167539981709.16316.14082640306773114847.git-patchwork-notify@kernel.org>
Date:   Fri, 03 Feb 2023 04:50:17 +0000
References: <1675319486-27744-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1675319486-27744-1-git-send-email-yangtiezhu@loongson.cn>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu,  2 Feb 2023 14:31:24 +0800 you wrote:
> Tiezhu Yang (2):
>   tools/bpf: Use tab instead of white spaces to sync bpf.h
>   selftests/bpf: Use semicolon instead of comma in test_verifier.c
> 
>  tools/include/uapi/linux/bpf.h              | 4 ++--
>  tools/testing/selftests/bpf/test_verifier.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [bpf-next,1/2] tools/bpf: Use tab instead of white spaces to sync bpf.h
    https://git.kernel.org/bpf/bpf-next/c/e2bd9742989b
  - [bpf-next,2/2] selftests/bpf: Use semicolon instead of comma in test_verifier.c
    https://git.kernel.org/bpf/bpf-next/c/150809082aab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


