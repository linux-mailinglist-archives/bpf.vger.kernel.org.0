Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6159925A61F
	for <lists+bpf@lfdr.de>; Wed,  2 Sep 2020 09:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgIBHHz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Sep 2020 03:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBHHy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Sep 2020 03:07:54 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F24C061244;
        Wed,  2 Sep 2020 00:07:54 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f18so2327750pfa.10;
        Wed, 02 Sep 2020 00:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eKRJosbo+g0I7bg9/O9Hx0UMRK5lfTb++YcTo9JR86A=;
        b=oQvoiIoaNZtVdcV3BUNju/hHwr8IkpTukwJHrEQrbFvG1ZZCbepiDvsOO1d5sp9Sz9
         3ykvIAnjopyPlGnufaTi1sqxBMTWwvko4YOgHvWMBhDQTWD7GHOJYcpfqQCMhC+nsIgV
         f2y/JG4mc946t0hBaiqt29AjVb/F9bHxpqgyrLRX+qK1pQHeVkVHrUjbMR+Kvt71M2Ts
         51barXwGbP6c7E1/2v89Iucj3+ot+KeIgJBWsJDpmWOUDNvhW1XrgSY8OG7NC9hlTgW0
         y8JhCs//ORgjrWLDw/UDCgllg3t+S30kCvOPjGrIyvgpjuKqb+/vNFFkAuKScwSpSIy3
         qhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eKRJosbo+g0I7bg9/O9Hx0UMRK5lfTb++YcTo9JR86A=;
        b=RaJUA9XVjY4xBSP1PCPcAemnXfQ3iOKVTU2Xh4fmRcwp08uTPTB/DnLL3pxDIYpVbO
         ec9ZOoEDxk04vOZglFMcIxfY+vQHGbHZhA45xdcc0caIL+j5IiTY1Ln7AVbEYaFQBcjk
         ZEMRexOXjFcuoi8oZ/o865fI8w6l49Fc1bYDoPdtRW418UKRkDnz2AS94EVPhDAR0ye2
         C5lnYescMIWw7sdLyctWeMiTFVP9jlA6WBaNOS2vKW6dMtLaQRX/o87NgNd6NntRXOgM
         AMcjzO5V6y+PnzuENuTJWq4353en7rj8maQCO4tjytgA54qyRUo5qQ97L3Do92caTuN6
         eFpA==
X-Gm-Message-State: AOAM532vOnk3YvXlv1EpA83Ra1NY7BLbnNd4p8qLLNoCT2gyo0BhUWcX
        P/kSwhH//XrGg6pSKFt1oRh62zyv8pD81+ksra0=
X-Google-Smtp-Source: ABdhPJy2kvUDCWgLIqvGJ3sJmktN0ty3zmr6o+oVzLHFrn570b7aIv7a07S3SdnFmBreFphnkiuXBRcR3Wk5S2kK314=
X-Received: by 2002:a63:29c7:: with SMTP id p190mr913126pgp.292.1599030473531;
 Wed, 02 Sep 2020 00:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bcdbb005ae4f25ce@google.com> <7795503d-e112-cc26-81d8-c7a9692675b0@iogearbox.net>
In-Reply-To: <7795503d-e112-cc26-81d8-c7a9692675b0@iogearbox.net>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Wed, 2 Sep 2020 09:07:42 +0200
Message-ID: <CAJ8uoz29gZzGGiWZesFTu32RnsmpknxRBOnDq5v3N3wztScu2w@mail.gmail.com>
Subject: Re: KASAN: use-after-free Write in xp_put_pool
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     syzbot <syzbot+5334f62e4d22804e646a@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>, hawk@kernel.org,
        John Fastabend <john.fastabend@gmail.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, kpsingh@chromium.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>, mingo@kernel.org,
        Network Development <netdev@vger.kernel.org>,
        paulmck@kernel.org, peterz@infradead.org,
        Song Liu <songliubraving@fb.com>,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 2, 2020 at 9:06 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 9/2/20 8:57 AM, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
>
> Magnus/Bjorn, ptal, thanks!

On it as we speak.

