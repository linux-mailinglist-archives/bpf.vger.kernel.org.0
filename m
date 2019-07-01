Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8285844A92
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2019 20:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfFMS0G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Jun 2019 14:26:06 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:42559 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbfFMS0C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Jun 2019 14:26:02 -0400
Received: by mail-io1-f70.google.com with SMTP id f22so16014371ioj.9
        for <bpf@vger.kernel.org>; Thu, 13 Jun 2019 11:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=H8fkKRsajFNvveyMibT6Ym6gwJL9IWybrrDbLE6hjXM=;
        b=cpE+Qo8fb+Ko6Bo8ouly9KUyJ2NFUEAGRtHQd0Jk2yJwKCDNjTCwGG/bDBp1/iKzdI
         O+4qDg3505xrILotV/iUd+PlYJ9RBLg+j324/fkhAeDsNA4CL/lnzhrTZP0rcN//MzAA
         qmUiTwNudkcBpGb7eqKAjGB1CuzcdSJiSlcYRp2QkMTB6jnB3WaTVaPFsV7+3vlGuOji
         HY1OSWmDT4kk3UXb2reieNNsmLumBVgAyeND/p2yskRlJVZe8ddyFyZtyHLX1tturIzY
         dGhuOUVvtjB0gg/23riyI2JaitPZA65PgBDIRXB/GrXXir/QyBO8pdOS+wFUjfzGAeB3
         GBOA==
X-Gm-Message-State: APjAAAXngjHWHpiQ39cySkf27gHNAgrRFQno2FhjwIkM7wpHjOG7oIFa
        ZODuJO6LbLrqrIVtldICsUk7MfS5m9vKx3VSJr5x5RUzC/AE
X-Google-Smtp-Source: APXvYqzBC1FZKm6BWRsem6orfogvQHSXv8MqMWzwoem5idhuC5D8v+7E99KxjGlqvsPxtqaqrIOr9RdqfLmefvin5NKd9sUHCap2
MIME-Version: 1.0
X-Received: by 2002:a02:b90e:: with SMTP id v14mr28704806jan.122.1560450360686;
 Thu, 13 Jun 2019 11:26:00 -0700 (PDT)
Date:   Thu, 13 Jun 2019 11:26:00 -0700
In-Reply-To: <CACT4Y+bAuAiApr9CxSH5CoDnZ5hYmU+K4kJqrSo5yBZLyrzONA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007042a8058b38a946@google.com>
Subject: Re: memory leak in vhost_net_ioctl
From:   syzbot <syzbot+0789f0c7e45efd7bb643@syzkaller.appspotmail.com>
To:     asias@redhat.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, dvyukov@google.com,
        hawk@kernel.org, hdanton@sina.com, jakub.kicinski@netronome.com,
        jasowang@redhat.com, john.fastabend@gmail.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org,
        xdp-newbies@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer still triggered  
crash:
memory leak in vhost_net_ioctl

ANGE): hsr_slave_1: link becomes ready
2019/06/13 18:24:57 executed programs: 18
BUG: memory leak
unreferenced object 0xffff88811cbc6ac0 (size 64):
   comm "syz-executor.0", pid 7196, jiffies 4294943804 (age 14.770s)
   hex dump (first 32 bytes):
     01 00 00 00 81 88 ff ff 00 00 00 00 82 88 ff ff  ................
     d0 6a bc 1c 81 88 ff ff d0 6a bc 1c 81 88 ff ff  .j.......j......
   backtrace:
     [<000000006c752978>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000006c752978>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000006c752978>] slab_alloc mm/slab.c:3326 [inline]
     [<000000006c752978>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000b3825d52>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000b3825d52>] vhost_net_ubuf_alloc drivers/vhost/net.c:241  
[inline]
     [<00000000b3825d52>] vhost_net_set_backend drivers/vhost/net.c:1535  
[inline]
     [<00000000b3825d52>] vhost_net_ioctl+0xb43/0xc10  
