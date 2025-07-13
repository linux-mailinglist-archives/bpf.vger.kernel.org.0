Return-Path: <bpf+bounces-63131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1FCB03177
	for <lists+bpf@lfdr.de>; Sun, 13 Jul 2025 16:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF7017C9A4
	for <lists+bpf@lfdr.de>; Sun, 13 Jul 2025 14:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A21F279907;
	Sun, 13 Jul 2025 14:25:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8322227933A
	for <bpf@vger.kernel.org>; Sun, 13 Jul 2025 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752416732; cv=none; b=PITG+9/Hc3O7c/VfoTO/Dv6wDtARE5Xb8TcN9WuvTwiufCiHsvraFpkPnf0FDgc5V9OnYvSH4JZhTactTNiGtGheUIVMbyhqrbtiEcqpK6RG1KmnnqxPaXDjrvE8mQu+78mVWkgsPfeNpHkcGwV3bLTNkjd4eLKj8wCAOsDFuwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752416732; c=relaxed/simple;
	bh=hnNlqaR9EADGWa6HRp+DejNOOSbVVg+HhF6T5+EIL+I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=E5yl3fCRWqsFmupkhQtdqeN7oLjgbIq7dZ//yWt9N52TfIgizYX9zBiuwOLJ0V1xfqBFad9QwV1GubVjD7WWSnzWoSRj1Kh5D3dWmpXB4354zLgJnyWm1Rdef0oj54wHaLFAyz6cavyLTAmg8IXiJWIrdjUPot7I2k+ayO+lA5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-86cfff5669bso344177139f.0
        for <bpf@vger.kernel.org>; Sun, 13 Jul 2025 07:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752416730; x=1753021530;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AsZwwtasZK1i3+QCbQOQX9ffmAK8mhRajv74GQOgHak=;
        b=Wc7EVFXr2OGL4wtVCu27Nrhaq+ILriR73OlvzCQv08KltvReYFv0mMcTO3pb6zJNDb
         PmpL+W87Q9/DuVUeuiiLD/CAVWTdzTk766cMsaTPqa9ecLO+LQalVAtVv1USF+91fST9
         Sy5v0+WL0OhP1e2Zp4BOms5FJGd+cdDEpA/qqMqTBqd/BJr9JFiDR+b+RXZi3LlZ+OLO
         bsl+aN5snF0Xcm08qRyaDW2gTFZyUNPGOZE1hPcG79Iw+U84Uafjm8zPO4U61KVmy9q3
         oIHzdmNx5prkLrssDT01QlEgD4LxGwE4l52kbnHP0KeMIWKWCBC4PLOdlVcZdHLQbsAH
         PFAw==
X-Forwarded-Encrypted: i=1; AJvYcCU07v8jczmrZRMOQEPJZNJJAbbPQyw/tTfouFP/sm+TU1btTkyIqmJj8MS3hKkAdNMhaLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzDjWpk1AxBLLH3bOkPW1MnQcumcMXdKdjMsHRf/zSqBHgvsgf
	wY7hB7TP8fQkgLOcbgQus6iHQ1VQd+tnqDuoEO2tGBTSXn21+X349W6BonJRq6UVNL6k3EBOUU8
	q19LqrBU8WhJ+78lTxiyJqHWASUjrXa1HaTmAX7UZxkNWQUn6nCf/e4yxmv8=
X-Google-Smtp-Source: AGHT+IEI0W840+Y0OOOgESBxivlWBVXV2S9q1tznNcysIcnK5FVvhm0xA1K9fNAytFNv9e4xc04c+tyatQDfvyDnn2eFt5tjPqqd
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:d209:0:b0:85e:16e9:5e8d with SMTP id
 ca18e2360f4ac-87966fef563mr1280627039f.7.1752416729662; Sun, 13 Jul 2025
 07:25:29 -0700 (PDT)
Date: Sun, 13 Jul 2025 07:25:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6873c1d9.a70a0220.3b380f.0037.GAE@google.com>
Subject: [syzbot] [bpf?] [net?] INFO: task hung in dev_map_free (3)
From: syzbot <syzbot+9bb2e1829da8582dcffa@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    733923397fd9 Merge tag 'pwm/for-6.16-rc6-fixes' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ef2a8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b309c907eaab29da
dashboard link: https://syzkaller.appspot.com/bug?extid=9bb2e1829da8582dcffa
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/add1e315f3a3/disk-73392339.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/72ed0a419d76/vmlinux-73392339.xz
kernel image: https://storage.googleapis.com/syzbot-assets/17b779bf819e/bzImage-73392339.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9bb2e1829da8582dcffa@syzkaller.appspotmail.com

