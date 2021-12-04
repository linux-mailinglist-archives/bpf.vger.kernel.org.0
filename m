Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD459468642
	for <lists+bpf@lfdr.de>; Sat,  4 Dec 2021 17:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355404AbhLDQiu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Dec 2021 11:38:50 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:50757 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355429AbhLDQit (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Dec 2021 11:38:49 -0500
Received: by mail-il1-f200.google.com with SMTP id i3-20020a056e021b0300b0029eceae8532so4023987ilv.17
        for <bpf@vger.kernel.org>; Sat, 04 Dec 2021 08:35:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=BA9OwP3e4KSpyoZW+XzJWCMfEa5xkpbba0Rxgywsghc=;
        b=kq3MCDAoD4NMFNnawOE+KJQY6G9Qyjk754v4Aay22aunWaJRQE6TuUPbxkduiN8PSw
         /iOl0XdpPhV3tVNZpCtPknx1UoU8mT2E69IDcwGRs5CwQ8NMpS6K+tVCf92pYALbl1U0
         uTt7dQm1y94oaaF8pcTW1KRO5oGnbbBKemSsuWeL+IVu8dBp35rMguNQ/Ava9c7VLZjN
         l5ZTN4V7N6PYgP4FotNfCXcEMHSq/wuqmk7nxRj60EvIuNjYRj/Vjk1KbWmQ4Tfnay/L
         XE4wKi6EgXyF/5GkHeZUwDsmzJozN1y+tH0bl6tsPDQTMo6XBLdhuSOFNHi0RUdzDua2
         Xt+g==
X-Gm-Message-State: AOAM532MtHFgM6ywezO1utL6Ty0KFWhdh16CSIeEAtfnGqa6ChEiRnGv
        JT4CNLg4XNXMQhpS+M0kBIly7sQJDQD4hOuNVxRllfB2QrUb
X-Google-Smtp-Source: ABdhPJxxznh9Q5hCHWgnwvJ6XXsUs0D50cBHWOW6zK9XJmrmos7R9Ap1SlHUG3GwLkFakTQVL9lP37VnIwwgNfklMYJK4c/OBW5L
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24ca:: with SMTP id y10mr30640190jat.109.1638635723454;
 Sat, 04 Dec 2021 08:35:23 -0800 (PST)
Date:   Sat, 04 Dec 2021 08:35:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000367c2205d2549cb9@google.com>
Subject: [syzbot] KASAN: vmalloc-out-of-bounds Read in __bpf_prog_put
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

Hello,

syzbot found the following issue on:

HEAD commit:    ce83278f313c Merge branch 'qed-enhancements'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11c8ce3ab00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5949d4891208a1b
dashboard link: https://syzkaller.appspot.com/bug?extid=5027de09e0964fd78ce1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5027de09e0964fd78ce1@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in __bpf_prog_put.constprop.0+0x1dd/0x220 kernel/bpf/syscall.c:1812
Read of size 8 at addr ffffc90000cf2038 by task kworker/0:24/16179

CPU: 0 PID: 16179 Comm: kworker/0:24 Not tainted 5.16.0-rc3-syzkaller #0
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
 ffffc90000cf1f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90000cf1f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc90000cf2000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                                        ^
 ffffc90000cf2080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90000cf2100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
