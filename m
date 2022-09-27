Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E715ECC6A
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 20:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiI0Svs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 27 Sep 2022 14:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiI0Svo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 14:51:44 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328F114AD4E
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 11:51:43 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id v20-20020a6b5b14000000b0069fee36308eso6368000ioh.10
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 11:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+UtalqemC23LCsMVIprSKVlKapSr2rP3wl6kZxQ368M=;
        b=e5YS7cXCT+eT8paFoBv69jCQneCFI14Hhg/lWPl16RdX8dReyh+aI9y8Nfm6g1C7gR
         id2EQuwWa4awuMLAGGW4MPsDC3IKj5TMG85ZtahYNcsMDzmTDjXrPnxBdbxudQdr1IGc
         7ZU5n7hvlZKreEnq3IXJjJN1xSXZCzKi/tdjc330KZrTED2lbyHLC+t//20V8Zs8HybN
         MIPIZowB55BQIawmjRMgWwLC8w7a6gkn928926G1WN724FpiBr/YaMSBJ+Nd57m3ob59
         m3A4qsGjAFAmLjWJSs7p6MCv/ROLl4WMEtnHMDUwR7DBXHguD3wqRQ4QxrK1a8WjitOt
         cVjQ==
X-Gm-Message-State: ACrzQf1XUPyY89kSmS/2UMSfilFpMghrWIU4Nr3g+72O6SI2nrnMxgGe
        SRoHi6fCdiPLqqwyfsoNmGGJac1oYysaS41xazcqlFx7fIvJ
X-Google-Smtp-Source: AMsMyM7DCld31+pivdSCsltbh1AUXK2CIlKuj+zz94o6QBBPBtPBOmwAoBFoqy2Zhf00fC3qU0jQ6NaMKUl1pM/OAqhkzrose8Up
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:687:b0:2f8:e16a:a3fb with SMTP id
 o7-20020a056e02068700b002f8e16aa3fbmr900770ils.163.1664304702539; Tue, 27 Sep
 2022 11:51:42 -0700 (PDT)
Date:   Tue, 27 Sep 2022 11:51:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097ce6405e9ad2282@google.com>
Subject: [syzbot] possible deadlock in __mod_timer
From:   syzbot <syzbot+622205cc61a6d1bb6452@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bigeasy@linutronix.de,
        bpf@vger.kernel.org, brauner@kernel.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a1375562c0a8 Merge tag 'x86_urgent_for_v6.0-rc8' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15760950880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1992c90769e07
dashboard link: https://syzkaller.appspot.com/bug?extid=622205cc61a6d1bb6452
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+622205cc61a6d1bb6452@syzkaller.appspotmail.com

chnl_net:caif_netlink_parms(): no params data found
======================================================
WARNING: possible circular locking dependency detected
6.0.0-rc7-syzkaller-00034-ga1375562c0a8 #0 Not tainted
------------------------------------------------------
syz-executor.2/3684 is trying to acquire lock:
ffffffff8c0be788 (zonelist_update_seq.seqcount){...-}-{0:0}, at: __alloc_pages+0x43d/0x510 mm/page_alloc.c:5562

but task is already holding lock:
ffff88802cb29498 (&base->lock){-.-.}-{2:2}, at: __mod_timer+0x60c/0xe30 kernel/time/timer.c:1096

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&base->lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
       lock_timer_base+0x5a/0x1f0 kernel/time/timer.c:999
       __mod_timer+0x398/0xe30 kernel/time/timer.c:1072
       __queue_delayed_work+0x1a7/0x270 kernel/workqueue.c:1676
       queue_delayed_work_on+0x105/0x120 kernel/workqueue.c:1701
       psi_enqueue kernel/sched/stats.h:136 [inline]
       enqueue_task+0x1ec/0x3a0 kernel/sched/core.c:2062
       activate_task kernel/sched/core.c:2091 [inline]
       wake_up_new_task+0x582/0xbf0 kernel/sched/core.c:4680
       kernel_clone+0x1eb/0xab0 kernel/fork.c:2695
       user_mode_thread+0xad/0xe0 kernel/fork.c:2740
       rest_init+0x23/0x270 init/main.c:692
       arch_call_rest_init+0xf/0x14 init/main.c:883
       start_kernel+0x46e/0x48f init/main.c:1138
       secondary_startup_64_no_verify+0xce/0xdb

