Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8045533FBD4
	for <lists+bpf@lfdr.de>; Thu, 18 Mar 2021 00:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhCQXaZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Mar 2021 19:30:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229658AbhCQXaI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Mar 2021 19:30:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8339364DAF;
        Wed, 17 Mar 2021 23:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616023808;
        bh=Idvl73Ee3SM1SiaMKgxHHU5cQCVvwRDqZ1X4DyCFbZ0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=t0EUwttTR68pO73fzTQPH+5u8yjwdkBmmpK2k8Zl/fi+c2vZd1sIiPr4c1Z5IY+xp
         x6taC+V14j0tYfZy0rH4JfpwxkX3lLHq08BMSMpDZ8QBFqeBwZu9Xva25t8ghMB+pi
         16UYMYw2YzudWysXNzZOXprusV7ZPfqfStVA01beznIPW5Pn6QNAKNO1K3Bh7rNAZY
         F6SqyOpWYNAVF9xDqGx+acUQC/Kd/sKmgLC2KQy7nMrN6f67wtrA2kryVWVjJ8Qy9w
         809NiXWPW8w/jVSy31Ucw8hY+LqmBn/GZ4Xm+qeUCpe5NrW6f7pAsRg0GnOKiIEIoL
         4Cv4msXnGUHVg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7317260A45;
        Wed, 17 Mar 2021 23:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Fix fexit trampoline.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161602380846.17175.8769309724238970461.git-patchwork-notify@kernel.org>
Date:   Wed, 17 Mar 2021 23:30:08 +0000
References: <20210316210007.38949-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20210316210007.38949-1-alexei.starovoitov@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        paulmck@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Tue, 16 Mar 2021 14:00:07 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The fexit/fmod_ret programs can be attached to kernel functions that can sleep.
> The synchronize_rcu_tasks() will not wait for such tasks to complete.
> In such case the trampoline image will be freed and when the task
> wakes up the return IP will point to freed memory causing the crash.
> Solve this by adding percpu_ref_get/put for the duration of trampoline
> and separate trampoline vs its image life times.
> The "half page" optimization has to be removed, since
> first_half->second_half->first_half transition cannot be guaranteed to
> complete in deterministic time. Every trampoline update becomes a new image.
> The image with fmod_ret or fexit progs will be freed via percpu_ref_kill and
> call_rcu_tasks. Together they will wait for the original function and
> trampoline asm to complete. The trampoline is patched from nop to jmp to skip
> fexit progs. They are freed independently from the trampoline. The image with
> fentry progs only will be freed via call_rcu_tasks_trace+call_rcu_tasks which
> will wait for both sleepable and non-sleepable progs to complete.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Fix fexit trampoline.
    https://git.kernel.org/bpf/bpf/c/e21aa341785c

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


