Return-Path: <bpf+bounces-69657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76753B9D4A0
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 05:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA156167403
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 03:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAB12E6CCF;
	Thu, 25 Sep 2025 03:11:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697611DE4E0
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 03:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758769892; cv=none; b=FSgNEwZq/8P3BNi1Zzbg6xVXzbOddB/YWUK+o3yvmDchLiwK+AoVTk4DbgKzfN9NH9otJKR4DLnQ0NMcwnURqzUwDDUh1t5MvLUQIeT2ohC9fqenSS1aYw9PFmDsXQ0dVWLTJfj3fkuWYsyLVOMSe4OYyY/7eIj8FSMrBXK3MuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758769892; c=relaxed/simple;
	bh=mujJZpYCVSYmotVR8+774RrqliuRI2OYFHrPqrz1NHM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tYXNK8RneJ/sIMofhGJ7gOFRP6SEDTjmLD4rGtKYOYEOqw8TPwaPO4qzrIeYZxDEjjeWomRWgjJkMAgE2gVwcoBNA/T/J1dHwkB509RP/9eVfxb8d6bQmO3c8j1f1eNRSLyP691c4HhXTcS8JGcB4EZ+TxdjE1TdVs7Gg9eitOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-42571c700d2so11508935ab.1
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 20:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758769889; x=1759374689;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q4yFUCJeldr4yYPWLOazb1XxGy7ks26f36uWNdaijnM=;
        b=i8t2E53OHY/cV+KtQecJIgEcHDgmMRDaVRmCW/q2ywV+XWE6KJbDEtX6BOM+sJ/8sP
         DW7Dt4oi35sFJ1EYqY9X5+ghTwyYpm6C4XLExcE2d7hbqXmSEYb5M4EI6QxOjZYU4DEw
         c96dwUPO4fA7mhAK/srHDXHB/a9F/BNeIRyHvOcFDAmN1EEc9K3tyIzUEkiSqAqAOOpa
         3D+4QNRerb75x2Vl9i7+twUjvRPVkJj4FKibGlKEfphlf4OrrQBQW/DaN0jXNRCiiANK
         FmUzNEB5tmhcGXJMFZKRgXopi9BmirXuYfPGKkl3Ct/kF8pPg5tTCbgAQMQI7aMP4bKb
         eczw==
X-Forwarded-Encrypted: i=1; AJvYcCXd8YKyrdS0WtOQK1sHJOEp0rBJsZF3Yvav/neFCQC/hv7fv8DKQXbOLTUHW4zPMx4qZkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCOR0vjENcx5t1tIDtCde95NwSR9mX5n18OWmr+/9R2COFn98k
	Uon0R5k2P0dANdACD5BJfv9hRzR6i/sSMqI8mXRI4NRSOWnaZnRV/0B9GBmRV4XtEdyOaFdPbGN
	2vf1MUN/zqpiBuMonlxBZN4AkeCSTQcaHjK62qs8CilIJ9367evUrmurQ3uQ=
X-Google-Smtp-Source: AGHT+IH48u6ENaP0YKfKw8HhqsTAI0zVWq/sq/UNcVvHQQLN6iOp+WF6NomRFd6YNqwUVdsKECv4kOZQbQLtOnAhI/Iealf0jSzp
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26b:0:b0:425:39b:a7d3 with SMTP id
 e9e14a558f8ab-425955ca729mr26825395ab.1.1758769889573; Wed, 24 Sep 2025
 20:11:29 -0700 (PDT)
