Return-Path: <bpf+bounces-61532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E7EAE876F
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 17:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0151BC19EB
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 15:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A23D26A08A;
	Wed, 25 Jun 2025 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfygaoOJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65378262FF1;
	Wed, 25 Jun 2025 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750863982; cv=none; b=iDMQB/Dzh1GPdkfbJHvXGKVuaY1dvmO6sjCBjKd9uFHCpck3Rpldm2m2zmmaf6FZ1MMzf6vvJKv/mVXKLDO4GUpZ8v2wlWdtH/vLDL6x17jQwJUzz7K8SnHfV9JCKyo2ldBM6LIYXk0mAFeZl+QIDDsI9uPAnL/x9YoLBs6AdEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750863982; c=relaxed/simple;
	bh=2ypfGspBI86E2uEBHD/cPFxnYFAoZd9ouBuqFDp0q28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wkv1b2vwMwFqIbXR9WFpIuxqyU1W52JAliO5xj4wsEZ2NBK73L5osH0ppqm3E6yNcwV/uNsFJxGmdFZ8dcI5dfRmxfJdMuQybYHJ6ipoQQGNRCBThvD/4Q3k591vHdi7J6Qj2PmnTAEzMpD/4PEvJMi19hm+ThdsKnHz4BWjEfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfygaoOJ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23633a6ac50so27615015ad.2;
        Wed, 25 Jun 2025 08:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750863977; x=1751468777; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YL0HCtBBxnrrDW707sR535/4iheIMz6T7R1WUld7x5A=;
        b=AfygaoOJAcY9W8VgxREJKYrgTIRMxGzv9KejMheOyRT4fQ47qC6RK2FQNIVpORqrjm
         fij6LCK0nN/KLhn/R9WahRST4w0nRP/sbxacMMfmbKMwKtF3jMC8OHWEWyw6cbXS5WpR
         vKuS6rYVSieTUDtyW2lZiBIkD9xCsM1rm/TKuqFwR5Z95AWhj7NBCIjHNzUWmesEA1QD
         zFWRBOM5oQUKzi5KEIEWLtP9NMxp1e/PcFtlFOWo0pmMspJ0Z4gQC7W1tYjc5eiej/7R
         cC6mHEX5uLoWFTYaGn5AdwV7Y9pSG8LFRxPRrnG0NY7Jr1f3AUqlzUs8rNYU6Lujq56d
         xZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750863977; x=1751468777;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YL0HCtBBxnrrDW707sR535/4iheIMz6T7R1WUld7x5A=;
        b=WiN9j7SaSq2LTMtZqUuuruK1hJAafwEWhLN6WE5sQ1IWVUhJxR9pEaiTlqD3zHIB07
         auh+QOBp5xtevtx5JrY6tl7aP3/+Npkle0K9uAOzF07j74E+tDUEGH1MAHb72Dbp56Hk
         0tL4dahJADepv1ZWfw1K8NW/Oifzbb0gZYgM3KQo8IJ6EN4EyfRTCCgzrX5ZCrEQYTRp
         b/thj47Y5ZSSq54ZiDs+3EnV13uKpDAgAQJ4QcqBhtN7D56e5brhQ2EoAm+hp0AnK2R5
         32Q213PhFQ2fm0L47ipf7rF9SdTgeioGbj8KPoyI/EX75tmm6I+A5NsXomL1X654WITN
         J4wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT5R2P/YtvdUupd2r6iQDKi5HlSXHKtocqWOvjDMpvxmhb2RmJDCo0KhmyN1ScfwMtf1RgZwOT@vger.kernel.org, AJvYcCXCi/Wd6Foxli5hbpjLUzHbrZ5bTsBbj4XI/bDjjt3oUVUyz4rmwGbEXi0tTVv7OSsJd/0=@vger.kernel.org, AJvYcCXiFZ50DrYHOAs+UCl4obva/rU25ICTTCdVILJrbRp93i7Cqmn4CXJtLT9bVFQR+xW9pxPRunYl56F8G4SB@vger.kernel.org
X-Gm-Message-State: AOJu0YxBvqN94DM8xIz3oz33kiIqpZklLO3hr5aXvKOYXHXZfJwZPbSF
	0ZLroj+CFttzf9MQk5wM2UNuwLvUix4wmt6UOe+Z+30fnboTK7qYqJ2lgei+
