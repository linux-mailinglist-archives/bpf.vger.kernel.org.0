Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E127069B3F3
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 21:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjBQUaU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 15:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjBQUaT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 15:30:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9893E632
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 12:30:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87AA061FF2
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 20:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA041C433EF;
        Fri, 17 Feb 2023 20:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676665817;
        bh=X+sSg6LiIKfYuFsEaBrqM3mCPloDNRqAVIoJ8sXY7TI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lo/gQsRvGmONU/H5BWcC6bkXFO5AkvpkM5el021/V1CmALoNP60+BhDWHf3j5583K
         coO7A75nl3fZnKANDXCKpAOsM8BirxS4zd7tnI5S3j1G/Tim2M4UvoKpEEozo6MqtC
         GVlK1VmJCPqaaaYJ7ONs3BwlZOi1x53bTPTTvWItva7gHlsDF8dSu3ZQblWFgfQXRJ
         2VlbXriyqH03xSFlNXqzg+njL7/yAdvyGF0di1jrZQgMcIC2j8ih4BfKZl5vxwIqIT
         9gYvnxEGuxvyaWptuOtuXlE5BbqOCpwu9higOkCt8QpmX0bawNeCUxRcx2e3uGQ+Jl
         Ozlm9AuWhGakQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BCA42E21EC4;
        Fri, 17 Feb 2023 20:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/3] Fix BPF verifier global subprog context
 argument logic
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167666581776.8842.4868500111566161313.git-patchwork-notify@kernel.org>
Date:   Fri, 17 Feb 2023 20:30:17 +0000
References: <20230216045954.3002473-1-andrii@kernel.org>
In-Reply-To: <20230216045954.3002473-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
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

On Wed, 15 Feb 2023 20:59:51 -0800 you wrote:
> Fix kernel bug in determining whether global subprog's argument is PTR_TO_CTX,
> which is done based on type names. Currently KPROBE programs are broken.
> 
> Add few tests validating that KPROBE context can be passed to global subprog.
> For that also refactor test_global_funcs test to use test_loader framework.
> 
> v1->v2:
>   - fix compilation warning on arm64 and s390x by force-casting ctx to
>     `void *`, to discard const from `const struct user_pt_regs *`, when
>     passing it to bpf_get_stack().
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/3] bpf: fix global subprog context argument resolution logic
    https://git.kernel.org/bpf/bpf-next/c/d384dce281ed
  - [v2,bpf-next,2/3] selftests/bpf: convert test_global_funcs test to test_loader framework
    https://git.kernel.org/bpf/bpf-next/c/95ebb376176c
  - [v2,bpf-next,3/3] selftests/bpf: add global subprog context passing tests
    https://git.kernel.org/bpf/bpf-next/c/e2b5cfc978f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


