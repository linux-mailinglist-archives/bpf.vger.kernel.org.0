Return-Path: <bpf+bounces-55809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FBDA86AE7
	for <lists+bpf@lfdr.de>; Sat, 12 Apr 2025 06:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F1F8C68BA
	for <lists+bpf@lfdr.de>; Sat, 12 Apr 2025 04:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E87C187325;
	Sat, 12 Apr 2025 04:33:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880EF10F9
	for <bpf@vger.kernel.org>; Sat, 12 Apr 2025 04:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744432413; cv=none; b=sAtI9ntPDzz+nLdFXwmpsZsiZ+zi/+9BijRSWIvyqXV30jv6P3SPi4zV2e/BONiEH60SwA/eC8OzoPBOHhBJE0uVFMtdtwrgGkeYIIvTy1wMLlFpYCxoMkvXxuFIri6dqMCSLsykNZ1aX8QaLjEzxXdLrgKnySQfsMM5Jr4UxN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744432413; c=relaxed/simple;
	bh=ojitbJHEMKFRhmI/vwHyzo6nauks425Nhh2K8ScZBts=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Sz7wRFsf4QBhTlOwCmrJ45OqfKz7uLkvWU26GXSeYUpw7Eytd1XWRQczCbG/GH6JHSDaKI1JU/Q/qTRi2rl8X46Slx2lUGExsiuWzTTEEM9iucpXhnz4VP5uUK/0sLGRxUO3iqRswJUAi58jgKSmT/iQufmTbAy4ETmP5tICDdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-85b41b906b3so279982939f.0
        for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 21:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744432410; x=1745037210;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U88TuH7H09UT3JLeEKRiNAgRtjuMARbsQFruKUYbc80=;
        b=XIF/CmDQMLz2o9PxSDkrFyFUFdZflX9xxhHMju92cKrLaDMG2nsZTY/GtRuPSJFgXW
         UKPhFfceIZ+BWb3wmi6Wzm+F4oXjl0Ziiy8Fxli3q7tOPK9ZagEW2PnYxM4JaE3PU4gW
         uFrwFybbF/PpHeFOYzUgp25yn1a6eRYGS/PVFmnVLFz7h9ORZZFbcadJy4IDY4D2pft/
         5nOL1TRksedPfeRE0SvhroCkQ0pCda+7n5nMt2ydqWt/AxIaSQb2LPNjhoHGIqGZXkov
         Wi0lU+qw1jJVRbMd3KO+89yQDiP3b4szzmoTd4k+XG4Jk6lZg6mNhaRr0nps8IFN/Kre
         7HTw==
X-Forwarded-Encrypted: i=1; AJvYcCWVHpDzOPAaNTByAO/7BBDpucOZ6Ourt+MOPhz2W17Xj+mDxTKAh0ilHmdEnGcAOnORGcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeEU2dreKtfD1fjr+6d6M+sAbDyfRBrRdtuN0VVJurRMGEsqKq
	01MwQC80xhre2tfRU/I9UJc46+XO8be+BIL5EG0cmPKHtrU05FLR730UWAoYjN3KCfXaV2+70Nr
	ArF/AcIHJiYC+smYzb1Z2+9F2fjVh3Nc0OYVOPKInkqQ6v6muuNunoxA=
X-Google-Smtp-Source: AGHT+IFlhbrTv5tNodhf+fEsKccMSh5Ykk/2nT1WKVpFogTCgLvV1Bd38sQYtoYa5lVBwoqdi0y0jVPJd//FOlZO/N02hQcU1VDC
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1889:b0:3cf:c7d3:e4b with SMTP id
 e9e14a558f8ab-3d7ec27efd0mr65166545ab.21.1744432410456; Fri, 11 Apr 2025
 21:33:30 -0700 (PDT)
Date: Fri, 11 Apr 2025 21:33:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f9ed1a.050a0220.379d84.0005.GAE@google.com>
Subject: [syzbot] [bpf?] [net?] possible deadlock in xsk_notifier (2)
From: syzbot <syzbot+6f588c78bf765b62b450@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bjorn@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jonathan.lemon@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, maciej.fijalkowski@intel.com, 
	magnus.karlsson@intel.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    900241a5cc15 Merge tag 'drm-fixes-2025-04-11-1' of https:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1604ef4c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eecd7902e39d7933
dashboard link: https://syzkaller.appspot.com/bug?extid=6f588c78bf765b62b450
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2c469c14915e/disk-900241a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5ec97d2ebbd8/vmlinux-900241a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0a9190b11490/bzImage-900241a5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6f588c78bf765b62b450@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.15.0-rc1-syzkaller-00246-g900241a5cc15 #0 Not tainted
------------------------------------------------------
syz.3.3171/15285 is trying to acquire lock:
ffff88807d2fc6f0 (&xs->mutex){+.+.}-{4:4}, at: xsk_notifier+0xcf/0x230 net/xdp/xsk.c:1648

