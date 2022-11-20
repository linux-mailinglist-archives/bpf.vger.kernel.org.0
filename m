Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB2D63158B
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 18:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiKTRaU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 12:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiKTRaT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 12:30:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE13AB50;
        Sun, 20 Nov 2022 09:30:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52B0E60C8E;
        Sun, 20 Nov 2022 17:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E7D4C433D7;
        Sun, 20 Nov 2022 17:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668965416;
        bh=wdMvv3HwY72aYEPn2ySfTAhKmjiAzDdlJphIynQ0Boo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=a1qTG9YgkSgMG6B5L/DXeVlKqTAccZt1qFGvGlKn0A3tHGoUyxu/bFzQzc0PeyoKc
         leqV1ufbKSeWIgb3Oq8lXJWWpAlkn5QNLsycfGLkYZKH2FfoULYwsq2ZG81xel149e
         wKLumNY5VZbdRxniQfifPkhqL3HQlMYFP1PSiDgr3aIvQaMSmFk/9RaSaio/TTt+YB
         qIE2mT+7JZnsYzTBm5iDuwfsiw6g3M2K0KG4wLx4m+Wf905hqZs/yUa4rFO9OhhKbR
         sVXvGDVPe7hn12XEvnOZJakhVl6Ryqn9FiB+dFIl9iN7utuZJRIQZGbMHeiUyjPBMJ
         Y6CNgyaXAhiAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80F39E270C8;
        Sun, 20 Nov 2022 17:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v9 0/4] Support storing struct task_struct objects as
 kptrs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166896541652.21684.9432538725103105426.git-patchwork-notify@kernel.org>
Date:   Sun, 20 Nov 2022 17:30:16 +0000
References: <20221120051004.3605026-1-void@manifault.com>
In-Reply-To: <20221120051004.3605026-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, haoluo@google.com, jolsa@kernel.org,
        kpsingh@kernel.org, memxor@gmail.com, tj@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
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
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 19 Nov 2022 23:10:00 -0600 you wrote:
> Now that BPF supports adding new kernel functions with kfuncs, and
> storing kernel objects in maps with kptrs, we can add a set of kfuncs
> which allow struct task_struct objects to be stored in maps as
> referenced kptrs.
> 
> The possible use cases for doing this are plentiful.  During tracing,
> for example, it would be useful to be able to collect some tasks that
> performed a certain operation, and then periodically summarize who they
> are, which cgroup they're in, how much CPU time they've utilized, etc.
> Doing this now would require storing the tasks' pids along with some
> relevant data to be exported to user space, and later associating the
> pids to tasks in other event handlers where the data is recorded.
> Another useful by-product of this is that it allows a program to pin a
> task in a BPF program, and by proxy therefore also e.g. pin its task
> local storage.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v9,1/4] bpf: Allow multiple modifiers in reg_type_str() prefix
    https://git.kernel.org/bpf/bpf-next/c/ef66c5475d7f
  - [bpf-next,v9,2/4] bpf: Allow trusted pointers to be passed to KF_TRUSTED_ARGS kfuncs
    https://git.kernel.org/bpf/bpf-next/c/3f00c5239344
  - [bpf-next,v9,3/4] bpf: Add kfuncs for storing struct task_struct * as a kptr
    https://git.kernel.org/bpf/bpf-next/c/90660309b0c7
  - [bpf-next,v9,4/4] bpf/selftests: Add selftests for new task kfuncs
    https://git.kernel.org/bpf/bpf-next/c/fe147956fca4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


