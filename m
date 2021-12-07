Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9842446C1E9
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 18:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240067AbhLGRkA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Dec 2021 12:40:00 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:39629 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240062AbhLGRkA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Dec 2021 12:40:00 -0500
Received: by mail-il1-f200.google.com with SMTP id d3-20020a056e021c4300b002a23bcd5ee7so12519854ilg.6
        for <bpf@vger.kernel.org>; Tue, 07 Dec 2021 09:36:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=1dQvezvp3iGWZ0YIb75qsQGcY3DEG/a8kpN3taG3XIQ=;
        b=zjRwBkACal/XlUhRC8PM1mBqbTB8biI1yK3CmlNeiUmnZCpVZMEcsvJW7lnw6BP8/v
         HIMs+rrUHZMAfj4K8ea4ZiHRDzREtR8zWQhGCYDuLrLWnP0QSlm3861vD6fRvrnNu4ce
         ncr+xRHW8mY1VGxLoIe4/XGvQE1w+vLomPIKMogLD90eZARiTh0P73F11qQhz2AghhpU
         2prZGr/pysB1I+unUcUCWKQ+h/aIWbihgsUCF1GuvHsvcAl4m3dlPm3eH5KlWaCONdlQ
         6FW7jMc/9gEnTw1y6nN2mJJtq7mnNAae5CMQK4N66u+Ji1mnqdSlsYvvk4XjHlqZp/f6
         0DNA==
X-Gm-Message-State: AOAM530LQWP/9139uJCTZil7LML4eb2MtVUCY+TRbZ9yZW3Lm4jyi3fK
        UlQdGZpFuav9dF4SRwp5PAS5/+JyzTx8VZYpGdnP84qRZnHC
X-Google-Smtp-Source: ABdhPJxrY5ezv1MAc4b3hmpC2DiyVCa1ZBCuumVI4l2wVqyLJVseDqkqWYesgOImWu3+rPfrjLJrTeEt9WFpybMUWdvQ/3svPH4Z
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16ca:: with SMTP id 10mr721658ilx.274.1638898589332;
 Tue, 07 Dec 2021 09:36:29 -0800 (PST)
Date:   Tue, 07 Dec 2021 09:36:29 -0800
In-Reply-To: <000000000000367c2205d2549cb9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d78f805d291d061@google.com>
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Read in __bpf_prog_put
From:   syzbot <syzbot+5027de09e0964fd78ce1@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    1c5526968e27 net/smc: Clear memory when release and reuse ..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13a9eabdb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b8e24e3a80e3875
dashboard link: https://syzkaller.appspot.com/bug?extid=5027de09e0964fd78ce1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b749a9b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170d7519b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5027de09e0964fd78ce1@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in __bpf_prog_put.constprop.0+0x1dd/0x220 kernel/bpf/syscall.c:1812
Read of size 8 at addr ffffc90001a16038 by task kworker/0:3/2934

CPU: 0 PID: 2934 Comm: kworker/0:3 Not tainted 5.16.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events sk_psock_destroy
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xf/0x320 mm/kasan/report.c:247
 __kasan_report mm/kasan/report.c:433 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:450
 __bpf_prog_put.constprop.0+0x1dd/0x220 kernel/bpf/syscall.c:1812
 psock_set_prog include/linux/skmsg.h:477 [inline]
 psock_progs_drop include/linux/skmsg.h:495 [inline]
 sk_psock_destroy+0xad/0x620 net/core/skmsg.c:804
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>


Memory state around the buggy address:
 ffffc90001a15f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90001a15f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc90001a16000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                                        ^
 ffffc90001a16080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90001a16100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================

