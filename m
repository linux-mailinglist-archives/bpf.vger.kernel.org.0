Return-Path: <bpf+bounces-11184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990017B5055
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 12:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id D27C3B20B52
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 10:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE0310A15;
	Mon,  2 Oct 2023 10:31:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B9E10A03
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 10:31:01 +0000 (UTC)
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCC3B0
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 03:30:57 -0700 (PDT)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1dcdffddde7so31105894fac.0
        for <bpf@vger.kernel.org>; Mon, 02 Oct 2023 03:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696242656; x=1696847456;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mSyQzxCxIxEyaFnkQfO5EmP0btmSKt2Vjm/kNx4GYMY=;
        b=vLRXOU+OQyeGbJYHm7kpw7fkggYvuBGDEybcLaYaHlLgusPAEhEDxXdi7GwqWvZ6bj
         roEclByErznGQUnMJItr2aLPrKXoX8v967Js1PDrOLE8HLuXhRYd0X3h9dzIzWaBbeZz
         uD4ySW4NQrNRnNULlq2wzkrjIDnhvIryJgmyuDPnNekHx6NMyxUcscw4FWX6L6d18S5Q
         3TYJqL5BwXJjtP7xOnoVkxLvtBQPP8Au+2wqJcCfR6TICwWU/Rr/YLwlQWjVBpsTATQS
         oz961kG12WKGuUGwl3xPrVHiGkfg+BHV0uOAbJ3lIWC5KZioDBlw7QjIi+Lshkprszcr
         GqOA==
X-Gm-Message-State: AOJu0YwzgwH/z5P9dZhSH/G6/D/iI0o+beE+7uaK9mkurtYP2EkmMi9n
	94+M/I7jGMxG0tAc6aVl9m3HWC6KrBXyqQsUu3ibMpZGK4rv9oUD1g==
X-Google-Smtp-Source: AGHT+IGKHpcZ5Kpxka9NFrtMLfgXEycK8RYIybPURaSXo2KT4Fjj1sMiJya0XGitaswl8zUZJH4AjR8m3KL0nTKWEj+i+ND/6zoi
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:8c2f:b0:1e0:fd82:d6af with SMTP id
 ec47-20020a0568708c2f00b001e0fd82d6afmr4025526oab.7.1696242655247; Mon, 02
 Oct 2023 03:30:55 -0700 (PDT)
Date: Mon, 02 Oct 2023 03:30:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb41740606b944ef@google.com>
Subject: [syzbot] [media?] KASAN: slab-use-after-free Read in ir_raw_event_store
From: syzbot <syzbot+3edd6754ed84dc732eee@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-usb@vger.kernel.org, mchehab@kernel.org, 
	sean@mess.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    8a749fd1a872 Linux 6.6-rc4
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=15f3dfc6680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c3a9469137c1fdfd
dashboard link: https://syzkaller.appspot.com/bug?extid=3edd6754ed84dc732eee
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/60dab1248c25/disk-8a749fd1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f4cd52987657/vmlinux-8a749fd1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/69612a5fc6d4/bzImage-8a749fd1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3edd6754ed84dc732eee@syzkaller.appspotmail.com

rc rc0: IR event FIFO is full!
rc rc0: IR event FIFO is full!
rc rc0: IR event FIFO is full!
rc rc0: IR event FIFO is full!
==================================================================
BUG: KASAN: slab-use-after-free in ir_raw_event_store+0x2ea/0x370 drivers/media/rc/rc-ir-raw.c:80
Read of size 4 at addr ffff888102b7c018 by task syz-executor.0/23935