Date: Wed, 24 Sep 2025 20:11:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d4b2e1.050a0220.57ae1.0037.GAE@google.com>
Subject: [syzbot] [bpf?] [net?] possible deadlock in xdp_umem_pin_pages
From: syzbot <syzbot+1b607ee7794bdba65be7@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, david@redhat.com, jgg@ziepe.ca, 
	jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	netdev@vger.kernel.org, peterx@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b5a4da2c459f Add linux-next specific files for 20250924
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17d3cce2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=841973c5ab4f4157
dashboard link: https://syzkaller.appspot.com/bug?extid=1b607ee7794bdba65be7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2d0e39514585/disk-b5a4da2c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c7c8001fe2ea/vmlinux-b5a4da2c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/807bea872f12/bzImage-b5a4da2c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1b607ee7794bdba65be7@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.5.7937/23579 is trying to acquire lock:
ffff88802981d0e8 (&resv_map->rw_sema){++++}-{4:4}, at: follow_page_mask mm/gup.c:1015 [inline]
ffff88802981d0e8 (&resv_map->rw_sema){++++}-{4:4}, at: __get_user_pages+0x5da/0x2a00 mm/gup.c:1426

but task is already holding lock:
ffff888028e401e0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:368 [inline]
ffff888028e401e0 (&mm->mmap_lock){++++}-{4:4}, at: xdp_umem_pin_pages+0xcb/0x350 net/xdp/xdp_umem.c:104

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #8 (&mm->mmap_lock){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __might_fault+0xcc/0x130 mm/memory.c:7125
       _copy_from_iter+0xf3/0x1790 lib/iov_iter.c:259
       copy_from_iter include/linux/uio.h:228 [inline]
       copy_from_iter_full include/linux/uio.h:245 [inline]
       skb_do_copy_data_nocache include/net/sock.h:2269 [inline]
       skb_copy_to_page_nocache include/net/sock.h:2295 [inline]
       tcp_sendmsg_locked+0x2347/0x5540 net/ipv4/tcp.c:1272
       tcp_sendmsg+0x2f/0x50 net/ipv4/tcp.c:1413
       sock_sendmsg_nosec net/socket.c:714 [inline]
       __sock_sendmsg+0x19c/0x270 net/socket.c:729
       sock_write_iter+0x279/0x360 net/socket.c:1182
       new_sync_write fs/read_write.c:593 [inline]
       vfs_write+0x5c9/0xb30 fs/read_write.c:686
       ksys_write+0x145/0x250 fs/read_write.c:738
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #7 (sk_lock-AF_INET){+.+.}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       lock_sock_nested+0x48/0x100 net/core/sock.c:3720
       lock_sock include/net/sock.h:1679 [inline]
       inet_shutdown+0x6a/0x390 net/ipv4/af_inet.c:907
       nbd_mark_nsock_dead+0x2e9/0x560 drivers/block/nbd.c:318
       sock_shutdown+0x15e/0x260 drivers/block/nbd.c:411
       nbd_clear_sock drivers/block/nbd.c:1424 [inline]
       nbd_config_put+0x342/0x790 drivers/block/nbd.c:1448
       nbd_release+0xfe/0x140 drivers/block/nbd.c:1753
       bdev_release+0x536/0x650 block/bdev.c:-1
       blkdev_release+0x15/0x20 block/fops.c:702
       __fput+0x44c/0xa70 fs/file_table.c:468
       task_work_run+0x1d4/0x260 kernel/task_work.c:227
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
       exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
       syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
       syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
       do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #6 (&nsock->tx_lock){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
       nbd_handle_cmd drivers/block/nbd.c:1140 [inline]
       nbd_queue_rq+0x257/0xf10 drivers/block/nbd.c:1204
       blk_mq_dispatch_rq_list+0x4c0/0x1900 block/blk-mq.c:2129
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xda4/0x1570 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2367
       blk_mq_dispatch_list+0xd0c/0xe00 include/linux/spinlock.h:-1
       blk_mq_flush_plug_list+0x469/0x550 block/blk-mq.c:2976
       __blk_flush_plug+0x3d3/0x4b0 block/blk-core.c:1225
       blk_finish_plug block/blk-core.c:1252 [inline]
       __submit_bio+0x2d3/0x5a0 block/blk-core.c:651
       __submit_bio_noacct_mq block/blk-core.c:724 [inline]
       submit_bio_noacct_nocheck+0x2fb/0xa50 block/blk-core.c:755
       submit_bh fs/buffer.c:2829 [inline]
       block_read_full_folio+0x599/0x830 fs/buffer.c:2447
       filemap_read_folio+0x117/0x380 mm/filemap.c:2444
       do_read_cache_folio+0x350/0x590 mm/filemap.c:4009
       read_mapping_folio include/linux/pagemap.h:999 [inline]
       read_part_sector+0xb6/0x2b0 block/partitions/core.c:722
       adfspart_check_ICS+0xa4/0xa50 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x75f/0x14b0 block/partitions/core.c:693
       blkdev_get_whole+0x380/0x510 block/bdev.c:748
       bdev_open+0x31e/0xd30 block/bdev.c:957
       blkdev_open+0x457/0x600 block/fops.c:694
       do_dentry_open+0x953/0x13f0 fs/open.c:965
       vfs_open+0x3b/0x340 fs/open.c:1097
       do_open fs/namei.c:3975 [inline]
       path_openat+0x2ee5/0x3830 fs/namei.c:4134
       do_filp_open+0x1fa/0x410 fs/namei.c:4161
       do_sys_openat2+0x121/0x1c0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_openat fs/open.c:1468 [inline]
       __se_sys_openat fs/open.c:1463 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1463
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&cmd->lock){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
       nbd_queue_rq+0xc8/0xf10 drivers/block/nbd.c:1196
       blk_mq_dispatch_rq_list+0x4c0/0x1900 block/blk-mq.c:2129
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xda4/0x1570 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2367
       blk_mq_dispatch_list+0xd0c/0xe00 include/linux/spinlock.h:-1
       blk_mq_flush_plug_list+0x469/0x550 block/blk-mq.c:2976
       __blk_flush_plug+0x3d3/0x4b0 block/blk-core.c:1225
       blk_finish_plug block/blk-core.c:1252 [inline]
       __submit_bio+0x2d3/0x5a0 block/blk-core.c:651
       __submit_bio_noacct_mq block/blk-core.c:724 [inline]
       submit_bio_noacct_nocheck+0x2fb/0xa50 block/blk-core.c:755
       submit_bh fs/buffer.c:2829 [inline]
       block_read_full_folio+0x599/0x830 fs/buffer.c:2447
       filemap_read_folio+0x117/0x380 mm/filemap.c:2444
       do_read_cache_folio+0x350/0x590 mm/filemap.c:4009
       read_mapping_folio include/linux/pagemap.h:999 [inline]
       read_part_sector+0xb6/0x2b0 block/partitions/core.c:722
       adfspart_check_ICS+0xa4/0xa50 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x75f/0x14b0 block/partitions/core.c:693
       blkdev_get_whole+0x380/0x510 block/bdev.c:748
       bdev_open+0x31e/0xd30 block/bdev.c:957
       blkdev_open+0x457/0x600 block/fops.c:694
       do_dentry_open+0x953/0x13f0 fs/open.c:965
       vfs_open+0x3b/0x340 fs/open.c:1097
       do_open fs/namei.c:3975 [inline]
       path_openat+0x2ee5/0x3830 fs/namei.c:4134
       do_filp_open+0x1fa/0x410 fs/namei.c:4161
       do_sys_openat2+0x121/0x1c0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_openat fs/open.c:1468 [inline]
       __se_sys_openat fs/open.c:1463 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1463
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (set->srcu){.+.+}-{0:0}:
       lock_sync+0xba/0x160 kernel/locking/lockdep.c:5916
       srcu_lock_sync include/linux/srcu.h:173 [inline]
       __synchronize_srcu+0x96/0x3a0 kernel/rcu/srcutree.c:1429
       elevator_switch+0x12b/0x640 block/elevator.c:588
       elevator_change+0x315/0x4c0 block/elevator.c:691
       elevator_set_default+0x186/0x260 block/elevator.c:767
       blk_register_queue+0x34e/0x3f0 block/blk-sysfs.c:942
       __add_disk+0x677/0xd50 block/genhd.c:528
       add_disk_fwnode+0xfc/0x480 block/genhd.c:597
       add_disk include/linux/blkdev.h:775 [inline]
       nbd_dev_add+0x717/0xae0 drivers/block/nbd.c:1981
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2688
       do_one_initcall+0x236/0x820 init/main.c:1283
       do_initcall_level+0x104/0x190 init/main.c:1345
       do_initcalls+0x59/0xa0 init/main.c:1361
       kernel_init_freeable+0x334/0x4b0 init/main.c:1593
       kernel_init+0x1d/0x1d0 init/main.c:1483
       ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #3 (&q->elevator_lock){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
       elevator_change+0x1e5/0x4c0 block/elevator.c:689
       elevator_set_none+0x42/0xb0 block/elevator.c:782
       blk_mq_elv_switch_none block/blk-mq.c:5032 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:5075 [inline]
       blk_mq_update_nr_hw_queues+0x598/0x1ab0 block/blk-mq.c:5133
       nbd_start_device+0x17f/0xb10 drivers/block/nbd.c:1486
       nbd_genl_connect+0x135b/0x18f0 drivers/block/nbd.c:2236
       genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
       genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
       genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
       netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
       netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
       netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
       netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
       sock_sendmsg_nosec net/socket.c:714 [inline]
       __sock_sendmsg+0x21c/0x270 net/socket.c:729
       ____sys_sendmsg+0x505/0x830 net/socket.c:2617
       ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2671
       __sys_sendmsg net/socket.c:2703 [inline]
       __do_sys_sendmsg net/socket.c:2708 [inline]
       __se_sys_sendmsg net/socket.c:2706 [inline]
       __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2706
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&q->q_usage_counter(io)#49){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       blk_alloc_queue+0x538/0x620 block/blk-core.c:461
       blk_mq_alloc_queue block/blk-mq.c:4399 [inline]
       __blk_mq_alloc_disk+0x15c/0x340 block/blk-mq.c:4446
       nbd_dev_add+0x46c/0xae0 drivers/block/nbd.c:1951
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2688
       do_one_initcall+0x236/0x820 init/main.c:1283
       do_initcall_level+0x104/0x190 init/main.c:1345
       do_initcalls+0x59/0xa0 init/main.c:1361
       kernel_init_freeable+0x334/0x4b0 init/main.c:1593
       kernel_init+0x1d/0x1d0 init/main.c:1483
       ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __fs_reclaim_acquire mm/page_alloc.c:4269 [inline]
       fs_reclaim_acquire+0x72/0x100 mm/page_alloc.c:4283
       might_alloc include/linux/sched/mm.h:318 [inline]
       prepare_alloc_pages+0x153/0x610 mm/page_alloc.c:4951
       __alloc_frozen_pages_noprof+0x123/0x370 mm/page_alloc.c:5172
       alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
       alloc_frozen_pages_noprof mm/mempolicy.c:2487 [inline]
       alloc_pages_noprof+0xa9/0x190 mm/mempolicy.c:2507
       pagetable_alloc_noprof include/linux/mm.h:2990 [inline]
       __pud_alloc_one_noprof include/asm-generic/pgalloc.h:177 [inline]
       pud_alloc_one_noprof include/asm-generic/pgalloc.h:198 [inline]
       __pud_alloc+0x3f/0x450 mm/memory.c:6593
       pud_alloc include/linux/mm.h:2941 [inline]
       huge_pte_alloc+0x4dc/0x620 mm/hugetlb.c:7679
       hugetlb_fault+0x508/0x2970 mm/hugetlb.c:6720
       handle_mm_fault+0x740/0x8e0 mm/memory.c:6529
       faultin_page mm/gup.c:1126 [inline]
       __get_user_pages+0x165c/0x2a00 mm/gup.c:1428
       populate_vma_page_range+0x29f/0x3a0 mm/gup.c:1860
       __mm_populate+0x24c/0x380 mm/gup.c:1963
       mm_populate include/linux/mm.h:3481 [inline]
       vm_mmap_pgoff+0x387/0x4d0 mm/util.c:585
       ksys_mmap_pgoff+0x587/0x760 mm/mmap.c:604
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&resv_map->rw_sema){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_read+0x46/0x2e0 kernel/locking/rwsem.c:1537
       follow_page_mask mm/gup.c:1015 [inline]
       __get_user_pages+0x5da/0x2a00 mm/gup.c:1426
       __get_user_pages_locked mm/gup.c:1692 [inline]
       __gup_longterm_locked+0x3dc/0x1660 mm/gup.c:2481
       pin_user_pages+0x9e/0xd0 mm/gup.c:3394
       xdp_umem_pin_pages+0x11c/0x350 net/xdp/xdp_umem.c:105
       xdp_umem_reg net/xdp/xdp_umem.c:230 [inline]
       xdp_umem_create+0x677/0x8e0 net/xdp/xdp_umem.c:263
       xsk_setsockopt+0x7b0/0x8d0 net/xdp/xsk.c:1484
       do_sock_setsockopt+0x17c/0x1b0 net/socket.c:2347
       __sys_setsockopt net/socket.c:2372 [inline]
       __do_sys_setsockopt net/socket.c:2378 [inline]
       __se_sys_setsockopt net/socket.c:2375 [inline]
       __x64_sys_setsockopt+0x13f/0x1b0 net/socket.c:2375
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &resv_map->rw_sema --> sk_lock-AF_INET --> &mm->mmap_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&mm->mmap_lock);
                               lock(sk_lock-AF_INET);
                               lock(&mm->mmap_lock);
  rlock(&resv_map->rw_sema);

 *** DEADLOCK ***

