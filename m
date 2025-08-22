Return-Path: <bpf+bounces-66275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BEFB31998
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 15:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB3F16A3D3
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 13:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A15E2FE59C;
	Fri, 22 Aug 2025 13:27:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A8B2FE585
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869258; cv=none; b=aBxsPvSSzZYg+f7VP9FGDlzUrLCOz40p7Dz1kL2mj3W0Tf2wjuLpvi9aFTxfgu/QyB26k9b3khuCmsFbj79h9Hk8kgSs/YQbMeLl7iNJxOlv2rIH6W/saQOFFPAuqxNfmO16lByWy2gJT+6VoQxhoKy3vfrRidQoAu0rayJw3ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869258; c=relaxed/simple;
	bh=h0SJ7PIeyitHm5/b5//7LAQEmr5OEKHhZHDu/HzwNNQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=STgkHYFYSRurX/+hydTvk4lGp7RTbKKphHI503hE0Ei2ottjTWXvzw3HpPOY6OhrUyS3eRU/vE9hZ5QWxhO7Rg74HQg0zJrX1btcA/XSlkIe8mmQFQIOkUZGPrHjOzuXgMRq6tp/hD4+fdUkWQlO9ADV9Bp4RLhMJzQjbGccDTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-88428cc6d2fso377222039f.1
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 06:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869255; x=1756474055;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J53L8+/pP9d7e5hkG9Rhd2A6MzVCvZ29BchM0nf5SxA=;
        b=GARSKUS+Ko13C0n8+ZDDVl1vGXLhcrHUt6DCIB5vO9mAwP/5vNqAaZLUmTQmd3SFWd
         DCD3qYViMey3TiCKE8DiFB69mCOKg76OIAplQuRPio5+k05PU4dSNgEzqSIZWTmTG3fh
         VLA07g4t/FW08hBl/GKx7W1URFSrA0mwpxLgPWEfO3FaFcl1uM/RAKinS3SU2BdDWBqY
         QfDbgkXHROosRKK1rddSrEyfV3F4PgGBJbGwTMxHZmRrnNS+TvtDpWQxI7Bvn2FjTNEz
         +m/azOAemqw80qG1T2qBQGldUc7DtE/2GdOI6mqHw+Sq94oR/+qYO8A/z05LT6Ltzf82
         Fqgw==
X-Forwarded-Encrypted: i=1; AJvYcCW+aupWkWlVN+YEJn1+4IUvyYPY1UG398niDsq3u2FM0rXPelA/8LrwZQ9tUs6iY8Dj63g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvTY4aIeJNIhvmFgGr8grZ2fD83YNNOkfk8sxqX3PhOux8Y34W
	DL7KHGHy14NhXN+qAcIiam7N0eJVqNBiJyWwFuQGRyg3GA+mTJ8hO8TQBFIpIiUgRRPpPglX72p
	r72hWRqTQmerZi1eph482XbZGYZhQOn4swyomGKOWHIidV/pD+HaxFeZ2BAw=
X-Google-Smtp-Source: AGHT+IGcJ7qplXs6cXaqSqYlY0SE0YtHIceXsys7pz1MBO1NO4Ou84fX0HFJhAgjYSVX986H6vMdnDJmbj3dtaIC9cGt9SaUehIj
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3991:b0:3de:e74:be13 with SMTP id
 e9e14a558f8ab-3e6d0827bafmr116888775ab.0.1755869255578; Fri, 22 Aug 2025
 06:27:35 -0700 (PDT)
Date: Fri, 22 Aug 2025 06:27:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a87047.a00a0220.33401d.0258.GAE@google.com>
Subject: [syzbot] [mm?] BUG: soft lockup in dev_ioctl (2)
From: syzbot <syzbot+e65a4f7e08397dea6c3f@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev, 
	mathieu.desnoyers@efficios.com, mattbobrowski@google.com, mhiramat@kernel.org, 
	netdev@vger.kernel.org, rostedt@goodmis.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    91dbac407653 Use thread-safe function pointer in libbpf_pr..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14d3e368580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=90837c100b88a636
