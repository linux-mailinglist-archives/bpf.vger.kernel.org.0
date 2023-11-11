Return-Path: <bpf+bounces-14812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D74967E86DB
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 01:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0391C20A03
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 00:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416A6185B;
	Sat, 11 Nov 2023 00:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DB31849
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 00:17:31 +0000 (UTC)
Received: from mail-pf1-f206.google.com (mail-pf1-f206.google.com [209.85.210.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3539B3C39
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 16:17:29 -0800 (PST)
Received: by mail-pf1-f206.google.com with SMTP id d2e1a72fcca58-6bf2b098e43so2478689b3a.3
        for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 16:17:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699661848; x=1700266648;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FlObPBRipr7QG5n1UjlXxQ9MYBDyrAAHU5ysht5qkY0=;
        b=BTQkZ4vL7Lpu7014Jbvt2va+cKAXsjG9MvEMvgbu1DvYHKglGRDq0O7RZq12rZjr6p
         UPGQZ1gzfqRgDQYdJ9hZf0YJ/Ynh6gjnNbs+PiLx3tdax3zm/A9F684pm+xCbjKmAduF
         goB5QFfB+vuusDmNkfxQry0YBWaEyVakQDnxzsu0BiJd1p9nCPsWH1XNqKAjd70r8YY0
         tGT32Iat9v+xNSIW23AQdW5eNgTfHZlqK7GIO9BuS5NzeN750B3e617hqwrFTNm0bK74
         7O4OESXfRe2ujfZE6ZIYrVCInJpZpEYoD6VmXWtrdXLRtQVMaH+NKUkKvzw0mLg0U+0j
         UE+w==
X-Gm-Message-State: AOJu0YzzAnFh7jBkTK6X2XIuRGZkjziC3d4fMoj3ePxWCxj83scSNBkm
	y2TI9BkgHeWbbx+Sv4GDHbNfAG43iA/MgjhTouxX9Mx2w+Gy
X-Google-Smtp-Source: AGHT+IEIOkL5pWDPSteicMdD+j6LEq4q7tbzXlkjH8awDFC6XuXC+TGeVENj8rcRv3n/BApbU7E5uxDU5NX0gIMpBgo9oT3JjvHm
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a62:d45c:0:b0:6be:3dca:7d9d with SMTP id
 u28-20020a62d45c000000b006be3dca7d9dmr140697pfl.5.1699661848662; Fri, 10 Nov
 2023 16:17:28 -0800 (PST)
Date: Fri, 10 Nov 2023 16:17:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba5cfd0609d55c40@google.com>
Subject: [syzbot] [bpf?] INFO: rcu detected stall in sys_unshare (9)
From: syzbot <syzbot+872bccd9a68c6ba47718@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d2f51b3516da Merge tag 'rtc-6.7' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f706eb680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ffa1cec3b40f3ce
dashboard link: https://syzkaller.appspot.com/bug?extid=872bccd9a68c6ba47718
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1156a047680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1400ef87680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/38e8e9ac2457/disk-d2f51b35.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b68cb55b3341/vmlinux-d2f51b35.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a16207c0a2b9/bzImage-d2f51b35.xz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b50a5b680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11b50a5b680000
console output: https://syzkaller.appspot.com/x/log.txt?x=16b50a5b680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+872bccd9a68c6ba47718@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5082/1:b..l
rcu: 	(detected by 0, t=10503 jiffies, g=4817, q=37 ncpus=2)
task:syz-executor172 state:R  running task     stack:27680 pid:5082  tgid:5082  ppid:5079   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0xee2/0x59a0 kernel/sched/core.c:6688
 preempt_schedule_irq+0x52/0x90 kernel/sched/core.c:7008
 irqentry_exit+0x35/0x80 kernel/entry/common.c:432
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:lock_acquire+0x1ef/0x510 kernel/locking/lockdep.c:5721
Code: c1 05 dd 7d 99 7e 83 f8 01 0f 85 b0 02 00 00 9c 58 f6 c4 02 0f 85 9b 02 00 00 48 85 ed 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01 c3 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 48 8b 84 24
RSP: 0018:ffffc90003c6f6f8 EFLAGS: 00000206
RAX: dffffc0000000000 RBX: 1ffff9200078dee1 RCX: 0000000000000001
RDX: 1ffff11002ffd157 RSI: ffffffff8accbc20 RDI: ffffffff8b2e7fc0
RBP: 0000000000000200 R08: 0000000000000000 R09: fffffbfff23e2bd0
R10: ffffffff91f15e87 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffff8cfacfe0 R15: 0000000000000000
 rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 rcu_read_lock include/linux/rcupdate.h:747 [inline]
 is_bpf_text_address+0x36/0x1a0 kernel/bpf/core.c:733
 kernel_text_address kernel/extable.c:125 [inline]
 kernel_text_address+0x85/0xf0 kernel/extable.c:94
 __kernel_text_address+0xd/0x30 kernel/extable.c:79
 unwind_get_return_address+0x78/0xe0 arch/x86/kernel/unwind_orc.c:369
 arch_stack_walk+0xbe/0x170 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x96/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1007 [inline]
 __kmalloc+0x60/0x100 mm/slab_common.c:1020
 kmalloc_array include/linux/slab.h:637 [inline]
 kcalloc include/linux/slab.h:668 [inline]
 cache_create_net+0xa0/0x220 net/sunrpc/cache.c:1749
 rsi_cache_create_net net/sunrpc/auth_gss/svcauth_gss.c:2033 [inline]
 gss_svc_init_net+0x122/0x660 net/sunrpc/auth_gss/svcauth_gss.c:2093
 ops_init+0xb9/0x650 net/core/net_namespace.c:136
 setup_net+0x422/0xa40 net/core/net_namespace.c:339
 copy_net_ns+0x2fa/0x670 net/core/net_namespace.c:491
 create_new_namespaces+0x3ea/0xb10 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc1/0x1f0 kernel/nsproxy.c:228
 ksys_unshare+0x443/0x9b0 kernel/fork.c:3433
 __do_sys_unshare kernel/fork.c:3504 [inline]
 __se_sys_unshare kernel/fork.c:3502 [inline]
 __x64_sys_unshare+0x31/0x40 kernel/fork.c:3502
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f00801172f7
RSP: 002b:00007ffd109dd1d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007ffd109dd208 RCX: 00007f00801172f7
RDX: 00007f0080115e79 RSI: 00007ffd109dd280 RDI: 0000000040000000
RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000555556d1d370
R13: 0000000000000003 R14: 0000000000000003 R15: 00007ffd109dd240
 </TASK>
rcu: rcu_preempt kthread starved for 10544 jiffies! g4817 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27632 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0xee2/0x59a0 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6778
 schedule_timeout+0x157/0x2c0 kernel/time/timer.c:2167
 rcu_gp_fqs_loop+0x1ec/0xb10 kernel/rcu/tree.c:1626
 rcu_gp_kthread+0x249/0x380 kernel/rcu/tree.c:1825
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5110 Comm: syz-executor172 Not tainted 6.6.0-syzkaller-14651-gd2f51b3516da #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:__lock_acquire+0x16/0x5de0 kernel/locking/lockdep.c:4992
Code: 00 e9 58 fe ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 41 57 41 89 cf 49 89 fa 48 b9 00 00 00 00 00 fc ff df 41 56 41 55 <41> 89 f5 41 54 41 89 d4 55 44 89 cd 53 48 81 ec 10 01 00 00 48 8b
RSP: 0018:ffffc90003e0fba0 EFLAGS: 00000006
RAX: 0000000000000200 RBX: 1ffff920007c1f7f RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888079bed720
RBP: 0000000000000200 R08: 0000000000000001 R09: 0000000000000000
R10: ffff888079bed720 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: ffff888079bed720 R15: 0000000000000001
FS:  0000555556d1d3c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f008012d4c0 CR3: 000000006f293000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
 __might_fault mm/memory.c:5955 [inline]
 __might_fault+0x11f/0x1a0 mm/memory.c:5948
 clear_rseq_cs kernel/rseq.c:257 [inline]
 rseq_ip_fixup kernel/rseq.c:291 [inline]
 __rseq_handle_notify_resume+0xd5b/0x1010 kernel/rseq.c:329
 rseq_handle_notify_resume include/linux/sched.h:2361 [inline]
 rseq_signal_deliver include/linux/sched.h:2370 [inline]
 setup_rt_frame arch/x86/kernel/signal.c:211 [inline]
 handle_signal arch/x86/kernel/signal.c:266 [inline]
 arch_do_signal_or_restart+0x431/0x7f0 arch/x86/kernel/signal.c:311
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:296
 do_syscall_64+0x4b/0x110 arch/x86/entry/common.c:88
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f0080115e79
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd109dd1d8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00007f0080115e79
RDX: 000000002006b000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000555556d1d370
R13: 0000000000000002 R14: 00007ffd109dd250 R15: 00007ffd109dd240
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

