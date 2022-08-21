Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4896A59B31A
	for <lists+bpf@lfdr.de>; Sun, 21 Aug 2022 12:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiHUKRd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 21 Aug 2022 06:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiHUKRc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Aug 2022 06:17:32 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EC61274C
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 03:17:30 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id x7-20020a056e021ca700b002ded2e6331aso6507734ill.20
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 03:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc;
        bh=LE1LCU4tNiknKVyA+WMm6zjkYRDeBGfWddeOl3Lef4w=;
        b=1MmQG71IUB4qTKimJlJOtTs9mQbflBonhuL12KZFQyx3//tF/z84jCr8zfb0xib22G
         Yw70699GCvDQrcyE9JDsjIMips02KH4SBh6oxPM7XaJuvA5dmg+4cyRq/ZKKZeMQPbgj
         VLZydpTnLD84V5DDVEW2+pSjuSQ4F+3vI/K0GL3+i2yvgDWC1pm+V0bJsxQOPSdVM7T+
         aN1McatCEm0hN7SX6Xq4sCepUUAEWNrxskFz3dtHFelCYK3cBYKJx5JWPPgXz2gDE06N
         RgN/nmTuLwairVrYUYC1CndWgU5DgvzRPEy/48zqzrtI9YckVA2cLof0/PyNE6xv9KFn
         LFVg==
X-Gm-Message-State: ACgBeo0KcB1x9/tesllKVggYUJAjDFAcAXdiez6Bm1XzmH1MlVbgsYuN
        z3fQ/+PErcn3XCpfFskE0sh0YLq6w1yj+WBtTmCwi9PGkelx
X-Google-Smtp-Source: AA6agR6cTFTJE4DTxNRzC1mvv5FLi6A5SVpBpl+52m93EucjUlON1aYB3xVYz2TAlHJtIIi6zDetKSO2AIi9YnIZGGKmPPp6hWrQ
MIME-Version: 1.0
X-Received: by 2002:a5d:879a:0:b0:689:da06:93c6 with SMTP id
 f26-20020a5d879a000000b00689da0693c6mr1036946ion.202.1661077050248; Sun, 21
 Aug 2022 03:17:30 -0700 (PDT)
Date:   Sun, 21 Aug 2022 03:17:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086582105e6bda31b@google.com>
Subject: [syzbot] possible deadlock in strp_work
From:   syzbot <syzbot+9fc084a4348493ef65d2@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        edumazet@google.com, jakub@cloudflare.com,
        john.fastabend@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8755ae45a9e8 Add linux-next specific files for 20220819
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10d3e2d3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ead6107a3bbe3c62
dashboard link: https://syzkaller.appspot.com/bug?extid=9fc084a4348493ef65d2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1136b1a5080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10bb167b080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9fc084a4348493ef65d2@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.0.0-rc1-next-20220819-syzkaller #0 Not tainted
------------------------------------------------------
kworker/u4:2/38 is trying to acquire lock:
ffff888026598d30 (sk_lock-AF_INET){+.+.}-{0:0}, at: do_strp_work net/strparser/strparser.c:398 [inline]
ffff888026598d30 (sk_lock-AF_INET){+.+.}-{0:0}, at: strp_work+0x40/0x130 net/strparser/strparser.c:415

but task is already holding lock:
ffffc90000af7da8 ((work_completion)(&strp->work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 ((work_completion)(&strp->work)){+.+.}-{0:0}:
       __flush_work+0x105/0xae0 kernel/workqueue.c:3069
       __cancel_work_timer+0x3f9/0x570 kernel/workqueue.c:3160
       strp_done+0x64/0xf0 net/strparser/strparser.c:513
       kcm_attach net/kcm/kcmsock.c:1429 [inline]
       kcm_attach_ioctl net/kcm/kcmsock.c:1490 [inline]
       kcm_ioctl+0x913/0x1180 net/kcm/kcmsock.c:1696
       sock_do_ioctl+0xcc/0x230 net/socket.c:1169
       sock_ioctl+0x2f1/0x640 net/socket.c:1286
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (sk_lock-AF_INET){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
       lock_acquire kernel/locking/lockdep.c:5666 [inline]
       lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
       lock_sock_nested+0x36/0xf0 net/core/sock.c:3391
       do_strp_work net/strparser/strparser.c:398 [inline]
       strp_work+0x40/0x130 net/strparser/strparser.c:415
       process_one_work+0x991/0x1610 kernel/workqueue.c:2289
       worker_thread+0x665/0x1080 kernel/workqueue.c:2436
       kthread+0x2e4/0x3a0 kernel/kthread.c:376
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock((work_completion)(&strp->work));
                               lock(sk_lock-AF_INET);
                               lock((work_completion)(&strp->work));
  lock(sk_lock-AF_INET);

 *** DEADLOCK ***

2 locks held by kworker/u4:2/38:
 #0: ffff88802642d138 ((wq_completion)kstrp){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88802642d138 ((wq_completion)kstrp){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88802642d138 ((wq_completion)kstrp){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88802642d138 ((wq_completion)kstrp){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88802642d138 ((wq_completion)kstrp){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88802642d138 ((wq_completion)kstrp){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90000af7da8 ((work_completion)(&strp->work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264

stack backtrace:
CPU: 1 PID: 38 Comm: kworker/u4:2 Not tainted 6.0.0-rc1-next-20220819-syzkaller #0
kworker/u4:2[38] cmdline: ��a�����
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Workqueue: kstrp strp_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:122 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:140
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain kernel/locking/lockdep.c:3829 [inline]
 __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
 lock_acquire kernel/locking/lockdep.c:5666 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
 lock_sock_nested+0x36/0xf0 net/core/sock.c:3391
 do_strp_work net/strparser/strparser.c:398 [inline]
 strp_work+0x40/0x130 net/strparser/strparser.c:415
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
