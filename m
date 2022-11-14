Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A860628833
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 19:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbiKNSUS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 13:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236146AbiKNSUR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 13:20:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F3D22B;
        Mon, 14 Nov 2022 10:20:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 073306133B;
        Mon, 14 Nov 2022 18:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65E75C43143;
        Mon, 14 Nov 2022 18:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668450015;
        bh=i8IdxfVSE2gtQo4hkINlvCNXZD7kqjet/z+dlfrkTCQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BFzHyJhWrBCIgPHjHb3hsidspggI4bMje3RDCMUKlHDsEEKtlrS7GeomnZbl95Www
         VURi6KjNP8U+JFByi7OK9vPIw2QnJKFIy7ZBWqGbt0Vc1oX0+ATFg+DsD1H1UhnBnR
         bZmtPfuINJ9bL9lRTdj4UfsV0Uk/YF1WlvDz7GKPCTWlb4/sD86JXZmtPgaFjWxBmj
         tpx2PhPhDcG8Tmr0lcNVHZJz59pNAdODo/l+G/9eXbru7TBXT7fRiRnsvF8AeQ4qKQ
         C3GVlHYkkFLGz17hHejEzB2LuvJTJ2pI7PBxAGKQj+kLC2ugtL9C0R9z+6AYNP/kht
         yKwVruPMt6VOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47306E270C2;
        Mon, 14 Nov 2022 18:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 1/1] docs: fixup cpumap sphinx >= 3.1 warning
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166845001528.16608.11508706066376026924.git-patchwork-notify@kernel.org>
Date:   Mon, 14 Nov 2022 18:20:15 +0000
References: <20221113103327.3287482-1-mtahhan@redhat.com>
In-Reply-To: <20221113103327.3287482-1-mtahhan@redhat.com>
To:     Maryam Tahhan <mtahhan@redhat.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, jbrouer@redhat.com,
        thoiland@redhat.com, donhunte@redhat.com, akiyks@gmail.com
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun, 13 Nov 2022 05:33:27 -0500 you wrote:
> From: Maryam Tahhan <mtahhan@redhat.com>
> 
> Fixup bpf_map_update_elem() declaration to use a single line.
> 
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
> Reported-by: Akira Yokosawa <akiyks@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/1] docs: fixup cpumap sphinx >= 3.1 warning
    https://git.kernel.org/bpf/bpf-next/c/e662c7753668

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