> > HEAD commit:    dc1a9bf2 octeontx2-pf: Add UDP segmentation offload support
> > git tree:       net-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16ff67de900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=b6856d16f78d8fa9
> > dashboard link: https://syzkaller.appspot.com/bug?extid=5334f62e4d22804e646a
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e9f279900000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125f3e1e900000
> >
> > The issue was bisected to:
> >
> > commit a1132430c2c55af62d13e9fca752d46f14d548b3
> > Author: Magnus Karlsson <magnus.karlsson@intel.com>
> > Date:   Fri Aug 28 08:26:26 2020 +0000
> >
> >      xsk: Add shared umem support between devices
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10a373de900000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=12a373de900000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14a373de900000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+5334f62e4d22804e646a@syzkaller.appspotmail.com
> > Fixes: a1132430c2c5 ("xsk: Add shared umem support between devices")
> >
> > ==================================================================
> > BUG: KASAN: use-after-free in instrument_atomic_write include/linux/instrumented.h:71 [inline]
> > BUG: KASAN: use-after-free in atomic_fetch_sub_release include/asm-generic/atomic-instrumented.h:220 [inline]
> > BUG: KASAN: use-after-free in refcount_sub_and_test include/linux/refcount.h:266 [inline]
> > BUG: KASAN: use-after-free in refcount_dec_and_test include/linux/refcount.h:294 [inline]
> > BUG: KASAN: use-after-free in xp_put_pool+0x2c/0x1e0 net/xdp/xsk_buff_pool.c:262
> > Write of size 4 at addr ffff8880a6a4d860 by task ksoftirqd/0/9
> >
> > CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 5.9.0-rc1-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0x18f/0x20d lib/dump_stack.c:118
> >   print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
> >   __kasan_report mm/kasan/report.c:513 [inline]
> >   kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
> >   check_memory_region_inline mm/kasan/generic.c:186 [inline]
> >   check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
> >   instrument_atomic_write include/linux/instrumented.h:71 [inline]
> >   atomic_fetch_sub_release include/asm-generic/atomic-instrumented.h:220 [inline]
> >   refcount_sub_and_test include/linux/refcount.h:266 [inline]
> >   refcount_dec_and_test include/linux/refcount.h:294 [inline]
> >   xp_put_pool+0x2c/0x1e0 net/xdp/xsk_buff_pool.c:262
> >   xsk_destruct+0x7d/0xa0 net/xdp/xsk.c:1138
> >   __sk_destruct+0x4b/0x860 net/core/sock.c:1764
> >   rcu_do_batch kernel/rcu/tree.c:2428 [inline]
> >   rcu_core+0x5c7/0x1190 kernel/rcu/tree.c:2656
> >   __do_softirq+0x2de/0xa24 kernel/softirq.c:298
> >   run_ksoftirqd kernel/softirq.c:652 [inline]
> >   run_ksoftirqd+0x89/0x100 kernel/softirq.c:644
> >   smpboot_thread_fn+0x655/0x9e0 kernel/smpboot.c:165
> >   kthread+0x3b5/0x4a0 kernel/kthread.c:292
> >   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> >
> > Allocated by task 6854:
> >   kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
> >   kasan_set_track mm/kasan/common.c:56 [inline]
> >   __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
> >   kmalloc_node include/linux/slab.h:577 [inline]
> >   kvmalloc_node+0x61/0xf0 mm/util.c:574
> >   kvmalloc include/linux/mm.h:750 [inline]
> >   kvzalloc include/linux/mm.h:758 [inline]
> >   xp_create_and_assign_umem+0x58/0x8d0 net/xdp/xsk_buff_pool.c:54
> >   xsk_bind+0x9a0/0xed0 net/xdp/xsk.c:709
> >   __sys_bind+0x1e9/0x250 net/socket.c:1656
> >   __do_sys_bind net/socket.c:1667 [inline]
> >   __se_sys_bind net/socket.c:1665 [inline]
> >   __x64_sys_bind+0x6f/0xb0 net/socket.c:1665
> >   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> >   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > Freed by task 6854:
> >   kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
> >   kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
> >   kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
> >   __kasan_slab_free+0xd8/0x120 mm/kasan/common.c:422
> >   __cache_free mm/slab.c:3418 [inline]
> >   kfree+0x103/0x2c0 mm/slab.c:3756
> >   kvfree+0x42/0x50 mm/util.c:603
> >   xp_destroy net/xdp/xsk_buff_pool.c:44 [inline]
> >   xp_destroy+0x45/0x60 net/xdp/xsk_buff_pool.c:38
> >   xsk_bind+0xbdd/0xed0 net/xdp/xsk.c:719
> >   __sys_bind+0x1e9/0x250 net/socket.c:1656
> >   __do_sys_bind net/socket.c:1667 [inline]
> >   __se_sys_bind net/socket.c:1665 [inline]
> >   __x64_sys_bind+0x6f/0xb0 net/socket.c:1665
> >   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> >   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > The buggy address belongs to the object at ffff8880a6a4d800
> >   which belongs to the cache kmalloc-1k of size 1024
> > The buggy address is located 96 bytes inside of
> >   1024-byte region [ffff8880a6a4d800, ffff8880a6a4dc00)
> > The buggy address belongs to the page:
> > page:00000000dd5fc18f refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xa6a4d
> > flags: 0xfffe0000000200(slab)
> > raw: 00fffe0000000200 ffffea00029cce48 ffffea00025f2148 ffff8880aa040700
> > raw: 0000000000000000 ffff8880a6a4d000 0000000100000002 0000000000000000
> > page dumped because: kasan: bad access detected
> >
> > Memory state around the buggy address:
> >   ffff8880a6a4d700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >   ffff8880a6a4d780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >> ffff8880a6a4d800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                                                         ^
> >   ffff8880a6a4d880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >   ffff8880a6a4d900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > ==================================================================
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> > syzbot can test patches for this issue, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
> >
>