2 locks held by syz.5.7937/23579:
 #0: ffff888078c706b8 (&xs->mutex){+.+.}-{4:4}, at: xsk_setsockopt+0x63c/0x8d0 net/xdp/xsk.c:1478
 #1: ffff888028e401e0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:368 [inline]
 #1: ffff888028e401e0 (&mm->mmap_lock){++++}-{4:4}, at: xdp_umem_pin_pages+0xcb/0x350 net/xdp/xdp_umem.c:104

stack backtrace:
CPU: 0 UID: 0 PID: 23579 Comm: syz.5.7937 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2043
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 down_read+0x46/0x2e0 kernel/locking/rwsem.c:1537
 follow_page_mask mm/gup.c:1015 [inline]
 __get_user_pages+0x5da/0x2a00 mm/gup.c:1426
 __get_user_pages_locked mm/gup.c:1692 [inline]
 __gup_longterm_locked+0x3dc/0x1660 mm/gup.c:2481
 pin_user_pages+0x9e/0xd0 mm/gup.c:3394
 xdp_umem_pin_pages+0x11c/0x350 net/xdp/xdp_umem.c:105
 xdp_umem_reg net/xdp/xdp_umem.c:230 [inline]
 xdp_umem_create+0x677/0x8e0 net/xdp/xdp_umem.c:263
 xsk_setsockopt+0x7b0/0x8d0 net/xdp/xsk.c:1484
 do_sock_setsockopt+0x17c/0x1b0 net/socket.c:2347
 __sys_setsockopt net/socket.c:2372 [inline]
 __do_sys_setsockopt net/socket.c:2378 [inline]
 __se_sys_setsockopt net/socket.c:2375 [inline]
 __x64_sys_setsockopt+0x13f/0x1b0 net/socket.c:2375
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa2d038eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa2d11fd038 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007fa2d05e5fa0 RCX: 00007fa2d038eec9
RDX: 0000000000000004 RSI: 000000000000011b RDI: 0000000000000003
RBP: 00007fa2d0411f91 R08: 0000000000000020 R09: 0000000000000000
R10: 00002000000000c0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa2d05e6038 R14: 00007fa2d05e5fa0 R15: 00007ffd6dae5908
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

