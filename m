Return-Path: <bpf+bounces-61540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37BDAE8890
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 17:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F613AA17B
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 15:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CC629B224;
	Wed, 25 Jun 2025 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/ddR3YB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415BE15DBC1;
	Wed, 25 Jun 2025 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750866409; cv=none; b=NUgjIoNRtgarjAicmPSUmKpbCEve6VuwmLwYchBz4QcTiHolSGwzfPEmYPEbNZOdBh8MAXVOjyRtZvPNWkYpr7UeI64d5qjMCLH3aHZdYWNgb2nigxcKxlKVKO31oLmvY66tc0K62Qh44S25xDJvJvPGsYUr7I1C9WlNikMfkLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750866409; c=relaxed/simple;
	bh=aKgM6Pc1KDtR6QB+3Mz/BgYOpk574O1TBmYyLDC2/Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGjqEjD+wBZTypcBTfjLgSFXACu9s/wylxmyXbL2SupqaLs/uCJ+XSPavzJWtamFdSLxLYIXW74pFWnnT1iKb22kSG4GPuLehUXd5n1j3E/G58bgWz6t0Bbj28/Cj2+e23fDjxrlExTM61p9pfSlCPIlvD3rMutx2Gala9GoH4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/ddR3YB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234d3261631so369935ad.1;
        Wed, 25 Jun 2025 08:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750866407; x=1751471207; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/51X+PmNEz/ZTtQwAkNz0pI8nEQTlFHqT6YHtRmYQVk=;
        b=B/ddR3YB6pMYYy07ZmedAamnolALe1s3/13LowAh21GwcJlI1UGoMLEfcyuy/jhfn4
         swq1uP444aDlg+zxaRFX+IHyCoK8lATh/K2L6z5aMLWny6E9W+WxERftcVkwKVNrdWe1
         ITQ03T0BpElBZnctEO6gMs5LNgNpuflqFLitJHuRFiVjRdqYxzn6Z7n+LxsYSeyT2+Kx
         lII5Pn5euZeeO7J7mFHn2HyM5og6skqtHQQXUyZvBMZUF5cboUDdf6TIL9gtGWYjJp7L
         z+x8UKbJa464DhdNc6htSENsqX0m+xTZJlpdp1Z2u3RzUGNhDyriZimXLWxNW6cx4HBT
         5LSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750866407; x=1751471207;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/51X+PmNEz/ZTtQwAkNz0pI8nEQTlFHqT6YHtRmYQVk=;
        b=aWAPaJ9asO7G/leAV+zhxsDvx5x3Tt4j78t2VWcpE7cLD9FoVCCiaP3owQjxEvVTWD
         KrAl/hcGvOSyXX/6l+/iqOOTqT0DNU0+OyhYSr8JcJNUdWeBxRSWGGr5oqx7dSXBVU/b
         ltvbwA5MX4r1fOSl9SI3JB4Dz6PddSZAryTJ4MYId6HmJv/kxiBWD2uSrdIJzGVxWjKi
         Lo08CPDD7fLf6X19qBMfvSsdUhqptsB73LtrqsiHkj2oX8mQF6Kn519TpY/Bvs1rAqEx
         FFgKvUmtWi9Qoz1jR39tt1/XH8elx1U5LwY0DxgGEajqOHNaE3pz/ItLGK4TBcMj6S7s
         q/NA==
X-Forwarded-Encrypted: i=1; AJvYcCXQE6U3mjPGKWLYByH6gQmQz4hvY20SYkq21bv7I+CVm1AtZCB2ZCRdgZ7BVqLz3aQisEEBCCjjcWcqbSj0@vger.kernel.org, AJvYcCXVWjc17mFVcirwF0nUqAkwITguKDXnhoPxRZTuTcgTaz8zldsUBvAiRRcxHR+GYGLldz8=@vger.kernel.org, AJvYcCXpbIRNOm9QMyUR7JUgkN6LoZ1gIK1vvOikuYR6ZtE03/Yntl+kyDdFIhwjrdXVOyOmYmo1Bu/Y@vger.kernel.org
X-Gm-Message-State: AOJu0YzGRwH2lAi5h4r3kqBCZbqETsRfjXPfvTM3iRySsd+dG8DAf133
	dIvT6wGBIp0sUBAMay7aUdr6WOOhUePWvOLmdlCkxaZul0E3x30ALmg=
X-Gm-Gg: ASbGncvttvcTX/VbHPW8A7kHbJaHoQwugYRq5j9aiAeEU/T9H9H0xCevSsm8kaGZYtB
	95v8d1k4NkP1zC1Xj8N6nvus2xZt+xP9vYeXs+a6euLbEig5BYfe/nhMeo0/EtI/YzdmDNWEc6O
	ryRP3CgRlCAUMt86wbZIo748pXKZS2GIF5BpIZc4K4nGfws7uLHPu1H/8CD/NCsb593NmgRXXNp
	tVttJJgQDnFOv9vjZJf6eMcAUqNogrgVCqQZgSZ/UrWQ/ub6vVQ0UyODAIUTUwHR0YfS2AJlguf
	eAi+hpRiNN/mtSQh720l/GEa+H223wxDKmhLsNQFcFjk5YZ0Hx+pIB2qB2IxmxFJ/XYcuebp+ig
	Y0pBcfy4dOU9Mvfs3Fs0+XaE=
