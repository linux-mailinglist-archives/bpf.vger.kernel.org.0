Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4146068FC50
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 02:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjBIBA2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 20:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjBIBAW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 20:00:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEAF234DE;
        Wed,  8 Feb 2023 17:00:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B2DA61852;
        Thu,  9 Feb 2023 01:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CD43C433D2;
        Thu,  9 Feb 2023 01:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675904417;
        bh=kKZbJKq68HUD3fPiTrbY14WyTPSgVoe/5F6U8VCnGjA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Wze7jVPp6F6+sChkuLbqTfB13dj2MO6yElX0WzIuwMcUhOJuisNUOpzR4EPdcqt/X
         IEtfPb6TaGbAe91gRAeftF0mQdUXhOVsBG7ARjs7gBOGb2DjM48bfYbOfeaeEWTdls
         TRQCSmq3hNy8juuWqYrW9/YJPbu8WJHTMRCeBr74JudRi1c5YoFMssKyPRMM2YyEnc
         JB3Mv3zuea/cDM/BHxIwWKw3LoICmAJ10dyXSoU81b6pqyRNQ2lU6zHqLCrxMXW8M5
         acmec3uR+hHC3Y2pM204kY6dVH91j9x8Z+uuKsaqhnBKTAaUFSepJH0QUB2147Ox77
         Bbwn3b2/sS80Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 819CAE50D62;
        Thu,  9 Feb 2023 01:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] samples: bpf: syscall_tp: Add syscall openat2
 enter/exit tracepoint
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167590441752.22544.17049705662314833420.git-patchwork-notify@kernel.org>
Date:   Thu, 09 Feb 2023 01:00:17 +0000
References: <tencent_9381CB1A158ED7ADD12C4406034E21A3AC07@qq.com>
In-Reply-To: <tencent_9381CB1A158ED7ADD12C4406034E21A3AC07@qq.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     ast@kernel.org, rongtao@cestc.cn, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
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

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  8 Feb 2023 09:04:41 +0800 you wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> commit fe3300897cbf("samples: bpf: fix syscall_tp due to unused syscall")
> add openat() syscall trapoints, this submit support openat2().
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] samples: bpf: syscall_tp: Add syscall openat2 enter/exit tracepoint
    https://git.kernel.org/bpf/bpf-next/c/06744f24696e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