drivers/vhost/net.c:1717
     [<00000000700f02d7>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<00000000700f02d7>] file_ioctl fs/ioctl.c:509 [inline]
     [<00000000700f02d7>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<000000009a0ec0a7>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<00000000d9416323>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<00000000d9416323>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<00000000d9416323>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<00000000e4407a23>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000008715c149>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810b1365c0 (size 64):
   comm "syz-executor.2", pid 7193, jiffies 4294943823 (age 14.580s)
   hex dump (first 32 bytes):
     01 00 00 00 81 88 ff ff 00 00 00 00 81 88 ff ff  ................
     d0 65 13 0b 81 88 ff ff d0 65 13 0b 81 88 ff ff  .e.......e......
   backtrace:
     [<000000006c752978>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000006c752978>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000006c752978>] slab_alloc mm/slab.c:3326 [inline]
     [<000000006c752978>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000b3825d52>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000b3825d52>] vhost_net_ubuf_alloc drivers/vhost/net.c:241  
[inline]
     [<00000000b3825d52>] vhost_net_set_backend drivers/vhost/net.c:1535  
[inline]
     [<00000000b3825d52>] vhost_net_ioctl+0xb43/0xc10  
drivers/vhost/net.c:1717
     [<00000000700f02d7>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<00000000700f02d7>] file_ioctl fs/ioctl.c:509 [inline]
     [<00000000700f02d7>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<000000009a0ec0a7>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<00000000d9416323>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<00000000d9416323>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<00000000d9416323>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<00000000e4407a23>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000008715c149>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810be23700 (size 64):
   comm "syz-executor.3", pid 7194, jiffies 4294943823 (age 14.580s)
   hex dump (first 32 bytes):
     01 00 00 00 00 00 00 00 00 00 00 00 00 c9 ff ff  ................
     10 37 e2 0b 81 88 ff ff 10 37 e2 0b 81 88 ff ff  .7.......7......
   backtrace:
     [<000000006c752978>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000006c752978>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000006c752978>] slab_alloc mm/slab.c:3326 [inline]
     [<000000006c752978>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000b3825d52>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000b3825d52>] vhost_net_ubuf_alloc drivers/vhost/net.c:241  
[inline]
     [<00000000b3825d52>] vhost_net_set_backend drivers/vhost/net.c:1535  
[inline]
     [<00000000b3825d52>] vhost_net_ioctl+0xb43/0xc10  
drivers/vhost/net.c:1717
     [<00000000700f02d7>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<00000000700f02d7>] file_ioctl fs/ioctl.c:509 [inline]
     [<00000000700f02d7>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<000000009a0ec0a7>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<00000000d9416323>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<00000000d9416323>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<00000000d9416323>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<00000000e4407a23>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000008715c149>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810b136500 (size 64):
   comm "syz-executor.6", pid 7228, jiffies 4294943827 (age 14.540s)
   hex dump (first 32 bytes):
     01 00 00 00 20 69 6f 63 00 00 00 00 64 65 76 2f  .... ioc....dev/
     10 65 13 0b 81 88 ff ff 10 65 13 0b 81 88 ff ff  .e.......e......
   backtrace:
     [<000000006c752978>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000006c752978>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000006c752978>] slab_alloc mm/slab.c:3326 [inline]
     [<000000006c752978>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000b3825d52>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000b3825d52>] vhost_net_ubuf_alloc drivers/vhost/net.c:241  
[inline]
     [<00000000b3825d52>] vhost_net_set_backend drivers/vhost/net.c:1535  
[inline]
     [<00000000b3825d52>] vhost_net_ioctl+0xb43/0xc10  
drivers/vhost/net.c:1717
     [<00000000700f02d7>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<00000000700f02d7>] file_ioctl fs/ioctl.c:509 [inline]
     [<00000000700f02d7>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<000000009a0ec0a7>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<00000000d9416323>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<00000000d9416323>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<00000000d9416323>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<00000000e4407a23>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000008715c149>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810b9cfec0 (size 64):
   comm "syz-executor.7", pid 7236, jiffies 4294943829 (age 14.520s)
   hex dump (first 32 bytes):
     01 00 00 00 20 69 6f 63 00 00 00 00 64 65 76 2f  .... ioc....dev/
     d0 fe 9c 0b 81 88 ff ff d0 fe 9c 0b 81 88 ff ff  ................
   backtrace:
     [<000000006c752978>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000006c752978>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000006c752978>] slab_alloc mm/slab.c:3326 [inline]
     [<000000006c752978>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000b3825d52>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000b3825d52>] vhost_net_ubuf_alloc drivers/vhost/net.c:241  
[inline]
     [<00000000b3825d52>] vhost_net_set_backend drivers/vhost/net.c:1535  
[inline]
     [<00000000b3825d52>] vhost_net_ioctl+0xb43/0xc10  
drivers/vhost/net.c:1717
     [<00000000700f02d7>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<00000000700f02d7>] file_ioctl fs/ioctl.c:509 [inline]
     [<00000000700f02d7>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<000000009a0ec0a7>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<00000000d9416323>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<00000000d9416323>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<00000000d9416323>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<00000000e4407a23>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000008715c149>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810b9cd380 (size 64):
   comm "syz-executor.4", pid 7218, jiffies 4294943834 (age 14.470s)
   hex dump (first 32 bytes):
     01 00 00 00 81 88 ff ff 00 00 00 00 81 88 ff ff  ................
     90 d3 9c 0b 81 88 ff ff 90 d3 9c 0b 81 88 ff ff  ................
   backtrace:
     [<000000006c752978>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000006c752978>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000006c752978>] slab_alloc mm/slab.c:3326 [inline]
     [<000000006c752978>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000b3825d52>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000b3825d52>] vhost_net_ubuf_alloc drivers/vhost/net.c:241  
[inline]
     [<00000000b3825d52>] vhost_net_set_backend drivers/vhost/net.c:1535  
[inline]
     [<00000000b3825d52>] vhost_net_ioctl+0xb43/0xc10  
drivers/vhost/net.c:1717
     [<00000000700f02d7>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<00000000700f02d7>] file_ioctl fs/ioctl.c:509 [inline]
     [<00000000700f02d7>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<000000009a0ec0a7>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<00000000d9416323>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<00000000d9416323>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<00000000d9416323>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<00000000e4407a23>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000008715c149>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



Tested on:

commit:         c11fb13a Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11c6b666a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb38d33cd06d8d48
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11ff0de1a00000

