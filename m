Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3715F15FC
	for <lists+bpf@lfdr.de>; Sat,  1 Oct 2022 00:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbiI3WUU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 18:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbiI3WUQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 18:20:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123D261B25;
        Fri, 30 Sep 2022 15:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98BAE624E6;
        Fri, 30 Sep 2022 22:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E863EC433D7;
        Fri, 30 Sep 2022 22:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664576415;
        bh=Bt1k2I7Ai9NohzA4Ulehl31JUCHSQnWaFU2Qle7n4DY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uVDqBys/2mp29w3Z5talOJ2q2nqdE11pZqsa6fQ26isGG3Xl2nz8RoA2XMRPB29uJ
         mlKLQpTcUwbMLYbxu0ayxFlunepuj7lf6GzYvtmU6WlAseCY1ySpTzR+XxhdxdANur
         dWIUUBdZi0nVcr1o4x5GcjxLfA8w52SK18mYPHWtLSpZaHar16hvLnOQw4FFL4Srsa
         0qJO6v8kboGZcRCglgk3HRlyAMbCGy0MIUGGyH0Lg2OAq9v9l2DBVeydzgLyn+CUUW
         8PzLz7p2xrnsMD2t29BcwfGUwHkIoZIIVpo2GNM6kBp3btaaExkE/KbxczRTYpRRPs
         36QNHstWETM6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC5EEE4D013;
        Fri, 30 Sep 2022 22:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf:fix overrun in attribute iteration
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166457641483.5145.8427039204984502212.git-patchwork-notify@kernel.org>
Date:   Fri, 30 Sep 2022 22:20:14 +0000
References: <20220930090708.62394-1-liuxin350@huawei.com>
In-Reply-To: <20220930090708.62394-1-liuxin350@huawei.com>
To:     Xin Liu <liuxin350@huawei.com>
Cc:     quentin@isovalent.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kongweibin2@huawei.com,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, sdf@google.com, song@kernel.org,
        wuchangye@huawei.com, xiesongyang@huawei.com, yanan@huawei.com,
        yhs@fb.com, zhudi2@huawei.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Fri, 30 Sep 2022 17:07:08 +0800 you wrote:
> I accidentally found that a change in commit 1045b03e07d8 ("netlink: fix
> overrun in attribute iteration") was not synchronized to the function
> `nla_ok` in tools/lib/bpf/nlattr.c, I think it is necessary to modify,
> this patch will do it.
> 
> Signed-off-by: Xin Liu <liuxin350@huawei.com>
> 
> [...]

Here is the summary with links:
  - libbpf:fix overrun in attribute iteration
    https://git.kernel.org/bpf/bpf-next/c/51e05a8cf8eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


