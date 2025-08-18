Return-Path: <bpf+bounces-65882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2870B2A3F4
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 15:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9741717B6
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 13:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0EB31E0F1;
	Mon, 18 Aug 2025 13:03:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B6731E0E4
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522215; cv=none; b=Mxq/fWNc5tXcOGil5Z1Q6Azu9wcWVxhaX7dFwPu6Kpq2Xm5iblGZrldIoLKzxknHwAP4INTUNq3zFetmRsqlCTzirSAf+Kkb90IUeHawzpLwZe7kpl6wBfTDmmkA15WA93JJFSwtXwRodhqvbMs0zIPK2P9wgpMd+9GGRS/RAAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522215; c=relaxed/simple;
	bh=VWQDe+tdPUG9+IU46gdoK6WXGm8lfqys7RG0ouhkjNk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EW6Wg1MzqU0DwiP/xDPEkdmYiRzrMwj+v2iMNAzKbLirCFcNS6qLnrxKdccgxmtXZLn8zzniwCqwHwPmL6joBPzPmXv1WjxjIQHNkzdzSNIvJgT8Fe40A3WGiZcR0EI1QGF5aVGm9wJSwzDiX87gEH5qpuiT+zqIgBvJswF+YRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-88432cb7627so415047239f.0
        for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 06:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755522213; x=1756127013;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J6D/MLSyEOvx+mf01Y+3hlSzu1UvpzFqY9eDSOwkeYQ=;
        b=P5EpcnSjY6nPLRi7BJGDagwmOzN6KUKP00MBIL6vjTss5OBnSfCrzSqiVPHtxVVUZV
         cZrS/pQfKm3gTv33qzZ/9gkZbLuzRxRbP/tIAAB1iYBEnmgnF1O34DioikcGPORCW1gC
         6kYJK+CcZ+dpnJNaN3YFKD2VtSnWUCxhE78rLl+EYNrQs2ZCi1t+5yWIrKpIg8J2Jhx9
         3LL8GRctiWy/+7zGaDPQ4mywsAEnzImZn9ivttlpDP0UGDAcbOMSLH+jyKQvLTgNA5zc
         w7oeUO68KJf9gvk3Z2JqwJtx4xBSqZLSnxC+XgvbwKx1HAF/pTw23UwC01uI/+WPXpHL
         zFsA==
X-Forwarded-Encrypted: i=1; AJvYcCUFHD+LEPTz9hsL79m2oU6kNk6qfE9DdQcDDLa+S4cIv3bvet95/zloe0s4W3SHfznUi1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXumuCLuIDdaYAWYus2mDnhuN7rSb1NYtMuy+Pjl7+4oTJFpiD
	KBzKVb/J3GjKfBqxlfYETL4EZDKZrrMYsB01t6zFAHCMWZAl/5FJS+ZGueDC/noWBzCYdfjT35w
	uNKo5EzPqzy+iAIVCy9NRCDhAEw9SetHqJ34QDZxVx6wfcxagddSiiKWpi0M=
X-Google-Smtp-Source: AGHT+IGjcDaJWe46xzthBaKdKkQgFfnYtUt9n3274K0vkPhMdTkgnX2cWwcPvLSiwFEJ/BcNafUkJRyQBJL0w96L+uBEZP5YpK8M
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ea:b0:3e5:5466:1aa2 with SMTP id
 e9e14a558f8ab-3e57e7fd2b0mr214245375ab.10.1755522212847; Mon, 18 Aug 2025
 06:03:32 -0700 (PDT)
