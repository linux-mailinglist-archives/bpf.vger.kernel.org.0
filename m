Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A693D6871F4
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 00:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjBAXaZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 18:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjBAXaX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 18:30:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FEB5BAF;
        Wed,  1 Feb 2023 15:30:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9769EB8235C;
        Wed,  1 Feb 2023 23:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47735C4339B;
        Wed,  1 Feb 2023 23:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675294220;
        bh=jlomzh/whMQHOGWML2nIIOEb287956g6YMGM5opRB7Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jpmSLhQViqoSY7uXGgH82gZ+E1KZGI4Nqcs6UUIgoTGDC7DtusLhjvv03hwxz1+eA
         0ZHoSfL7DVxbrWqnV6+0O1azO7J50SLLRrH35Se+FTrzJiXlU7HTCXNMnM1wHhsZ0v
         ZK7S3ULJgTjkAnFt80gKvS0XoMliFRnPdFvI2iWR9H6JOgx6Jko5K3wunefve8kzUD
         jruL4qjZYY2GHMX4KTmksXd76mmOhF8HhDUNfMsy3pHW5MvlpInyHsMSuItJi7EJlB
         mfQzsYfttz5+K05hXg/Ib1tPqtA7eLE/EVia3dAbJC73dZlh2Z55s4sXpoQZBph93N
         YSCRm7ppwcGPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24BD1C4314C;
        Wed,  1 Feb 2023 23:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/4] bpf: Add __bpf_kfunc tag for kfunc
 definitions
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167529422014.24245.9433110504480439659.git-patchwork-notify@kernel.org>
Date:   Wed, 01 Feb 2023 23:30:20 +0000
References: <20230201173016.342758-1-void@manifault.com>
In-Reply-To: <20230201173016.342758-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com, corbet@lwn.net,
        hch@infradead.org, acme@kernel.org, alan.maguire@oracle.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed,  1 Feb 2023 11:30:12 -0600 you wrote:
> This is v3 of the patchset [0]. v2 can be found at [1].
> 
> [0]: https://lore.kernel.org/bpf/Y7kCsjBZ%2FFrsWW%2Fe@maniforge.lan/T/
> [1]: https://lore.kernel.org/lkml/20230123171506.71995-1-void@manifault.com/
> 
> Changelog:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/4] bpf: Add __bpf_kfunc tag for marking kernel functions as kfuncs
    https://git.kernel.org/bpf/bpf-next/c/57e7c169cd6a
  - [bpf-next,v3,2/4] bpf: Document usage of the new __bpf_kfunc macro
    https://git.kernel.org/bpf/bpf-next/c/98e6ab7a0435
  - [bpf-next,v3,3/4] bpf: Add __bpf_kfunc tag to all kfuncs
    https://git.kernel.org/bpf/bpf-next/c/400031e05adf
  - [bpf-next,v3,4/4] selftests/bpf: Add testcase for static kfunc with unused arg
    https://git.kernel.org/bpf/bpf-next/c/6aed15e330bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


