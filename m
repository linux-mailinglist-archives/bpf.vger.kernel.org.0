Return-Path: <bpf+bounces-65083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDB8B1B91B
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 19:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F96118947CA
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 17:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C5D295D91;
	Tue,  5 Aug 2025 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EF6GBPXQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65902472B7;
	Tue,  5 Aug 2025 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754414219; cv=none; b=S0VcZYy7erp1JYh74qmTKFUrolP+oxCp4n71qB3M3whsSZU7e8DbUWgI90GSRMW3NDL8tClkcr7oEHtvhRM3fKMiEyShj4HVuQP1qkEpMh9DeSKjZHkBaDy0vPZPjpupObbSIBHuFGEj60JF9i8mywn0oeM11niDv8uVCl5vz50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754414219; c=relaxed/simple;
	bh=ZyExUuLDVrdmpy9f8MiZn0nc5nFfsV1LXo1uoutzOek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MM6gcgmo34ZuFG/BZMdzZOfE8fRbyuGZ7W7WiHB3Gx+iwXXhK67FW9Yi3mDlH+tLrjppCeI3zfoBkbkR8zm7eaN8DGRAztkfz7yvADfTbtT/Z/n9kdd67ozjvoLbDv65FulSpg9WWWyC2Ipbyw+lc8V6rbBmavdrxxxY4CiaQvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EF6GBPXQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76bdea88e12so3904261b3a.0;
        Tue, 05 Aug 2025 10:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754414217; x=1755019017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P8RhAzm5tGalRyrI3Uz1QuoNudPoOXs8YV2Ba/jsaYY=;
        b=EF6GBPXQs3PnCa4c57VZvXChbRkBxydg28qtORDlmB8Gi+gjoxhq3FnrGI2qNVERnU
         nYDE/MuCoIwLa73UlJxJ/oEk7brW4HXPN8S/KNRrpIjJPRGOFybsvRkFT9OdRjeJOdcQ
         5HQPtDyh4iOouKjoQw3nzX0oBWW+rMvTlcMhmlZgGpOSjF7O3wgmyDhK2b0Iyd9ofERS
         DR+ceI4vPYi+CGJxbCVN4LddsH+WyQ2xRgUqZCIjfUIIR6qT1KCl2bMtGoTAy/qh1LP5
         1ENPV4SBaitIjNkJ5wXQpBuK5vB0LaLvuhcGX0JyaNF1Iz3Ny9G0/ImXrUHpyHMn0Iz6
         Z2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754414217; x=1755019017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8RhAzm5tGalRyrI3Uz1QuoNudPoOXs8YV2Ba/jsaYY=;
        b=jCQZHlUa72mtd6BCfFnG2IC5MYYHJMJD03TxyLRkA+G5koMuBIvmO7KY0nKb17M+H9
         M6CbSyhksJDYXV8i94oVMYgkzgAm97sSyLGinwOL+4YFJGgMX33qveVCJH2aUx29V5iL
         PYearCFFAdJovR+BA2tB+Xh4qsz6T/0j1luPurTJuwEStPjPCyGi/apriy9pOpOs/poD
         4oFPzbRr9UtniM8iSiMLv1y6nHIZqwCFv+r67oVt+gK2nlW8aJASOQjp0Q1TzgXivBoA
         8HjI2FYvTOlXHkQy6cYmF2veg82UPmsedKWUdU+e+r+EeHHzj+MzXEV8yvQ3kJGmZnXQ
         KSPg==
X-Forwarded-Encrypted: i=1; AJvYcCUUALtB903SEEWBkfr/9J1gh1sSGm6JauChvB8xj0S+9WMNEDQgNNXlld8K7fzIUcEQ3Ck=@vger.kernel.org, AJvYcCUWsVvueiqQGzEe/3ofnXbN/fhwPMdfRPvEj23s9qbRfkm4KON54678z6jEXIO6qTeHNSV71Y7AY5FK41Mn@vger.kernel.org, AJvYcCV6yhu3ka/N8tsITbiVwIIZ2Oa4c/pSkbjZcaulQMQkohQTTGTG6pXBe39j5pbr3VgmWpbE2WRa@vger.kernel.org
X-Gm-Message-State: AOJu0YwzMOczWqhCdEOX10RhAdvgwJhPjR3GGqAThfTsRfIdIBiLs4G0
	+EPfApbGnzQ8057l0EOIlEZ3PMmetHzJVQxi5v16Z0awuSqf9q9ffZs=
