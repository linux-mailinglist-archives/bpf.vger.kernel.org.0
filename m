Return-Path: <bpf+bounces-55615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6B7A8368A
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 04:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9B237AF12F
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 02:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3335E1E261F;
	Thu, 10 Apr 2025 02:35:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8CE1E1308
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 02:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744252527; cv=none; b=eTrEAJKmEtiKlHveKqIT+mZpNKmeFuXA34Yg0fiHyzJ5ynEBVYG0tUjs49CktWmESkZRio+YNbBomVguZbKGlCr8DdVDlGeejz9Y3Ld1wDJLkpgW7py4ZgzMNMRRQD+fUY1pKwVrK/Ssj+rwt9lgT+VVJ83RoLd0CgSo1PiCTB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744252527; c=relaxed/simple;
	bh=hfzSRZYZmIEbDflOrEzA7qkKhQ5vb71z5d6SFB4i4Aw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YUq7zCnUVQ1B2haBOrSNH7pgzIc4+v+xlvnDPsim37fSvM36h4ns0fJSWfq2zHcbR5T97XusdW6Zr6i0XBz2MIMe5jznONyOw4xwozeMV7nayPFjRSdSmhwKNImXogva8fNDnO3qldJqC+oE9YqlSt6oZeAh1OEMr12umzwKsVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d458e61faaso4035765ab.0
        for <bpf@vger.kernel.org>; Wed, 09 Apr 2025 19:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744252525; x=1744857325;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=seNAskAAqbiE6X+p0D7OjDytS2wTZOQSFjJ1rVdcR0I=;
        b=mP1QTceDWzcxvd4qtLn+bFeRKOSJ829hHPrRgegcBAgmlBKuuKzeqnNj/t7+DBlPXE
         wOSnR89mhdc99p81pReOk7kYaWJkxsVezhvLzPG523JcMm//vm1x43YOkx0zEm43p3PU
         r/gjDyzvzX7jIkDyEIIDFCt1Fv5uQRILY2eKDCJBVTer4Y04m2Lx/+BBjSZFRA8zyy7l
         mUHcTZ9i1gFnSVOSdX431OHhZgvtrm+u8hawgKnJSVTCZBpQzqLisdizh73gpPIfwE5V
         xuZIGAFT54ib6hwhW1m5IggsjHtCd49L840oNh0jWSC0aqcIkJvuskwzEDSPWRG/Squj
         wAqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1GnZiKtXqPOXfQ4ak4fWV1v9J9Fs8SfZqUVKV9TqEBUr7WTwddbZrHkB9/DDxKsW4DpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxauOwNuP7ZS+PfZ3yrG+jPUVk1ciKbZoyNMblXOx/7QnfG/k5L
	2FgRGtWsEibsb6fiF7jnTtA55D2QALIbptmQ6+gfPK+HBE2/QI914HW27GRTdcoTpgIc3hW38fU
	DaWrc4gBCbjrIpTnBTsqXyc7GVEO7GX+VpZlVQ3rx3CV8ejnJ+1fNzns=
X-Google-Smtp-Source: AGHT+IFSzO3OEKc2bnJIX8X3oITkSpdHQTsTC6PQ+mvhzXZeWU8tITDuicmTJ29i/+kBaJzA7tuOSmZIMtn763m4vnYjBITaUI0X
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3b84:b0:3d0:26a5:b2c with SMTP id
 e9e14a558f8ab-3d7e4deec38mr8501395ab.8.1744252525351; Wed, 09 Apr 2025
 19:35:25 -0700 (PDT)
Date: Wed, 09 Apr 2025 19:35:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f72e6d.050a0220.258fea.0027.GAE@google.com>
Subject: [syzbot] [bpf?] [net?] possible deadlock in xsk_bind
From: syzbot <syzbot+46043677477d6064a1a0@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bjorn@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jonathan.lemon@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, maciej.fijalkowski@intel.com, 
	magnus.karlsson@intel.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    61f96e684edd Merge tag 'net-6.15-rc1' of git://git.kernel...
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1635523f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2054704dd53fb80
dashboard link: https://syzkaller.appspot.com/bug?extid=46043677477d6064a1a0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a3119b4324e8/disk-61f96e68.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ee1ca254d083/vmlinux-61f96e68.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ed04807ee582/bzImage-61f96e68.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+46043677477d6064a1a0@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.14.0-syzkaller-13305-g61f96e684edd #0 Not tainted
------------------------------------------------------
syz.0.1422/11074 is trying to acquire lock:
ffff888035a5cd30 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2751 [inline]
ffff888035a5cd30 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
ffff888035a5cd30 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: xsk_bind+0x2fd/0xfb0 net/xdp/xsk.c:1188

