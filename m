Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA351278B2C
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 16:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgIYOrT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Sep 2020 10:47:19 -0400
Received: from mail-io1-f77.google.com ([209.85.166.77]:43092 "EHLO
        mail-io1-f77.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbgIYOrT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Sep 2020 10:47:19 -0400
Received: by mail-io1-f77.google.com with SMTP id b73so2024801iof.10
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2020 07:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=M6+/ZKVR/90rLrLFBtjo/Mm7W41v17JMkdnZdvY3o98=;
        b=TaMwcawKZ2Yh7iw+jJTBKNpJ7L3NOfVG5ZQRF+vKOgK3RKthgeeiY+NuRFZszwdcZ/
         P5Agt0lwJ48B3/wFycMt0ndExMyL6zUUTrO2k+Btd3pc15bTjuL0Db+gDXa7D8gWztO0
         +O9bIEBP9CMwnZmTpaLc6USpPR6GGfweETlOd43OGR6aW2KH+11NYo6CYmj6x+e9QvAC
         RicwvSKZ/KAwx0RpLKS0z6f/egPhK9LgIz7UiZsicsJz+cjbJep35SL11s9K6CQ2qRY9
         ft+602/bETvnSapNxMG2gVHPKIHfzbSHzhTU4RKjIzVkZzUFaCYurjnad/ChUP3iOB+K
         1wCA==
X-Gm-Message-State: AOAM532sHX8DJswnoChzXf3w/guV3barMP44FN03ZkOufcT6UB2G9BY4
        QGU5y+KVKIU1XBD8OQfBhsU0X3hNixkya21GCVIByY0IUrxN
X-Google-Smtp-Source: ABdhPJzbIQCjGeAdlz7BLhEUwnTKQfQvsClQ0ijGBrZ0OlsNyAai2+6C2kZvqVq3N+G3Wm9C3B3Kcw/GfWNkIFnQxvghVolzcCSz
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:8f:: with SMTP id l15mr453713ilm.119.1601045237602;
 Fri, 25 Sep 2020 07:47:17 -0700 (PDT)
Date:   Fri, 25 Sep 2020 07:47:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a821aa05b0246452@google.com>
Subject: general protection fault in xsk_release
From:   syzbot <syzbot+ddc7b4944bc61da19b81@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bjorn.topel@intel.com,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        hawk@kernel.org, john.fastabend@gmail.com,
        jonathan.lemon@gmail.com, kafai@fb.com, kpsingh@chromium.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        magnus.karlsson@intel.com, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3fc826f1 Merge branch 'net-dsa-bcm_sf2-Additional-DT-chang..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=158f8009900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=51fb40e67d1e3dec
dashboard link: https://syzkaller.appspot.com/bug?extid=ddc7b4944bc61da19b81
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16372c81900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100bd2c3900000

The issue was bisected to:

commit 1c1efc2af158869795d3334a12fed2afd9c51539
Author: Magnus Karlsson <magnus.karlsson@intel.com>
Date:   Fri Aug 28 08:26:17 2020 +0000

    xsk: Create and free buffer pool independently from umem

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=157a3103900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=177a3103900000
console output: https://syzkaller.appspot.com/x/log.txt?x=137a3103900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ddc7b4944bc61da19b81@syzkaller.appspotmail.com
Fixes: 1c1efc2af158 ("xsk: Create and free buffer pool independently from umem")

RAX: ffffffffffffffda RBX: 00007fff675613c0 RCX: 0000000000443959
RDX: 0000000000000030 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000001bbbbbb
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000007 R14: 0000000000000000 R15: 0000000000000000
general protection fault, probably for non-canonical address 0xdffffc00000000ad: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000568-0x000000000000056f]
CPU: 0 PID: 6888 Comm: syz-executor811 Not tainted 5.9.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:dev_put include/linux/netdevice.h:3899 [inline]
RIP: 0010:xsk_unbind_dev net/xdp/xsk.c:521 [inline]
RIP: 0010:xsk_release+0x63f/0x7d0 net/xdp/xsk.c:591
Code: 00 00 48 c7 85 c8 04 00 00 00 00 00 00 e8 29 a0 47 fe 48 8d bb 68 05 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 66 01 00 00 48 8b 83 68 05 00 00 65 ff 08 e9 54
RSP: 0018:ffffc90005707c90 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff815b9de2
RDX: 00000000000000ad RSI: ffffffff882d2317 RDI: 0000000000000568
RBP: ffff888091aae000 R08: 0000000000000001 R09: ffffffff8d0ffaaf
R10: fffffbfff1a1ff55 R11: 0000000000000000 R12: ffff888091aae5f8
R13: ffff888091aae4c8 R14: dffffc0000000000 R15: 1ffff11012355cb5
FS:  0000000000000000(0000) GS:ffff8880ae400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004c8b88 CR3: 0000000093ea3000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __sock_release+0xcd/0x280 net/socket.c:596
 sock_close+0x18/0x20 net/socket.c:1277
 __fput+0x285/0x920 fs/file_table.c:281
 task_work_run+0xdd/0x190 kernel/task_work.c:141
 exit_task_work include/linux/task_work.h:25 [inline]
 do_exit+0xb7d/0x29f0 kernel/exit.c:806
 do_group_exit+0x125/0x310 kernel/exit.c:903
 __do_sys_exit_group kernel/exit.c:914 [inline]
 __se_sys_exit_group kernel/exit.c:912 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:912
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x442588
Code: Bad RIP value.
RSP: 002b:00007fff67561328 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000000000442588
RDX: 0000000000000001 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00000000004c8b50 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006dd280 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 9742ad575ae08359 ]---
RIP: 0010:dev_put include/linux/netdevice.h:3899 [inline]
RIP: 0010:xsk_unbind_dev net/xdp/xsk.c:521 [inline]
RIP: 0010:xsk_release+0x63f/0x7d0 net/xdp/xsk.c:591
Code: 00 00 48 c7 85 c8 04 00 00 00 00 00 00 e8 29 a0 47 fe 48 8d bb 68 05 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 66 01 00 00 48 8b 83 68 05 00 00 65 ff 08 e9 54
RSP: 0018:ffffc90005707c90 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff815b9de2
RDX: 00000000000000ad RSI: ffffffff882d2317 RDI: 0000000000000568
RBP: ffff888091aae000 R08: 0000000000000001 R09: ffffffff8d0ffaaf
R10: fffffbfff1a1ff55 R11: 0000000000000000 R12: ffff888091aae5f8
R13: ffff888091aae4c8 R14: dffffc0000000000 R15: 1ffff11012355cb5
FS:  0000000000000000(0000) GS:ffff8880ae400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004c8b88 CR3: 0000000093ea3000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