X-Gm-Gg: ASbGncsJ6696wM7BynNH5qHhP6GEdrJCx0pxREuUsihqNTbxn9OrFz8pGVDYu9J4IPb
	irg3Y8SNuzWgzW9zcb4je4RlYxqzlEupzmLvEnK1msxK9q/gd9ldedTDGYeFhZ8IWpW2whsmdlz
	9Sy2CrwJZoOSJfLsUK/o0xB28OyX8VBxogp4UjdMdNqKTbL1zvvVKCTbHkd3+i013WNhyvktE6d
	wgyWcFct20hq2k5N7iYO8iEdWjAQwiG0l8iB2blan7FLdz1YiWOc5bGEMH04qkrv82TaDaQuNED
	Mxh+2mGv60X5WBOCSxfMICVSYYTj5nQyG5ICoQq3/vc8DDMMy9ruJ+XKmr0LSeysmb0q23DzhT8
	bdvY6AYxd7wyjAHqKMpqmenc=
X-Google-Smtp-Source: AGHT+IEsmuWyEyajFfX0ZFbVi5FKhFVstCiM/DDJBnmrxkjER0DRtxLXzKlp52i+/qeu/rna0fs/XA==
X-Received: by 2002:a17:903:24e:b0:234:c8f6:1b17 with SMTP id d9443c01a7336-23824051a2fmr70229005ad.38.1750863976162;
        Wed, 25 Jun 2025 08:06:16 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-237d8393043sm141760815ad.3.2025.06.25.08.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:06:15 -0700 (PDT)
Date: Wed, 25 Jun 2025 08:06:14 -0700
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
Message-ID: <aFwQZhpWIxVLJ1Ui@mini-arch>
References: <685af3b1.a00a0220.2e5631.0091.GAE@google.com>
 <CAL+tcoB0as6+5VOk9nu0M_OH4TqT6NjDZBZmgQgdQcYx0pciCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoB0as6+5VOk9nu0M_OH4TqT6NjDZBZmgQgdQcYx0pciCw@mail.gmail.com>