but task is already holding lock:
ffff88805421d6f0 (&xs->mutex){+.+.}-{4:4}, at: xsk_bind+0x166/0xfb0 net/xdp/xsk.c:1176

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&xs->mutex){+.+.}-{4:4}:
       lock_acquire+0x116/0x2f0 kernel/locking/lockdep.c:5866
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x1a5/0x10c0 kernel/locking/mutex.c:746
       xsk_notifier+0xcf/0x230 net/xdp/xsk.c:1648
       notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
       call_netdevice_notifiers_extack net/core/dev.c:2221 [inline]
       call_netdevice_notifiers net/core/dev.c:2235 [inline]
       unregister_netdevice_many_notify+0x1572/0x2510 net/core/dev.c:11980
       unregister_netdevice_many net/core/dev.c:12044 [inline]
       unregister_netdevice_queue+0x383/0x400 net/core/dev.c:11896
       unregister_netdevice include/linux/netdevice.h:3374 [inline]
       ip6_tnl_siocdevprivate+0x552/0x1570 net/ipv6/ip6_tunnel.c:1717
       dev_siocdevprivate net/core/dev_ioctl.c:521 [inline]
       dev_ifsioc+0xc04/0x1010 net/core/dev_ioctl.c:631
       dev_ioctl+0x8c3/0x1380 net/core/dev_ioctl.c:848
       sock_ioctl+0x819/0x900 net/socket.c:1236
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&net->xdp.lock){+.+.}-{4:4}:
       lock_acquire+0x116/0x2f0 kernel/locking/lockdep.c:5866
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x1a5/0x10c0 kernel/locking/mutex.c:746
       xsk_notifier+0x8b/0x230 net/xdp/xsk.c:1644
       notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
       call_netdevice_notifiers_extack net/core/dev.c:2221 [inline]
       call_netdevice_notifiers net/core/dev.c:2235 [inline]
       unregister_netdevice_many_notify+0x1572/0x2510 net/core/dev.c:11980
       unregister_netdevice_many net/core/dev.c:12044 [inline]
       unregister_netdevice_queue+0x383/0x400 net/core/dev.c:11896
       unregister_netdevice include/linux/netdevice.h:3374 [inline]
       _cfg80211_unregister_wdev+0x163/0x590 net/wireless/core.c:1256
       ieee80211_remove_interfaces+0x4f1/0x700 net/mac80211/iface.c:2316
       ieee80211_unregister_hw+0x5d/0x2c0 net/mac80211/main.c:1681
       mac80211_hwsim_del_radio+0x2c6/0x4c0 drivers/net/wireless/virtual/mac80211_hwsim.c:5665
       hwsim_exit_net+0x5c3/0x670 drivers/net/wireless/virtual/mac80211_hwsim.c:6545
       ops_exit_list net/core/net_namespace.c:172 [inline]
       cleanup_net+0x814/0xd60 net/core/net_namespace.c:654
       process_one_work kernel/workqueue.c:3238 [inline]
       process_scheduled_works+0xac3/0x18e0 kernel/workqueue.c:3319
       worker_thread+0x870/0xd50 kernel/workqueue.c:3400
       kthread+0x7b7/0x940 kernel/kthread.c:464
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (&rdev->wiphy.mtx){+.+.}-{4:4}:
       lock_acquire+0x116/0x2f0 kernel/locking/lockdep.c:5866
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x1a5/0x10c0 kernel/locking/mutex.c:746
       class_wiphy_constructor include/net/cfg80211.h:6092 [inline]
       cfg80211_netdev_notifier_call+0x1b3/0x1430 net/wireless/core.c:1547
       notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
       call_netdevice_notifiers_extack net/core/dev.c:2221 [inline]
       call_netdevice_notifiers net/core/dev.c:2235 [inline]
       __dev_close_many+0x15d/0x760 net/core/dev.c:1680
       dev_close_many+0x250/0x4c0 net/core/dev.c:1734
       unregister_netdevice_many_notify+0x628/0x2510 net/core/dev.c:11949
       unregister_netdevice_many net/core/dev.c:12044 [inline]
       default_device_exit_batch+0x7ff/0x880 net/core/dev.c:12536
       ops_exit_list net/core/net_namespace.c:177 [inline]
       cleanup_net+0x8af/0xd60 net/core/net_namespace.c:654
       process_one_work kernel/workqueue.c:3238 [inline]
       process_scheduled_works+0xac3/0x18e0 kernel/workqueue.c:3319
       worker_thread+0x870/0xd50 kernel/workqueue.c:3400
       kthread+0x7b7/0x940 kernel/kthread.c:464
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (&dev_instance_lock_key#3){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3166 [inline]
       check_prevs_add kernel/locking/lockdep.c:3285 [inline]
       validate_chain+0xa69/0x24e0 kernel/locking/lockdep.c:3909
       __lock_acquire+0xad5/0xd80 kernel/locking/lockdep.c:5235
       lock_acquire+0x116/0x2f0 kernel/locking/lockdep.c:5866
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x1a5/0x10c0 kernel/locking/mutex.c:746
       netdev_lock include/linux/netdevice.h:2751 [inline]
       netdev_lock_ops include/net/netdev_lock.h:42 [inline]
       xsk_bind+0x2fd/0xfb0 net/xdp/xsk.c:1188
       __sys_bind_socket net/socket.c:1810 [inline]
       __sys_bind+0x1de/0x290 net/socket.c:1841
       __do_sys_bind net/socket.c:1846 [inline]
       __se_sys_bind net/socket.c:1844 [inline]
       __x64_sys_bind+0x7a/0x90 net/socket.c:1844
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &dev_instance_lock_key#3 --> &net->xdp.lock --> &xs->mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&xs->mutex);
                               lock(&net->xdp.lock);
                               lock(&xs->mutex);
  lock(&dev_instance_lock_key#3);

 *** DEADLOCK ***

2 locks held by syz.0.1422/11074:
 #0: ffffffff900fc9c8 (rtnl_mutex){+.+.}-{4:4}, at: xsk_bind+0x153/0xfb0 net/xdp/xsk.c:1175
 #1: ffff88805421d6f0 (&xs->mutex){+.+.}-{4:4}, at: xsk_bind+0x166/0xfb0 net/xdp/xsk.c:1176

stack backtrace:
CPU: 1 UID: 0 PID: 11074 Comm: syz.0.1422 Not tainted 6.14.0-syzkaller-13305-g61f96e684edd #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2079
 check_noncircular+0x142/0x160 kernel/locking/lockdep.c:2211
 check_prev_add kernel/locking/lockdep.c:3166 [inline]
 check_prevs_add kernel/locking/lockdep.c:3285 [inline]
 validate_chain+0xa69/0x24e0 kernel/locking/lockdep.c:3909
 __lock_acquire+0xad5/0xd80 kernel/locking/lockdep.c:5235
 lock_acquire+0x116/0x2f0 kernel/locking/lockdep.c:5866
 __mutex_lock_common kernel/locking/mutex.c:601 [inline]
 __mutex_lock+0x1a5/0x10c0 kernel/locking/mutex.c:746
 netdev_lock include/linux/netdevice.h:2751 [inline]
 netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 xsk_bind+0x2fd/0xfb0 net/xdp/xsk.c:1188
 __sys_bind_socket net/socket.c:1810 [inline]
 __sys_bind+0x1de/0x290 net/socket.c:1841
 __do_sys_bind net/socket.c:1846 [inline]
 __se_sys_bind net/socket.c:1844 [inline]
 __x64_sys_bind+0x7a/0x90 net/socket.c:1844
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd38178d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd37f5f6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 00007fd3819a5fa0 RCX: 00007fd38178d169
RDX: 0000000000000010 RSI: 0000200000000180 RDI: 0000000000000003
RBP: 00007fd38180e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fd3819a5fa0 R15: 00007ffc59db1d08
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

