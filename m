Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F13A52F7E1
	for <lists+bpf@lfdr.de>; Sat, 21 May 2022 05:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiEUDKP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 May 2022 23:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiEUDKP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 23:10:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7F515E61D
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 20:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 140F461EEF
        for <bpf@vger.kernel.org>; Sat, 21 May 2022 03:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67FBCC34100;
        Sat, 21 May 2022 03:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653102613;
        bh=2UyVzI1xhnRqflDj0vZKsiaJl0uoz58t9T3Sjlc1vgE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XvsHLbfVO/5uExDpRgiBQXGyAuSor4WhQPnYyAez9i+N66eJvvu13YU5glGdfOV+e
         snh3RPu7abnC/HKKIsWjcNz3JYsWEysYpnm4S1bprjyOA371jtY22/e67kcnXRHaYG
         rH/JjuK88nvwEEnHPDkpS9sBvAIuDoiiacTh2yLKORkcRVFPO9SRkbZBaZ5+1z47g0
         vhlUjX//qaqLnxfIHXbxxfuqfVyyEGEHN8EI0DPbazAfyNO5F9QW82kQduiiAIcO7e
         NN2NJ4Ypgqv3VZGaYxBuJkGf6monUjZlUMpeRbhoNo1Fq+Efq9iewMrT2kdj5SVVWn
         Bxw0IjRu/TlrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C45FF0383D;
        Sat, 21 May 2022 03:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next 0/2] bpf: refine kernel.unprivileged_bpf_disabled
 behaviour
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165310261330.28965.7260666834777570379.git-patchwork-notify@kernel.org>
Date:   Sat, 21 May 2022 03:10:13 +0000
References: <1652970334-30510-1-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1652970334-30510-1-git-send-email-alan.maguire@oracle.com>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        keescook@chromium.org, bpf@vger.kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

On Thu, 19 May 2022 15:25:32 +0100 you wrote:
> Unprivileged BPF disabled (kernel.unprivileged_bpf_disabled >= 1)
> is the default in most cases now; when set, the BPF system call is
> blocked for users without CAP_BPF/CAP_SYS_ADMIN.  In some cases
> however, it makes sense to split activities between capability-requiring
> ones - such as program load/attach - and those that might not require
> capabilities such as reading perf/ringbuf events, reading or
> updating BPF map configuration etc.  One example of this sort of
> approach is a service that loads a BPF program, and a user-space
> program that interacts with it.
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next,1/2] bpf: refine kernel.unprivileged_bpf_disabled behaviour
    https://git.kernel.org/bpf/bpf-next/c/c8644cd0efe7
  - [v4,bpf-next,2/2] selftests/bpf: add tests verifying unprivileged bpf behaviour
    https://git.kernel.org/bpf/bpf-next/c/90a039fd19fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


