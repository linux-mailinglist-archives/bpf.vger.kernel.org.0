Return-Path: <bpf+bounces-7682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616B777AB43
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 22:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD7A1C2095E
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 20:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DF69465;
	Sun, 13 Aug 2023 20:46:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DD89461
	for <bpf@vger.kernel.org>; Sun, 13 Aug 2023 20:46:04 +0000 (UTC)
Received: from mail-pf1-f205.google.com (mail-pf1-f205.google.com [209.85.210.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC72E75
	for <bpf@vger.kernel.org>; Sun, 13 Aug 2023 13:46:01 -0700 (PDT)
Received: by mail-pf1-f205.google.com with SMTP id d2e1a72fcca58-686bf0ee1b0so4637818b3a.1
        for <bpf@vger.kernel.org>; Sun, 13 Aug 2023 13:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691959560; x=1692564360;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mxp+NOGqzkXjEoQntmAVfjOsOf47ClQ7DObuIoaaFg0=;
        b=fwJiiZ0W6htsJPEmpYiA3VHv20G6WRFbt9GdZqfYlgXm/AK7PXBOAMZDRKw+wwDHGn
         F1/uxnbXd441VJeZ+6Evxu+XIlHOTMIaMkvT6pYFTCtBhnG8y+Vllps9qiGdV06ft/I5
         V+leAvcYQhC0tVx39A251iLb8aXXjsTNabGFp5eYbGs9nBhf081VWAStMNUook+jINzo
         /Te9IedCvoWfLlh7gTb67f6yGUb/FaZK76PcQZJhoNZ66r7Z+RLKKx3sTR9jCSI/25+L
         4t80fteKuYGc9u0QTSX4zp4cOCzNkYY/fHiGrPxU4i0bh8xqOr+kUGbo2lSFunB+md85
         CKxQ==
X-Gm-Message-State: AOJu0YxJmY+FhiBLsuiYhLfOXCvoA98Ch9oBoXqqdh491JV2XNwHIs64
	vhzIjIc1sx3E7v74C1DwimVlinX0wok1ffQdyJs5B5Sjw66Xo5GNeQ==
X-Google-Smtp-Source: AGHT+IHUxQaYtnxGp6TEsRCac21Lk9FCe/Sk/HjmRnrhq4VIRhXq63ivlPjegt6CZagcqiCg+P6MbQW9mlWCy7ewwwtviAG0Ly7F
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1704:b0:687:a55f:a9ef with SMTP id
 h4-20020a056a00170400b00687a55fa9efmr3681528pfc.2.1691959559854; Sun, 13 Aug
 2023 13:45:59 -0700 (PDT)
Date: Sun, 13 Aug 2023 13:45:59 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a1fbb0602d4088a@google.com>
Subject: [syzbot] [net?] INFO: rcu detected stall in unix_release
From: syzbot <syzbot+a3618a167af2021433cd@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net, 
	edumazet@google.com, jiri@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    d0378ae6d16c Merge branch 'enetc-probe-fix'
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1052ea2ba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5bd4cd5ab6259d
dashboard link: https://syzkaller.appspot.com/bug?extid=a3618a167af2021433cd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1152c6eda80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b1eddda80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c893f52cd6ab/disk-d0378ae6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dfb7a8b86a99/vmlinux-d0378ae6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cb9134e0a22c/bzImage-d0378ae6.xz

The issue was bisected to:

commit c2368b19807affd7621f7c4638cd2e17fec13021
Author: Jiri Pirko <jiri@nvidia.com>
Date:   Fri Jul 29 07:10:35 2022 +0000

    net: devlink: introduce "unregistering" mark and use it during devlinks iteration

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=134f1179a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10cf1179a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=174f1179a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a3618a167af2021433cd@syzkaller.appspotmail.com
Fixes: c2368b19807a ("net: devlink: introduce "unregistering" mark and use it during devlinks iteration")

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	0-....: (10499 ticks this GP) idle=9774/1/0x4000000000000000 softirq=8757/8758 fqs=5219
rcu: 	         hardirqs   softirqs   csw/system
rcu: 	 number:        1          0            0
rcu: 	cputime:    26308      26181           17   ==> 52490(ms)
rcu: 	(t=10500 jiffies g=8417 q=457 ncpus=2)
CPU: 0 PID: 5047 Comm: syz-executor224 Not tainted 6.5.0-rc4-syzkaller-00212-gd0378ae6d16c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:taprio_dequeue_tc_priority+0x263/0x4b0 net/sched/sch_taprio.c:798
Code: 8b 74 24 10 89 ef 44 89 f6 e8 29 b8 2c f9 44 39 f5 0f 84 40 ff ff ff e8 2b bd 2c f9 49 83 ff 0f 0f 87 e1 01 00 00 48 8b 04 24 <0f> b6 00 38 44 24 36 7c 08 84 c0 0f 85 bf 01 00 00 8b 33 8b 4c 24
RSP: 0018:ffffc90000007d60 EFLAGS: 00000293
RAX: ffffed10047a4a72 RBX: ffff888023d25394 RCX: 0000000000000100
RDX: ffff888028efbb80 RSI: ffffffff88594af5 RDI: 0000000000000004
RBP: 0000000000000008 R08: 0000000000000004 R09: 0000000000000008
R10: 0000000000000000 R11: ffffc90000007ff8 R12: 0000000000000010
R13: ffff88802d19ab60 R14: 0000000000000000 R15: 0000000000000001
FS:  0000555555857380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000600 CR3: 000000002cdd1000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 taprio_dequeue+0x12e/0x5f0 net/sched/sch_taprio.c:868
 dequeue_skb net/sched/sch_generic.c:292 [inline]
 qdisc_restart net/sched/sch_generic.c:397 [inline]
 __qdisc_run+0x1c4/0x19d0 net/sched/sch_generic.c:415
 qdisc_run include/net/pkt_sched.h:125 [inline]
 qdisc_run include/net/pkt_sched.h:122 [inline]
 net_tx_action+0x71e/0xc80 net/core/dev.c:5049
 __do_softirq+0x218/0x965 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1109
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:unwind_next_frame+0x5ba/0x2020 arch/x86/kernel/unwind_orc.c:517
Code: 31 02 00 00 41 80 fe 04 0f 84 08 0c 00 00 41 80 fe 05 0f 85 d7 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 14 24 48 c1 ea 03 <80> 3c 02 00 0f 85 42 19 00 00 48 89 c8 4d 8b 7d 38 48 ba 00 00 00
RSP: 0018:ffffc90003b9f748 EFLAGS: 00000a02
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffffff8f3ed5c8
RDX: 1ffff92000773efe RSI: 0000000000000001 RDI: ffffffff8ec31910
RBP: ffffc90003b9f800 R08: ffffffff8f3ed646 R09: ffffffff8f3ed5cc
R10: ffffc90003b9f7b8 R11: 000000000000d9e9 R12: ffffc90003b9f808
R13: ffffc90003b9f7b8 R14: 0000000000000005 R15: 0000000000000000
 arch_stack_walk+0x8b/0xf0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x96/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15e/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1792 [inline]
 slab_free_freelist_hook+0x10b/0x1e0 mm/slub.c:1818
 slab_free mm/slub.c:3801 [inline]
 kmem_cache_free+0xf0/0x490 mm/slub.c:3823
 sk_prot_free net/core/sock.c:2122 [inline]
 __sk_destruct+0x49e/0x770 net/core/sock.c:2216
 sk_destruct+0xc2/0xf0 net/core/sock.c:2231
 __sk_free+0xc4/0x3a0 net/core/sock.c:2242
 sk_free+0x7c/0xa0 net/core/sock.c:2253
 sock_put include/net/sock.h:1975 [inline]
 unix_release_sock+0xa76/0xf70 net/unix/af_unix.c:668
 unix_release+0x88/0xe0 net/unix/af_unix.c:1065
 __sock_release+0xcd/0x290 net/socket.c:654
 sock_close+0x1c/0x20 net/socket.c:1386
 __fput+0x3fd/0xac0 fs/file_table.c:384
 task_work_run+0x14d/0x240 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc3bb116ef7
Code: 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd1d8ead88 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 00007fc3bb116ef7
RDX: 0000000000000000 RSI: 0000000000008933 RDI: 0000000000000004
RBP: 00007ffd1d8ead90 R08: 0000000000000008 R09: 0000000000000004
R10: 000000000000000b R11: 0000000000000246 R12: 00007ffd1d8eafc0
R13: 00003faaaaaaaaaa R14: 00007ffd1d8eaff0 R15: 00007fc3bb164376
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