X-Google-Smtp-Source: AGHT+IH37pvTbM1uImAHDo+bJnWCTeX3jIdtvgP5fYWBiLshFdz0z+SJkY/pdvBBhIWareIvSTJzAA==
X-Received: by 2002:a17:902:cec5:b0:234:f4da:7eed with SMTP id d9443c01a7336-23824362d4dmr67367415ad.44.1750866407311;
        Wed, 25 Jun 2025 08:46:47 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-237d8393043sm142621705ad.3.2025.06.25.08.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:46:46 -0700 (PDT)
Date: Wed, 25 Jun 2025 08:46:45 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: syzbot <syzbot+e67ea9c235b13b4f0020@syzkaller.appspotmail.com>,
	andrii@kernel.org, ast@kernel.org, bjorn@kernel.org,
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, jonathan.lemon@gmail.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in xsk_notifier (3)
Message-ID: <aFwZ5WWj835sDGpS@mini-arch>
References: <685af3b1.a00a0220.2e5631.0091.GAE@google.com>
 <CAL+tcoB0as6+5VOk9nu0M_OH4TqT6NjDZBZmgQgdQcYx0pciCw@mail.gmail.com>
 <aFwQZhpWIxVLJ1Ui@mini-arch>
 <CAL+tcoCmiT9XXUVGwcT1NB6bLVK69php-oH+9UL+mH6_HYxGhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoCmiT9XXUVGwcT1NB6bLVK69php-oH+9UL+mH6_HYxGhA@mail.gmail.com>

