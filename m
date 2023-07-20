Return-Path: <bpf+bounces-5479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5919975B24B
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 17:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140E7281F2C
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 15:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5193F18B1D;
	Thu, 20 Jul 2023 15:18:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271B518C00
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 15:18:18 +0000 (UTC)
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FD8272D
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 08:18:16 -0700 (PDT)
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-56601c9a4feso1428515eaf.1
        for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 08:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689866295; x=1690471095;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rf376TlIa//4Lkn5N+iGROnwRF6E/So2idCDCzplRGs=;
        b=BrWi3zcstMeQj7yRSPkwNDppXnQPQCw2zLJHKvTd6zQQSHO9H3aWILI11qGOwNZ49V
         xsHENcciNO9E7AJZ5upAUI7VU8JbPtORlM3j9hLI2WljiMJmkcjSdzEl/ekR8SRrWn8H
         ah/Th14JrlO3brgoA8WpYQjmCUP2LoQONeF6gfai5CKlMStpiFdwbjg4rO6fsqRjMbCb
         u/pKnxyKyerdBg5Sx9Q8bkVly2XVpFBqtxToC0I6nCaPxo3dE8VodbaukpSOR0ji9DyW
         ydij8FRLiprUCM5nEQLXk2rtLwVT7DE6uotoofJSlt6J+4hzAWn7KoBZOvAhusYnY9Vb
         HFvA==
X-Gm-Message-State: ABy/qLZezF/QAsym6UYF/IdEGjD/aMIGcFzQ30DxXhvXrn071q1Wx24m
	EBfchxK/SLNKzJE0CW6L+wxMt6pTuzHfWxzNQt8qHrXl9tbRQ7G2lQ==
X-Google-Smtp-Source: APBJJlF890SiMThQTbzlJQCFf+nI0YGszN2DWBJaxkZIfChDx0PehXUYCyyGH5KWUkl/KxXevMFwLYtuCRy2/GSXaP5d7g9RqH3L
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:a707:0:b0:563:356f:5f91 with SMTP id
 g7-20020a4aa707000000b00563356f5f91mr4192926oom.0.1689866295541; Thu, 20 Jul
 2023 08:18:15 -0700 (PDT)
Date: Thu, 20 Jul 2023 08:18:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004386940600eca80d@google.com>
Subject: [syzbot] [net?] WARNING: ODEBUG bug in ingress_destroy
From: syzbot <syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    03b123debcbc tcp: tcp_enter_quickack_mode() should be static
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=168e1baaa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=32e3dcc11fd0d297
dashboard link: https://syzkaller.appspot.com/bug?extid=bdcf141f362ef83335cf
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bf2bf4a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12741e9aa80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/348462fb61fa/disk-03b123de.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/33375730f77f/vmlinux-03b123de.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b6882fbac041/bzImage-03b123de.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: activate active (active state 1) object: ffff88807f28f000 object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 5029 at lib/debugobjects.c:514 debug_print_object+0x19e/0x2a0 lib/debugobjects.c:514
Modules linked in:
CPU: 0 PID: 5029 Comm: syz-executor389 Not tainted 6.5.0-rc1-syzkaller-00458-g03b123debcbc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
RIP: 0010:debug_print_object+0x19e/0x2a0 lib/debugobjects.c:514
Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 49 48 8b 14 dd c0 20 c8 8a 41 56 4c 89 e6 48 c7 c7 20 14 c8 8a e8 b2 fa 28 fd <0f> 0b 58 83 05 5c 8b 87 0a 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e
RSP: 0018:ffffc90003a5f168 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: ffff8880269b1dc0 RSI: ffffffff814d4986 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8ac81a80
R13: ffffffff8a6df720 R14: 0000000000000000 R15: ffff888017f63360
FS:  0000555555f7f380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000007b9d8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 debug_object_activate+0x32b/0x490 lib/debugobjects.c:733
 debug_rcu_head_queue kernel/rcu/rcu.h:226 [inline]
 kvfree_call_rcu+0x30/0xbe0 kernel/rcu/tree.c:3359
 tcx_entry_free include/net/tcx.h:96 [inline]
 ingress_destroy+0x39f/0x520 net/sched/sch_ingress.c:127
 __qdisc_destroy+0xc4/0x450 net/sched/sch_generic.c:1063
 qdisc_destroy+0x4f/0x60 net/sched/sch_generic.c:1078
 qdisc_graft+0x6f9/0x1680 net/sched/sch_api.c:1132
 tc_modify_qdisc+0xcd2/0x1bf0 net/sched/sch_api.c:1731
 rtnetlink_rcv_msg+0x439/0xd30 net/core/rtnetlink.c:6423
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2546
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x93c/0xe30 net/netlink/af_netlink.c:1911
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:748
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2494
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2548
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2577
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1232c17839
Code: 48 83 c4 28 c3 e8 27 18 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc05125308 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 000000000000003f RCX: 00007f1232c17839
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00007f1232c8e0d0 R08: 00007ffc05125380 R09: 00007ffc05125380
R10: 00007ffc05125380 R11: 0000000000000246 R12: 00007f1232c8a5f0
R13: 00007ffc05125508 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