CPU: 0 PID: 23935 Comm: syz-executor.0 Not tainted 6.6.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 ir_raw_event_store+0x2ea/0x370 drivers/media/rc/rc-ir-raw.c:80
 ir_raw_event_store_with_filter+0x403/0x590 drivers/media/rc/rc-ir-raw.c:183
 sz_push+0x97/0x1d0 drivers/media/rc/streamzap.c:104
 sz_push_full_space drivers/media/rc/streamzap.c:132 [inline]
 sz_push_half_space drivers/media/rc/streamzap.c:138 [inline]
 streamzap_callback+0x57d/0x7e0 drivers/media/rc/streamzap.c:190
 __usb_hcd_giveback_urb+0x359/0x5c0 drivers/usb/core/hcd.c:1650
 usb_hcd_giveback_urb+0x389/0x430 drivers/usb/core/hcd.c:1733
 dummy_timer+0x1415/0x35f0 drivers/usb/gadget/udc/dummy_hcd.c:1987
 call_timer_fn+0x19e/0x580 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers+0x764/0xb10 kernel/time/timer.c:2022
 run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
 __do_softirq+0x20b/0x94e kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xa7/0x110 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x8e/0xb0 arch/x86/kernel/apic/apic.c:1074
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:__sanitizer_cov_trace_const_cmp1+0x0/0x20 kernel/kcov.c:289
Code: 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 8b 0c 24 48 89 f2 48 89 fe bf 06 00 00 00 e9 f8 fe ff ff 0f 1f 84 00 00 00 00 00 <f3> 0f 1e fa 48 8b 0c 24 40 0f b6 d6 40 0f b6 f7 bf 01 00 00 00 e9
RSP: 0018:ffffc90005e8f748 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88813f273a00 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffea00045c3540 R08: 0000000000000004 R09: 00000000000000c5
R10: 00000000000001fe R11: 0000000000000001 R12: dffffc0000000000
R13: 00007fcb7b4cd000 R14: 0000000000000000 R15: ffff88812b3d6660
 zap_pte_range mm/memory.c:1460 [inline]
 zap_pmd_range mm/memory.c:1573 [inline]
 zap_pud_range mm/memory.c:1602 [inline]
 zap_p4d_range mm/memory.c:1623 [inline]
 unmap_page_range+0xe06/0x2640 mm/memory.c:1644
 unmap_single_vma+0x194/0x2b0 mm/memory.c:1690
 unmap_vmas+0x1e2/0x330 mm/memory.c:1731
 exit_mmap+0x1ad/0xa60 mm/mmap.c:3210
 __mmput kernel/fork.c:1349 [inline]
 mmput+0xdb/0x420 kernel/fork.c:1371
 exit_mm kernel/exit.c:567 [inline]
 do_exit+0x9ad/0x2990 kernel/exit.c:861
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 get_signal+0x23c3/0x27a0 kernel/signal.c:2892
 arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x116/0x1f0 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:296
 do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fcb7ba6cae9
Code: Unable to access opcode bytes at 0x7fcb7ba6cabf.
RSP: 002b:00007fcb7adef178 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007fcb7bb8bf88 RCX: 00007fcb7ba6cae9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fcb7bb8bf88
RBP: 00007fcb7bb8bf80 R08: 00007fcb7adef6c0 R09: 00007fcb7adef6c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fcb7bb8bf8c
R13: 0000000000000006 R14: 00007fffafc8b0a0 R15: 00007fffafc8b188
 </TASK>

Allocated by task 8:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x87/0x90 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 ir_raw_event_prepare+0x5a/0x320 drivers/media/rc/rc-ir-raw.c:617
 rc_register_device+0x1517/0x1bd0 drivers/media/rc/rc-main.c:1921
 streamzap_init_rc_dev drivers/media/rc/streamzap.c:249 [inline]
 streamzap_probe+0x805/0x1090 drivers/media/rc/streamzap.c:331
 usb_probe_interface+0x307/0x930 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x117e/0x1aa0 drivers/base/core.c:3624
 usb_set_configuration+0x10cb/0x1c40 drivers/usb/core/message.c:2207
 usb_generic_driver_probe+0xca/0x130 drivers/usb/core/generic.c:238
 usb_probe_device+0xda/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x117e/0x1aa0 drivers/base/core.c:3624
 usb_new_device+0xd80/0x1960 drivers/usb/core/hub.c:2589
 hub_port_connect drivers/usb/core/hub.c:5440 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
 port_event drivers/usb/core/hub.c:5740 [inline]
 hub_event+0x2e62/0x4f30 drivers/usb/core/hub.c:5822
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Freed by task 5323:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x13c/0x190 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook mm/slub.c:1826 [inline]
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0xff/0x330 mm/slub.c:3822
 ir_raw_event_free drivers/media/rc/rc-ir-raw.c:653 [inline]
 ir_raw_event_free drivers/media/rc/rc-ir-raw.c:648 [inline]
 ir_raw_event_unregister+0x2e3/0x400 drivers/media/rc/rc-ir-raw.c:676
 rc_unregister_device+0x35c/0x410 drivers/media/rc/rc-main.c:2022
 streamzap_disconnect+0xa6/0x1f0 drivers/media/rc/streamzap.c:388
 usb_unbind_interface+0x1dd/0x8d0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
 bus_remove_device+0x22c/0x420 drivers/base/bus.c:574
 device_del+0x39a/0xa50 drivers/base/core.c:3813
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1416
 usb_disconnect+0x2e1/0x890 drivers/usb/core/hub.c:2252
 hub_port_connect drivers/usb/core/hub.c:5280 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
 port_event drivers/usb/core/hub.c:5740 [inline]
 hub_event+0x1be0/0x4f30 drivers/usb/core/hub.c:5822
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

