Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF05A64BF5C
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 23:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbiLMWaT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 17:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbiLMWaS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 17:30:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E051CFE8
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 14:30:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E4EB61755
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 22:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD84FC433F0;
        Tue, 13 Dec 2022 22:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670970616;
        bh=xyl1pWu1NM8HdGNBt9DDYzfcSDPOWCwN1+TOoVPQZio=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=k4Xw7WKjthOe8rXusxIIMU+jV+HF4/almpGLjqQ1r41hi1OeQDe6xrlX3WTPcJhyu
         UH3vbgbsb+2j0awrqjSZqzearjXEyn3sLxuzHBZwf7Kq1h1YD9RZAPZTdXf1qIY5J0
         rhpVpVfVrdOrTIXsYAdFWDnHmsDHUUMUqXdyNWutGLb7Xa3eTA4ifHl9Cpnu9LLRiw
         ULxGq01zCSKg9LfTvbZ7RhSOvNZPd9vCNF/8ZMHb/rSFKlu96j1UpcxDpRggT8MoHl
         79dC8FKUJuX39oa0KlYAA1Rmwh58w3u3eIhdCosV8r+wnQ9zfEI16OIUowNdu+Pj3V
         RQn+petsOYMvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 936B7E4D00F;
        Tue, 13 Dec 2022 22:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] selftests/bpf: Fix a selftest compilation error with
 CONFIG_SMP=n
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167097061660.397.7865456626742035188.git-patchwork-notify@kernel.org>
Date:   Tue, 13 Dec 2022 22:30:16 +0000
References: <20221213012224.379581-1-yhs@fb.com>
In-Reply-To: <20221213012224.379581-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
        lkp@intel.com, void@manifault.com
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

On Mon, 12 Dec 2022 17:22:24 -0800 you wrote:
> Kernel test robot reported bpf selftest build failure when CONFIG_SMP
> is not set. The error message looks below:
> 
>   >> progs/rcu_read_lock.c:256:34: error: no member named 'last_wakee' in 'struct task_struct'
>              last_wakee = task->real_parent->last_wakee;
>                           ~~~~~~~~~~~~~~~~~  ^
>      1 error generated.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] selftests/bpf: Fix a selftest compilation error with CONFIG_SMP=n
    https://git.kernel.org/bpf/bpf-next/c/711dfe1d66b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


