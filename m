Return-Path: <bpf+bounces-46365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDDE9E8441
	for <lists+bpf@lfdr.de>; Sun,  8 Dec 2024 09:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC30281A9E
	for <lists+bpf@lfdr.de>; Sun,  8 Dec 2024 08:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B841459E0;
	Sun,  8 Dec 2024 08:40:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDC0142E9F
	for <bpf@vger.kernel.org>; Sun,  8 Dec 2024 08:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733647221; cv=none; b=JLIXyi/r42xrwI4Rryv995o+8Hw49ULP3SWZH+DxaRZXBDCAIEAfyE9VI5jXiFBnZMeDLJyTAimpFJBDA7EHOlDRvN4Rkf4ooWoMd0pBNWqHIE0Tz7C06i6/wi1jYR4szfGd7MOq35j+CKDNrUbfjH5ezU1yrx3dA+vm8BJ5SFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733647221; c=relaxed/simple;
	bh=4QF2XpCCEeA9k4McCNbrQXfYSzEwl2hedT8LHcNwRzw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XnF/v0urszEwP5pWjyUPe5SGHz8L1GULJO4WJEujKhXrv8IO5Iwr/gIsrKvuG0C3q+PbaFDwTeUu0rVcKBpQJg1KDDwS4yRTcoUht2WJv/DUH4k9PbNR4kBSVjbYGplrlJXUkTNiaqtPXZmkGSFrxoLHmLg3+8/d5BcNuRkO1Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a9c9b37244so18797355ab.1
        for <bpf@vger.kernel.org>; Sun, 08 Dec 2024 00:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733647218; x=1734252018;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QLkSHq64Nxjaqz10qyDTcTJAhlmCroB71Qgc3dg7NN4=;
        b=PcAHqPSsPskVTI4l7SNWB5tyZByjawzY2d7iZTOa6VjhEo+b288FwskSFOeLgyft40
         timsWupdjIHky0yhae4Q1LH4rRmtmeksM2m5VCr+EtbGga7ft/SDXldZd+EGckYES0Tg
         aPMBnvv6iAatgmM06KZ9xWKJJDcYCfaGIkD/ot0w0s129ehdKVpUCXJRGewFGDY0388D
         1jXx/UpP9HtT8ApznCIpXGSKF1NGjxOHJC0bJyWOJ9wHWv5MNWoiywdYl41ps1ZvfXSM
         pwmFIahbaBKss4TF8WjS1E7trUFZBuCn0JaKurRIbkNpO4+525DwMXp6KuMcfub//qd1
         EyXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV+SQLhAryL+uRIchME0mC+tQLsAIHCDHF6CO7d3kH7RQVaF4T97vfFTTOWdm+4foSIwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5sWY/YF0IvZFB76ADKvPHcxJVoyLeS7Bs6fkzjZ1HasjOcLM7
	r8xVGliYX8TDBj+4dRsU4Uw0u4LwKs7rfCoC2rrAqeZ/+YNrBv3Hg74GIJQmkx9soiEvxebrePq
	apZTCYsOScSgr74iF0hU6DJJ85StjkC5IN/mdh/Nlvvu77C8ol+Sl1t4=
X-Google-Smtp-Source: AGHT+IExX0I4T9wezoV91nHo4rRkDkD8Ajfozz9/9EUWYmnn9+JGBZaWFJGdfMjnIgM3DJLGfQNNeXKe+A+ftPmzxdQG4wCCsZNU
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20cf:b0:3a7:4674:d637 with SMTP id
 e9e14a558f8ab-3a811d7716cmr115044625ab.3.1733647218605; Sun, 08 Dec 2024
 00:40:18 -0800 (PST)
Date: Sun, 08 Dec 2024 00:40:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67555b72.050a0220.2477f.0026.GAE@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in sys_umount (3)
From: syzbot <syzbot+1ec0f904ba50d06110b1@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, martin.lau@linux.dev, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    feffde684ac2 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1420a330580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=1ec0f904ba50d06110b1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c060f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3bb09093023b/disk-feffde68.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9e37e48dc48a/vmlinux-feffde68.xz
kernel image: https://storage.googleapis.com/syzbot-assets/36b46b3a6421/bzImage-feffde68.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1ec0f904ba50d06110b1@syzkaller.appspotmail.com

bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5930/1:b..l
rcu: 	(detected by 0, t=10503 jiffies, g=6361, q=569 ncpus=2)
task:syz-executor    state:R  running task     stack:20208 pid:5930  tgid:5930  ppid:5919   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:7078
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:rcu_preempt_read_enter kernel/rcu/tree_plugin.h:390 [inline]
RIP: 0010:__rcu_read_lock+0x27/0xb0 kernel/rcu/tree_plugin.h:413
Code: 90 90 90 f3 0f 1e fa 55 41 57 41 56 53 49 be 00 00 00 00 00 fc ff df 65 4c 8b 3c 25 00 d6 03 00 49 81 c7 44 04 00 00 4c 89 fb <48> c1 eb 03 42 0f b6 04 33 84 c0 75 35 41 8b 2f ff c5 42 0f b6 04
RSP: 0018:ffffc900035f77e0 EFLAGS: 00000286
RAX: ffffffff81ae868a RBX: ffff888026cd5e44 RCX: ffff888026cd5a00
RDX: 0000000000000000 RSI: ffffffff8c5f63c0 RDI: 00007fc1f8581247
RBP: 0000000000000001 R08: ffffffff810a464d R09: ffffc900035f7990
R10: ffffc900035f78f0 R11: ffffffff818b36f0 R12: ffff888026cd5a00
R13: ffffffff818b36f0 R14: dffffc0000000000 R15: ffff888026cd5e44
 rcu_read_lock include/linux/rcupdate.h:847 [inline]
 is_bpf_text_address+0x1f/0x2a0 kernel/bpf/core.c:768
 kernel_text_address+0xa7/0xe0 kernel/extable.c:125
 __kernel_text_address+0xd/0x40 kernel/extable.c:79
 unwind_get_return_address+0x4d/0x90 arch/x86/kernel/unwind_orc.c:369
 arch_stack_walk+0xfd/0x150 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 save_stack+0xfb/0x1f0 mm/page_owner.c:156
 __reset_page_owner+0x76/0x430 mm/page_owner.c:297
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xdef/0x1130 mm/page_alloc.c:2657
 __slab_free+0x31b/0x3d0 mm/slub.c:4509
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4104 [inline]
 slab_alloc_node mm/slub.c:4153 [inline]
 kmem_cache_alloc_noprof+0x1d9/0x380 mm/slub.c:4160
 getname_flags+0xb7/0x540 fs/namei.c:139
 user_path_at+0x24/0x60 fs/namei.c:3069
 ksys_umount fs/namespace.c:2033 [inline]
 __do_sys_umount fs/namespace.c:2041 [inline]
 __se_sys_umount fs/namespace.c:2039 [inline]
 __x64_sys_umount+0xf1/0x170 fs/namespace.c:2039
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc1f8581247
RSP: 002b:00007fc1f886ecc8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc1f8581247
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fc1f886ed80
RBP: 00007fc1f886ed80 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fc1f886fe00
R13: 00007fc1f85f3824 R14: 000000000000f97b R15: 00007fc1f886fe40
 </TASK>
rcu: rcu_preempt kthread starved for 10527 jiffies! g6361 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:26264 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_timeout+0x15a/0x290 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2045
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2247
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 24 Comm: ksoftirqd/1 Not tainted 6.13.0-rc1-syzkaller-00025-gfeffde684ac2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:unwind_get_return_address+0x56/0x90 arch/x86/kernel/unwind_orc.c:369
Code: 83 c3 48 49 89 df 49 c1 ef 03 43 80 3c 37 00 74 08 48 89 df e8 7b b2 be 00 48 8b 3b e8 c3 73 1e 00 85 c0 74 14 43 80 3c 37 00 <74> 08 48 89 df e8 60 b2 be 00 48 8b 03 eb 02 31 c0 5b 41 5e 41 5f
RSP: 0018:ffffc900001e6d20 EFLAGS: 00000246
RAX: 0000000000000001 RBX: ffffc900001e6d88 RCX: ffffffff91790000
RDX: ffffffff91940701 RSI: ffffc900001e0000 RDI: ffffffff81fe1859
RBP: ffffc900001e6dd0 R08: ffffc900001e7120 R09: 0000000000000000
R10: ffffc900001e6d90 R11: fffff5200003cdb4 R12: ffff88801d2e8000
R13: ffffffff818b36f0 R14: dffffc0000000000 R15: 1ffff9200003cdb1
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc1f886ecdc CR3: 000000007d414000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 arch_stack_walk+0xfd/0x150 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4104 [inline]
 slab_alloc_node mm/slub.c:4153 [inline]
 kmem_cache_alloc_noprof+0x1d9/0x380 mm/slub.c:4160
 __skb_ext_alloc net/core/skbuff.c:6924 [inline]
 skb_ext_add+0x14d/0x910 net/core/skbuff.c:7027
 nf_bridge_alloc include/net/netfilter/br_netfilter.h:12 [inline]
 br_nf_pre_routing_ipv6+0x131/0x770 net/bridge/br_netfilter_ipv6.c:172
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:277 [inline]
 br_handle_frame+0x9fd/0x1530 net/bridge/br_input.c:424
 __netif_receive_skb_core+0x14eb/0x4690 net/core/dev.c:5566
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 process_backlog+0x662/0x15b0 net/core/dev.c:6117
 __napi_poll+0xcb/0x490 net/core/dev.c:6877
 napi_poll net/core/dev.c:6946 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:7068
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:554
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:943
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
net_ratelimit: 52114 callbacks suppressed
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
net_ratelimit: 58692 callbacks suppressed
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)


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

