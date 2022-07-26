Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D71E5811D1
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 13:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238829AbiGZLUR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 07:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238600AbiGZLUQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 07:20:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAE031A
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 04:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D3B26130A
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 11:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B858C341D0;
        Tue, 26 Jul 2022 11:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658834414;
        bh=+JXxisR+s0o3iTzz3hbGIFTmAzraCAY5EAnlxrnB3WA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rTrCv6ASY5vSUgfKHxYPyrRyBHwvihbsWYMtfZTvq/IZwJg56KGEXe2TN883Nemly
         n6niHFi9XIX9Vo4qPHZyUjDt1BTZXYf6GOpqyHO9vIVsu7bfUU9g78OALGTVTCiN6U
         4RWsoRzrYsbENnnCbUhlGbtIGj7/hpmiEgRTjASrPPf+kE7T1zGDasAKswjqMeYYJ4
         LuFRPtNXnGxBXBrU5KUkaPF7dqUxHbNFhmrNTVknkwVhlTsANhWqL4KG9pTrOKoF+C
         XzxwpnNS2jYsG6rULq7fOtejJzUx0vZoEog3tRYhnrfQenb3ED/wpuPM8R+TJycgs4
         4oLjibQcH+emw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50ACDE450B7;
        Tue, 26 Jul 2022 11:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 1/1] bpf: Fix bpf_xdp_pointer return pointer
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165883441432.20862.15416029011190400715.git-patchwork-notify@kernel.org>
Date:   Tue, 26 Jul 2022 11:20:14 +0000
References: <20220722220105.2065466-1-joannelkoong@gmail.com>
In-Reply-To: <20220722220105.2065466-1-joannelkoong@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, lorenzo@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, ast@kernel.org
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 22 Jul 2022 15:01:05 -0700 you wrote:
> For the case where offset + len == size, bpf_xdp_pointer should return a
> valid pointer to the addr because that access is permitted. We should
> only return NULL in the case where offset + len exceeds size.
> 
> Fixes: 3f364222d032 ("net: xdp: introduce bpf_xdp_pointer utility routine")
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/1] bpf: Fix bpf_xdp_pointer return pointer
    https://git.kernel.org/bpf/bpf-next/c/bbd52178e249

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


