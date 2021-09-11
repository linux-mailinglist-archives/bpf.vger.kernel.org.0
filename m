Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946A3407A7C
	for <lists+bpf@lfdr.de>; Sat, 11 Sep 2021 23:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhIKVUa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Sep 2021 17:20:30 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:35569 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbhIKVU3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Sep 2021 17:20:29 -0400
Received: by mail-io1-f72.google.com with SMTP id g14-20020a6be60e000000b005b62a0c2a41so11481452ioh.2
        for <bpf@vger.kernel.org>; Sat, 11 Sep 2021 14:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Jmi3yBWyM3sCdQcNUG7hYrR527zmNHaostTgpyWLE4g=;
        b=cVnXTpyEppIjBvYDQdJLU2HkOBVCipR4SlF7mbqa5RUcgMAPc+9tnwQs9c/FUfLoSS
         Kq8cUiXGYpDXvRwQCqRrPQfwaRHzBVc2Dvbm9vyhUDcj5GHZ7bZqkenSywGRHUp/UxZK
         I0ndkSERz9J3gKuNFY7Uf52PPRkfRrD986w5hYT59+/BXrXINbZ8mjqRxs2pIjeCnHws
         gh+IwVCJotGg0CNEQXZ9/fcA2HTWq41Eo0/p3jHUWNxs2fd2pxvqsCmBVuWRWDw99LEr
         AvUKmb5lLtvZA31/irhjBkK+GRatdIqMsYM/SSiTGh3RJDLMXcn2Ji9BVmlsvwaLMe+1
         cgJQ==
X-Gm-Message-State: AOAM531rVa7IVCQq5SHvn9obOobqnWgd7W0m7CjcReZohzC0H80avL1E
        mZSD2mJsEe+Z26KaWkiNUXBv3B26/WQsy5Jsg90Rhw6cycut
X-Google-Smtp-Source: ABdhPJw/wl4HsYKJ/UzPjAAqOxVZVC5DXtimWwIUaaY3Vyc+6GHMU1aF05QQWQLEMf8bn3QU3fpznvpVfWUS70bysyXwRprS2A6h
MIME-Version: 1.0
X-Received: by 2002:a6b:7b4b:: with SMTP id m11mr3067729iop.165.1631395156119;
 Sat, 11 Sep 2021 14:19:16 -0700 (PDT)
Date:   Sat, 11 Sep 2021 14:19:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c4d45205cbbec87f@google.com>
Subject: [syzbot] riscv/fixes test error: BUG: unable to handle kernel paging
 request in corrupted
From:   syzbot <syzbot+fd2f89c6e52024e6118d@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7d2a07b76933 Linux 5.14
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=1153e67d300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8211b06020972e8
dashboard link: https://syzkaller.appspot.com/bug?extid=fd2f89c6e52024e6118d
compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
userspace arch: riscv64

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fd2f89c6e52024e6118d@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address 1ffffffff07aa547
Oops [#1]
Modules linked in:
CPU: 0 PID: 3309 Comm: kworker/0:5 Not tainted 5.14.0-syzkaller #0
Hardware name: riscv-virtio,qemu (DT)
Workqueue: events nsim_dev_trap_report_work
epc : slab_alloc_node mm/slub.c:2884 [inline]
epc : __kmalloc_node_track_caller+0xb0/0x3d2 mm/slub.c:4653
 ra : slab_pre_alloc_hook mm/slab.h:494 [inline]
 ra : slab_alloc_node mm/slub.c:2880 [inline]
 ra : __kmalloc_node_track_caller+0x70/0x3d2 mm/slub.c:4653
epc : ffffffff803e2a20 ra : ffffffff803e29e0 sp : ffffffe0095c3b20
 gp : ffffffff83f967d8 tp : ffffffe00ba397c0 t0 : ffffffe008b544a8
 t1 : 0000000000000001 t2 : ffffffffeddd472a s0 : ffffffe0095c3bc0
 s1 : ffffffe005602140 a0 : 0000000000000000 a1 : 0000000000000007
 a2 : 1ffffffff07aa51f a3 : ffffffff80a9711a a4 : 0000000004000000
 a5 : 0000000000000000 a6 : 0000000000f00000 a7 : 78e919c5cf7e2f00
 s2 : ffffffff83f96adc s3 : 0000000000082a20 s4 : 0000000000001000
 s5 : ffffffffffffffff s6 : ffffffff81538164 s7 : ffffffff83f9a0d0
 s8 : 0000000000000000 s9 : 0000000000082a20 s10: 0000000000000000
 s11: ffffffe008b545c8 t3 : 78e919c5cf7e2f00 t4 : ffffffc40116a8bb
 t5 : ffffffc40116a8bc t6 : ffffffe00eede026
status: 0000000000000120 badaddr: 1ffffffff07aa547 cause: 000000000000000f
[<ffffffff803e2a20>] slab_alloc_node mm/slub.c:2884 [inline]
[<ffffffff803e2a20>] __kmalloc_node_track_caller+0xb0/0x3d2 mm/slub.c:4653
[<ffffffff821a8952>] kmalloc_reserve net/core/skbuff.c:355 [inline]
[<ffffffff821a8952>] __alloc_skb+0xee/0x2e2 net/core/skbuff.c:426
[<ffffffff81538164>] alloc_skb include/linux/skbuff.h:1112 [inline]
[<ffffffff81538164>] nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:664 [inline]
[<ffffffff81538164>] nsim_dev_trap_report drivers/net/netdevsim/dev.c:721 [inline]
[<ffffffff81538164>] nsim_dev_trap_report_work+0x1cc/0x5e6 drivers/net/netdevsim/dev.c:762
[<ffffffff80063b62>] process_one_work+0x5e0/0xf82 kernel/workqueue.c:2276
[<ffffffff8006485a>] worker_thread+0x356/0x8e6 kernel/workqueue.c:2422
[<ffffffff80076554>] kthread+0x25c/0x2c6 kernel/kthread.c:319
[<ffffffff8000515e>] ret_from_exception+0x0/0x14
---[ end trace fa569262b4bfae4f ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
