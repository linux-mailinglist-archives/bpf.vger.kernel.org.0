Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E111142BF12
	for <lists+bpf@lfdr.de>; Wed, 13 Oct 2021 13:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhJMLmZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Oct 2021 07:42:25 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:49928 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhJMLmY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Oct 2021 07:42:24 -0400
Received: by mail-io1-f72.google.com with SMTP id l17-20020a05660227d100b005d6609eb90eso1649622ios.16
        for <bpf@vger.kernel.org>; Wed, 13 Oct 2021 04:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=SB9IPDSfjtSY2Vj2VJmHJrw1P1v8HF1L8QnrpBqns8M=;
        b=N4eexoSGMeYNBL0geaV9jiG6sgBc/UhV+mKeDp0ATU9w/yAausHOFFILzOUXZ6jLXR
         dNEg8UCbWE9pVxnvF6wTQQw0T9HlufBL9z2pjlycpgh4u2XMzfDpdetab7k60MLyk/SH
         MENHMaOYtL5Z3TwSg6C3v0/xfgg12Tbn4AnLvt97R1tLThhX39zyMdUP1/9yj671d/T7
         oMpyfpYHfKvJEmn6s6Zt671leoNhhX7fFA1BTWgkw6puJXwP1GBGX4nNsLRTn/35LOX5
         8WRgy6OaZckLHvWCJm8d6iIgSYVQyi6ROWKERDFxGt93EFoURzqauRFtGfuMZ+Ty+oke
         rJZg==
X-Gm-Message-State: AOAM533M2e82Niv5PWAehwkVJvt6xtAcxzpQn4JgECRHZoScOK8XIpH3
        Ax5OaW8H6n6jCH5jLKaWoUcswclyOCX6CjZ1VD3OATi3voRD
X-Google-Smtp-Source: ABdhPJyUNhYOY8K5eaDeWjzC+bAVRTWqNr5hy0FJlN8eDbHMaqFymA5rolaTf90yt/ItBRwBEFjsP12ertCY2mRp6lDCElwstZ2F
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:6c2:: with SMTP id p2mr17916421ils.104.1634125221343;
 Wed, 13 Oct 2021 04:40:21 -0700 (PDT)
Date:   Wed, 13 Oct 2021 04:40:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005639cd05ce3a6d4d@google.com>
Subject: [syzbot] BUG: corrupted list in netif_napi_add
From:   syzbot <syzbot+62e474dd92a35e3060d8@syzkaller.appspotmail.com>
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

HEAD commit:    683f29b781ae Add linux-next specific files for 20211008
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1525a614b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=673b3589d970c
dashboard link: https://syzkaller.appspot.com/bug?extid=62e474dd92a35e3060d8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c98e98b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+62e474dd92a35e3060d8@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
list_add double add: new=ffff888023417160, prev=ffff88807de3a050, next=ffff888023417160.
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:29!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9490 Comm: syz-executor.1 Not tainted 5.15.0-rc4-next-20211008-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__list_add_valid.cold+0x26/0x3c lib/list_debug.c:29
Code: b1 24 c3 fa 4c 89 e1 48 c7 c7 60 56 04 8a e8 f2 8c f1 ff 0f 0b 48 89 f2 4c 89 e1 48 89 ee 48 c7 c7 a0 57 04 8a e8 db 8c f1 ff <0f> 0b 48 89 f1 48 c7 c7 20 57 04 8a 4c 89 e6 e8 c7 8c f1 ff 0f 0b
RSP: 0018:ffffc90002c26a48 EFLAGS: 00010286
RAX: 0000000000000058 RBX: 0000000000000040 RCX: 0000000000000000
RDX: ffff888023263a00 RSI: ffffffff815e0d78 RDI: fffff52000584d3b
RBP: ffff888023417160 R08: 0000000000000058 R09: 0000000000000000
R10: ffffffff815dab5e R11: 0000000000000000 R12: ffff888023417160
R13: ffff888023417000 R14: ffff888023417160 R15: ffff888023417160
FS:  00007f841e9e8700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000601bd000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_add_rcu include/linux/rculist.h:79 [inline]
 list_add_rcu include/linux/rculist.h:106 [inline]
 netif_napi_add+0x3fd/0x9c0 net/core/dev.c:6889
 veth_enable_xdp_range+0x1b1/0x300 drivers/net/veth.c:1009
 veth_enable_xdp+0x2a5/0x620 drivers/net/veth.c:1063
 veth_xdp_set drivers/net/veth.c:1483 [inline]
 veth_xdp+0x4d4/0x780 drivers/net/veth.c:1523
 bond_xdp_set drivers/net/bonding/bond_main.c:5217 [inline]
 bond_xdp+0x325/0x920 drivers/net/bonding/bond_main.c:5263
 dev_xdp_install+0xd5/0x270 net/core/dev.c:9365
 dev_xdp_attach+0x83d/0x1010 net/core/dev.c:9513
 dev_change_xdp_fd+0x246/0x300 net/core/dev.c:9753
 do_setlink+0x2fb4/0x3970 net/core/rtnetlink.c:2931
 rtnl_group_changelink net/core/rtnetlink.c:3242 [inline]
 __rtnl_newlink+0xc06/0x1750 net/core/rtnetlink.c:3396
 rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3506
 rtnetlink_rcv_msg+0x413/0xb80 net/core/rtnetlink.c:5572
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2491
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x86d/0xda0 net/netlink/af_netlink.c:1916
 sock_sendmsg_nosec net/socket.c:704 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:724
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2409
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2463
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2492
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f841f2718d9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f841e9e8188 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f841f375f60 RCX: 00007f841f2718d9
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000003
RBP: 00007f841f2cbcb4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc8978d37f R14: 00007f841e9e8300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 7281cadbc8534f23 ]---
RIP: 0010:__list_add_valid.cold+0x26/0x3c lib/list_debug.c:29
Code: b1 24 c3 fa 4c 89 e1 48 c7 c7 60 56 04 8a e8 f2 8c f1 ff 0f 0b 48 89 f2 4c 89 e1 48 89 ee 48 c7 c7 a0 57 04 8a e8 db 8c f1 ff <0f> 0b 48 89 f1 48 c7 c7 20 57 04 8a 4c 89 e6 e8 c7 8c f1 ff 0f 0b
RSP: 0018:ffffc90002c26a48 EFLAGS: 00010286
RAX: 0000000000000058 RBX: 0000000000000040 RCX: 0000000000000000
RDX: ffff888023263a00 RSI: ffffffff815e0d78 RDI: fffff52000584d3b
RBP: ffff888023417160 R08: 0000000000000058 R09: 0000000000000000
R10: ffffffff815dab5e R11: 0000000000000000 R12: ffff888023417160
R13: ffff888023417000 R14: ffff888023417160 R15: ffff888023417160
FS:  00007f841e9e8700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000601bd000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
