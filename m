Return-Path: <bpf+bounces-61526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4FEAE850B
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 15:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024BF189AEEA
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 13:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F72262FF1;
	Wed, 25 Jun 2025 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mit1Iwrd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0B525C831;
	Wed, 25 Jun 2025 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750859096; cv=none; b=mdrqPQEowmZrPUMpkoX1/I8T+dl4DrLuLX5HfgORFJ2bM+/7wNUHLp4Rc+a5MhJshHx/EGEvkUzZHJKJzbNNGLkLqV47m2oAQwg8e1izzN4mnkEbVmRNQjZaP/SQkgmWp9uTjYprthgq+3NjCMgH086ZzTvpkXovSLRsQ1voH6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750859096; c=relaxed/simple;
	bh=Jv1N6NtAkOW5JGjNW/cIZEASYH/c4SGmt+R3+TPykN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IzmyTOLscx3LRzcvbVzlAYSepSxvW6RZD/hpbd1LM8i9r8oqy4qNZOIV3nYBD39ypjDiGl6lrBmN/oZCQcN+GmKX+Iz3BOoSoVwOVoCphvPk48kGT/h3BDY6c7G5hb00zedTd8nLlkd/mIlgwWFRFpsnbl1aX1Hxyg/+jXauU7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mit1Iwrd; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3ddda0a8ba2so14239635ab.0;
        Wed, 25 Jun 2025 06:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750859093; x=1751463893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U52BAG3EPBkC0aUFMrff+X418EDblG8rX84y2XBSKdE=;
        b=mit1IwrdOz3kXKdIqN+GY6dRhcC5qsty/G+rpPbyKdn5Yxjjob6H2RPhRU51fIl6+b
         7AY/Cc0LNSW99x9StR/mx8j2GB1jQuuojoxZUP7esjcQz4zJua6iyMeljpWxYnPopgHy
         MxxGV2owIQ+HPcpcTvS36uAx9vtpnAtTez1fHF4zXu3fNYpDV1rlJdRpQt69BXKiwfCF
         TJo6QkgyzqsstZ9U3CN2OgcIG04mMj18t9s+wNBD21OofQU+Wye7ip7xTTQSM/iXHbzC
         iv58U6JITFykQRSr059m6y4XO6iqofL/7Flth7VWcEERyh6FX9Nh/wfa6MRi5Er9ZlNA
         zArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750859093; x=1751463893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U52BAG3EPBkC0aUFMrff+X418EDblG8rX84y2XBSKdE=;
        b=VNfgY1GSwoj7YfSSvAvWQBDOpS797gFonEcoVL4YahM5LxRn/9KJ/4GYb4I2OVhbyE
         02OtKWcoyYDHLBdOzk/vZT4YytL1x75DzwHYPN5c392CaM/RZdE0hF+LyaxGGDuDUyjM
         jDjk6/AVVAu99Ino9fwPG42qHeFy6zwVZvVzRSGHAB7BTODCRY5WpsWego63Lfl89lUq
         Ri3ednxHcX2P1lX/GwGBu5SS99/KvYxfph8//U7E6cZyKT1soQBCZifuorE/7hamq2Qd
         Jld/xCen/xFD/pToewNyay4TX9wrLFJnjk6vEtDAvhg8iu48hcJjUgcbmQ4mF2oDuXzC
         q6WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnXWt/E0ZiSAU6B96XBBzx4k9d8+Cbhu9yeBOIXFo5kueSLqTLet0qdc+NQeNurQ/Fi/O/mu3w@vger.kernel.org, AJvYcCVo6ywLOM6pQaYUErRDzfjuFt7/++JLdMQZeahPqiQiWy/A8rlJaMVN63jOc4y3hItk4PeRyWdmbnk9UMk2@vger.kernel.org, AJvYcCX9XMSOIvPoNnGVk0gCDjmkHFfwiZzhl6XoKHmy+DubFCRKR3KeiNBC3XBrdjXHtfcVy20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9W9+PEGUTTPfbDuighT4V1mrpwd3+vKZaHsALdOw5bN5+Bb+k
	uqIF6i8Zy/kFCtTRxuT7N6es7RU2uslzHvcwRwmKVDwxgN3pmheiqkiuIH+dYSkmU4IXulrxU9G
	ypL4P/tCx+BWiXvW0dyCG/VLTOwxd5Kg=
X-Gm-Gg: ASbGncvQOFBPN6sIC7Mi8QalIX1S6hHoXNCMBeZx7+lUPL1xdDdWEPtwDJA3u1m2XZc
	afofad1ip982Ms3hgEc3OkrAWm9k1hkdsGGZSpzmvnrFB/RS0TU2/0kbYS2Mr4dcuAjp5FRf21l
	4bxUIOjJtfsXsez5QemYJ0iosbhOUSiI1PqjhAlfgTcWXqDvyngtta
