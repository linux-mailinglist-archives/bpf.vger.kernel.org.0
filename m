Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203EB58EEE6
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 17:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiHJPAT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 11:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiHJPAS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 11:00:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD3165EB;
        Wed, 10 Aug 2022 08:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6E9DB81CEF;
        Wed, 10 Aug 2022 15:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DCCEC433D7;
        Wed, 10 Aug 2022 15:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660143614;
        bh=x6K4He4gWVxz2vTCW1AFl5XEkaP57fSN/ZbNcBaWxoQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=m3UkrU4WD3xeI8ezpnh5Pu44LN9gmuTOktplx5hcyCnqDRh5vQPNVGGQxPnYkzTuW
         6e/PGGWWzaOVEsIuNkkW3j6BIKkoWJcIzcKyUWY11FLW6wpilfQhvfJqvuEguSg/KI
         bXT3XfRM1FXAELruAt/YLEXtbFnxfHh82Wb3Sg60knhs93sKQiObXtCLrSWSzOb+lY
         fQY7c5uOMaLl4LUQQihfz5yMvGlut1Rn55mbroiLmvHAXJlwq4Tm6NhtJBZ/LVCWrE
         4AQtmsM1/X/rjKERqlGv6dJXXut4HxnABHd+X/jWAQ+gGVBgVZOz9fXCg/nrZ8QDuP
         YRkvFz9NA+kSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BB1AC43143;
        Wed, 10 Aug 2022 15:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf, arm64: Fix bpf trampoline instruction endianness
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166014361423.11049.14659962620709690422.git-patchwork-notify@kernel.org>
Date:   Wed, 10 Aug 2022 15:00:14 +0000
References: <20220808040735.1232002-1-xukuohai@huawei.com>
In-Reply-To: <20220808040735.1232002-1-xukuohai@huawei.com>
To:     Xu Kuohai <xukuohai@huawei.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com,
        kbuild-all@lists.01.org, daniel@iogearbox.net,
        jean-philippe@linaro.org
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

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 8 Aug 2022 00:07:35 -0400 you wrote:
> The sparse tool complains as follows:
> 
> arch/arm64/net/bpf_jit_comp.c:1684:16:
> 	warning: incorrect type in assignment (different base types)
> arch/arm64/net/bpf_jit_comp.c:1684:16:
> 	expected unsigned int [usertype] *branch
> arch/arm64/net/bpf_jit_comp.c:1684:16:
> 	got restricted __le32 [usertype] *
> arch/arm64/net/bpf_jit_comp.c:1700:52:
> 	error: subtraction of different types can't work (different base
> 	types)
> arch/arm64/net/bpf_jit_comp.c:1734:29:
> 	warning: incorrect type in assignment (different base types)
> arch/arm64/net/bpf_jit_comp.c:1734:29:
> 	expected unsigned int [usertype] *
> arch/arm64/net/bpf_jit_comp.c:1734:29:
> 	got restricted __le32 [usertype] *
> arch/arm64/net/bpf_jit_comp.c:1918:52:
> 	error: subtraction of different types can't work (different base
> 	types)
> 
> [...]

Here is the summary with links:
  - [bpf] bpf, arm64: Fix bpf trampoline instruction endianness
    https://git.kernel.org/bpf/bpf/c/aada47665546

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


