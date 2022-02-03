Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBDD4A8AA3
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 18:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239401AbiBCRuK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 12:50:10 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55410 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiBCRuJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Feb 2022 12:50:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9A08617A7
        for <bpf@vger.kernel.org>; Thu,  3 Feb 2022 17:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28E7FC340EF;
        Thu,  3 Feb 2022 17:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643910609;
        bh=2ZGA3r6dVMlywubO6vXsoa+otpjUKC0oA245No7JMYk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XsF+I/tbFhGKg2skrqWoI833joTL1O/6p6MrA74P0jhskJobB2zMJptEySdcH1V9w
         LbcT037MowYgq8GXYvn7NIQHYmqvR9Si52CsomL25jx7J63qouk/sMlGtd9Z4oOV6V
         uiu4TMoFiplK5W4HftepfRRwU6NI6xZZz61KUlB01C6/9o3gPkXbUTjSGupbTmaYWR
         MVeNIckq/PTSdn+VHNoZlvpYnu/5JZ1Fymp5bqNaswBMImi+BJb/ePjPDoH2WxKOH+
         /7i5wmkkND5+9LGo5Xu8BfkkrrLiXYGq+nOAVTAo44AYRlCh2cf+9VIjn3GaT8Nq5I
         DPuLmM9laLJUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B5F3E5869F;
        Thu,  3 Feb 2022 17:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: test_run: fix OOB access in
 bpf_prog_test_run_xdp
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164391060904.1486.6609284418127236354.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Feb 2022 17:50:09 +0000
References: <688c26f9dd6e885e58e8e834ede3f0139bb7fa95.1643835097.git.lorenzo@kernel.org>
In-Reply-To: <688c26f9dd6e885e58e8e834ede3f0139bb7fa95.1643835097.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        brouer@redhat.com, toke@redhat.com, lorenzo.bianconi@redhat.com,
        andrii@kernel.org, syzkaller-bugs@googlegroups.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  2 Feb 2022 21:53:20 +0100 you wrote:
> Fix the following kasan issue reported by syzbot:
> 
> BUG: KASAN: slab-out-of-bounds in __skb_frag_set_page include/linux/skbuff.h:3242 [inline]
> BUG: KASAN: slab-out-of-bounds in bpf_prog_test_run_xdp+0x10ac/0x1150 net/bpf/test_run.c:972
> Write of size 8 at addr ffff888048c75000 by task syz-executor.5/23405
> 
> CPU: 1 PID: 23405 Comm: syz-executor.5 Not tainted 5.16.0-syzkaller #0
> Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  print_address_description.constprop.0.cold+0x8d/0x336 mm/kasan/report.c:255
>  __kasan_report mm/kasan/report.c:442 [inline]
>  kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
>  __skb_frag_set_page include/linux/skbuff.h:3242 [inline]
>  bpf_prog_test_run_xdp+0x10ac/0x1150 net/bpf/test_run.c:972
>  bpf_prog_test_run kernel/bpf/syscall.c:3356 [inline]
>  __sys_bpf+0x1858/0x59a0 kernel/bpf/syscall.c:4658
>  __do_sys_bpf kernel/bpf/syscall.c:4744 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:4742 [inline]
>  __x64_sys_bpf+0x75/0xb0 kernel/bpf/syscall.c:4742
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f4ea30dd059
> RSP: 002b:00007f4ea1a52168 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007f4ea31eff60 RCX: 00007f4ea30dd059
> RDX: 0000000000000048 RSI: 0000000020000000 RDI: 000000000000000a
> RBP: 00007f4ea313708d R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffc8367c5af R14: 00007f4ea1a52300 R15: 0000000000022000
>  </TASK>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: test_run: fix OOB access in bpf_prog_test_run_xdp
    https://git.kernel.org/bpf/bpf-next/c/a6763080856f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