Date: Mon, 18 Aug 2025 06:03:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a324a4.050a0220.e29e5.00a8.GAE@google.com>
Subject: [syzbot] [bpf?] INFO: rcu detected stall in task_work_add
From: syzbot <syzbot+f2cf09711ff194bc2c22@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3b5ca25ecfa8 Merge branch 'net-don-t-use-pk-through-printk..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=104365a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ae1da3a7f4a6ba4
dashboard link: https://syzkaller.appspot.com/bug?extid=f2cf09711ff194bc2c22
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140b0da2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3a41dee6422d/disk-3b5ca25e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/37991dc02c89/vmlinux-3b5ca25e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48eac1c2fff5/bzImage-3b5ca25e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f2cf09711ff194bc2c22@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P6488/1:b..l
rcu: 	(detected by 1, t=10502 jiffies, g=19581, q=865 ncpus=2)
task:syz.6.33        state:R  running task     stack:25096 pid:6488  tgid:6488  ppid:6264   task_flags:0x400040 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7288
 irqentry_exit+0x6f/0x90 kernel/entry/common.c:197
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x175/0x360 kernel/locking/lockdep.c:5872
Code: 00 00 00 00 9c 8f 44 24 30 f7 44 24 30 00 02 00 00 0f 85 cd 00 00 00 f7 44 24 08 00 02 00 00 74 01 fb 65 48 8b 05 eb 93 02 11 <48> 3b 44 24 58 0f 85 f2 00 00 00 48 83 c4 60 5b 41 5c 41 5d 41 5e
RSP: 0018:ffffc900047776f0 EFLAGS: 00000206
RAX: c2093f235efbe900 RBX: 0000000000000000 RCX: c2093f235efbe900
RDX: 0000000000000001 RSI: ffffffff8dba39e3 RDI: ffffffff8be32680
RBP: ffffffff81cea1f6 R08: 0000000000000000 R09: ffffffff81cea1f6
R10: ffffc90004777878 R11: ffffffff81ac3890 R12: 0000000000000002
R13: ffffffff8e139ee0 R14: 0000000000000000 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:841 [inline]
 is_bpf_text_address+0x47/0x2b0 kernel/bpf/core.c:776
 kernel_text_address+0xa5/0xe0 kernel/extable.c:125
 __kernel_text_address+0xd/0x40 kernel/extable.c:79
 unwind_get_return_address+0x4d/0x90 arch/x86/kernel/unwind_orc.c:369
 arch_stack_walk+0xfc/0x150 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
 task_work_add+0xb1/0x420 kernel/task_work.c:65
 __fput_deferred+0x154/0x390 fs/file_table.c:529
 fput_close+0x119/0x200 fs/file_table.c:585
 filp_close+0x27/0x40 fs/open.c:1561
 __range_close fs/file.c:767 [inline]
 __do_sys_close_range fs/file.c:826 [inline]
 __se_sys_close_range+0x359/0x650 fs/file.c:790
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fed93f8ebe9
RSP: 002b:00007ffcb5611318 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: ffffffffffffffda RBX: 00007fed941b7da0 RCX: 00007fed93f8ebe9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007fed941b7da0 R08: 0000000000000000 R09: 00000006b561160f
R10: 00007fed941b7cb0 R11: 0000000000000246 R12: 0000000000057219
R13: 00007fed941b6090 R14: ffffffffffffffff R15: 0000000000000003
 </TASK>
rcu: rcu_preempt kthread starved for 1596 jiffies! g19581 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27160 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 UID: 0 PID: 6401 Comm: napi/wg0-0 Not tainted 6.16.0-syzkaller-12122-g3b5ca25ecfa8 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:finish_task_switch+0x26b/0x950 kernel/sched/core.c:5225
Code: 0f 84 3c 01 00 00 48 85 db 0f 85 63 01 00 00 0f 1f 44 00 00 4c 8b 75 d0 4c 89 e7 e8 cf 37 ea 09 e8 5a 3f 36 00 fb 4c 8b 65 c0 <49> 8d bc 24 18 16 00 00 48 89 f8 48 c1 e8 03 42 0f b6 04 28 84 c0
RSP: 0018:ffffc9000458fa78 EFLAGS: 00000286
RAX: e330458c080e4500 RBX: 0000000000000000 RCX: e330458c080e4500
RDX: 0000000000000000 RSI: ffffffff8d9b49fa RDI: ffffffff8be32680
RBP: ffffc9000458fad0 R08: ffffffff8fa34737 R09: 1ffffffff1f468e6
R10: dffffc0000000000 R11: fffffbfff1f468e7 R12: ffff8880252d0000
R13: dffffc0000000000 R14: ffff8880256a3c00 R15: ffff8880b873ab58
FS:  0000000000000000(0000) GS:ffff888125d21000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ea52750000 CR3: 0000000077f62000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5360 [inline]
 __schedule+0x17a0/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 napi_thread_wait net/core/dev.c:7583 [inline]
 napi_threaded_poll+0xfa/0x2b0 net/core/dev.c:7634
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

