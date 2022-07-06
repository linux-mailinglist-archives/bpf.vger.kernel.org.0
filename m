Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50975568BA9
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 16:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbiGFOuV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 10:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiGFOuU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 10:50:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ECC22B21
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 07:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91D1AB81D4D
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 14:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42054C341D0;
        Wed,  6 Jul 2022 14:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657119017;
        bh=rK/QW24E9QaND28jNsUibvoy85Tg1vtAEWKTbebM2mY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BtCpzlD7lSeG3zjD68dcLEM8pafzyJLZ0g/7Gvuk9gjoUtZFe3YQFa/KIyf+AeowI
         ijTzhXuBLEXEp7hcBXB48BAIFLlqxrxzhdemQB7VHl8mNd8V1+/xrCBSyFjRugru/T
         xeSAZ7y8FNprQCQNBbIlcJv0tvlmBgjKDwtlbQfovCZEfSrLW2pQaArH3CSuBTHEtN
         47RyCsrYk2sRdnXi76crfcdQketymeAn0QhkTv/BoMxu4nD4/pYJmKBHeRoJizapTy
         UctbVVBffJmd5abErfXTN4hmvG4hbf5q12rKz8g5YKWQgzZMDFNibO9GI7Wzsa9J2N
         XbwaLDt2LaXxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2660AE45BDF;
        Wed,  6 Jul 2022 14:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] Fix few compiler warnings in selftests and
 libbpf
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165711901715.17272.10185659235288232043.git-patchwork-notify@kernel.org>
Date:   Wed, 06 Jul 2022 14:50:17 +0000
References: <20220705224818.4026623-1-andrii@kernel.org>
In-Reply-To: <20220705224818.4026623-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 5 Jul 2022 15:48:15 -0700 you wrote:
> Few small patches fixing compiler warning issues detected by Coverity or by
> building selftests in -O2 mode.
> 
> Andrii Nakryiko (3):
>   selftests/bpf: fix bogus uninitialized variable warning
>   selftests/bpf: fix few more compiler warnings
>   libbpf: remove unnecessary usdt_rel_ip assignments
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] selftests/bpf: fix bogus uninitialized variable warning
    https://git.kernel.org/bpf/bpf-next/c/645d5d3bc001
  - [bpf-next,2/3] selftests/bpf: fix few more compiler warnings
    https://git.kernel.org/bpf/bpf-next/c/c46a12200114
  - [bpf-next,3/3] libbpf: remove unnecessary usdt_rel_ip assignments
    https://git.kernel.org/bpf/bpf-next/c/7c8121af1bfe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