INFO: task kworker/u8:4:61 blocked for more than 143 seconds.
      Not tainted 6.16.0-rc5-syzkaller-00038-g733923397fd9 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:4    state:D stack:23720 pid:61    tgid:61    ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: events_unbound bpf_map_free_deferred
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6940
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x724/0xe80 kernel/locking/mutex.c:747
 rcu_barrier+0x4c/0x570 kernel/rcu/tree.c:3786
 dev_map_free+0x11f/0x6a0 kernel/bpf/devmap.c:214
 bpf_map_free kernel/bpf/syscall.c:862 [inline]
 bpf_map_free_deferred+0xed/0x110 kernel/bpf/syscall.c:888
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task syz.5.706:7849 blocked for more than 144 seconds.
      Not tainted 6.16.0-rc5-syzkaller-00038-g733923397fd9 #0
      Blocked by coredump.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.5.706       state:D stack:25032 pid:7849  tgid:7849  ppid:5840   task_flags:0x40044c flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6883
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6940
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x724/0xe80 kernel/locking/mutex.c:747
 rcu_barrier+0x4c/0x570 kernel/rcu/tree.c:3786
 netdev_run_todo+0x327/0xea0 net/core/dev.c:11376
 tun_detach drivers/net/tun.c:639 [inline]
 tun_chr_close+0x13c/0x1c0 drivers/net/tun.c:3396
 __fput+0x44c/0xa70 fs/file_table.c:465
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x6b5/0x22e0 kernel/exit.c:964
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1105
 get_signal+0x1286/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x75/0x110 kernel/entry/common.c:111
 exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f16ba58e929
RSP: 002b:00007ffc31e304e8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f16ba7b7ba0 RCX: 00007f16ba58e929
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f16ba7b7ba0 R08: 00000000000059a4 R09: 0000000331e307df
R10: 00000000005f9cc4 R11: 0000000000000246 R12: 0000000000032577
R13: 00007ffc31e305e0 R14: ffffffffffffffff R15: 00007ffc31e30600
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8e13f160 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e13f160 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e13f160 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6770
3 locks held by kworker/u8:2/36:
2 locks held by kworker/1:1/44:
3 locks held by kworker/u8:4/61:
 #0: ffff88801a481148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88801a481148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #1: ffffc9000211fbc0 ((work_completion)(&map->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000211fbc0 ((work_completion)(&map->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #2: ffffffff8e144b40 (rcu_state.barrier_mutex){+.+.}-{4:4}, at: rcu_barrier+0x4c/0x570 kernel/rcu/tree.c:3786
2 locks held by kworker/1:2/3089:
2 locks held by getty/5598:
 #0: ffff88814c73c0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000333b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
1 lock held by syz-executor/5844:
 #0: ffffffff8e144b40 (rcu_state.barrier_mutex){+.+.}-{4:4}, at: rcu_barrier+0x4c/0x570 kernel/rcu/tree.c:3786
2 locks held by kworker/1:3/5922:
2 locks held by kworker/1:7/5977:
2 locks held by syz-executor/7551:
 #0: ffff88805480c0e0 (&type->s_umount_key#69){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff88805480c0e0 (&type->s_umount_key#69){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff88805480c0e0 (&type->s_umount_key#69){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:506
 #1: ffffffff8e144b40 (rcu_state.barrier_mutex){+.+.}-{4:4}, at: rcu_barrier+0x4c/0x570 kernel/rcu/tree.c:3786
1 lock held by syz.5.706/7849:
 #0: ffffffff8e144b40 (rcu_state.barrier_mutex){+.+.}-{4:4}, at: rcu_barrier+0x4c/0x570 kernel/rcu/tree.c:3786
1 lock held by syz-executor/8034:
 #0: ffffffff8e144b40 (rcu_state.barrier_mutex){+.+.}-{4:4}, at: rcu_barrier+0x4c/0x570 kernel/rcu/tree.c:3786