but task is already holding lock:
ffff88805fc3bc58 (&net->xdp.lock){+.+.}-{4:4}, at: xsk_notifier+0x8b/0x230 net/xdp/xsk.c:1644

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&net->xdp.lock){+.+.}-{4:4}:
       lock_acquire+0x116/0x2f0 kernel/locking/lockdep.c:5866
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x1a5/0x10c0 kernel/locking/mutex.c:746
       xsk_notifier+0x8b/0x230 net/xdp/xsk.c:1644
       notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
       call_netdevice_notifiers_extack net/core/dev.c:2212 [inline]
       call_netdevice_notifiers net/core/dev.c:2226 [inline]
       unregister_netdevice_many_notify+0x1572/0x2510 net/core/dev.c:11971
       unregister_netdevice_many net/core/dev.c:12035 [inline]
       unregister_netdevice_queue+0x383/0x400 net/core/dev.c:11887
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
       call_netdevice_notifiers_extack net/core/dev.c:2212 [inline]
       call_netdevice_notifiers net/core/dev.c:2226 [inline]
       __dev_close_many+0x15d/0x760 net/core/dev.c:1671
       dev_close_many+0x250/0x4c0 net/core/dev.c:1725
       unregister_netdevice_many_notify+0x628/0x2510 net/core/dev.c:11940
       unregister_netdevice_many net/core/dev.c:12035 [inline]
       default_device_exit_batch+0x7ff/0x880 net/core/dev.c:12527
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
       __ia32_sys_bind+0x7a/0x90 net/socket.c:1844
       do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
       __do_fast_syscall_32+0xb4/0x110 arch/x86/entry/syscall_32.c:306
       do_fast_syscall_32+0x34/0x80 arch/x86/entry/syscall_32.c:331
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #0 (&xs->mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3166 [inline]
       check_prevs_add kernel/locking/lockdep.c:3285 [inline]
       validate_chain+0xa69/0x24e0 kernel/locking/lockdep.c:3909
       __lock_acquire+0xad5/0xd80 kernel/locking/lockdep.c:5235
       lock_acquire+0x116/0x2f0 kernel/locking/lockdep.c:5866
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x1a5/0x10c0 kernel/locking/mutex.c:746
       xsk_notifier+0xcf/0x230 net/xdp/xsk.c:1648
       notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
       call_netdevice_notifiers_extack net/core/dev.c:2212 [inline]
       call_netdevice_notifiers net/core/dev.c:2226 [inline]
       unregister_netdevice_many_notify+0x1572/0x2510 net/core/dev.c:11971
       unregister_netdevice_many net/core/dev.c:12035 [inline]
       unregister_netdevice_queue+0x383/0x400 net/core/dev.c:11887
       unregister_netdevice include/linux/netdevice.h:3374 [inline]
       ip_tunnel_ctl+0x1f6/0xc40 net/ipv4/ip_tunnel.c:998
       ip_tunnel_siocdevprivate+0x107/0x1a0 net/ipv4/ip_tunnel.c:1061
       dev_siocdevprivate net/core/dev_ioctl.c:521 [inline]
       dev_ifsioc+0xc04/0x1010 net/core/dev_ioctl.c:631
       dev_ioctl+0x8c3/0x1380 net/core/dev_ioctl.c:848
       sock_ioctl+0x819/0x900 net/socket.c:1236
       compat_sock_ioctl_trans net/socket.c:-1 [inline]
       compat_sock_ioctl+0x293/0xf50 net/socket.c:3507
       __do_compat_sys_ioctl fs/ioctl.c:1004 [inline]
       __se_compat_sys_ioctl+0x50e/0xc30 fs/ioctl.c:947
       do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
       __do_fast_syscall_32+0xb4/0x110 arch/x86/entry/syscall_32.c:306
       do_fast_syscall_32+0x34/0x80 arch/x86/entry/syscall_32.c:331
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

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

2 locks held by syz.3.3171/15285:
 #0: ffffffff900fd3c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #0: ffffffff900fd3c8 (rtnl_mutex){+.+.}-{4:4}, at: dev_ioctl+0x8b0/0x1380 net/core/dev_ioctl.c:847
 #1: ffff88805fc3bc58 (&net->xdp.lock){+.+.}-{4:4}, at: xsk_notifier+0x8b/0x230 net/xdp/xsk.c:1644

stack backtrace:
CPU: 0 UID: 0 PID: 15285 Comm: syz.3.3171 Not tainted 6.15.0-rc1-syzkaller-00246-g900241a5cc15 #0 PREEMPT(full) 
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
 xsk_notifier+0xcf/0x230 net/xdp/xsk.c:1648
 notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2212 [inline]
 call_netdevice_notifiers net/core/dev.c:2226 [inline]
 unregister_netdevice_many_notify+0x1572/0x2510 net/core/dev.c:11971
 unregister_netdevice_many net/core/dev.c:12035 [inline]
 unregister_netdevice_queue+0x383/0x400 net/core/dev.c:11887
 unregister_netdevice include/linux/netdevice.h:3374 [inline]
 ip_tunnel_ctl+0x1f6/0xc40 net/ipv4/ip_tunnel.c:998
 ip_tunnel_siocdevprivate+0x107/0x1a0 net/ipv4/ip_tunnel.c:1061
 dev_siocdevprivate net/core/dev_ioctl.c:521 [inline]
 dev_ifsioc+0xc04/0x1010 net/core/dev_ioctl.c:631
 dev_ioctl+0x8c3/0x1380 net/core/dev_ioctl.c:848
 sock_ioctl+0x819/0x900 net/socket.c:1236
 compat_sock_ioctl_trans net/socket.c:-1 [inline]
 compat_sock_ioctl+0x293/0xf50 net/socket.c:3507
 __do_compat_sys_ioctl fs/ioctl.c:1004 [inline]
 __se_compat_sys_ioctl+0x50e/0xc30 fs/ioctl.c:947
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xb4/0x110 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x34/0x80 arch/x86/entry/syscall_32.c:331
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf744d579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f50b555c EFLAGS: 00000206 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000000089f2
RDX: 0000000080000500 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	90                   	nop
  33:	90                   	nop
  34:	90                   	nop
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop


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

