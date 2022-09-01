Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB7D5AA15D
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 23:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbiIAVKT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 17:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiIAVKS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 17:10:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9626A3DF20;
        Thu,  1 Sep 2022 14:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 553DBB82939;
        Thu,  1 Sep 2022 21:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 048A8C433D7;
        Thu,  1 Sep 2022 21:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662066615;
        bh=uK3LHkBlUkCOueQhUHBS1Wh7J6xa+HkoKB/uvtNZ+7Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=L9f1ZUR7SZ2ptNG18dUDqMum9Fap9E17qwbmgSjukK3YTepFf8GsPzuF9NNOJxL7b
         SSp3LKlnUGUTZNAFWi0+E3xjFedJ5iZoyPXJFexRHIOdFb3ASH9gGctK+rJXxtxv9C
         4ykMO6VdefnbMFyVf2I9LE4n3OGLs8DuXQzxeudV0OK7Z26CGXGurQd28+HZQ8u/SF
         u7248d220Op4gOjTE0qCRO8H+d4VkZmslrehBApd7/LUAqGiOzclovbUAeLCYckW+z
         pmGA7eLFhABYLTxCcvg6cjEjbntDigoqRUELQCC5zVH/qu8MFw+BRr1Ny32YtLei+1
         JWC+HX3fcAnHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB212E924DA;
        Thu,  1 Sep 2022 21:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Remove useless else if
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166206661488.11491.13732223075037979617.git-patchwork-notify@kernel.org>
Date:   Thu, 01 Sep 2022 21:10:14 +0000
References: <20220831021618.86770-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20220831021618.86770-1-jiapeng.chong@linux.alibaba.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     yhs@fb.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, abaci@linux.alibaba.com
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

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 31 Aug 2022 10:16:18 +0800 you wrote:
> The assignment of the else and else if branches is the same, so the else
> if here is redundant, so we remove it and add a comment to make the code
> here readable.
> 
> ./kernel/bpf/cgroup_iter.c:81:6-8: WARNING: possible condition with no effect (if == else).
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2016
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> 
> [...]

Here is the summary with links:
  - bpf: Remove useless else if
    https://git.kernel.org/bpf/bpf-next/c/ccf365eac0c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


