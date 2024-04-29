Return-Path: <bpf+bounces-28133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3051E8B6060
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 19:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB981F2170C
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 17:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5315A128820;
	Mon, 29 Apr 2024 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JtLSw0kt"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EF2128396
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412758; cv=none; b=qWCY2Uryk2uRA4V/yHNv2oZbbqJXiOH8h+RVYu1YuycZu/Sex02ey7Pt5Ag/1pREAS3N/U+k8jj3oYEUEs0wfCpbLS6RswtntjxkmsbSE4A0GCgw5Dxdx3KQ+glM0jpiUjfco71lqOSaRQ/u0a/D3p1Fa9s0+koUxToShF70hik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412758; c=relaxed/simple;
	bh=lFxLGe1ug8Ra1SKtFkV6OMijDJZuGgOGdi/k0+rQBX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HpxaC1ISBfX/NIcDeEnjrrl88fqc3avGQRoCVxedalGABT5c0E5D1VyMIq5mZFSBY6jj8Fo+QurWQUx47WZapZ3MkH+L5WMUQo4cGJv+TrEBCyfj2I9iz1wA7Iku7IlLGB1UCluZuW4ppQMKWEoL/BXZWr4ClKIgPh2A4OnUtcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JtLSw0kt; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <eeeac631-6495-4b4c-9423-490839397dd1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714412754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7oFU2BoxCCtC1ccNHcqKzlkmI8ESHX9lPB03PGJn9w=;
	b=JtLSw0ktJVMmaBbu6NfLE+Nn85jlnfqvxnNX9ctwmRVvOlVQ76zPhEb3KLuYPLINVhDyjC
	D2VvztNkf47xQd6IvC8FZmJ2Lz8Daux/v/kPMKs8ooAmhCD/foy6zqxoxWiW3HUe10U1IV
	YKYqsoVsy7jX3zgD+TvcLD7X3Bezbfw=
Date: Mon, 29 Apr 2024 10:45:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [bpf?] [trace?] WARNING in group_send_sig_info
Content-Language: en-GB
To: syzbot <syzbot+1902c6d326478ce2dfb0@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 martin.lau@linux.dev, mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 netdev@vger.kernel.org, rostedt@goodmis.org, sdf@google.com,
 song@kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000bc2d38061716975e@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <000000000000bc2d38061716975e@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/27/24 9:34 AM, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