On 06/25, Jason Xing wrote:
> On Wed, Jun 25, 2025 at 11:06 PM Stanislav Fomichev
> <stfomichev@gmail.com> wrote:
> >
> > On 06/25, Jason Xing wrote:
> > > On Wed, Jun 25, 2025 at 2:51 AM syzbot
> > > <syzbot+e67ea9c235b13b4f0020@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    78f4e737a53e Merge tag 'for-6.16/dm-fixes' of git://git.ke..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=11b48f0c580000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=12ec1a20ad573841
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=e67ea9c235b13b4f0020
> > > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/3ff97b2d201b/disk-78f4e737.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/1968f46c8915/vmlinux-78f4e737.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/3455e371b965/bzImage-78f4e737.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+e67ea9c235b13b4f0020@syzkaller.appspotmail.com
> > > >
> > > > netlink: 4 bytes leftover after parsing attributes in process `syz.1.1331'.
> > > > ======================================================
> > > > WARNING: possible circular locking dependency detected
> > > > 6.16.0-rc3-syzkaller-00042-g78f4e737a53e #0 Not tainted
> > > > ------------------------------------------------------
> > > > syz.1.1331/11144 is trying to acquire lock:
> > > > ffff888054b136b0 (&xs->mutex){+.+.}-{4:4}, at: xsk_notifier+0x101/0x280 net/xdp/xsk.c:1649
> > > >
> > > > but task is already holding lock:
> > > > ffff888052f43d58 (&net->xdp.lock){+.+.}-{4:4}, at: xsk_notifier+0xa4/0x280 net/xdp/xsk.c:1645
> > > >
> > > > which lock already depends on the new lock.
> > > >
> > > >
> > > > the existing dependency chain (in reverse order) is:
> > > >
> > > > -> #2 (&net->xdp.lock){+.+.}-{4:4}:
> > > >        __mutex_lock_common kernel/locking/mutex.c:602 [inline]
> > > >        __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:747
> > > >        xsk_notifier+0xa4/0x280 net/xdp/xsk.c:1645
> > > >        notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
> > > >        call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2230
> > > >        call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
> > > >        call_netdevice_notifiers net/core/dev.c:2282 [inline]
> > > >        unregister_netdevice_many_notify+0xf9d/0x2700 net/core/dev.c:12077
> > > >        unregister_netdevice_many net/core/dev.c:12140 [inline]
> > > >        unregister_netdevice_queue+0x305/0x3f0 net/core/dev.c:11984
> > > >        register_netdevice+0x18f1/0x2270 net/core/dev.c:11149
> > > >        lapbeth_new_device drivers/net/wan/lapbether.c:420 [inline]
> > > >        lapbeth_device_event+0x5b1/0xbe0 drivers/net/wan/lapbether.c:462
> > > >        notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
> > > >        call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2230
> > > >        call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
> > > >        call_netdevice_notifiers net/core/dev.c:2282 [inline]
> > > >        __dev_notify_flags+0x12c/0x2e0 net/core/dev.c:9497
> > > >        netif_change_flags+0x108/0x160 net/core/dev.c:9526
> > > >        dev_change_flags+0xba/0x250 net/core/dev_api.c:68
> > > >        devinet_ioctl+0x11d5/0x1f50 net/ipv4/devinet.c:1200
> > > >        inet_ioctl+0x3a7/0x3f0 net/ipv4/af_inet.c:1001
> > > >        sock_do_ioctl+0x118/0x280 net/socket.c:1190
> > > >        sock_ioctl+0x227/0x6b0 net/socket.c:1311
> > > >        vfs_ioctl fs/ioctl.c:51 [inline]
> > > >        __do_sys_ioctl fs/ioctl.c:907 [inline]
> > > >        __se_sys_ioctl fs/ioctl.c:893 [inline]
> > > >        __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:893
> > > >        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > > >        do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
> > > >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > >
> > > > -> #1 (&dev_instance_lock_key#20){+.+.}-{4:4}:
> > > >        __mutex_lock_common kernel/locking/mutex.c:602 [inline]
> > > >        __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:747
> > > >        netdev_lock include/linux/netdevice.h:2756 [inline]
> > > >        netdev_lock_ops include/net/netdev_lock.h:42 [inline]
> > > >        xsk_bind+0x37c/0x1570 net/xdp/xsk.c:1189
> > > >        __sys_bind_socket net/socket.c:1810 [inline]
> > > >        __sys_bind_socket net/socket.c:1802 [inline]
> > > >        __sys_bind+0x1a7/0x260 net/socket.c:1841
> > > >        __do_sys_bind net/socket.c:1846 [inline]
> > > >        __se_sys_bind net/socket.c:1844 [inline]
> > > >        __x64_sys_bind+0x72/0xb0 net/socket.c:1844
> > > >        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > > >        do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
> > > >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > >
> > > > -> #0 (&xs->mutex){+.+.}-{4:4}:
> > > >        check_prev_add kernel/locking/lockdep.c:3168 [inline]
> > > >        check_prevs_add kernel/locking/lockdep.c:3287 [inline]
> > > >        validate_chain kernel/locking/lockdep.c:3911 [inline]
> > > >        __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5240
> > > >        lock_acquire kernel/locking/lockdep.c:5871 [inline]
> > > >        lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
> > > >        __mutex_lock_common kernel/locking/mutex.c:602 [inline]
> > > >        __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:747
> > > >        xsk_notifier+0x101/0x280 net/xdp/xsk.c:1649
> > > >        notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
> > > >        call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2230
> > > >        call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
> > > >        call_netdevice_notifiers net/core/dev.c:2282 [inline]
> > > >        unregister_netdevice_many_notify+0xf9d/0x2700 net/core/dev.c:12077
> > > >        rtnl_delete_link net/core/rtnetlink.c:3511 [inline]
> > > >        rtnl_dellink+0x3cb/0xa80 net/core/rtnetlink.c:3553
> > > >        rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6944
> > > >        netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2534
> > > >        netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
> > > >        netlink_unicast+0x53d/0x7f0 net/netlink/af_netlink.c:1339
> > > >        netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
> > > >        sock_sendmsg_nosec net/socket.c:712 [inline]
> > > >        __sock_sendmsg net/socket.c:727 [inline]
> > > >        ____sys_sendmsg+0xa98/0xc70 net/socket.c:2566
> > > >        ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
> > > >        __sys_sendmsg+0x16d/0x220 net/socket.c:2652
> > > >        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > > >        do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
> > > >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > >
> > > > other info that might help us debug this:
> > > >
> > > > Chain exists of:
> > > >   &xs->mutex --> &dev_instance_lock_key#20 --> &net->xdp.lock
> > > >
> > > >  Possible unsafe locking scenario:
> > > >
> > > >        CPU0                    CPU1
> > > >        ----                    ----
> > > >   lock(&net->xdp.lock);
> > > >                                lock(&dev_instance_lock_key#20);
> > > >                                lock(&net->xdp.lock);
> > > >   lock(&xs->mutex);
> > >
> > > I feel the above race map is not that right?
> > >
> > > My understanding is as shown below.
> > > CPU 0                                                    CPU 1
> > > ---                                                           ---
> > > unregister_netdevice_many_notify()
> > >                                                           xsk_bind()
> > > netdev_lock_ops(dev);
> > >
> > > mutex_lock(&xs->mutex);
> > >                                                           netdev_lock_ops(dev);
> > > xsk_notifier()
> > > mutex_lock(&net->xdp.lock);
> > > mutex_lock(&xs->mutex);
> > >
> > > So ABBA lock case happens, IIUC.
> >
> > Since we can't (easily) control the ordering in notifiers, looks like
> > we need to align xsk_bind ordering (to be instance lock -> xs->mutex).
> > LMK if you want to take a stab at this; otherwise I'll try to send a
> > fix.
> 
> I'm still learning the af_xdp. Sure, I'm interested in it, just a bit
> worried if I'm capable of completing it. I will try then.

SG, thanks! If you need more details lmk, but basically we need to reorder
netdev_lock_ops() and mutex_lock(lock: &xs->mutex)+XSK_READY check.
And similarly for cleanup (out_unlock/out_release) path.

