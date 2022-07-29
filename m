Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CAC5856E2
	for <lists+bpf@lfdr.de>; Sat, 30 Jul 2022 00:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiG2WkW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 18:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiG2WkP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 18:40:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA03D14030;
        Fri, 29 Jul 2022 15:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EF4E6206C;
        Fri, 29 Jul 2022 22:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6060AC43140;
        Fri, 29 Jul 2022 22:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659134413;
        bh=g8IspXOTTAcN1lgRiVT1J9dflPj9acBNDo5/Xv/aLas=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=N0jALmHkH8eZGQWqYHurFaYpEwinQVbWy0/fuED125juzTHrSz4DYOcljDnLO+7k4
         IJRcef+PpY3np4UiQJwE8rw+H400dUxzKOGkKC5gPOR1DC4cr2CdlihyX8CCZLA+Lx
         Mqp92D6/WOkjpSK0bcEcQJVX5k1SpwstzAjqHMi9ewIz2nxpn68l7LIKU/Pia7a6kx
         Kggpghu1f8AjWvdb06qmmPhQ8Zg+kpRxpnAPTLAUQU4Sj1BgmdLXT2KtHEdh6Dip0A
         kVEhUfg6vPpD63AYbj0z5iZuccn/u3H08xormeHBDdCca57GpTnH93HJpTpMHNWXuP
         UTJvtwokIbXnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 444C2C43142;
        Fri, 29 Jul 2022 22:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] bpf: remove unneeded semicolon
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165913441327.29361.1203034031458667191.git-patchwork-notify@kernel.org>
Date:   Fri, 29 Jul 2022 22:40:13 +0000
References: <20220725222733.55613-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220725222733.55613-1-yang.lee@linux.alibaba.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, abaci@linux.alibaba.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Tue, 26 Jul 2022 06:27:33 +0800 you wrote:
> Eliminate the following coccicheck warning:
> /kernel/bpf/trampoline.c:101:2-3: Unneeded semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  kernel/bpf/trampoline.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [-next] bpf: remove unneeded semicolon
    https://git.kernel.org/bpf/bpf-next/c/14250fa4839b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


