Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981366F1141
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 07:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjD1FKX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 01:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjD1FKW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 01:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FBDE68
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 22:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E60086351D
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 05:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41904C433D2;
        Fri, 28 Apr 2023 05:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682658620;
        bh=t852FZJE3qk0oo0eKUnxs574BY34/MqLTQ8PYWHb8No=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pJhwvaDjgJNlL8Be81WzgFDVl5jr1iN8iP/9uGs1ZfIR+/H2w0clyFUS9Ty1j90u0
         lLp9ZGMGEVsrut267fUTFVCYzWA9jBGLQ2X3nbHHfybGRWgNpm5IUxPAqQgnMIUfZE
         NhWQ975CPaehRt/lYVR/kEG+Pjbqd5/V7eO6AD0Rv+MoVnEHDdjPftCs2q9OFWYUdQ
         teUSNwy7L4H4MqZv5on3eQbhv4gWtS+Zjz6vdqnQUWdmhl9sC5Y7XihIUPZrm1FifQ
         Ud1moRIxrd1ryrXbOWhgLUwcBV/ZYc+0/ZUQ3cb/IpX1LcDlGHMKLwtkYx9un4NngU
         e8DpA2+tdj91A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D10EC3959F;
        Fri, 28 Apr 2023 05:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Add fexit_sleep to DENYLIST.aarch64
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168265862011.10833.13090252703731494840.git-patchwork-notify@kernel.org>
Date:   Fri, 28 Apr 2023 05:10:20 +0000
References: <20230428034726.2593484-1-martin.lau@linux.dev>
In-Reply-To: <20230428034726.2593484-1-martin.lau@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@meta.com, chantra@meta.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 27 Apr 2023 20:47:26 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> It is reported that the fexit_sleep never returns in aarch64.
> The remaining tests cannot start. Put this test into DENYLIST.aarch64
> for now so that other tests can continue to run in the CI.
> 
> Reported-by: Manu Bretelle <chantra@meta.com>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Add fexit_sleep to DENYLIST.aarch64
    https://git.kernel.org/bpf/bpf-next/c/af781ba682e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


