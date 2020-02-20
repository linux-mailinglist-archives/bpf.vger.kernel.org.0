Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB9B21657A6
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2020 07:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgBTGbP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Feb 2020 01:31:15 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:56549 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgBTGbP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Feb 2020 01:31:15 -0500
Received: by mail-io1-f69.google.com with SMTP id d13so1905326ioo.23
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2020 22:31:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=DDqMJ8JPj7oJO/ZR8xGUg6VFAFuonxwUf5QT8gnpMlI=;
        b=G4QXcfE1XumJmzm5oXWavLfOePbtPDaf0EcLtJUbT0tw4B0H3lGDwjguhP3Tv/Qstq
         5hSdqUd1k+EYWuF1TFOgbI2UixODdq4sEoHjeeLYzEVeM2DWaRTk4ORQiWuhBZc70Zz+
         kiLti+gsSrEBrVu6zRK7Q2vUKl0tx57bgdTtz/qSwC/AxASqjLOFQU33G23kmH+arQlC
         tDCsNdxTrAcKDxvGUt493OyAnYiC7rDn3jbAT8D4iy8g8iIaI6+u7wkfOtMG+TGiwrUy
         KLFLcUnDvZ0+VSqUr/M1E7zCXcjdTgqgxS0ji6SIYMejIR/+NCgLY+/tGfKnaqCU1wYA
         yhXg==
X-Gm-Message-State: APjAAAXQ/pdeG+vNZWl6XwC+7VJWQM3wf4jSabTZ9Vcx2AAbaqNnSV2a
        naHbQjdLFnMCvcLymofg8ggNd9u3XwtWM+k3kaHTwtjbN8ye
X-Google-Smtp-Source: APXvYqxOsNiTKh+qdqttr1Rz5Xoag30BA+Qf5UFs3ZfyNMV1nBh7iGpymuj0iWTB8mx5mFnbL62z472NbkKQFR/ecoPKcwCxKaZz
MIME-Version: 1.0
X-Received: by 2002:a92:cb8c:: with SMTP id z12mr26095480ilo.5.1582180274590;
 Wed, 19 Feb 2020 22:31:14 -0800 (PST)
Date:   Wed, 19 Feb 2020 22:31:14 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003cdd26059efc0db3@google.com>
Subject: KASAN: null-ptr-deref Write in kcm_tx_work
From:   syzbot <syzbot+867331f5ea7690d840b4@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
        jslaby@suse.cz, kafai@fb.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, willy@infradead.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2019fc96 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=159f2701e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=735296e4dd620b10
dashboard link: https://syzkaller.appspot.com/bug?extid=867331f5ea7690d840b4
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+867331f5ea7690d840b4@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in clear_bit include/asm-generic/bitops/instrumented-atomic.h:41 [inline]
BUG: KASAN: null-ptr-deref in kcm_tx_work+0x10e/0x170 net/kcm/kcmsock.c:743
Write of size 8 at addr 0000000000000008 by task kworker/u4:4/280

CPU: 0 PID: 280 Comm: kworker/u4:4 Not tainted 5.6.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: kkcmd kcm_tx_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 __kasan_report.cold+0x5/0x32 mm/kasan/report.c:510
 kasan_report+0x12/0x20 mm/kasan/common.c:641
 check_memory_region_inline mm/kasan/generic.c:185 [inline]
 check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
 __kasan_check_write+0x14/0x20 mm/kasan/common.c:101
 clear_bit include/asm-generic/bitops/instrumented-atomic.h:41 [inline]
 kcm_tx_work+0x10e/0x170 net/kcm/kcmsock.c:743
 process_one_work+0xa05/0x17a0 kernel/workqueue.c:2264
 worker_thread+0x98/0xe40 kernel/workqueue.c:2410
 kthread+0x361/0x430 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
==================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 280 Comm: kworker/u4:4 Tainted: G    B             5.6.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: kkcmd kcm_tx_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:221
 end_report+0x47/0x4f mm/kasan/report.c:96
 __kasan_report.cold+0xe/0x32 mm/kasan/report.c:513
 kasan_report+0x12/0x20 mm/kasan/common.c:641
 check_memory_region_inline mm/kasan/generic.c:185 [inline]
 check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
 __kasan_check_write+0x14/0x20 mm/kasan/common.c:101
 clear_bit include/asm-generic/bitops/instrumented-atomic.h:41 [inline]
 kcm_tx_work+0x10e/0x170 net/kcm/kcmsock.c:743
 process_one_work+0xa05/0x17a0 kernel/workqueue.c:2264
 worker_thread+0x98/0xe40 kernel/workqueue.c:2410
 kthread+0x361/0x430 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
