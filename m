Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB2A2F48AE
	for <lists+bpf@lfdr.de>; Wed, 13 Jan 2021 11:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbhAMK2J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jan 2021 05:28:09 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:36295 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbhAMK2J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jan 2021 05:28:09 -0500
Received: by mail-io1-f69.google.com with SMTP id x4so939921ioh.3
        for <bpf@vger.kernel.org>; Wed, 13 Jan 2021 02:27:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Jp5VjL+jpjBW595+oPVu2b30QzQh/C/HNqg9KiGkCc4=;
        b=f9McimabcHYzFCKgsd+CJXd+OcztYyW8aqKnPDhE1vpZjA1j1fjzen1rk0BoICdpNJ
         y0RP14U+cleFHcLuDy0iVkEvEBfvCnoh5r7+VaSEHPY6MGluAFrlNOudTocHhvCDAEmP
         V5cMGTEHP6uyZkrDcDyNDcAxLvqh+j37DsNZnGWTivEB0Mj5lb93HPBcbyF1K+Vc5vIX
         6+r/1Y8Chjdp7EM+lqQT8XFz2kwubXgRKqMC/q1g24SX5vMkmpxCYtv3Im56H/ayPtwe
         UwVO7de0tYsuRV1DsFmviqKqdkJE8OJS16s0eCTqYNWkcw3GtbqhK461JLxSiu1ntIvy
         JX4w==
X-Gm-Message-State: AOAM531CV9brquD692anAfukKOwiaOfc8EdaCkEyvZPaHvgucuWvdJxL
        acxPWEdIcN/Z4ZMdsLdj9QoQ3Abe/2cN2BMfz8YR11aELEJG
X-Google-Smtp-Source: ABdhPJy7G1VvD9b/lF62lCN9U89knU5g8Cw2lnZokW1Z44DCZM4u/XY579mw0ushu1ahm53ZcxbWDjG0Goj5mAtd9tE0KNfeeOWm
MIME-Version: 1.0
X-Received: by 2002:a02:d45:: with SMTP id 66mr1848412jax.120.1610533647748;
 Wed, 13 Jan 2021 02:27:27 -0800 (PST)
Date:   Wed, 13 Jan 2021 02:27:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9191905b8c59562@google.com>
Subject: kernel BUG at net/core/dev.c:NUM!
From:   syzbot <syzbot+2393580080a2da190f04@syzkaller.appspotmail.com>
To:     andrii@kernel.org, andriin@fb.com, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        edumazet@google.com, f.fainelli@gmail.com, hawk@kernel.org,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, roopa@cumulusnetworks.com,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c49243e8 Merge branch 'net-fix-issues-around-register_netd..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=11da7ba8d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bacfc914704718d3
dashboard link: https://syzkaller.appspot.com/bug?extid=2393580080a2da190f04
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13704c3f500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160cc357500000

The issue was bisected to:

commit c269a24ce057abfc31130960e96ab197ef6ab196
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Wed Jan 6 18:40:06 2021 +0000

    net: make free_netdev() more lenient with unregistering devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13901b50d00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10501b50d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17901b50d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2393580080a2da190f04@syzkaller.appspotmail.com
Fixes: c269a24ce057 ("net: make free_netdev() more lenient with unregistering devices")

------------[ cut here ]------------
kernel BUG at net/core/dev.c:10661!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8459 Comm: syz-executor375 Not tainted 5.11.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:free_netdev+0x4b3/0x5e0 net/core/dev.c:10661
Code: c0 01 38 d0 7c 08 84 d2 0f 85 1a 01 00 00 0f b7 83 32 02 00 00 48 29 c3 48 89 df e8 d7 77 ac fa e9 47 ff ff ff e8 3d 1e 80 fa <0f> 0b e8 36 1e 80 fa 0f b6 2d 39 e1 e8 05 31 ff 89 ee e8 a6 24 80
RSP: 0018:ffffc9000163f1a0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88802814a000 RCX: 0000000000000000
RDX: ffff888021678000 RSI: ffffffff86f25763 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff86f25683 R11: 0000000000000003 R12: ffff888028149ef8
R13: ffff88802814a058 R14: dffffc0000000000 R15: ffff888028149ef8
FS:  00000000010bf880(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ade220a6d8 CR3: 0000000012719000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __rtnl_newlink+0x1484/0x16e0 net/core/rtnetlink.c:3447
 rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3491
 rtnetlink_rcv_msg+0x44e/0xad0 net/core/rtnetlink.c:5553
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2494
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2345
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2399
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2432
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4404b9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff3e934f98 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004404b9
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000014 R09: 00000000004002c8
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000401cc0
R13: 0000000000401d50 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace ec4d68ff94a95202 ]---
RIP: 0010:free_netdev+0x4b3/0x5e0 net/core/dev.c:10661
Code: c0 01 38 d0 7c 08 84 d2 0f 85 1a 01 00 00 0f b7 83 32 02 00 00 48 29 c3 48 89 df e8 d7 77 ac fa e9 47 ff ff ff e8 3d 1e 80 fa <0f> 0b e8 36 1e 80 fa 0f b6 2d 39 e1 e8 05 31 ff 89 ee e8 a6 24 80
RSP: 0018:ffffc9000163f1a0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88802814a000 RCX: 0000000000000000
RDX: ffff888021678000 RSI: ffffffff86f25763 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff86f25683 R11: 0000000000000003 R12: ffff888028149ef8
R13: ffff88802814a058 R14: dffffc0000000000 R15: ffff888028149ef8
FS:  00000000010bf880(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd33803e118 CR3: 0000000012719000 CR4: 00000000001506f0
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
