Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91626571175
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 06:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiGLEaS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 00:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiGLEaR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 00:30:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0635B201AE;
        Mon, 11 Jul 2022 21:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33DD9B81655;
        Tue, 12 Jul 2022 04:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0173C341C0;
        Tue, 12 Jul 2022 04:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657600213;
        bh=2O9oCOtLhZK7N0Ps3fdnTGG2yPfJtsX/AEI7XcdxC9g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Bt7E8IgW1ycvTXur177rFtbrkEzjJap9n2YfadD6YnyKLYLjc7LyfzThYwbmaQbqW
         oj2vRAsogQ6uSNijiW1uB2v8BM2of4BwLEq8qp8PFUB2t9Gs8bgGaSB+alLvdXGhlN
         pQHLBtGmji8vXvKJmZ28Q9rz5T1xxIUPK/7YQ2IUl1STC588A1ZBPHY8CDd2DHamGg
         xaTxj+Zsgr0m7gGtq+NaN9xjSw+QIWvWVHYkKbND529ivGfsQWrlSrHvyxtGSIbzJ8
         jyXrwPT8FZ777ef5IML8kpMvppPZYP1AxND410xhyA0gGxIdrmvtaUKFfz93ZQxX4S
         sBveeyrE2vMWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B403EE45221;
        Tue, 12 Jul 2022 04:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Fix 'dubious one-bit signed bitfield'
 warnings
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165760021373.564.7413956884709981206.git-patchwork-notify@kernel.org>
Date:   Tue, 12 Jul 2022 04:30:13 +0000
References: <20220711081200.2081262-1-matthieu.baerts@tessares.net>
In-Reply-To: <20220711081200.2081262-1-matthieu.baerts@tessares.net>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, eddyz87@gmail.com,
        mptcp@lists.linux.dev, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
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
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 11 Jul 2022 10:12:00 +0200 you wrote:
> Our CI[1] reported these warnings when using Sparse:
> 
>   $ touch net/mptcp/bpf.c
>   $ make C=1 net/mptcp/bpf.o
>   net/mptcp/bpf.c: note: in included file:
>   include/linux/bpf_verifier.h:348:26: error: dubious one-bit signed bitfield
>   include/linux/bpf_verifier.h:349:29: error: dubious one-bit signed bitfield
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Fix 'dubious one-bit signed bitfield' warnings
    https://git.kernel.org/bpf/bpf-next/c/f16214c102f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