-> #3 (&rq->__lock){-.-.}-{2:2}:
       _raw_spin_lock_nested+0x30/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2b/0x120 kernel/sched/core.c:544
       raw_spin_rq_lock kernel/sched/sched.h:1355 [inline]
       rq_lock kernel/sched/sched.h:1653 [inline]
       task_fork_fair+0x68/0x520 kernel/sched/fair.c:11440
       sched_cgroup_fork+0x340/0x480 kernel/sched/core.c:4624
       copy_process+0x4416/0x7090 kernel/fork.c:2371
       kernel_clone+0xe7/0xab0 kernel/fork.c:2671
       user_mode_thread+0xad/0xe0 kernel/fork.c:2740
       rest_init+0x23/0x270 init/main.c:692
       arch_call_rest_init+0xf/0x14 init/main.c:883
       start_kernel+0x46e/0x48f init/main.c:1138
       secondary_startup_64_no_verify+0xce/0xdb

-> #2 (&p->pi_lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
       try_to_wake_up+0xab/0x1e60 kernel/sched/core.c:4082
       up+0x75/0xb0 kernel/locking/semaphore.c:191
       __up_console_sem+0xa4/0xc0 kernel/printk/printk.c:263
       __console_unlock kernel/printk/printk.c:2652 [inline]
       console_unlock+0x480/0x5a0 kernel/printk/printk.c:2863
       vga_remove_vgacon drivers/pci/vgaarb.c:189 [inline]
       vga_remove_vgacon.cold+0x99/0x9e drivers/pci/vgaarb.c:170
       aperture_remove_conflicting_pci_devices+0x59/0x200 drivers/video/aperture.c:336
       virtio_gpu_pci_quirk drivers/gpu/drm/virtio/virtgpu_drv.c:61 [inline]
       virtio_gpu_probe.cold+0x16a/0x189 drivers/gpu/drm/virtio/virtgpu_drv.c:118
       virtio_dev_probe+0x577/0x870 drivers/virtio/virtio.c:305
       call_driver_probe drivers/base/dd.c:560 [inline]
       really_probe+0x249/0xb90 drivers/base/dd.c:639
       __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
       driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
       __driver_attach+0x1d0/0x550 drivers/base/dd.c:1190
       bus_for_each_dev+0x147/0x1d0 drivers/base/bus.c:301
       bus_add_driver+0x4c9/0x640 drivers/base/bus.c:618
       driver_register+0x220/0x3a0 drivers/base/driver.c:246
       do_one_initcall+0xfe/0x650 init/main.c:1296
       do_initcall_level init/main.c:1369 [inline]
       do_initcalls init/main.c:1385 [inline]
       do_basic_setup init/main.c:1404 [inline]
       kernel_init_freeable+0x6b1/0x73a init/main.c:1623
       kernel_init+0x1a/0x1d0 init/main.c:1512
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

-> #1 ((console_sem).lock){-...}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
       down_trylock+0xe/0x60 kernel/locking/semaphore.c:139
       __down_trylock_console_sem+0x40/0x120 kernel/printk/printk.c:246
       console_trylock kernel/printk/printk.c:2586 [inline]
       console_trylock_spinning kernel/printk/printk.c:1870 [inline]
       vprintk_emit+0x167/0x5f0 kernel/printk/printk.c:2270
       vprintk+0x80/0x90 kernel/printk/printk_safe.c:50
       _printk+0xba/0xed kernel/printk/printk.c:2292
       build_zonelists+0x2e7/0x400 mm/page_alloc.c:6468
       __build_all_zonelists+0x111/0x180 mm/page_alloc.c:6584
       build_all_zonelists_init+0x2f/0x104 mm/page_alloc.c:6609
       build_all_zonelists+0x11f/0x140 mm/page_alloc.c:6642
       start_kernel+0xb9/0x48f init/main.c:960
       secondary_startup_64_no_verify+0xce/0xdb