X-Google-Smtp-Source: AGHT+IGlFrKfqr7E7UhGZNBI7crzmEJafhSwoLnoXp+TkYnwO9BVyMDW0GLoERJ+FO1LwjBTdlu/oxVBxzZEzMeA1LM=
X-Received: by 2002:a05:6e02:2604:b0:3df:3b77:1ed8 with SMTP id
 e9e14a558f8ab-3df3b772186mr9222475ab.7.1750859092659; Wed, 25 Jun 2025
 06:44:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <685af3b1.a00a0220.2e5631.0091.GAE@google.com>
In-Reply-To: <685af3b1.a00a0220.2e5631.0091.GAE@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 25 Jun 2025 21:44:16 +0800
X-Gm-Features: Ac12FXy1_QI9Mo8C7FLtCTJMvsRWy-G7fmjCR5BV_rgMSQ-LFc9rSSIXkD8I-xc
Message-ID: <CAL+tcoB0as6+5VOk9nu0M_OH4TqT6NjDZBZmgQgdQcYx0pciCw@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in xsk_notifier (3)
To: syzbot <syzbot+e67ea9c235b13b4f0020@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bjorn@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jonathan.lemon@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, maciej.fijalkowski@intel.com, 
	magnus.karlsson@intel.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdf@fomichev.me, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 2:51=E2=80=AFAM syzbot
