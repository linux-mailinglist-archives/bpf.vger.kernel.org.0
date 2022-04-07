Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119704F89E9
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 00:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiDGVmU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Apr 2022 17:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiDGVmR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Apr 2022 17:42:17 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEF82A4
        for <bpf@vger.kernel.org>; Thu,  7 Apr 2022 14:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 578FBCE29D7
        for <bpf@vger.kernel.org>; Thu,  7 Apr 2022 21:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81826C385A8;
        Thu,  7 Apr 2022 21:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649367612;
        bh=6VJXSna4wPuVy14aEE/8BWSwMJ/wAViYJpjZ3gf1Kcg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AX2wS6o8iNEYMaWSi/fYig8vMNw38Qpm0Y8gFauQC/Cs28KrofdB0vxgGDgznbdY0
         udeFmumUym6HMQ7mVnLntPqRk/At/na/u1Hv49aDMmEmJ9h+cb7Cot7vG1qxMYmnnl
         4vAVktzfK1bmV3+MEu1gebcfwzTEC2JVcvHTGiVJiXq8MWVziPHQsW3MD5sQWfhEr6
         DkujG+x0P9RwfVHaGkpCO1z9X2o6WJdfNUj19xsDghHCSSLC+EwdLzuVMMMJf3Nt9/
         9YEgB2jsExesC8/H6BN5wx6Biy8dYRyPp/MmG+zZNNAJqU9z6fctqmLApoYYL/cXPI
         4ay7CYNXBMi5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 635D3E85D53;
        Thu,  7 Apr 2022 21:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: fix use #ifdef instead of #if to avoid
 compiler warning
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164936761240.22211.4406395532419744389.git-patchwork-notify@kernel.org>
Date:   Thu, 07 Apr 2022 21:40:12 +0000
References: <20220407203842.3019904-1-andrii@kernel.org>
In-Reply-To: <20220407203842.3019904-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, naresh.kamboju@linaro.org, sfr@canb.auug.org.au
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Thu, 7 Apr 2022 13:38:42 -0700 you wrote:
> As reported by Naresh:
> 
>   perf build errors on i386 [1] on Linux next-20220407 [2]
> 
>   usdt.c:1181:5: error: "__x86_64__" is not defined, evaluates to 0
>   [-Werror=undef]
>    1181 | #if __x86_64__
>         |     ^~~~~~~~~~
>   usdt.c:1196:5: error: "__x86_64__" is not defined, evaluates to 0
>   [-Werror=undef]
>    1196 | #if __x86_64__
>         |     ^~~~~~~~~~
>   cc1: all warnings being treated as errors
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: fix use #ifdef instead of #if to avoid compiler warning
    https://git.kernel.org/bpf/bpf-next/c/ded6dffaed5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