2 locks held by kworker/1:9/8359:
1 lock held by syz.1.899/8451:
 #0: ffffffff8e144b40 (rcu_state.barrier_mutex){+.+.}-{4:4}, at: rcu_barrier+0x4c/0x570 kernel/rcu/tree.c:3786
1 lock held by syz-executor/8646:
 #0: ffffffff8e144b40 (rcu_state.barrier_mutex){+.+.}-{4:4}, at: rcu_barrier+0x4c/0x570 kernel/rcu/tree.c:3786
2 locks held by kworker/1:10/8789:
2 locks held by syz.6.1039/8856:
 #0: ffffffff8fa40bb0 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8fa40bb0 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8fa40bb0 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x23/0x250 net/core/rtnetlink.c:570
 #1: ffffffff8e144b40 (rcu_state.barrier_mutex){+.+.}-{4:4}, at: rcu_barrier+0x4c/0x570 kernel/rcu/tree.c:3786
7 locks held by syz-executor/8984:
 #0: ffff888034798428 (sb_writers#7){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3096 [inline]
 #0: ffff888034798428 (sb_writers#7){.+.+}-{0:0}, at: vfs_write+0x211/0xa90 fs/read_write.c:682
 #1: ffff8880410e2088 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1e0/0x4f0 fs/kernfs/file.c:325
 #2: ffff888142b361e8 (kn->active#52){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x203/0x4f0 fs/kernfs/file.c:326
 #3: ffffffff8edab048 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x360 drivers/net/netdevsim/bus.c:216
 #4: ffff888054fc00e8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:884 [inline]
 #4: ffff888054fc00e8 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1094 [inline]
 #4: ffff888054fc00e8 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xb6/0x7c0 drivers/base/dd.c:1292
 #5: ffff888054fc1250 (&devlink->lock_key#3){+.+.}-{4:4}, at: nsim_drv_remove+0x50/0x160 drivers/net/netdevsim/dev.c:1675
 #6: ffffffff8e144b40 (rcu_state.barrier_mutex){+.+.}-{4:4}, at: rcu_barrier+0x4c/0x570 kernel/rcu/tree.c:3786
4 locks held by syz-executor/9020:
 #0: ffff888034798428 (sb_writers#7){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3096 [inline]
 #0: ffff888034798428 (sb_writers#7){.+.+}-{0:0}, at: vfs_write+0x211/0xa90 fs/read_write.c:682
 #1: ffff888068728488 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1e0/0x4f0 fs/kernfs/file.c:325
 #2: ffff888142b361e8 (kn->active#52){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x203/0x4f0 fs/kernfs/file.c:326
 #3: ffffffff8edab048 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x360 drivers/net/netdevsim/bus.c:216
4 locks held by syz-executor/9023:
 #0: ffff888034798428 (sb_writers#7){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3096 [inline]
 #0: ffff888034798428 (sb_writers#7){.+.+}-{0:0}, at: vfs_write+0x211/0xa90 fs/read_write.c:682
 #1: ffff88804abec888 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1e0/0x4f0 fs/kernfs/file.c:325
 #2: ffff888142b361e8 (kn->active#52){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x203/0x4f0 fs/kernfs/file.c:326
 #3: ffffffff8edab048 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x360 drivers/net/netdevsim/bus.c:216
4 locks held by syz-executor/9028:
 #0: ffff888034798428 (sb_writers#7){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3096 [inline]
 #0: ffff888034798428 (sb_writers#7){.+.+}-{0:0}, at: vfs_write+0x211/0xa90 fs/read_write.c:682
 #1: ffff888051a04488 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1e0/0x4f0 fs/kernfs/file.c:325
 #2: ffff888142b361e8 (kn->active#52){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x203/0x4f0 fs/kernfs/file.c:326
 #3: ffffffff8edab048 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x360 drivers/net/netdevsim/bus.c:216
4 locks held by syz-executor/9031:
 #0: ffff888034798428 (sb_writers#7){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3096 [inline]
 #0: ffff888034798428 (sb_writers#7){.+.+}-{0:0}, at: vfs_write+0x211/0xa90 fs/read_write.c:682
 #1: ffff888051a05888 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1e0/0x4f0 fs/kernfs/file.c:325
 #2: ffff888142b361e8 (kn->active#52){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x203/0x4f0 fs/kernfs/file.c:326
 #3: ffffffff8edab048 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x360 drivers/net/netdevsim/bus.c:216