X-Gm-Gg: ASbGnctogUvys2BoJYNb2F49aHpH08p5eviZU3NVjsVepxgSDIgvo7rZ8TZPXOfs7lR
	/1pIgBESNMJ5UXyQ/oRRMQ2di7PHKJR5dmS4NCjPx+knkS8DF6/VKO6Fk9F3mZg0KWtl32C7BFQ
	FXAAhRAsjkb5bLzipcC/tPujbh4uJBsLfnzAembUleWb1YEIfFHZlUHxj4GvI4LdQC+OXiIO0Ze
	S71oKhlUaubwrg9FrK7sY6yvASf9dyYZ72xuGDMb7wJIyvY0hAp9XVb16Y34rCJO67EpeMjN+Sc
	U2hBpdvA4KD/M8AROAnPnyRJ7STx4/o5go20NHi16JLp2yWFnTaY2GSM2j66QAKGOXWh0oEmPEE
	oF5iJVIPbX1pCXVy2LYi63lsOKwB1aCEvGTFSzqrYtjQj7A/wBr4d9jggljU=
X-Google-Smtp-Source: AGHT+IEG1PWX5t5R0j+vg7A2komMl5Z0xmYaY8JZzhBmtz4ApZV1acv7YnstnB5hdnO0pzBbLA1lLQ==
X-Received: by 2002:a05:6a00:1805:b0:748:f1ba:9af8 with SMTP id d2e1a72fcca58-76bec5026ffmr20730559b3a.21.1754414217161;
        Tue, 05 Aug 2025 10:16:57 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76bccfc0a2asm13541015b3a.70.2025.08.05.10.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 10:16:56 -0700 (PDT)
Date: Tue, 5 Aug 2025 10:16:56 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: syzbot <syzbot+e6300f66a999a6612477@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bjorn@kernel.org,
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, jonathan.lemon@gmail.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in xsk_diag_dump (2)
Message-ID: <aJI8iPFU9__PW-tU@mini-arch>
References: <6890e510.050a0220.1fc43d.000f.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6890e510.050a0220.1fc43d.000f.GAE@google.com>