The buggy address belongs to the object at ffff888102b7c000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 24 bytes inside of
 freed 8192-byte region [ffff888102b7c000, ffff888102b7e000)

The buggy address belongs to the physical page:
page:ffffea00040ade00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x102b78
head:ffffea00040ade00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x200000000000840(slab|head|node=0|zone=2)
page_type: 0xffffffff()
raw: 0200000000000840 ffff888100042280 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080020002 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d28c0(GFP_NOWAIT|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 2421, tgid 2421 (dhcpcd), ts 2043176724451, free_ts 2043138506502
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x10e1/0x2fd0 mm/page_alloc.c:3170
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4426
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2297
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x251/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8c7/0x1580 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x12c/0x310 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1022 [inline]
 __kmalloc_node_track_caller+0x50/0x100 mm/slab_common.c:1043
 kmalloc_reserve+0xef/0x260 net/core/skbuff.c:581
 __alloc_skb+0x12b/0x330 net/core/skbuff.c:650
 alloc_skb include/linux/skbuff.h:1286 [inline]
 netlink_dump+0x2e5/0xca0 net/netlink/af_netlink.c:2233
 netlink_recvmsg+0x9ff/0xf20 net/netlink/af_netlink.c:1992
 sock_recvmsg_nosec net/socket.c:1027 [inline]
 sock_recvmsg+0xe2/0x170 net/socket.c:1049
 ____sys_recvmsg+0x21f/0x5c0 net/socket.c:2760
 ___sys_recvmsg+0x115/0x1a0 net/socket.c:2802
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x460/0xa20 mm/page_alloc.c:2312
 free_unref_page+0x33/0x2c0 mm/page_alloc.c:2405
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x4a/0x70 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3478 [inline]
 slab_alloc mm/slub.c:3486 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
 kmem_cache_alloc+0x182/0x370 mm/slub.c:3502
 getname_flags.part.0+0x50/0x4d0 fs/namei.c:140
 getname_flags+0x9c/0xf0 include/linux/audit.h:321
 user_path_at_empty+0x2c/0x60 fs/namei.c:2909
 do_readlinkat+0xdd/0x2f0 fs/stat.c:490
 __do_sys_readlink fs/stat.c:523 [inline]
 __se_sys_readlink fs/stat.c:520 [inline]
 __x64_sys_readlink+0x78/0xb0 fs/stat.c:520
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888102b7bf00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888102b7bf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888102b7c000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888102b7c080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888102b7c100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess):
   0:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   7:	00 00 00
   a:	f3 0f 1e fa          	endbr64
   e:	48 8b 0c 24          	mov    (%rsp),%rcx
  12:	48 89 f2             	mov    %rsi,%rdx
  15:	48 89 fe             	mov    %rdi,%rsi
  18:	bf 06 00 00 00       	mov    $0x6,%edi
  1d:	e9 f8 fe ff ff       	jmp    0xffffff1a
  22:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  29:	00
* 2a:	f3 0f 1e fa          	endbr64 <-- trapping instruction
  2e:	48 8b 0c 24          	mov    (%rsp),%rcx
  32:	40 0f b6 d6          	movzbl %sil,%edx
  36:	40 0f b6 f7          	movzbl %dil,%esi
  3a:	bf 01 00 00 00       	mov    $0x1,%edi
  3f:	e9                   	.byte 0xe9


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

