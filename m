Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E9F3F2096
	for <lists+bpf@lfdr.de>; Thu, 19 Aug 2021 21:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhHSTan (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Aug 2021 15:30:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231294AbhHSTam (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Aug 2021 15:30:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 48ADA60F39;
        Thu, 19 Aug 2021 19:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629401406;
        bh=RU5mMDuW2WkA6FSnUxBtEs4RXbCtKUEDMwMOU2ipiiM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KKrEHop9v7pEiQRdSsBfbJhausO6lC8slp6QYINsGqfb+vQ7z/cZ9c4A3phiTD3eW
         carPbxTe6pdVpf7l5vPcZy40hdW6gdIRO8M34+iBCSAdEXQ7+gIc3ZThcLpOnvz5y3
         sJNVkOD2mKna6XbJRf1+cyzD6r3qhCoChw8EcpStJ1fCza7PBwjaQP+kPylUHynYHQ
         5YSbkpqRy+lw7xLa2BMjFvIYy2OetWQ/2boMR73QeBlsqgy87kLTajJnaIn6PNqg7a
         G05DNuiGJt+2oxW2ZSGzteVSeUxMmEdAQZZ8NY6E6S37WcgB2fvtEb9cbNCl63wa12
         L0wGRqcDXFuaw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3DBCF60A89;
        Thu, 19 Aug 2021 19:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: fix NULL event->prog pointer access in
 bpf_overflow_handler
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162940140624.416.6919865600057451007.git-patchwork-notify@kernel.org>
Date:   Thu, 19 Aug 2021 19:30:06 +0000
References: <20210819155209.1927994-1-yhs@fb.com>
In-Reply-To: <20210819155209.1927994-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Thu, 19 Aug 2021 08:52:09 -0700 you wrote:
> Andrii reported that libbpf CI hit the following oops when
> running selftest send_signal:
>   [ 1243.160719] BUG: kernel NULL pointer dereference, address: 0000000000000030
>   [ 1243.161066] #PF: supervisor read access in kernel mode
>   [ 1243.161066] #PF: error_code(0x0000) - not-present page
>   [ 1243.161066] PGD 0 P4D 0
>   [ 1243.161066] Oops: 0000 [#1] PREEMPT SMP NOPTI
>   [ 1243.161066] CPU: 1 PID: 882 Comm: new_name Tainted: G           O      5.14.0-rc5 #1
>   [ 1243.161066] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>   [ 1243.161066] RIP: 0010:bpf_overflow_handler+0x9a/0x1e0
>   [ 1243.161066] Code: 5a 84 c0 0f 84 06 01 00 00 be 66 02 00 00 48 c7 c7 6d 96 07 82 48 8b ab 18 05 00 00 e8 df 55 eb ff 66 90 48 8d 75 48 48 89 e7 <ff> 55 30 41 89 c4 e8 fb c1 f0 ff 84 c0 0f 84 94 00 00 00 e8 6e 0f
>   [ 1243.161066] RSP: 0018:ffffc900000c0d80 EFLAGS: 00000046
>   [ 1243.161066] RAX: 0000000000000002 RBX: ffff8881002e0dd0 RCX: 00000000b4b47cf8
>   [ 1243.161066] RDX: ffffffff811dcb06 RSI: 0000000000000048 RDI: ffffc900000c0d80
>   [ 1243.161066] RBP: 0000000000000000 R08: 0000000000000000 R09: 1a9d56bb00000000
>   [ 1243.161066] R10: 0000000000000001 R11: 0000000000080000 R12: 0000000000000000
>   [ 1243.161066] R13: ffffc900000c0e00 R14: ffffc900001c3c68 R15: 0000000000000082
>   [ 1243.161066] FS:  00007fc0be2d3380(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
>   [ 1243.161066] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [ 1243.161066] CR2: 0000000000000030 CR3: 0000000104f8e000 CR4: 00000000000006e0
>   [ 1243.161066] Call Trace:
>   [ 1243.161066]  <IRQ>
>   [ 1243.161066]  __perf_event_overflow+0x4f/0xf0
>   [ 1243.161066]  perf_swevent_hrtimer+0x116/0x130
>   [ 1243.161066]  ? __lock_acquire+0x378/0x2730
>   [ 1243.161066]  ? __lock_acquire+0x372/0x2730
>   [ 1243.161066]  ? lock_is_held_type+0xd5/0x130
>   [ 1243.161066]  ? find_held_lock+0x2b/0x80
>   [ 1243.161066]  ? lock_is_held_type+0xd5/0x130
>   [ 1243.161066]  ? perf_event_groups_first+0x80/0x80
>   [ 1243.161066]  ? perf_event_groups_first+0x80/0x80
>   [ 1243.161066]  __hrtimer_run_queues+0x1a3/0x460
>   [ 1243.161066]  hrtimer_interrupt+0x110/0x220
>   [ 1243.161066]  __sysvec_apic_timer_interrupt+0x8a/0x260
>   [ 1243.161066]  sysvec_apic_timer_interrupt+0x89/0xc0
>   [ 1243.161066]  </IRQ>
>   [ 1243.161066]  asm_sysvec_apic_timer_interrupt+0x12/0x20
>   [ 1243.161066] RIP: 0010:finish_task_switch+0xaf/0x250
>   [ 1243.161066] Code: 31 f6 68 90 2a 09 81 49 8d 7c 24 18 e8 aa d6 03 00 4c 89 e7 e8 12 ff ff ff 4c 89 e7 e8 ca 9c 80 00 e8 35 af 0d 00 fb 4d 85 f6 <58> 74 1d 65 48 8b 04 25 c0 6d 01 00 4c 3b b0 a0 04 00 00 74 37 f0
>   [ 1243.161066] RSP: 0018:ffffc900001c3d18 EFLAGS: 00000282
>   [ 1243.161066] RAX: 000000000000031f RBX: ffff888104cf4980 RCX: 0000000000000000
>   [ 1243.161066] RDX: 0000000000000000 RSI: ffffffff82095460 RDI: ffffffff820adc4e
>   [ 1243.161066] RBP: ffffc900001c3d58 R08: 0000000000000001 R09: 0000000000000001
>   [ 1243.161066] R10: 0000000000000001 R11: 0000000000080000 R12: ffff88813bd2bc80
>   [ 1243.161066] R13: ffff8881002e8000 R14: ffff88810022ad80 R15: 0000000000000000
>   [ 1243.161066]  ? finish_task_switch+0xab/0x250
>   [ 1243.161066]  ? finish_task_switch+0x70/0x250
>   [ 1243.161066]  __schedule+0x36b/0xbb0
>   [ 1243.161066]  ? _raw_spin_unlock_irqrestore+0x2d/0x50
>   [ 1243.161066]  ? lockdep_hardirqs_on+0x79/0x100
>   [ 1243.161066]  schedule+0x43/0xe0
>   [ 1243.161066]  pipe_read+0x30b/0x450
>   [ 1243.161066]  ? wait_woken+0x80/0x80
>   [ 1243.161066]  new_sync_read+0x164/0x170
>   [ 1243.161066]  vfs_read+0x122/0x1b0
>   [ 1243.161066]  ksys_read+0x93/0xd0
>   [ 1243.161066]  do_syscall_64+0x35/0x80
>   [ 1243.161066]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: fix NULL event->prog pointer access in bpf_overflow_handler
    https://git.kernel.org/bpf/bpf-next/c/594286b7574c

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