4 locks held by kworker/1:15/9060:
4 locks held by syz-executor/9157:
 #0: ffff888034798428 (sb_writers#7){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3096 [inline]
 #0: ffff888034798428 (sb_writers#7){.+.+}-{0:0}, at: vfs_write+0x211/0xa90 fs/read_write.c:682
 #1: ffff88803a622488 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1e0/0x4f0 fs/kernfs/file.c:325
 #2: ffff888142b361e8 (kn->active#52){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x203/0x4f0 fs/kernfs/file.c:326
 #3: ffffffff8edab048 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x360 drivers/net/netdevsim/bus.c:216
1 lock held by syz.4.1133/9171:
 #0: ffffffff8e144b40 (rcu_state.barrier_mutex){+.+.}-{4:4}, at: rcu_barrier+0x4c/0x570 kernel/rcu/tree.c:3786
4 locks held by syz-executor/9175:
 #0: ffff888034798428 (sb_writers#7){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3096 [inline]
 #0: ffff888034798428 (sb_writers#7){.+.+}-{0:0}, at: vfs_write+0x211/0xa90 fs/read_write.c:682
 #1: ffff888055099888 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1e0/0x4f0 fs/kernfs/file.c:325
 #2: ffff888142b361e8 (kn->active#52){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x203/0x4f0 fs/kernfs/file.c:326
 #3: ffffffff8edab048 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x360 drivers/net/netdevsim/bus.c:216
4 locks held by syz-executor/9186:
 #0: ffff888034798428 (sb_writers#7){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3096 [inline]
 #0: ffff888034798428 (sb_writers#7){.+.+}-{0:0}, at: vfs_write+0x211/0xa90 fs/read_write.c:682
 #1: ffff888071bdd488 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1e0/0x4f0 fs/kernfs/file.c:325
 #2: ffff888142b361e8 (kn->active#52){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x203/0x4f0 fs/kernfs/file.c:326
 #3: ffffffff8edab048 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x360 drivers/net/netdevsim/bus.c:216
4 locks held by syz-executor/9199:
 #0: ffff888034798428 (sb_writers#7){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3096 [inline]
 #0: ffff888034798428 (sb_writers#7){.+.+}-{0:0}, at: vfs_write+0x211/0xa90 fs/read_write.c:682
 #1: ffff888092c53488 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1e0/0x4f0 fs/kernfs/file.c:325
 #2: ffff888142b361e8 (kn->active#52){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x203/0x4f0 fs/kernfs/file.c:326
 #3: ffffffff8edab048 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x360 drivers/net/netdevsim/bus.c:216
4 locks held by syz-executor/9202:
 #0: ffff888034798428 (sb_writers#7){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3096 [inline]
 #0: ffff888034798428 (sb_writers#7){.+.+}-{0:0}, at: vfs_write+0x211/0xa90 fs/read_write.c:682
 #1: ffff88803a62b488 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1e0/0x4f0 fs/kernfs/file.c:325
 #2: ffff888142b361e8 (kn->active#52){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x203/0x4f0 fs/kernfs/file.c:326
 #3: ffffffff8edab048 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x360 drivers/net/netdevsim/bus.c:216
4 locks held by syz-executor/9206:
 #0: ffff888034798428 (sb_writers#7){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3096 [inline]
 #0: ffff888034798428 (sb_writers#7){.+.+}-{0:0}, at: vfs_write+0x211/0xa90 fs/read_write.c:682
 #1: ffff888092bdc488 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1e0/0x4f0 fs/kernfs/file.c:325
 #2: ffff888142b361e8 (kn->active#52){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x203/0x4f0 fs/kernfs/file.c:326
 #3: ffffffff8edab048 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x360 drivers/net/netdevsim/bus.c:216