On 06/25, Jason Xing wrote:
> On Wed, Jun 25, 2025 at 2:51 AM syzbot
> <syzbot+e67ea9c235b13b4f0020@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    78f4e737a53e Merge tag 'for-6.16/dm-fixes' of git://git.ke..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11b48f0c580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=12ec1a20ad573841
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e67ea9c235b13b4f0020
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/3ff97b2d201b/disk-78f4e737.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/1968f46c8915/vmlinux-78f4e737.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/3455e371b965/bzImage-78f4e737.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+e67ea9c235b13b4f0020@syzkaller.appspotmail.com
> >
> > netlink: 4 bytes leftover after parsing attributes in process `syz.1.1331'.
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 6.16.0-rc3-syzkaller-00042-g78f4e737a53e #0 Not tainted
> > ------------------------------------------------------
> > syz.1.1331/11144 is trying to acquire lock:
> > ffff888054b136b0 (&xs->mutex){+.+.}-{4:4}, at: xsk_notifier+0x101/0x280 net/xdp/xsk.c:1649
> >
> > but task is already holding lock:
> > ffff888052f43d58 (&net->xdp.lock){+.+.}-{4:4}, at: xsk_notifier+0xa4/0x280 net/xdp/xsk.c:1645
> >
> > which lock already depends on the new lock.
> >
> >
> > the existing dependency chain (in reverse order) is:
> >
> > -> #2 (&net->xdp.lock){+.+.}-{4:4}:
> >        __mutex_lock_common kernel/locking/mutex.c:602 [inline]
> >        __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:747
> >        xsk_notifier+0xa4/0x280 net/xdp/xsk.c:1645
> >        notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
> >        call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2230
> >        call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
> >        call_netdevice_notifiers net/core/dev.c:2282 [inline]
> >        unregister_netdevice_many_notify+0xf9d/0x2700 net/core/dev.c:12077
> >        unregister_netdevice_many net/core/dev.c:12140 [inline]
> >        unregister_netdevice_queue+0x305/0x3f0 net/core/dev.c:11984
> >        register_netdevice+0x18f1/0x2270 net/core/dev.c:11149
> >        lapbeth_new_device drivers/net/wan/lapbether.c:420 [inline]
> >        lapbeth_device_event+0x5b1/0xbe0 drivers/net/wan/lapbether.c:462
> >        notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
> >        call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2230
> >        call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
> >        call_netdevice_notifiers net/core/dev.c:2282 [inline]
> >        __dev_notify_flags+0x12c/0x2e0 net/core/dev.c:9497
> >        netif_change_flags+0x108/0x160 net/core/dev.c:9526
> >        dev_change_flags+0xba/0x250 net/core/dev_api.c:68
> >        devinet_ioctl+0x11d5/0x1f50 net/ipv4/devinet.c:1200
> >        inet_ioctl+0x3a7/0x3f0 net/ipv4/af_inet.c:1001
> >        sock_do_ioctl+0x118/0x280 net/socket.c:1190
> >        sock_ioctl+0x227/0x6b0 net/socket.c:1311
> >        vfs_ioctl fs/ioctl.c:51 [inline]
> >        __do_sys_ioctl fs/ioctl.c:907 [inline]
> >        __se_sys_ioctl fs/ioctl.c:893 [inline]
> >        __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:893
> >        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >        do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
> >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > -> #1 (&dev_instance_lock_key#20){+.+.}-{4:4}:
> >        __mutex_lock_common kernel/locking/mutex.c:602 [inline]
> >        __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:747
> >        netdev_lock include/linux/netdevice.h:2756 [inline]
> >        netdev_lock_ops include/net/netdev_lock.h:42 [inline]
> >        xsk_bind+0x37c/0x1570 net/xdp/xsk.c:1189
> >        __sys_bind_socket net/socket.c:1810 [inline]
> >        __sys_bind_socket net/socket.c:1802 [inline]
> >        __sys_bind+0x1a7/0x260 net/socket.c:1841
> >        __do_sys_bind net/socket.c:1846 [inline]
> >        __se_sys_bind net/socket.c:1844 [inline]
> >        __x64_sys_bind+0x72/0xb0 net/socket.c:1844
> >        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >        do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
> >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > -> #0 (&xs->mutex){+.+.}-{4:4}:
> >        check_prev_add kernel/locking/lockdep.c:3168 [inline]
> >        check_prevs_add kernel/locking/lockdep.c:3287 [inline]
> >        validate_chain kernel/locking/lockdep.c:3911 [inline]
> >        __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5240
> >        lock_acquire kernel/locking/lockdep.c:5871 [inline]
> >        lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
> >        __mutex_lock_common kernel/locking/mutex.c:602 [inline]
> >        __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:747
> >        xsk_notifier+0x101/0x280 net/xdp/xsk.c:1649
> >        notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
> >        call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2230
> >        call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
> >        call_netdevice_notifiers net/core/dev.c:2282 [inline]
> >        unregister_netdevice_many_notify+0xf9d/0x2700 net/core/dev.c:12077
> >        rtnl_delete_link net/core/rtnetlink.c:3511 [inline]
> >        rtnl_dellink+0x3cb/0xa80 net/core/rtnetlink.c:3553
> >        rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6944
> >        netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2534
> >        netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
> >        netlink_unicast+0x53d/0x7f0 net/netlink/af_netlink.c:1339
> >        netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
> >        sock_sendmsg_nosec net/socket.c:712 [inline]
> >        __sock_sendmsg net/socket.c:727 [inline]
> >        ____sys_sendmsg+0xa98/0xc70 net/socket.c:2566
> >        ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
> >        __sys_sendmsg+0x16d/0x220 net/socket.c:2652
> >        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >        do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
> >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > other info that might help us debug this:
> >
> > Chain exists of:
> >   &xs->mutex --> &dev_instance_lock_key#20 --> &net->xdp.lock
> >
> >  Possible unsafe locking scenario:
> >
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(&net->xdp.lock);
> >                                lock(&dev_instance_lock_key#20);
> >                                lock(&net->xdp.lock);
> >   lock(&xs->mutex);
> 
> I feel the above race map is not that right?
> 
> My understanding is as shown below.
> CPU 0                                                    CPU 1
> ---                                                           ---
> unregister_netdevice_many_notify()
>                                                           xsk_bind()
> netdev_lock_ops(dev);
> 
> mutex_lock(&xs->mutex);
>                                                           netdev_lock_ops(dev);
> xsk_notifier()
> mutex_lock(&net->xdp.lock);
> mutex_lock(&xs->mutex);
> 
> So ABBA lock case happens, IIUC.

Since we can't (easily) control the ordering in notifiers, looks like
we need to align xsk_bind ordering (to be instance lock -> xs->mutex).
LMK if you want to take a stab at this; otherwise I'll try to send a
fix.

