Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F36E604F9E
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 20:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiJSSa0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 14:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiJSSaZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 14:30:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54D314D8E0;
        Wed, 19 Oct 2022 11:30:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C20AB825A9;
        Wed, 19 Oct 2022 18:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02E6EC433C1;
        Wed, 19 Oct 2022 18:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666204222;
        bh=TLJzRDFwABoe+AQfzbw1ZSUlBK2YNAdeEeDzfljoy+g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WHr3ixzSmYIHO5tDKnCVbGUW/W9H5GoWhiAaqqATNn/j2fuLJkX9ITMRxNZfM1PVt
         MobQEBzRFx7UtIBotUgN5p5D4JRqmHresFU7uXbj6btT451FbcTZWmIQlo2sbddd0c
         lvbCiBkTHAQGwVtuEAM5fZIecTnp3T7dX7l6Ave/kQf6qEMDcuc0mcwY+kYEkCTD2w
         OZNCzZcSEtKA7YKq0q8TSnCV7lpmGC+IHuu0eUsAkP0MnBNXjgm+4S9CeBT+yxNYzv
         vxMf2kVJgFWel4Zo38LFhdaD/KBnAm1ul1AQS+sZKzV++jcDmtH69WfCBmZvV+3fNs
         D0JGfQp+i2qcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE77EE4D00A;
        Wed, 19 Oct 2022 18:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Fix double word in comments
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166620422184.24351.14443966544780633082.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Oct 2022 18:30:21 +0000
References: <20221017142303.8299-1-dengshaomin@cdjrlc.com>
In-Reply-To: <20221017142303.8299-1-dengshaomin@cdjrlc.com>
To:     Shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Mon, 17 Oct 2022 10:23:03 -0400 you wrote:
> Remove the repeated word "by" in comments.
> 
> Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
> ---
>  samples/bpf/hbm_edt_kern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - bpf: Fix double word in comments
    https://git.kernel.org/bpf/bpf-next/c/01dea9548f6c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


