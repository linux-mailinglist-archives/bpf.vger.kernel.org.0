Return-Path: <bpf+bounces-55451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DE6A803BE
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 14:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F253B6879
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 11:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CD7268688;
	Tue,  8 Apr 2025 11:53:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381DA268C6B
	for <bpf@vger.kernel.org>; Tue,  8 Apr 2025 11:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113218; cv=none; b=YoFr8PeTXwDHChxxgJf/adzomjNCQOcAabMManTJCVV6iPouSptCOOKKcyKnyuWaZr2Z+USZ6f36dFUle+ugxgn5+wx3/YaQeMFuoR+La/CpQWdUTaIzBXXCp5TxTkDZInnZeWP3L/PqDyU1hItnAjfrBIcktfuNGn9iAOIFEMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113218; c=relaxed/simple;
	bh=orQmC8douUBCMe7A+rGO1OMONi3j02y+HFy6esDvlo4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=G40DLGXqq5bw2f7BE4nnSFaQvpl2t4GVT7txFkzc2TiDDTHGEQZZZ2GsVoUtI5T9xElQDjmUpICMREddG6mEoKOMlrhx7NL1/A/kzHxrk3OOvCTPdtQTnTgBx4v/+WmI1lG4HN1OC1a4Fr02ZPG//VKAI5wKNfdRxK44Y6QklLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d451ad5b2dso64893655ab.0
        for <bpf@vger.kernel.org>; Tue, 08 Apr 2025 04:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744113215; x=1744718015;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yyKIF+kDQ+OyPVEZulRdmjSzR121gPzyDZOV6/tx19I=;
        b=oeel4ahl8rQy4ctgfUDY9VunfNQ8OW3jgNFX/NJBLRk+weynzZoM2kSUA8FeD51X+N
         zZYeA8s93e8lbVc/NEhT4C0K0rnnZkaXO6xe7FBK0koWmR1pwDsFoZYTDoWnGmljksmb
         pUgUHjjHhGHm92O70zOaSTZnZRMw5PZBFIiTweBTc74EO34i/KtGYLvTYz1RwebAzLo3
         lO5phXIL/8Qg8cGqt1Z+7n1AJjlPlPJ5UpIW8BNjtl0rx1tGd3qqAehnRHwUc1ErDz/w
         mThNLfyjTTypVIJS7heJwH/Bb0YTKpQlV2kHpFlO0DSrSFcpb157yi8AEFt1ZZtBaaja
         xdFg==
X-Forwarded-Encrypted: i=1; AJvYcCXNSYhujmrTHGutNrahCzgYXbKVR+lHXQD+Mq/noHVewQZ8D6vpolPE0n8B5MzLx5t66hY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybp2a6YGeTLSDG0KNKz8XnJOlW1NIIVyEwDdnF4ym4jLv/S3Zt
	LQmdIRb0bnTt1gu47nkPP2QdtroaU/JiMjb264PDvUSFiJP3fe47Fz6xjr7Rbb806mmfIIgOzgg
	J8GbAcf9GfPj2Ot7MWTDJ+zGT4RGku+Y/YMlK8ZvA9IV+8T0FOV+5ppM=
X-Google-Smtp-Source: AGHT+IFKdIiz5f4uYk7nxY+6Yf7xd6gTJSr/6moDZGfVo9sX1dqUiG9kzMvaZAbbhrwGBE4BloxtWHhjgYHM3drtF+orMe4yWIvM
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8e:b0:3d4:2acc:81fa with SMTP id
 e9e14a558f8ab-3d70368ba91mr30895135ab.2.1744113215317; Tue, 08 Apr 2025
 04:53:35 -0700 (PDT)
Date: Tue, 08 Apr 2025 04:53:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f50e3f.050a0220.396535.0562.GAE@google.com>
Subject: [syzbot] [net?] [bpf?] possible deadlock in xsk_diag_dump
From: syzbot <syzbot+4ebb06d5f6e3597279c0@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=11923b4c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2054704dd53fb80
dashboard link: https://syzkaller.appspot.com/bug?extid=4ebb06d5f6e3597279c0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a3119b4324e8/disk-61f96e68.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ee1ca254d083/vmlinux-61f96e68.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ed04807ee582/bzImage-61f96e68.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4ebb06d5f6e3597279c0@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.14.0-syzkaller-13305-g61f96e684edd #0 Not tainted
------------------------------------------------------
syz.2.908/8961 is trying to acquire lock:
ffff88805c6b06f0 (&xs->mutex){+.+.}-{4:4}, at: xsk_diag_fill net/xdp/xsk_diag.c:113 [inline]
ffff88805c6b06f0 (&xs->mutex){+.+.}-{4:4}, at: xsk_diag_dump+0x5be/0x19d0 net/xdp/xsk_diag.c:166