-> #0 (zonelist_update_seq.seqcount){...-}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
       lock_acquire kernel/locking/lockdep.c:5666 [inline]
       lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
       seqcount_lockdep_reader_access include/linux/seqlock.h:102 [inline]
       read_seqbegin include/linux/seqlock.h:836 [inline]
       zonelist_iter_begin mm/page_alloc.c:4722 [inline]
       __alloc_pages_slowpath.constprop.0+0x1a5/0x2300 mm/page_alloc.c:5044
       __alloc_pages+0x43d/0x510 mm/page_alloc.c:5562
       __alloc_pages_node include/linux/gfp.h:243 [inline]
       kmem_getpages mm/slab.c:1363 [inline]
       cache_grow_begin+0x75/0x360 mm/slab.c:2569
       cache_alloc_refill+0x27f/0x380 mm/slab.c:2942
       ____cache_alloc mm/slab.c:3018 [inline]
       ____cache_alloc mm/slab.c:3001 [inline]
       __do_cache_alloc mm/slab.c:3246 [inline]
       slab_alloc mm/slab.c:3287 [inline]
       __kmem_cache_alloc_lru mm/slab.c:3471 [inline]
       kmem_cache_alloc+0x433/0x520 mm/slab.c:3491
       kmem_cache_zalloc include/linux/slab.h:723 [inline]
       fill_pool+0x264/0x5c0 lib/debugobjects.c:168
       __debug_object_init+0x7a/0xd10 lib/debugobjects.c:562
       debug_object_init lib/debugobjects.c:617 [inline]
       debug_object_activate+0x32c/0x3e0 lib/debugobjects.c:703
       debug_timer_activate kernel/time/timer.c:782 [inline]
       __mod_timer+0x77d/0xe30 kernel/time/timer.c:1103
       __queue_delayed_work+0x1a7/0x270 kernel/workqueue.c:1676
       queue_delayed_work_on+0x105/0x120 kernel/workqueue.c:1701
       queue_delayed_work include/linux/workqueue.h:518 [inline]
       wg_ratelimiter_init+0x198/0x2c0 drivers/net/wireguard/ratelimiter.c:191
       wg_newlink+0x4f2/0x9a0 drivers/net/wireguard/device.c:367
       rtnl_newlink_create net/core/rtnetlink.c:3363 [inline]
       __rtnl_newlink+0x1087/0x17e0 net/core/rtnetlink.c:3580
       rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3593
       rtnetlink_rcv_msg+0x43a/0xca0 net/core/rtnetlink.c:6090
       netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2501
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
       sock_sendmsg_nosec net/socket.c:714 [inline]
       sock_sendmsg+0xcf/0x120 net/socket.c:734
       __sys_sendto+0x236/0x340 net/socket.c:2117
       __do_sys_sendto net/socket.c:2129 [inline]
       __se_sys_sendto net/socket.c:2125 [inline]
       __x64_sys_sendto+0xdd/0x1b0 net/socket.c:2125
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  zonelist_update_seq.seqcount --> &rq->__lock --> &base->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&base->lock);
                               lock(&rq->__lock);
                               lock(&base->lock);
  lock(zonelist_update_seq.seqcount);

 *** DEADLOCK ***

3 locks held by syz-executor.2/3684:
 #0: ffffffff8d7a89a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:74 [inline]
 #0: ffffffff8d7a89a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x3e5/0xca0 net/core/rtnetlink.c:6087
 #1: ffffffff8ccaad48 (init_lock){+.+.}-{3:3}, at: wg_ratelimiter_init+0x17/0x2c0 drivers/net/wireguard/ratelimiter.c:160
 #2: ffff88802cb29498 (&base->lock){-.-.}-{2:2}, at: __mod_timer+0x60c/0xe30 kernel/time/timer.c:1096

