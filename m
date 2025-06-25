Return-Path: <bpf+bounces-61539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F46AE8862
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 17:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2034A0A19
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 15:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D90628935A;
	Wed, 25 Jun 2025 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqrIuWz5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E5117B425;
	Wed, 25 Jun 2025 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750865957; cv=none; b=kkE/OKOVDpjsz2kz9ElC9G2AupaCNRICHvgKgtiTwbUo2gwakzRjfQUQvF7bBldHyPMXfGY3NTaDQWBhsFI2NVPQj2pAc8tmftjUNco5yw0vE4xw9r/IlO0EZEvzrnYA3lDY/uCwLs5eXOilbiFtQCjs7E1ORXpdQ2xWm6XYOEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750865957; c=relaxed/simple;
	bh=tT/vsDNULqvD4Qw4DB42OlIKe0Yc3q1BPe5c6McclzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CB4h7pkeVq3Z0DJIICvAtKwhcaM8LCEUHaxRMQJj8ugk2x36W4cIPP+3lvtk1VoFEzqw7iGkZuRPK0lcIJ7psbTouj9zaIdx6KXXNq3mPrzRcmQxBxrYZGu22h5vheh0RmnjIR+ZzGhh0sKxDCewS7RLl9kX1lmMA9Mgxg1qUK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqrIuWz5; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3df2d111fefso15204605ab.1;
        Wed, 25 Jun 2025 08:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750865954; x=1751470754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86340NYCQ0WBYTdAXDtIee86pugHIjYTXIpkWZrdMxM=;
        b=SqrIuWz5bDDJrwadd9L6MAajSdIDyEhNHqU/7zqNpvlqszn4UQBTQSv05dWBcoXfSV
         DfNxvGNuXONvD+vyTY1dgA25Xtnbv/Or4aaXu9+NduE3dAISPV0bp9TS5EJhtwix3X48
         ucKMYh4ephi5i19Q6nW+vpLQxc/wNbt8NtJ6+yxiA3vJ2nQLHoyhxCzGasl+6ry0bmtZ
         IlzCVt733ae/SAe6LSs0qkAnt3JRk2Xu9KrU+QgzGO+9lXkQLXNCSUpQC3NB8wzyxTIG
         mfLHjlG4k+BUGexVEbLTJWOlQS/V2LyohrQ/EEWVxL7fCj4FZt7KgTDkGkOJ01lH7LpK
         Ja6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750865954; x=1751470754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86340NYCQ0WBYTdAXDtIee86pugHIjYTXIpkWZrdMxM=;
        b=N8vr1TwXZeNiUYm5vcnDLo0CCqGWAdJll9eWRmfV0BAWHGv4bhsZd3LIs3XpqseAUW
         HAJWkMjPlTgMENin6cac38Mz6rIPjThXKY9YwhIVAyBRDyEPHw46pB/05kuhyi5MmtLw
         rXcGr6sW6iaWCSInaIJPO4GutefBSMb5BsNR6PsZGBBer02UbbjXMVeTKEE2Pi9ixDwi
         5aFJbIhWn9Qu7W/S32MRL1ZoYJ26t71Uw95JEs2/+PoehopGFhAI67xxdOG46NImvjMc
         jTVQyRcBQ8d+jGgzaCc8qwoc3tc2lrPNSYUfTBkkIe1oTW6EjVIzThIsxDL3Hri+Yw5k
         zeuw==
X-Forwarded-Encrypted: i=1; AJvYcCUT2R8M+62kx86va912HJOfb9sMIl6SG4ByzxQFfpEKthKE0r2Z/op+cS+SfimzCkx9G2AXjb4W@vger.kernel.org, AJvYcCUrmxghF9t8+8NUqyO9mduKdsCpp2R5wVrPHimMs7dfuHZ38QM0IyGkqcdRngXULjKHNRI=@vger.kernel.org, AJvYcCXhgWg9ydvcFKRTwEe7SN9dHt2/GhkzYaZU4dG5tyLR3vmKx2HdM/xd93OhxxJZdOp/IiRYbQt3oFBsVi/s@vger.kernel.org
X-Gm-Message-State: AOJu0YyAbGf9JVhaFc5/vOFBRcSEvzUgNK1iKIxt+YjkleSgyq8HSrJl
	8pDCcx5Bh1N3nOvHEJuez5kNa7hpqyTlhf4/l2V03HPsBlDaSzjPknUFMT0xWHbfGAHTX9r/WmM
	NtbKf1icsJA9S8ZrfGTdboCCTWl9vq8coiM7021k=
