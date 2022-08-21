Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9B859B158
	for <lists+bpf@lfdr.de>; Sun, 21 Aug 2022 05:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbiHUDEe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Aug 2022 23:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbiHUDEc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Aug 2022 23:04:32 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CBE29CB0
        for <bpf@vger.kernel.org>; Sat, 20 Aug 2022 20:04:28 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id d6-20020a056e020be600b002dcc7977592so5906549ilu.17
        for <bpf@vger.kernel.org>; Sat, 20 Aug 2022 20:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=/nXPIQGJRkolknwhdIPdZn9RGrbvOH9/zz0b+a2VlR4=;
        b=qqDOBsMO5/7UWGgHL5uk+RGmAJrlcJbdQkhebObmLBpkyhimdI6L19Mf6+kHWXyzuA
         bgbFhjAZlObFj14/hSIOMnMlWZ/aSxQ2vZi8V+b3py5GbfE4deRr6gocMft3YYmIh5h9
         nHOe2peqDNYjNYdZHCnIQE8Nq4Y38Ez3BNVXw03HQX23uWG/T7zaIMvepLETmj6AlJdv
         gd5vwXderX6SHvDe8GESeC5NAuUIHvhpg0Z/F4F5Z2HpZF40w4CwKqfjHd366lR1yyc1
         ojuYdaD80eD0N2NX+zrkqg4AKxrimrMHmwte+TcNlsZ1Iyi+6ooafBfCbGSwh2d4+zAi
         X2fg==
X-Gm-Message-State: ACgBeo2srKKG8bWSxH+rMECX3cQNCSEQlQAjGK0ky62NQOyRCu080X89
        VIHSZk1QAEFL4Mlxl1c9LvnogC+yUxjUEYpVDxcrnWXyHYv/
X-Google-Smtp-Source: AA6agR6aHHKzmsTVUTBZOFb87IDrhURrI7ZbxiVzpjFu5AdO8UzrQIq1z29F3AkEiYh/3in1Z830/lGKF00bUOhEL2e3Zl5GuYPf
MIME-Version: 1.0
X-Received: by 2002:a92:6007:0:b0:2e4:464f:6e57 with SMTP id
 u7-20020a926007000000b002e4464f6e57mr6974607ilb.181.1661051068273; Sat, 20
 Aug 2022 20:04:28 -0700 (PDT)
Date:   Sat, 20 Aug 2022 20:04:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e0dc1505e6b796c7@google.com>
Subject: [syzbot] linux-next boot error: BUG: unable to handle kernel paging
 request in enqueue_entity