1 lock held by syz-executor/9228:
 #0: ffffffff8e144c78 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:304 [inline]
 #0: ffffffff8e144c78 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x2f6/0x730 kernel/rcu/tree_exp.h:998

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.16.0-rc5-syzkaller-00038-g733923397fd9 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:158 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:307 [inline]
 watchdog+0xfee/0x1030 kernel/hung_task.c:470
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 9013 Comm: kworker/1:12 Not tainted 6.16.0-rc5-syzkaller-00038-g733923397fd9 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: wg-kex-wg2 wg_packet_handshake_receive_worker
RIP: 0010:orc_ip arch/x86/kernel/unwind_orc.c:80 [inline]
RIP: 0010:__orc_find arch/x86/kernel/unwind_orc.c:102 [inline]
RIP: 0010:orc_find arch/x86/kernel/unwind_orc.c:227 [inline]
RIP: 0010:unwind_next_frame+0x130e/0x2390 arch/x86/kernel/unwind_orc.c:494
Code: c1 e8 3f 48 01 c8 48 83 e0 fe 4c 8d 3c 45 00 00 00 00 49 01 ef 4c 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 <84> c0 75 27 49 63 07 4c 01 f8 49 8d 4f 04 4c 39 e0 48 0f 46 e9 49
RSP: 0018:ffffc90000a08058 EFLAGS: 00000217
RAX: 0000000000000000 RBX: ffffffff8fb509c8 RCX: dffffc0000000000
RDX: ffffffff8fb509a0 RSI: ffffffff90308480 RDI: ffffffff8be29d60
RBP: ffffffff8fb509a0 R08: 000000000000000b R09: ffffffff81729ae5
R10: dffffc0000000000 R11: ffffffff81acf3a0 R12: ffffffff81684981
R13: ffffffff8fb509a0 R14: ffffc90000a08128 R15: ffffffff8fb509b4
FS:  0000000000000000(0000) GS:ffff888125d1b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0e75b4a0b5 CR3: 000000000df38000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4328 [inline]
 __kmalloc_node_track_caller_noprof+0x271/0x4e0 mm/slub.c:4347
 __do_krealloc mm/slub.c:4905 [inline]
 krealloc_noprof+0x124/0x340 mm/slub.c:4958
 nf_ct_ext_add+0x1ab/0x450 net/netfilter/nf_conntrack_extend.c:117
 nf_ct_labels_ext_add include/net/netfilter/nf_conntrack_labels.h:45 [inline]
 init_conntrack+0x680/0xef0 net/netfilter/nf_conntrack_core.c:1783
 resolve_normal_ct net/netfilter/nf_conntrack_core.c:1885 [inline]
 nf_conntrack_in+0xbf2/0x1600 net/netfilter/nf_conntrack_core.c:2037
 nf_hook_entry_hookfn include/linux/netfilter.h:157 [inline]
 nf_hook_slow+0xc5/0x220 net/netfilter/core.c:623
 nf_hook include/linux/netfilter.h:272 [inline]
 NF_HOOK+0x206/0x3a0 include/linux/netfilter.h:315
 __netif_receive_skb_one_core net/core/dev.c:5977 [inline]
 __netif_receive_skb+0x143/0x380 net/core/dev.c:6090
 process_backlog+0x60e/0x14f0 net/core/dev.c:6442
 __napi_poll+0xc7/0x480 net/core/dev.c:7414
 napi_poll net/core/dev.c:7478 [inline]
 net_rx_action+0x707/0xe30 net/core/dev.c:7605
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 do_softirq+0xec/0x180 kernel/softirq.c:480
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x17d/0x1c0 kernel/softirq.c:407
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 fpregs_unlock arch/x86/include/asm/fpu/api.h:77 [inline]
 kernel_fpu_end+0xd2/0x120 arch/x86/kernel/fpu/core.c:476
 blake2s_compress+0x5f/0xd0 arch/x86/lib/crypto/blake2s-glue.c:46
 blake2s_update+0x14b/0x450 lib/crypto/blake2s.c:32
 hmac+0x1b6/0x330 drivers/net/wireguard/noise.c:324
 kdf drivers/net/wireguard/noise.c:367 [inline]
 message_ephemeral+0x1e2/0x280 drivers/net/wireguard/noise.c:493
 wg_noise_handshake_consume_initiation+0x1cb/0x900 drivers/net/wireguard/noise.c:605
 wg_receive_handshake_packet drivers/net/wireguard/receive.c:144 [inline]
 wg_packet_handshake_receive_worker+0x5f2/0xfb0 drivers/net/wireguard/receive.c:213
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x711/0x8a0 kernel/kthread.c:464
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