X-Gm-Gg: ASbGncsUaCyN1sst/+EM+fJ4NkGuF2QiR0op5xARODNeevB6nVCB64F+rXUSA4SsUSD
	+RT3TaFR7w8OwAJjcs7btJqokCxRJV5c5ksAgMqlw1SrsLfZtxtvg9x0pmkae8W5airyKCnU/ps
	ZDUlxl8qt3u9IpLWhnNAuaOGNJZbud7vinzbYrc8mTPXNF+fwFRVFi
X-Google-Smtp-Source: AGHT+IHn2ngvlx3w//siNf9b0Ba3r4Ygn2cycDMbK90PGBtKsHV53C4RMdhMXxgo7Hw86W+lSygmUCZQCtnEvzcu85o=
X-Received: by 2002:a05:6e02:2181:b0:3dd:d6c2:51fb with SMTP id
 e9e14a558f8ab-3df329224b9mr40177785ab.10.1750865953792; Wed, 25 Jun 2025
 08:39:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <685af3b1.a00a0220.2e5631.0091.GAE@google.com> <CAL+tcoB0as6+5VOk9nu0M_OH4TqT6NjDZBZmgQgdQcYx0pciCw@mail.gmail.com>
 <aFwQZhpWIxVLJ1Ui@mini-arch>
In-Reply-To: <aFwQZhpWIxVLJ1Ui@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 25 Jun 2025 23:38:37 +0800
X-Gm-Features: Ac12FXy0ijCtBBvxF3uOTbRT64AdfGb8Fb6YMPRFtPqWwJ41zn1-T70gHgIVNl8
Message-ID: <CAL+tcoCmiT9XXUVGwcT1NB6bLVK69php-oH+9UL+mH6_HYxGhA@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in xsk_notifier (3)
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: syzbot <syzbot+e67ea9c235b13b4f0020@syzkaller.appspotmail.com>, 
	andrii@kernel.org, ast@kernel.org, bjorn@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jonathan.lemon@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, maciej.fijalkowski@intel.com, 
	magnus.karlsson@intel.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdf@fomichev.me, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 11:06=E2=80=AFPM Stanislav Fomichev
