Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4FD6C91CB
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 01:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjCZAMS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Mar 2023 20:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCZAMR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Mar 2023 20:12:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A49AF1A;
        Sat, 25 Mar 2023 17:12:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3095A60DE3;
        Sun, 26 Mar 2023 00:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C4B8C4339B;
        Sun, 26 Mar 2023 00:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679789535;
        bh=eFp8h+lyyQAeLgWNpEKwDJOlkXJNNVleOesWRSSHbpg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=S0e+t1BlWlnS3OUiQiXB7XegEwyhUCnk5/f3IUAZsKn2rjGmQazIUN+8J2UB9NQLZ
         kSMELD1OqBBLWRnvp8+H4swtT6Nq116Rt8IMCFXIXaqbUP7GBIqRaOG84bPtKar06o
         +4ixZXtSEL/Grn/wwlyOyWzsYJzVUPjChcetSUTpTiNODkWg+OgQQtSjf+xJ5ofK2V
         k3Y+fS+6aNMSBS9oA2Xd2+OAQ5hH2VSiL5EDzAZJ8x/NKquObJfeF1mCYCOiHk5taR
         Fn/g1dcrMfOupM0mIOEYB8m6ZlzB0RzkPQRvY3162FzMF8NnJtuCel1zJOef7gps7O
         7jq9jjOD53lQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 614E6E4F0DA;
        Sun, 26 Mar 2023 00:12:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] Don't invoke KPTR_REF destructor on NULL xchg
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167978953539.24849.6734848364583344239.git-patchwork-notify@kernel.org>
Date:   Sun, 26 Mar 2023 00:12:15 +0000
References: <20230325213144.486885-1-void@manifault.com>
In-Reply-To: <20230325213144.486885-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 25 Mar 2023 16:31:41 -0500 you wrote:
> When a map value is being freed, we loop over all of the fields of the
> corresponding BPF object and issue the appropriate cleanup calls
> corresponding to the field's type. If the field is a referenced kptr, we
> atomically xchg the value out of the map, and invoke the kptr's
> destructor on whatever was there before.
> 
> Currently, we always invoke the destructor (or bpf_obj_drop() for a
> local kptr) on any kptr, including if no value was xchg'd out of the
> map. This means that any function serving as the kptr's KF_RELEASE
> destructor must always treat the argument as possibly NULL, and we
> invoke unnecessary (and seemingly unsafe) cleanup logic for the local
> kptr path as well.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] bpf: Only invoke kptr dtor following non-NULL xchg
    https://git.kernel.org/bpf/bpf-next/c/1431d0b584a6
  - [bpf-next,2/3] bpf: Remove now-unnecessary NULL checks for KF_RELEASE kfuncs
    https://git.kernel.org/bpf/bpf-next/c/fb2211a57c11
  - [bpf-next,3/3] bpf: Treat KF_RELEASE kfuncs as KF_TRUSTED_ARGS
    https://git.kernel.org/bpf/bpf-next/c/6c831c468412

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


