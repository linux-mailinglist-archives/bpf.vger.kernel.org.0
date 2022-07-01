Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00155563442
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 15:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiGANUQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Jul 2022 09:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiGANUP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Jul 2022 09:20:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E334060522
        for <bpf@vger.kernel.org>; Fri,  1 Jul 2022 06:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EFBF61FF0
        for <bpf@vger.kernel.org>; Fri,  1 Jul 2022 13:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3096C341C7;
        Fri,  1 Jul 2022 13:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656681613;
        bh=sVIVK4WwfcGlM/Pfl50EglWXeMOYwilDCu9qa8zakbY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Z7lBsd+crNCgjTctKv/cG/mIovQL6SkD6qzyd5uT9HlxcPqop7OJ9pswf9iAuKERq
         sATem6tO7DSQV45wD9HR4qZv1h4T+HjuD66TtTnsPf2prQ8/8k5ZcZeFY6icctlhMY
         uQU88L9/3tUeJEW8djihFhd6c4BCWLdtqyD9ZWhWs/iVzJ74DzcKnkqFPPV2rfsUhI
         gkwUt5ILKUs2urwxznQPgKwYxmq4L85/Hw6VVdmsIGaKquNeHQCMgqmGJLVyVOziMt
         slUTYAbyXQqx4zgpPhNFXKVtHXeUDnpkN9cbMzIjNhbsMDfRpAFHSd4FHkFrNkb9O6
         /gAXBr3WIz2/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A539CE49BBC;
        Fri,  1 Jul 2022 13:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: skip lsm_cgroup when don't have
 trampolines
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165668161367.7539.8173924631850866924.git-patchwork-notify@kernel.org>
Date:   Fri, 01 Jul 2022 13:20:13 +0000
References: <20220630224203.512815-1-sdf@google.com>
In-Reply-To: <20220630224203.512815-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Thu, 30 Jun 2022 15:42:03 -0700 you wrote:
> With arch_prepare_bpf_trampoline removed on x86:
> 
>  #98/1    lsm_cgroup/functional:SKIP
>  #98      lsm_cgroup:SKIP
>  Summary: 1/0 PASSED, 1 SKIPPED, 0 FAILED
> 
> Fixes: dca85aac8895 ("selftests/bpf: lsm_cgroup functional test")
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: skip lsm_cgroup when don't have trampolines
    https://git.kernel.org/bpf/bpf-next/c/b0d93b44641a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