From:   syzbot <syzbot+e8d2360e9962d57f8072@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bigeasy@linutronix.de,
        bpf@vger.kernel.org, brauner@kernel.org, david@redhat.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, luto@kernel.org, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e1084bacab44 Add linux-next specific files for 20220816
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14c686a5080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f5fa747986be53a
dashboard link: https://syzkaller.appspot.com/bug?extid=e8d2360e9962d57f8072
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e8d2360e9962d57f8072@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffdc0000000008
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8 Comm: kworker/u4:0 Not tainted 6.0.0-rc1-next-20220816-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Workqueue: events_unbound async_run_entry_fn
RIP: 0010:entity_before kernel/sched/fair.c:585 [inline]
RIP: 0010:__entity_less kernel/sched/fair.c:621 [inline]
RIP: 0010:rb_add_cached include/linux/rbtree.h:174 [inline]
RIP: 0010:__enqueue_entity kernel/sched/fair.c:629 [inline]
RIP: 0010:enqueue_entity+0x389/0x1520 kernel/sched/fair.c:4618
Code: 00 0f 85 57 0e 00 00 48 8b 53 50 be 01 00 00 00 49 bd 00 00 00 00 00 fc ff df eb 03 48 89 c5 48 8d 7d 40 48 89 f8 48 c1 e8 03 <42> 80 3c 28 00 0f 85 77 0c 00 00 48 3b 55 40 4c 8d 65 10 78 06 4c
RSP: 0000:ffffc900001e0b00 EFLAGS: 00010802
RAX: 1fffe00000000008 RBX: ffff88801b1a5900 RCX: 0000000000000100
RDX: 00000000f90154e3 RSI: 0000000000000000 RDI: ffff000000000040
RBP: ffff000000000000 R08: ffff88801b1a5910 R09: ffff8880b9b3a080
R10: fffffbfff1bbd5ba R11: 0000000000000001 R12: ffff88801fc28098
R13: dffffc0000000000 R14: ffff8880b9b3a040 R15: ffff8880b9b3a050
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffdc0000000008 CR3: 000000000bc8e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 enqueue_task_fair+0x1ba/0xce0 kernel/sched/fair.c:5921
 enqueue_task+0xad/0x3a0 kernel/sched/core.c:2066
 activate_task kernel/sched/core.c:2091 [inline]
 ttwu_do_activate+0x157/0x330 kernel/sched/core.c:3670
 ttwu_queue kernel/sched/core.c:3875 [inline]
 try_to_wake_up+0xcc0/0x1e60 kernel/sched/core.c:4198
 wake_up_worker kernel/workqueue.c:865 [inline]
 insert_work+0x27e/0x350 kernel/workqueue.c:1376
 __queue_work+0x625/0x1210 kernel/workqueue.c:1527
 queue_work_on+0x143/0x170 kernel/workqueue.c:1562
 queue_work include/linux/workqueue.h:508 [inline]
 schedule_work include/linux/workqueue.h:569 [inline]
 __vfree_deferred mm/vmalloc.c:2718 [inline]
 __vfree+0xb0/0xd0 mm/vmalloc.c:2742
 vfree+0x5a/0x90 mm/vmalloc.c:2775
 thread_stack_free_rcu+0x88/0xa0 kernel/fork.c:221
 rcu_do_batch kernel/rcu/tree.c:2245 [inline]
 rcu_core+0x7b5/0x1890 kernel/rcu/tree.c:2505
 __do_softirq+0x1d3/0x9c6 kernel/softirq.c:571
 invoke_softirq kernel/softirq.c:445 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:662
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1106
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:lock_acquire+0x1ef/0x570 kernel/locking/lockdep.c:5634
Code: eb a2 7e 83 f8 01 0f 85 e8 02 00 00 9c 58 f6 c4 02 0f 85 fb 02 00 00 48 83 7c 24 08 00 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01 c3 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 48 8b 84 24
RSP: 0000:ffffc900000d7660 EFLAGS: 00000206
RAX: dffffc0000000000 RBX: 1ffff9200001aece RCX: 6ba147c65e712bc2
RDX: 1ffff11027fccc5e RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff908de947
R10: fffffbfff211bd28 R11: 0000000000000000 R12: 0000000000000002
R13: 0000000000000000 R14: ffffffff8bf89a80 R15: 0000000000000000
 rcu_lock_acquire include/linux/rcupdate.h:280 [inline]
 rcu_read_lock include/linux/rcupdate.h:706 [inline]
 blk_mq_run_hw_queue+0xbf/0x490 block/blk-mq.c:2138
 blk_mq_sched_restart block/blk-mq-sched.h:35 [inline]
 __blk_mq_free_request+0x26c/0x3f0 block/blk-mq.c:624
 blk_mq_free_request+0x35b/0x500 block/blk-mq.c:647
 __scsi_execute+0x452/0x5d0 drivers/scsi/scsi_lib.c:261
 scsi_execute_req include/scsi/scsi_device.h:479 [inline]
 scsi_probe_lun drivers/scsi/scsi_scan.c:685 [inline]
 scsi_probe_and_add_lun+0x521/0x3660 drivers/scsi/scsi_scan.c:1199
 __scsi_scan_target+0x21f/0xdb0 drivers/scsi/scsi_scan.c:1673
 scsi_scan_channel drivers/scsi/scsi_scan.c:1761 [inline]
 scsi_scan_channel+0x148/0x1e0 drivers/scsi/scsi_scan.c:1737
 scsi_scan_host_selected+0x2df/0x3b0 drivers/scsi/scsi_scan.c:1790
 do_scsi_scan_host+0x1e8/0x260 drivers/scsi/scsi_scan.c:1929
 do_scan_async+0x3e/0x500 drivers/scsi/scsi_scan.c:1939
 async_run_entry_fn+0x98/0x530 kernel/async.c:127
 process_one_work+0x991/0x1610 kernel/workqueue.c:2312
 worker_thread+0x665/0x1080 kernel/workqueue.c:2459
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
CR2: ffffdc0000000008
---[ end trace 0000000000000000 ]---
RIP: 0010:entity_before kernel/sched/fair.c:585 [inline]
RIP: 0010:__entity_less kernel/sched/fair.c:621 [inline]
RIP: 0010:rb_add_cached include/linux/rbtree.h:174 [inline]
RIP: 0010:__enqueue_entity kernel/sched/fair.c:629 [inline]
RIP: 0010:enqueue_entity+0x389/0x1520 kernel/sched/fair.c:4618
Code: 00 0f 85 57 0e 00 00 48 8b 53 50 be 01 00 00 00 49 bd 00 00 00 00 00 fc ff df eb 03 48 89 c5 48 8d 7d 40 48 89 f8 48 c1 e8 03 <42> 80 3c 28 00 0f 85 77 0c 00 00 48 3b 55 40 4c 8d 65 10 78 06 4c
RSP: 0000:ffffc900001e0b00 EFLAGS: 00010802
RAX: 1fffe00000000008 RBX: ffff88801b1a5900 RCX: 0000000000000100
RDX: 00000000f90154e3 RSI: 0000000000000000 RDI: ffff000000000040
RBP: ffff000000000000 R08: ffff88801b1a5910 R09: ffff8880b9b3a080
R10: fffffbfff1bbd5ba R11: 0000000000000001 R12: ffff88801fc28098
R13: dffffc0000000000 R14: ffff8880b9b3a040 R15: ffff8880b9b3a050
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffdc0000000008 CR3: 000000000bc8e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 0f                	add    %cl,(%rdi)
   2:	85 57 0e             	test   %edx,0xe(%rdi)
   5:	00 00                	add    %al,(%rax)
   7:	48 8b 53 50          	mov    0x50(%rbx),%rdx
   b:	be 01 00 00 00       	mov    $0x1,%esi
  10:	49 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%r13
  17:	fc ff df
  1a:	eb 03                	jmp    0x1f
  1c:	48 89 c5             	mov    %rax,%rbp
  1f:	48 8d 7d 40          	lea    0x40(%rbp),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	0f 85 77 0c 00 00    	jne    0xcac
  35:	48 3b 55 40          	cmp    0x40(%rbp),%rdx
  39:	4c 8d 65 10          	lea    0x10(%rbp),%r12
  3d:	78 06                	js     0x45
  3f:	4c                   	rex.WR


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
