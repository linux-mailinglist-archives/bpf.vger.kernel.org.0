Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453DA57D6E1
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 00:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiGUWaR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 18:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiGUWaQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 18:30:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55235255A7;
        Thu, 21 Jul 2022 15:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E614B61E23;
        Thu, 21 Jul 2022 22:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A311C341C6;
        Thu, 21 Jul 2022 22:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658442614;
        bh=M0NrkebK2nQP0JGmkZ9AAOBaRfwlQ/U1x2M+0d/KGDg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=t0z3M3FFxRHXl/w/6d+7GkvE+1zBhALq6THo1wBc19+PoHnFtsEX6da2QiTZOX0tw
         cSELw/t5YrtJIsRmebXHIxF2r8lraAYAgz3PfObcyxVaE6rVylYUqigjJ33nKNa7tB
         ZV/UrDKDGjAxYNV1RBkoBCnPNFWg4xgrjoL6/rRpcWTHJeymjnUsioEbkADkWg7/qu
         Syagcg46coCu9s4TL6gkYpixpCFKSMZQHdVI9/YX1FN7vq4MacMmg0/Zkl8IwbjhJ2
         zIup9sHjo4MW9PnSvqV6Na06JwMp5yRY6huDIpVFN9ntboRs3JYEXDaGbCP2Dq93Qj
         iIaocsVrTPgdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15049E451B9;
        Thu, 21 Jul 2022 22:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf, arm64: Fix compile error in dummy_tramp()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165844261408.3850.10654235868584356143.git-patchwork-notify@kernel.org>
Date:   Thu, 21 Jul 2022 22:30:14 +0000
References: <20220721121319.2999259-1-xukuohai@huaweicloud.com>
In-Reply-To: <20220721121319.2999259-1-xukuohai@huaweicloud.com>
To:     Xu Kuohai <xukuohai@huaweicloud.com>
Cc:     bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        catalin.marinas@arm.com, daniel@iogearbox.net, haoluo@google.com,
        jakub@cloudflare.com, jean-philippe@linaro.org, jolsa@kernel.org,
        john.fastabend@gmail.com, jonathanh@nvidia.com, kpsingh@kernel.org,
        martin.lau@linux.dev, song@kernel.org, sdf@google.com,
        will@kernel.org, yhs@fb.com, zlim.lnx@gmail.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 21 Jul 2022 08:13:19 -0400 you wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> dummy_tramp() uses "lr" to refer to the x30 register, but some assembler
> does not recognize "lr" and reports a build failure:
> 
> /tmp/cc52xO0c.s: Assembler messages:
> /tmp/cc52xO0c.s:8: Error: operand 1 should be an integer register -- `mov lr,x9'
> /tmp/cc52xO0c.s:7: Error: undefined symbol lr used as an immediate value
> make[2]: *** [scripts/Makefile.build:250: arch/arm64/net/bpf_jit_comp.o] Error 1
> make[1]: *** [scripts/Makefile.build:525: arch/arm64/net] Error 2
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, arm64: Fix compile error in dummy_tramp()
    https://git.kernel.org/bpf/bpf-next/c/339ed900b307

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