> git tree:       bpf
> console output: https://syzkaller.appspot.com/x/log.txt?x=11ca8fe7180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
> dashboard link: https://syzkaller.appspot.com/bug?extid=1902c6d326478ce2dfb0
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3f355021a085/disk-443574b0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/44cf4de7472a/vmlinux-443574b0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a99a36c7ad65/bzImage-443574b0.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1902c6d326478ce2dfb0@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> raw_local_irq_restore() called with IRQs enabled
> WARNING: CPU: 1 PID: 7785 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x29/0x40 kernel/locking/irqflag-debug.c:10
> Modules linked in:
> CPU: 1 PID: 7785 Comm: syz-executor.3 Not tainted 6.8.0-syzkaller-05236-g443574b03387 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> RIP: 0010:warn_bogus_irq_restore+0x29/0x40 kernel/locking/irqflag-debug.c:10
> Code: 90 f3 0f 1e fa 90 80 3d de 59 01 04 00 74 06 90 c3 cc cc cc cc c6 05 cf 59 01 04 01 90 48 c7 c7 20 ba aa 8b e8 f8 d5 e7 f5 90 <0f> 0b 90 90 90 c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
> RSP: 0018:ffffc9000399fbb8 EFLAGS: 00010246
>
> RAX: 4aede97b00455d00 RBX: 1ffff92000733f7c RCX: ffff88802a129e00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc9000399fc50 R08: ffffffff8157cc12 R09: 1ffff110172a51a2
> R10: dffffc0000000000 R11: ffffed10172a51a3 R12: dffffc0000000000
> R13: 1ffff92000733f78 R14: ffffc9000399fbe0 R15: 0000000000000246
> FS:  000055557ae76480(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffc27e190f8 CR3: 000000006cb50000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
>   _raw_spin_unlock_irqrestore+0x120/0x140 kernel/locking/spinlock.c:194
>   spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
>   unlock_task_sighand include/linux/sched/signal.h:754 [inline]
>   do_send_sig_info kernel/signal.c:1302 [inline]
>   group_send_sig_info+0x2e0/0x310 kernel/signal.c:1453
>   bpf_send_signal_common+0x2dd/0x430 kernel/trace/bpf_trace.c:881
>   ____bpf_send_signal kernel/trace/bpf_trace.c:886 [inline]
>   bpf_send_signal+0x19/0x30 kernel/trace/bpf_trace.c:884
>   bpf_prog_8cc4ff36b5985b6a+0x1d/0x1f
>   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>   __bpf_prog_run include/linux/filter.h:650 [inline]
>   bpf_prog_run include/linux/filter.h:664 [inline]
>   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
>   bpf_trace_run2+0x375/0x420 kernel/trace/bpf_trace.c:2420
>   trace_sys_exit include/trace/events/syscalls.h:44 [inline]
>   syscall_exit_work+0x153/0x170 kernel/entry/common.c:163
>   syscall_exit_to_user_mode_prepare kernel/entry/common.c:194 [inline]
>   __syscall_exit_to_user_mode_work kernel/entry/common.c:199 [inline]
>   syscall_exit_to_user_mode+0x273/0x360 kernel/entry/common.c:212
>   do_syscall_64+0x10a/0x240 arch/x86/entry/common.c:89
>   entry_SYSCALL_64_after_hwframe+0x6d/0x75

The following are related functions.

struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
                                            unsigned long *flags)
{
         struct sighand_struct *sighand;

         rcu_read_lock();
         for (;;) {
                 sighand = rcu_dereference(tsk->sighand);
                 if (unlikely(sighand == NULL))
                         break;

                 /*
                  * This sighand can be already freed and even reused, but
                  * we rely on SLAB_TYPESAFE_BY_RCU and sighand_ctor() which
                  * initializes ->siglock: this slab can't go away, it has
                  * the same object type, ->siglock can't be reinitialized.
                  *
                  * We need to ensure that tsk->sighand is still the same
                  * after we take the lock, we can race with de_thread() or
                  * __exit_signal(). In the latter case the next iteration
                  * must see ->sighand == NULL.
                  */
                 spin_lock_irqsave(&sighand->siglock, *flags);
                 if (likely(sighand == rcu_access_pointer(tsk->sighand)))
                         break;
                 spin_unlock_irqrestore(&sighand->siglock, *flags);
         }
         rcu_read_unlock();

         return sighand;
}

static inline struct sighand_struct *lock_task_sighand(struct task_struct *task,
                                                        unsigned long *flags)
{
         struct sighand_struct *ret;

         ret = __lock_task_sighand(task, flags);
         (void)__cond_lock(&task->sighand->siglock, ret);
         return ret;
}


static inline void unlock_task_sighand(struct task_struct *task,
                                                 unsigned long *flags)
{
         spin_unlock_irqrestore(&task->sighand->siglock, *flags);
}

int do_send_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *p,
                         enum pid_type type)
{
         unsigned long flags;
         int ret = -ESRCH;

         if (lock_task_sighand(p, &flags)) {
                 ret = send_signal_locked(sig, info, p, type);
                 unlock_task_sighand(p, &flags);
         }
         
         return ret;
}

If p->sighand changed between lock_task_sighand() and unlock_task_sighand(),
the warning makes sense. But I am not sure whether and how this could happen.

> RIP: 0033:0x7f8e47e7dc0b
> Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> RSP: 002b:00007ffd999e9950 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: fffffffffffffffa RBX: 0000000000000003 RCX: 00007f8e47e7dc0b
> RDX: 0000000000000000 RSI: 0000000000004c01 RDI: 0000000000000003
> RBP: 00007ffd999e9a0c R08: 0000000000000000 R09: 00007ffd999e96f7
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000032
> R13: 000000000004757a R14: 000000000004754c R15: 000000000000000f
>   </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>

