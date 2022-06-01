Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E410653B04E
	for <lists+bpf@lfdr.de>; Thu,  2 Jun 2022 00:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbiFAWuQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jun 2022 18:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiFAWuP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jun 2022 18:50:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF612838D4;
        Wed,  1 Jun 2022 15:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7954361053;
        Wed,  1 Jun 2022 22:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8F62C385A5;
        Wed,  1 Jun 2022 22:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654123812;
        bh=6CvCnnAVyCXcLQ8zBFyJWeBh6er1L3Kq4/lafoSo9/c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bKf3r0vbfd9dhg4xxBGuiSzlyrBearvFnsC6RqbvQJfzg5G62p9he52lKvSvVu/Zh
         Ehqx1HfIajNEuxu4LvSu6e0amfwp4DQp1Jjvg/gafQojXNuWq/lYAL4VGhqBfPi+fF
         YFQbE4IUD2nXzCPrciPUqOMF2c4wxwt0FauCjohJAeVniE07eCjdJE7HEscpB8lXEA
         APo9tmxtj+5Lsc3KbPxFsHateiwmEtujYbTkp5dF1aZFeN0TK1/Zmw4KbtgYfUozWL
         NVZoF6BNJsdzHSeRMLgeo3TSCmXJUN/Y8fFa5Mx6OfKo4HD5xtgPCqPjJyl6kg975R
         IVKHL4TacuuYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A93D7EAC081;
        Wed,  1 Jun 2022 22:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf, test_run: Remove unnecessary prog type checks
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165412381268.2260.5293996444739274612.git-patchwork-notify@kernel.org>
Date:   Wed, 01 Jun 2022 22:50:12 +0000
References: <0a9aaac329f76ddb17df1786b001117823ffefa5.1653855302.git.dxu@dxuuu.xyz>
In-Reply-To: <0a9aaac329f76ddb17df1786b001117823ffefa5.1653855302.git.dxu@dxuuu.xyz>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, linux-kernel@vger.kernel.org
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

On Sun, 29 May 2022 15:15:41 -0500 you wrote:
> These checks were effectively noops b/c there's only one way these
> functions get called: through prog_ops dispatching. And since there's no
> other callers, we can be sure that `prog` is always the correct type.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  net/bpf/test_run.c | 6 ------
>  1 file changed, 6 deletions(-)

Here is the summary with links:
  - [bpf-next] bpf, test_run: Remove unnecessary prog type checks
    https://git.kernel.org/bpf/bpf-next/c/330eb2a696f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


