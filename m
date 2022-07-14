Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AD157514B
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 17:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238780AbiGNPAR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 11:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238568AbiGNPAQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 11:00:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AAD2AE13;
        Thu, 14 Jul 2022 08:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C143761EB6;
        Thu, 14 Jul 2022 15:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A1C2C385A2;
        Thu, 14 Jul 2022 15:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657810815;
        bh=R+qJYsXeO4VPKnKzbC6ePW1RszlSU5kzXy/j+1wtGL8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pBbPobjqiHhMQErWCWv/hnEuLAcveWa9R/8G0gYHwc30+25M7DqDQf6oXJP4U7ApZ
         Hr5M3dHscly6S+7EbduaXAxIul2kQPxX0wGDQzcsLu6PwlGS5xIviuQfS5cSBU21YS
         BHC8S9lborX6i1Lw/jvOYY1VTNn8YevN8M6OfDfsoYr59iTUB6ifhl2Kt9jzOHe4lU
         TqscNzet2fcyAT/RtaxsxuvNSl1f0iOo5whLzyjIh7Mb0Ke+Jhq4jgWWLNfkw6VUFI
         a2HBsRtJMOUHkMdGwWtM1pBHMndtd0R944xSfjGDus52GP2bXIkWr2zuW01qQeQFKD
         Th2eiDQUEHw+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC13EE45228;
        Thu, 14 Jul 2022 15:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf, arm64: Mark dummy_tramp as global
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165781081489.29992.6920779338134686620.git-patchwork-notify@kernel.org>
Date:   Thu, 14 Jul 2022 15:00:14 +0000
References: <20220713173503.3889486-1-nathan@kernel.org>
In-Reply-To: <20220713173503.3889486-1-nathan@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, zlim.lnx@gmail.com,
        xukuohai@huawei.com, ndesaulniers@google.com, trix@redhat.com,
        bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, samitolvanen@google.com
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 13 Jul 2022 10:35:03 -0700 you wrote:
> When building with clang + CONFIG_CFI_CLANG=y, the following error
> occurs at link time:
> 
>   ld.lld: error: undefined symbol: dummy_tramp
> 
> dummy_tramp is declared globally in C but its definition in inline
> assembly does not use .global, which prevents clang from properly
> resolving the references to it when creating the CFI jump tables.
> 
> [...]

Here is the summary with links:
  - bpf, arm64: Mark dummy_tramp as global
    https://git.kernel.org/bpf/bpf-next/c/33f32e5072b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


