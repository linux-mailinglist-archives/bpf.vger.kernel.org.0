Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0EB316CCA
	for <lists+bpf@lfdr.de>; Tue,  7 May 2019 23:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfEGVGH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 May 2019 17:06:07 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:53568 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbfEGVGH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 May 2019 17:06:07 -0400
Received: by mail-it1-f198.google.com with SMTP id q1so257192itc.3
        for <bpf@vger.kernel.org>; Tue, 07 May 2019 14:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=i0ea6qcnQd61vbI8zTdhw0aEpWQ9Mlm3sK4Plx8ZZ34=;
        b=hKu35H9FrH9huoOuPsKmGzSRKmgUSPlTQN86G9XfZnPeGMlqjx/EGIf1ao0AoFMbWx
         lSaA8yy9j2+9wuMdJbTjzdQC0aWWx2XLjU7UyaUzqtXE9xbb773N+7EjUcZT60FQ6e52
         WmUvcVhZNbRx98pYurmyqB+XPA18dQg/3OE7jQMsXuuMJ9df1tsy8wgMlQdBhdNOjPG/
         Wkggowie/GxLQEbXjgc9lArrI9tliZ+xuh2y6K0HWAoXa5HsYS0GlTf7jt0xzBsMbCx0
         wx7fE+VniuGCh/sR1YZnHM7MoiHYln2iL+XnYyZLFw6IYXhGg6R4O02hykP7iO24xYTB
         OI1w==
X-Gm-Message-State: APjAAAW4vhM8jdTn0bNua1bR9IYcrqkGGPDQLYiL4QIL3n9WJMZcvgsL
        uJZINSBc+VlpB7h1PzZoSynN3xS6BHkUqxfIq5U0xrTvXTFp
X-Google-Smtp-Source: APXvYqwviF0xJxHe46j5bqms5DHO0TndCvSi+GNUBcjDPBsGCSLKdU29VhEZ0WAQRpIfAcyXdPYocu9RIPfTPT+fF7bNU6r4CWkr
MIME-Version: 1.0
X-Received: by 2002:a6b:fe0d:: with SMTP id x13mr3993691ioh.1.1557263166391;
 Tue, 07 May 2019 14:06:06 -0700 (PDT)
Date:   Tue, 07 May 2019 14:06:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dace5e0588529558@google.com>
Subject: WARNING: ODEBUG bug in del_timer (3)
From:   syzbot <syzbot+13d91ed9bbcd7dc13230@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davejwatson@fb.com, davem@davemloft.net, doronrk@fb.com,
        jakub.kicinski@netronome.com, kafai@fb.com, kjlu@umn.edu,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        vakul.garg@nxp.com, yhs@fb.com, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    71ae5fc8 Merge tag 'linux-kselftest-5.2-rc1' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136c06f0a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=511168bc7720867
dashboard link: https://syzkaller.appspot.com/bug?extid=13d91ed9bbcd7dc13230
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17128012a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+13d91ed9bbcd7dc13230@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: assert_init not available (active state 0) object type: timer_list  
hint:           (null)
WARNING: CPU: 1 PID: 22 at lib/debugobjects.c:325  
debug_print_object+0x16a/0x250 lib/debugobjects.c:325
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 22 Comm: kworker/1:1 Not tainted 5.1.0+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events sk_psock_destroy_deferred
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  __warn.cold+0x20/0x45 kernel/panic.c:566
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:972
RIP: 0010:debug_print_object+0x16a/0x250 lib/debugobjects.c:325
Code: dd 60 f4 a1 87 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b5 00 00 00 48  
8b 14 dd 60 f4 a1 87 48 c7 c7 00 ea a1 87 e8 44 02 12 fe <0f> 0b 83 05 31  
10 2d 06 01 48 83 c4 20 5b 41 5c 41 5d 41 5e 5d c3
RSP: 0018:ffff8880a9a3f970 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815aec76 RDI: ffffed1015347f20
RBP: ffff8880a9a3f9b0 R08: ffff8880a9a2a5c0 R09: ffffed1015d240f1
R10: ffffed1015d240f0 R11: ffff8880ae920787 R12: 0000000000000001
R13: ffffffff889ac720 R14: ffffffff81605b60 R15: ffff8880990fdba8
  debug_object_assert_init lib/debugobjects.c:694 [inline]
  debug_object_assert_init+0x23d/0x2f0 lib/debugobjects.c:665
  debug_timer_assert_init kernel/time/timer.c:725 [inline]
  debug_assert_init kernel/time/timer.c:770 [inline]
  del_timer+0x7c/0x120 kernel/time/timer.c:1192
  try_to_grab_pending+0x2d7/0x710 kernel/workqueue.c:1249
  __cancel_work_timer+0xc4/0x520 kernel/workqueue.c:3079
  cancel_delayed_work_sync+0x1b/0x20 kernel/workqueue.c:3252
  strp_done+0x5d/0xf0 net/strparser/strparser.c:526
  sk_psock_destroy_deferred+0x3a/0x6c0 net/core/skmsg.c:558
  process_one_work+0x98e/0x1790 kernel/workqueue.c:2263
  worker_thread+0x98/0xe40 kernel/workqueue.c:2409
  kthread+0x357/0x430 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
