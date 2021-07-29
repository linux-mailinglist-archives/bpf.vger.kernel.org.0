Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457C73DAEB1
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 00:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhG2WKJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 18:10:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234158AbhG2WKJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 18:10:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AE8B260F5C;
        Thu, 29 Jul 2021 22:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627596605;
        bh=pVYpXqwLysQ/MDzD6y5CmFRhoMmyO13DtTEJ6hqOW1Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=frKti2a8mTAasHmdHrGZhQ9YAtrrUiznGJz5XddcUNh0tTrnS4TFlmPQN7H2A+9Sy
         pcx4sE1M8SVmESkrdkObg4U0PCnxbt+kMOhTCTJLAJftY6O3beGdqvH7RJt+RVfHmM
         DzTUkjauvJ5ATR35KNyjiGQa5h2KjYvRNtobMXfKx08kwZXBVE7GKKtDLQIb54X2Jv
         YEGWXvTcHyBcPqG6SsEGRNHY9Tt1oSqAH6P9SCKrDQJajMtRRBVJYxVXGjJ5qWLxJy
         p/KWxgnjk9DWBxWjRE+us48w7AW3rQK5ehc5R4ttjsUFn7BWCs4zE658rLrwhcNfdo
         NyZpeBLwbA0RA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A2636609F7;
        Thu, 29 Jul 2021 22:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: fix rcu warning in bpf_prog_run_pin_on_cpu()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162759660566.3171.3401866075961092975.git-patchwork-notify@kernel.org>
Date:   Thu, 29 Jul 2021 22:10:05 +0000
References: <20210728172307.1030271-1-yhs@fb.com>
In-Reply-To: <20210728172307.1030271-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com,
        syzbot+7ee5c2c09c284495371f@syzkaller.appspotmail.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Wed, 28 Jul 2021 10:23:07 -0700 you wrote:
> syzbot reported a RCU warning like below:
>   WARNING: suspicious RCU usage
>   ...
>   Call Trace:
>    __dump_stack lib/dump_stack.c:88 [inline]
>    dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
>    task_css_set include/linux/cgroup.h:481 [inline]
>    task_dfl_cgroup include/linux/cgroup.h:550 [inline]
>    ____bpf_get_current_cgroup_id kernel/bpf/helpers.c:356 [inline]
>    bpf_get_current_cgroup_id+0x1ce/0x210 kernel/bpf/helpers.c:354
>    bpf_prog_08c4887f705f20b8+0x10/0x824
>    bpf_dispatcher_nop_func include/linux/bpf.h:687 [inline]
>    bpf_prog_run_pin_on_cpu include/linux/filter.h:624 [inline]
>    bpf_prog_test_run_syscall+0x2cf/0x5f0 net/bpf/test_run.c:954
>    bpf_prog_test_run kernel/bpf/syscall.c:3207 [inline]
>    __sys_bpf+0x1993/0x53b0 kernel/bpf/syscall.c:4487
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: fix rcu warning in bpf_prog_run_pin_on_cpu()
    https://git.kernel.org/bpf/bpf/c/8118b11cb603

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


