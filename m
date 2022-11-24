Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB9263806A
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 22:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiKXVKT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Nov 2022 16:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKXVKT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Nov 2022 16:10:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7342691C29
        for <bpf@vger.kernel.org>; Thu, 24 Nov 2022 13:10:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC150621BF
        for <bpf@vger.kernel.org>; Thu, 24 Nov 2022 21:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29630C433D7;
        Thu, 24 Nov 2022 21:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669324217;
        bh=XQb+4uj0rOgkiTVelM79wjH+d4mlieYGBVd3MLUxbXs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kJv8vuILktRnkyXLJWl3BGUiPLfMyTno0438FYzXh9B6G3GXiZmwVKI5ExzIeaQLZ
         L+1tr1B1mpAnp5murfRlGYmZA7qM4yGn7Yut8LqeD4cCUPaiC251Ghy3B55DNMxm4p
         vyvllIxB6xYWB+Qeml+ST46nQMMe2bABhRUzK+ba0zab3/HTrtn3EDcUAqjY7IcMRW
         z/3mzk/P7gwhMtUR6rd4jAM76FGfhKyV8wmOxu+d/QOMIj/KzzKJlkIzhckRN89evY
         v2JQ90Gil0ahBdBIItXxQ0q4vqej1lh2L46JYtQErBwY/ctorhbZQ6cD6sObFBp/hJ
         4Zj/Gt9CQUhFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F1A1E29F52;
        Thu, 24 Nov 2022 21:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v10 0/4] bpf: Add bpf_rcu_read_lock() support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166932421705.8227.17049613081717402206.git-patchwork-notify@kernel.org>
Date:   Thu, 24 Nov 2022 21:10:17 +0000
References: <20221124053201.2372298-1-yhs@fb.com>
In-Reply-To: <20221124053201.2372298-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org
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
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 23 Nov 2022 21:32:01 -0800 you wrote:
> Currently, without rcu attribute info in BTF, the verifier treats
> rcu tagged pointer as a normal pointer. This might be a problem
> for sleepable program where rcu_read_lock()/unlock() is not available.
> For example, for a sleepable fentry program, if rcu protected memory
> access is interleaved with a sleepable helper/kfunc, it is possible
> the memory access after the sleepable helper/kfunc might be invalid
> since the object might have been freed then. Even without
> a sleepable helper/kfunc, without rcu_read_lock() protection,
> it is possible that the rcu protected object might be release
> in the middle of bpf program execution which may cause incorrect
> result.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v10,1/4] compiler_types: Define __rcu as __attribute__((btf_type_tag("rcu")))
    https://git.kernel.org/bpf/bpf-next/c/5a0f663f0189
  - [bpf-next,v10,2/4] bpf: Introduce might_sleep field in bpf_func_proto
    https://git.kernel.org/bpf/bpf-next/c/01685c5bddaa
  - [bpf-next,v10,3/4] bpf: Add kfunc bpf_rcu_read_lock/unlock()
    https://git.kernel.org/bpf/bpf-next/c/9bb00b2895cb
  - [bpf-next,v10,4/4] selftests/bpf: Add tests for bpf_rcu_read_lock()
    https://git.kernel.org/bpf/bpf-next/c/48671232fcb8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


