Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1263F665187
	for <lists+bpf@lfdr.de>; Wed, 11 Jan 2023 03:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjAKCKx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 21:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjAKCKv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 21:10:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE03E234
        for <bpf@vger.kernel.org>; Tue, 10 Jan 2023 18:10:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B11DB81AA6
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 02:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 942BEC433D2;
        Wed, 11 Jan 2023 02:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673403016;
        bh=gwjR3YR0+E/M7qPvFCuk3OTSxvc3YRWc43beBlCPkzM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZFVVTW/i62GlKED+sFJufw6kujVukwFZ0CN5Y+xdbXWxIUbvccjYTFqhK79tepn8+
         rIWCUOhUqWTX4oKyp84edCn8JnCEcFme5n9+XxBuR60pIpbI9pP41u79R0dfg5C0Hk
         koERypUVtc9V5ehhoYb1acoRjmTX68ot4zIeC/tr8n8oCu74JSS0e7V8/TyyC28x5s
         V8SMUOy4P9dDjemJEmdjNbF28VWSD/9mzSe9DmBtdVPNXdYOxs2XqAUM6oIoST+hnk
         CzFv7h3CTIHuEOecSvhz8v9n01Ch79Zqy+5b183QJo6vfRazwG3s6WAibk8zGojsU1
         Oq1qYci20+bJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D5DDE4D026;
        Wed, 11 Jan 2023 02:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf: Fix map creation flags sanitization
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167340301651.2379.15983088919526303033.git-patchwork-notify@kernel.org>
Date:   Wed, 11 Jan 2023 02:10:16 +0000
References: <20230108182018.24433-1-ludovic.lhours@gmail.com>
In-Reply-To: <20230108182018.24433-1-ludovic.lhours@gmail.com>
To:     Ludovic L'Hours <ludovic.lhours@gmail.com>
Cc:     andrii@kernel.org, bpf@vger.kernel.org
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
by Martin KaFai Lau <martin.lau@kernel.org>:

On Sun,  8 Jan 2023 19:20:18 +0100 you wrote:
> As BPF_F_MMAPABLE flag is now conditionnaly set (by map_is_mmapable),
> it should not be toggled but disabled if not supported by kernel.
> 
> Fixes: 4fcac46c7e10 ("libbpf: only add BPF_F_MMAPABLE flag for data maps with global vars")
> Signed-off-by: Ludovic L'Hours <ludovic.lhours@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - libbpf: Fix map creation flags sanitization
    https://git.kernel.org/bpf/bpf-next/c/6920b08661e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


