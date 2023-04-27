Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C8F6F0DD1
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 23:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343716AbjD0VuV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 17:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD0VuU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 17:50:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D6E2D5B
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 14:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD5A463FA4
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 21:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07098C433EF;
        Thu, 27 Apr 2023 21:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682632219;
        bh=TiJHfP1jfbrKcuhR8Igm01wGgzBceZzu5pzwQLXtCQo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YXdOh5vyNNgd8+w6FtOa2yhgHO/XUQard4WpwIyeSa4u2YIEFIbx/+CxAZTq4mA8Q
         WUTLkwQrOSlf4M2HS/HC6oRpxyPmzjo6i+tkW9oIP4fVgJkZFuosQiZqGWZTA9UFy2
         Tzsjalamz6L16zJRDjWeA/2890kMqUdjixDgrm+UMzolbvsHS2Vv7Y/QhV1nQjYWu9
         F1c1/dXuXm0+ibVsP09J17EOkT3ryKy+8SEagSo28NZvgw0k8LIvaUHiehzC0FI/Y2
         coU0wclnmMAk0bbVJb3rexyopj1D9TvxlajyY7Ub0UOgBkaO3bgJwVVtoedEzKCQFq
         0RArEr2PnUWKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D45BDE5FFC8;
        Thu, 27 Apr 2023 21:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix selftest
 test_global_funcs/global_func1 failure with latest clang
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168263221886.23242.8794326015147121830.git-patchwork-notify@kernel.org>
Date:   Thu, 27 Apr 2023 21:50:18 +0000
References: <20230425174744.1758515-1-yhs@fb.com>
In-Reply-To: <20230425174744.1758515-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org
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
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 25 Apr 2023 10:47:44 -0700 you wrote:
> The selftest test_global_funcs/global_func1 failed with the latest clang17.
> The reason is due to upstream ArgumentPromotionPass ([1]),
> which may manipulate static function parameters and cause inlining
> although the funciton is marked as noinline.
> 
> The original code:
>   static __attribute__ ((noinline))
>   int f0(int var, struct __sk_buff *skb)
>   {
>         return skb->len;
>   }
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix selftest test_global_funcs/global_func1 failure with latest clang
    https://git.kernel.org/bpf/bpf-next/c/f1f5553d91a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