<stfomichev@gmail.com> wrote:
>
> On 06/25, Jason Xing wrote:
> > On Wed, Jun 25, 2025 at 2:51=E2=80=AFAM syzbot
> > <syzbot+e67ea9c235b13b4f0020@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    78f4e737a53e Merge tag 'for-6.16/dm-fixes' of git://g=
it.ke..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D11b48f0c5=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D12ec1a20a=
d573841
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3De67ea9c235b=
13b4f0020
> > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils f=
or Debian) 2.40
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/3ff97b2d201b=
/disk-78f4e737.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/1968f46c8915/vm=
linux-78f4e737.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/3455e371b9=
65/bzImage-78f4e737.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+e67ea9c235b13b4f0020@syzkaller.appspotmail.com
> > >
> > > netlink: 4 bytes leftover after parsing attributes in process `syz.1.=
1331'.
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > WARNING: possible circular locking dependency detected
> > > 6.16.0-rc3-syzkaller-00042-g78f4e737a53e #0 Not tainted
> > > ------------------------------------------------------
> > > syz.1.1331/11144 is trying to acquire lock:
> > > ffff888054b136b0 (&xs->mutex){+.+.}-{4:4}, at: xsk_notifier+0x101/0x2=
80 net/xdp/xsk.c:1649
> > >
> > > but task is already holding lock:
> > > ffff888052f43d58 (&net->xdp.lock){+.+.}-{4:4}, at: xsk_notifier+0xa4/=
0x280 net/xdp/xsk.c:1645
> > >
> > > which lock already depends on the new lock.
> > >
> > >
> > > the existing dependency chain (in reverse order) is:
> > >
> > > -> #2 (&net->xdp.lock){+.+.}-{4:4}:
> > >        __mutex_lock_common kernel/locking/mutex.c:602 [inline]
> > >        __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:747
> > >        xsk_notifier+0xa4/0x280 net/xdp/xsk.c:1645
> > >        notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
> > >        call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2230
> > >        call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
> > >        call_netdevice_notifiers net/core/dev.c:2282 [inline]
> > >        unregister_netdevice_many_notify+0xf9d/0x2700 net/core/dev.c:1=
2077
> > >        unregister_netdevice_many net/core/dev.c:12140 [inline]
> > >        unregister_netdevice_queue+0x305/0x3f0 net/core/dev.c:11984
> > >        register_netdevice+0x18f1/0x2270 net/core/dev.c:11149
> > >        lapbeth_new_device drivers/net/wan/lapbether.c:420 [inline]
> > >        lapbeth_device_event+0x5b1/0xbe0 drivers/net/wan/lapbether.c:4=
62
> > >        notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
> > >        call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2230
> > >        call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
> > >        call_netdevice_notifiers net/core/dev.c:2282 [inline]
> > >        __dev_notify_flags+0x12c/0x2e0 net/core/dev.c:9497
> > >        netif_change_flags+0x108/0x160 net/core/dev.c:9526
> > >        dev_change_flags+0xba/0x250 net/core/dev_api.c:68
> > >        devinet_ioctl+0x11d5/0x1f50 net/ipv4/devinet.c:1200
> > >        inet_ioctl+0x3a7/0x3f0 net/ipv4/af_inet.c:1001
> > >        sock_do_ioctl+0x118/0x280 net/socket.c:1190
> > >        sock_ioctl+0x227/0x6b0 net/socket.c:1311
> > >        vfs_ioctl fs/ioctl.c:51 [inline]
> > >        __do_sys_ioctl fs/ioctl.c:907 [inline]
> > >        __se_sys_ioctl fs/ioctl.c:893 [inline]
> > >        __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:893
> > >        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >        do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
> > >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > -> #1 (&dev_instance_lock_key#20){+.+.}-{4:4}:
> > >        __mutex_lock_common kernel/locking/mutex.c:602 [inline]
> > >        __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:747
> > >        netdev_lock include/linux/netdevice.h:2756 [inline]
> > >        netdev_lock_ops include/net/netdev_lock.h:42 [inline]
> > >        xsk_bind+0x37c/0x1570 net/xdp/xsk.c:1189
> > >        __sys_bind_socket net/socket.c:1810 [inline]
> > >        __sys_bind_socket net/socket.c:1802 [inline]
> > >        __sys_bind+0x1a7/0x260 net/socket.c:1841
> > >        __do_sys_bind net/socket.c:1846 [inline]
> > >        __se_sys_bind net/socket.c:1844 [inline]
> > >        __x64_sys_bind+0x72/0xb0 net/socket.c:1844
> > >        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >        do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
> > >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > -> #0 (&xs->mutex){+.+.}-{4:4}:
> > >        check_prev_add kernel/locking/lockdep.c:3168 [inline]
> > >        check_prevs_add kernel/locking/lockdep.c:3287 [inline]
> > >        validate_chain kernel/locking/lockdep.c:3911 [inline]
> > >        __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5240
> > >        lock_acquire kernel/locking/lockdep.c:5871 [inline]
> > >        lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
> > >        __mutex_lock_common kernel/locking/mutex.c:602 [inline]
> > >        __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:747
> > >        xsk_notifier+0x101/0x280 net/xdp/xsk.c:1649
> > >        notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
> > >        call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2230
> > >        call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
> > >        call_netdevice_notifiers net/core/dev.c:2282 [inline]
> > >        unregister_netdevice_many_notify+0xf9d/0x2700 net/core/dev.c:1=
2077
> > >        rtnl_delete_link net/core/rtnetlink.c:3511 [inline]
> > >        rtnl_dellink+0x3cb/0xa80 net/core/rtnetlink.c:3553
> > >        rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6944
> > >        netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2534
> > >        netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
> > >        netlink_unicast+0x53d/0x7f0 net/netlink/af_netlink.c:1339
> > >        netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
> > >        sock_sendmsg_nosec net/socket.c:712 [inline]
> > >        __sock_sendmsg net/socket.c:727 [inline]
> > >        ____sys_sendmsg+0xa98/0xc70 net/socket.c:2566
> > >        ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
> > >        __sys_sendmsg+0x16d/0x220 net/socket.c:2652
> > >        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >        do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
> > >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > other info that might help us debug this:
> > >
> > > Chain exists of:
> > >   &xs->mutex --> &dev_instance_lock_key#20 --> &net->xdp.lock
> > >
> > >  Possible unsafe locking scenario:
> > >
> > >        CPU0                    CPU1
> > >        ----                    ----
> > >   lock(&net->xdp.lock);
> > >                                lock(&dev_instance_lock_key#20);
> > >                                lock(&net->xdp.lock);
> > >   lock(&xs->mutex);
> >
> > I feel the above race map is not that right?
> >
> > My understanding is as shown below.
> > CPU 0                                                    CPU 1
> > ---                                                           ---
> > unregister_netdevice_many_notify()
> >                                                           xsk_bind()
> > netdev_lock_ops(dev);
> >
> > mutex_lock(&xs->mutex);
> >                                                           netdev_lock_o=
ps(dev);
> > xsk_notifier()
> > mutex_lock(&net->xdp.lock);
> > mutex_lock(&xs->mutex);
> >
> > So ABBA lock case happens, IIUC.
>
> Since we can't (easily) control the ordering in notifiers, looks like
> we need to align xsk_bind ordering (to be instance lock -> xs->mutex).
> LMK if you want to take a stab at this; otherwise I'll try to send a
> fix.

I'm still learning the af_xdp. Sure, I'm interested in it, just a bit
worried if I'm capable of completing it. I will try then.

Thanks,
Jason

