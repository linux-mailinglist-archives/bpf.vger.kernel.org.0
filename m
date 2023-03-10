Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58E16B4CF3
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 17:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjCJQ3K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 11:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjCJQ2s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 11:28:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC8612B3FB
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 08:25:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B05AFB82342
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 16:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51BD5C4339B;
        Fri, 10 Mar 2023 16:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678465219;
        bh=8t41AbpKwADZz5hBTm6hYwf4m//jGoYBZeIrke39k5s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ad0fGzDnbzfyBl4RSiAEtCXxXfyQfIvteBxxhD3Qy6deWn3KPPoumsCjxnbGqsGKa
         KX9Sq8mOvCNEUH+7KhRS7o87KnehoTVejZBbC6a9SBcy+QqAQ6vcSb5Zb4cfkX9lHN
         1vXhq5uN9yjpgd+nALFfA2Gpn41CtZ3s1qMf+POecly1xm/22uD7c2pqX5p+aswF1v
         5JYcnYiToRb04/3DhBkS8RxGKw4sHYc93q7nwOYsklCYq4qc3bYe11rIFxzQ88pTHk
         BXakaEcv824T47SViA3A0xBKpkIZhVaaDfoY0feps2vRDS/NkFfAK3hMaUdHXA9AEy
         m0k5Q5tHxxUlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37198E21EEB;
        Fri, 10 Mar 2023 16:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/4] selftests/bpf: make BPF_CFLAGS stricter with
 -Wall
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167846521921.31037.14904429312826497813.git-patchwork-notify@kernel.org>
Date:   Fri, 10 Mar 2023 16:20:19 +0000
References: <20230309054015.4068562-1-andrii@kernel.org>
In-Reply-To: <20230309054015.4068562-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@meta.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 8 Mar 2023 21:40:11 -0800 you wrote:
> Make BPF-side compiler flags stricter by adding -Wall. Fix tons of small
> issues pointed out by compiler immediately after that. That includes newly
> added bpf_for(), bpf_for_each(), and bpf_repeat() macros.
> 
> Andrii Nakryiko (4):
>   selftests/bpf: prevent unused variable warning in bpf_for()
>   selftests/bpf: add __sink() macro to fake variable consumption
>   selftests/bpf: fix lots of silly mistakes pointed out by compiler
>   selftests/bpf: make BPF compiler flags stricter
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/4] selftests/bpf: prevent unused variable warning in bpf_for()
    https://git.kernel.org/bpf/bpf-next/c/2498e6231bfd
  - [bpf-next,2/4] selftests/bpf: add __sink() macro to fake variable consumption
    https://git.kernel.org/bpf/bpf-next/c/713461b895ef
  - [bpf-next,3/4] selftests/bpf: fix lots of silly mistakes pointed out by compiler
    https://git.kernel.org/bpf/bpf-next/c/c8ed66859397
  - [bpf-next,4/4] selftests/bpf: make BPF compiler flags stricter
    https://git.kernel.org/bpf/bpf-next/c/3d5a55ddc255

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