stack backtrace:
CPU: 3 PID: 3684 Comm: syz-executor.2 Not tainted 6.0.0-rc7-syzkaller-00034-ga1375562c0a8 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain kernel/locking/lockdep.c:3829 [inline]
 __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
 lock_acquire kernel/locking/lockdep.c:5666 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
 seqcount_lockdep_reader_access include/linux/seqlock.h:102 [inline]
 read_seqbegin include/linux/seqlock.h:836 [inline]
 zonelist_iter_begin mm/page_alloc.c:4722 [inline]
 __alloc_pages_slowpath.constprop.0+0x1a5/0x2300 mm/page_alloc.c:5044
 __alloc_pages+0x43d/0x510 mm/page_alloc.c:5562
 __alloc_pages_node include/linux/gfp.h:243 [inline]
 kmem_getpages mm/slab.c:1363 [inline]
 cache_grow_begin+0x75/0x360 mm/slab.c:2569
 cache_alloc_refill+0x27f/0x380 mm/slab.c:2942
 ____cache_alloc mm/slab.c:3018 [inline]
 ____cache_alloc mm/slab.c:3001 [inline]
 __do_cache_alloc mm/slab.c:3246 [inline]
 slab_alloc mm/slab.c:3287 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3471 [inline]
 kmem_cache_alloc+0x433/0x520 mm/slab.c:3491
 kmem_cache_zalloc include/linux/slab.h:723 [inline]
 fill_pool+0x264/0x5c0 lib/debugobjects.c:168
 __debug_object_init+0x7a/0xd10 lib/debugobjects.c:562
 debug_object_init lib/debugobjects.c:617 [inline]
 debug_object_activate+0x32c/0x3e0 lib/debugobjects.c:703
 debug_timer_activate kernel/time/timer.c:782 [inline]
 __mod_timer+0x77d/0xe30 kernel/time/timer.c:1103
 __queue_delayed_work+0x1a7/0x270 kernel/workqueue.c:1676
 queue_delayed_work_on+0x105/0x120 kernel/workqueue.c:1701
 queue_delayed_work include/linux/workqueue.h:518 [inline]
 wg_ratelimiter_init+0x198/0x2c0 drivers/net/wireguard/ratelimiter.c:191
 wg_newlink+0x4f2/0x9a0 drivers/net/wireguard/device.c:367
 rtnl_newlink_create net/core/rtnetlink.c:3363 [inline]
 __rtnl_newlink+0x1087/0x17e0 net/core/rtnetlink.c:3580
 rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3593
 rtnetlink_rcv_msg+0x43a/0xca0 net/core/rtnetlink.c:6090
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2501
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:734
 __sys_sendto+0x236/0x340 net/socket.c:2117
 __do_sys_sendto net/socket.c:2129 [inline]
 __se_sys_sendto net/socket.c:2125 [inline]
 __x64_sys_sendto+0xdd/0x1b0 net/socket.c:2125
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0030e3c5bc
Code: fa fa ff ff 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 20 fb ff ff 48 8b
RSP: 002b:00007ffdc46c8050 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f0031ee4320 RCX: 00007f0030e3c5bc
RDX: 000000000000003c RSI: 00007f0031ee4370 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffdc46c80a4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 00007f0031ee4370 R14: 0000000000000003 R15: 0000000000000000
 </TASK>
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge_slave_0 entered promiscuous mode
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_1 entered promiscuous mode
bond0: (slave bond_slave_0): Enslaving as an active interface with an up link
bond0: (slave bond_slave_1): Enslaving as an active interface with an up link
team0: Port device team_slave_0 added
team0: Port device team_slave_1 added
batman_adv: batadv0: Adding interface: batadv_slave_0
batman_adv: batadv0: The MTU of interface batadv_slave_0 is too small (1500) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1560 would solve the problem.
batman_adv: batadv0: Not using interface batadv_slave_0 (retrying later): interface not active
batman_adv: batadv0: Adding interface: batadv_slave_1
batman_adv: batadv0: The MTU of interface batadv_slave_1 is too small (1500) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1560 would solve the problem.
batman_adv: batadv0: Not using interface batadv_slave_1 (retrying later): interface not active
device hsr_slave_0 entered promiscuous mode
device hsr_slave_1 entered promiscuous mode
netdevsim netdevsim2 netdevsim0: renamed from eth0
netdevsim netdevsim2 netdevsim1: renamed from eth1
netdevsim netdevsim2 netdevsim2: renamed from eth2
netdevsim netdevsim2 netdevsim3: renamed from eth3
8021q: adding VLAN 0 to HW filter on device bond0
8021q: adding VLAN 0 to HW filter on device team0
hsr0: Slave A (hsr_slave_0) is not up; please bring it up to get a fully working HSR network
hsr0: Slave B (hsr_slave_1) is not up; please bring it up to get a fully working HSR network
8021q: adding VLAN 0 to HW filter on device batadv0
device veth0_vlan entered promiscuous mode
device veth1_vlan entered promiscuous mode
device veth0_macvtap entered promiscuous mode
device veth1_macvtap entered promiscuous mode
batman_adv: The newly added mac address (aa:aa:aa:aa:aa:3e) already exists on: batadv_slave_0
batman_adv: It is strongly recommended to keep mac addresses unique to avoid problems!
batman_adv: batadv0: Interface activated: batadv_slave_0
batman_adv: The newly added mac address (aa:aa:aa:aa:aa:3f) already exists on: batadv_slave_1
batman_adv: It is strongly recommended to keep mac addresses unique to avoid problems!
batman_adv: batadv0: Interface activated: batadv_slave_1
netdevsim netdevsim2 netdevsim0: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim2 netdevsim1: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim2 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim2 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
