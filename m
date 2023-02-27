Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BB86A4919
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 19:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjB0SDG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 13:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjB0SCx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 13:02:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D62F2107;
        Mon, 27 Feb 2023 10:01:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0894B60EA4;
        Mon, 27 Feb 2023 18:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66910C4339B;
        Mon, 27 Feb 2023 18:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677520817;
        bh=YrdsB4NMFLBJqbnHWTj3IOoIar8lQojVnXNhGMSS+JQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FhaTOemhZSayFBMe2RaeAyxBmUBxS4oYPHl2ejdqok14ynlgUo8PWsUkrkLRIKAyS
         xIq3N3gaF5m4QndmAF/kC1Wg1JHOFLZ2XhQP8wRSzOBHAU9B1UQfYI01cFz9igKWdx
         gjW+gHVUFXAi+oAPfyX9rQhaG/KoUhYy7dCErbqBVY3jSbsMvir7pVX/GMCXyt1sJE
         IY/+tKHhy75VU5iqdYD/GUZHLDo0V3TGGbsXv4Vra4Umaly0cdvUpCLBg5/a8bzXDU
         1kN/wauBf/ODz3j9pXqVSfjWJxTyo7hHLTmUlJqByMzoCWQWf/dg5q99i8CP5Uu0zJ
         exzLq/YagLUGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E0B2E68D2D;
        Mon, 27 Feb 2023 18:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] Fix some build errors for bpf selftest on
 LoongArch
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167752081731.14731.11660038530878470104.git-patchwork-notify@kernel.org>
Date:   Mon, 27 Feb 2023 18:00:17 +0000
References: <1677235015-21717-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1677235015-21717-1-git-send-email-yangtiezhu@loongson.cn>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
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
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 24 Feb 2023 18:36:52 +0800 you wrote:
> v2: Modify patch #3 to avoid breaking user_ringbuf test on x86
> 
> Tiezhu Yang (3):
>   libbpf: Use struct user_pt_regs to define __PT_REGS_CAST() for
>     LoongArch
>   selftests/bpf: Check __TARGET_ARCH_loongarch if target is bpf for
>     LoongArch
>   selftests/bpf: Use __NR_prlimit64 instead of __NR_getrlimit in
>     user_ringbuf test
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] libbpf: Use struct user_pt_regs to define __PT_REGS_CAST() for LoongArch
    https://git.kernel.org/bpf/bpf-next/c/29c66ad1c3ad
  - [bpf-next,v2,2/3] selftests/bpf: Check __TARGET_ARCH_loongarch if target is bpf for LoongArch
    (no matching commit)
  - [bpf-next,v2,3/3] selftests/bpf: Use __NR_prlimit64 instead of __NR_getrlimit in user_ringbuf test
    https://git.kernel.org/bpf/bpf-next/c/84c22fa83f9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


