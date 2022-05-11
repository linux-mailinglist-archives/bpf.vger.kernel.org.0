Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082EE523D2A
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 21:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbiEKTKQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 15:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238585AbiEKTKP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 15:10:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA056FA04
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 12:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A911DB8235D
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 19:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4ED8AC34100;
        Wed, 11 May 2022 19:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652296212;
        bh=TK+/u7HCJAJEAymZ9t7MzRpPJpp3idZHf5NQ4eCHIys=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UsJS+FJ3RywcUsRjtJXzVLQytEtVdA45qE/nF+6CEJp7/xHUjRDZ/5+Cva5zE/sU/
         4TMbjVy8Br0kAinXpYSFRawcCNtr4H4LxWJdXxDqQMv9hHZt52P+mt8+f6RIh5EAGC
         Zd0+cFsgxGKW169C9JAfbLom6h27mcJEmJcvk+L6Vjo2Dd/McYprvYOHEKW1/AGcQ8
         MSrwivHpjJlQ3SWBxtMQ7hG1rYVh+kXaNmsV0+Sot/WUpQcc23WPCCJaKsRGoOVWMS
         8atRwrgNZjgjDqyS2N4se3mRMRzi5R6suA9PHwZg2RM0oTCx+dJwiGKP3HYPXQBmcb
         YozB2Jw06LiNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A818F03931;
        Wed, 11 May 2022 19:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] Enable CONFIG_FPROBE for self tests
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165229621216.7050.4235763611551261959.git-patchwork-notify@kernel.org>
Date:   Wed, 11 May 2022 19:10:12 +0000
References: <20220511172249.4082510-1-deso@posteo.net>
In-Reply-To: <20220511172249.4082510-1-deso@posteo.net>
To:     =?utf-8?q?Daniel_M=C3=BCller_=3Cdeso=40posteo=2Enet=3E?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
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
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 11 May 2022 17:22:49 +0000 you wrote:
> Some of the BPF selftests are failing when running with a rather bare
> bones configuration based on tools/testing/selftests/bpf/config.
> Specifically, we see a bunch of failures due to errno 95:
> 
>   > test_attach_api:PASS:fentry_raw_skel_load 0 nsec
>   > libbpf: prog 'test_kprobe_manual': failed to attach: Operation not supported
>   > test_attach_api:FAIL:bpf_program__attach_kprobe_multi_opts unexpected error: -95
>   > 79 /6     kprobe_multi_test/attach_api_syms:FAIL
> 
> [...]

Here is the summary with links:
  - [bpf-next] Enable CONFIG_FPROBE for self tests
    https://git.kernel.org/bpf/bpf-next/c/998e1869de1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


