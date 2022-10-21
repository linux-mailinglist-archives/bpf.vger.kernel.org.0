Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452D160820F
	for <lists+bpf@lfdr.de>; Sat, 22 Oct 2022 01:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJUXaf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 19:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiJUXa3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 19:30:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458E8A99E0
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 16:30:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A6B2B80D59
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 23:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A420C433B5;
        Fri, 21 Oct 2022 23:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666395022;
        bh=9YjBqzO7yaAyBOQboTqKJCBaT1EVl9HybY2S5a+66pw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Qe1wPyexfa7AmT3ePkloRpzIS9t7RE5QfXBUm0szVFAGd9hdX5NCFKwxfBqCfvUES
         Ik938zxg4NSU6oIvPteIn0459nc9xK6bfPLIBYCTuB3WGZXglsx06KkA15T9De8f2X
         rX0w6e/Quicj6/L5DWmSp4DQevMgCtD34Ua+rVhqRBxtSVM5YuLqOuN2WZSWNd+edJ
         WKKPCGitsSad6zCDekqYyuc3jT/LttAB/gXF1picLSjEYeZ2jBPQCyzmVKzkxXDO+7
         QAG3oT7lU4H0cUCoXG+aNIZAl/sdYUuJjy/qLQNt0YLeINpfUy2vLRlWtk1qGO5Z0I
         q7WKOYsWssx4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A1DEE270E2;
        Fri, 21 Oct 2022 23:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/4] Add support for aarch64 to
 selftests/bpf/vmtest.sh
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166639502210.16988.4357978055876799242.git-patchwork-notify@kernel.org>
Date:   Fri, 21 Oct 2022 23:30:22 +0000
References: <20221021210701.728135-1-chantr4@gmail.com>
In-Reply-To: <20221021210701.728135-1-chantr4@gmail.com>
To:     Manu Bretelle <chantr4@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, mykolal@fb.com,
        daniel@iogearbox.net, martin.lau@linux.dev, yhs@fb.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 21 Oct 2022 14:06:57 -0700 you wrote:
> This patchset adds initial support for running BPF's vmtest on aarch64
> architecture.
> It includes a `config.aarch64` heavily based on `config.s390x`
> Makes vmtest.sh handle aarch64 and set QEMU variables to values that
> works on that arch.
> Finally, it provides a DENYLIST.aarch64 that takes care of currently
> broken tests on aarch64 so the vmtest run passes.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/4] selftests/bpf: Remove entries from config.s390x already present in config
    https://git.kernel.org/bpf/bpf-next/c/7a42af4b94f1
  - [bpf-next,2/4] selftests/bpf: Add config.aarch64
    https://git.kernel.org/bpf/bpf-next/c/ec99451f0a48
  - [bpf-next,3/4] selftests/bpf: Update vmtests.sh to support aarch64
    https://git.kernel.org/bpf/bpf-next/c/20776b72ae2a
  - [bpf-next,4/4] selftests/bpf: Initial DENYLIST for aarch64
    https://git.kernel.org/bpf/bpf-next/c/94d52a191807

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