dashboard link: https://syzkaller.appspot.com/bug?extid=e65a4f7e08397dea6c3f
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6286b507cb31/disk-91dbac40.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ab49bacbdcaa/vmlinux-91dbac40.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e6fe8f0d9e6a/bzImage-91dbac40.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e65a4f7e08397dea6c3f@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#1 stuck for 144s! [syz.3.20:5985]
Modules linked in:
irq event stamp: 11376505
hardirqs last  enabled at (11376504): [<ffffffff8b5533c4>] irqentry_exit+0x74/0x90 kernel/entry/common.c:357
hardirqs last disabled at (11376505): [<ffffffff8b551dbe>] sysvec_apic_timer_interrupt+0xe/0xc0 arch/x86/kernel/apic/apic.c:1049
softirqs last  enabled at (146114): [<ffffffff8185c3da>] __do_softirq kernel/softirq.c:613 [inline]
softirqs last  enabled at (146114): [<ffffffff8185c3da>] invoke_softirq kernel/softirq.c:453 [inline]
softirqs last  enabled at (146114): [<ffffffff8185c3da>] __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
softirqs last disabled at (146117): [<ffffffff8185c3da>] __do_softirq kernel/softirq.c:613 [inline]
softirqs last disabled at (146117): [<ffffffff8185c3da>] invoke_softirq kernel/softirq.c:453 [inline]
softirqs last disabled at (146117): [<ffffffff8185c3da>] __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
CPU: 1 UID: 0 PID: 5985 Comm: syz.3.20 Not tainted 6.15.0-rc3-syzkaller-g91dbac407653 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
RIP: 0010:check_kcov_mode kernel/kcov.c:183 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x28/0x70 kernel/kcov.c:217
Code: 90 90 f3 0f 1e fa 48 8b 04 24 65 48 8b 0c 25 08 00 75 92 65 8b 15 98 42 b5 10 81 e2 00 01 ff 00 74 11 81 fa 00 01 00 00 75 35 <83> b9 3c 16 00 00 00 74 2c 8b 91 18 16 00 00 83 fa 02 75 21 48 8b
RSP: 0018:ffffc90000a07eb8 EFLAGS: 00000246
RAX: ffffffff81cad2c6 RBX: 0000000000000001 RCX: ffff888031285a00
RDX: 0000000000000100 RSI: ffffe8ffffda3000 RDI: ffffffff8de0ab40
RBP: ffffc90000a07fb8 R08: 0000000000000001 R09: ffff8880b8932608
R10: dffffc0000000000 R11: fffff91ffffb4605 R12: ffffe8ffffda3000
R13: 1ffff92000140fe4 R14: ffff8880b8932608 R15: ffffffff8de0ab40
FS:  00007f8b2ed396c0(0000) GS:ffff8881261d0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ff03ff8 CR3: 000000001128c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 trace_call_bpf+0x76/0x850 kernel/trace/bpf_trace.c:111
 perf_trace_run_bpf_submit+0x78/0x170 kernel/events/core.c:10788
 do_perf_trace_lock include/trace/events/lock.h:50 [inline]
 perf_trace_lock+0x2f8/0x3b0 include/trace/events/lock.h:50
 __do_trace_lock_release include/trace/events/lock.h:69 [inline]
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release+0x3b2/0x3e0 kernel/locking/lockdep.c:5877
 rcu_lock_release include/linux/rcupdate.h:341 [inline]
 rcu_read_unlock include/linux/rcupdate.h:871 [inline]
 class_rcu_destructor include/linux/rcupdate.h:1155 [inline]
 unwind_next_frame+0x19a9/0x2390 arch/x86/kernel/unwind_orc.c:680
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4161 [inline]
 slab_alloc_node mm/slub.c:4210 [inline]
 kmem_cache_alloc_node_noprof+0x1bb/0x3c0 mm/slub.c:4262
 kmalloc_reserve+0xbd/0x290 net/core/skbuff.c:577
 __alloc_skb+0x142/0x2d0 net/core/skbuff.c:668
 napi_alloc_skb+0x84/0x7d0 net/core/skbuff.c:810
 page_to_skb+0x233/0x8d0 drivers/net/virtio_net.c:840
 receive_mergeable drivers/net/virtio_net.c:2430 [inline]
 receive_buf+0x302/0x1580 drivers/net/virtio_net.c:2568
 virtnet_receive_packets drivers/net/virtio_net.c:2926 [inline]
 virtnet_receive drivers/net/virtio_net.c:2950 [inline]
 virtnet_poll+0x1f9b/0x2d70 drivers/net/virtio_net.c:3045
 __napi_poll+0xc4/0x480 net/core/dev.c:7324
 napi_poll net/core/dev.c:7388 [inline]
 net_rx_action+0x6ea/0xdf0 net/core/dev.c:7510
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:_compound_head include/linux/page-flags.h:282 [inline]
RIP: 0010:virt_to_folio include/linux/mm.h:1404 [inline]
RIP: 0010:virt_to_slab mm/slab.h:211 [inline]
RIP: 0010:kasan_addr_to_slab+0x30/0x90 mm/kasan/common.c:38
Code: 89 fb e8 13 a5 51 ff 84 c0 74 46 48 89 df e8 07 a3 51 ff 48 c1 e8 06 48 83 e0 c0 48 ba 00 00 00 00 00 ea ff ff 48 8b 4c 10 08 <f6> c1 01 75 48 48 01 d0 66 90 0f b6 48 33 c1 e1 18 31 d2 81 f9 00
RSP: 0018:ffffc9000538f738 EFLAGS: 00000202
RAX: 0000000000c71740 RBX: ffff888031c5d390 RCX: ffffea0000c71601
RDX: ffffea0000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000538f870 R08: ffffc9000538f4cf R09: 0000000000000000
R10: ffffc9000538f4c0 R11: ffffffffa0002018 R12: dffffc0000000000
R13: 1ffff92000a71ef8 R14: ffffffff8184d770 R15: 0000000000000000
 kasan_record_aux_stack+0xf/0xd0 mm/kasan/generic.c:533
 __call_rcu_common kernel/rcu/tree.c:3082 [inline]
 call_rcu+0x142/0x990 kernel/rcu/tree.c:3202
 context_switch kernel/sched/core.c:5385 [inline]
 __schedule+0x16ea/0x4cd0 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6860
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6917
 __mutex_lock_common kernel/locking/mutex.c:678 [inline]
 __mutex_lock+0x724/0xe80 kernel/locking/mutex.c:746
 rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 dev_ioctl+0x5dc/0x1150 net/core/dev_ioctl.c:774
 sock_do_ioctl+0x22c/0x300 net/socket.c:1204
 sock_ioctl+0x576/0x790 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8b2df8e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8b2ed39038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f8b2e1b5fa0 RCX: 00007f8b2df8e969
