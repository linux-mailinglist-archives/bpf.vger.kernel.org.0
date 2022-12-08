Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEED1646646
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 02:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiLHBKT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 20:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHBKS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 20:10:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA3B8B1AA
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 17:10:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 666A461D1F
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 01:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B880CC433D6;
        Thu,  8 Dec 2022 01:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670461816;
        bh=QXl/bTRIuAPN1aO2e0cgTGuBLFmykZ0khwxMPfRw6Js=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cX+qfRglFffJb5DHKupqwtqGHPQcxRk8QJcpJGgGNBoVDCz0Y+q+XXWtPm2nAFzCc
         izcMBTQX0B2p5g+nY0iK9+PRvgM7QxSF9ygDrkyw7gnw2vR6vUipWILwnOI43eZh5w
         1wpW/bwqUeW25HBFqJVZAz3QCCtetBCYkQ8d5Xm8TphqalqF+01d6tqmJP/2gU3S9O
         qYHRxPOuffwTUEexANp1FNitx3h6Ji512dR/0ZWc344b6vQ9ySU5zRQNSRgjEt18Qf
         Bh1BK6k3YqfDCBF9sAlkhSvZHx43nioIxLF90SBaEErZLr4zHdivXxvYqq/bWKq9sc
         wc+2c+F8YtwnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E37CE4D02C;
        Thu,  8 Dec 2022 01:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 1/2] selftests/bpf: add generic BPF program
 tester-loader
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167046181664.23916.17685102360972752577.git-patchwork-notify@kernel.org>
Date:   Thu, 08 Dec 2022 01:10:16 +0000
References: <20221207201648.2990661-1-andrii@kernel.org>
In-Reply-To: <20221207201648.2990661-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, john.fastabend@gmail.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 7 Dec 2022 12:16:47 -0800 you wrote:
> It's become a common pattern to have a collection of small BPF programs
> in one BPF object file, each representing one test case. On user-space
> side of such tests we maintain a table of program names and expected
> failure or success, along with optional expected verifier log message.
> 
> This works, but each set of tests reimplement this mundane code over and
> over again, which is a waste of time for anyone trying to add a new set
> of tests. Furthermore, it's quite error prone as it's way too easy to miss
> some entries in these manually maintained test tables (as evidences by
> dynptr_fail tests, in which ringbuf_release_uninit_dynptr subtest was
> accidentally missed; this is fixed in next patch).
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/2] selftests/bpf: add generic BPF program tester-loader
    https://git.kernel.org/bpf/bpf-next/c/537c3f66eac1
  - [v2,bpf-next,2/2] selftests/bpf: convert dynptr_fail and map_kptr_fail subtests to generic tester
    https://git.kernel.org/bpf/bpf-next/c/26c386ecf021

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