On 08/04, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d2eedaa3909b Merge tag 'rtc-6.17' of git://git.kernel.org/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=159482f0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=75e522434dc68cb9
> dashboard link: https://syzkaller.appspot.com/bug?extid=e6300f66a999a6612477
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3435b26b899d/disk-d2eedaa3.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/531223373575/vmlinux-d2eedaa3.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e82f9030b8d5/bzImage-d2eedaa3.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e6300f66a999a6612477@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.16.0-syzkaller-11489-gd2eedaa3909b #0 Not tainted
> ------------------------------------------------------
> syz.8.4735/22857 is trying to acquire lock:
> ffff8880223e06b8 (&xs->mutex){+.+.}-{4:4}, at: xsk_diag_fill net/xdp/xsk_diag.c:113 [inline]
> ffff8880223e06b8 (&xs->mutex){+.+.}-{4:4}, at: xsk_diag_dump+0x550/0x14d0 net/xdp/xsk_diag.c:166
> 
> but task is already holding lock:
> ffff888031291c98 (&net->xdp.lock){+.+.}-{4:4}, at: xsk_diag_dump+0x178/0x14d0 net/xdp/xsk_diag.c:158
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #2 (&net->xdp.lock){+.+.}-{4:4}:
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>        __mutex_lock_common kernel/locking/mutex.c:598 [inline]
>        __mutex_lock+0x187/0x1360 kernel/locking/mutex.c:760
>        xsk_notifier+0x89/0x230 net/xdp/xsk.c:1664
>        notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
>        call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
>        call_netdevice_notifiers net/core/dev.c:2281 [inline]
>        unregister_netdevice_many_notify+0x14d7/0x1ff0 net/core/dev.c:12156
>        unregister_netdevice_many net/core/dev.c:12219 [inline]
>        unregister_netdevice_queue+0x33c/0x380 net/core/dev.c:12063
>        register_netdevice+0x1689/0x1ae0 net/core/dev.c:11241
>        bpq_new_device drivers/net/hamradio/bpqether.c:481 [inline]
>        bpq_device_event+0x491/0x600 drivers/net/hamradio/bpqether.c:523
>        notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
>        call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
>        call_netdevice_notifiers net/core/dev.c:2281 [inline]
>        __dev_notify_flags+0x18d/0x2e0 net/core/dev.c:-1
>        netif_change_flags+0xe8/0x1a0 net/core/dev.c:9608
>        dev_change_flags+0x130/0x260 net/core/dev_api.c:68
>        devinet_ioctl+0xbb4/0x1b50 net/ipv4/devinet.c:1200
>        inet_ioctl+0x3c0/0x4c0 net/ipv4/af_inet.c:1001
>        sock_do_ioctl+0xdc/0x300 net/socket.c:1238
>        sock_ioctl+0x576/0x790 net/socket.c:1359
>        vfs_ioctl fs/ioctl.c:51 [inline]
>        __do_sys_ioctl fs/ioctl.c:598 [inline]
>        __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #1 (&dev_instance_lock_key#20){+.+.}-{4:4}:
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>        __mutex_lock_common kernel/locking/mutex.c:598 [inline]
>        __mutex_lock+0x187/0x1360 kernel/locking/mutex.c:760
>        netdev_lock include/linux/netdevice.h:2758 [inline]
>        netdev_lock_ops include/net/netdev_lock.h:42 [inline]
>        xsk_bind+0x2f7/0xf90 net/xdp/xsk.c:1193
>        __sys_bind_socket net/socket.c:1858 [inline]
>        __sys_bind+0x2c6/0x3e0 net/socket.c:1889
>        __do_sys_bind net/socket.c:1894 [inline]
>        __se_sys_bind net/socket.c:1892 [inline]
>        __x64_sys_bind+0x7a/0x90 net/socket.c:1892
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #0 (&xs->mutex){+.+.}-{4:4}:
>        check_prev_add kernel/locking/lockdep.c:3165 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3284 [inline]
>        validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
>        __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>        __mutex_lock_common kernel/locking/mutex.c:598 [inline]
>        __mutex_lock+0x187/0x1360 kernel/locking/mutex.c:760
>        xsk_diag_fill net/xdp/xsk_diag.c:113 [inline]
>        xsk_diag_dump+0x550/0x14d0 net/xdp/xsk_diag.c:166
>        netlink_dump+0x6e4/0xe90 net/netlink/af_netlink.c:2327
>        __netlink_dump_start+0x5cb/0x7e0 net/netlink/af_netlink.c:2442
>        netlink_dump_start include/linux/netlink.h:341 [inline]
>        xsk_diag_handler_dump+0x183/0x220 net/xdp/xsk_diag.c:193
>        sock_diag_rcv_msg+0x4cc/0x600 net/core/sock_diag.c:-1
>        netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
>        netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
>        netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
>        netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
>        sock_sendmsg_nosec net/socket.c:714 [inline]
>        __sock_sendmsg+0x21c/0x270 net/socket.c:729
>        sock_write_iter+0x258/0x330 net/socket.c:1179
>        do_iter_readv_writev+0x56e/0x7f0 fs/read_write.c:-1
>        vfs_writev+0x31a/0x960 fs/read_write.c:1057
>        do_writev+0x14d/0x2d0 fs/read_write.c:1103
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   &xs->mutex --> &dev_instance_lock_key#20 --> &net->xdp.lock
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&net->xdp.lock);
>                                lock(&dev_instance_lock_key#20);
>                                lock(&net->xdp.lock);
>   lock(&xs->mutex);
> 
>  *** DEADLOCK ***
> 
> 2 locks held by syz.8.4735/22857:
>  #0: ffff8880223e16d0 (nlk_cb_mutex-SOCK_DIAG){+.+.}-{4:4}, at: __netlink_dump_start+0xfe/0x7e0 net/netlink/af_netlink.c:2406
>  #1: ffff888031291c98 (&net->xdp.lock){+.+.}-{4:4}, at: xsk_diag_dump+0x178/0x14d0 net/xdp/xsk_diag.c:158
> 
> stack backtrace:
> CPU: 0 UID: 0 PID: 22857 Comm: syz.8.4735 Not tainted 6.16.0-syzkaller-11489-gd2eedaa3909b #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2043
>  check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2175
>  check_prev_add kernel/locking/lockdep.c:3165 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3284 [inline]
>  validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
>  __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
>  lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>  __mutex_lock_common kernel/locking/mutex.c:598 [inline]
>  __mutex_lock+0x187/0x1360 kernel/locking/mutex.c:760
>  xsk_diag_fill net/xdp/xsk_diag.c:113 [inline]
>  xsk_diag_dump+0x550/0x14d0 net/xdp/xsk_diag.c:166
>  netlink_dump+0x6e4/0xe90 net/netlink/af_netlink.c:2327
>  __netlink_dump_start+0x5cb/0x7e0 net/netlink/af_netlink.c:2442
>  netlink_dump_start include/linux/netlink.h:341 [inline]
>  xsk_diag_handler_dump+0x183/0x220 net/xdp/xsk_diag.c:193
>  sock_diag_rcv_msg+0x4cc/0x600 net/core/sock_diag.c:-1
>  netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
>  netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
>  netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
>  netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
>  sock_sendmsg_nosec net/socket.c:714 [inline]
>  __sock_sendmsg+0x21c/0x270 net/socket.c:729
>  sock_write_iter+0x258/0x330 net/socket.c:1179
>  do_iter_readv_writev+0x56e/0x7f0 fs/read_write.c:-1
>  vfs_writev+0x31a/0x960 fs/read_write.c:1057
>  do_writev+0x14d/0x2d0 fs/read_write.c:1103
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f6e7b38eb69
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f6e791d5038 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
> RAX: ffffffffffffffda RBX: 00007f6e7b5b6160 RCX: 00007f6e7b38eb69
> RDX: 0000000000000001 RSI: 0000200000000140 RDI: 0000000000000007
> RBP: 00007f6e7b411df1 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f6e7b5b6160 R15: 00007ffdbe0ab9a8
>  </TASK>

Looks similar to [0] but this time comes via bpq_device_event.
I can try to pack the fix from 0 and do something similar here as well..

0: https://lore.kernel.org/netdev/685af3b1.a00a0220.2e5631.0091.GAE@google.com/