RDX: 0000200000000140 RSI: 0000000000008923 RDI: 0000000000000005
RBP: 00007f8b2e010ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f8b2e1b5fa0 R15: 00007ffcb2fa33f8
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5992 Comm: syz.2.21 Not tainted 6.15.0-rc3-syzkaller-g91dbac407653 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
RIP: 0010:io_serial_in+0x77/0xc0 drivers/tty/serial/8250/8250_port.c:409
Code: e8 2e ae 82 fc 44 89 f9 d3 e3 49 83 c6 40 4c 89 f0 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 f7 e8 9f 9e e4 fc 41 03 1e 89 da ec <0f> b6 c0 5b 41 5c 41 5e 41 5f c3 cc cc cc cc cc 44 89 f9 80 e1 07
RSP: 0018:ffffc90000006518 EFLAGS: 00000006
RAX: 1ffffffff3368f05 RBX: 00000000000003f9 RCX: 0000000000000000
RDX: 00000000000003f9 RSI: 0000000000000000 RDI: 0000000000000020
RBP: ffffc900000066f0 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: ffffffff853d0f00 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffffffff99b47bc0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881260d0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555913105c8 CR3: 00000000613ee000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 serial_port_in include/linux/serial_core.h:791 [inline]
 serial8250_console_write+0x581/0x1ba0 drivers/tty/serial/8250/8250_port.c:3420
 console_emit_next_record kernel/printk/printk.c:3138 [inline]
 console_flush_all+0x725/0xc40 kernel/printk/printk.c:3226
 __console_flush_and_unlock kernel/printk/printk.c:3285 [inline]
 console_unlock+0xc4/0x270 kernel/printk/printk.c:3325
 vprintk_emit+0x5b7/0x7a0 kernel/printk/printk.c:2450
 _printk+0xcf/0x120 kernel/printk/printk.c:2475
 print_other_cpu_stall+0x189/0x1370 kernel/rcu/tree_stall.h:598
 check_cpu_stall kernel/rcu/tree_stall.h:795 [inline]
 rcu_pending kernel/rcu/tree.c:3630 [inline]
 rcu_sched_clock_irq+0x9cb/0x1080 kernel/rcu/tree.c:2669
 update_process_times+0x23c/0x2f0 kernel/time/timer.c:2515
 tick_sched_handle kernel/time/tick-sched.c:276 [inline]
 tick_nohz_handler+0x39a/0x520 kernel/time/tick-sched.c:297
 __run_hrtimer kernel/time/hrtimer.c:1761 [inline]
 __hrtimer_run_queues+0x4dd/0xc60 kernel/time/hrtimer.c:1825
 hrtimer_interrupt+0x45b/0xaa0 kernel/time/hrtimer.c:1887
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x108/0x410 arch/x86/kernel/apic/apic.c:1055
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1049
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:skb_queue_len_lockless include/linux/skbuff.h:-1 [inline]
RIP: 0010:enqueue_to_backlog+0x12e/0xf40 net/core/dev.c:5076
Code: 8b 2f 48 8d 9d 80 b5 76 92 48 89 d8 48 c1 e8 03 48 89 44 24 60 42 0f b6 04 28 84 c0 0f 85 d1 09 00 00 48 89 5c 24 38 44 8b 3b <48> c7 c0 84 6d c6 8d 48 c1 e8 03 42 0f b6 04 28 84 c0 0f 85 ce 09
RSP: 0018:ffffc90000007198 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff8880b883b580 RCX: ffff888031c58000
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000008
RBP: ffff8881260d0000 R08: ffff88807e53a0af R09: 1ffff1100fca7415
R10: dffffc0000000000 R11: ffffed100fca7416 R12: ffff888033b91790
R13: dffffc0000000000 R14: 1ffff110067722f2 R15: 000000000000000e
 netif_rx_internal+0x130/0x560 net/core/dev.c:5401
 __netif_rx+0x78/0xc0 net/core/dev.c:5421
 veth_forward_skb drivers/net/veth.c:323 [inline]
 veth_xmit+0x55d/0xa00 drivers/net/veth.c:376
 __netdev_start_xmit include/linux/netdevice.h:5203 [inline]
 netdev_start_xmit include/linux/netdevice.h:5212 [inline]
 xmit_one net/core/dev.c:3776 [inline]
 dev_hard_start_xmit+0x2ff/0x880 net/core/dev.c:3792
 __dev_queue_xmit+0x1adf/0x3a70 net/core/dev.c:4629
 dev_queue_xmit include/linux/netdevice.h:3350 [inline]
 neigh_hh_output include/net/neighbour.h:523 [inline]
 neigh_output include/net/neighbour.h:537 [inline]
 ip6_finish_output2+0x11bc/0x16a0 net/ipv6/ip6_output.c:141
 __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
 ip6_finish_output+0x234/0x7d0 net/ipv6/ip6_output.c:226
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ndisc_send_skb+0xb47/0x1400 net/ipv6/ndisc.c:513
 addrconf_rs_timer+0x369/0x670 net/ipv6/addrconf.c:4038
 call_timer_fn+0x17b/0x5f0 kernel/time/timer.c:1789
 expire_timers kernel/time/timer.c:1840 [inline]
 __run_timers kernel/time/timer.c:2414 [inline]
 __run_timer_base+0x61a/0x860 kernel/time/timer.c:2426
 run_timer_base kernel/time/timer.c:2435 [inline]
 run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2445
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:check_kcov_mode kernel/kcov.c:194 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x37/0x70 kernel/kcov.c:217
Code: 08 00 75 92 65 8b 15 98 42 b5 10 81 e2 00 01 ff 00 74 11 81 fa 00 01 00 00 75 35 83 b9 3c 16 00 00 00 74 2c 8b 91 18 16 00 00 <83> fa 02 75 21 48 8b 91 20 16 00 00 48 8b 32 48 8d 7e 01 8b 89 1c
RSP: 0018:ffffc9000559f1e8 EFLAGS: 00000246
RAX: ffffffff81ef4d52 RBX: 0000000000000000 RCX: ffff888031c58000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88801d53514f R09: 1ffff11003aa6a29
R10: dffffc0000000000 R11: ffffed1003aa6a2a R12: 1ffff1100638b285
R13: dffffc0000000000 R14: ffff888031c5942c R15: dffffc0000000000
 get_recursion_context kernel/events/internal.h:220 [inline]
 perf_swevent_get_recursion_context+0xb2/0x100 kernel/events/core.c:10474
 perf_trace_buf_alloc+0x59/0x2a0 kernel/trace/trace_event_perf.c:410
 do_perf_trace_lock include/trace/events/lock.h:50 [inline]
 perf_trace_lock+0x18d/0x3b0 include/trace/events/lock.h:50
 __do_trace_lock_release include/trace/events/lock.h:69 [inline]
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release+0x3b2/0x3e0 kernel/locking/lockdep.c:5877
 rcu_lock_release include/linux/rcupdate.h:341 [inline]
 rcu_read_unlock include/linux/rcupdate.h:871 [inline]
 page_table_check_clear+0x4b0/0x6e0 mm/page_table_check.c:89
 ptep_get_and_clear_full arch/x86/include/asm/jump_label.h:-1 [inline]
 get_and_clear_full_ptes include/linux/pgtable.h:714 [inline]
 zap_present_folio_ptes mm/memory.c:1501 [inline]
 zap_present_ptes mm/memory.c:1586 [inline]
 do_zap_pte_range mm/memory.c:1687 [inline]
 zap_pte_range mm/memory.c:1731 [inline]
 zap_pmd_range mm/memory.c:1823 [inline]
 zap_pud_range mm/memory.c:1852 [inline]
 zap_p4d_range mm/memory.c:1873 [inline]
 unmap_page_range+0x30be/0x4210 mm/memory.c:1894
 unmap_vmas+0x25d/0x3c0 mm/memory.c:1984
 exit_mmap+0x245/0xba0 mm/mmap.c:1284
 __mmput+0x118/0x420 kernel/fork.c:1379
 exit_mm+0x1da/0x2c0 kernel/exit.c:589
 do_exit+0x859/0x2550 kernel/exit.c:940
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1102
 get_signal+0x125e/0x1310 kernel/signal.c:3034
 arch_do_signal_or_restart+0x95/0x780 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x8b/0x120 kernel/entry/common.c:218
 do_syscall_64+0x103/0x210 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb5c9b8e969
Code: Unable to access opcode bytes at 0x7fb5c9b8e93f.
RSP: 002b:00007fb5ca95c038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffea RBX: 00007fb5c9db5fa0 RCX: 00007fb5c9b8e969
RDX: 0000000000000048 RSI: 00002000000006c0 RDI: 0000000000000000
RBP: 00007fb5c9c10ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fb5c9db5fa0 R15: 00007ffdd9bb4678
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