but task is already holding lock:
ffff88805e529c58 (&net->xdp.lock){+.+.}-{4:4}, at: xsk_diag_dump+0x18e/0x19d0 net/xdp/xsk_diag.c:158

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&net->xdp.lock){+.+.}-{4:4}:
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

-> #2 (&rdev->wiphy.mtx){+.+.}-{4:4}:
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

-> #1 (&dev_instance_lock_key#3){+.+.}-{4:4}:
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

-> #0 (&xs->mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3166 [inline]
       check_prevs_add kernel/locking/lockdep.c:3285 [inline]
       validate_chain+0xa69/0x24e0 kernel/locking/lockdep.c:3909
       __lock_acquire+0xad5/0xd80 kernel/locking/lockdep.c:5235
       lock_acquire+0x116/0x2f0 kernel/locking/lockdep.c:5866
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x1a5/0x10c0 kernel/locking/mutex.c:746
       xsk_diag_fill net/xdp/xsk_diag.c:113 [inline]
       xsk_diag_dump+0x5be/0x19d0 net/xdp/xsk_diag.c:166
       netlink_dump+0x678/0xeb0 net/netlink/af_netlink.c:2309
       __netlink_dump_start+0x5a2/0x790 net/netlink/af_netlink.c:2424
       netlink_dump_start include/linux/netlink.h:340 [inline]
       xsk_diag_handler_dump+0x1de/0x270 net/xdp/xsk_diag.c:193
       sock_diag_rcv_msg+0x3dc/0x5f0 net/core/sock_diag.c:-1
       netlink_rcv_skb+0x208/0x480 net/netlink/af_netlink.c:2534
       netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
       netlink_unicast+0x7f8/0x9a0 net/netlink/af_netlink.c:1339
       netlink_sendmsg+0x8c3/0xcd0 net/netlink/af_netlink.c:1883
       sock_sendmsg_nosec net/socket.c:712 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:727
       sock_write_iter+0x2d9/0x3f0 net/socket.c:1131
       do_iter_readv_writev+0x71f/0x9d0 fs/read_write.c:-1
       vfs_writev+0x38d/0xbc0 fs/read_write.c:1055
       do_writev+0x1b8/0x360 fs/read_write.c:1101
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &xs->mutex --> &rdev->wiphy.mtx --> &net->xdp.lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&net->xdp.lock);
                               lock(&rdev->wiphy.mtx);
                               lock(&net->xdp.lock);
  lock(&xs->mutex);

 *** DEADLOCK ***

2 locks held by syz.2.908/8961:
 #0: ffff88805c6b76c8 (nlk_cb_mutex-SOCK_DIAG){+.+.}-{4:4}, at: __netlink_dump_start+0x119/0x790 net/netlink/af_netlink.c:2388
 #1: ffff88805e529c58 (&net->xdp.lock){+.+.}-{4:4}, at: xsk_diag_dump+0x18e/0x19d0 net/xdp/xsk_diag.c:158

stack backtrace:
CPU: 0 UID: 0 PID: 8961 Comm: syz.2.908 Not tainted 6.14.0-syzkaller-13305-g61f96e684edd #0 PREEMPT(full) 
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
 xsk_diag_fill net/xdp/xsk_diag.c:113 [inline]
 xsk_diag_dump+0x5be/0x19d0 net/xdp/xsk_diag.c:166
 netlink_dump+0x678/0xeb0 net/netlink/af_netlink.c:2309
 __netlink_dump_start+0x5a2/0x790 net/netlink/af_netlink.c:2424
 netlink_dump_start include/linux/netlink.h:340 [inline]
 xsk_diag_handler_dump+0x1de/0x270 net/xdp/xsk_diag.c:193
 sock_diag_rcv_msg+0x3dc/0x5f0 net/core/sock_diag.c:-1
 netlink_rcv_skb+0x208/0x480 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x7f8/0x9a0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8c3/0xcd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:727
 sock_write_iter+0x2d9/0x3f0 net/socket.c:1131
 do_iter_readv_writev+0x71f/0x9d0 fs/read_write.c:-1
 vfs_writev+0x38d/0xbc0 fs/read_write.c:1055
 do_writev+0x1b8/0x360 fs/read_write.c:1101
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f466eb8d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f466fa3a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007f466eda6160 RCX: 00007f466eb8d169
RDX: 0000000000000001 RSI: 0000200000019440 RDI: 0000000000000007
RBP: 00007f466ec0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f466eda6160 R15: 00007ffcf86fb978
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