<syzbot+e67ea9c235b13b4f0020@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    78f4e737a53e Merge tag 'for-6.16/dm-fixes' of git://git.k=
e..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D11b48f0c58000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D12ec1a20ad573=
841
> dashboard link: https://syzkaller.appspot.com/bug?extid=3De67ea9c235b13b4=
f0020
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3ff97b2d201b/dis=
k-78f4e737.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1968f46c8915/vmlinu=
x-78f4e737.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3455e371b965/b=
zImage-78f4e737.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+e67ea9c235b13b4f0020@syzkaller.appspotmail.com
>
> netlink: 4 bytes leftover after parsing attributes in process `syz.1.1331=
'.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.16.0-rc3-syzkaller-00042-g78f4e737a53e #0 Not tainted
> ------------------------------------------------------
> syz.1.1331/11144 is trying to acquire lock:
> ffff888054b136b0 (&xs->mutex){+.+.}-{4:4}, at: xsk_notifier+0x101/0x280 n=
et/xdp/xsk.c:1649
>
> but task is already holding lock:
> ffff888052f43d58 (&net->xdp.lock){+.+.}-{4:4}, at: xsk_notifier+0xa4/0x28=
0 net/xdp/xsk.c:1645
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #2 (&net->xdp.lock){+.+.}-{4:4}:
>        __mutex_lock_common kernel/locking/mutex.c:602 [inline]
>        __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:747
>        xsk_notifier+0xa4/0x280 net/xdp/xsk.c:1645
>        notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
>        call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2230
>        call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
>        call_netdevice_notifiers net/core/dev.c:2282 [inline]
>        unregister_netdevice_many_notify+0xf9d/0x2700 net/core/dev.c:12077
>        unregister_netdevice_many net/core/dev.c:12140 [inline]
>        unregister_netdevice_queue+0x305/0x3f0 net/core/dev.c:11984
>        register_netdevice+0x18f1/0x2270 net/core/dev.c:11149
>        lapbeth_new_device drivers/net/wan/lapbether.c:420 [inline]
>        lapbeth_device_event+0x5b1/0xbe0 drivers/net/wan/lapbether.c:462
>        notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
>        call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2230
>        call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
>        call_netdevice_notifiers net/core/dev.c:2282 [inline]
>        __dev_notify_flags+0x12c/0x2e0 net/core/dev.c:9497
>        netif_change_flags+0x108/0x160 net/core/dev.c:9526
>        dev_change_flags+0xba/0x250 net/core/dev_api.c:68
>        devinet_ioctl+0x11d5/0x1f50 net/ipv4/devinet.c:1200
>        inet_ioctl+0x3a7/0x3f0 net/ipv4/af_inet.c:1001
>        sock_do_ioctl+0x118/0x280 net/socket.c:1190
>        sock_ioctl+0x227/0x6b0 net/socket.c:1311
>        vfs_ioctl fs/ioctl.c:51 [inline]
>        __do_sys_ioctl fs/ioctl.c:907 [inline]
>        __se_sys_ioctl fs/ioctl.c:893 [inline]
>        __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:893
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> -> #1 (&dev_instance_lock_key#20){+.+.}-{4:4}:
>        __mutex_lock_common kernel/locking/mutex.c:602 [inline]
>        __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:747
>        netdev_lock include/linux/netdevice.h:2756 [inline]
>        netdev_lock_ops include/net/netdev_lock.h:42 [inline]
>        xsk_bind+0x37c/0x1570 net/xdp/xsk.c:1189
>        __sys_bind_socket net/socket.c:1810 [inline]
>        __sys_bind_socket net/socket.c:1802 [inline]
>        __sys_bind+0x1a7/0x260 net/socket.c:1841
>        __do_sys_bind net/socket.c:1846 [inline]
>        __se_sys_bind net/socket.c:1844 [inline]
>        __x64_sys_bind+0x72/0xb0 net/socket.c:1844
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> -> #0 (&xs->mutex){+.+.}-{4:4}:
>        check_prev_add kernel/locking/lockdep.c:3168 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3287 [inline]
>        validate_chain kernel/locking/lockdep.c:3911 [inline]
>        __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5240
>        lock_acquire kernel/locking/lockdep.c:5871 [inline]
>        lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
>        __mutex_lock_common kernel/locking/mutex.c:602 [inline]
>        __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:747
>        xsk_notifier+0x101/0x280 net/xdp/xsk.c:1649
>        notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
>        call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2230
>        call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
>        call_netdevice_notifiers net/core/dev.c:2282 [inline]
>        unregister_netdevice_many_notify+0xf9d/0x2700 net/core/dev.c:12077
>        rtnl_delete_link net/core/rtnetlink.c:3511 [inline]
>        rtnl_dellink+0x3cb/0xa80 net/core/rtnetlink.c:3553
>        rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6944
>        netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2534
>        netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>        netlink_unicast+0x53d/0x7f0 net/netlink/af_netlink.c:1339
>        netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
>        sock_sendmsg_nosec net/socket.c:712 [inline]
>        __sock_sendmsg net/socket.c:727 [inline]
>        ____sys_sendmsg+0xa98/0xc70 net/socket.c:2566
>        ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
>        __sys_sendmsg+0x16d/0x220 net/socket.c:2652
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
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

I feel the above race map is not that right?

My understanding is as shown below.
CPU 0                                                    CPU 1
---                                                           ---
unregister_netdevice_many_notify()
                                                          xsk_bind()
netdev_lock_ops(dev);

mutex_lock(&xs->mutex);
                                                          netdev_lock_ops(d=
ev);
xsk_notifier()
mutex_lock(&net->xdp.lock);
mutex_lock(&xs->mutex);

So ABBA lock case happens, IIUC.

Thanks,
Jason

>
>  *** DEADLOCK ***
>
> 2 locks held by syz.1.1331/11144:
>  #0: ffffffff9034e4a8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rt=
netlink.c:80 [inline]
>  #0: ffffffff9034e4a8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include=
/linux/rtnetlink.h:130 [inline]
>  #0: ffffffff9034e4a8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_dellink+0x277/0x=
a80 net/core/rtnetlink.c:3545
>  #1: ffff888052f43d58 (&net->xdp.lock){+.+.}-{4:4}, at: xsk_notifier+0xa4=
/0x280 net/xdp/xsk.c:1645
>
> stack backtrace:
> CPU: 1 UID: 0 PID: 11144 Comm: syz.1.1331 Not tainted 6.16.0-rc3-syzkalle=
r-00042-g78f4e737a53e #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 05/07/2025
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  print_circular_bug+0x275/0x350 kernel/locking/lockdep.c:2046
>  check_noncircular+0x14c/0x170 kernel/locking/lockdep.c:2178
>  check_prev_add kernel/locking/lockdep.c:3168 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3287 [inline]
>  validate_chain kernel/locking/lockdep.c:3911 [inline]
>  __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5240
>  lock_acquire kernel/locking/lockdep.c:5871 [inline]
>  lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
>  __mutex_lock_common kernel/locking/mutex.c:602 [inline]
>  __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:747
>  xsk_notifier+0x101/0x280 net/xdp/xsk.c:1649
>  notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
>  call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2230
>  call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
>  call_netdevice_notifiers net/core/dev.c:2282 [inline]
>  unregister_netdevice_many_notify+0xf9d/0x2700 net/core/dev.c:12077
>  rtnl_delete_link net/core/rtnetlink.c:3511 [inline]
>  rtnl_dellink+0x3cb/0xa80 net/core/rtnetlink.c:3553
>  rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6944
>  netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2534
>  netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>  netlink_unicast+0x53d/0x7f0 net/netlink/af_netlink.c:1339
>  netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
>  sock_sendmsg_nosec net/socket.c:712 [inline]
>  __sock_sendmsg net/socket.c:727 [inline]
>  ____sys_sendmsg+0xa98/0xc70 net/socket.c:2566
>  ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
>  __sys_sendmsg+0x16d/0x220 net/socket.c:2652
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f97c7b8e929
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f97c8abc038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f97c7db5fa0 RCX: 00007f97c7b8e929
> RDX: 0000000000000000 RSI: 0000200000000040 RDI: 0000000000000003
> RBP: 00007f97c7c10b39 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f97c7db5fa0 R15: 00007fff09d1ae48
>  </TASK>
> batman_adv: batadv0: Removing interface: batadv_slave_1
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>

