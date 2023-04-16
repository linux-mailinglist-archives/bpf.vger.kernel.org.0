Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5E46E3A0F
	for <lists+bpf@lfdr.de>; Sun, 16 Apr 2023 18:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjDPQAV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 16 Apr 2023 12:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPQAU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 16 Apr 2023 12:00:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F129930CA;
        Sun, 16 Apr 2023 09:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 886E1612FF;
        Sun, 16 Apr 2023 16:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0B95C4339B;
        Sun, 16 Apr 2023 16:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681660818;
        bh=CBZceDftIE3tp7qd6rHlc+bcPu/aGTJriElj13UZ96Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=L2SqPNpcAZNQ5E9nOppcrjK8s7KVfXcCSyJlaI0dXerKtmdPr+Co7TYSO9MEOeZl9
         BAI59XGNIFSxzxSe7oiu+pcIbCxIVbkSKRGTkB1WYL4nO+fAHh8fHK0OSaxLEvWngj
         +IAMKdILcWcuLtXDYb/cb4qbQuXGrNweXUvp115g5qZZC34SltI1nypAWv7P4Us0FZ
         KRU1s8UBCwMWUZ2EiVevQxypyZJ8+OmIoD23YdiUNpvzATsnzh1d6KAJ/9LrG8gVjK
         Aj4Sv1F75yG4QIvsH59bDWWvrPH/wm/8PyhK1Qg1SbLALCaymMQYJdvBSnIK9hkWEo
         VY8E8NnheqWTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8844E29F41;
        Sun, 16 Apr 2023 16:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] Remove KF_KPTR_GET kfunc flag
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168166081875.23493.14575067430091367699.git-patchwork-notify@kernel.org>
Date:   Sun, 16 Apr 2023 16:00:18 +0000
References: <20230416084928.326135-1-void@manifault.com>
In-Reply-To: <20230416084928.326135-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        memxor@gmail.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 16 Apr 2023 03:49:25 -0500 you wrote:
> We've managed to improve the UX for kptrs significantly over the last 9
> months. All of the existing use cases which previously had KF_KPTR_GET
> kfuncs (struct bpf_cpumask *, struct task_struct *, and struct cgroup *)
> have all been updated to be synchronized using RCU. In other words,
> their KF_KPTR_GET kfuncs have been removed in favor of KF_RCU |
> KF_ACQUIRE kfuncs, with the pointers themselves also being readable from
> maps in an RCU read region thanks to the types being RCU safe.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] bpf: Remove bpf_kfunc_call_test_kptr_get() test kfunc
    https://git.kernel.org/bpf/bpf-next/c/09b501d90521
  - [bpf-next,v2,2/3] bpf: Remove KF_KPTR_GET kfunc flag
    https://git.kernel.org/bpf/bpf-next/c/7b4ddf3920d2
  - [bpf-next,v2,3/3] bpf,docs: Remove KF_KPTR_GET from documentation
    https://git.kernel.org/bpf/bpf-next/c/530474e6d044

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


