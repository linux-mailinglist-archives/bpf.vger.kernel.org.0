Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ECC53AFF1
	for <lists+bpf@lfdr.de>; Thu,  2 Jun 2022 00:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiFAWKS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jun 2022 18:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiFAWKR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jun 2022 18:10:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F245716B
        for <bpf@vger.kernel.org>; Wed,  1 Jun 2022 15:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D04B5B81BBA
        for <bpf@vger.kernel.org>; Wed,  1 Jun 2022 22:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E408C385B8;
        Wed,  1 Jun 2022 22:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654121413;
        bh=XoxvJM3hnE28mzycl0V5c7NI9ppybakIZZrOYRgs/xc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cro3Qju11yC8iQUNaXavhk8U97ztpcY6Iy7eCYsi9AmmwjpWfcxDD+sviiTKXsNgs
         C27HloG7Qhfd5gucGxr8I+E9sSYTEOzkFZ0UaKuzY7TLc26vl4H+EyGmY3BbZtHnGB
         oMo9QnU1C0H/riolPBc7Y/aU5HlxGTGRqm9KJlcl/IF7RMzssJYW3O941IFtY6X0QT
         ITbXTsCePhKqyhSTVR24ooyEeds5gaAaNabtJhA/RcyDhjUUCNfzcGdexL/GP8owAD
         LcsWo0DthVxYbagr/Rqzs85/DMdjcRoXABqO+JkigbzRNBkMuZm7C1/Yvxx+dq+zxW
         mJQnsvrwsJcmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BB11F03950;
        Wed,  1 Jun 2022 22:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Fix a couple of typos
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165412141336.14276.4196564802431402682.git-patchwork-notify@kernel.org>
Date:   Wed, 01 Jun 2022 22:10:13 +0000
References: <20220601154025.3295035-1-deso@posteo.net>
In-Reply-To: <20220601154025.3295035-1-deso@posteo.net>
To:     =?utf-8?q?Daniel_M=C3=BCller_=3Cdeso=40posteo=2Enet=3E?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed,  1 Jun 2022 15:40:25 +0000 you wrote:
> This change fixes a couple of typos that were encountered while studying
> the source code.
> 
> Signed-off-by: Daniel Müller <deso@posteo.net>
> ---
>  tools/lib/bpf/btf.c       | 2 +-
>  tools/lib/bpf/libbpf.h    | 2 +-
>  tools/lib/bpf/relo_core.c | 8 ++++----
>  3 files changed, 6 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [bpf-next] libbpf: Fix a couple of typos
    https://git.kernel.org/bpf/bpf-next/c/788542f2b407

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


