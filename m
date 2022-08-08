Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFE958D014
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 00:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbiHHWUS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 18:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiHHWUR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 18:20:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B141DFEF
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 15:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A96DB810DB
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 22:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B467C433B5;
        Mon,  8 Aug 2022 22:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659997214;
        bh=tXVPJUFhrT/paA3P9qsSRXg/HcSRpVWvBqTybF2Uj0Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=S2+gqR0m2e4f8FH6RzeoF0PNyEwSp+zf6iKevda82KmzitC+xcy2Ylwl0fWzPjPTF
         8qiV2x5IWZCUPJ/JmxKbyibaYfEfuVvz3QnMARKv5oMOyLVj3chkc7FGpYZUJXAZh6
         SdQy46GqW3N6uwjCwZoUnVSZ9cDJSIrpqcfr8Ph1EwAbl2sElgtLW4TvauESsGG/3p
         9hk58LfgCifzP4Cw3pnUUvr7ks+tkWd/RWH2CU4aokd2SsHSD+YGYNoAOn7gZ+8Iix
         gwnvuUsMtMk/pJO9NJjdseKt90hwmh8yRwEYJrtqg+2pc4GMCSTWGKTnLcJTsC0Y7T
         NeU1G8VdCPr0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E430EC43140;
        Mon,  8 Aug 2022 22:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Improve docstring for BPF_F_USER_BUILD_ID flag
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165999721393.22650.17849612213445584107.git-patchwork-notify@kernel.org>
Date:   Mon, 08 Aug 2022 22:20:13 +0000
References: <20220808164723.3107500-1-davemarchevsky@fb.com>
In-Reply-To: <20220808164723.3107500-1-davemarchevsky@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, kernel-team@fb.com,
        slinger@fb.com
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

On Mon, 8 Aug 2022 09:47:23 -0700 you wrote:
> Most tools which use bpf_get_stack or bpf_get_stackid symbolicate the
> stack - meaning the stack of addresses in the target process' address
> space is transformed into meaningful symbol names. The
> BPF_F_USER_BUILD_ID flag eases this process by finding the build_id of
> the file-backed vma which the address falls in and translating the
> address to an offset within the backing file.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Improve docstring for BPF_F_USER_BUILD_ID flag
    https://git.kernel.org/bpf/bpf-next/c/ca34ce29fc4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


