Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6907529D93B
	for <lists+bpf@lfdr.de>; Wed, 28 Oct 2020 23:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389540AbgJ1WuG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Oct 2020 18:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389530AbgJ1WuF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Oct 2020 18:50:05 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603925404;
        bh=YkIvDKPErt3NvCXUo0fvJk/pdkjkI5dN3QZ8rVeGMDU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GGt4d08MLbClyJrEjlzzv+OFpRxQLZy65gEG7uBbRKJdYklCpEXWT9mqCuqitsH11
         ZGVE6VZukrjY6BsBV0qX8JSHjoyCX4w34jsg1SRH4YS3kh+ULLSznAsW9IPBVbGPS9
         xuUyHNPrjzHXCdyiatJiafTbs3aqdCNbfH8tFcrA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: permit cond_resched for some iterators
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160392540439.15061.11814721370459886312.git-patchwork-notify@kernel.org>
Date:   Wed, 28 Oct 2020 22:50:04 +0000
References: <20201028061054.1411116-1-yhs@fb.com>
In-Reply-To: <20201028061054.1411116-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, andrii@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 27 Oct 2020 23:10:54 -0700 you wrote:
> Commit e679654a704e ("bpf: Fix a rcu_sched stall issue with
> bpf task/task_file iterator") tries to fix rcu stalls warning
> which is caused by bpf task_file iterator when running
> "bpftool prog".
> 
>       rcu: INFO: rcu_sched self-detected stall on CPU
>       rcu: \x097-....: (20999 ticks this GP) idle=302/1/0x4000000000000000 softirq=1508852/1508852 fqs=4913
>       \x09(t=21031 jiffies g=2534773 q=179750)
>       NMI backtrace for cpu 7
>       CPU: 7 PID: 184195 Comm: bpftool Kdump: loaded Tainted: G        W         5.8.0-00004-g68bfc7f8c1b4 #6
>       Hardware name: Quanta Twin Lakes MP/Twin Lakes Passive MP, BIOS F09_3A17 05/03/2019
>       Call Trace:
>       <IRQ>
>       dump_stack+0x57/0x70
>       nmi_cpu_backtrace.cold+0x14/0x53
>       ? lapic_can_unplug_cpu.cold+0x39/0x39
>       nmi_trigger_cpumask_backtrace+0xb7/0xc7
>       rcu_dump_cpu_stacks+0xa2/0xd0
>       rcu_sched_clock_irq.cold+0x1ff/0x3d9
>       ? tick_nohz_handler+0x100/0x100
>       update_process_times+0x5b/0x90
>       tick_sched_timer+0x5e/0xf0
>       __hrtimer_run_queues+0x12a/0x2a0
>       hrtimer_interrupt+0x10e/0x280
>       __sysvec_apic_timer_interrupt+0x51/0xe0
>       asm_call_on_stack+0xf/0x20
>       </IRQ>
>       sysvec_apic_timer_interrupt+0x6f/0x80
>       ...
>       task_file_seq_next+0x52/0xa0
>       bpf_seq_read+0xb9/0x320
>       vfs_read+0x9d/0x180
>       ksys_read+0x5f/0xe0
>       do_syscall_64+0x38/0x60
>       entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: permit cond_resched for some iterators
    https://git.kernel.org/bpf/bpf-next/c/cf83b2d2e2b6

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


