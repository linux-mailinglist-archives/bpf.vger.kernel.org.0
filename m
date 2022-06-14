Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC3A54B40A
	for <lists+bpf@lfdr.de>; Tue, 14 Jun 2022 17:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239186AbiFNPAV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jun 2022 11:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347514AbiFNPAT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jun 2022 11:00:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9112432EE4
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 08:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 350A0B8197D
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 15:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3BD5C341C8;
        Tue, 14 Jun 2022 15:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655218813;
        bh=81f/6E2D/+VvzHSSilJoBBmXwSyZMtIXiObBWKvYZsM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UVeEPCCvpHOL08C/OEgDROu85I3b2PXyv9MaXKvHdWSlcJciPWjtdIF01YFBd2bnm
         ig0Lrr2C8XmJIgcV4BL+Kt6UxSa0T6wbO0WsJgBUNeGsIk2nemEH/+a00whAITnoSJ
         ryasHRSRFhs4ltrOw0GxkuBPNEOyRl346L3YbzQVA2S7Y2emyNcJlQMPU0D6TMBrdv
         AoTR2COz6gkRWkJsuD9tX0N1a6gcG2VM4bFL0nRYyfKNH/xpq3qVs85e9jHDOwd5ya
         NoeVLYRZEZ7acwMxkFrQGZjqpe/JQf4oJXZHe07OZYTjk//DNcokdeQ7AI1FDsZzTr
         96i0yu9hYcHoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BAE4AFD99FF;
        Tue, 14 Jun 2022 15:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: fix spelling in bpf_verifier.h
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165521881376.16120.14765344364029939449.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Jun 2022 15:00:13 +0000
References: <20220613211633.58647-1-jwnhy0@gmail.com>
In-Reply-To: <20220613211633.58647-1-jwnhy0@gmail.com>
To:     john <jwnhy0@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        bpf@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Mon, 13 Jun 2022 21:16:33 +0000 you wrote:
> From: Hongyi Lu <jwnhy0@gmail.com>
> 
> 6689139af (HEAD -> master) fix spelling in bpf_verifier.h
> Spelling is no big deal, but it is still an improvement.
> This is my first patch as a newbie. Hope I didn't cause much trouble.
> 
> Signed-off-by: Hongyi Lu <jwnhy0@gmail.com>
> 
> [...]

Here is the summary with links:
  - bpf: fix spelling in bpf_verifier.h
    https://git.kernel.org/bpf/bpf-next/c/6dbdc9f35360

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


