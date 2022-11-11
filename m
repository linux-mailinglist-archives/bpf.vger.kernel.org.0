Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB34626187
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 19:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbiKKSmo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 13:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbiKKSm0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 13:42:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832FB83B9D
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 10:40:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19B0762092
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 18:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A71DC433D7;
        Fri, 11 Nov 2022 18:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668192015;
        bh=ncPABe4Zdh+PkpnOBGMQRKKTFuLe8fQByu+JKhkQ1JE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=D7bTzOIkpDljYLDMQJdvIvRmZCdEQrJm1mYNjcGiIpMSQalect5eoNpDPJ8CSRjig
         s5BqG0xJx9gB2+zEpkDRR/pSkiqrYTYzrl3NzEErtrIedXIeEGaBlrnDEi6W34B4hR
         taMa8mpPmDGDeCHcSGnrcj8gDXdka7wONxQdeGzZ4sdiZavdrTQWinDUjxq4rArnTK
         dRAT5HrW1dU0kfrIUUFozpmBgj7Q1UCcAjB3MKItWoX+a9z63WGQnT5a3zB8ziosVC
         wQ+vnKC0lo7bBy9A5KwnPH0ECD1iz/W0w/YOHzysrKL2v7eiBIN8wCC61nJioNBMDk
         t4DhsohVl7lNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4DD9CE270EF;
        Fri, 11 Nov 2022 18:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: hashmap.h update to fix build issues using
 LLVM14
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166819201531.3747.11542448346995110143.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Nov 2022 18:40:15 +0000
References: <20221110223240.1350810-1-eddyz87@gmail.com>
In-Reply-To: <20221110223240.1350810-1-eddyz87@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com, lkp@intel.com
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
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 11 Nov 2022 00:32:40 +0200 you wrote:
> A fix for the LLVM compilation error while building bpftool.
> Replaces the expression:
> 
>   _Static_assert((p) == NULL || ...)
> 
> by expression:
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: hashmap.h update to fix build issues using LLVM14
    https://git.kernel.org/bpf/bpf-next/c/42597aa372f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


