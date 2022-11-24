Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D5463814C
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 00:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiKXXKU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Nov 2022 18:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXXKT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Nov 2022 18:10:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5BF7DEFD;
        Thu, 24 Nov 2022 15:10:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7ED22B8293C;
        Thu, 24 Nov 2022 23:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 163B2C433D6;
        Thu, 24 Nov 2022 23:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669331416;
        bh=/HDv+mAESp1hPabQrG6CtweWqU3lEkCgOtLj6ltj3qI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Hg5Xjr+sSxFEdZvNvCXxu6Saikb0sLfHAkk2zo5fXn8hEGCvphiCirwThQoll074J
         DoGfUXW5a6vXKxSrKFK7/61hM7mxVh8/Z9BqEm21ywGjLqWrIPe/jyqRdyQc0Adj2o
         ClUXcrd/ml+1RE9UkyNtdxzgf6h0SwQqey9kt8gadC5HIAykPKHfQVwnU5v0N7np2B
         7mvcp7lAnZefuxBKh830F/K4PychpkRA7mKzbKUaUJcIzwB3gHyY6rIjDQY4EiGbBx
         yzDCZbmh8wZ0pFMEIpBrHS8giXBKSdOCEEM3jrKQS0hizyHL+ryqBooJudVuC9Vr1g
         YM7WbvksgD+ZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ECEB2E270C7;
        Thu, 24 Nov 2022 23:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4] docs/bpf: Update btf selftests program and add
 link
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166933141596.31829.17958400614612608344.git-patchwork-notify@kernel.org>
Date:   Thu, 24 Nov 2022 23:10:15 +0000
References: <tencent_1FA6904156E8E599CAE4ABDBE80F22830106@qq.com>
In-Reply-To: <tencent_1FA6904156E8E599CAE4ABDBE80F22830106@qq.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     void@manifault.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, corbet@lwn.net, daniel@iogearbox.net,
        haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@linux.dev,
        rongtao@cestc.cn, sdf@google.com, song@kernel.org, yhs@fb.com
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 22 Nov 2022 08:50:42 +0800 you wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> commit c64779e24e88("selftests/bpf: Merge most of test_btf into
> test_progs") rename selftests/bpf btf test from 'test_btf.c' to
> 'prog_tests/btf.c'.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4] docs/bpf: Update btf selftests program and add link
    https://git.kernel.org/bpf/bpf-next/c/b74344cbede2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


